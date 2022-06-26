Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FDC433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiFZNKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiFZNKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1152B7C1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so4041172wmb.5
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jcHZa6OxZmATA8PmZA8rXPGZ6qgI9ipXlfsvYD2N1zc=;
        b=Z2EtUCKtpu0ye+TROZOm6SBDv6P5UjGXY3rnpeCuEBqEY+vi1lflR5MJQEGrmiFLjm
         2ADsgJdqq8fg4d8SUc9hal2HfOKmF79BezKZUpkmiKz5wd+xqdPfqEYl/kvgBqDvTSDu
         ezvNU9FaLbYVGd6dJudsHII9Zf7SQ1IySZcaenHHHywJKjLmGm6Dal7TDpwHE8S8VrKy
         mXjnPyFO0/C41Qhu/+49T2tgXAIGWYVVbPht+RhUApNtOvp2xBNmZEE1WENTDVvkBpAx
         zYk6WldYbQfvlt0AF3OVV4+monYFOhPf/7JfCbMGKJCVVT94a9nEM61pf4fq44H6Debt
         IDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jcHZa6OxZmATA8PmZA8rXPGZ6qgI9ipXlfsvYD2N1zc=;
        b=YwWgwRTfITV1EUH7PDQswtmlU4qsD1EljwIT3h/A5VZaZ4tABgqctlfA4Vf4v6qKEd
         MZuAmV9cPfVKYdQP5lbAydEGZyG4diY4KAprc3CmTK5N1LnrcUVRkGUedp9vqmZqPUFh
         L5jBezk/mKYLAXk1DcnV4rG8TiS3ksx4SpR+gfI1G4V94/apvJHYvFicgQUiNsBw5dTX
         H8D3T5gkwM5ZR+X0XJOeyHEW+J7xsNpX75qpfKZMs9fFAChstlnTlp1N84c7pXF56+yb
         WOf2pj0FLBi1ND6Hz1i6Kp5KA+LMuWbTKMsTc5Nm9Kvrs4kqzQIAU1G82yztLh5Hxfp1
         g1Zw==
X-Gm-Message-State: AJIora+EBIFfSKICbZXUVS+BQkhh7a1LgjqwqRngQdJPba+U8q5acikC
        tsRHLeS0kdNVSukehLtxCPfY9v8ZaRIY5Q==
X-Google-Smtp-Source: AGRyM1uT1v9O3iqs1b1YyxLGle55JxAy1H85Yguwi0jwS3q9VgCUUALz0fzBq7YQ8sTXk/1Yypk01A==
X-Received: by 2002:a1c:3b07:0:b0:3a0:333d:ae22 with SMTP id i7-20020a1c3b07000000b003a0333dae22mr9446816wma.1.1656249024049;
        Sun, 26 Jun 2022 06:10:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b00210bac248c8sm7695582wrq.11.2022.06.26.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:23 -0700 (PDT)
Message-Id: <4fbfcff8a208798146cd561b0185e094a116cf0e.1656249017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
        <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:15 +0000
Subject: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Earlier change teaches Git to write bitmap lookup table. But Git
does not know how to parse them.

Teach Git to parse the existing bitmap lookup table. The older
versions of git are not affected by it. Those versions ignore the
lookup table.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 pack-bitmap.c                 | 193 ++++++++++++++++++++++++++++++++--
 t/t5310-pack-bitmaps.sh       |   7 ++
 t/t5326-multi-pack-bitmaps.sh |   1 +
 3 files changed, 191 insertions(+), 10 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 36134222d7a..9e09c5824fc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -82,6 +82,12 @@ struct bitmap_index {
 	/* The checksum of the packfile or MIDX; points into map. */
 	const unsigned char *checksum;
 
+	/*
+	 * If not NULL, this point into the commit table extension
+	 * (within map).
+	 */
+	unsigned char *table_lookup;
+
 	/*
 	 * Extended index.
 	 *
@@ -185,6 +191,22 @@ static int load_bitmap_header(struct bitmap_index *index)
 			index->hashes = (void *)(index_end - cache_size);
 			index_end -= cache_size;
 		}
+
+		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
+			git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1)) {
+			size_t table_size = 0;
+			size_t triplet_sz = st_add3(sizeof(uint32_t),    /* commit position */
+							sizeof(uint64_t),    /* offset */
+							sizeof(uint32_t));    /* xor offset */
+
+			table_size = st_add(table_size,
+					st_mult(ntohl(header->entry_count),
+						triplet_sz));
+			if (table_size > index_end - index->map - header_size)
+				return error("corrupted bitmap index file (too short to fit lookup table)");
+			index->table_lookup = (void *)(index_end - table_size);
+			index_end -= table_size;
+		}
 	}
 
 	index->entry_count = ntohl(header->entry_count);
