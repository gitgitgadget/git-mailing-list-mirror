Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6431D363A
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054064; cv=none; b=qy8CVQhq3LgLUDEaqUDMXJvbO1sCV23muUz+ovND5hXumK4glNEJp/QsN/HMOPyn78jYRyeWBfY2NtpGktvDWhHkWJhReaSHd3c5LTV50DTPgei27w6G5YTBdFL0yPcTx1FT3WaF0rc0swNSLg1ckE2MSk9mdS8mU7127tzW0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054064; c=relaxed/simple;
	bh=0sInAvI+HQAx2r9lL2BTrfzFkY1zxC0zMCovkm1+4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBF1ekWSK+SApzFWueReMamJMY1yajd4Zbv4JSZ4M+7gobgIEyCKyNAsSi05yya2xFBuNmjtVmYIQIlTHpU7t6p7wqnSti2k8ANKFbYkIxo06s558lusP5YkT7Ni3954p2BDiy9MitK30gQGWBAHa9BZD8DQTgm9I+GM2gX3JpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GNgRQ2mO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GNgRQ2mO"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e38232fc4d8so2950826276.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054060; x=1732658860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f22BfR2pfhbu10D3BRua0+75M+He42oQQUe+qb51iIQ=;
        b=GNgRQ2mOvMViDwO+XL+BeBJtDow11YU4X1DFJmu+O1rLcoFkbFrPgjQoVIdsqvwbBo
         05OsL50G5MwnF4eoRxNytnrxJXDJzJwmP14/AyCrixqxk49Oy2OSAlayfyh0QZeaMsGA
         GD8nupxj4a52OiKXEbjSwRD+I2iXcml+Jfn5EqhFh4oM05eKFEz8whOXJqxXqOjZi/lb
         rGZONanY9BG5w+tQ8FYOAmeDRR+sVu2tVoiZWPo1YH1ZbjNI3seO0y5MaM0z5AFS/Fjb
         UIbPj9XjYqcrc8OrHTAYwKQMzYB4Npqzywk6bixEZg0FgcQRjDujD5GiHB4xz/k3oOLG
         lpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054060; x=1732658860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f22BfR2pfhbu10D3BRua0+75M+He42oQQUe+qb51iIQ=;
        b=KnT/anrTZbDTZ3ouWBHu9b7xPrEYVRybd4RwSCEe3CvhAdR9fDMWfenfFZv8hT/Tdt
         Wcv296wkT3YVElMDUrVF0bTK9I701rqSSykQIG4EGP51kjamRUMbMbVwtdYYhdiujMop
         Opjd366x/aVV0XrD6wMFJb9pG44E/teVPyUolyqSNMrXNJaymg1c20fwrvT/kDgfOWc0
         gKSRoCjCoSGf+sGf5g1Th8kTlV4HHGbvWLtCptLwT4XCti7LTypp+fwgRg97e3Keh0Qs
         A1QTn411CNNnadYoxPe/DFk+z6vQznPyxQrdyBLfI6ROQWQlFggAdcIAC5OV5ImbBc9Q
         of8g==
X-Gm-Message-State: AOJu0YxxXvwCizQpvRpay5UvAuZrrfJFjbYWW/tceEIDjYyyYbloj6bn
	4eUtIBWVS4G1W8wzYOKzDFL/jLlPYNP2Gj9EEA+CkCa0aLXORiyQZR6ZvEcThPcNqQfp+Fwq+iJ
	y84Y=
X-Google-Smtp-Source: AGHT+IGrLTAA5JA51PEgCoq+Xv+Mf7K1g1Cl7QLSpTzVVWBi6J7Ttor8/BvBHGmU607C5YsIY0GxWA==
X-Received: by 2002:a05:6902:2509:b0:e20:2245:6f9c with SMTP id 3f1490d57ef6-e38cb5a0011mr329026276.26.1732054059799;
        Tue, 19 Nov 2024 14:07:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e806ae0sm2733447276.57.2024.11.19.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:39 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:38 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/13] pack-bitmap.c: teach `rev-list --test-bitmap` about
 incremental MIDXs
Message-ID: <17ab23dd76dce076275873e96991acd2f2b2a994.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Implement support for the special `--test-bitmap` mode of `git rev-list`
when using incremental MIDXs.

The bitmap_test_data structure is extended to contain a "base" pointer
that mirrors the structure of the bitmap chain that it is being used to
test.

When we find a commit to test, we first chase down the ->base pointer to
find the appropriate bitmap_test_data for the bitmap layer that the
given commit is contained within, and then perform the test on that
bitmap.

In order to implement this, light modifications are made to
bitmap_for_commit() to reimplement it in terms of a new function,
find_bitmap_for_commit(), which fills out a pointer which indicates the
bitmap layer which contains the given commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 105 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1dddb242434..02864a0e1f7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -943,8 +943,9 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	return NULL;
 }
 
-struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
-				      struct commit *commit)
+static struct ewah_bitmap *find_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						  struct commit *commit,
+						  struct bitmap_index **found)
 {
 	khiter_t hash_pos;
 	if (!bitmap_git)
@@ -954,18 +955,30 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
-			return bitmap_for_commit(bitmap_git->base, commit);
+			return find_bitmap_for_commit(bitmap_git->base, commit,
+						      found);
 
 		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
-			return bitmap_for_commit(bitmap_git->base, commit);
+			return find_bitmap_for_commit(bitmap_git->base, commit,
+						      found);
+		if (found)
+			*found = bitmap_git;
 		return lookup_stored_bitmap(bitmap);
 	}
