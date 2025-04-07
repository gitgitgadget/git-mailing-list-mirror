Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB6255232
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031796; cv=none; b=O4ioGMCHtqTZnKj6XS476ZApRZYS9eRRA0lWmGLn0d/XNGU/+YmSDUav6LdB6rrZBtUSHfb3pBmDDyUB0APm0+SucHssq1gz+LZePlvc/cek8/xvYnkmneu+l6K7BUepnY5tFW6m3IGPPxTscMuY7yvU2B5TXrtNnVPkU1rRZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031796; c=relaxed/simple;
	bh=yyQH6SpjWFYD+V8dY3VsF1BIHOEX9Q4Mg6SE5HSa7ME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkwGFQIaEn6bjmQzzaoG74bI0l9JW1DrY93+heXSnPWuy9s6U0qcYnQ6qO9nqFv7cFUa0uB0pSs0irixYvyE72PhA4rBFOFEBYi+Bw3+PjEWET71SximjOL46RPWBacXfMYZQXqnY9JOszlVIRRxpqQ6ElZ5guT5et+zvybDwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c5igDEiY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5T/S05J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c5igDEiY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5T/S05J"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A8953138032D;
	Mon,  7 Apr 2025 09:16:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 09:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031793;
	 x=1744118193; bh=DntH2Rgb9d9yQflW03bjRqU0/1TbH36xZ6b3TcB5Lv8=; b=
	c5igDEiY1+XQIpRfWk41X2pL05gh07Zp7rfPqMbPLBLonI1uiGJWCTEwsIhgHZAb
	xoNF6B7V4L7E1DxoSS4y63H64RMgwXeUQxVMP6jk0+WS4SpDGd5nQeCMtzFYYFV7
	R1Hc2G2nDJqBDJ4shLrWzTscsxJh0R7tt+m5JjRLEoYhVWd+F6fOKTvy4aPibAaw
	NPmXJWT/d2cUHjo5JbRWFcqzy21iT6evrMWM7pWm7LL5CI+cnqGJuenPTWRJuAvK
	UKVzlHZ9Nfj0PZhsEsBN+dOGBZAh9jglCp8Ev852i2eyh8Dj1x8WQXkEAwB2IwxE
	QDGNqFWdWmyufIpVwkpR1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031793; x=
	1744118193; bh=DntH2Rgb9d9yQflW03bjRqU0/1TbH36xZ6b3TcB5Lv8=; b=F
	5T/S05J34goCNu64kGiOikWpuHrD0ydNRaGH5UzEWSZHuPIFXcGodIC/U7KpZcLH
	BYyRmj6PDxZadiW7OW32IZB1rAKOcqUUdbbVYPzgooypxSEv2hCQ/ZMiurT31VSE
	xe2nB95YUbK2eEV084MVD0AjZcQNFvwf+goNs7KI2qaovED+BSJwy7AeCGwKgZuJ
	cdaBFpMWcWHKEVdezYdiOSzyysVdeXll+H0KYjjM3Ha7BDekFtxjr9CKfjZ5av92
	ORhAE7TiNEhBj2uOXugeY7DsqlrDyQoCueNrzDYf5QHNgy9CHHW37ZOt3I/BtMFG
	4Kpp0AkVYnnvkwYxTOArA==
X-ME-Sender: <xms:MdDzZ0ItuxbvkgI4aPqVsAwOA9s8QUTfjwICgCAdxbuXV2Jo7KItvA>
    <xme:MdDzZ0KtKRUEyut3jiJcpBGkHlKya7wWu0v-ACQjgKHouna0bhC0_kJHUmZzAoj8Y
    Ad0_QuOTZ4IrpwNfQ>
X-ME-Received: <xmr:MdDzZ0tpoGAbQzjJ4vZlmmVGRUXWvZIvX_LwURrkaO7p3QngoNS_HnabRwbjEdzqA76sr0G8oczI606FNkMh49d3KTBO0k0WQ9jalgLAwtw9cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MdDzZxaj7aLv1MWcK78UtH9zlokJBFzT1zM9BmSqGbPj3oSaaIEgAA>
    <xmx:MdDzZ7b4P4jcvg-P5WWi8sthsfuy7iyi8uvloRBNMPxsfHjMXvo-Gw>
    <xmx:MdDzZ9AFXxlCrcIcAYNPP4wpHHUwlziLuopCVByCp3tuvO1CTItbQA>
    <xmx:MdDzZxbrC1vwK4qfVqc2_rgzPDs-3iGABomecrT82g938WXMwkRH0A>
    <xmx:MdDzZ8k1dfA15FLmG9gOhyicx3oiEV5UYBGcwEy8S4jEB4WsIEN8f3h9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cedf12af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:23 +0200
Subject: [PATCH v2 11/16] reftable/block: make block iterators reseekable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-11-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor the block iterators so that initialization and seeking are
different from one another. This makes the iterator trivially reseekable
by storing the pointer to the block at initialization time, which we can
then reuse on every seek.

This refactoring prepares the code for exposing a `reftable_iterator`
interface for blocks in a subsequent commit. Callsites are adjusted
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                | 23 +++++++++++++----------
 reftable/block.h                | 21 ++++++++++++++++-----
 reftable/iter.c                 |  2 +-
 reftable/table.c                | 11 +++++++----
 t/unit-tests/t-reftable-block.c | 26 +++++++++++---------------
 5 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index a425dd7abf3..20712be7eee 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -381,11 +381,16 @@ static uint32_t block_restart_offset(const struct reftable_block *b, size_t idx)
 	return reftable_get_be24(b->block_data.data + b->restart_off + 3 * idx);
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
index 9ce675510c9..a79c90d9ba6 100644
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
index ef1f33c92fc..50ffad7edcb 100644
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
index e36ed7ac576..9f91d697f6d 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -66,7 +66,7 @@ static void t_ref_block_read_write(void)
 	block_source_from_buf(&source ,&block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -79,10 +79,9 @@ static void t_ref_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -91,7 +90,7 @@ static void t_ref_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -156,7 +155,7 @@ static void t_log_block_read_write(void)
 	block_source_from_buf(&source, &block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -169,11 +168,10 @@ static void t_log_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_buf_reset(&want);
 		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -182,7 +180,7 @@ static void t_log_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -249,7 +247,7 @@ static void t_obj_block_read_write(void)
 	block_source_from_buf(&source, &block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -262,10 +260,9 @@ static void t_obj_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -334,7 +331,7 @@ static void t_index_block_read_write(void)
 	block_source_from_buf(&source, &block_data);
 	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
 
-	block_iter_seek_start(&it, &block);
+	block_iter_init(&it, &block);
 
 	for (i = 0; ; i++) {
 		ret = block_iter_next(&it, &rec);
@@ -347,10 +344,9 @@ static void t_index_block_read_write(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);
@@ -359,7 +355,7 @@ static void t_index_block_read_write(void)
 		check(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1));
 
 		want.len--;
-		ret = block_iter_seek_key(&it, &block, &want);
+		ret = block_iter_seek_key(&it, &want);
 		check_int(ret, ==, 0);
 
 		ret = block_iter_next(&it, &rec);

-- 
2.49.0.604.gff1f9ca942.dirty

