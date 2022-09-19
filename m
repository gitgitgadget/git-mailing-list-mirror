Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26528ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiISRsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiISRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:47:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A443328
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso5072418wmr.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=8s6qy2aMuoR4p8e6H4B3Q2tNhoMA8Q4Ka4T3mMCfbFc=;
        b=ZhWLQsb0pvwElLqMd2CjHodqazUWcWDzLm9Mf17Q/giPbL86+GmiJKr4M0LR5eP311
         Hr/ICKX1YfMO9jSPZjXYbt1TdR74bHb6FVnqjPNdtllPXzyNr7+brPMdYTg2GL3i6UZL
         Cnt+Mra6Bn0sDSMrY0ABelEVMulITbkpZKHWf5QqU0uCsAmMHrbd0zCb+Zfua17NkGZr
         3I+4iyBuabyfuqSwb/rgbNy+NxefWRLaumvp4KDcToLAQnbdw3BvglLeQ2lwdPcfD6Dj
         A1ekYj1TMxsQMaQOLZnf1OwogTBVDVFzIMYkCQQOAZAtTyaChfkzgkLCnNxROhojeSoM
         kuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8s6qy2aMuoR4p8e6H4B3Q2tNhoMA8Q4Ka4T3mMCfbFc=;
        b=x4vkVlq7NzcsyJQE/J+3BE5/tZJ+HOnI9f6ert+D8x8nPH7qxjYmv+bq6K10+ZsIno
         cnfh1ThQntp7F6+RUUDzXa/ogOggFSkItBBBggGDEqK/VTDXh6BXP18D7ihXPb1CRU3X
         KVm8XkLbaDMkhkDZgE9ovMRpZ3rDMvLp/6hkGFhAtkqNZIAxLEezi/ZpJdSBt+luQsH7
         qnK/UQMttHjdmKWpFCPDJUtTob68MfkT5igVCDqYxp4aZ8dMf+e6hBs1B0DYQ0ofFAws
         eA9Sd/RK12xjnsVpN7C4OHbWRHhgvrpySVBG9aAY4bSqlezEdGfKs/2U+C7N6dBalu8s
         9ONQ==
X-Gm-Message-State: ACgBeo1n9gQNNMqpi7pf9FdufZxz0BtkfmrgvoOmYorIVcUBHGhGywm0
        K+Z76MwvLdhjAU3cxBf0j3+SLdIIVGs=
X-Google-Smtp-Source: AA6agR4tAVpPzHqmyA8p2KoOHlnv8YyRClcvLdkqFv6VMlVq83qNBeIPFLwiDQZKDzD7H7y2xI0WPg==
X-Received: by 2002:a05:600c:6018:b0:3b4:6c30:d9c1 with SMTP id az24-20020a05600c601800b003b46c30d9c1mr19608491wmb.144.1663609667656;
        Mon, 19 Sep 2022 10:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003b476bb2624sm14881270wme.6.2022.09.19.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:47:47 -0700 (PDT)
Message-Id: <7b49bbf2e28d3ff3dd648c51d2d8741e72b0e786.1663609660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 17:47:39 +0000
Subject: [PATCH 5/5] roaring: teach Git to read roaring bitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Git knows how to write roaring bitmaps but it still doesn't know
how to read roaring bitmaps. The changes are backward-compatible.

Teach Git to read roaring bitmaps.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 builtin/pack-objects.c  |  74 ++-
 pack-bitmap.c           | 969 ++++++++++++++++++++++++++++------------
 pack-bitmap.h           |   4 +-
 t/t5310-pack-bitmaps.sh |  84 ++--
 4 files changed, 798 insertions(+), 333 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 439c5572c18..e4011669889 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -218,7 +218,7 @@ static struct progress *progress_state;
 
 static struct packed_git *reuse_packfile;
 static uint32_t reuse_packfile_objects;
-static struct bitmap *reuse_packfile_bitmap;
+static void *reuse_packfile_bitmap;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
@@ -1084,15 +1084,29 @@ static size_t write_reused_pack_verbatim(struct hashfile *out,
 					 struct pack_window **w_curs)
 {
 	size_t pos = 0;
-
-	while (pos < reuse_packfile_bitmap->word_alloc &&
-			reuse_packfile_bitmap->words[pos] == (eword_t)~0)
-		pos++;
+	enum bitmap_type bm_type = get_bitmap_type();
+	trace2_region_enter("pack-objects", "write-reuse-v2-pack", the_repository);
+
+	if (bm_type == EWAH) {
+		struct bitmap *raw_reuse_packfile_bitmap = reuse_packfile_bitmap;
+		while (pos < raw_reuse_packfile_bitmap->word_alloc &&
+				raw_reuse_packfile_bitmap->words[pos] == (eword_t)~0)
+			pos++;
+		written = (pos * BITS_IN_EWORD);
+	}
+	else if (bm_type == ROARING) {
+		uint32_t cardinality = roaring_bitmap_get_cardinality(reuse_packfile_bitmap);
+		while (pos < cardinality && roaring_bitmap_contains(reuse_packfile_bitmap, pos))
+			pos++;
+		written = pos;
+	}
+	else
+		die(_("bitmap type is not initialized\n"));
+	trace2_region_leave("pack-objects", "write-reuse-v2-pack", the_repository);
 
 	if (pos) {
 		off_t to_write;
 
-		written = (pos * BITS_IN_EWORD);
 		to_write = pack_pos_to_offset(reuse_packfile, written)
 			- sizeof(struct pack_header);
 
@@ -1112,30 +1126,49 @@ static void write_reused_pack(struct hashfile *f)
 	size_t i = 0;
 	uint32_t offset;
 	struct pack_window *w_curs = NULL;
+	enum bitmap_type bm_type = get_bitmap_type();
+	trace2_region_enter("pack-objects", "write-reused-pack", the_repository);
 
 	if (allow_ofs_delta)
 		i = write_reused_pack_verbatim(f, &w_curs);
 
-	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
-		eword_t word = reuse_packfile_bitmap->words[i];
-		size_t pos = (i * BITS_IN_EWORD);
+	if (bm_type == EWAH) {
+		struct bitmap *raw_reuse_packfile_bitmap = reuse_packfile_bitmap;
+		for (; i < raw_reuse_packfile_bitmap->word_alloc; ++i) {
+			eword_t word = raw_reuse_packfile_bitmap->words[i];
+			size_t pos = (i * BITS_IN_EWORD);
 
-		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			if ((word >> offset) == 0)
-				break;
+			for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+				if ((word >> offset) == 0)
+					break;
 
-			offset += ewah_bit_ctz64(word >> offset);
-			/*
-			 * Can use bit positions directly, even for MIDX
-			 * bitmaps. See comment in try_partial_reuse()
-			 * for why.
-			 */
-			write_reused_pack_one(pos + offset, f, &w_curs);
+				offset += ewah_bit_ctz64(word >> offset);
+				/*
+				* Can use bit positions directly, even for MIDX
+				* bitmaps. See comment in try_partial_reuse()
+				* for why.
+				*/
+				write_reused_pack_one(pos + offset, f, &w_curs);
+				display_progress(progress_state, ++written);
+			}
+		}
+	}
+	else if (bm_type == ROARING) {
+		uint32_t cardinality = roaring_bitmap_get_cardinality(reuse_packfile_bitmap);
+		uint32_t *bm_arr = NULL;
+		roaring_bitmap_to_uint32_array(reuse_packfile_bitmap, bm_arr);
+
+		for (; i < cardinality; ++i) {
+			write_reused_pack_one(bm_arr[i], f, &w_curs);
 			display_progress(progress_state, ++written);
 		}
+		free(bm_arr);
 	}
+	else
+		die(_("bitmap_type not initialized"));
 
 	unuse_pack(&w_curs);
+	trace2_region_leave("pack-objects", "write-reused-pack", the_repository);
 }
 
 static void write_excluded_by_configs(void)
@@ -1260,6 +1293,7 @@ static void write_pack_file(void)
 			if (write_bitmap_index) {
 				bitmap_writer_init_bm_type(write_bitmap_options);
 				bitmap_writer_set_checksum(hash);
+				fprintf(stderr, "hi man\n");
 				bitmap_writer_build_type_index(
 					&to_pack, written_list, nr_written);
 			}
@@ -1279,9 +1313,11 @@ static void write_pack_file(void)
 				stop_progress(&progress_state);
 
 				bitmap_writer_show_progress(progress);
