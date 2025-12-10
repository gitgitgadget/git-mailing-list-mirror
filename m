Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233E17A309
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371156; cv=none; b=iFvUKie2mrul46VprpusUGBONN6/1irsCU3d2TUXmYTTdW1DIPHt0lfqpx/MLQ7SmCIec+JDyYSwHHSksoS1X58ufJQD1Lp97Xr9x186mFMWcwYP2yVwRd+eyXBU3doVvMZ6K7ST/a6fqnWckQOlp8MR8gSWVR7FRI+N3OCWU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371156; c=relaxed/simple;
	bh=5y/WdeMwzh/VPFcSDO5O3DAaxodSAMV21ciiXc/nWs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRnAkVn2MRS0tTrRb+LtraT4eK/ESv56OhGSkFCwf3lly3i+dfipbr5axbls6AiWXvdPzA+4k0KF7QQdU1sBHIgk8b7IfR9udwHlj1+1TUYyn0y23UiiVhBKxfptdnd9WsHutEg0C/jek03VOE/ST+ejs1gyseG9WKxbTFKmuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pQDdg9vr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eV9r8tjp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pQDdg9vr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eV9r8tjp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36CA0140003B;
	Wed, 10 Dec 2025 07:52:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Dec 2025 07:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765371154;
	 x=1765457554; bh=SW12Ac+6Ogd7L6pBzRw664YTT6gYTwZ/VjqngST50JY=; b=
	pQDdg9vrxeSCTVt6MhtTJvoIezArl4kVBFCzAb+qaZ959SX8ej9/7JzkiwIJc77s
	22W6cKE6G92OJYme7zngWc7/9PPwWjkhConZla59UHdT7PIkGUgAPrrjKTA3E0br
	55frCgEqvy4ZR/PNni7e8fqvo9xLx1PWXnmpjOI/41h2Mi1NLhXI9uypJPF8zmgT
	Vkxq1PtD+ZRDxRCGbzvlWOf0zprGxwTL+hPfj1Ke5jbkDKOQAelXv0Rlnj5T82eL
	CHXV9Do045P+El63UsqoGD9APo3tXJ80Fji6RWlMRrbPSClmA6277U0GcLi8WWZE
	PEzktA/+GBXDutbwdtGn+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765371154; x=
	1765457554; bh=SW12Ac+6Ogd7L6pBzRw664YTT6gYTwZ/VjqngST50JY=; b=e
	V9r8tjpqloFIlp3hCpoj5JHM3ckT7TTk7nMLo1+BzrYmpwkdCo23gcklXTsJmcwu
	/UqrhUHTEWZktfwEUjPDguxlYRYWmA51grnCQjmgh0DaRY9zjtr8lqfnwcwvRGnf
	0Xza9Vnv4S+y+4jM9qGPsx+m8VmOHmldczv8IA65Qs4Z+yhJtta9ENvPYMEhZWxk
	Zo4iHTE1PqeVAxkoxCr82EF2N0RoaVTg8gEtEXgD/DpshDiiTiMlt/mhdy1bUaUC
	OsMh8kcO98tRetPf1GQfypkC2o9r5I7skhfTmGcG/4LEUEY9xLl/oizP/wu+vRf6
	UkKh+wEFgRm5Wunghfh8g==
X-ME-Sender: <xms:Em05aeqOM2iKZLavm005d1XgBJrTLq5mQmtq7kZh2WesdlxpOhgXAA>
    <xme:Em05aUEN5A35RUbkGg2cKEZFS_6sXyG_uYTLU0Umg0fMbAPdsT19Rf0yTGJeOmLXE
    5OPEpvM8mvgq8gvbFjWO6xTy_YcOE5YIng7KcPpRkbla3dj2nDdbg>
X-ME-Received: <xmr:Em05aQkTbJhAOgPpvcFiaZxrkBOETu66ccc_mbynsb7J5rIjhhWmVeLzE3NJBM6wETx02XEb8aTQNHkPCcQ8v-5bqbKMKJrJ8cYoZXs2f84c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:Em05aXm0NEKC1kwsFGm-Sfr1RYDYc-S2eayFGJK0V4kdHuqLEo2Lvw>
    <xmx:Em05aRsJg0IIp5DtzZvLDFCEX_6mZkQj_AvTVIpimR7QD6Zn_Eiy2w>
    <xmx:Em05aamjbuWtVu_eNtc0GnEKUc9cDvxPienkswuL8_EQhjObntHTDA>
    <xmx:Em05acuOxPJdO46I6klw0issp4qsSKvK9VbBhO4RyQXb-YhivY6HtA>
    <xmx:Em05aZgRS4I9w0Tn0JvhdRERvD1Y49PG4H2QWD4u9GU9f92hoUH9otoV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 07:52:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61c0d204 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 12:52:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Dec 2025 13:52:20 +0100
