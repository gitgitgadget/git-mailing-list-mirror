Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5D2DEA93
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959614; cv=none; b=hHmMlr55+81/yyH8bK6VS7K8vLEyMcYhIQPlYkzBwLHjhouF/P60986D0v8z9t5PQL0SpRWtx1VFyxxQ9DE9HIMLk627F6/PofxiflPY1m8k8KOF4fPATgQ5N28U69K4pDyjy0IpRgEenyLQKAZCvrE1I2e9Lv7QdDE7kPwW1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959614; c=relaxed/simple;
	bh=1+H/vDlIR43pDw7H7Ayo5BQ8jA8e1GRaE5dhyVtPBpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdGr2817kbXzRsYyRg4/Do1iAWaPtWoXoO1GRcbnbRw+y5GQCsVYUdzf5xQ2qCfZFOJJIahOp6JsNNunkwoRQT29P8xAK2KJ1y+3D4cA36xVcNv6vA2TBApScar4jp9lMUZ+1HN0K+OUM3hM5pRIk/ZiOOdooT7bUlcLCP0T/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pVAdwfVf; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pVAdwfVf"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-897002b7576so77465566d6.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959612; x=1772564412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kd8UF45CtnOA3el+hycV59pJzgGT6LaMd0hfSjJnEnA=;
        b=pVAdwfVfzBE+7Z8U/zT3BjXVjdv8LkCzl3WOED49jIpDZRbZ3Ai9u3NKG8Xs18410S
         oRyJnehl0zZ95uZQClDxtmHP4khNHnsdVaZgIM3QZ7uZEv30fL5dBgFE7aiu2+1/nUMW
         DPOPOI8048mRRtv/Zr6kRDZcGkVgp2UCrIA1JelRSf2bhLgKLFBNpxtbn9ptC5KtqGdL
         FWQCE31KJBUYLffDvY5+vxFgGZNJwAf4s9vFtYigHQUiR5Spt4kURMEt+xhcWkp2wOYv
         J98wBCy3F5y+tYFSBBmYtxGafRd+QsI/iZFTk2g6cUqWIjXzMepIebAV6CMDcCtCNXy2
         NL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959612; x=1772564412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd8UF45CtnOA3el+hycV59pJzgGT6LaMd0hfSjJnEnA=;
        b=qszGrqjPijopLKfcuysZQlh48G79gz3ku9PEF72Iy6uqOkOxC0ZJd646+P5MJM7+L8
         7wcfnoZmsV9Cf5/fhf0tmAG2DmQr5nLnI6AcXWwW8TE8bRWXMT+HqmO+qJ1YqFzulgj/
         4JlAl+ptMRVPrWaleyOo/8QGZjlccQNQbdnSwtkEfEG09BneSIb1JmaiNZ7sgbXKlLlb
         /qSflb3e1D8Uk0LX4NX5OAPAROWm5rbyaBB0UVWLQsgIqcyLZgRBguBSfPcz1qvyLwDy
         OA3nNLXv2Y47fUydvwoj3Oc7X4AGT+VFg5paZFHmdwH75nvRmPYeRZB7kQhDaKyG6ahY
         VhZQ==
X-Gm-Message-State: AOJu0YyGBK1fY/kyZW9N7XvS/GtFLVuHJQRyjjwcCL/pOEFE5E+EGitE
	uvmioFyT0kI96K4UlSbUUP2DSK+M6qyThnpghk/czZ7f/OwrABE2fVxU8gt1Ylsk3DZAcDwlID/
	WA/+KDm537/uB
X-Gm-Gg: AZuq6aIzRzTAhEvcXerylThsQykuwLv0JFZGeGjsKY6cG7GtddVM8CuotW23h4UM5x3
	MBwLiT+TplFEuBh9srF5qfLXoOhuA5g/Yr5hiawtA2yn4vWc/4LxyZ5Wyfqhma4vIPw2j/uh+vL
	H85rBX793lJPlRwFsIB1w/U+80IvvL42NiAM7s2xGBwrFrsP6j+ET3We3EyDyI4n5byLyQ4oETw
	oqZBrmc4SNEyYf52Xl+dX3u0w1z+2EsfbzGicfOYCodxt2TFp34VHXDbpbn3qysIiSpYiKayqF7
	m53nB4Pezx7CsgTg3kEv/emdk7fylp2nZYLwgxqMvue32MeNFNKrEeUfNsoPJrz2pzAjvCiXnfy
	xHam2nX8lwfTDeea+nRz5Cz/b5PTQDf54+NtipTyiT/yHKeih4gvbL9EHkmi3R/gG1dxtyx9ykF
	lEooFVM4wkwImfzR4qyk/8ftooMNBbKyyVFSQFhCVeJWPfF/2YqkAiTM9rd2yNI97oPIRbiD0bh
	LwLYekKuaXoYwRibK222ZFa2IVUzg==
