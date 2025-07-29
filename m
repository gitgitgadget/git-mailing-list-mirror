Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775A1DFDAB
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798385; cv=none; b=tTi0KzP7rB3qOg1CdPvSwMHDNmkwv0i3VmpedQbK+9h9S6bWrT/FcBzTbihvWZnylKO2DCP6cFkqo6neyPv+2Prm3vAdENhcg2Cu+FXoxLrTjZLVTbDZpnAJViZJj5xfkSGeO9KD4p5u5jIMTvdHkslLBzzv+oZnfEfEQ80r27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798385; c=relaxed/simple;
	bh=J2Q39FO/BSeVOWtsRL+zV5okTKJo7gSVB1V5Yr+C/y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gzq+S0pEfvh0X3zHXHZUTYlfDgvO+jaCd0x2gmdW8vbtPh82eqWm8xevKSc/cpTVbWS7IfWFQHziDgfKo8JeYDDlQ5nsGHgaRH2F/Y6d4YyKXI/2XNMkVdIdr9F/RWBq3Q0LZUQ71K3oveydbSV58icGW0UQT3cCHgokxJRklCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cQ4GlZvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VXPZRJ0v; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cQ4GlZvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VXPZRJ0v"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5D407A0392;
	Tue, 29 Jul 2025 10:13:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 29 Jul 2025 10:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753798382;
	 x=1753884782; bh=lbeYi6jWe/wp/Gkb4ZvRXw392FRUMHFz7lIjpIKWkZ4=; b=
	cQ4GlZvQ+1KdX/fosH3A5sM0pv2WtEtA5O2NxPFIOJnaJEOaTHwDYrZizZZLX3Pd
	NDYcPsaB4u2e6lj9n3jCrahs+ctwJPz6tBqolhS3mxn6ADGHEoTcPy9NhSI4Vu7L
	dzsx8T1UtUHkhNUhJi18+Hblnkye75JSmSFgLgq/uOrKTEuINSgFNjG0XEgMzGah
	Y9IeOv414Uv/GgpwhqpKNTeXrl01yTExyiKdRXEo42NU8xickahpoTK36/vNoe9h
	gilKia/J1UNI1lYqhSDr5L61Xm0RTDUWRPBYuk5WthdoGkTgyrF9lDnMPTBUngP/
	6LND4OWTRldTt3f0oyLD4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753798382; x=
	1753884782; bh=lbeYi6jWe/wp/Gkb4ZvRXw392FRUMHFz7lIjpIKWkZ4=; b=V
	XPZRJ0vG2VwURLB/f/NThMfO2IJchnGdQqf4t+0NnqXBgTDbrywEopcWAhJH1z4y
	E4YxtIxt7IYzagITh008BwRtC5tpBdjq2LNganBe5KLtoBiGPePBAUxcYkxxKAUx
	HekD91VARtPtdrs1WZUJaV3Ou8HmBLzdaFE1AePEHj+BoAgLnoyG9HkFFjli/xsy
	qgDd32X4MqAo5T4E6EI14UkhITIDOWgkwOjvdtFjGArvfKevB5EV+QWJ9fXuIdqR
	2KTc9a0naPM9Ep5NJeEUdi2owiYB51koYlnb4V812jpo5Xak0XsRMAbLeuitajv7
	k2iVb5t522yzhBWmpq1Fg==
X-ME-Sender: <xms:7taIaJ-wi7-gyAdiR33-CJGYSKA_Fz0RGsGgmXLCKeFvrUPfOhTIZw>
    <xme:7taIaN4DBvh5VemgLlhaH5LQvnsQtmFK-zThinmc84OOx7w12P2t15MdpbBketRX-
    B_RmnT8nal4aBDLzA>
X-ME-Received: <xmr:7taIaI1iiz4vIUMYM-zj2Td5wRXgeFpzSBEg4s4RoX_q7MeCDf0vV8pwmqa8ht54ENqqJZWZ39a_DM5P6G6zXYZgJ2glUEmcmsqRL0oURP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7taIaMAhpuX9dJirfFK7ptwg4yyRAKIACS-dWKUONLILQFcKISh3JA>
    <xmx:7taIaC3KpkSSvIL4MXITaLXLRX60WQ1OrlHCNNgx0sPDgv581Dm7Tw>
    <xmx:7taIaOs1uVfNY1Z5G6fzFeBnq9OayMVtitnevWInIEluOh6s6i1apA>
    <xmx:7taIaK4Ow_BmYjU2TH6f4r7y6zXevIZKFPX8gSj23D36TKiHeY51Eg>
    <xmx:7taIaIwvsv5mGMhLHymP9kYY4OdVMsq692Co8rC4EryRd-XLqGVvp3JQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 10:13:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c9127e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 14:13:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 16:12:45 +0200