Subject: [PATCH v2 3/3] midx-write: skip rewriting MIDX with
 `--stdin-packs` unless needed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-pks-skip-noop-rewrite-v2-3-f813a9e44f28@pks.im>
References: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
In-Reply-To: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

In `write_midx_internal()` we know to skip rewriting the multi-pack
index in case the existing one already covers all packs. This logic does
not know to handle `git multi-pack-index write --stdin-packs` though, so
we end up always rewriting the MIDX in this case even if the MIDX would
not change.

With our default maintenance strategy this isn't really much of a
problem, as git-gc(1) does not use the "--stdin-packs" option. But that
is changing with geometric repacking, where "--stdin-packs" is used to
explicitly select the packfiles part of the geometric sequence.

This issue can be demonstrated trivially with a benchmark in the Git
repository: executing `git repack --geometric=2 --write-midx -d` in the
Git repository takes more than 3 seconds only to end up with the same
multi-pack index as we already had before.

The logic that decides if we need to rewrite the MIDX only checks
whether the number of packfiles covered will change. That check is of
course too lenient for "--stdin-packs", as it could happen that we want
to cover a different-but-same-size set of packfiles. But there is no
inherent reason why we cannot handle "--stdin-packs".

Improve the logic to not only check for the number of packs, but to also
verify that we are asked to generate a MIDX for the _same_ packs. This
allows us to also skip no-op rewrites for "--stdin-packs".

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx-write.c                | 100 +++++++++++++++++++++++++++++++-------------
 t/t5319-multi-pack-index.sh |  51 ++++++++++++++++++++++
 t/t7703-repack-geometric.sh |  35 ++++++++++++++++
 3 files changed, 156 insertions(+), 30 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 78bc8a65b8..ce459b02c3 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1014,9 +1014,10 @@ static void clear_midx_files(struct odb_source *source,
 	strbuf_release(&buf);
 }
 
-static bool midx_needs_update(struct write_midx_context *ctx)
+static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_context *ctx)
 {
-	struct multi_pack_index *midx = ctx->m;
+	struct strset packs = STRSET_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	bool needed = true;
 
 	/*
@@ -1027,25 +1028,48 @@ static bool midx_needs_update(struct write_midx_context *ctx)
 	if (ctx->incremental)
 		goto out;
 
-	/*
-	 * If there is no MIDX then either it doesn't exist, or we're doing a
-	 * geometric repack. We cannot (yet) determine whether we need to
-	 * update the multi-pack index in the second case.
-	 */
-	if (!midx)
-		goto out;
-
 	/*
 	 * Otherwise, we need to verify that the packs covered by the existing
-	 * MIDX match the packs that we already have. This test is somewhat
-	 * lenient and will be fixed.
+	 * MIDX match the packs that we already have. The logic to do so is way
+	 * more complicated than it has any right to be. This is because:
+	 *
+	 *   - We cannot assume any ordering.
+	 *
+	 *   - The MIDX packs may not be loaded at all, and loading them would
+	 *     be wasteful. So we need to use the pack names tracked by the
+	 *     MIDX itself.
+	 *
+	 *   - The MIDX pack names are tracking the ".idx" files, whereas the
+	 *     packs themselves are tracking the ".pack" files. So we need to
+	 *     strip suffixes.
 	 */
 	if (ctx->nr != midx->num_packs + midx->num_packs_in_base)
 		goto out;
 
+	for (uint32_t i = 0; i < ctx->nr; i++) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(ctx->info[i].p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if (!strset_add(&packs, buf.buf))
+			BUG("same pack added twice?");
+	}
+
+	for (uint32_t i = 0; i < ctx->nr; i++) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, midx->pack_names[i]);
+		strbuf_strip_suffix(&buf, ".idx");
+
+		if (!strset_contains(&packs, buf.buf))
+			goto out;
+		strset_remove(&packs, buf.buf);
+	}
+
 	needed = false;
 
 out:
+	strbuf_release(&buf);
+	strset_clear(&packs);
 	return needed;
 }
 
@@ -1066,6 +1090,7 @@ static int write_midx_internal(struct odb_source *source,
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
 	 };
