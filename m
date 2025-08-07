Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AE24DFF3
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554233; cv=none; b=FfyQ8DevbgFQdg3bG3I/Vo9ovMCzmTaCVC0/WmBnSaDSh6BAOvs8P3ERmddD8MalOGuxaaaDcW8aYZgSrcOkaJQkb/ODGwsKvMLXr8CFC2a5Zv5c5+t6s7XSAaiiihqUH6zAlQxOf6+r18ea0OP7mYNyzejak1LeFKh6FQNvLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554233; c=relaxed/simple;
	bh=cygHMg673nBZSuPFRvu2PAo9SXhQs8Tl18EpBeFsrPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKxBGLtb6lQUgKDwmWDOL2/AhmxmoLKhe8ULJpQC12DdM7eh0piZvPO7Cifgy4GPo5Zl+LT2pg5ElROstCZP3y52qEXEiWzM+FqCIklPxSaCcSlkPCDVBJpmbrVS4UNBJiUBtMxbm2SUWg6RyzDlsMyHUw7NiW5eWyDSb9yoxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fYaraykD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adfgZ2b1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fYaraykD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adfgZ2b1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 91E12EC00D8;
	Thu,  7 Aug 2025 04:10:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554230;
	 x=1754640630; bh=12nhUByKQ4qH8OZE7ixrK1hYcSKc72UFi1Zea9GsPs4=; b=
	fYaraykDMTuh7ajMk3Ow3ygaAvepXkbLnSlLTQts0qhdMQfPD+8/zKEg+8+y4o0w
	0sUuf6KRR+1G65XV3mWLPgX0mdZCzje7dE+3rmvho2m71R9sKr/PuA/0/aYDTMEb
	fN/tAAhK6kIQgoA6+zpml89igpRw3xLTFyIj+tIJ3wasGnkQWpuJsi876ZBVvKdJ
	5hMtauveWFpWL6MDs6wEfB5uzJH1Pbqn2e7pYzEaOaDwramU9bLbvM2rmjXXnD0V
	Emhxvp5HoKAqsIcNETXmkopmqWmr+t3DcvAXaANuoD9jVfANqmQAe4ZbPkw4ZQ1K
	3pa7G8yPsjxffubGxsvmVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554230; x=
	1754640630; bh=12nhUByKQ4qH8OZE7ixrK1hYcSKc72UFi1Zea9GsPs4=; b=a
	dfgZ2b194VHNC5BhqDXzevb/6C1bvKDxIRgD8peaVdfrLQ0/xPc0NR6mVFU54QkP
	bpDy9+gt4d20Yut9AbU81ga6NJTco+7FQFwL8gbXWs7gCjp3bKeeG47UEgeUTZEo
	pJzWRF88yChuXdv/T2Yywy7gOllkQFisacCDmi0unmv9oiOtYdollbZ8Lh4znXko
	FmVqgrsohEhhW/M+UvpisuonukrLVMYinhlYouNsydGQZiiq4yQiITrtC+OCn8ag
	yGGPaHIq9zA8tofvWEqWTSMbXqWk+OQkQDLsGPUp7MjYzwGoXXoAPa4rHz2cB68H
	oJvp59Vut/UsXwYAx2tGQ==
X-ME-Sender: <xms:dl-UaGxYSE5_1jPTLzo7_gWpVWCspfbq5KH3e9lO-j1KYcRhtX3irw>
    <xme:dl-UaFi2TLQ_gK4DOekOlt-3bMCr0B7ZwtXVCF3oFZ9rcrAWo2qYeRiUpB2HQjof5
    mYj5OP6N8R7_k2vng>