+				fprintf(stderr, "hello I am working good\n");
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				if (bitmap_writer_build(&to_pack) < 0)
 					die(_("failed to write bitmap index"));
+				fprintf(stderr, "after building bitmaps\n");
 				bitmap_writer_finish(written_list, nr_written,
 						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index c1a0bc26d02..6c0b72d4503 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -16,6 +16,7 @@
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
+#include "chunk-format.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -23,7 +24,7 @@
  */
 struct stored_bitmap {
 	struct object_id oid;
-	struct ewah_bitmap *root;
+	void *root;
 	struct stored_bitmap *xor;
 	int flags;
 };
@@ -66,10 +67,10 @@ struct bitmap_index {
 	 * type. This provides type information when yielding the objects from
 	 * the packfile during a walk, which allows for better delta bases.
 	 */
-	struct ewah_bitmap *commits;
-	struct ewah_bitmap *trees;
-	struct ewah_bitmap *blobs;
-	struct ewah_bitmap *tags;
+	void *commits;
+	void *trees;
+	void *blobs;
+	void *tags;
 
 	/* Map from object ID -> `stored_bitmap` for all the bitmapped commits */
 	kh_oid_map_t *bitmaps;
@@ -104,28 +105,37 @@ struct bitmap_index {
 	} ext_index;
 
 	/* Bitmap result of the last performed walk */
-	struct bitmap *result;
+	void *result;
 
 	/* "have" bitmap from the last performed walk */
-	struct bitmap *haves;
+	void *haves;
 
 	/* Version of the bitmap index */
 	unsigned int version;
+
+	/* for version 2 */
+	unsigned char chunk_nr;
 };
 
-static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
+static void *lookup_stored_bitmap(struct bitmap_index *index, struct stored_bitmap *st)
 {
-	struct ewah_bitmap *parent;
-	struct ewah_bitmap *composed;
+	void *parent;
+	void *composed;
 
 	if (!st->xor)
 		return st->root;
 
-	composed = ewah_pool_new();
-	parent = lookup_stored_bitmap(st->xor);
-	ewah_xor(st->root, parent, composed);
+	if (index->version == 1) {
+		composed = ewah_pool_new();
+		parent = lookup_stored_bitmap(index, st->xor);
+		ewah_xor(st->root, parent, composed);
 
-	ewah_pool_free(st->root);
+		ewah_pool_free(st->root);
+	}
+	else if (index->version == 2) {
+		parent = lookup_stored_bitmap(index, st->xor);
+		composed = roaring_bitmap_xor(st->root, parent);
+	}
 	st->root = composed;
 	st->xor = NULL;
 
@@ -154,6 +164,20 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 	return b;
 }
 
+static roaring_bitmap_t *read_roaring_bitmap(struct bitmap_index *index, size_t  max_limit)
+{
+	roaring_bitmap_t *rb = NULL;
+	size_t bitmap_size = roaring_bitmap_portable_network_deserialize_size((const char *)index->map + index->map_pos, max_limit);
+
+	if (bitmap_size ==  0) {
+		error(_("failed to load bitmap index (corrupted?)"));
+		return NULL;
+	}
+	rb = roaring_bitmap_portable_network_deserialize_safe((const char *)index->map + index->map_pos, max_limit);
+	index->map_pos += bitmap_size;
+	return rb;
+}
+
 static uint32_t bitmap_num_objects(struct bitmap_index *index)
 {
 	if (index->midx)
@@ -161,10 +185,39 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
 	return index->pack->num_objects;
 }
 
+static int ewah_load_bitmap_header(struct bitmap_index *index,
+				       struct bitmap_disk_header *header,
+				       uint32_t flags)
+{
+	ssize_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
+	size_t cache_size = st_mult(bitmap_num_objects(index), sizeof(uint32_t));
+	unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
+
+	if (flags & BITMAP_OPT_HASH_CACHE) {
+		if (cache_size > index_end - index->map - header_size)
+			return error(_("corrupted bitmap index file (too short to fit hash cache)"));
+		index->hashes = (void *)(index_end - cache_size);
+		index_end -= cache_size;
+	}
+
+	if (flags & BITMAP_OPT_LOOKUP_TABLE) {
+		size_t table_size = st_mult(ntohl(header->entry_count),
+						BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
+		if (table_size > index_end - index->map - header_size)
+			return error(_("corrupted bitmap index file (too short to fit lookup table)"));
+		if (git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1))
+			index->table_lookup = (void *)(index_end - table_size);
+		index_end -= table_size;
+	}
+	index->map_pos += header_size;
+	return 0;
+}
+
 static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
 	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
+	uint32_t flags = ntohs(header->options);
 
 	if (index->map_size < header_size + the_hash_algo->rawsz)
 		return error(_("corrupted bitmap index (too small)"));
@@ -172,46 +225,29 @@ static int load_bitmap_header(struct bitmap_index *index)
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
 		return error(_("corrupted bitmap index file (wrong header)"));
 
-	index->version = ntohs(header->version);
-	if (index->version != 1)
-		return error(_("unsupported version '%d' for bitmap index file"), index->version);
-
-	/* Parse known bitmap format options */
-	{
-		uint32_t flags = ntohs(header->options);
-		size_t cache_size = st_mult(bitmap_num_objects(index), sizeof(uint32_t));
-		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
-
-		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
-			BUG("unsupported options for bitmap index file "
-				"(Git requires BITMAP_OPT_FULL_DAG)");
-
-		if (flags & BITMAP_OPT_HASH_CACHE) {
-			if (cache_size > index_end - index->map - header_size)
-				return error(_("corrupted bitmap index file (too short to fit hash cache)"));
-			index->hashes = (void *)(index_end - cache_size);
-			index_end -= cache_size;
-		}
-
-		if (flags & BITMAP_OPT_LOOKUP_TABLE) {
-			size_t table_size = st_mult(ntohl(header->entry_count),
-						    BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
-			if (table_size > index_end - index->map - header_size)
-				return error(_("corrupted bitmap index file (too short to fit lookup table)"));
-			if (git_env_bool("GIT_TEST_READ_COMMIT_TABLE", 1))
-				index->table_lookup = (void *)(index_end - table_size);
-			index_end -= table_size;
-		}
-	}
+	if ((flags & BITMAP_OPT_FULL_DAG) == 0)
+		BUG("unsupported options for bitmap index file "
+			"(Git requires BITMAP_OPT_FULL_DAG)");
 
+	index->version = ntohs(header->version);
 	index->entry_count = ntohl(header->entry_count);
 	index->checksum = header->checksum;
-	index->map_pos += header_size;
-	return 0;
+	if (index->version == 1) {
+		set_bitmap_type(EWAH);
+		return ewah_load_bitmap_header(index, header, flags);
+	}
+	if (index->version == 2) {
+		set_bitmap_type(ROARING);
+		index->chunk_nr = *(index->map + header_size);
+		index->map_pos += header_size + sizeof(char);
+		return 0;
+	}
+
+	return error(_("unsupported version '%d' for bitmap index file"), index->version);
 }
 
 static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
-					  struct ewah_bitmap *root,
+					  void *root,
 					  const struct object_id *oid,
 					  struct stored_bitmap *xor_with,
 					  int flags)
@@ -484,6 +520,105 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
 	return load_pack_revindex(bitmap_git->pack);
 }
 
