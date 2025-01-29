select * from customers c;
select * from employees e;
select * from offices off;
select * from orderdetails od;
select * from orders o;
select * from payments pm;
select * from productlines pl;
select * from products p;




--Top 10 customers with the highest credit limit
select customerNumber,customerName,creditLimit 
from customers c
ORDER BY creditLimit DESC
LIMIT 10;

--Top 10 customers with the lowest credit limit
select customerNumber,customerName,creditLimit 
from customers c
ORDER BY creditLimit ASC
LIMIT 10;





--- low in stock

WITH products_orders as(
select * from products p
join orderdetails od
on p.productCode = od.productCode
)
SELECT productName,
	productCode,
	quantityINStock,
	sum(quantityOrdered) AS quantity_ordered,
	round(sum(quantityOrdered)*1.0/
	quantityINStock) AS low_stock
FROM products_orders pd
GROUP BY productCode
ORDER BY low_stock DESC
LIMIT 10;


--high in stock
WITH products_orders as(
select * from products p
join orderdetails od
on p.productCode = od.productCode
)
SELECT productName,
	productCode,
	quantityINStock,
	sum(quantityOrdered) AS quantity_ordered,
	round(sum(quantityOrdered)*1.0/
	quantityINStock) AS low_stock
FROM products_orders pd
GROUP BY productCode
ORDER BY quantityInStock DESC
LIMIT 10;






---top 5 customers by revenue
with top_customers as(
select o.customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS revenue
  FROM products p
  JOIN orderdetails od
    ON p.productCode = od.productCode
  JOIN orders o
    ON o.orderNumber = od.orderNumber
 GROUP BY o.customerNumber
 order by revenue desc
 )
 SELECT contactLastName, contactFirstName, city, country, tc.revenue
  FROM customers c
  join top_customers tc
  on tc.customerNumber = c.customerNumber
 ORDER BY tc.revenue DESC
limit 10;


---bottom 5 customers by revenue
with top_customers as(
select o.customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS revenue
  FROM products p
  JOIN orderdetails od
    ON p.productCode = od.productCode
  JOIN orders o
    ON o.orderNumber = od.orderNumber
 GROUP BY o.customerNumber
 order by revenue desc
 )
 SELECT contactLastName, contactFirstName, city, country, tc.revenue
  FROM customers c
  join top_customers tc
  on tc.customerNumber = c.customerNumber
 ORDER BY tc.revenue asc
limit 10;






---top sales

WITH sales as(
SELECT	od.productCode,
        od.quantityOrdered,
        od.priceEach,
        p.productName
FROM orderdetails od
JOIN products p
ON p.productCode = od.productCode
)
SELECT productCode,productName,
sum(priceEach*quantityOrdered) AS amount_sold
FROM sales s
GROUP BY productCode
ORDER BY amount_sold DESC
LIMIT 10;


--lowest sales
WITH sales as(
SELECT	od.productCode, 
        od.quantityOrdered,
        od.priceEach,
        p.productname
FROM orderdetails od
JOIN products p
ON p.productCode = od.productCode
)
SELECT productCode,productName,
sum(priceEach*quantityOrdered) AS amount_sold
FROM sales s
GROUP BY productCode
ORDER BY amount_sold ASC
LIMIT 10;


select * from products p;
select * from orderdetails od;

