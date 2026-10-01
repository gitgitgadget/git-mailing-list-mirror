Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490D42A7A8
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827932; cv=none; b=aOzva8VV9Ejm6Snanp9hjsTrAbpcFW7bPkbs8WIq0E0D+fan5aw7AxzdrMKPmyrieweIm1K9RIB/VRQioXtO72vSXbUvblSrSEIEhnr3mBwJgUmSd77ETXmra6O/5ylMy/beSM20VC5j5x6MyK0d0LP10ww4IQ0b1V8MP9uTOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827932; c=relaxed/simple;
	bh=ZUNbtJpTwtQLkEWwTMu89QF1fxO2VEThfxbhxRTVUKs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTiyLjRQ97Ep8IeJDVASTCQuujIaId3/lnUEdrTKcWMy3l6912SGK1baLOTZCq6ixTqCRnp6t23I6lKktUfqr2rytyv1aa+4h6+tVsdCVWjMH+tsmD6ijUfvN3vA6godoHHD6VrCxsKY7A54io6bXEEpKCeR0z4o3SqBP4SnI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=J8LsffC6; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="J8LsffC6"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d8709e0e13so1808790eaf.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827929; x=1791432729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vqAAtlkvTtudNgYyX8buxI8SzBu4oHkAZRA+s6PUISo=;
        b=J8LsffC6RE19wsq/LkR8+6fY12GwMaK8ffTfDZ3qssrzDa4bWtLb6utbKtPYEyPuZv
         ErpZr6UG4JnbEZ2lOVEpDRWUHKDS1XIcVrjNsG1dHRCku7B4eXSFFxtIWD1ScB5D7KcF
         Gf1qgIAPg1BeQ8MJCWEOqapvSDPzI2I9b1kSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827929; x=1791432729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqAAtlkvTtudNgYyX8buxI8SzBu4oHkAZRA+s6PUISo=;
        b=EFwBt8YHYpJvv22aOUUTzcw2C8SpzW14ITIznZYH1+S7WK5Mazt56VnWgCUP4NVZRm
         LY2LsUHLhjwoWoht/z3u36zGFFDVmgjIZgoIa8GW8mFtpPMQx0oAvL3c9AmHtbw8wMc2
         3qnora5zAe5Drp40ajDZICqz9p8gn6JioVUVZOvJnfJiApns7FxfJ6BYoaQSd/Otpl2W
         BEDtE2n0wlrogCOIEG13GgdN4s+3xJ+2smfbSKzkewkHyUwiGaVEyUMU9NO8PneHLVVI
         k4a1GivyTY7Poh8tqK2xsnsxNOBH4ZHpysDE6+oBVP+XLdjZUYoHem7F7UY5f5QfX92q
         vQQg==
X-Gm-Message-State: AFuF++mZHbPesOYDEeZV97T+qgD8daJXFknlexS9CI0lBEsZkch9/OYP
	Xft0SvIet2/WPCVM7yP1WzakfKftwidsU414+iIHPKAesf8dblXJ2A9zKYav8g33dXsI/o1R2Xp
	lD9twEY0=
X-Gm-Gg: AYBFou3nJ+cetg9ZEL7ryuQWMfoAvM2LeKvEsR6ZPLUJm0qvvC5G7B39z8JQez7Kzn/
	odNTSmipdCeZfW0aF68myDZMCDG1l6OfiRYm+w0Q14i/9a0RqfqB0hH96fGBW5dvwxs4FatJZ9T
	IQksox+hOq53m6Rfcv+9lG4xr1d7wOToVQvWUSUH9jBwa5vblG2pkR3cbAnDDl6EwHY9eD27zVn
	izYzYMZAaJbJ1vsZyQSx1esMHf4Bd+ctcfw4nz3P3wIoKaVYucA3w314DlnIxaUNoy4k22zJpVU
	dGt/8smKOARxbiuuCYudew4PltuP2UL/VmFkvb8+aFzr34EPulAQKOHbXh4iFRQDTfGRUdSligc
	XdMOES26TJcMep6jw7FgRoQeHNO43qr18HaObxQ9yoLrmRYmfEof1kMsXtblJhGug1k4g2lGVUX
	l4kgktBOYcPI7xwrVRyD9jYckCzriFpNLZY8dwQfuN6w8rGk4yySKILb0T1gLILoEGg4xODCiY8
	gvrvK2Qn/mxmO1qgxz2b0/9EnMqBzwgS3uexiC3IGOgYnAzupcrTTsPSu4fz3x9LGgt7exXiPut
	LJ73vSsn