+static int load_ewah_bitmap(struct bitmap_index *bitmap_git)
+{
+	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
+		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
+		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
+		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
+		return -1;
+
+	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
+		return -1;
+	return 0;
+}
+
+
+static int load_roaring_type_index(const unsigned char *chunk_start,
+				   size_t chunk_size, void *data)
+{
+	struct bitmap_index *index = data;
+	size_t initial_map_pos = chunk_start - index->map;
+	index->map_pos = initial_map_pos;
+
+	if (!(index->commits = read_roaring_bitmap(index, chunk_size)) ||
+		!(index->trees = read_roaring_bitmap(index, chunk_size - (index->map_pos - initial_map_pos))) ||
+		!(index->blobs = read_roaring_bitmap(index, chunk_size - (index->map_pos - initial_map_pos))) ||
+		!(index->tags = read_roaring_bitmap(index, chunk_size - (index->map_pos - initial_map_pos))))
+		return 1;
+	return 0;
+}
+
+static int load_bitmap_entries_v2(const unsigned char *chunk_start,
+				     size_t chunk_size, void *data)
+{
+	struct stored_bitmap *recent_bitmaps[MAX_XOR_OFFSET] = { NULL };
+	struct bitmap_index *index = data;
+	size_t max_limit = chunk_size;
+	size_t initial_map_pos = chunk_start - index->map;
+	uint32_t i;
+	index->map_pos = initial_map_pos;
+
+	for (i = 0; i < index->entry_count; i++) {
+		int xor_offset, flags;
+		roaring_bitmap_t *bitmap = NULL;
+		struct stored_bitmap *xor_bitmap = NULL;
+		uint32_t commit_idx_pos;
+		struct object_id oid;
+
+		max_limit = chunk_size - (index->map_pos - initial_map_pos);
+
+		if (max_limit < 6)
+			return error(_("corrupt roaring bitmap: truncated header for entry %d"), i);
+
+		commit_idx_pos = read_be32(index->map, &index->map_pos);
+		xor_offset = read_u8(index->map, &index->map_pos);
+		flags = read_u8(index->map, &index->map_pos);
+
+		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
+			return error(_("corrupt roaring bitmap: commit index %u out of range"),
+				     (unsigned)commit_idx_pos);
+
+		bitmap = read_roaring_bitmap(index, max_limit);
+		if (!bitmap)
+			return -1;
+
+		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
+			return error(_("corrupted bitmap pack index"));
+
+		if (xor_offset > 0) {
+			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
+
+			if (!xor_bitmap)
+				return error(_("invalid XOR offset in bitmap pack index"));
+		}
+
+		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
+			index, bitmap, &oid, xor_bitmap, flags);
+	}
+	return 0;
+}
+
+static int load_roaring_bitmap(struct bitmap_index *bitmap_git)
+{
+	struct chunkfile *cf = init_chunkfile(NULL);
+	trace2_region_enter("pack-bitmap", "load-roaring-bitmap", the_repository);
+	if (read_table_of_contents(cf, bitmap_git->map, bitmap_git->map_size,
+				   bitmap_git->map_pos,
+				   bitmap_git->chunk_nr))
+		return -1;
+
+	if (read_chunk(cf, BITMAP_TYPE_INDEXES, load_roaring_type_index, bitmap_git) == CHUNK_NOT_FOUND)
+		die(_("bitmap file missing required type index chunk"));
+	pair_chunk(cf, BITMAP_LOOKUP_TABLE, (const unsigned char **)&bitmap_git->table_lookup);
+	if (!bitmap_git->table_lookup && read_chunk(cf, BITMAP_REACHABILITY_BITMAPS,
+		 load_bitmap_entries_v2, bitmap_git) == CHUNK_NOT_FOUND)
+		die(_("bitmap file missing required reachability chunk"));
+	pair_chunk(cf, BITMAP_HASH_CACHE, (const unsigned char **)&bitmap_git->hashes);
+	trace2_region_leave("pack-bitmap", "load-roaring-bitmap", the_repository);
+	return 0;
+}
+
 static int load_bitmap(struct bitmap_index *bitmap_git)
 {
 	assert(bitmap_git->map);
@@ -494,13 +629,9 @@ static int load_bitmap(struct bitmap_index *bitmap_git)
 	if (load_reverse_index(bitmap_git))
 		goto failed;
 
-	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
-		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
-		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
-		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
+	if (bitmap_git->version == 1 && load_ewah_bitmap(bitmap_git) < 0)
 		goto failed;
-
-	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
+	else if (bitmap_git->version == 2 && load_roaring_bitmap(bitmap_git) < 0)
 		goto failed;
 
 	return 0;
@@ -563,6 +694,12 @@ static int open_bitmap(struct repository *r,
 struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+	bitmap_git->haves = NULL;
+	bitmap_git->result = NULL;
+	bitmap_git->commits = NULL;
+	bitmap_git->trees = NULL;
+	bitmap_git->blobs = NULL;
+	bitmap_git->tags = NULL;
 
 	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
 		return bitmap_git;
@@ -584,8 +721,8 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 
 struct include_data {
 	struct bitmap_index *bitmap_git;
-	struct bitmap *base;
-	struct bitmap *seen;
+	void *base;
+	void *seen;
 };
 
 struct bitmap_lookup_table_triplet {
@@ -696,12 +833,13 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	int flags;
 	struct bitmap_lookup_table_triplet triplet;
 	struct object_id *oid = &commit->object.oid;
-	struct ewah_bitmap *bitmap;
+	void *bitmap;
 	struct stored_bitmap *xor_bitmap = NULL;
 	const int bitmap_header_size = 6;
 	static struct bitmap_lookup_table_xor_item *xor_items = NULL;
 	static size_t xor_items_nr = 0, xor_items_alloc = 0;
 	static int is_corrupt = 0;
+	size_t max_limit = 0;
 	int xor_flags;
 	khiter_t hash_pos;
 	struct bitmap_lookup_table_xor_item *xor_item;
@@ -766,7 +904,15 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 
 		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
 		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
-		bitmap = read_bitmap_1(bitmap_git);
+		if (bitmap_git->version == 1)
+			bitmap = read_bitmap_1(bitmap_git);
+		else if (bitmap_git->version == 2) {
+			if (bitmap_git->hashes)
+				max_limit = ((unsigned char *)bitmap_git->hashes - bitmap_git->map) - bitmap_git->map_pos;
+			else
+				max_limit = (bitmap_git->table_lookup - bitmap_git->map) - bitmap_git->map_pos;
+			bitmap = read_roaring_bitmap(bitmap_git, max_limit);
+		}
 
 		if (!bitmap)
 			goto corrupt;
@@ -807,7 +953,15 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	 */
 	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
 	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
-	bitmap = read_bitmap_1(bitmap_git);
+
+	if (bitmap_git->hashes)
+		max_limit = ((unsigned char *)bitmap_git->hashes - bitmap_git->map) - bitmap_git->map_pos;
+	else
+		max_limit = (bitmap_git->table_lookup - bitmap_git->map) - bitmap_git->map_pos;
+	if (bitmap_git->version == 1)
+		bitmap = read_bitmap_1(bitmap_git);
+	else if (bitmap_git->version == 2)
+		bitmap = read_roaring_bitmap(bitmap_git, max_limit);
 
 	if (!bitmap)
 		goto corrupt;
@@ -820,8 +974,8 @@ corrupt:
 	return NULL;
 }
 
-struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
-				      struct commit *commit)
+void *bitmap_for_commit(struct bitmap_index *bitmap_git,
+			struct commit *commit)
 {
 	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
 					   commit->object.oid);
@@ -836,9 +990,9 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
 		if (!bitmap)
 			return NULL;
-		return lookup_stored_bitmap(bitmap);
+		return lookup_stored_bitmap(bitmap_git, bitmap);
 	}
-	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
+	return lookup_stored_bitmap(bitmap_git, kh_value(bitmap_git->bitmaps, hash_pos));
 }
 
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
@@ -922,7 +1076,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 
 struct bitmap_show_data {
 	struct bitmap_index *bitmap_git;
-	struct bitmap *base;
+	void *base;
 };
 
 static void show_object(struct object *object, const char *name, void *data_)
@@ -936,7 +1090,7 @@ static void show_object(struct object *object, const char *name, void *data_)
 		bitmap_pos = ext_index_add_object(data->bitmap_git, object,
 						  name);
 
-	raw_bitmap_set(data->base, bitmap_pos);
+	roaring_or_raw_bitmap_set(data->base, bitmap_pos);
 }
 
 static void show_commit(struct commit *commit, void *data)
@@ -948,21 +1102,24 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 			      struct commit *commit,
 			      int bitmap_pos)
 {
-	struct ewah_bitmap *partial;
+	void *partial;
 
-	if (data->seen && raw_bitmap_get(data->seen, bitmap_pos))
+	if (data->seen && roaring_or_raw_bitmap_get(data->seen, bitmap_pos))
 		return 0;
 
-	if (raw_bitmap_get(data->base, bitmap_pos))
+	if (roaring_or_raw_bitmap_get(data->base, bitmap_pos))
 		return 0;
 
 	partial = bitmap_for_commit(bitmap_git, commit);
 	if (partial) {
-		raw_bitmap_or_ewah(data->base, partial);
+		if (bitmap_git->version == 1)
+			raw_bitmap_or_ewah(data->base, partial);
+		else if (bitmap_git->version == 2)
+			roaring_bitmap_or(data->base, partial);
 		return 0;
 	}
 
-	raw_bitmap_set(data->base, bitmap_pos);
+	roaring_or_raw_bitmap_set(data->base, bitmap_pos);
 	return 1;
 }
 
