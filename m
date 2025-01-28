Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F981F473F
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052910; cv=none; b=s7OejRf9RiiEAdaD46wMv4ymppzjYVWmB84bm8R8JO3nu2db29frJfnK7INMCuTFra3uKZ2lMgpWTNmmrzeGwn6vwrMmN4sfpnBK0KmQc0J33d6oalWWn0A+I1VAdQAUm0WgpLhQD7u02rDdMs+JYHdms7z9cfmrBLkAg8QV0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052910; c=relaxed/simple;
	bh=VI0guBAnlrQx8ug+rNahw3HaYKaoL90XO6wmT73ZoD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xpf8Jy0vByysTu3Ndb/iFC8bRfCBtvs/sQq83lO7A6jCat25jXLtnJnCnpQ3Kzon/TJF77LN3VgqXuM+Eq/AxEulcwuD513BCE0kmvpufE9bg70hn69xHhKizP1L5zFw1MdnWdFgmSf2Vu0wqw+93r3+nBxYO9E94gNx07TNrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KBUVwmYX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8fNflDX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KBUVwmYX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8fNflDX"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3680E11401CC;
	Tue, 28 Jan 2025 03:28:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jan 2025 03:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052908;
	 x=1738139308; bh=xkd0YUwGaxAHDbOLxLubeRD8GcdkulaMiz/zIRxrvlU=; b=
	KBUVwmYXRpJ2r8aSbqogb534NYRQMKGir4QIiK6bkNkMRcav8Hkdg8mHaMGBzV2N
	LfYUGOres8qSFij8ML8F6F7f416yPuktzi2B1NAHgeaPI80StHyBWLJ/0YY5cuzA
	pfDZNa1ynlFZCgDihh+pGxfZKnA2Nv6pX5KohvZpkeQGXaACL2ooyVlCLwCzBAkk
	8dx+RB+o1tgvG/hFitQqKrSofPyLHGVaV8BR2GgbgEJANM9m0C2sZ/OfZxoXAuCS
	Atjf2SpMp8fY3hqnpLQ94ZiGazsO8VTIhHL90E05HdJvjBmr1TXF79q2ABmDJ3Au
	KxzUNuVgnnELC6mnxMRhOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052908; x=
	1738139308; bh=xkd0YUwGaxAHDbOLxLubeRD8GcdkulaMiz/zIRxrvlU=; b=n
	8fNflDX9ahYKhkUgiSpfaw62xMtyn+66xjIqUYl7jlZJhEcBO8S8YCRg5eKdiMvP
	7gV9GjnEWcfGA9HSFtlILOlBqWvieCY5z5wHef4U7Wsx1uQfBcJJS5sPUXM88wZf
	lfyeCJLqC8olRUYr63+ET7s5Bjjw33+pf8MDrIYWYFzbxf7e+ZOo41mFABLYMHJA
	h5yuXNz3fvpb52bu61NlMnrt6aV3W8XuG170l66kS4789/b9DmvBrAMpgmRa9hVc
	fDsCcNyx3lgRvw92qhcsXBqYaBrzK2p/gz032a9nprofuM79OUdn4UxZFNQfVr3J
	bhZHu5xMQFb5sW3Ecz4Vw==
X-ME-Sender: <xms:K5WYZzDm20HW_yC-sQdDActBYoixl1Ans0Y1FD4pkcP2_VoGtPYPpg>
    <xme:K5WYZ5g-prcBNTZBl5RVQoXe7vPNiMCRhSyvumVZh5qm3LUjQKz-Tiif4yddHClAY
    2V-kPdKgIZANjKmIA>
X-ME-Received: <xmr:K5WYZ-mOhQl4Y3tJgl0Tg2FymjWJk_fa22Crv4yofClk1Mxp-pgaTPs_zSj-PQrA5KjCjrCQI50SIUQqGLHE0yFvEeueGXA2ZlX1tvLMVq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K5WYZ1yb8h1oaWXbHrk-IUIh3mLxPSW3q3S5mY7eKGaemPTjlPmR9w>
    <xmx:K5WYZ4SS9PTyUbnrM7HzQV4Ym2gGlYId985VvROK1ZWjYPyZ-6QzTQ>
    <xmx:K5WYZ4aWWxIbQId06Qgh4koArVjQonv0cnpCfKr4rvqrn-M1ohyIkA>
    <xmx:K5WYZ5QMYYQ_z_3LjLAHc_ptBJFI5V69fbYz_QoVDwYq6u5gexNtaA>
    <xmx:LJWYZ-MZqGloV6-ZrJxV8ROWIzxMsrdz58jUL2KHGCsHZnE5OFspdbWR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d6375a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:15 +0100