X-Received: by 2002:a05:6820:f03:b0:6d8:8fdb:c4a1 with SMTP id 006d021491bc7-6dcf46576f2mr3914306eaf.16.1790827928726;
        Wed, 30 Sep 2026 21:12:08 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd980fb183sm1848132eaf.10.2026.09.30.21.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:12:08 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:12:05 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 8/8] repack: include required packs in incremental MIDX
 writes
Message-ID: <a42f775cbe27b385bfc8ff38f33604b3913dc340.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

The append plan introduced in 06733a50eee (repack: allow
`--write-midx=incremental` without `--geometric`, 2026-05-19) adds only
newly written packs to the existing MIDX chain. The bitmap writer can
use objects from the new layer and all retained base layers, but the
plan omits preexisting packs outside the chain. Bitmap generation fails
if a selected commit reaches an object absent from the resulting chain.

The geometric plan from 1da62fb5c86 (repack: implement incremental MIDX
repacking, 2026-05-19) can omit kept and cruft packs, since neither
necessarily participates in the geometric repack. Such packs can also be
lost when replacing a tip layer that contains them. Neither plan
consults `midx_included_packs()`, so the rules for retaining cruft in
ordinary MIDX writes do not protect incremental writes.

Use that selection logic to add missing packs to each plan's write step.
Skip packs in retained base layers, but include required packs from a
replaced tip. Count added objects when choosing which layers to compact,
without changing the preferred pack.

Write and verify bitmaps in the existing append test: its existing
checks do not detect the omitted pack containing the first commit. Cover
the no-new-pack case separately with a reachable blob in a cruft pack.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 Documentation/git-repack.adoc      |  5 +-
 repack-midx.c                      | 83 ++++++++++++++++++++++++------
 t/t7705-repack-incremental-midx.sh | 63 ++++++++++++++++++-----
 3 files changed, 122 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index a1f9e64f668..ee59b76580a 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -303,8 +303,9 @@ linkgit:git-multi-pack-index[1]).
 		flat MIDX.
 +
 Without `--geometric`, a new MIDX layer is appended to the existing
-chain (or a new chain is started) containing whatever packs were written
-by the repack. Existing layers are preserved as-is.
+chain (or a new chain is started) containing newly written packs and any
+other required packs not already in the chain. Existing layers are
+preserved as-is.
 +
 When combined with `--geometric`, the incremental mode maintains a chain
 of MIDX layers that is compacted over time using a geometric merging
diff --git a/repack-midx.c b/repack-midx.c
index 06eadb9df82..58776c44691 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -7,6 +7,7 @@
 #include "odb.h"
 #include "oidset.h"
 #include "pack-bitmap.h"
+#include "packfile.h"
 #include "path.h"
 #include "refs.h"
 #include "run-command.h"
