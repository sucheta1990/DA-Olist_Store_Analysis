use p_133_s;
select * from customers;
select * from orders;
select * from items;
select * from products where product_category_name="pet_shop";
select * from review where review_score="5";
create or replace view kpi_1 as select  if(dayname( date( order_purchase_timestamp)) ="Saturday","Weekend",if(dayname(date(order_purchase_timestamp))="Sunday","Weekend","Weekday")) as weekend_weekday,round(sum(payment_value),2)  as sum_payments from orders o join payments   p on p.order_id=o.order_id group by weekend_weekday; 
select * from kpi_1;

create  or replace view kpi_2 as select count(r.order_id) as num_of_orders,review_score,payment_type from review r join payments p on p.order_id=r.order_id where payment_type="credit_card" and review_score="5" group by review_score;
select * from kpi_2;

create or replace view kpi3 as select product_category_name,avg(datediff(date(order_delivered_customer_date),date(order_purchase_timestamp))) as avg_no_days from orders o join items i on i.order_id=o.order_id join products py on py.product_id=i.product_id where product_category_name="pet_shop";
select * from kpi3;


create or replace view kpi_4 as select avg(price) as avg_price_value,avg(payment_value) as avg_payment_values, customer_city from items i join payments p on p.order_id=i.order_id join orders o on o.order_id=p.order_id join customers c on c.customer_id=o.customer_id where customer_city="sao paulo";
select * from kpi_4;

create or replace view kpi_5 as select review_score, avg(datediff(date(order_delivered_customer_date),date(order_purchase_timestamp))) as shipping_days from review r join orders o on o.order_id=r.order_id group by review_score;
select * from kpi_5;