Subject: [PATCH v2 14/20] reftable/basics: stop using `UNUSED` annotation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-14-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Stop using the `UNUSED` annotation and replace it with a new
`REFTABLE_UNUSED` macro. The latter is a weaker guarantee compared to
`UNUSED` as it only suppresses unused parameters without generating a
warning in case a parameter marked as unused is in fact used. But it's
good enough, and by relaxing the behaviour a bit we avoid having to wire
up compiler-specific logic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h      |  2 ++
 reftable/blocksource.c | 10 +++++++---
 reftable/iter.c        | 17 ++++++++++++-----
 reftable/record.c      | 51 ++++++++++++++++++++++++++++++++++++--------------
 reftable/writer.c      |  4 +++-
 5 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 59000798f0..4d0645a4e9 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -16,6 +16,8 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "reftable-basics.h"
 
+#define REFTABLE_UNUSED(x) (void)(x)
+
 struct reftable_buf {
 	size_t alloc;
 	size_t len;
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 02972c46f4..bfd64b0e48 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,15 +13,17 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void reftable_buf_return_block(void *b UNUSED, struct reftable_block *dest)
+static void reftable_buf_return_block(void *b, struct reftable_block *dest)
 {
+	REFTABLE_UNUSED(b);
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-static void reftable_buf_close(void *b UNUSED)
+static void reftable_buf_close(void *b)
 {
+	REFTABLE_UNUSED(b);
 }
 
 static ssize_t reftable_buf_read_block(void *v, struct reftable_block *dest,
@@ -67,8 +69,10 @@ static uint64_t file_size(void *b)
 	return ((struct file_block_source *)b)->size;
 }
 
-static void file_return_block(void *b UNUSED, struct reftable_block *dest UNUSED)
+static void file_return_block(void *b, struct reftable_block *dest)
 {
+	REFTABLE_UNUSED(b);
+	REFTABLE_UNUSED(dest);
 }
 
 static void file_close(void *v)
diff --git a/reftable/iter.c b/reftable/iter.c
index b2ffb09c16..452add2705 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -25,18 +25,23 @@ int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
 	return it->ops->next(it->iter_arg, rec);
 }
 
-static int empty_iterator_seek(void *arg UNUSED, struct reftable_record *want UNUSED)
+static int empty_iterator_seek(void *arg, struct reftable_record *want)
 {
+	REFTABLE_UNUSED(arg);
+	REFTABLE_UNUSED(want);
 	return 0;
 }
 
-static int empty_iterator_next(void *arg UNUSED, struct reftable_record *rec UNUSED)
+static int empty_iterator_next(void *arg, struct reftable_record *rec)
 {
+	REFTABLE_UNUSED(arg);
+	REFTABLE_UNUSED(rec);
 	return 1;
 }
 
-static void empty_iterator_close(void *arg UNUSED)
+static void empty_iterator_close(void *arg)
 {
+	REFTABLE_UNUSED(arg);
 }
 
 static struct reftable_iterator_vtable empty_vtable = {
@@ -143,9 +148,11 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 	return 0;
 }
 
-static int indexed_table_ref_iter_seek(void *p UNUSED,
-				       struct reftable_record *want UNUSED)
+static int indexed_table_ref_iter_seek(void *p,
+				       struct reftable_record *want)
 {
+	REFTABLE_UNUSED(p);
+	REFTABLE_UNUSED(want);
 	return REFTABLE_API_ERROR;
 }
 
diff --git a/reftable/record.c b/reftable/record.c
index d86cd65bb4..46093ef987 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -490,11 +490,13 @@ static void reftable_obj_record_release(void *rec)
 }
 
 static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					 uint32_t hash_size UNUSED)
