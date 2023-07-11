/*Evaluación 2*/
USE northwind;
/*Selecciona todos los campos de los productos, que pertenezcan a los proveedores
con códigos: 1, 3, 7, 8 y 9, que tengan stock en el almacén, y al mismo 
tiempo que sus precios unitarios estén entre 50 y 100. 
Por último, ordena los resultados por código de proveedor de forma ascendente.*/

SELECT products.supplier_id, products.product_name
FROM products
INNER JOIN order_details
ON products.product_id = order_details.product_id
WHERE products.units_in_stock IS NOT NULL and 50 < order_details.unit_price < 100 AND products.supplier_id IN (1,3,7,8,9)
ORDER BY products.supplier_id;

/* Devuelve el nombre y apellidos y el id de los empleados con códigos entre el 3 y el 6,
 además que hayan vendido a clientes que tengan códigos que comiencen con las letras de
 la A hasta la G. Por último, en esta búsqueda queremos filtrar solo por aquellos 
 envíos que la fecha de pedido este comprendida entre el 22 y el 31 de Diciembre 
 de cualquier año.*/
 

SELECT order_id, shipped_date,employees.employee_id, employees.first_name, employees.last_name, month(shipped_date), day(shipped_date), customers.company_name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN employees
ON orders.employee_id = employees.employee_id
WHERE month(shipped_date) = 12 AND day(shipped_date) BETWEEN 22 AND 31 AND customers.customer_id REGEXP '^[A-G]' AND employees.employee_id BETWEEN 3 AND 6;

 /*Calcula el precio de venta de cada pedido una vez aplicado el descuento.
 Muestra el id del la orden, el id del producto, el nombre del producto, 
 el precio unitario, la cantidad, el descuento y el precio de venta después 
 de haber aplicado el descuento.*/
 
SELECT order_details.order_id, order_details.product_id, products.product_name, order_details.unit_price, order_details.discount, (order_details.quantity * order_details.unit_price) * (1 - discount) AS Totalprice
FROM order_details
INNER JOIN products
ON order_details.product_id = products.product_id;

/*Usando una subconsulta, muestra los productos cuyos precios
 estén por encima del precio medio total de los productos de la BBDD.*/
SELECT product_name, unit_price 
FROM products
WHERE unit_price > (SELECT AVG(unit_price)
						FROM products);
/*¿Qué productos ha vendido cada empleado y 
cuál es la cantidad vendida de cada uno de ellos?*/
SELECT orders.employee_id, order_details.product_id, sum(order_details.quantity)
FROM orders
RIGHT JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.employee_id;