Subject: [PATCH 6/8] midx: write multi-pack indices via their source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-pks-midx-deduplicate-source-info-v1-6-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Similar to the preceding commit, refactor the writing side of multi-pack
indices so that we pass in the object database source where the index
should be written to.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/multi-pack-index.c | 19 +++++++------
 builtin/repack.c           |  2 +-
 midx-write.c               | 69 +++++++++++++++++++++-------------------------
 midx.h                     |  8 +++---
 4 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index e4a9305af3..b1e971e535 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -147,6 +147,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			     N_("refs snapshot for selecting bitmap commits")),
 		OPT_END(),
 	};
+	struct odb_source *source;
 	int ret;
 
 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
@@ -165,7 +166,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
-	handle_object_dir_option(repo);
+	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
 
@@ -174,7 +175,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(repo, opts.object_dir, &packs,
+		ret = write_midx_file_only(source, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot, opts.flags);
 
@@ -185,7 +186,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(repo, opts.object_dir, opts.preferred_pack,
+	ret = write_midx_file(source, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
@@ -233,6 +234,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
+	struct odb_source *source;
+
 	options = add_common_options(builtin_multi_pack_index_expire_options);
 
 	trace2_cmd_mode(argv[0]);
@@ -245,11 +248,11 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
-	handle_object_dir_option(the_repository);
+	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
+	return expire_midx_packs(source, opts.flags);
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
@@ -264,6 +267,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 		  N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
+	struct odb_source *source;
 
 	options = add_common_options(builtin_multi_pack_index_repack_options);
 
@@ -278,12 +282,11 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_repack_usage,
 				   options);
-	handle_object_dir_option(the_repository);
+	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	return midx_repack(the_repository, opts.object_dir,
-			   (size_t)opts.batch_size, opts.flags);
+	return midx_repack(source, (size_t)opts.batch_size, opts.flags);
 }
 
 int cmd_multi_pack_index(int argc,
diff --git a/builtin/repack.c b/builtin/repack.c
index 21723866b9..94dec26f18 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1711,7 +1711,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(the_repository, repo_get_object_directory(the_repository),
+		write_midx_file(the_repository->objects->sources,
 				NULL, NULL, flags);
 	}
 
diff --git a/midx-write.c b/midx-write.c
index 37a0b1682f..bf7c01d4b1 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -913,15 +913,6 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	return ret;
 }
 
-static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
-							const char *object_dir)
-{
-	struct odb_source *source = odb_find_source(r->objects, object_dir);
-	if (!source)
-		die(_("could not find object directory matching %s"), object_dir);
-	return get_multi_pack_index(source);
-}
-
 static int fill_packs_from_midx(struct write_midx_context *ctx,
 				const char *preferred_pack_name, uint32_t flags)
 {
@@ -1012,7 +1003,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	return ret;
 }
 