X-Received: by 2002:a05:622a:4c9:b0:4f3:59c1:768c with SMTP id d75a77b69052e-5070bcbce40mr173998861cf.60.1771959611644;
        Tue, 24 Feb 2026 11:00:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50cee9sm102363041cf.2.2026.02.24.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:11 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/17] midx-write.c: introduce `struct write_midx_opts`
Message-ID: <132e823e758418f0d8b930940b2c836118692dae.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

In the MIDX writing code, there are four functions which perform some
sort of MIDX write operation. They are:

 - write_midx_file()
 - write_midx_file_only()
 - expire_midx_packs()
 - midx_repack()

All of these functions are thin wrappers over `write_midx_internal()`,
which implements the bulk of these routines. As a result, the
`write_midx_internal()` function takes six arguments.

Future commits in this series will want to add additional arguments, and
in general this function's signature will be the union of parameters
among *all* possible ways to write a MIDX.

Instead of adding yet more arguments to this function to support MIDX
compaction, introduce a `struct write_midx_opts`, which has the same
struct members as `write_midx_internal()`'s arguments.

Adding additional fields to the `write_midx_opts` struct is preferable
to adding additional arguments to `write_midx_internal()`. This is
because the callers below all zero-initialize the struct, so each time
we add a new piece of information, we do not have to pass the zero value
for it in all other call-sites that do not care about it.

For now, no functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 135 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 81 insertions(+), 54 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index da9c5a7c295..8a54644e427 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1078,14 +1078,20 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 	return needed;
 }
 
-static int write_midx_internal(struct odb_source *source,
-			       struct string_list *packs_to_include,
-			       struct string_list *packs_to_drop,
-			       const char *preferred_pack_name,
-			       const char *refs_snapshot,
-			       unsigned flags)
+struct write_midx_opts {
+	struct odb_source *source; /* non-optional */
+
+	struct string_list *packs_to_include;
+	struct string_list *packs_to_drop;
+
+	const char *preferred_pack_name;
+	const char *refs_snapshot;
+	unsigned flags;
+};
+
+static int write_midx_internal(struct write_midx_opts *opts)
 {
-	struct repository *r = source->odb->repo;
+	struct repository *r = opts->source->odb->repo;
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t start_pack;
@@ -1106,22 +1112,22 @@ static int write_midx_internal(struct odb_source *source,
 	trace2_region_enter("midx", "write_midx_internal", r);
 
 	ctx.repo = r;
-	ctx.source = source;
+	ctx.source = opts->source;
 
-	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
+	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
 
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
 			    "%s/pack/multi-pack-index.d/tmp_midx_XXXXXX",
-			    source->path);
+			    opts->source->path);
 	else
