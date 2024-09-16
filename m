Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2553158DC1
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489762; cv=none; b=MrEz4MSWAyKm7mUjSCYv1iPFCEhoNsH93Yqy3ni3aU5EoWLyOBQdlDnTNqNGWrPev1DKD853l258ZVntaDz+wUBzKQGPGMRa7Ctn3CA8bHtkCuZJ2N5b+ke899+dxe4e2TIf7QcVO+URQoIMSMpFivDpj9KGUFKVZDwHUdQdmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489762; c=relaxed/simple;
	bh=05/GNCcXcT7m+G3ywxkizG+TVE5VDzWbpfqJw813NTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGeXWlr9Pn+g6v9vQv+GyKcaiH4JP/qTOlWbGEYySq0sx1IIUG2LaZuAoQ65p2zgw3ALczbiPnwgCGMdtgwCoQJUS4KOM4F/O9nb3zgsU1RnnvyGx+PgjLeUEoLVg1CGLTSzzfrgyZj8I6ALBj/S7Fspjt8ZznW9Oe/ssqFyfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avYceeTU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAHgb4sm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avYceeTU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAHgb4sm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B002113801E0;
	Mon, 16 Sep 2024 08:29:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Sep 2024 08:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489759; x=1726576159; bh=g6Xp4bi3QZ
	ZRye5C3xewQuhPoDfZ+wCNKoInqzsYX6c=; b=avYceeTULEy9OfrSu4xnkXDCHX
	q63rItu7Ylua1A7kPAQ+xkJfMOP2I1MpUfTZXP+yuFJ2Brgm08Kc9xA52GgZRA1d
	sXzVpzWeVggCxg848JgqCGNJTRPmL/CKE7jI+YUJMk5OjluACOJl5k8VMEtWXBa1
	ew7Q17XahyZfa+bf0VW0srwMqz77znhVoGInNo1mwZUUn0d+qsHUuV6u8xbcNZfQ
	PX7f5iICizIMvT7/DaaUzLaQ+WpZSHMyoY/mvoTWVGlpIgYT45qkD5BusD9dhW45
	5AHXNn9GXLRhcU5SN58bJdy+DOaJnyqr7N4V5r0swe5s1Qy+pE9i/6wavjsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489759; x=1726576159; bh=g6Xp4bi3QZZRye5C3xewQuhPoDfZ
	+wCNKoInqzsYX6c=; b=oAHgb4smvdUjW6XvmRPtplUWbQc/nHHJ4CPa2X0+si6i
	BC4+nLw/IqghYfjiasB7cYwtFTEH9rlSOFQ1BlA87DST/Zl7R4e3tFmd10znPNsx
	Iu5XD9EPYbrCEi4sTa+Ip2MLkjScEfu8Zqjj73p26YeTDc6KTcBIDQrXFlVa3nyU
	43k5a71nS0vLdKA6fSbatVdWuwceCBuqRskuVaPqRwiVrbo0LqIJdyJbTY94cqpo
	eveQRKqLDEubJWsVYSIEmfE4HgPFmqfZHzSem3uCoEj1Ofs+WUhDDbLyiz5WbuqI
	ZW/PLON7fKkeCqzxhKqrGYjsIvdPWWp+cW2XZIDLzw==
X-ME-Sender: <xms:nyToZvGwV1h_gIG6z69Z0z_AE_rKJza2TVdxryPO6wpjtgSOu1n4Bw>
    <xme:nyToZsX4cMoNiQ2pu5lUlEEmm5j_-_gsYznNthOGYpESZhrulr9uTd48pSv_H9aT-
    -_P7QtwVMqkDHm1zw>