+	struct multi_pack_index *midx_to_free = NULL;
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -1146,25 +1171,39 @@ static int write_midx_internal(struct odb_source *source,
 	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (!packs_to_include && !packs_to_drop && !midx_needs_update(&ctx)) {
-		struct bitmap_index *bitmap_git;
-		int bitmap_exists;
-		int want_bitmap = flags & MIDX_WRITE_BITMAP;
-
-		bitmap_git = prepare_midx_bitmap_git(ctx.m);
-		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
-		free_bitmap_index(bitmap_git);
-
-		if (bitmap_exists || !want_bitmap) {
-			/*
-			 * The correct MIDX already exists, and so does a
-			 * corresponding bitmap (or one wasn't requested).
-			 */
-			if (!want_bitmap)
-				clear_midx_files_ext(source, "bitmap", NULL);
-			result = 0;
-			goto cleanup;
+	if (!packs_to_drop) {
+		/*
+		 * If there is no MIDX then either it doesn't exist, or we're
+		 * doing a geometric repack. Try to load it from the source to
+		 * tell these two cases apart.
+		 */
+		struct multi_pack_index *midx = ctx.m;
+		if (!midx)
+			midx = midx_to_free = load_multi_pack_index(ctx.source);
+
+		if (midx && !midx_needs_update(midx, &ctx)) {
+			struct bitmap_index *bitmap_git;
+			int bitmap_exists;
+			int want_bitmap = flags & MIDX_WRITE_BITMAP;
+
+			bitmap_git = prepare_midx_bitmap_git(midx);
+			bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
+			free_bitmap_index(bitmap_git);
+
+			if (bitmap_exists || !want_bitmap) {
+				/*
+				 * The correct MIDX already exists, and so does a
+				 * corresponding bitmap (or one wasn't requested).
+				 */
+				if (!want_bitmap)
+					clear_midx_files_ext(source, "bitmap", NULL);
+				result = 0;
+				goto cleanup;
+			}
 		}
+
+		close_midx(midx_to_free);
+		midx_to_free = NULL;
 	}
 
 	if (ctx.incremental && !ctx.nr) {
@@ -1520,6 +1559,7 @@ static int write_midx_internal(struct odb_source *source,
 		free(keep_hashes);
 	}
 	strbuf_release(&midx_name);
+	close_midx(midx_to_free);
 
 	trace2_region_leave("midx", "write_midx_internal", r);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 9492a9737b..794f8b5ab4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -366,6 +366,57 @@ test_expect_success 'preferred pack cannot be determined without bitmap' '
 	)
 '
 
+test_midx_is_retained () {
+	test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+	ls -l .git/objects/pack/multi-pack-index >expect &&
+	git multi-pack-index write "$@" &&
+	ls -l .git/objects/pack/multi-pack-index >actual &&
+	test_cmp expect actual
+}
+
+test_midx_is_rewritten () {
+	test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+	ls -l .git/objects/pack/multi-pack-index >expect &&
+	git multi-pack-index write "$@" &&
+	ls -l .git/objects/pack/multi-pack-index >actual &&
+	! test_cmp expect actual
+}
+
+test_expect_success 'up-to-date multi-pack-index is retained' '
+	test_when_finished "rm -fr midx-up-to-date" &&
+	git init midx-up-to-date &&
+	(
+		cd midx-up-to-date &&
+
+		# Write the initial pack that contains the most objects.
+		test_commit first &&
+		test_commit second &&
+		git repack -Ad --write-midx &&
+		test_midx_is_retained &&
+
+		# Writing a new bitmap index should cause us to regenerate the MIDX.
+		test_midx_is_rewritten --bitmap &&
+		test_midx_is_retained --bitmap &&
+
+		# Ensure that writing a new packfile causes us to rewrite the index.
+		test_commit incremental &&
+		git repack -d &&
+		test_midx_is_rewritten &&
+		test_midx_is_retained &&
+
+		for pack in .git/objects/pack/*.idx
+		do
+			basename "$pack" || exit 1
+		done >stdin &&
+		test_line_count = 2 stdin &&
+		test_midx_is_retained --stdin-packs <stdin &&
+		head -n1 stdin >stdin.trimmed &&
+		test_midx_is_rewritten --stdin-packs <stdin.trimmed
+	)
+'
+
+test_done
+
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9fc1626fbf..98806cdb6f 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -287,6 +287,41 @@ test_expect_success '--geometric with pack.packSizeLimit' '
 	)
 '
 
+test_expect_success '--geometric --write-midx retains up-to-date MIDX without bitmap index' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+
+		test_path_is_missing .git/objects/pack/multi-pack-index &&
+		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
+		test_path_is_file .git/objects/pack/multi-pack-index &&
+		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+
+		ls -l .git/objects/pack/ >expect &&
+		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
+		ls -l .git/objects/pack/ >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--geometric --write-midx retains up-to-date MIDX with bitmap index' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	test_commit -C repo initial &&
+
+	test_path_is_missing repo/.git/objects/pack/multi-pack-index &&
+	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
+	test_path_is_file repo/.git/objects/pack/multi-pack-index &&
+	test-tool chmtime =0 repo/.git/objects/pack/multi-pack-index &&
+
+	ls -l repo/.git/objects/pack/ >expect &&
+	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
+	ls -l repo/.git/objects/pack/ >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--geometric --write-midx with packfiles in main and alternate ODB' '
 	test_when_finished "rm -fr shared member" &&
 

-- 
2.52.0.270.g3f4935d65f.dirty