-		get_midx_filename(source, &midx_name);
+		get_midx_filename(opts->source, &midx_name);
 	if (safe_create_leading_directories(r, midx_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name.buf);
 
-	if (!packs_to_include || ctx.incremental) {
-		struct multi_pack_index *m = get_multi_pack_index(source);
+	if (!opts->packs_to_include || ctx.incremental) {
+		struct multi_pack_index *m = get_multi_pack_index(opts->source);
 		if (m && !midx_checksum_valid(m)) {
 			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 			m = NULL;
@@ -1136,7 +1142,7 @@ static int write_midx_internal(struct odb_source *source,
 			 */
 			if (ctx.incremental)
 				ctx.base_midx = m;
-			else if (!packs_to_include)
+			else if (!opts->packs_to_include)
 				ctx.m = m;
 		}
 	}
@@ -1149,7 +1155,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (ctx.incremental) {
 		struct multi_pack_index *m = ctx.base_midx;
 		while (m) {
-			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
+			if (opts->flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
 				      midx_get_checksum_hex(m));
 				goto cleanup;
@@ -1164,18 +1170,18 @@ static int write_midx_internal(struct odb_source *source,
 	start_pack = ctx.nr;
 
 	ctx.pack_paths_checked = 0;
-	if (flags & MIDX_PROGRESS)
+	if (opts->flags & MIDX_PROGRESS)
 		ctx.progress = start_delayed_progress(r,
 						      _("Adding packfiles to multi-pack-index"), 0);
 	else
 		ctx.progress = NULL;
 
-	ctx.to_include = packs_to_include;
+	ctx.to_include = opts->packs_to_include;
 
-	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
+	for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (!packs_to_drop) {
+	if (!opts->packs_to_drop) {
 		/*
 		 * If there is no MIDX then either it doesn't exist, or we're
 		 * doing a geometric repack. Try to load it from the source to
@@ -1188,7 +1194,7 @@ static int write_midx_internal(struct odb_source *source,
 		if (midx && !midx_needs_update(midx, &ctx)) {
 			struct bitmap_index *bitmap_git;
 			int bitmap_exists;
-			int want_bitmap = flags & MIDX_WRITE_BITMAP;
+			int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
 
 			bitmap_git = prepare_midx_bitmap_git(midx);
 			bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
@@ -1200,7 +1206,7 @@ static int write_midx_internal(struct odb_source *source,
 				 * corresponding bitmap (or one wasn't requested).
 				 */
 				if (!want_bitmap)
-					clear_midx_files_ext(source, "bitmap", NULL);
+					clear_midx_files_ext(ctx.source, "bitmap", NULL);
 				result = 0;
 				goto cleanup;
 			}
@@ -1215,11 +1221,11 @@ static int write_midx_internal(struct odb_source *source,
 		goto cleanup; /* nothing to do */
 	}
 
-	if (preferred_pack_name) {
+	if (opts->preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
 		for (size_t i = 0; i < ctx.nr; i++) {
-			if (!cmp_idx_or_pack_name(preferred_pack_name,
+			if (!cmp_idx_or_pack_name(opts->preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx = i;
 				break;
@@ -1228,9 +1234,9 @@ static int write_midx_internal(struct odb_source *source,
 
 		if (ctx.preferred_pack_idx == NO_PREFERRED_PACK)
 			warning(_("unknown preferred pack: '%s'"),
-				preferred_pack_name);
+				opts->preferred_pack_name);
 	} else if (ctx.nr &&
-		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
+		   (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
 		struct packed_git *oldest = ctx.info[0].p;
 		ctx.preferred_pack_idx = 0;
 
@@ -1241,7 +1247,7 @@ static int write_midx_internal(struct odb_source *source,
 		 */
 		open_pack_index(oldest);
 
-		if (packs_to_drop && packs_to_drop->nr)
+		if (opts->packs_to_drop && opts->packs_to_drop->nr)
 			BUG("cannot write a MIDX bitmap during expiration");
 
 		/*
@@ -1303,20 +1309,21 @@ static int write_midx_internal(struct odb_source *source,
 
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
-	if (packs_to_drop && packs_to_drop->nr) {
+	if (opts->packs_to_drop && opts->packs_to_drop->nr) {
 		size_t drop_index = 0;
 		int missing_drops = 0;
 
-		for (size_t i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
+		for (size_t i = 0;
+		     i < ctx.nr && drop_index < opts->packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
-					 packs_to_drop->items[drop_index].string);
+					 opts->packs_to_drop->items[drop_index].string);
 
 			if (!cmp) {
 				drop_index++;
 				ctx.info[i].expired = 1;
 			} else if (cmp > 0) {
 				error(_("did not see pack-file %s to drop"),
-				      packs_to_drop->items[drop_index].string);
+				      opts->packs_to_drop->items[drop_index].string);
 				drop_index++;
 				missing_drops++;
 				i--;
@@ -1353,8 +1360,8 @@ static int write_midx_internal(struct odb_source *source,
 	}
 
 	/* Check that the preferred pack wasn't expired (if given). */
-	if (preferred_pack_name) {
-		struct pack_info *preferred = bsearch(preferred_pack_name,
+	if (opts->preferred_pack_name) {
+		struct pack_info *preferred = bsearch(opts->preferred_pack_name,
 						      ctx.info, ctx.nr,
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
@@ -1362,7 +1369,7 @@ static int write_midx_internal(struct odb_source *source,
 			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
-					preferred_pack_name);
+					opts->preferred_pack_name);
 		}
 	}
 
@@ -1376,15 +1383,15 @@ static int write_midx_internal(struct odb_source *source,
 	}
 
 	if (!ctx.entries_nr) {
-		if (flags & MIDX_WRITE_BITMAP)
+		if (opts->flags & MIDX_WRITE_BITMAP)
 			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+		opts->flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
 	}
 
 	if (ctx.incremental) {
 		struct strbuf lock_name = STRBUF_INIT;
 
-		get_midx_chain_filename(source, &lock_name);
+		get_midx_chain_filename(opts->source, &lock_name);
 		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
 		strbuf_release(&lock_name);
 
@@ -1427,7 +1434,7 @@ static int write_midx_internal(struct odb_source *source,
 				MIDX_CHUNK_LARGE_OFFSET_WIDTH),
 			write_midx_large_offsets);
 
-	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
+	if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
 		ctx.pack_order = midx_pack_order(&ctx);
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
@@ -1445,11 +1452,11 @@ static int write_midx_internal(struct odb_source *source,
 			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & MIDX_WRITE_REV_INDEX &&
+	if (opts->flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
 		write_midx_reverse_index(&ctx, midx_hash);
 
-	if (flags & MIDX_WRITE_BITMAP) {
+	if (opts->flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
 		struct commit_stack commits = COMMIT_STACK_INIT;
 
@@ -1458,7 +1465,7 @@ static int write_midx_internal(struct odb_source *source,
 
 		prepare_midx_packing_data(&pdata, &ctx);
 
-		find_commits_for_midx_bitmap(&commits, refs_snapshot, &ctx);
+		find_commits_for_midx_bitmap(&commits, opts->refs_snapshot, &ctx);
 
 		/*
 		 * The previous steps translated the information from
@@ -1469,8 +1476,8 @@ static int write_midx_internal(struct odb_source *source,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(&ctx, midx_hash, &pdata,
-				      commits.items, commits.nr, flags) < 0) {
+		if (write_midx_bitmap(&ctx, midx_hash, &pdata, commits.items,
+				      commits.nr, opts->flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			clear_packing_data(&pdata);
 			commit_stack_clear(&commits);
@@ -1503,7 +1510,7 @@ static int write_midx_internal(struct odb_source *source,
 		if (link_midx_to_chain(ctx.base_midx) < 0)
 			goto cleanup;
 
-		get_split_midx_filename_ext(source, &final_midx_name,
+		get_split_midx_filename_ext(opts->source, &final_midx_name,
 					    midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
@@ -1536,7 +1543,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(source, keep_hashes,
+	clear_midx_files(opts->source, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
 	result = 0;
@@ -1571,9 +1578,14 @@ int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
 		    const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(source, NULL, NULL,
-				   preferred_pack_name, refs_snapshot,
-				   flags);
+	struct write_midx_opts opts = {
+		.source = source,
+		.preferred_pack_name = preferred_pack_name,
+		.refs_snapshot = refs_snapshot,
+		.flags = flags,
+	};
+
+	return write_midx_internal(&opts);
 }
 
 int write_midx_file_only(struct odb_source *source,
@@ -1581,8 +1593,15 @@ int write_midx_file_only(struct odb_source *source,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(source, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	struct write_midx_opts opts = {
+		.source = source,
+		.packs_to_include = packs_to_include,
+		.preferred_pack_name = preferred_pack_name,
+		.refs_snapshot = refs_snapshot,
+		.flags = flags,
+	};
+
+	return write_midx_internal(&opts);
 }
 
 int expire_midx_packs(struct odb_source *source, unsigned flags)
@@ -1641,9 +1660,14 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
 
 	free(count);
 
-	if (packs_to_drop.nr)
-		result = write_midx_internal(source, NULL,
-					     &packs_to_drop, NULL, NULL, flags);
+	if (packs_to_drop.nr) {
+		struct write_midx_opts opts = {
+			.source = source,
+			.packs_to_drop = &packs_to_drop,
+			.flags = flags & MIDX_PROGRESS,
+		};
+		result = write_midx_internal(&opts);
+	}
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1776,6 +1800,10 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
 	struct multi_pack_index *m = get_multi_pack_index(source);
+	struct write_midx_opts opts = {
+		.source = source,
+		.flags = flags,
+	};
 
 	/*
 	 * When updating the default for these configuration
@@ -1850,8 +1878,7 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 		goto cleanup;
 	}
 
-	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
-				     flags);
+	result = write_midx_internal(&opts);
 
 cleanup:
 	free(include_pack);
-- 
2.53.0.171.gde83996e422