X-ME-Received: <xmr:dl-UaBw3ZwLpOp8607bf9dCeyxByD23xgSMd4zTGG-FhScmKn1ghHW6LreVhzFZ9C_UTdw5h-gbP8_rXQl5ElykdnDF3R-rRWL9oAke23Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:dl-UaIIap0FUUqNYq3J1f0S6jxa7zBiCCbY0lWExIY8ctzsrj3qh_A>
    <xmx:dl-UaISWYExhpjol3DJhXDZ-RTkpleQbICjJQkcTmB37j3kZecfZJA>
    <xmx:dl-UaAq43fOSJDTVfLYqn5mlXNDINxRtf5slldVbb6rIZqRfpT9yuA>
    <xmx:dl-UaNoYJ8H2JDvxhLMJ9QoazCsZFCZhpqpjKrx_o_evcPE4RiVHyA>
    <xmx:dl-UaKU2DZEZWQwxuYcqwohaY7-k9xqV7w1a2GE9n8a7YVwepNW32btY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ee30184 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:59 +0200
Subject: [PATCH v2 9/9] midx: compute paths via their source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-9-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

With the preceding commits we started to always have the object database
source available when we load, write or access multi-pack indices. With
this in place we can change how MIDX paths are computed so that we don't
have to pass in the combination of a hash algorithm and object directory
anymore, but only the object database source.

Refactor the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx-write.c    | 52 ++++++++++++++++++++++++----------------------------
 midx.c          | 54 +++++++++++++++++++++++++-----------------------------
 midx.h          | 13 +++++--------
 pack-bitmap.c   | 10 ++++------
 pack-revindex.c |  8 ++++----
 5 files changed, 62 insertions(+), 75 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 84f76856d6..1dcdf3dc0f 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -26,9 +26,9 @@
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
 
 extern int midx_checksum_valid(struct multi_pack_index *m);
