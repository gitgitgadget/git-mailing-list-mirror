Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB436AB6B
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527402; cv=none; b=tRqVsRwx5DScUqh/MObNC1nSWImyveleTa1jjj+ACRskzQ0SWWVe9GXhhxdtMKF3BHr0suKbFbLgDy5ALm5FL4j/lXzWydHeHmdUGoQEEROZ0Vxvd81YE/pxyJEJdCo/cqlNSHi43zUTYLda5LnTDlrvkzg9fgVJ/BMoa/UdcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527402; c=relaxed/simple;
	bh=bIimCLxndjthvgVLPzz+y3UOB+QSPyVUophBesimAGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUeqESqiMT4a/oBNfOYatB8+ui6aXbuxcZVIif99CJZKFtDPJLgqV67Y5ScNj17+VRLprDKxLvNqd7j1whY3S4i6xwnUubBbbo1usOnrLds7qoKurS35rMydHtFK2uhgbj/5tB4p0o1a0uzuO8nHE1EOP+TGyNYgspI0Uv0pQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ2uEoFE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ2uEoFE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f71156e1aso783224f8f.3
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527399; x=1786132199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFYRj8p2Om4GIBef9BLEA7iYh35KvdqkugP1mhl0itI=;
        b=DJ2uEoFEhuL+P205kYEVz8W9dnfGtg5/gpQ8tcEmDRwqAzgDYq9fD1a1pSKnptoFk6
         4QUHmruebdBVgtqTvWL174zSoAF4bVDB2VOmY0u4g/9Vbw8JSoB82JmtNQnwoCbA77sH
         iLyUCqxNEgmVLELfgTiPHx9zZx2GrwIFRLNL6hi1PExIOdmSmU0MFJTWaqiAibC+Zqe8
         p57bjSjoF2bBEQ9BNVcdSgAiZjoemqzgUI6Caozwd5KPEIisydvmN6Vg/CWvff6sY5qt
         gv+BhufiN8aC09yvojLRp7+278XGOOdMZkf4gkzThXqtf7Krr+N+Ip/qvpGma5wbw9/D
         s+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527399; x=1786132199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFYRj8p2Om4GIBef9BLEA7iYh35KvdqkugP1mhl0itI=;
        b=SJ/oqBj8UNq9ow9v+a9XMxUz/wUB1QioKOCDVi0UxkBNklePZDSZdrSQOEJ6d/puax
         t0rhqsgN5fZCISQPF2pS8zfKYSvzoONCHDGKbzrLJcJctCZ7dlUZ6R5uYkIvUbyisrIW
         hEjoHlCoBgj0ko+mRvM4iRu4ZLX8QbhONwCSQFsdwZIjBJPCb9UtUi/05PVNaANAm7KO
         KrSz8EfCBAU/1z0zZklBvpDIP4fv2c7cof6MygPerp0R9c9q4sgZX30JHq6p08Zkzhev
         Oep0PsKIvW9zooZz5DQms7Lz83gJ1Iq5sAQE41EeDcxwe70P9YTCpMW8HvEjcmaUeeDq
         EbNQ==
X-Gm-Message-State: AOJu0YzoUPPKPkUAQSSl/4c8MJ3GyH1NjFqqIcghcmOe/Qefo0G7QZhU
	mlptYoWnJMmZzVu35iePBhxo9wILEXDgVDilDxAS1GChRaHr1vrVDWkm