@@ -211,12 +233,20 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 
 	hash_pos = kh_put_oid_map(index->bitmaps, stored->oid, &ret);
 
-	/* a 0 return code means the insertion succeeded with no changes,
-	 * because the SHA1 already existed on the map. this is bad, there
-	 * shouldn't be duplicated commits in the index */
+	/* A 0 return code means the insertion succeeded with no changes,
+	 * because the SHA1 already existed on the map. If lookup table
+	 * is NULL, this is bad, there shouldn't be duplicated commits
+	 * in the index.
+	 *
+	 * If table_lookup exists, that means the desired bitmap is already
+	 * loaded. Either this bitmap has been stored directly or another
+	 * bitmap has a direct or indirect xor relation with it. */
 	if (ret == 0) {
-		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
-		return NULL;
+		if (!index->table_lookup) {
+			error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
+			return NULL;
+		}
+		return kh_value(index->bitmaps, hash_pos);
 	}
 
 	kh_value(index->bitmaps, hash_pos) = stored;
@@ -470,7 +500,7 @@ static int load_bitmap(struct bitmap_index *bitmap_git)
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
 		goto failed;
 
-	if (load_bitmap_entries_v1(bitmap_git) < 0)
+	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
 	return 0;
@@ -557,13 +587,145 @@ struct include_data {
 	struct bitmap *seen;
 };
 
+static inline const void *bitmap_get_triplet(struct bitmap_index *bitmap_git, uint32_t xor_pos)
+{
+	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
+	const void *p = bitmap_git->table_lookup + st_mult(xor_pos, triplet_sz);
+	return p;
+}
+
+static uint64_t triplet_get_offset(const void *triplet)
+{
+	const void *p = (unsigned char*) triplet + sizeof(uint32_t);
+	return get_be64(p);
+}
+
+static uint32_t triplet_get_xor_pos(const void *triplet)
+{
+	const void *p = (unsigned char*) triplet + st_add(sizeof(uint32_t), sizeof(uint64_t));
+	return get_be32(p);
+}
+
+static int triplet_cmp(const void *va, const void *vb)
+{
+	int result = 0;
+	uint32_t *a = (uint32_t *) va;
+	uint32_t b = get_be32(vb);
+	if (*a > b)
+		result = 1;
+	else if (*a < b)
+		result = -1;
+	else
+		result = 0;
+
+	return result;
+}
+
+static uint32_t bsearch_pos(struct bitmap_index *bitmap_git, struct object_id *oid,
+						uint32_t *result)
+{
+	int found;
+
+	if (bitmap_git->midx)
+		found = bsearch_midx(oid, bitmap_git->midx, result);
+	else
+		found = bsearch_pack(oid, bitmap_git->pack, result);
+
+	return found;
+}
+
+static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
+					  struct commit *commit)
+{
+	uint32_t commit_pos, xor_pos;
+	uint64_t offset;
+	int flags;
+	const void *triplet = NULL;
+	struct object_id *oid = &commit->object.oid;
+	struct ewah_bitmap *bitmap;
+	struct stored_bitmap *xor_bitmap = NULL;
+	size_t triplet_sz = st_add3(sizeof(uint32_t), sizeof(uint64_t), sizeof(uint32_t));
+
+	int found = bsearch_pos(bitmap_git, oid, &commit_pos);
+
+	if (!found)
+		return NULL;
+
+	triplet = bsearch(&commit_pos, bitmap_git->table_lookup, bitmap_git->entry_count,
+						triplet_sz, triplet_cmp);
+	if (!triplet)
+		return NULL;
+
+	offset = triplet_get_offset(triplet);
+	xor_pos = triplet_get_xor_pos(triplet);
+
+	if (xor_pos != 0xffffffff) {
+		int xor_flags;
+		uint64_t offset_xor;
+		uint32_t *xor_positions;
+		struct object_id xor_oid;
+		size_t size = 0;
+
+		ALLOC_ARRAY(xor_positions, bitmap_git->entry_count);
+		while (xor_pos != 0xffffffff) {
+			xor_positions[size++] = xor_pos;
+			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
+			xor_pos = triplet_get_xor_pos(triplet);
+		}
+
+		while (size){
+			xor_pos = xor_positions[size - 1];
+			triplet = bitmap_get_triplet(bitmap_git, xor_pos);
+			commit_pos = get_be32(triplet);
+			offset_xor = triplet_get_offset(triplet);
+
+			if (nth_bitmap_object_oid(bitmap_git, &xor_oid, commit_pos) < 0) {
+				free(xor_positions);
+				return NULL;
+			}
+
+			bitmap_git->map_pos = offset_xor + sizeof(uint32_t) + sizeof(uint8_t);
+			xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+			bitmap = read_bitmap_1(bitmap_git);
+
+			if (!bitmap){
+				free(xor_positions);
+				return NULL;
+			}
+
+			xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_oid, xor_bitmap, xor_flags);
+			size--;
+		}
+
+		free(xor_positions);
+	}
+
+	bitmap_git->map_pos = offset + sizeof(uint32_t) + sizeof(uint8_t);
+	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+	bitmap = read_bitmap_1(bitmap_git);
+
+	if (!bitmap)
+		return NULL;
+
+	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
+}
+
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
 	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
 					   commit->object.oid);
