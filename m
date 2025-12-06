Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A8259CB2
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053087; cv=none; b=AG7S2EdYonA6ZUBV+xZse/4jG1VUSkadFwxlCRr91IxpWnfiOd/+r9NU/Jge1nmwGPUpPJlGNvsQYpZP94zdHwWEXJmmTlsx8SjpZWgRGyEWSTF5MQuOoW60XR2zuWCpgS14XL9jtzJ/fiSL2I8e/Oyr8bUbPQyUblV50It58D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053087; c=relaxed/simple;
	bh=7ISDkcRIDLqfLujFnz221KSSpSRx2WXdB/gJA/hGdEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLfEvumto6h6UtWapKAMg3Y0l97rwmuX6u3eGCjTG1WTkZzXQ38QYEi0whrTAEm6wLqQuJv/chL4VB2OxlrzMWPeaEpV/ZdeRaT+9ld+9XCR+Vt+VyZCqkqzrdOP74/91CL/Yw0yBDG8liGYMM4EYItsiJL+brbPlnnQK33u2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FrJx9pi6; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FrJx9pi6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f996d4e1aso3622737d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053084; x=1765657884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOHcA8tfgjRRnGP8MaUv8pTF31Trj5di8PW3PHFwHY4=;
        b=FrJx9pi6aicPTNwcyS0mbtC68sivnUJt2a5BFJRoK1tLGsw9Y3OOnjQooQlLRT+LBu
         HI+biIY6wLjC6jJcdzl5+1dTxkK8OAXZ7Q3lxAamMhtyMk4o1kTDq9fvP96iU1jxTKiR
         3QPWD/Fyn2Hqz2SGFo4x6MMDmMQRVf12ISu4drEx5I8E9VCf24vt0VUFehXIKc3IuNM3
         zDq94aEG1mvUs2xOnOUQ6rRSfAyIBi0U3VMuRILas8Hngny8AbDhylLCkt5H8/JC+/Eu
         2lkcoeajcPoQz96llNd2jUutzT9S0pLvCx4Wuqjk2NM0NsyYd7M9BNFrEclpWWYqtXY+
         kUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053084; x=1765657884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOHcA8tfgjRRnGP8MaUv8pTF31Trj5di8PW3PHFwHY4=;
        b=ecIXs1ZZGs7OCcZRIo3PUP7UYg1XjL4BR/ef66PV8V5rZmzpKG5z1HoxG7MNXlWRCb
         KRJH5HjznqiB2tA28HYZYvrLrAZHM5w7OHh0k92rXchwZ8hc7WxoyAPsHEHeDNWNatJ2
         b9P4olE3W5YqgNYqQ2DP85RHnLWYPLeaoiPxE4aOjT5a46rW4OTrPiQuUoJC1NkNvkNt
         /y3RYk8RCgOUqyNWRO+4hjxFzA5VoF3ccnFQTU0xDV3iqOdxfV0LDVKIsBQlstBOWumM
         dqW9itQBTFS0kNV8VelApwovgVkjIEdjyKwG+MfZ2vR0EbUmAnLcg8dKvr6v3CA25c2p
         HBqA==
X-Gm-Message-State: AOJu0YxXjQzBN+K0S9pf+675DrkimtJnjcltMJvJsWBc7dNJozg4hqmQ
	uaNPIne2LLKEAj41XxY1Y38eFC5Ei6L1cptxE3N9r3P1KNKGaai3gXJRF78Wd1l+R6ECGA/UkLs
	DKDKswEo=
