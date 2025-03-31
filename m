Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C21DE8A2
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410494; cv=none; b=ofVrf7F+VMo2o/JjcRFSjxdeC0dAFVN+KMVBC+BJSkl2cZRCH4Tj1foooagAqaz8fbf7tHgr9tw+wvK2z/6kyFDBa+qpYAvv74+4f86oXjzekpuL+94auN0trunsYYn32N7XheGtSNAH0bIUWha9GYFZWi7BR02SIyFYA36uX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410494; c=relaxed/simple;
	bh=sE+aO7M4s6dwLf0rmqLkyoBeKUYppgmNHatMZLJqtMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6TFSmiCooRF78HFIYI39cPd1P/17n1icVbivcPFShYe31gunASGQTtG/i72tnPpTBhdP4Q0sYL3ttZwJcG8/D6yzajtgiZr2JUdOsIA887cad40SbW3hkj/EzyEfYjMwkaMTpDPztW2Of1U60S6FrcEV4d9r8X0wC/bkSeS6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MoZmlnK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o8mAzOmB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MoZmlnK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8mAzOmB"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 187821382D85
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 31 Mar 2025 04:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410492;
	 x=1743496892; bh=Wd7GpukHog3NYfECwtiZ1DfkBhWLjHYbHlfB2BqIf50=; b=
	MoZmlnK1//JdWBJHTYkQOVPmWpmKH3FxYptSGLwlfxBST3/yA7hgexleoQWKcxNC
	O0zDLMmTFn8IO5E/O2iVxu2+U8avvJl2k0rcX2F1sUvLhK/dmd2hZzFh6jv6gB1E
	KwLOgaJIi8+oDjzMvifUC9Z6XcUSKVyqm26h+qovzvD00xWZjIPJ8Xd4st/0Jsdx
	DeRJ8/9Tk6BkzEYm7R+UgGeLyxSMnkge4UjLGwXKWFixrfjjHYEW8dl82JDQ6A8K
	VYY2B/51gj0K7o6Uoc0Vw5Yp1MDWWJGDpIBN9Eign9Yj6LydP4jxkLxQngdvy1qc
	sExuI5zBj3A3cP17ROHyAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410492; x=
	1743496892; bh=Wd7GpukHog3NYfECwtiZ1DfkBhWLjHYbHlfB2BqIf50=; b=o
	8mAzOmByGblstuQh0sAHQZRY8ycyMFH9/ZMR22uXxG+jIP9RAxpyVxJJ34LJ95gO
	+UHo9fOiQouZOu1DFk0pINRdMQJA24PwLzbWfKrjtzlnlpeuJW2y/BwwMRLJPqAe
	lQz4JimPRGI+15wyiK8QALvbC56J6lGqbxZarK8jxswOJHW72GciQuNmgf6/eeXP
	zySjyM4peZB5vKR2Ylyo5IVeGNUftfVJLCNhQ/TvC9moDZWKp140dI75CYZYgC6R
	MZk98cihok2tv2XG+ky02J5yUB66L64pVDURhtLSvJVxJvrP4sAlC49n8LGedFIR
	knkjbK4d8u6gt2ENmEm+w==
X-ME-Sender: <xms:O1XqZ3kzjFiIkCD8i9zWI--UbjQxHRpIjng9a2IllLK9Spe2BOaVXA>
    <xme:O1XqZ628clMCv_hPtCty7TNtqiHgsDfBZXx9wzl9LZrF6mkV65N8mblGDn5PA_lQo
    mAoA0hFKkd-nzD6IQ>