-	if (hash_pos >= kh_end(bitmap_git->bitmaps))
-		return NULL;
+	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
+		struct stored_bitmap *bitmap = NULL;
+		if (!bitmap_git->table_lookup)
+			return NULL;
+
+		/* NEEDSWORK: cache misses aren't recorded */
+		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
+		if(!bitmap)
+			return NULL;
+		return lookup_stored_bitmap(bitmap);
+	}
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
 }
 
@@ -1699,9 +1861,13 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (revs->pending.nr != 1)
 		die("you must specify exactly one commit to test");
 
-	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
+	fprintf(stderr, "Bitmap v%d test (%d entries)\n",
 		bitmap_git->version, bitmap_git->entry_count);
 
+	if (!bitmap_git->table_lookup)
+		fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
+			bitmap_git->version, bitmap_git->entry_count);
+
 	root = revs->pending.objects[0].item;
 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
 
@@ -1753,10 +1919,16 @@ void test_bitmap_walk(struct rev_info *revs)
 
 int test_bitmap_commits(struct repository *r)
 {
-	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
+	struct bitmap_index *bitmap_git = NULL;
 	struct object_id oid;
 	MAYBE_UNUSED void *value;
 
+	/* As this function is only used to print bitmap selected
+	 * commits, we don't have to read the commit table.
+	 */
+	setenv("GIT_TEST_READ_COMMIT_TABLE", "0", 1);
+
+	bitmap_git = prepare_bitmap_git(r);
 	if (!bitmap_git)
 		die("failed to load bitmap indexes");
 
@@ -1764,6 +1936,7 @@ int test_bitmap_commits(struct repository *r)
 		printf("%s\n", oid_to_hex(&oid));
 	});
 
+	setenv("GIT_TEST_READ_COMMIT_TABLE", "1", 1);
 	free_bitmap_index(bitmap_git);
 
 	return 0;
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index c669ed959e9..10d7691d973 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -42,6 +42,12 @@ test_expect_success 'full repack creates bitmaps' '
 	grep "\"label\":\"writing_lookup_table\"" trace
 '
 
+test_expect_success 'using lookup table loads only necessary bitmaps' '
+	git rev-list --test-bitmap HEAD 2>out &&
+	! grep "Bitmap v1 test (106 entries loaded)" out &&
+	grep "Found bitmap for" out
+'
+
 basic_bitmap_tests
 
 test_expect_success 'incremental repack fails when bitmaps are requested' '
@@ -255,6 +261,7 @@ test_expect_success 'pack reuse respects --incremental' '
 
 test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	test_config pack.writebitmaphashcache false &&
+	test_config pack.writebitmaplookuptable false &&
 	git repack -ad &&
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 43be49617b8..7d36dbcf722 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -320,4 +320,5 @@ test_expect_success 'multi-pack-index write writes lookup table if enabled' '
 		grep "\"label\":\"writing_lookup_table\"" trace
 	)
 '
+
 test_done
-- 
gitgitgadget