-extern void clear_midx_files_ext(const char *object_dir, const char *ext,
+extern void clear_midx_files_ext(struct odb_source *source, const char *ext,
 				 const char *keep_hash);
-extern void clear_incremental_midx_files_ext(const char *object_dir,
+extern void clear_incremental_midx_files_ext(struct odb_source *source,
 					     const char *ext,
 					     const char **keep_hashes,
 					     uint32_t hashes_nr);
@@ -112,6 +112,7 @@ struct write_midx_context {
 	struct string_list *to_include;
 
 	struct repository *repo;
+	struct odb_source *source;
 };
 
 static int should_include_pack(const struct write_midx_context *ctx,
@@ -648,7 +649,6 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 }
 
 static void write_midx_reverse_index(struct write_midx_context *ctx,
-				     const char *object_dir,
 				     unsigned char *midx_hash)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -657,11 +657,10 @@ static void write_midx_reverse_index(struct write_midx_context *ctx,
 	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
 
 	if (ctx->incremental)
-		get_split_midx_filename_ext(ctx->repo->hash_algo, &buf,
-					    object_dir, midx_hash,
-					    MIDX_EXT_REV);
+		get_split_midx_filename_ext(ctx->source, &buf,
+					    midx_hash, MIDX_EXT_REV);
 	else
-		get_midx_filename_ext(ctx->repo->hash_algo, &buf, object_dir,
+		get_midx_filename_ext(ctx->source, &buf,
 				      midx_hash, MIDX_EXT_REV);
 
 	tmp_file = write_rev_file_order(ctx->repo, NULL, ctx->pack_order,
@@ -836,7 +835,6 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 }
 
 static int write_midx_bitmap(struct write_midx_context *ctx,
-			     const char *object_dir,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
@@ -852,12 +850,11 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	trace2_region_enter("midx", "write_midx_bitmap", ctx->repo);
 
 	if (ctx->incremental)
-		get_split_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
-					    object_dir, midx_hash,
-					    MIDX_EXT_BITMAP);
+		get_split_midx_filename_ext(ctx->source, &bitmap_name,
+					    midx_hash, MIDX_EXT_BITMAP);
 	else
-		get_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
-				      object_dir, midx_hash, MIDX_EXT_BITMAP);
+		get_midx_filename_ext(ctx->source, &bitmap_name,
+				      midx_hash, MIDX_EXT_BITMAP);
 
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
@@ -981,11 +978,9 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
 		const unsigned char *hash = get_midx_checksum(m);
 
-		get_midx_filename_ext(m->source->odb->repo->hash_algo, &from,
-				      m->source->path,
+		get_midx_filename_ext(m->source, &from,
 				      hash, midx_exts[i].non_split);
-		get_split_midx_filename_ext(m->source->odb->repo->hash_algo, &to,
-					    m->source->path, hash,
+		get_split_midx_filename_ext(m->source, &to, hash,
 					    midx_exts[i].split);
 
 		if (link(from.buf, to.buf) < 0 && errno != ENOENT) {
@@ -1023,16 +1018,16 @@ static void clear_midx_files(struct odb_source *source,
 	uint32_t i, j;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		clear_incremental_midx_files_ext(source->path, exts[i],
+		clear_incremental_midx_files_ext(source, exts[i],
 						 hashes, hashes_nr);
 		for (j = 0; j < hashes_nr; j++)
-			clear_midx_files_ext(source->path, exts[i], hashes[j]);
+			clear_midx_files_ext(source, exts[i], hashes[j]);
 	}
 
 	if (incremental)
-		get_midx_filename(source->odb->repo->hash_algo, &buf, source->path);
+		get_midx_filename(source, &buf);
 	else
-		get_midx_chain_filename(&buf, source->path);
+		get_midx_chain_filename(source, &buf);
 
 	if (unlink(buf.buf) && errno != ENOENT)
 		die_errno(_("failed to clear multi-pack-index at %s"), buf.buf);
@@ -1065,6 +1060,7 @@ static int write_midx_internal(struct odb_source *source,
 	trace2_region_enter("midx", "write_midx_internal", r);
 
 	ctx.repo = r;
+	ctx.source = source;
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
 
@@ -1073,7 +1069,7 @@ static int write_midx_internal(struct odb_source *source,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
 			    source->path);
 	else
-		get_midx_filename(r->hash_algo, &midx_name, source->path);
+		get_midx_filename(source, &midx_name);
 	if (safe_create_leading_directories(r, midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
@@ -1153,7 +1149,7 @@ static int write_midx_internal(struct odb_source *source,
 			 * corresponding bitmap (or one wasn't requested).
 			 */
 			if (!want_bitmap)
-				clear_midx_files_ext(source->path, "bitmap", NULL);
+				clear_midx_files_ext(source, "bitmap", NULL);
 			goto cleanup;
 		}
 	}
@@ -1321,7 +1317,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (ctx.incremental) {
 		struct strbuf lock_name = STRBUF_INIT;
 
-		get_midx_chain_filename(&lock_name, source->path);
+		get_midx_chain_filename(source, &lock_name);
 		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
 		strbuf_release(&lock_name);
 
@@ -1384,7 +1380,7 @@ static int write_midx_internal(struct odb_source *source,
 
 	if (flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
-		write_midx_reverse_index(&ctx, source->path, midx_hash);
+		write_midx_reverse_index(&ctx, midx_hash);
 
 	if (flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
@@ -1407,7 +1403,7 @@ static int write_midx_internal(struct odb_source *source,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(&ctx, source->path,
+		if (write_midx_bitmap(&ctx,
 				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
@@ -1440,8 +1436,8 @@ static int write_midx_internal(struct odb_source *source,
 		if (link_midx_to_chain(ctx.base_midx) < 0)
 			return -1;
 
-		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
-					    source->path, midx_hash, MIDX_EXT_MIDX);
+		get_split_midx_filename_ext(source, &final_midx_name,
+					    midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
diff --git a/midx.c b/midx.c
index 81bf3c4d5f..7726c13d7e 100644
--- a/midx.c
+++ b/midx.c
@@ -16,9 +16,9 @@
 #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
 
 int midx_checksum_valid(struct multi_pack_index *m);
-void clear_midx_files_ext(const char *object_dir, const char *ext,
+void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash);
-void clear_incremental_midx_files_ext(const char *object_dir, const char *ext,
+void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
 				      char **keep_hashes,
 				      uint32_t hashes_nr);
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
@@ -29,19 +29,17 @@ const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
 
-void get_midx_filename(const struct git_hash_algo *hash_algo,
-		       struct strbuf *out, const char *object_dir)
+void get_midx_filename(struct odb_source *source, struct strbuf *out)
 {
-	get_midx_filename_ext(hash_algo, out, object_dir, NULL, NULL);
+	get_midx_filename_ext(source, out, NULL, NULL);
 }
 
-void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
-			   struct strbuf *out, const char *object_dir,
+void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext)
 {
-	strbuf_addf(out, "%s/pack/multi-pack-index", object_dir);
+	strbuf_addf(out, "%s/pack/multi-pack-index", source->path);
 	if (ext)
-		strbuf_addf(out, "-%s.%s", hash_to_hex_algop(hash, hash_algo), ext);
+		strbuf_addf(out, "-%s.%s", hash_to_hex_algop(hash, source->odb->repo->hash_algo), ext);
 }
 
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
@@ -222,24 +220,23 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 	return NULL;
 }
 
-void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir)
+void get_midx_chain_dirname(struct odb_source *source, struct strbuf *buf)
 {
-	strbuf_addf(buf, "%s/pack/multi-pack-index.d", object_dir);
+	strbuf_addf(buf, "%s/pack/multi-pack-index.d", source->path);
 }
 
-void get_midx_chain_filename(struct strbuf *buf, const char *object_dir)
+void get_midx_chain_filename(struct odb_source *source, struct strbuf *buf)
 {
-	get_midx_chain_dirname(buf, object_dir);
+	get_midx_chain_dirname(source, buf);
 	strbuf_addstr(buf, "/multi-pack-index-chain");
 }
 
-void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
-				 struct strbuf *buf, const char *object_dir,
+void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext)
 {
-	get_midx_chain_dirname(buf, object_dir);
+	get_midx_chain_dirname(source, buf);
 	strbuf_addf(buf, "/multi-pack-index-%s.%s",
-		    hash_to_hex_algop(hash, hash_algo), ext);
+		    hash_to_hex_algop(hash, source->odb->repo->hash_algo), ext);
 }
 
 static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
@@ -326,7 +323,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source *source,
 		valid = 0;
 
 		strbuf_reset(&buf);
-		get_split_midx_filename_ext(hash_algo, &buf, source->path,
+		get_split_midx_filename_ext(source, &buf,
 					    layer.hash, MIDX_EXT_MIDX);
 		m = load_multi_pack_index_one(source, buf.buf);
 
@@ -358,7 +355,7 @@ static struct multi_pack_index *load_multi_pack_index_chain(struct odb_source *s
 	int fd;
 	struct multi_pack_index *m = NULL;
 
-	get_midx_chain_filename(&chain_file, source->path);
+	get_midx_chain_filename(source, &chain_file);
 	if (open_multi_pack_index_chain(source->odb->repo->hash_algo, chain_file.buf, &fd, &st)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
@@ -374,8 +371,7 @@ struct multi_pack_index *load_multi_pack_index(struct odb_source *source)
 	struct strbuf midx_name = STRBUF_INIT;
 	struct multi_pack_index *m;
 
-	get_midx_filename(source->odb->repo->hash_algo, &midx_name,
-			  source->path);
+	get_midx_filename(source, &midx_name);
 
 	m = load_multi_pack_index_one(source, midx_name.buf);
 	if (!m)
@@ -762,7 +758,7 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
 		die_errno(_("failed to remove %s"), full_path);
 }
 
-void clear_midx_files_ext(const char *object_dir, const char *ext,
+void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash)
 {
 	struct clear_midx_data data;
@@ -776,7 +772,7 @@ void clear_midx_files_ext(const char *object_dir, const char *ext,
 	}
 	data.ext = ext;
 
-	for_each_file_in_pack_dir(object_dir,
+	for_each_file_in_pack_dir(source->path,
 				  clear_midx_file_ext,
 				  &data);
 
@@ -785,7 +781,7 @@ void clear_midx_files_ext(const char *object_dir, const char *ext,
 	free(data.keep);
 }
 
-void clear_incremental_midx_files_ext(const char *object_dir, const char *ext,
+void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
 				      char **keep_hashes,
 				      uint32_t hashes_nr)
 {
@@ -801,7 +797,7 @@ void clear_incremental_midx_files_ext(const char *object_dir, const char *ext,
 	data.keep_nr = hashes_nr;
 	data.ext = ext;
 
-	for_each_file_in_pack_subdir(object_dir, "multi-pack-index.d",
+	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
 
 	for (i = 0; i < hashes_nr; i++)
@@ -813,7 +809,7 @@ void clear_midx_file(struct repository *r)
 {
 	struct strbuf midx = STRBUF_INIT;
 
-	get_midx_filename(r->hash_algo, &midx, r->objects->sources->path);
+	get_midx_filename(r->objects->sources, &midx);
 
 	if (r->objects) {
 		struct odb_source *source;
@@ -828,8 +824,8 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(r->objects->sources->path, MIDX_EXT_BITMAP, NULL);
-	clear_midx_files_ext(r->objects->sources->path, MIDX_EXT_REV, NULL);
+	clear_midx_files_ext(r->objects->sources, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(r->objects->sources, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
@@ -888,7 +884,7 @@ int verify_midx_file(struct odb_source *source, unsigned flags)
 		struct stat sb;
 		struct strbuf filename = STRBUF_INIT;
 
-		get_midx_filename(r->hash_algo, &filename, source->path);
+		get_midx_filename(source, &filename);
 
 		if (!stat(filename.buf, &sb)) {
 			error(_("multi-pack-index file exists, but failed to parse"));
diff --git a/midx.h b/midx.h
index 71dbdec66e..e241d2d690 100644
--- a/midx.h
+++ b/midx.h
@@ -86,15 +86,12 @@ struct multi_pack_index {
 #define MIDX_EXT_MIDX "midx"
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
-void get_midx_filename(const struct git_hash_algo *hash_algo,
-		       struct strbuf *out, const char *object_dir);
-void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
-			   struct strbuf *out, const char *object_dir,
+void get_midx_filename(struct odb_source *source, struct strbuf *out);
+void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
-void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
-void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
-void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
-				 struct strbuf *buf, const char *object_dir,
+void get_midx_chain_dirname(struct odb_source *source, struct strbuf *out);
+void get_midx_chain_filename(struct odb_source *source, struct strbuf *out);
+void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext);
 
 struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 01e14c34bd..058bdb5d7d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -418,13 +418,12 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (midx->has_chain)
-		get_split_midx_filename_ext(midx->source->odb->repo->hash_algo, &buf,
-					    midx->source->path,
+		get_split_midx_filename_ext(midx->source, &buf,
 					    get_midx_checksum(midx),
 					    MIDX_EXT_BITMAP);
 	else
-		get_midx_filename_ext(midx->source->odb->repo->hash_algo, &buf,
-				      midx->source->path, get_midx_checksum(midx),
+		get_midx_filename_ext(midx->source, &buf,
+				      get_midx_checksum(midx),
 				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
@@ -463,8 +462,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
-		get_midx_filename(midx->source->odb->repo->hash_algo, &buf,
-				  midx->source->path);
+		get_midx_filename(midx->source, &buf);
 		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
 				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
diff --git a/pack-revindex.c b/pack-revindex.c
index b206518dcb..d0791cc493 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -389,12 +389,12 @@ int load_midx_revindex(struct multi_pack_index *m)
 			   "source", "rev");
 
 	if (m->has_chain)
-		get_split_midx_filename_ext(m->source->odb->repo->hash_algo, &revindex_name,
-					    m->source->path, get_midx_checksum(m),
+		get_split_midx_filename_ext(m->source, &revindex_name,
+					    get_midx_checksum(m),
 					    MIDX_EXT_REV);
 	else
-		get_midx_filename_ext(m->source->odb->repo->hash_algo, &revindex_name,
-				      m->source->path, get_midx_checksum(m),
+		get_midx_filename_ext(m->source, &revindex_name,
+				      get_midx_checksum(m),
 				      MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,

-- 
2.51.0.rc0.215.g125493bb4a.dirty