+					 uint32_t hash_size)
 {
 	struct reftable_obj_record *obj = rec;
 	const struct reftable_obj_record *src = src_rec;
 
+	REFTABLE_UNUSED(hash_size);
+
 	reftable_obj_record_release(obj);
 
 	REFTABLE_ALLOC_ARRAY(obj->hash_prefix, src->hash_prefix_len);
@@ -523,13 +525,16 @@ static uint8_t reftable_obj_record_val_type(const void *rec)
 }
 
 static int reftable_obj_record_encode(const void *rec, struct string_view s,
-				      uint32_t hash_size UNUSED)
+				      uint32_t hash_size)
 {
 	const struct reftable_obj_record *r = rec;
 	struct string_view start = s;
 	int i = 0;
 	int n = 0;
 	uint64_t last = 0;
+
+	REFTABLE_UNUSED(hash_size);
+
 	if (r->offset_len == 0 || r->offset_len >= 8) {
 		n = put_var_int(&s, r->offset_len);
 		if (n < 0) {
@@ -558,8 +563,8 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 
 static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      uint32_t hash_size UNUSED,
-				      struct reftable_buf *scratch UNUSED)
+				      uint32_t hash_size,
+				      struct reftable_buf *scratch)
 {
 	struct string_view start = in;
 	struct reftable_obj_record *r = rec;
@@ -567,6 +572,9 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	int n = 0;
 	uint64_t last;
 
+	REFTABLE_UNUSED(hash_size);
+	REFTABLE_UNUSED(scratch);
+
 	reftable_obj_record_release(r);
 
 	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
@@ -613,17 +621,20 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	return start.len - in.len;
 }
 
-static int not_a_deletion(const void *p UNUSED)
+static int not_a_deletion(const void *p)
 {
+	REFTABLE_UNUSED(p);
 	return 0;
 }
 
 static int reftable_obj_record_equal_void(const void *a, const void *b,
-					  uint32_t hash_size UNUSED)
+					  uint32_t hash_size)
 {
 	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
 	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
 
+	REFTABLE_UNUSED(hash_size);
+
 	if (ra->hash_prefix_len != rb->hash_prefix_len
 	    || ra->offset_len != rb->offset_len)
 		return 0;
@@ -1049,12 +1060,14 @@ static int reftable_index_record_key(const void *r, struct reftable_buf *dest)
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
-					   uint32_t hash_size UNUSED)
+					   uint32_t hash_size)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
 	int err;
 
+	REFTABLE_UNUSED(hash_size);
+
 	reftable_buf_reset(&dst->last_key);
 	err = reftable_buf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
 	if (err < 0)
@@ -1070,19 +1083,23 @@ static void reftable_index_record_release(void *rec)
 	reftable_buf_release(&idx->last_key);
 }
 
-static uint8_t reftable_index_record_val_type(const void *rec UNUSED)
+static uint8_t reftable_index_record_val_type(const void *rec)
 {
+	REFTABLE_UNUSED(rec);
 	return 0;
 }
 
 static int reftable_index_record_encode(const void *rec, struct string_view out,
-					uint32_t hash_size UNUSED)
+					uint32_t hash_size)
 {
 	const struct reftable_index_record *r =
 		(const struct reftable_index_record *)rec;
 	struct string_view start = out;
+	int n;
 
-	int n = put_var_int(&out, r->offset);
+	REFTABLE_UNUSED(hash_size);
+
+	n = put_var_int(&out, r->offset);
 	if (n < 0)
 		return n;
 
@@ -1092,15 +1109,19 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
 }
 
 static int reftable_index_record_decode(void *rec, struct reftable_buf key,
-					uint8_t val_type UNUSED,
+					uint8_t val_type,
 					struct string_view in,
-					uint32_t hash_size UNUSED,
-					struct reftable_buf *scratch UNUSED)
+					uint32_t hash_size,
+					struct reftable_buf *scratch)
 {
 	struct string_view start = in;
 	struct reftable_index_record *r = rec;
 	int err, n = 0;
 
+	REFTABLE_UNUSED(val_type);
+	REFTABLE_UNUSED(hash_size);
+	REFTABLE_UNUSED(scratch);
+
 	reftable_buf_reset(&r->last_key);
 	err = reftable_buf_add(&r->last_key, key.buf, key.len);
 	if (err < 0)
@@ -1115,11 +1136,13 @@ static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 }
 
 static int reftable_index_record_equal(const void *a, const void *b,
-				       uint32_t hash_size UNUSED)
+				       uint32_t hash_size)
 {
 	struct reftable_index_record *ia = (struct reftable_index_record *) a;
 	struct reftable_index_record *ib = (struct reftable_index_record *) b;
 
+	REFTABLE_UNUSED(hash_size);
+
 	return ia->offset == ib->offset && !reftable_buf_cmp(&ia->last_key, &ib->last_key);
 }
 
diff --git a/reftable/writer.c b/reftable/writer.c
index 5961698311..0040a1b1c4 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -636,10 +636,12 @@ static void write_object_record(void *void_arg, void *key)
 done:;
 }
 
-static void object_record_free(void *void_arg UNUSED, void *key)
+static void object_record_free(void *void_arg, void *key)
 {
 	struct obj_index_tree_node *entry = key;
 
+	REFTABLE_UNUSED(void_arg);
+
 	REFTABLE_FREE_AND_NULL(entry->offsets);
 	reftable_buf_release(&entry->hash);
 	reftable_free(entry);

-- 
2.48.1.362.g079036d154.dirty