X-Gm-Gg: ASbGncto6ppQohAwH4yLJIxgA8YVvnSKhHa/lneILktlj2kIh9bQEFR/+yHL8kgKwGB
	ahYdeadOWca6Z+kQ16wF2ofHpPFAie5hJlW14ABvh4ClZt7ZRGvGRM0CSu30dmfsTtYBIUTTpEN
	MI/1OgtYtmX/Rn8zbWkkWGEHxrXNjqMDivDzVqtvh+mudXF2T8fktdaNgwb4lAlbj8tR5rjJDWy
	rFDUgGIDV0f4L22EA3D56N9onS0KOmA8pjWbLg4yMkJpHHMVAZusiysGnTmqhLzoClgIGGq+SbE
	YBFgXVHJH8Sse3lAcYUAEhpno17hOespevOoIgmo/AndAKEslov0cN8R8sOdYnXJCoYy8W8nrmm
	4aC52As+iVblj2w7KDKnpQ81x2OMfiELdEJ01pwij6YI1ltMXOUSpO3NwbYKpfHWEjQJd4Gf+Uv
	Mvz9LO+pRXWSyoSWZTDQMXMf0CvJRnK0InpNhENOplzKXrDb7YNQ9p4RIcrRifgampyN7+3C5oi
	WYzQw87RB+7Ivn4lQ==
X-Google-Smtp-Source: AGHT+IEogIJLZ2ZBTeru2DhbllWsQFwxb88ECqbSo5om4smma/cHvlvVeUwYbZr5WA4Kf26hEcx29w==
X-Received: by 2002:a05:690e:428a:10b0:644:444f:3bb7 with SMTP id 956f58d0204a3-6444e756e35mr2248791d50.5.1765053083598;
        Sat, 06 Dec 2025 12:31:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4ae73asm31202087b3.5.2025.12.06.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:23 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/17] midx-write.c: introduce `struct write_midx_opts`
Message-ID: <47aae3bf2a83a2724aecd3314f8cc5d47e8013f1.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

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
 midx-write.c | 129 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 52 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c30f6a70d37..b262631ae45 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1014,14 +1014,20 @@ static void clear_midx_files(struct odb_source *source,
 	strbuf_release(&buf);
 }
 