X-ME-Received: <xmr:O1XqZ9obOoq367znbD6EJn7YwT-L754uH6ruben62vgJ-rJss89FEYACC9YOxP_HZifZn443qfCYsRpyBPjlNq0S4efsU2MHlDEkkRi6_H-qVPih>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O1XqZ_kjnw3AFI64OEY7_9GpPSVZDyv3db_a70CWAHX8a2ERT_hN9w>
    <xmx:O1XqZ13L4xrT1O9v-G5yRKpov7PoDa0CipPelCxguvq3h5n9QhmFKw>
    <xmx:O1XqZ-vAVbwc3bahvuqbQssi_EElqhWBmFm32f4fuk_ARPi19AYaYQ>
    <xmx:O1XqZ5XXF1EpaL8PMyMeitEp_jIvS_B6r9LcILxhUFhx6D_TbHG-fQ>
    <xmx:PFXqZ29VL471at9NgjkI13_lcT2k3QIk1bmwc1TlvJtcbZIvNPo4R8kK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c91e9f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:29 +0200
Subject: [PATCH 11/16] reftable/block: make block iterators reseekable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-11-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Refactor the block iterators so that initialization and seeking are
different from one another. This makes the iterator trivially reseekable
by storing the pointer to the block at initialization time, which we can
then reuse on ever seek.

This refactoring prepares the code for exposing a `reftable_iterator`
interface for blocks in a subsequent commit. Callsites are adjusted
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                | 23 +++++++++++++----------
 reftable/block.h                | 21 ++++++++++++++++-----
 reftable/iter.c                 |  2 +-
 reftable/table.c                | 11 +++++++----
 t/unit-tests/t-reftable-block.c | 30 +++++++++++++++---------------
 5 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 576c6caf59b..6e5c1191f5f 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -381,11 +381,16 @@ static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
 	return reftable_get_be24(b->block.data + b->restart_off + 3 * idx);
 }
 
-void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block)
+void block_iter_init(struct block_iter *it, const struct reftable_block *block)
 {
 	it->block = block;
+	block_iter_seek_start(it);
+}
+
+void block_iter_seek_start(struct block_iter *it)
+{
 	reftable_buf_reset(&it->last_key);
-	it->next_off = block->header_off + 4;
+	it->next_off = it->block->header_off + 4;
 }
 
 struct restart_needle_less_args {
@@ -473,12 +478,11 @@ void block_iter_close(struct block_iter *it)
 	reftable_buf_release(&it->scratch);
 }
 
-int block_iter_seek_key(struct block_iter *it, const struct reftable_block *block,
-			struct reftable_buf *want)
+int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want)
 {
 	struct restart_needle_less_args args = {
 		.needle = *want,
-		.block = block,
+		.block = it->block,
 	};
 	struct reftable_record rec;
 	int err = 0;
@@ -496,7 +500,7 @@ int block_iter_seek_key(struct block_iter *it, const struct reftable_block *bloc
 	 * restart point. While that works alright, we would end up scanning
 	 * too many record.
 	 */
-	i = binsearch(block->restart_count, &restart_needle_less, &args);
+	i = binsearch(it->block->restart_count, &restart_needle_less, &args);
 	if (args.error) {
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
@@ -521,12 +525,11 @@ int block_iter_seek_key(struct block_iter *it, const struct reftable_block *bloc
 	 *     starting from the preceding restart point.
 	 */
 	if (i > 0)
-		it->next_off = block_restart_offset(block, i - 1);
+		it->next_off = block_restart_offset(it->block, i - 1);
 	else
-		it->next_off = block->header_off + 4;
-	it->block = block;
+		it->next_off = it->block->header_off + 4;
 
-	err = reftable_record_init(&rec, reftable_block_type(block));
+	err = reftable_record_init(&rec, reftable_block_type(it->block));
 	if (err < 0)
 		goto done;
 
diff --git a/reftable/block.h b/reftable/block.h
index 268d5a1e005..1bfd44f56aa 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -79,12 +79,23 @@ struct block_iter {
 	.scratch = REFTABLE_BUF_INIT, \
 }
 
-/* Position `it` at start of the block */
-void block_iter_seek_start(struct block_iter *it, const struct reftable_block *block);
+/*
+ * Initialize the block iterator with the given block. The iterator will be
+ * positioned at the first record contained in the block. The block must remain
+ * valid until the end of the iterator's lifetime. It is valid to re-initialize
+ * iterators multiple times.
+ */
+void block_iter_init(struct block_iter *it, const struct reftable_block *block);
+
+/* Position the initialized iterator at the first record of its block. */
+void block_iter_seek_start(struct block_iter *it);
 
-/* Position `it` to the `want` key in the block */
-int block_iter_seek_key(struct block_iter *it, const struct reftable_block *block,
-			struct reftable_buf *want);
+/*
+ * Position the initialized iterator at the desired record key. It is not an
+ * error in case the record cannot be found. If so, a subsequent call to
+ * `block_iter_next()` will indicate that the iterator is exhausted.
+ */
+int block_iter_seek_key(struct block_iter *it, struct reftable_buf *want);
 
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
 int block_iter_next(struct block_iter *it, struct reftable_record *rec);
diff --git a/reftable/iter.c b/reftable/iter.c
index 74684de8f6a..7a7e8aa4d7e 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -139,7 +139,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 		/* indexed block does not exist. */
 		return REFTABLE_FORMAT_ERROR;
 	}
-	block_iter_seek_start(&it->cur, &it->block);
+	block_iter_init(&it->cur, &it->block);
 	return 0;
 }
 
diff --git a/reftable/table.c b/reftable/table.c
index 3f2e70caac4..5422ed6769c 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -208,7 +208,7 @@ static int table_iter_next_block(struct table_iter *ti)
 
 	ti->block_off = next_block_off;
 	ti->is_finished = 0;
-	block_iter_seek_start(&ti->bi, &ti->block);
+	block_iter_init(&ti->bi, &ti->block);
 
 	return 0;
 }
@@ -256,7 +256,7 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
 
 	ti->typ = reftable_block_type(&ti->block);
 	ti->block_off = off;
-	block_iter_seek_start(&ti->bi, &ti->block);
+	block_iter_init(&ti->bi, &ti->block);
 	ti->is_finished = 0;
 	return 0;
 }