X-ME-Received: <xmr:nyToZhJCl9RHoKqgbR-FPKAw_mvVh_NRlnv659-kUOGN284OTxkpWL6gPCpp0G4AAfPnDIJencNzpVxiIVGjL2V69_9S9kEX8SaJM0Oswj9ONjku>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nyToZtG5PjMXLFU9sXNsAyeO9efqB_AgKcPRKO82iMeQdEdqdAlJIg>
    <xmx:nyToZlWolvOSiT3Cb7JxtRA4EMDHEy_4cMvj4C53raRdV1w8mX8ObA>
    <xmx:nyToZoOmpHfIsS2YsCKOPCWcTwo5WcsEI2RShDEuPV4WqbiInfephQ>
    <xmx:nyToZk0pFmxyvpIQMd8gLAxITsfs2cuoosN_3uY53fcxOrkkoQKGXQ>
    <xmx:nyToZiiLDNXAS3JqzUung5_HuTNBnJybcqv8yseXqWr84STFItae7D7c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fdb1c59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:29:01 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 19/22] reftable/block: handle allocation failures
Message-ID: <4fa47a559b267c7ea074e4c3832211517e0e98de.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures in `block_writer_init()` and
`block_reader_init()`. This requires us to bubble up error codes into
`writer_reinit_block_writer()`. Adapt call sites accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                | 23 +++++++++++++--
 reftable/block.h                |  4 +--
 reftable/writer.c               | 51 ++++++++++++++++++++++-----------
 t/unit-tests/t-reftable-block.c | 20 +++++++------
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 00030eee065..bfa7dc61bf5 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -52,6 +52,8 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 		return -1;
 	if (is_restart) {
 		REFTABLE_ALLOC_GROW(w->restarts, w->restart_len + 1, w->restart_cap);
+		if (!w->restarts)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
 		w->restarts[w->restart_len++] = w->next;
 	}
 
@@ -63,8 +65,8 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	return 0;
 }
 
-void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
-		       uint32_t block_size, uint32_t header_off, int hash_size)
+int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+		      uint32_t block_size, uint32_t header_off, int hash_size)
 {
 	bw->buf = buf;
 	bw->hash_size = hash_size;
@@ -78,8 +80,12 @@ void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
 	bw->last_key.len = 0;
 	if (!bw->zstream) {
 		REFTABLE_CALLOC_ARRAY(bw->zstream, 1);
+		if (!bw->zstream)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
 		deflateInit(bw->zstream, 9);
 	}
+
+	return 0;
 }
 
 uint8_t block_writer_type(struct block_writer *bw)
@@ -163,6 +169,10 @@ int block_writer_finish(struct block_writer *w)
 		 */
 		compressed_len = deflateBound(w->zstream, src_len);
 		REFTABLE_ALLOC_GROW(w->compressed, compressed_len, w->compressed_cap);
+		if (!w->compressed) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			return ret;
+		}
 
 		w->zstream->next_out = w->compressed;
 		w->zstream->avail_out = compressed_len;
@@ -219,12 +229,21 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		/* Log blocks specify the *uncompressed* size in their header. */
 		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
 				    br->uncompressed_cap);
+		if (!br->uncompressed_data) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
 
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(br->uncompressed_data, block->data, block_header_skip);
 
 		if (!br->zstream) {
 			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
+			if (!br->zstream) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
+
 			err = inflateInit(br->zstream);
 		} else {
 			err = inflateReset(br->zstream);
diff --git a/reftable/block.h b/reftable/block.h
index 1c8f25ee6eb..18d7ea03373 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -45,8 +45,8 @@ struct block_writer {
 /*
  * initializes the blockwriter to write `typ` entries, using `buf` as temporary
  * storage. `buf` is not owned by the block_writer. */
-void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
-		       uint32_t block_size, uint32_t header_off, int hash_size);
+int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+		      uint32_t block_size, uint32_t header_off, int hash_size);
 
 /* returns the block type (eg. 'r' for ref records. */
 uint8_t block_writer_type(struct block_writer *bw);
diff --git a/reftable/writer.c b/reftable/writer.c
index 54ec822e1cd..712a84791b2 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -102,19 +102,24 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 	return header_size(writer_version(w));
 }
 