+	if (found)
+		*found = bitmap_git;
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
 }
 
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit)
+{
+	return find_bitmap_for_commit(bitmap_git, commit, NULL);
+}
+
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
@@ -2493,6 +2506,8 @@ struct bitmap_test_data {
 	struct bitmap *tags;
 	struct progress *prg;
 	size_t seen;
+
+	struct bitmap_test_data *base_tdata;
 };
 
 static void test_bitmap_type(struct bitmap_test_data *tdata,
@@ -2501,6 +2516,11 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	enum object_type bitmap_type = OBJ_NONE;
 	int bitmaps_nr = 0;
 
+	if (bitmap_is_midx(tdata->bitmap_git)) {
+		while (pos < tdata->bitmap_git->midx->num_objects_in_base)
+			tdata = tdata->base_tdata;
+	}
+
 	if (bitmap_get(tdata->commits, pos)) {
 		bitmap_type = OBJ_COMMIT;
 		bitmaps_nr++;
@@ -2564,13 +2584,57 @@ static void test_show_commit(struct commit *commit, void *data)
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
+static uint32_t bitmap_total_entry_count(struct bitmap_index *bitmap_git)
+{
+	uint32_t total = 0;
+	do {
+		total = st_add(total, bitmap_git->entry_count);
+		bitmap_git = bitmap_git->base;
+	} while (bitmap_git);
+
+	return total;
+}
+
+static void prepare_bitmap_test_data(struct bitmap_test_data *tdata,
+				     struct bitmap_index *bitmap_git)
+{
+	memset(tdata, 0, sizeof(struct bitmap_test_data));
+
+	tdata->bitmap_git = bitmap_git;
+	tdata->base = bitmap_new();
+	tdata->commits = ewah_to_bitmap(bitmap_git->commits);
+	tdata->trees = ewah_to_bitmap(bitmap_git->trees);
+	tdata->blobs = ewah_to_bitmap(bitmap_git->blobs);
+	tdata->tags = ewah_to_bitmap(bitmap_git->tags);
+
+	if (bitmap_git->base) {
+		CALLOC_ARRAY(tdata->base_tdata, 1);
+		prepare_bitmap_test_data(tdata->base_tdata, bitmap_git->base);
+	}
+}
+
+static void free_bitmap_test_data(struct bitmap_test_data *tdata)
+{
+	if (!tdata)
+		return;
+
+	free_bitmap_test_data(tdata->base_tdata);
+	free(tdata->base_tdata);
+
+	bitmap_free(tdata->base);
+	bitmap_free(tdata->commits);
+	bitmap_free(tdata->trees);
+	bitmap_free(tdata->blobs);
+	bitmap_free(tdata->tags);
+}
+
 void test_bitmap_walk(struct rev_info *revs)
 {
 	struct object *root;
 	struct bitmap *result = NULL;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
-	struct bitmap_index *bitmap_git;
+	struct bitmap_index *bitmap_git, *found;
 	struct ewah_bitmap *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
@@ -2579,17 +2643,26 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (revs->pending.nr != 1)
 		die(_("you must specify exactly one commit to test"));
 
-	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s)",
+	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s, %d total)",
 		bitmap_git->version,
 		bitmap_git->entry_count,
-		bitmap_git->table_lookup ? "" : " loaded");
+		bitmap_git->table_lookup ? "" : " loaded",
+		bitmap_total_entry_count(bitmap_git));
 
 	root = revs->pending.objects[0].item;
-	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
+	bm = find_bitmap_for_commit(bitmap_git, (struct commit *)root, &found);
 
 	if (bm) {
 		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
-			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
+			oid_to_hex(&root->oid),
+			(int)bm->bit_size, ewah_checksum(bm));
+
+		if (bitmap_is_midx(found))
+			fprintf_ln(stderr, "Located via MIDX '%s'.",
+				   hash_to_hex(get_midx_checksum(found->midx)));
+		else
+			fprintf_ln(stderr, "Located via pack '%s'.",
+				   hash_to_hex(found->pack->hash));
 
 		result = ewah_to_bitmap(bm);
 	}
@@ -2606,14 +2679,8 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
 
-	tdata.bitmap_git = bitmap_git;
-	tdata.base = bitmap_new();
-	tdata.commits = ewah_to_bitmap(bitmap_git->commits);
-	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
-	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
-	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
+	prepare_bitmap_test_data(&tdata, bitmap_git);
 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
-	tdata.seen = 0;
 
 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
 
@@ -2625,11 +2692,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		die(_("mismatch in bitmap results"));
 
 	bitmap_free(result);
-	bitmap_free(tdata.base);
-	bitmap_free(tdata.commits);
-	bitmap_free(tdata.trees);
-	bitmap_free(tdata.blobs);
-	bitmap_free(tdata.tags);
+	free_bitmap_test_data(&tdata);
 	free_bitmap_index(bitmap_git);
 }
 
-- 
2.47.0.301.g77ddd1170f9