X-Gm-Gg: AR+sD12izca0DzaEN30+hJH64itBrPlbBZJnixTT7UAzmKf9/NmKb2zPJNWhi3Z9SvL
	YocDT/Hzv/u/C7ljIA6BFGnjeCgjlmi24brmfZeGhznRz744JqN876xnVutqgzbfn8rPrSY2XkM
	hZ8okhDmxzCD4N4p1ACEFe1/i2yHlscu5+ojbZjGG+5Q2BXj1SSQ/MSNEde85BXugKPsdkfrgCt
	0QVne1P9adA2z4n/uRYzf1HNcZ0KKAXvnnXhOhNE9f5nF/Hj+xjSrFrEz4Ql90TSW1D9WVHARzs
	Mg+pcQUCPgp6HvPZtlEE5TVTvvH9EawUXTRBG+5/xttUnqmZ+Tw/B2X6FLHXBgViaMgWBLVuuyI
	RIW3qOzsLhodF997Q8G3vZNUcQ9JUKdEPwzFaHqwBTfs4Cm/zSRnDM1wCJHKuyzj8pUBDjX7RHu
	hY1bgEngvL0LeTeQp754qFdxGLM+wQyae/8raTMvDjncDFa/xXe4m8ZH5gSlKyfTc7mKarDbqNM
	I9hyiLvGDvMKUJBiMo/vZhgNAZcv/+pj1J6Ha5CVZzYO4p+vJZG4w9sPLwMo9ngoE1DJ2GfrOMr
	BXt+9S3WZOj2/ncMIWzCnkUr5wWBZNRbyqGw7CWiL0YQtrYfDPG7/hjIlFfYqUrHYmos5eCeR2H
	tMBjQ0W9k1/DYTtQrVhg7TKOEQ+cnBXbwEOdeAxIYYsh+XDxajBRyPFDtsokIrZQNe+X6uCRzfv
	gBQi6hxk0=
X-Received: by 2002:a5d:5f51:0:b0:47f:8817:eb7c with SMTP id ffacd0b85a97d-47fd7307512mr1860733f8f.42.1785527399271;
        Fri, 31 Jul 2026 12:49:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:49:58 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 31 Jul 2026 21:49:36 +0200
Subject: [PATCH GSoC v2 3/6] protocol-caps: add type support to object-info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-objecttype-support-v2-3-af577461ed57@gmail.com>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Teach the server-side object-info handler to accept type as a requested
field. When the client includes type in its object-info request, the
server returns the requested object type.

While touching send_info(), wrap an over-long line and fix the bit field
style of requested_info.size.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 protocol-caps.c      | 21 ++++++++++++++++++---
 t/t5701-git-serve.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 02261be14d..27e0f85b10 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -11,7 +11,8 @@
 #include "strbuf.h"
 
 struct requested_info {
-	unsigned size : 1;
+	unsigned size:1;
+	unsigned type:1;
 };
 
 /*
@@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	if (info->size)
 		packet_writer_write(writer, "size");
 
+	if (info->type)
+		packet_writer_write(writer, "type");
+
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
+		enum object_type object_type;
 		struct object_id oid;
 		size_t object_size;
 
 		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
 				writer,
-				"object-info: protocol error, expected to get oid, not '%s'",
+				"object-info: protocol error, expected to get "
+				"oid, not '%s'",
 				oid_str);
 			continue;
 		}
@@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		 * If an object is not recognized by the server append SP to
 		 * the response.
 		 */
-		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
+		object_type = get_object_info(r->objects, &oid, &object_size);
+		if (object_type <= OBJ_NONE) {
 			strbuf_addstr(&send_buffer, " ");
 			goto write;
 		}
@@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 				    (uintmax_t)object_size);
 		}
 
+		if (info->type)
+			strbuf_addf(&send_buffer, " %s", type_name(object_type));
+
 write:
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
@@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 			continue;
 		}
 
+		if (!strcmp("type", request->line)) {
+			info.type = 1;
+			continue;
+		}
+
 		if (parse_oid(request->line, &oid_str_list))
 			continue;
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index b4d6beef11..d7445571b1 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -366,6 +366,33 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'object-info supports type' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	type
+	oid $(git rev-parse two:two.t)
+	oid $(git rev-parse two:two.t)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	size
+	type
+	$(git rev-parse two:two.t) $(test_file_size two.t) blob
+	$(git rev-parse two:two.t) $(test_file_size two.t) blob
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare OID request' '
 	test_config transfer.advertiseObjectInfo true &&
 

-- 
2.54.0