@@ -999,8 +1156,8 @@ static int should_include_obj(struct object *obj, void *_data)
 	bitmap_pos = bitmap_position(data->bitmap_git, &obj->oid);
 	if (bitmap_pos < 0)
 		return 1;
-	if ((data->seen && raw_bitmap_get(data->seen, bitmap_pos)) ||
-	     raw_bitmap_get(data->base, bitmap_pos)) {
+	if ((data->seen && roaring_or_raw_bitmap_get(data->seen, bitmap_pos)) ||
+	     roaring_or_raw_bitmap_get(data->base, bitmap_pos)) {
 		obj->flags |= SEEN;
 		return 0;
 	}
@@ -1008,28 +1165,36 @@ static int should_include_obj(struct object *obj, void *_data)
 }
 
 static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
-				struct bitmap **base,
+				void **base,
 				struct commit *commit)
 {
-	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
+	void *or_with = bitmap_for_commit(bitmap_git, commit);
 
 	if (!or_with)
 		return 0;
 
-	if (!*base)
-		*base = ewah_to_raw_bitmap(or_with);
-	else
-		raw_bitmap_or_ewah(*base, or_with);
+	if (!*base) {
+		if (bitmap_git->version == 1)
+			*base = ewah_to_raw_bitmap(or_with);
+		else if (bitmap_git->version == 2)
+			*base = roaring_bitmap_copy(or_with);
+	}
+	else {
+		if (bitmap_git->version == 1)
+			raw_bitmap_or_ewah(*base, or_with);
+		else if (bitmap_git->version == 2)
+			roaring_bitmap_or(*base, or_with);
+	}
 
 	return 1;
 }
 
