Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53815531A
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760954; cv=none; b=fevVQ8wiSsbc/+6mqRK98YGR9r4P9HyqUZYwD6dJJq4kV/axFMEolPVQsYjNvIDF7Yq916wvvPlPlDWuIEtbq2s0RPg9F2F6HEgwGYXYBZIzfqKPQhtpWCYh7JDO5BHTr3e6eQbJLaDzbp6mYhub5KEXkYmnQpr0C00JzKm+N4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760954; c=relaxed/simple;
	bh=Diw2OP53BjtYbKzltDoOm+95IBJ5g3vodhUljHD7fsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB2G2bEXK/WBhaE3OqYOMdndS5aNDeI9AKKT5KirzmpzAfhUMXY7Ae+mv554o8fmoIP4jqJ8B/LQrF5ABGxtcArOKV6Fh1vnOqp6urmSajjvrxViMZ++1+vFlz/6cI8BjF+hZ5kaWk+qyuKA+fU19fbwNRg6fjwS0rx/qi1gkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gAlGGbes; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gAlGGbes"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e116e2727dcso1291716276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760952; x=1724365752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itJ+RhRFSycZejgewS480eUDQpt1Pgfchs0s5vJxBUc=;
        b=gAlGGbesHAi2IkZvi5Gm9ubYdKIDugmyrbJBH5xBjsZIZ8f9q4/S/sFf0stOadNadq
         0PatTJ5Y+CYw9PunJsvaNxPO8zlj0WiYB3S9ypF03VLBaqufB22EOE1kLMYrd1CK2u9O
         xCQqvGwUm2MSzUmX3/zSjYR4TyztetrzXDROTn25EbKTpoxnZiCSb367S0fUNCLkozPe
         OL7ebOQxr+MMn1mAWGZIJ39uv+MF/JItgiNvbw8LbKoCF5gewVkwxFlgW8nxHG32FjOR
         /+QqOOFctLw25QPKQ4W1/7BdS/cQUayCn1/OFEMGIL5B8qvVoU78DcU3e3H+OR4+awKw
         yBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760952; x=1724365752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itJ+RhRFSycZejgewS480eUDQpt1Pgfchs0s5vJxBUc=;
        b=NGbhOgws0eJO86frYfBYDWhdS7mnbsw3Nxai2H8I9Nuphl5UNQWSZS5fngHBaRvCus
         J6KVwBqFvh4eSgDo6IuwjiXkhsO9/93/kjj25MFj94ABiBoNA+x3LxJv1DWg3p6N1zlZ
         WPFgnji1KqUI2Dzu2AutNUTMTYUgwpRZl8+ReA5UhCBZhDmGUWZsBH6ctkhNwcH5whIx
         5S8WmJf9VWTzbgdSjaBgcZpFL4Aa8o1wvj04ozAo1/xkLWwl70KErGA48mclF9RWLjyN
         iI9P11BgdI205SeB447o0Jc01l9BYvmF6h0EagUWnkx3o9ODaBJYEVYutUwVYKZxAKbm
         /QcA==
X-Gm-Message-State: AOJu0YxbGoyEH7TYS59NXGyMkN+64SuYI0zMemqo2oBFvNH+QI0jDl+N
	2QpjLKHyOkP2mwcm1tXo7hcDF6YTZhEc3dHZruazQL8h1Oek4OTWcUc9V4AHP1y+9WeP3Tv/Cca
	R
X-Google-Smtp-Source: AGHT+IGSD8RzCKH12otdsKU6Lvg3YN5fRbI5d2KYCuMSt9J/IDHSlSkoFm5QCYvGRMEBxAOO0asryw==
X-Received: by 2002:a05:6902:2004:b0:e11:6cc0:3a94 with SMTP id 3f1490d57ef6-e1180eef11cmr1050851276.27.1723760951660;
        Thu, 15 Aug 2024 15:29:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e09d9esm502999276.13.2024.08.15.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:11 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/13] pack-bitmap.c: teach `rev-list --test-bitmap` about
 incremental MIDXs
Message-ID: <6baece31750b889a189cf81f6121af162db91354.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

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
index 2b3c53d882..5fea2714c1 100644
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
@@ -2489,6 +2502,8 @@ struct bitmap_test_data {
 	struct bitmap *tags;
 	struct progress *prg;
 	size_t seen;
+
+	struct bitmap_test_data *base_tdata;
 };
 
 static void test_bitmap_type(struct bitmap_test_data *tdata,
@@ -2497,6 +2512,11 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
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
@@ -2560,13 +2580,57 @@ static void test_show_commit(struct commit *commit, void *data)
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
@@ -2575,17 +2639,26 @@ void test_bitmap_walk(struct rev_info *revs)
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
@@ -2602,14 +2675,8 @@ void test_bitmap_walk(struct rev_info *revs)
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
 
@@ -2621,11 +2688,7 @@ void test_bitmap_walk(struct rev_info *revs)
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
2.46.0.86.ge766d390f0.dirty