@@ -349,7 +349,8 @@ static int table_iter_seek_linear(struct table_iter *ti,
 	 * the wanted key inside of it. If the block does not contain our key
 	 * we know that the corresponding record does not exist.
 	 */
-	err = block_iter_seek_key(&ti->bi, &ti->block, &want_key);
+	block_iter_init(&ti->bi, &ti->block);
+	err = block_iter_seek_key(&ti->bi, &want_key);
 	if (err < 0)
 		goto done;
 	err = 0;
@@ -417,7 +418,9 @@ static int table_iter_seek_indexed(struct table_iter *ti,
 		if (err != 0)
 			goto done;
 
-		err = block_iter_seek_key(&ti->bi, &ti->block, &want_index.u.idx.last_key);
+		block_iter_init(&ti->bi, &ti->block);
+
+		err = block_iter_seek_key(&ti->bi, &want_index.u.idx.last_key);
 		if (err < 0)
 			goto done;
 
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index e36ed7ac576..c4ced39a73b 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -66,7 +66,8 @@ static void t_ref_block_read_write(void)
 	block_source_from_buf(&source ,&block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
+	block_iter_seek_start(&it);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -79,10 +80,9 @@ static void t_ref_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -91,7 +91,7 @@ static void t_ref_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -156,7 +156,8 @@ static void t_log_block_read_write(void)
 	block_source_from_buf(&source, &block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
+	block_iter_seek_start(&it);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -169,11 +170,10 @@ static void t_log_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_buf_reset(&want);
 		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -182,7 +182,7 @@ static void t_log_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -249,7 +249,8 @@ static void t_obj_block_read_write(void)
 	block_source_from_buf(&source, &block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
+	block_iter_seek_start(&it);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -262,10 +263,9 @@ static void t_obj_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -334,7 +334,8 @@ static void t_index_block_read_write(void)
 	block_source_from_buf(&source, &block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
+	block_iter_seek_start(&it);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -347,10 +348,9 @@ static void t_index_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -359,7 +359,7 @@ static void t_index_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);

-- 
2.49.0.604.gff1f9ca942.dirty