-static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
+static void *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
-				   struct bitmap *seen)
+				   void *seen)
 {
-	struct bitmap *base = NULL;
+	void *base = NULL;
 	int needs_walk = 0;
 
 	struct object_list *not_mapped = NULL;
@@ -1080,7 +1245,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		roots = roots->next;
 		pos = bitmap_position(bitmap_git, &object->oid);
 
-		if (pos < 0 || base == NULL || !raw_bitmap_get(base, pos)) {
+		if (pos < 0 || base == NULL || !roaring_or_raw_bitmap_get(base, pos)) {
 			object->flags &= ~UNINTERESTING;
 			add_pending_object(revs, object, "");
 			needs_walk = 1;
@@ -1094,7 +1259,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		struct bitmap_show_data show_data;
 
 		if (!base)
-			base = raw_bitmap_new();
+			base = roaring_or_raw_bitmap_new();
 
 		incdata.bitmap_git = bitmap_git;
 		incdata.base = base;
@@ -1126,14 +1291,14 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 				  struct rev_info *revs,
 				  show_reachable_fn show_reach)
 {
-	struct bitmap *objects = bitmap_git->result;
+	void *objects = bitmap_git->result;
 	struct eindex *eindex = &bitmap_git->ext_index;
 	uint32_t i;
 
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!raw_bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
+		if (!roaring_or_raw_bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		obj = eindex->objects[i];
@@ -1233,6 +1398,77 @@ static void show_objects_for_type(
 	}
 }
 
+static void *get_roaring_type_index(struct bitmap_index *bitmap_git,
+				   enum object_type object_type)
+{
+	switch (object_type) {
+	case OBJ_COMMIT:
+		return bitmap_git->commits;
+
+	case OBJ_TREE:
+		return bitmap_git->trees;
+
+	case OBJ_BLOB:
+		return bitmap_git->blobs;
+
+	case OBJ_TAG:
+		return bitmap_git->tags;
+	default:
+		BUG("object type %d not stored by bitmap type index", object_type);
+		break;
+	}
+
+}
+
+static void show_roaring_objects_for_type(struct bitmap_index *bitmap_git,
+					  enum object_type object_type,
+					  show_reachable_fn show_reach)
+{
+	uint32_t i;
+	roaring_bitmap_t *type_index = NULL;
+	roaring_bitmap_t *objects = bitmap_git->result;
+	roaring_bitmap_t *fl_objects = NULL;
+	uint32_t *filter_objects = NULL;
+	uint32_t cardinality = 0;
+
+	type_index = get_roaring_type_index(bitmap_git, object_type);
+
+	fl_objects = roaring_bitmap_and(objects, type_index);
+	cardinality = roaring_bitmap_get_cardinality(fl_objects);
+	roaring_bitmap_to_uint32_array(fl_objects, filter_objects);
+	roaring_bitmap_free(fl_objects);
+
+	for (i = 0; i < cardinality; i++) {
+		struct packed_git *pack;
+		struct object_id oid;
+		uint32_t hash = 0, index_pos;
+		off_t ofs;
+
+		if (bitmap_is_midx(bitmap_git)) {
+			struct multi_pack_index *m = bitmap_git->midx;
+			uint32_t pack_id;
+
+			index_pos = pack_pos_to_midx(m, filter_objects[i]);
+			ofs = nth_midxed_offset(m, index_pos);
+			nth_midxed_object_oid(&oid, m, index_pos);
+
+			pack_id = nth_midxed_pack_int_id(m, index_pos);
+			pack = bitmap_git->midx->packs[pack_id];
+		} else {
+			index_pos = pack_pos_to_index(bitmap_git->pack, filter_objects[i]);
+			ofs = pack_pos_to_offset(bitmap_git->pack, filter_objects[i]);
+			nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
+
+			pack = bitmap_git->pack;
+		}
+
+		if (bitmap_git->hashes)
+			hash = get_be32(bitmap_git->hashes + index_pos);
+
+		show_reach(&oid, object_type, 0, hash, pack, ofs);
+	}
+}
+
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 			     struct object_list *roots)
 {
@@ -1252,11 +1488,11 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
-static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
+static void *find_tip_objects(struct bitmap_index *bitmap_git,
 				       struct object_list *tip_objects,
 				       enum object_type type)
 {
-	struct bitmap *result = raw_bitmap_new();
+	void *result = roaring_or_raw_bitmap_new();
 	struct object_list *p;
 
 	for (p = tip_objects; p; p = p->next) {
@@ -1269,7 +1505,7 @@ static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
 		if (pos < 0)
 			continue;
 
-		raw_bitmap_set(result, pos);
+		roaring_or_raw_bitmap_set(result, pos);
 	}
 
 	return result;
@@ -1277,13 +1513,11 @@ static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
 
 static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 				       struct object_list *tip_objects,
-				       struct bitmap *to_filter,
+				       void *to_filter,
 				       enum object_type type)
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
-	struct bitmap *tips;
-	struct ewah_iterator it;
-	eword_t mask;
+	void *tips;
 	uint32_t i;
 
 	/*
@@ -1293,17 +1527,33 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 */
 	tips = find_tip_objects(bitmap_git, tip_objects, type);
 
-	/*
-	 * We can use the type-level bitmap for 'type' to work in whole
-	 * words for the objects that are actually in the bitmapped
-	 * packfile.
-	 */
-	for (i = 0, init_type_iterator(&it, bitmap_git, type);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
-	     i++) {
-		if (i < tips->word_alloc)
-			mask &= ~tips->words[i];
-		to_filter->words[i] &= ~mask;
+	if (bitmap_git->version == 1) {
+		struct bitmap *raw_tips = tips;
+		struct bitmap *to_filter_raw = to_filter;
+		struct ewah_iterator it;
+		eword_t mask;
+
+		/*
+		* We can use the type-level bitmap for 'type' to work in whole
+		* words for the objects that are actually in the bitmapped
+		* packfile.
+		*/
+		for (i = 0, init_type_iterator(&it, bitmap_git, type);
+		i < to_filter_raw->word_alloc && ewah_iterator_next(&mask, &it);
+		i++) {
+			if (i < raw_tips->word_alloc)
+				mask &= ~raw_tips->words[i];
+			to_filter_raw->words[i] &= ~mask;
+		}
+	}
+	else if (bitmap_git->version == 2) {
+		roaring_bitmap_t *type_index = NULL;
+		roaring_bitmap_t *not_tip_type = NULL;
+
+		type_index = get_roaring_type_index(bitmap_git, type);
+		not_tip_type = roaring_bitmap_andnot(tips, type_index);
+		roaring_bitmap_andnot_inplace(to_filter, not_tip_type);
+		roaring_bitmap_free(not_tip_type);
 	}
 
 	/*
@@ -1314,17 +1564,17 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == type &&
-		    raw_bitmap_get(to_filter, pos) &&
-		    !raw_bitmap_get(tips, pos))
-			raw_bitmap_unset(to_filter, pos);
+		    roaring_or_raw_bitmap_get(to_filter, pos) &&
+		    !roaring_or_raw_bitmap_get(tips, pos))
+			roaring_or_raw_bitmap_unset(to_filter, pos);
 	}
 
-	raw_bitmap_free(tips);
+	roaring_or_raw_bitmap_free(tips);
 }
 
 static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 				    struct object_list *tip_objects,
-				    struct bitmap *to_filter)
+				    void *to_filter)
 {
 	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
 				   OBJ_BLOB);
@@ -1371,47 +1621,64 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 				     struct object_list *tip_objects,
-				     struct bitmap *to_filter,
+				     void *to_filter,
 				     unsigned long limit)
 {
-	struct eindex *eindex = &bitmap_git->ext_index;
-	struct bitmap *tips;
-	struct ewah_iterator it;
-	eword_t mask;
 	uint32_t i;
+	struct eindex *eindex = &bitmap_git->ext_index;
+	void *tips;
 
 	tips = find_tip_objects(bitmap_git, tip_objects, OBJ_BLOB);
 
-	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
-	     i++) {
-		eword_t word = to_filter->words[i] & mask;
-		unsigned offset;
+	if (bitmap_git->version == 1) {
+		struct bitmap *to_filter_raw = to_filter;
+		struct ewah_iterator it;
+		eword_t mask;
 
-		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
-			uint32_t pos;
+		for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
+		i < to_filter_raw->word_alloc && ewah_iterator_next(&mask, &it);
+		i++) {
+			eword_t word = to_filter_raw->words[i] & mask;
+			unsigned offset;
 
-			if ((word >> offset) == 0)
-				break;
-			offset += ewah_bit_ctz64(word >> offset);
-			pos = i * BITS_IN_EWORD + offset;
+			for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+				uint32_t pos;
 
-			if (!raw_bitmap_get(tips, pos) &&
-			    get_size_by_pos(bitmap_git, pos) >= limit)
-				raw_bitmap_unset(to_filter, pos);
+				if ((word >> offset) == 0)
+					break;
+				offset += ewah_bit_ctz64(word >> offset);
+				pos = i * BITS_IN_EWORD + offset;
+
+				if (!raw_bitmap_get(tips, pos) &&
+				get_size_by_pos(bitmap_git, pos) >= limit)
+					raw_bitmap_unset(to_filter, pos);
+			}
+		}
+	}
+	else if (bitmap_git->version == 2) {
+		roaring_bitmap_t *filter_bitmap = roaring_bitmap_and(to_filter, tips);
+		uint32_t *filter_arr = NULL;
+		uint32_t cardinality = roaring_bitmap_get_cardinality(filter_bitmap);
+		roaring_bitmap_to_uint32_array(filter_bitmap, filter_arr);
+		roaring_bitmap_free(filter_bitmap);
+
+		for (i = 0; i < cardinality; i++) {
+			if (!roaring_bitmap_contains(to_filter, filter_arr[i]) &&
+			get_size_by_pos(bitmap_git, filter_arr[i]) >= limit)
+				roaring_bitmap_remove(to_filter, filter_arr[i]);
 		}
 	}
 
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == OBJ_BLOB &&
-		    raw_bitmap_get(to_filter, pos) &&
-		    !raw_bitmap_get(tips, pos) &&
+		    roaring_or_raw_bitmap_get(to_filter, pos) &&
+		    !roaring_or_raw_bitmap_get(tips, pos) &&
 		    get_size_by_pos(bitmap_git, pos) >= limit)
-			raw_bitmap_unset(to_filter, pos);
+			roaring_or_raw_bitmap_unset(to_filter, pos);
 	}
 
-	raw_bitmap_free(tips);
+	roaring_or_raw_bitmap_free(tips);
 }
 
 static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
@@ -1430,7 +1697,7 @@ static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
 
 static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 				      struct object_list *tip_objects,
-				      struct bitmap *to_filter,
+				      void *to_filter,
 				      enum object_type object_type)
 {
 	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
@@ -1448,7 +1715,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
-			 struct bitmap *to_filter,
+			 void *to_filter,
 			 struct list_objects_filter_options *filter)
 {
 	if (!filter || filter->choice == LOFC_DISABLED)
@@ -1513,8 +1780,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	struct object_list *wants = NULL;
 	struct object_list *haves = NULL;
 
-	struct bitmap *wants_bitmap = NULL;
-	struct bitmap *haves_bitmap = NULL;
+	void *wants_bitmap = NULL;
+	void *haves_bitmap = NULL;
 
 	struct bitmap_index *bitmap_git;
 
@@ -1597,7 +1864,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 		BUG("failed to perform bitmap walk");
 
 	if (haves_bitmap)
-		raw_bitmap_and_not(wants_bitmap, haves_bitmap);
+		roaring_or_raw_bitmap_and_not(wants_bitmap, haves_bitmap);
 
 	filter_bitmap(bitmap_git,
 		      (revs->filter.choice && filter_provided_objects) ? NULL : wants,
@@ -1625,7 +1892,7 @@ cleanup:
  */
 static int try_partial_reuse(struct packed_git *pack,
 			     size_t pos,
-			     struct bitmap *reuse,
+			     void *reuse,
 			     struct pack_window **w_curs)
 {
 	off_t offset, delta_obj_offset;
@@ -1702,14 +1969,14 @@ static int try_partial_reuse(struct packed_git *pack,
 		 * to REF_DELTA on the fly. Better to just let the normal
 		 * object_entry code path handle it.
 		 */
-		if (!raw_bitmap_get(reuse, base_pos))
+		if (!roaring_or_raw_bitmap_get(reuse, base_pos))
 			return 0;
 	}
 
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
-	raw_bitmap_set(reuse, pos);
+	roaring_or_raw_bitmap_set(reuse, pos);
 	return 0;
 }
 
@@ -1724,11 +1991,11 @@ uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				       struct packed_git **packfile_out,
 				       uint32_t *entries,
-				       struct bitmap **reuse_out)
+				       void **reuse_out)
 {
 	struct packed_git *pack;
-	struct bitmap *result = bitmap_git->result;
-	struct bitmap *reuse;
+	void *result = bitmap_git->result;
+	void *reuse;
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
 	uint32_t offset;
@@ -1744,54 +2011,71 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		pack = bitmap_git->pack;
 	objects_nr = pack->num_objects;
 
-	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
-		i++;
-
-	/*
-	 * Don't mark objects not in the packfile or preferred pack. This bitmap
-	 * marks objects eligible for reuse, but the pack-reuse code only
-	 * understands how to reuse a single pack. Since the preferred pack is
-	 * guaranteed to have all bases for its deltas (in a multi-pack bitmap),
-	 * we use it instead of another pack. In single-pack bitmaps, the choice
-	 * is made for us.
-	 */
-	if (i > objects_nr / BITS_IN_EWORD)
-		i = objects_nr / BITS_IN_EWORD;
-
-	reuse = raw_bitmap_word_alloc(i);
-	memset(reuse->words, 0xFF, i * sizeof(eword_t));
-
-	for (; i < result->word_alloc; ++i) {
-		eword_t word = result->words[i];
-		size_t pos = (i * BITS_IN_EWORD);
+	if (bitmap_git->version == 1) {
+		struct bitmap *result_raw = result;
+		struct bitmap *reuse_raw = NULL;
 
-		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			if ((word >> offset) == 0)
-				break;
+		while (i < result_raw->word_alloc && result_raw->words[i] == (eword_t)~0)
+			i++;
 
-			offset += ewah_bit_ctz64(word >> offset);
-			if (try_partial_reuse(pack, pos + offset,
-					      reuse, &w_curs) < 0) {
-				/*
-				 * try_partial_reuse indicated we couldn't reuse
-				 * any bits, so there is no point in trying more
-				 * bits in the current word, or any other words
-				 * in result.
-				 *
-				 * Jump out of both loops to avoid future
-				 * unnecessary calls to try_partial_reuse.
-				 */
-				goto done;
+		/*
+		* Don't mark objects not in the packfile or preferred pack. This bitmap
+		* marks objects eligible for reuse, but the pack-reuse code only
+		* understands how to reuse a single pack. Since the preferred pack is
+		* guaranteed to have all bases for its deltas (in a multi-pack bitmap),
+		* we use it instead of another pack. In single-pack bitmaps, the choice
+		* is made for us.
+		*/
+		if (i > objects_nr / BITS_IN_EWORD)
+			i = objects_nr / BITS_IN_EWORD;
+
+		reuse_raw = raw_bitmap_word_alloc(i);
+		memset(reuse_raw->words, 0xFF, i * sizeof(eword_t));
+
+		for (; i < result_raw->word_alloc; ++i) {
+			eword_t word = result_raw->words[i];
+			size_t pos = (i * BITS_IN_EWORD);
+
+			for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+				if ((word >> offset) == 0)
+					break;
+
+				offset += ewah_bit_ctz64(word >> offset);
+				if (try_partial_reuse(pack, pos + offset,
+						reuse_raw, &w_curs) < 0) {
+					/*
+					* try_partial_reuse indicated we couldn't reuse
+					* any bits, so there is no point in trying more
+					* bits in the current word, or any other words
+					* in result.
+					*
+					* Jump out of both loops to avoid future
+					* unnecessary calls to try_partial_reuse.
+					*/
+					reuse = reuse_raw;
+					goto done;
+				}
 			}
 		}
+		reuse = reuse_raw;
+	}
+	else if (bitmap_git->version == 2) {
+		uint32_t cardinality = roaring_bitmap_get_cardinality(result);
+		for (i = 0;  i < objects_nr && roaring_bitmap_contains(result, i); i++);
+		reuse = roaring_bitmap_create_with_capacity(i);
+		roaring_bitmap_add_range(reuse, 0, i+1);
+		for (; i < cardinality; i++) {
+			if (try_partial_reuse(pack, i, reuse, &w_curs) < 0)
+				goto done;
+		}
 	}
 
 done:
 	unuse_pack(&w_curs);
 
-	*entries = raw_bitmap_popcount(reuse);
-	if (!*entries) {
-		raw_bitmap_free(reuse);
+	*entries = roaring_or_raw_bitmap_cardinality(reuse);
+	if (!*entries && reuse) {
+		roaring_or_raw_bitmap_free(reuse);
 		return -1;
 	}
 
@@ -1799,14 +2083,14 @@ done:
 	 * Drop any reused objects from the result, since they will not
 	 * need to be handled separately.
 	 */
-	raw_bitmap_and_not(result, reuse);
+	roaring_or_raw_bitmap_and_not(result, reuse);
 	*packfile_out = pack;
 	*reuse_out = reuse;
 	return 0;
 }
 
 int bitmap_walk_contains(struct bitmap_index *bitmap_git,
-			 struct bitmap *bitmap, const struct object_id *oid)
+			 void *bitmap, const struct object_id *oid)
 {
 	int idx;
 
@@ -1814,15 +2098,13 @@ int bitmap_walk_contains(struct bitmap_index *bitmap_git,
 		return 0;
 
 	idx = bitmap_position(bitmap_git, oid);
-	return idx >= 0 && raw_bitmap_get(bitmap, idx);
+	return idx >= 0 && roaring_or_raw_bitmap_get(bitmap, idx);
 }
 
-void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
-				 struct rev_info *revs,
-				 show_reachable_fn show_reachable)
+static void show_ewah_objects(struct bitmap_index *bitmap_git,
+			     struct rev_info *revs,
+			     show_reachable_fn show_reachable)
 {
-	assert(bitmap_git->result);
-
 	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
 	if (revs->tree_objects)
 		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
@@ -1830,6 +2112,31 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
 	if (revs->tag_objects)
 		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
+}
+
+static void show_roaring_objects(struct bitmap_index *bitmap_git,
+				  struct rev_info *revs,
+				  show_reachable_fn show_reachable)
+{
+	show_roaring_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
+	if (revs->tree_objects)
+		show_roaring_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
+	if (revs->blob_objects)
+		show_roaring_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
+	if (revs->tag_objects)
+		show_roaring_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
+}
+
+void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
+				 struct rev_info *revs,
+				 show_reachable_fn show_reachable)
+{
+	assert(bitmap_git->result);
+
+	if (bitmap_git->version == 1)
+		show_ewah_objects(bitmap_git, revs, show_reachable);
+	else if (bitmap_git->version == 2)
+		show_roaring_objects(bitmap_git, revs, show_reachable);
 
 	show_extended_objects(bitmap_git, revs, show_reachable);
 }
@@ -1837,23 +2144,36 @@ void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
 static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 				  enum object_type type)
 {
-	struct bitmap *objects = bitmap_git->result;
+	void *objects = bitmap_git->result;
 	struct eindex *eindex = &bitmap_git->ext_index;
 
 	uint32_t i = 0, count = 0;
-	struct ewah_iterator it;
-	eword_t filter;
 
-	init_type_iterator(&it, bitmap_git, type);
+	if (bitmap_git->version == 1) {
+		struct ewah_iterator it;
+		struct bitmap *raw_objects = objects;
+		eword_t filter;
+
+		init_type_iterator(&it, bitmap_git, type);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
-		eword_t word = objects->words[i++] & filter;
-		count += ewah_bit_popcount64(word);
+		while (i < raw_objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+			eword_t word = raw_objects->words[i++] & filter;
+			count += ewah_bit_popcount64(word);
+		}
+	}
+	else if (bitmap_git->version == 2) {
+		roaring_bitmap_t *type_index = NULL;
+		roaring_bitmap_t *filter_objects = NULL;
+
+		type_index = get_roaring_type_index(bitmap_git, type);
+		filter_objects = roaring_bitmap_and(objects, type_index);
+
+		count += roaring_bitmap_get_cardinality(filter_objects);
 	}
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			raw_bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
+			roaring_or_raw_bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			count++;
 	}
 
@@ -1881,11 +2201,11 @@ void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
 
 struct bitmap_test_data {
 	struct bitmap_index *bitmap_git;
-	struct bitmap *base;
-	struct bitmap *commits;
-	struct bitmap *trees;
-	struct bitmap *blobs;
-	struct bitmap *tags;
+	void *base;
+	void *commits;
+	void *trees;
+	void *blobs;
+	void *tags;
 	struct progress *prg;
 	size_t seen;
 };
@@ -1896,19 +2216,19 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	enum object_type bitmap_type = OBJ_NONE;
 	int bitmaps_nr = 0;
 
-	if (raw_bitmap_get(tdata->commits, pos)) {
+	if (roaring_or_raw_bitmap_get(tdata->commits, pos)) {
 		bitmap_type = OBJ_COMMIT;
 		bitmaps_nr++;
 	}
-	if (raw_bitmap_get(tdata->trees, pos)) {
+	if (roaring_or_raw_bitmap_get(tdata->trees, pos)) {
 		bitmap_type = OBJ_TREE;
 		bitmaps_nr++;
 	}
-	if (raw_bitmap_get(tdata->blobs, pos)) {
+	if (roaring_or_raw_bitmap_get(tdata->blobs, pos)) {
 		bitmap_type = OBJ_BLOB;
 		bitmaps_nr++;
 	}
-	if (raw_bitmap_get(tdata->tags, pos)) {
+	if (roaring_or_raw_bitmap_get(tdata->tags, pos)) {
 		bitmap_type = OBJ_TAG;
 		bitmaps_nr++;
 	}
@@ -1939,7 +2259,7 @@ static void test_show_object(struct object *object, const char *name,
 		die(_("object not in bitmap: '%s'"), oid_to_hex(&object->oid));
 	test_bitmap_type(tdata, object, bitmap_pos);
 
-	raw_bitmap_set(tdata->base, bitmap_pos);
+	roaring_or_raw_bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
@@ -1954,18 +2274,18 @@ static void test_show_commit(struct commit *commit, void *data)
 		die(_("object not in bitmap: '%s'"), oid_to_hex(&commit->object.oid));
 	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
-	raw_bitmap_set(tdata->base, bitmap_pos);
+	roaring_or_raw_bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
 void test_bitmap_walk(struct rev_info *revs)
 {
 	struct object *root;
-	struct bitmap *result = NULL;
+	void *result = NULL;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
 	struct bitmap_index *bitmap_git;
-	struct ewah_bitmap *bm;
+	void *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
 		die(_("failed to load bitmap indexes"));
@@ -1982,10 +2302,17 @@ void test_bitmap_walk(struct rev_info *revs)
 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
 
 	if (bm) {
-		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
-			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
+		if (bitmap_git->version == 1) {
+			struct ewah_bitmap *ewah_bm = bm;
+			fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
+				oid_to_hex(&root->oid), (int)ewah_bm->bit_size, ewah_checksum(ewah_bm));
 
-		result = ewah_to_raw_bitmap(bm);
+			result = ewah_to_raw_bitmap(ewah_bm);
+		}
+		else if (bitmap_git->version == 2) {
+			fprintf_ln(stderr, "Found bitmap for '%s'.", oid_to_hex(&root->oid));
+			result = roaring_bitmap_copy(bm);
+		}
 	}
 
 	if (!result)
@@ -1995,17 +2322,25 @@ void test_bitmap_walk(struct rev_info *revs)
 	revs->tree_objects = 1;
 	revs->blob_objects = 1;
 
-	result_popcnt = raw_bitmap_popcount(result);
+	result_popcnt = roaring_or_raw_bitmap_cardinality(result);
 
 	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
 
 	tdata.bitmap_git = bitmap_git;
-	tdata.base = raw_bitmap_new();
-	tdata.commits = ewah_to_raw_bitmap(bitmap_git->commits);
-	tdata.trees = ewah_to_raw_bitmap(bitmap_git->trees);
-	tdata.blobs = ewah_to_raw_bitmap(bitmap_git->blobs);
-	tdata.tags = ewah_to_raw_bitmap(bitmap_git->tags);
+	tdata.base = roaring_or_raw_bitmap_new();
+	if (bitmap_git->version == 1) {
+		tdata.commits = ewah_to_raw_bitmap(bitmap_git->commits);
+		tdata.trees = ewah_to_raw_bitmap(bitmap_git->trees);
+		tdata.blobs = ewah_to_raw_bitmap(bitmap_git->blobs);
+		tdata.tags = ewah_to_raw_bitmap(bitmap_git->tags);
+	}
+	else if (bitmap_git->version == 2) {
+		tdata.commits = roaring_bitmap_copy(bitmap_git->commits);
+		tdata.trees = roaring_bitmap_copy(bitmap_git->trees);
+		tdata.blobs = roaring_bitmap_copy(bitmap_git->blobs);
+		tdata.tags = roaring_bitmap_copy(bitmap_git->tags);
+	}
 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
 	tdata.seen = 0;
 
@@ -2013,17 +2348,17 @@ void test_bitmap_walk(struct rev_info *revs)
 
 	stop_progress(&tdata.prg);
 
-	if (raw_bitmap_equals(result, tdata.base))
+	if (roaring_or_raw_bitmap_equals(result, tdata.base))
 		fprintf_ln(stderr, "OK!");
 	else
 		die(_("mismatch in bitmap results"));
 
-	raw_bitmap_free(result);
-	raw_bitmap_free(tdata.base);
-	raw_bitmap_free(tdata.commits);
-	raw_bitmap_free(tdata.trees);
-	raw_bitmap_free(tdata.blobs);
-	raw_bitmap_free(tdata.tags);
+	roaring_or_raw_bitmap_free_safe(&result);
+	roaring_or_raw_bitmap_free_safe(&tdata.base);
+	roaring_or_raw_bitmap_free_safe(&tdata.commits);
+	roaring_or_raw_bitmap_free_safe(&tdata.trees);
+	roaring_or_raw_bitmap_free_safe(&tdata.blobs);
+	roaring_or_raw_bitmap_free_safe(&tdata.tags);
 	free_bitmap_index(bitmap_git);
 }
 
@@ -2081,33 +2416,52 @@ cleanup:
 	return 0;
 }
 
-int rebuild_bitmap(const uint32_t *reposition,
-		   struct ewah_bitmap *source,
-		   struct bitmap *dest)
+int rebuild_bitmap(struct bitmap_index *bitmap_git,
+		   const uint32_t *reposition,
+		   void *source,
+		   void *dest)
 {
 	uint32_t pos = 0;
-	struct ewah_iterator it;
-	eword_t word;
 
-	ewah_iterator_init(&it, source);
+	if (bitmap_git->version == 1) {
+		struct ewah_iterator it;
+		eword_t word;
 
-	while (ewah_iterator_next(&word, &it)) {
-		uint32_t offset, bit_pos;
+		ewah_iterator_init(&it, source);
 
-		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			if ((word >> offset) == 0)
-				break;
+		while (ewah_iterator_next(&word, &it)) {
+			uint32_t offset, bit_pos;
 
-			offset += ewah_bit_ctz64(word >> offset);
+			for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+				if ((word >> offset) == 0)
+					break;
+
+				offset += ewah_bit_ctz64(word >> offset);
 
-			bit_pos = reposition[pos + offset];
+				bit_pos = reposition[pos + offset];
+				if (bit_pos > 0)
+					roaring_or_raw_bitmap_set(dest, bit_pos - 1);
+				else /* can't reuse, we don't have the object */
+					return -1;
+			}
+
+			pos += BITS_IN_EWORD;
+		}
+	}
+	else if (bitmap_git->version == 2) {
+		uint32_t cardinality = roaring_bitmap_get_cardinality(source);
+		uint32_t *source_arr = NULL;
+		uint32_t i, bit_pos;
+
+		roaring_bitmap_to_uint32_array(source, source_arr);
+
+		for (i = 0; i < cardinality; i++) {
+			bit_pos = reposition[source_arr[i]];
 			if (bit_pos > 0)
-				raw_bitmap_set(dest, bit_pos - 1);
-			else /* can't reuse, we don't have the object */
+				roaring_or_raw_bitmap_set(dest, bit_pos);
+			else
 				return -1;
 		}
-
-		pos += BITS_IN_EWORD;
 	}
 	return 0;
 }
@@ -2156,23 +2510,39 @@ void free_bitmap_index(struct bitmap_index *b)
 
 	if (b->map)
 		munmap(b->map, b->map_size);
-	ewah_pool_free(b->commits);
-	ewah_pool_free(b->trees);
-	ewah_pool_free(b->blobs);
-	ewah_pool_free(b->tags);
+	if (b->version == 1) {
+		ewah_pool_free(b->commits);
+		ewah_pool_free(b->trees);
+		ewah_pool_free(b->blobs);
+		ewah_pool_free(b->tags);
+	}
+	else if (b->version == 2) {
+		roaring_bitmap_free_safe((roaring_bitmap_t **)&b->commits);
+		roaring_bitmap_free_safe((roaring_bitmap_t **)&b->trees);
+		roaring_bitmap_free_safe((roaring_bitmap_t **)&b->blobs);
+		roaring_bitmap_free_safe((roaring_bitmap_t **)&b->tags);
+	}
 	if (b->bitmaps) {
 		struct stored_bitmap *sb;
-		kh_foreach_value(b->bitmaps, sb, {
-			ewah_pool_free(sb->root);
-			free(sb);
-		});
+		if (b->version == 1) {
+			kh_foreach_value(b->bitmaps, sb, {
+				ewah_pool_free(sb->root);
+				free(sb);
+			});
+		}
+		else if (b->version == 2) {
+			kh_foreach_value(b->bitmaps, sb, {
+				roaring_bitmap_free_safe((roaring_bitmap_t **)&sb->root);
+				free(sb);
+			});
+		}
 	}
 	kh_destroy_oid_map(b->bitmaps);
 	free(b->ext_index.objects);
 	free(b->ext_index.hashes);
 	kh_destroy_oid_pos(b->ext_index.positions);
-	raw_bitmap_free(b->result);
-	raw_bitmap_free(b->haves);
+	roaring_or_raw_bitmap_free_safe(&b->result);
+	roaring_or_raw_bitmap_free_safe(&b->haves);
 	if (bitmap_is_midx(b)) {
 		/*
 		 * Multi-pack bitmaps need to have resources associated with
@@ -2199,31 +2569,74 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *bitmap_git,
 static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				     enum object_type object_type)
 {
-	struct bitmap *result = bitmap_git->result;
+	void *result = bitmap_git->result;
 	off_t total = 0;
-	struct ewah_iterator it;
-	eword_t filter;
 	size_t i;
 
-	init_type_iterator(&it, bitmap_git, object_type);
-	for (i = 0; i < result->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
-		eword_t word = result->words[i] & filter;
-		size_t base = (i * BITS_IN_EWORD);
-		unsigned offset;
-
-		if (!word)
-			continue;
-
-		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
-			if ((word >> offset) == 0)
-				break;
+	if (bitmap_git->version == 1) {
+		struct bitmap *raw_result = result;
+		struct ewah_iterator it;
+		eword_t filter;
+
+		init_type_iterator(&it, bitmap_git, object_type);
+		for (i = 0; i < raw_result->word_alloc &&
+				ewah_iterator_next(&filter, &it); i++) {
+			eword_t word = raw_result->words[i] & filter;
+			size_t base = (i * BITS_IN_EWORD);
+			unsigned offset;
+
+			if (!word)
+				continue;
+
+			for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+				if ((word >> offset) == 0)
+					break;
+
+				offset += ewah_bit_ctz64(word >> offset);
+
+				if (bitmap_is_midx(bitmap_git)) {
+					uint32_t pack_pos;
+					uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
+					off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
+
+					uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
+					struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+
+					if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
+						struct object_id oid;
+						nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
+
+						die(_("could not find '%s' in pack '%s' at offset %"PRIuMAX),
+						oid_to_hex(&oid),
+						pack->pack_name,
+						(uintmax_t)offset);
+					}
+
+					total += pack_pos_to_offset(pack, pack_pos + 1) - offset;
+				} else {
+					size_t pos = base + offset;
+					total += pack_pos_to_offset(bitmap_git->pack, pos + 1) -
+						pack_pos_to_offset(bitmap_git->pack, pos);
+				}
+			}
+		}
+	}
+	else if (bitmap_git->version == 2) {
+		uint32_t *filter_arr = NULL;
+		uint32_t cardinality = 0;
+		roaring_bitmap_t *filter_bitmap = NULL;
+		roaring_bitmap_t *type_index = NULL;
 
-			offset += ewah_bit_ctz64(word >> offset);
+		type_index = get_roaring_type_index(bitmap_git, object_type);
+		filter_bitmap = roaring_bitmap_and(result, type_index);
+		cardinality = roaring_bitmap_get_cardinality(filter_bitmap);
+		roaring_bitmap_to_uint32_array(filter_bitmap, filter_arr);
+		roaring_bitmap_free(filter_bitmap);
 
+		for (i = 0; i < cardinality; i++) {
 			if (bitmap_is_midx(bitmap_git)) {
 				uint32_t pack_pos;
-				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
+				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, filter_arr[i]);
 				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
 
 				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
@@ -2234,16 +2647,16 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
 
 					die(_("could not find '%s' in pack '%s' at offset %"PRIuMAX),
-					    oid_to_hex(&oid),
-					    pack->pack_name,
-					    (uintmax_t)offset);
+					oid_to_hex(&oid),
+					pack->pack_name,
+					(uintmax_t)offset);
 				}
 
 				total += pack_pos_to_offset(pack, pack_pos + 1) - offset;
 			} else {
-				size_t pos = base + offset;
+				size_t pos = filter_arr[i];
 				total += pack_pos_to_offset(bitmap_git->pack, pos + 1) -
-					 pack_pos_to_offset(bitmap_git->pack, pos);
+					pack_pos_to_offset(bitmap_git->pack, pos);
 			}
 		}
 	}
@@ -2253,7 +2666,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 
 static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 {
-	struct bitmap *result = bitmap_git->result;
+	void *result = bitmap_git->result;
 	struct eindex *eindex = &bitmap_git->ext_index;
 	off_t total = 0;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -2265,7 +2678,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!raw_bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
+		if (!roaring_or_raw_bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 6103e0d57e7..e9676ec53de 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -77,12 +77,12 @@ uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
 				       uint32_t *entries,
-				       struct bitmap **reuse_out);
+				       void**reuse_out);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
 int bitmap_walk_contains(struct bitmap_index *,
-			 struct bitmap *bitmap, const struct object_id *oid);
+			 void *bitmap, const struct object_id *oid);
 
 /*
  * After a traversal has been performed by prepare_bitmap_walk(), this can be
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index d953de6b7fe..e558bfcca5e 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -28,17 +28,20 @@ has_any () {
 
 test_bitmap_cases () {
 	writeLookupTable=false
+	useRoaringBitmap=false
 	for i in "$@"
 	do
 		case "$i" in
 		"pack.writeBitmapLookupTable") writeLookupTable=true;;
+		"pack.useRoaringBitmap") useRoaringBitmap=true;;
 		esac
 	done
 
 	test_expect_success 'setup test repository' '
 		rm -fr * .git &&
 		git init &&
-		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+		git config pack.useRoaringBitmap '"$useRoaringBitmap"'
 	'
 	setup_bitmap_history
 
@@ -48,7 +51,7 @@ test_bitmap_cases () {
 
 	test_expect_success 'full repack creates bitmaps' '
 		GIT_TRACE2_EVENT="$(pwd)/trace" \
-			git repack -ad &&
+		git repack -ad &&
 		ls .git/objects/pack/ | grep bitmap >output &&
 		test_line_count = 1 output &&
 		grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
@@ -189,27 +192,6 @@ test_bitmap_cases () {
 		git pack-objects --stdout --revs <revs >/dev/null
 	'
 
-	test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
-		git clone --bare . compat-jgit.git &&
-		(
-			cd compat-jgit.git &&
-			rm -f objects/pack/*.bitmap &&
-			jgit gc &&
-			git rev-list --test-bitmap HEAD
-		)
-	'
-
-	test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
-		git clone --bare . compat-us.git &&
-		(
-			cd compat-us.git &&
-			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
-			git repack -adb &&
-			# jgit gc will barf if it does not like our bitmaps
-			jgit gc
-		)
-	'
-
 	test_expect_success 'splitting packs does not generate bogus bitmaps' '
 		test-tool genrandom foo $((1024 * 1024)) >rand &&
 		git add rand &&
@@ -371,6 +353,7 @@ test_bitmap_cases () {
 		(
 			cd repo &&
 			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			git config pack.useRoaringBitmap '"$useRoaringBitmap"' &&
 
 			# create enough commits that not all are receive bitmap
 			# coverage even if they are all at the tip of some reference.
@@ -411,6 +394,7 @@ test_bitmap_cases () {
 		(
 			cd repo &&
 			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			git config pack.useRoaringBitmap '"$useRoaringBitmap"' &&
 
 			test_commit base &&
 
@@ -447,6 +431,26 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
+	git clone --bare . compat-jgit.git &&
+	(
+		cd compat-jgit.git &&
+		rm -f objects/pack/*.bitmap &&
+		jgit gc &&
+		git rev-list --test-bitmap HEAD
+	)
+'
+
+test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
+	git clone --bare . compat-us.git &&
+	(
+		cd compat-us.git &&
+		git repack -adb &&
+		# jgit gc will barf if it does not like our bitmaps
+		jgit gc
+	)
+'
+
 test_bitmap_cases "pack.writeBitmapLookupTable"
 
 test_expect_success 'verify writing bitmap lookup table when enabled' '
@@ -475,21 +479,33 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 	test_i18ngrep corrupted.bitmap.index stderr
 '
 
-test_expect_success 'setup test repository (roaring)' '
-	rm -fr * .git &&
-	git init
+test_expect_success JGIT,SHA1 'we can read jgit bitmaps (lookup table)' '
+	git clone --bare . compat-jgit.git &&
+	(
+		cd compat-jgit.git &&
+		rm -f objects/pack/*.bitmap &&
+		jgit gc &&
+		git rev-list --test-bitmap HEAD
+	)
 '
-setup_bitmap_history
 
-test_expect_success 'setup writing roaring bitmaps during repack' '
-	git config repack.writeBitmaps true &&
-	git config pack.useRoaringBitmap true
+test_expect_success JGIT,SHA1 'jgit can read our bitmaps (lookup table)' '
+	git clone --bare . compat-us.git &&
+	(
+		cd compat-us.git &&
+		git config pack.writeBitmapLookupTable true &&
+		git repack -adb &&
+		# jgit gc will barf if it does not like our bitmaps
+		jgit gc
+	)
 '
 
-test_expect_success 'full repack creates roaring bitmaps' '
-	GIT_TRACE2_EVENT="$(pwd)/trace6" \
-		git repack -ad &&
-	grep "\"label\":\"write-roaring-bitmap\"" trace6
+test_bitmap_cases 'pack.useRoaringBitmap'
+
+test_expect_success 'verify writing roaring bitmaps when enabled' '
+	GIT_TRACE2_EVENT="$(pwd)/trace5" \
+		git repack -adb &&
+	grep "\"label\":\"write-roaring-bitmap\"" trace5
 '
 
 test_done
-- 
gitgitgadget