@@ -73,7 +74,8 @@ void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
 
 static int midx_has_unknown_packs(struct string_list *include,
 				  struct pack_geometry *geometry,
-				  struct existing_packs *existing)
+				  struct existing_packs *existing,
+				  struct multi_pack_index *base)
 {
 	struct string_list_item *item;
 
@@ -91,6 +93,8 @@ static int midx_has_unknown_packs(struct string_list *include,
 		 *    MIDX. Note this function is called before the include
 		 *    list is populated with any cruft pack(s).
 		 *
+		 *  - In a MIDX layer retained as part of the new chain's base.
+		 *
 		 *  - Below the geometric split line (if using pack geometry),
 		 *    indicating that the pack won't be included in the new
 		 *    MIDX, but its contents were rolled up as part of the
@@ -99,7 +103,8 @@ static int midx_has_unknown_packs(struct string_list *include,
 		 *  - In the existing non-kept packs list (if not using pack
 		 *    geometry), and marked as non-deleted.
 		 */
-		if (string_list_has_string(include, pack_name)) {
+		if (string_list_has_string(include, pack_name) ||
+		    midx_contains_pack(base, pack_name)) {
 			continue;
 		} else if (geometry) {
 			struct strbuf buf = STRBUF_INIT;
@@ -141,7 +146,8 @@ static int midx_has_unknown_packs(struct string_list *include,
 }
 
 static void midx_included_packs(struct string_list *include,
-				struct repack_write_midx_opts *opts)
+				struct repack_write_midx_opts *opts,
+				struct multi_pack_index *base)
 {
 	struct existing_packs *existing = opts->existing;
 	struct pack_geometry *geometry = opts->geometry;
@@ -198,7 +204,7 @@ static void midx_included_packs(struct string_list *include,
 
 	if (opts->midx_must_contain_cruft ||
 	    (!geometry->split_factor && existing->kept_packs.nr) ||
-	    midx_has_unknown_packs(include, geometry, existing)) {
+	    midx_has_unknown_packs(include, geometry, existing, base)) {
 		/*
 		 * If there are one or more unknown pack(s) present (see
 		 * midx_has_unknown_packs() for what makes a pack
@@ -336,7 +342,7 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
 	int ret = 0;
 
-	midx_included_packs(&include, opts);
+	midx_included_packs(&include, opts, NULL);
 	if (!include.nr)
 		goto done;
 
@@ -547,9 +553,50 @@ static void midx_compaction_step_release(struct midx_compaction_step *step)
 	free(step->csum);
 }
 
+static int midx_compaction_step_include_packs(struct midx_compaction_step *step,
+					      struct repack_write_midx_opts *opts,
+					      struct multi_pack_index *base)
+{
+	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
+	struct string_list include = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct strbuf path = STRBUF_INIT;
+	int ret = 0;
+
+	midx_included_packs(&include, opts, base);
+	string_list_sort(&step->u.write);
+
+	for_each_string_list_item(item, &include) {
+		struct packed_git *p;
+
+		if (string_list_has_string(&step->u.write, item->string) ||
+		    midx_contains_pack(base, item->string))
+			continue;
+
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/%s", opts->packdir, item->string);
+		p = packfile_store_load_pack(files->packed, path.buf, 1);
+		if (!p || open_pack_index(p)) {
+			ret = error(_("cannot open index for %s"), path.buf);
+			goto out;
+		}
+		if (unsigned_add_overflows(step->objects_nr, p->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+		step->objects_nr += p->num_objects;
+		string_list_insert(&step->u.write, item->string);
+	}
+
+out:
+	strbuf_release(&path);
+	string_list_clear(&include, 0);
+	return ret;
+}
+
 /*
- * Build an append-only MIDX plan: a single WRITE step for the freshly
- * written packs, plus COPY steps for every existing layer.  No
+ * Build an append-only MIDX plan: a single WRITE step for packs not
+ * already in the chain, plus COPY steps for every existing layer. No
  * compaction or merging is performed.
  */
 static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
@@ -557,17 +604,20 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
 					 size_t *steps_nr_p)
 {
 	struct odb_source_files *files = odb_source_files_downcast(opts->existing->source);
+	struct string_list include = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 	struct multi_pack_index *m;
 	struct midx_compaction_step *steps = NULL;
 	struct midx_compaction_step *step = NULL;
-	struct strbuf buf = STRBUF_INIT;
 	size_t steps_nr = 0, steps_alloc = 0;
-	uint32_t i;
 
 	odb_reprepare(opts->existing->repo->objects);
 	m = get_multi_pack_index(files->packed);
 
-	for (i = 0; i < opts->names->nr; i++) {
+	midx_included_packs(&include, opts, m);
+	for_each_string_list_item(item, &include) {
+		if (midx_contains_pack(m, item->string))
+			continue;
 		if (!step) {
 			ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
 			step = &steps[steps_nr++];
@@ -575,12 +625,9 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
 			step->type = MIDX_COMPACTION_STEP_WRITE;
 			string_list_init_dup(&step->u.write);
 		}
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "pack-%s.idx",
-			    opts->names->items[i].string);
-		string_list_append(&step->u.write, buf.buf);
+		string_list_append(&step->u.write, item->string);
 	}
-	strbuf_release(&buf);
+	string_list_clear(&include, 0);
 
 	for (; m; m = m->base_midx) {
 		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
@@ -729,6 +776,12 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 	if (opts->geometry->midx_tip_rewritten)
 		m = m->base_midx;
 
+	if (midx_compaction_step_include_packs(&step, opts, m) < 0) {
+		midx_compaction_step_release(&step);
+		ret = -1;
+		goto out;
+	}
+
 	trace2_data_string("repack", opts->existing->repo, "midx:rewrote-tip",
 			   opts->geometry->midx_tip_rewritten ? "true" : "false");
 
diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
index 25a8c40e8ee..4760c920a50 100755
--- a/t/t7705-repack-incremental-midx.sh
+++ b/t/t7705-repack-incremental-midx.sh
@@ -74,7 +74,7 @@ test_expect_success '--write-midx=incremental without --geometric' '
 		git repack -d &&
 
 		test_commit second &&
-		git repack --write-midx=incremental &&
+		git repack --write-midx=incremental --write-bitmap-index &&
 
 		git multi-pack-index verify &&
 		test_line_count = 1 $midx_chain &&
@@ -83,7 +83,7 @@ test_expect_success '--write-midx=incremental without --geometric' '
 		# A second repack appends a new layer without
 		# disturbing the existing one.
 		test_commit third &&
-		git repack --write-midx=incremental &&
+		git repack --write-midx=incremental --write-bitmap-index &&
 
 		git multi-pack-index verify &&
 		test_line_count = 2 $midx_chain &&
@@ -91,10 +91,50 @@ test_expect_success '--write-midx=incremental without --geometric' '
 		head -n 1 $midx_chain >actual &&
 		test_cmp expect actual &&
 
+		git rev-list --test-bitmap HEAD &&
 		git fsck
 	)
 '
 
+test_expect_success 'incremental MIDX includes cruft without a new pack' '
+	git init incremental-cruft &&
+	(
+		cd incremental-cruft &&
+		git config repack.midxMustContainCruft false &&
+
+		test_commit base &&
+		echo cruft | git hash-object -w --stdin &&
+		git repack --cruft -d &&
+		test_commit cruft &&
+		git repack -d &&
+
+		# All objects are packed, but the new MIDX still needs cruft.
+		git repack --write-midx=incremental --write-bitmap-index &&
+		git rev-list --test-bitmap HEAD
+	)
+'
+
+test_expect_success 'geometric incremental MIDX retains cruft when replacing its tip' '
+	git init geometric-incremental-cruft &&
+	(
+		cd geometric-incremental-cruft &&
+		git config repack.midxNewLayerThreshold 1 &&
+
+		test_commit base &&
+		echo cruft | git hash-object -w --stdin &&
+		git repack --cruft -d &&
+		git multi-pack-index write --incremental --bitmap &&
+		test_commit cruft &&
+
+		# Pack the new commit and tree, leaving the blob in cruft.
+		git repack -d &&
+		git repack --geometric=2 --write-midx=incremental \
+			--write-bitmap-index &&
+		test_line_count = 1 $midx_chain &&
+		git rev-list --test-bitmap HEAD
+	)
+'
+
 test_expect_success 'below layer threshold, tip packs excluded' '
 	git init below-layer-threshold-tip-packs-excluded &&
 	(
@@ -338,7 +378,7 @@ test_expect_success 'geometric rollup with surviving tip packs' '
 	)
 '
 
-test_expect_success 'kept packs are excluded from repack' '
+test_expect_success 'kept packs are excluded from repack but included in MIDX' '
 	git init kept-packs-excluded-from-repack &&
 	(
 		cd kept-packs-excluded-from-repack &&
@@ -353,21 +393,20 @@ test_expect_success 'kept packs are excluded from repack' '
 			test_commit "$i" && git repack -d || return 1
 		done &&
 
-		keep=$(ls $packdir/pack-*.idx | head -n 1) &&
-		touch "${keep%.idx}.keep" &&
+		keep=$(test-tool find-pack A) &&
+		touch "${keep%.pack}.keep" &&
 
-		# The kept pack is excluded as a repacking candidate
-		# entirely, so no rollup occurs as there is only one
-		# non-kept pack. A new MIDX layer is written containing
-		# that pack.
-		git repack --geometric=2 -d --write-midx=incremental &&
+		# Neither pack is repacked, but both are needed for the
+		# bitmap of B, which reaches objects in the kept pack.
+		git repack --geometric=2 -d --write-midx=incremental \
+			--write-bitmap-index &&
 
 		test-tool read-midx $objdir >actual &&
 		grep "^pack-.*\.idx$" actual >actual.packs &&
-		test_line_count = 1 actual.packs &&
-		test_grep ! "$keep" actual.packs &&
+		test_line_count = 2 actual.packs &&
 
 		git multi-pack-index verify &&
+		git rev-list --test-bitmap HEAD &&
 
 		# All objects (from both kept and non-kept packs)
 		# must still be accessible.
-- 
2.56.0.8.ga42f775cbe2