-static void clear_midx_files(struct repository *r, const char *object_dir,
+static void clear_midx_files(struct odb_source *source,
 			     const char **hashes, uint32_t hashes_nr,
 			     unsigned incremental)
 {
@@ -1031,16 +1022,16 @@ static void clear_midx_files(struct repository *r, const char *object_dir,
 	uint32_t i, j;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		clear_incremental_midx_files_ext(object_dir, exts[i],
+		clear_incremental_midx_files_ext(source->path, exts[i],
 						 hashes, hashes_nr);
 		for (j = 0; j < hashes_nr; j++)
-			clear_midx_files_ext(object_dir, exts[i], hashes[j]);
+			clear_midx_files_ext(source->path, exts[i], hashes[j]);
 	}
 
 	if (incremental)
-		get_midx_filename(r->hash_algo, &buf, object_dir);
+		get_midx_filename(source->odb->repo->hash_algo, &buf, source->path);
 	else
-		get_midx_chain_filename(&buf, object_dir);
+		get_midx_chain_filename(&buf, source->path);
 
 	if (unlink(buf.buf) && errno != ENOENT)
 		die_errno(_("failed to clear multi-pack-index at %s"), buf.buf);
@@ -1048,13 +1039,14 @@ static void clear_midx_files(struct repository *r, const char *object_dir,
 	strbuf_release(&buf);
 }
 
-static int write_midx_internal(struct repository *r, const char *object_dir,
+static int write_midx_internal(struct odb_source *source,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       const char *refs_snapshot,
 			       unsigned flags)
 {
+	struct repository *r = source->odb->repo;
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t i, start_pack;
@@ -1078,15 +1070,15 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
-			    object_dir);
+			    source->path);
 	else
-		get_midx_filename(r->hash_algo, &midx_name, object_dir);
+		get_midx_filename(r->hash_algo, &midx_name, source->path);
 	if (safe_create_leading_directories(r, midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
 	if (!packs_to_include || ctx.incremental) {
-		struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
+		struct multi_pack_index *m = get_multi_pack_index(source);
 		if (m && !midx_checksum_valid(m)) {
 			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 			m = NULL;
@@ -1140,7 +1132,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	ctx.to_include = packs_to_include;
 
-	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
+	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
 	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
@@ -1160,7 +1152,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 * corresponding bitmap (or one wasn't requested).
 			 */
 			if (!want_bitmap)
-				clear_midx_files_ext(object_dir, "bitmap", NULL);
+				clear_midx_files_ext(source->path, "bitmap", NULL);
 			goto cleanup;
 		}
 	}
@@ -1328,7 +1320,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (ctx.incremental) {
 		struct strbuf lock_name = STRBUF_INIT;
 
-		get_midx_chain_filename(&lock_name, object_dir);
+		get_midx_chain_filename(&lock_name, source->path);
 		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
 		strbuf_release(&lock_name);
 
@@ -1391,7 +1383,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	if (flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
-		write_midx_reverse_index(&ctx, object_dir, midx_hash);
+		write_midx_reverse_index(&ctx, source->path, midx_hash);
 
 	if (flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
@@ -1414,7 +1406,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(&ctx, object_dir,
+		if (write_midx_bitmap(&ctx, source->path,
 				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
@@ -1448,7 +1440,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			return -1;
 
 		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
-					    object_dir, midx_hash, MIDX_EXT_MIDX);
+					    source->path, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
@@ -1481,7 +1473,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(r, object_dir, keep_hashes,
+	clear_midx_files(source, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
 
@@ -1510,29 +1502,29 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	return result;
 }
 
-int write_midx_file(struct repository *r, const char *object_dir,
+int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
 		    const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(r, object_dir, NULL, NULL,
+	return write_midx_internal(source, NULL, NULL,
 				   preferred_pack_name, refs_snapshot,
 				   flags);
 }
 
-int write_midx_file_only(struct repository *r, const char *object_dir,
+int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(r, object_dir, packs_to_include, NULL,
+	return write_midx_internal(source, packs_to_include, NULL,
 				   preferred_pack_name, refs_snapshot, flags);
 }
 
-int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
+int expire_midx_packs(struct odb_source *source, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
-	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
+	struct multi_pack_index *m = get_multi_pack_index(source);
 	struct progress *progress = NULL;
 
 	if (!m)
@@ -1545,7 +1537,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(
-					  r,
+					  source->odb->repo,
 					  _("Counting referenced objects"),
 					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
@@ -1557,7 +1549,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(
-					  r,
+					  source->odb->repo,
 					  _("Finding and deleting unreferenced packfiles"),
 					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
@@ -1585,7 +1577,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(r, object_dir, NULL,
+		result = write_midx_internal(source, NULL,
 					     &packs_to_drop, NULL, NULL, flags);
 
 	string_list_clear(&packs_to_drop, 0);
@@ -1710,14 +1702,15 @@ static void fill_included_packs_batch(struct repository *r,
 	free(pack_info);
 }
 
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
+int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 {
+	struct repository *r = source->odb->repo;
 	int result = 0;
 	uint32_t i, packs_to_repack = 0;
 	unsigned char *include_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
-	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
+	struct multi_pack_index *m = get_multi_pack_index(source);
 
 	/*
 	 * When updating the default for these configuration
@@ -1751,7 +1744,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	strvec_push(&cmd.args, "pack-objects");
 
-	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
+	strvec_pushf(&cmd.args, "%s/pack/pack", source->path);
 
 	if (delta_base_offset)
 		strvec_push(&cmd.args, "--delta-base-offset");
@@ -1792,7 +1785,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(r, object_dir, NULL, NULL, NULL, NULL,
+	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
 				     flags);
 
 cleanup:
diff --git a/midx.h b/midx.h
index 970d043989..d162001fbb 100644
--- a/midx.h
+++ b/midx.h
@@ -126,17 +126,17 @@ int prepare_multi_pack_index_one(struct odb_source *source);
  * Variant of write_midx_file which writes a MIDX containing only the packs
  * specified in packs_to_include.
  */
-int write_midx_file(struct repository *r, const char *object_dir,
+int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name, const char *refs_snapshot,
 		    unsigned flags);
-int write_midx_file_only(struct repository *r, const char *object_dir,
+int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct odb_source *source, unsigned flags);
-int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags);
+int expire_midx_packs(struct odb_source *source, unsigned flags);
+int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags);
 
 void close_midx(struct multi_pack_index *m);
 

-- 
2.50.1.619.g074bbf1d35.dirty

