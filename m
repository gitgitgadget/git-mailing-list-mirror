Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A6226186
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828355; cv=none; b=GhKSL/TP9dXqdqx1Uc1BKFmKxFOr7mltx89xplUbhpNH0AC/nwDxpfbzNjG18xzTFq8OZnYHsxeqarFJ7eGjUr12JkV1iMX6ueyTUr5UvspiYMUl2gLnSUmIYYu5msmoqEg3Ibt8OSDcsgauTrAbYpJA+a/snqgeFCLv5sI258U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828355; c=relaxed/simple;
	bh=xKuRG4n51uehYas7I9/AdhWyDDi6KGjeIZU9cqrNd5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkvQxcvHv5/6IYXklXA/voAg87kMVOabaY/16DCtcfwHPqMSj2MkDiro58ZRz4/s/KFX06WB6HlrHQ4CekJCIJc58FKXFyWGML35eGWZYW2pLK0mkh7qjx9F8nwY4Jo/ilgukUdO34zcU8pofGuKKfrafwJ+h+B40HXyzNYfkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nN5NSfeE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=maL2J9ap; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nN5NSfeE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="maL2J9ap"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C9B6913801F6;
	Thu,  6 Feb 2025 02:52:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 06 Feb 2025 02:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828351;
	 x=1738914751; bh=CzMzM5hAHzjSCVXBc2rdhes5dZghnM1KlfQhn05iLXM=; b=
	nN5NSfeEhiVj6YNYCb3OC2MYwTrQWCmY9oLHOT5XhzcL8HB3K5WvIU+7Y5YMmSYX
	+w3YtITQvy2+L+sI0Ks0F8lLqRMbLQzNQwOTwUw4+pS8xfr5SFVErf5YV36HH8Ax
	bZX9g785yqKoQZILQ9gnlaFSu5kidQe7us+s5G7khAy7VMflDa2phfZR5RJSJ5hY
	uCrvIKkrIsy7TkatZ+5p6onVDQPU6BUJpgYTgrt9xylYZRwqVVjCwVdKrnfwnnQz
	m4cPy5QfM8Pojw63nO3FeKTA/1+0U254L7dPC/1W3VgRMUZOqPlljT4rjG6EYN3H
	+/KVFxInGsHL/nsux4p3ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828351; x=
	1738914751; bh=CzMzM5hAHzjSCVXBc2rdhes5dZghnM1KlfQhn05iLXM=; b=m
	aL2J9ap7UzbZnWRwc4JD7ZofMYlYROSRqmRwnezkbZA4MxqoW6eM9Wu0+kREmkuj
	5E1+wgFIzHKvlTkwCf7yczfaR/SJ/7L/9YvGBcRWGqTydO1PHcLN7bvI2VSe7dWP
	lK9Cvhgt9KiDCH1jQCWcJ1UpUhWhsoZsp16ZIWAAonCOGHQ4cnD9h6W8iA8kJMdb
	W3+Dpr726JsxlLdSh/7ZguB3MC59x57l+y5f8JCyxJhE0R3Pmnccn5wUflPuus9U
	OBiP8t5KtuTbW+nnWXzUxDwiRNsTAWh+ywlRMgx5+mdFZjBArLc98wx4ceSXwjQ4
	SGF8CVNuwJus8TosXdDCg==
X-ME-Sender: <xms:P2qkZ9VOQSTdTPvDRaKJvCY1-YPjISrkKmKxdSWVyiMdX-Jqwloceg>
    <xme:P2qkZ9kK9MbxbyVezwFwvawHou5z3GvJySlT8JT35aRANzbzsbKk-4hBmbUNKUgua
    yrvyxbhtJbomL0BYA>
X-ME-Received: <xmr:P2qkZ5bsEx1C5kdd9Ny3SLNgw5k6YMj4DW-KB2KFFi8_eT9z-7Lxlxga-abqgfXWO0EtSV1yEbwsLJWt2aKrljV215PX7koRncjcyU0j8g1d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:P2qkZwXsNbu-Mif0iaFZ6SFeZGl1Bh1_DJ93Sa3ORUgjeU4M7_CSww>
    <xmx:P2qkZ3nA4U5xqTVs7w15YDVFf-2Uq155wDHVTaTb-fm9pwD9E_2Cbg>
    <xmx:P2qkZ9dFfkc5SD9g2TyGejAUACT49LVXnaRNH15S6FDzCGU_71M-eQ>
    <xmx:P2qkZxF4VCqHz1xYWsyyEUDf9hpEbeWVrU9Hq1l0K5NWd17XkJc-TA>
    <xmx:P2qkZyuuxVfvrnQ1eOru_tjimZtT4g_CD7t4-eoEGJXRg8IuIEeCrykv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68730ebc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:16 +0100
Subject: [PATCH v4 14/18] reftable/basics: stop using `UNUSED` annotation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-14-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
index 9a1edf39a0..5ee2fe44a7 100644
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
@@ -528,13 +530,16 @@ static uint8_t reftable_obj_record_val_type(const void *rec)
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
@@ -563,8 +568,8 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 
 static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      uint32_t hash_size UNUSED,
-				      struct reftable_buf *scratch UNUSED)
+				      uint32_t hash_size,
+				      struct reftable_buf *scratch)
 {
 	struct string_view start = in;
 	struct reftable_obj_record *r = rec;
@@ -572,6 +577,9 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	int n = 0;
 	uint64_t last;
 
+	REFTABLE_UNUSED(hash_size);
+	REFTABLE_UNUSED(scratch);
+
 	reftable_obj_record_release(r);
 
 	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
@@ -618,17 +626,20 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
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
@@ -1054,12 +1065,14 @@ static int reftable_index_record_key(const void *r, struct reftable_buf *dest)
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
@@ -1075,19 +1088,23 @@ static void reftable_index_record_release(void *rec)
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
 
@@ -1097,15 +1114,19 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
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
@@ -1120,11 +1141,13 @@ static int reftable_index_record_decode(void *rec, struct reftable_buf key,
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
2.48.1.538.gc4cfc42d60.dirty