-static int write_midx_internal(struct odb_source *source,
-			       struct string_list *packs_to_include,
-			       struct string_list *packs_to_drop,
-			       const char *preferred_pack_name,
-			       const char *refs_snapshot,
-			       unsigned flags)
+struct write_midx_opts {
+	struct odb_source *source;
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
@@ -1041,22 +1047,22 @@ static int write_midx_internal(struct odb_source *source,
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
@@ -1071,7 +1077,7 @@ static int write_midx_internal(struct odb_source *source,
 			 */
 			if (ctx.incremental)
 				ctx.base_midx = m;
-			else if (!packs_to_include)
+			else if (!opts->packs_to_include)
 				ctx.m = m;
 		}
 	}
@@ -1084,7 +1090,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (ctx.incremental) {
 		struct multi_pack_index *m = ctx.base_midx;
 		while (m) {
-			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
+			if (opts->flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
 				      get_midx_checksum(m));
 				goto cleanup;
@@ -1099,23 +1105,23 @@ static int write_midx_internal(struct odb_source *source,
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
 
 	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
 	    !ctx.incremental &&
-	    !(packs_to_include || packs_to_drop)) {
+	    !(opts->packs_to_include || opts->packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
-		int want_bitmap = flags & MIDX_WRITE_BITMAP;
+		int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
 
 		bitmap_git = prepare_midx_bitmap_git(ctx.m);
 		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
@@ -1127,7 +1133,8 @@ static int write_midx_internal(struct odb_source *source,
 			 * corresponding bitmap (or one wasn't requested).
 			 */
 			if (!want_bitmap)
-				clear_midx_files_ext(source, "bitmap", NULL);
+				clear_midx_files_ext(opts->source, "bitmap",
+						     NULL);
 			result = 0;
 			goto cleanup;
 		}
@@ -1138,11 +1145,11 @@ static int write_midx_internal(struct odb_source *source,
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
@@ -1151,9 +1158,9 @@ static int write_midx_internal(struct odb_source *source,
 
 		if (ctx.preferred_pack_idx == NO_PREFERRED_PACK)
 			warning(_("unknown preferred pack: '%s'"),
-				preferred_pack_name);
+				opts->preferred_pack_name);
 	} else if (ctx.nr &&
-		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
+		   (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
 		struct packed_git *oldest = ctx.info[0].p;
 		ctx.preferred_pack_idx = 0;
 
@@ -1164,7 +1171,7 @@ static int write_midx_internal(struct odb_source *source,
 		 */
 		open_pack_index(oldest);
 
-		if (packs_to_drop && packs_to_drop->nr)
+		if (opts->packs_to_drop && opts->packs_to_drop->nr)
 			BUG("cannot write a MIDX bitmap during expiration");
 
 		/*
@@ -1226,20 +1233,21 @@ static int write_midx_internal(struct odb_source *source,
 
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
@@ -1276,8 +1284,8 @@ static int write_midx_internal(struct odb_source *source,
 	}
 
 	/* Check that the preferred pack wasn't expired (if given). */
-	if (preferred_pack_name) {
-		struct pack_info *preferred = bsearch(preferred_pack_name,
+	if (opts->preferred_pack_name) {
+		struct pack_info *preferred = bsearch(opts->preferred_pack_name,
 						      ctx.info, ctx.nr,
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
@@ -1285,7 +1293,7 @@ static int write_midx_internal(struct odb_source *source,
 			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
-					preferred_pack_name);
+					opts->preferred_pack_name);
 		}
 	}
 
@@ -1299,15 +1307,15 @@ static int write_midx_internal(struct odb_source *source,
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
 
@@ -1350,7 +1358,7 @@ static int write_midx_internal(struct odb_source *source,
 				MIDX_CHUNK_LARGE_OFFSET_WIDTH),
 			write_midx_large_offsets);
 
-	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
+	if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
 		ctx.pack_order = midx_pack_order(&ctx);
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
@@ -1368,11 +1376,11 @@ static int write_midx_internal(struct odb_source *source,
 			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & MIDX_WRITE_REV_INDEX &&
+	if (opts->flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
 		write_midx_reverse_index(&ctx, midx_hash);
 
-	if (flags & MIDX_WRITE_BITMAP) {
+	if (opts->flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
 		struct commit **commits;
 		uint32_t commits_nr;
@@ -1382,7 +1390,7 @@ static int write_midx_internal(struct odb_source *source,
 
 		prepare_midx_packing_data(&pdata, &ctx);
 
-		commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &ctx);
+		commits = find_commits_for_midx_bitmap(&commits_nr, opts->refs_snapshot, &ctx);
 
 		/*
 		 * The previous steps translated the information from
@@ -1395,7 +1403,7 @@ static int write_midx_internal(struct odb_source *source,
 
 		if (write_midx_bitmap(&ctx,
 				      midx_hash, &pdata, commits, commits_nr,
-				      flags) < 0) {
+				      opts->flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			clear_packing_data(&pdata);
 			free(commits);
@@ -1428,7 +1436,7 @@ static int write_midx_internal(struct odb_source *source,
 		if (link_midx_to_chain(ctx.base_midx) < 0)
 			goto cleanup;
 
-		get_split_midx_filename_ext(source, &final_midx_name,
+		get_split_midx_filename_ext(opts->source, &final_midx_name,
 					    midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
@@ -1461,7 +1469,7 @@ static int write_midx_internal(struct odb_source *source,
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(source, keep_hashes,
+	clear_midx_files(opts->source, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
 	result = 0;
@@ -1495,9 +1503,14 @@ int write_midx_file(struct odb_source *source,
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
@@ -1505,8 +1518,15 @@ int write_midx_file_only(struct odb_source *source,
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
@@ -1566,8 +1586,11 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(source, NULL,
-					     &packs_to_drop, NULL, NULL, flags);
+		result = write_midx_internal(&(struct write_midx_opts) {
+					     .source = source,
+					     .packs_to_drop = &packs_to_drop,
+					     .flags = flags & MIDX_PROGRESS,
+					     });
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1774,8 +1797,10 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
 		goto cleanup;
 	}
 
-	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
-				     flags);
+	result = write_midx_internal(&(struct write_midx_opts) {
+				     .source = source,
+				     .flags = flags,
+				     });
 
 cleanup:
 	free(include_pack);
-- 
2.52.0.171.gd6a4e6b6955

