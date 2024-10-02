Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9220010A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866586; cv=none; b=Yx6Lq7vfWCHf50saD2987tQwlSkhkWkdRbq+Nx6F9JSaYszjR1xk0YKIwvLRkRVCvDheLRyB6Wpc0105PMsO6REgw90FRMWSBBqnNIRFk2EpBHKREXyM/ypt7x+l+hpm+L4ARgU68LywCAveFH7APYP4sOxk4KQZs5fI8U1/Vfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866586; c=relaxed/simple;
	bh=nxnFusU36jdefOtwH5N0TGO/cIzg8Jmv4BRaHZupmac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aoycfh69IkzSFwokCBjXGCkt4BpejbxLRBATkJwLNThVPj9UoG4jb9swH0l8KVtbBkqfHsuoaNnN+bTdDO6N7NJgy2ZXT3GcQTON0ldQg8sG8Nje/E9Ox5xpGlMJ098MoCmIFtv6fjNhz56JFdSrbYcfmuPAD2037t11ET77eHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RquX+nob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xc5XKnQq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RquX+nob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xc5XKnQq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D72BE11401FD;
	Wed,  2 Oct 2024 06:56:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 06:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866583; x=1727952983; bh=6DQ2LC5BU5
	rVy0ACAlOFLzRhYa+jqtSVnnTkLPRNixo=; b=RquX+nobuYI2MaGOzbHr5KSojY
	zhNJ3vmJ/xr9Go5Ib+AjTIkHNhV6qoABM3U/WmOU8NfTLdD1DhW2XO0wwR8qjc1Z
	71nLDoRLAgomuApBkIcl0yDycWpSqHHQU9w3mTN1s3Y+758RexuVomK2RdmasNXM
	dJaO1ZbvTWk+qToFk4IMFnavt1yfiCAKZk2oPjSHwetUeu0wMDUpRZYpmHyJWAfI
	mKgegSh3NuztU3n/wIArzWPe5fWCgUR+bA55dXw1kGwYskUgqbf7ze0Aal0fBlAk
	PAp+7r+7C/rP3T2lBoTJaCPCFtqMypHS+dAszcNcC8H9fwwzFwciAdcZtG3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866583; x=1727952983; bh=6DQ2LC5BU5rVy0ACAlOFLzRhYa+j
	qtSVnnTkLPRNixo=; b=Xc5XKnQqvSte6DD8ud+JXcMkR9u1ibv0nOytlt63VyLP
	88BNMVT39Ytx2AcmKJOC5dGX0ixr7RB7jngg9yq4ULmcAl8Nyv6/KRvnzcrBKx3Y
	fBEGmuBTH5YU+Zp0PrGIdPEfTrcUwYiBxMQ5zGjTTxsuzAiKcsQI8QejzPru4uag
	L9IVbx5FFzamWx2JcuVksdKrYFr7U+gFaFY9YcaIB684fwGlHpxqsBTlmKBHpE8U
	qAKbZxiAJxwlMj1r2asIR5VYllbvr4gJTZSkCJNSNVrOnGlbcfUROvx5qSvuFlB0
	Nmjd9klwfk5G8pI9COwNcf+GSE5SAn2gH5wCdmitqg==
X-ME-Sender: <xms:1yb9ZrFEpFGOh7-FiiKg27m3hJpU28Y6kkpbBjSV_L9UJ8YOpJZDEA>
    <xme:1yb9ZoVhynH1lNT8K8sIAwGdDNomjA9knvp4Yfri-sthNVXHW7YnGfILtXFu8fLpl
    cUWGVp-6nxIMX2tBw>
X-ME-Received: <xmr:1yb9ZtJbxXpVArNB1jACznrheZJxm6jakOboufxyCA8C56Pc0odAhjoCw9eD78hYvgDVW7I286VprGLuPuis8fgHAX7ENzXkNAF6vmyKrzSBEePP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:1yb9ZpEwAp3DyI_iAP7uJ7e0TNxDQ9yJrVd-7bqx_YhWR6NAdup5dg>
    <xmx:1yb9ZhW4gJHbDWbqVSEydwh7lCjAWEVkxch6gXGBZMODojfj4pdogA>
    <xmx:1yb9ZkPbcwMc_qkwDezuhZJQfp-41qsmEyczeV-a6fiLmBYGq1pFaw>
    <xmx:1yb9Zg0ftD2eMpCjdaWlUJjF__0nxwbzqZTfq5ol1Z6SKzafCdj05g>
    <xmx:1yb9ZnyiU7ilrQ8pF0AQ8WNeecKjwUtJ7EbTH3kl5KMzuMq6npIUuBK0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0ca2034 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:32 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 19/25] reftable/block: handle allocation failures
Message-ID: <92d39b9021afc2dfcfa3d236c7c86286a7a4e101.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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
index 00030eee06..bfa7dc61bf 100644
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
index 1c8f25ee6e..18d7ea0337 100644
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
index 8ab2e916d3..791e246337 100644
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
index f1a49485e2..e52a612e85 100644
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
2.47.0.rc0.dirty