-static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
+static int writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 {
-	int block_start = 0;
-	if (w->next == 0) {
+	int block_start = 0, ret;
+
+	if (w->next == 0)
 		block_start = header_size(writer_version(w));
-	}
 
 	strbuf_reset(&w->last_key);
-	block_writer_init(&w->block_writer_data, typ, w->block,
-			  w->opts.block_size, block_start,
-			  hash_size(w->opts.hash_id));
+	ret = block_writer_init(&w->block_writer_data, typ, w->block,
+				w->opts.block_size, block_start,
+				hash_size(w->opts.hash_id));
+	if (ret < 0)
+		return ret;
+
 	w->block_writer = &w->block_writer_data;
 	w->block_writer->restart_interval = w->opts.restart_interval;
+
+	return 0;
 }
 
 int reftable_writer_new(struct reftable_writer **out,
@@ -247,8 +252,11 @@ static int writer_add_record(struct reftable_writer *w,
 
 	strbuf_reset(&w->last_key);
 	strbuf_addbuf(&w->last_key, &key);
-	if (!w->block_writer)
-		writer_reinit_block_writer(w, reftable_record_type(rec));
+	if (!w->block_writer) {
+		err = writer_reinit_block_writer(w, reftable_record_type(rec));
+		if (err < 0)
+			goto done;
+	}
 
 	if (block_writer_type(w->block_writer) != reftable_record_type(rec))
 		BUG("record of type %d added to writer of type %d",
@@ -271,7 +279,9 @@ static int writer_add_record(struct reftable_writer *w,
 	err = writer_flush_block(w);
 	if (err < 0)
 		goto done;
-	writer_reinit_block_writer(w, reftable_record_type(rec));
+	err = writer_reinit_block_writer(w, reftable_record_type(rec));
+	if (err < 0)
+		goto done;
 
 	/*
 	 * Try to add the record to the writer again. If this still fails then
@@ -461,7 +471,9 @@ static int writer_finish_section(struct reftable_writer *w)
 
 		max_level++;
 		index_start = w->next;
-		writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+		err = writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
+		if (err < 0)
+			return err;
 
 		idx = w->index;
 		idx_len = w->index_len;
@@ -555,7 +567,10 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err < 0)
 		goto done;
 
-	writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+	arg->err = writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
+	if (arg->err < 0)
+		goto done;
+
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
@@ -584,16 +599,18 @@ static int writer_dump_object_index(struct reftable_writer *w)
 	struct common_prefix_arg common = {
 		.max = 1,		/* obj_id_len should be >= 2. */
 	};
-	if (w->obj_index_tree) {
+	int err;
+
+	if (w->obj_index_tree)
 		infix_walk(w->obj_index_tree, &update_common, &common);
-	}
 	w->stats.object_id_len = common.max + 1;
 
-	writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
+	err = writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
+	if (err < 0)
+		return err;
 
-	if (w->obj_index_tree) {
+	if (w->obj_index_tree)
 		infix_walk(w->obj_index_tree, &write_object_record, &closure);
-	}
 
 	if (closure.err < 0)
 		return closure.err;
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index f1a49485e23..e52a612e852 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -34,8 +34,9 @@ static void t_ref_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source ,&buf);
-	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
-			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
+				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	check(!ret);
 
 	rec.u.ref.refname = (char *) "";
 	rec.u.ref.value_type = REFTABLE_REF_DELETION;
@@ -126,8 +127,9 @@ static void t_log_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source ,&buf);
-	block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
-			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
+				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	check(!ret);
 
 	for (i = 0; i < N; i++) {
 		rec.u.log.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
@@ -214,8 +216,9 @@ static void t_obj_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source, &buf);
-	block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
-			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
+				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	check(!ret);
 
 	for (i = 0; i < N; i++) {
 		uint8_t bytes[] = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
@@ -296,8 +299,9 @@ static void t_index_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source, &buf);
-	block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
-			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
+				header_off, hash_size(GIT_SHA1_FORMAT_ID));
+	check(!ret);
 
 	for (i = 0; i < N; i++) {
 		strbuf_init(&recs[i].u.idx.last_key, 9);
-- 
2.46.0.551.gc5ee8f2d1c.dirty

