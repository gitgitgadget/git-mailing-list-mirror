Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D01C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiFTMdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiFTMdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2296459
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w17so14457627wrg.7
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qB40vecJidre48+Xh+Saa3dq72UdlnOWRldQU5puktU=;
        b=UEBzeoBx713cRahyiGYaJuTxYno8O7dk/HOAgJ4saG5rkuiV3Cwzy2ix65lx4XKhTi
         gfJERif4cE/B/i4WqRcKvqxmmYsH21KSgcKuQT14pbo3CMUv+AIGe7INHayZm7P5V56j
         KD6XsIezvV0wiIbEMSB2+mrgshQwGkkW35qlMYcM78g/0l85Qx15Sm9XX5J/KTNZ4oYS
         VaoTEt2yH7aaJT4X8ZJCPcg9JQMp0CBGcAtzBJobGcVz3VrzEjYcSNPE0GSZFJK4Whyt
         6xPGtQIQZZDQfgIf3jKiQE5cP3t+Sg/BGGgcvGmLnLYEbllslsjibbm0xuH3dO/FxBXB
         wIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qB40vecJidre48+Xh+Saa3dq72UdlnOWRldQU5puktU=;
        b=LZ0jUdLR+SI02HYpV3ZsnYZqV8MP6BZ7ykEXvoIYL38Y2QUy1rydk+oOnFnpHFTm7B
         r2E0aiO5gV0dnoOf/FNor7JjHKcpj1Fq0/6kvr8Q+UqDOouYYl/wc1/aLTrQT0z+DIjU
         VCUveZS2Yv7MJ270N6sEPjhAb20bknlm3PryFTtxT8jRrTieUFDnQt4l6BX7PWplPSzG
         ptkjwf6ulBK3lNFV+/pwQd5NRv98zx+HPmC1zqDcGn8I/mcboFzS1zSBiIWxLIkHM07h
         4xWj+lIMBwLQRBqkSOC9c0wzOrbNW/Q/45K+KxfyDB+2jjPCaEJoTCK5lOdkeHOh7iC5
         u5Pg==
X-Gm-Message-State: AJIora8iayPTQrR+RoDMIu3A4GJmu4IOze9SCbmRGA06L8HJFv2jFFvJ
        1sDqpB6Q2yyVlbRczJW35TZ8ygFpGdrjFw==
X-Google-Smtp-Source: AGRyM1vnX5XVn35qPwFbDGixdR5GLCLR2BSoC/j3FoFUYW6MPLaUUDtdxhmDa9X3FQyihjeav2gksA==
X-Received: by 2002:adf:e752:0:b0:21b:80ae:9d7a with SMTP id c18-20020adfe752000000b0021b80ae9d7amr16462961wrn.362.1655728398996;
        Mon, 20 Jun 2022 05:33:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9-20020adfe309000000b0020d0c9c95d3sm13488197wrj.77.2022.06.20.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:18 -0700 (PDT)
Message-Id: <d139a4c48aa058b142c4860721b10344c5498031.1655728395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:10 +0000
Subject: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Bitmap lookup table extension can let git to parse only the necessary
bitmaps without loading the previous bitmaps one by one.

Teach git to read and use the bitmap lookup table extension.

Co-Authored-by: Taylor Blau <ttaylorr@github.com>
Mentored-by: Taylor Blau <ttaylorr@github.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++--
 pack-bitmap.h |   1 +
 2 files changed, 166 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 36134222d7a..d5e5973a79f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -15,6 +15,7 @@
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
+#include "hash-lookup.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -82,6 +83,13 @@ struct bitmap_index {
 	/* The checksum of the packfile or MIDX; points into map. */
 	const unsigned char *checksum;
 
+	/*
+	 * If not NULL, these point into the various commit table sections
+	 * (within map).
+	 */
+	unsigned char *table_lookup;
+	unsigned char *table_offsets;
+
 	/*
 	 * Extended index.
 	 *
@@ -185,6 +193,24 @@ static int load_bitmap_header(struct bitmap_index *index)
 			index->hashes = (void *)(index_end - cache_size);
 			index_end -= cache_size;
 		}
+
+		if (flags & BITMAP_OPT_LOOKUP_TABLE &&
+		    git_env_bool("GIT_READ_COMMIT_TABLE", 1)) {
+			uint32_t entry_count = ntohl(header->entry_count);
+			uint32_t table_size =
+				(entry_count * the_hash_algo->rawsz) /* oids */ +
+				(entry_count * sizeof(uint32_t)) /* offsets */ +
+				(entry_count * sizeof(uint32_t)) /* xor offsets */ +
+				(sizeof(uint32_t)) /* flags */;
+
+			if (table_size > index_end - index->map - header_size)
+				return error("corrupted bitmap index file (too short to fit commit table)");
+
+			index->table_lookup = (void *)(index_end - table_size);
+			index->table_offsets = index->table_lookup + the_hash_algo->rawsz * entry_count;
+
+			index_end -= table_size;
+		}
 	}
 
 	index->entry_count = ntohl(header->entry_count);
@@ -470,7 +496,7 @@ static int load_bitmap(struct bitmap_index *bitmap_git)
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
 		goto failed;
 
-	if (load_bitmap_entries_v1(bitmap_git) < 0)
+	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
 	return 0;
@@ -557,14 +583,145 @@ struct include_data {
 	struct bitmap *seen;
 };
 
-struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
-				      struct commit *commit)
+static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						      struct commit *commit,
+						      uint32_t *pos_hint);
+
+static inline const unsigned char *bitmap_oid_pos(struct bitmap_index *bitmap_git,
+						  uint32_t pos)
+{
+	return bitmap_git->table_lookup + (pos * the_hash_algo->rawsz);
+}
+
+static inline const void *bitmap_offset_pos(struct bitmap_index *bitmap_git,
+					    uint32_t pos)
+{
+	return bitmap_git->table_offsets + (pos * 2 * sizeof(uint32_t));
+}
+
+static inline const void *xor_position_pos(struct bitmap_index *bitmap_git,
+					   uint32_t pos)
+{
+	return (unsigned char*) bitmap_offset_pos(bitmap_git, pos) + sizeof(uint32_t);
+}
+
+static int bitmap_lookup_cmp(const void *_va, const void *_vb)
+{
+	return hashcmp(_va, _vb);
+}
+
+static int bitmap_table_lookup(struct bitmap_index *bitmap_git,
+			       struct object_id *oid,
+			       uint32_t *commit_pos)
+{
+	unsigned char *found = bsearch(oid->hash, bitmap_git->table_lookup,
+				       bitmap_git->entry_count,
+				       the_hash_algo->rawsz, bitmap_lookup_cmp);
+	if (found)
+		*commit_pos = (found - bitmap_git->table_lookup) / the_hash_algo->rawsz;
+	return !!found;
+}
+
+static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						    struct object_id *oid,
+						    uint32_t commit_pos)
+{
+	uint32_t xor_pos;
+	off_t bitmap_ofs;
+
+	int flags;
+	struct ewah_bitmap *bitmap;
+	struct stored_bitmap *xor_bitmap;
+
+	bitmap_ofs = get_be32(bitmap_offset_pos(bitmap_git, commit_pos));
+	xor_pos = get_be32(xor_position_pos(bitmap_git, commit_pos));
+
+	/*
+	 * Lazily load the xor'd bitmap if required (and we haven't done so
+	 * already). Make sure to pass the xor'd bitmap's position along as a
+	 * hint to avoid an unnecessary binary search in
+	 * stored_bitmap_for_commit().
+	 */
+	if (xor_pos == 0xffffffff) {
+		xor_bitmap = NULL;
+	} else {
+		struct commit *xor_commit;
+		struct object_id xor_oid;
+
+		oidread(&xor_oid, bitmap_oid_pos(bitmap_git, xor_pos));
+
+		xor_commit = lookup_commit(the_repository, &xor_oid);
+		if (!xor_commit)
+			return NULL;
+
+		xor_bitmap = stored_bitmap_for_commit(bitmap_git, xor_commit,
+						      &xor_pos);
+	}
+
+	/*
+	 * Don't bother reading the commit's index position or its xor
+	 * offset:
+	 *
+	 *   - The commit's index position is irrelevant to us, since
+	 *     load_bitmap_entries_v1 only uses it to learn the object
+	 *     id which is used to compute the hashmap's key. We already
+	 *     have an object id, so no need to look it up again.
+	 *
+	 *   - The xor_offset is unusable for us, since it specifies how
+	 *     many entries previous to ours we should look at. This
+	 *     makes sense when reading the bitmaps sequentially (as in
+	 *     load_bitmap_entries_v1()), since we can keep track of
+	 *     each bitmap as we read them.
+	 *
+	 *     But it can't work for us, since the bitmap's don't have a
+	 *     fixed size. So we learn the position of the xor'd bitmap
+	 *     from the commit table (and resolve it to a bitmap in the
+	 *     above if-statement).
+	 *
+	 * Instead, we can skip ahead and immediately read the flags and
+	 * ewah bitmap.
+	 */
+	bitmap_git->map_pos = bitmap_ofs + sizeof(uint32_t) + sizeof(uint8_t);
+	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
+	bitmap = read_bitmap_1(bitmap_git);
+	if (!bitmap)
+		return NULL;
+
+	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
+}
+
+static struct stored_bitmap *stored_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						      struct commit *commit,
+						      uint32_t *pos_hint)
 {
 	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
 					   commit->object.oid);
-	if (hash_pos >= kh_end(bitmap_git->bitmaps))
+	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
+		uint32_t commit_pos;
+		if (!bitmap_git->table_lookup)
+			return NULL;
+
+		/* NEEDSWORK: cache misses aren't recorded. */
+		if (pos_hint)
+			commit_pos = *pos_hint;
+		else if (!bitmap_table_lookup(bitmap_git,
+					      &commit->object.oid,
+					      &commit_pos))
+			return NULL;
+		return lazy_bitmap_for_commit(bitmap_git, &commit->object.oid,
+					      commit_pos);
+	}
+	return kh_value(bitmap_git->bitmaps, hash_pos);
+}
+
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit)
+{
+	struct stored_bitmap *sb = stored_bitmap_for_commit(bitmap_git, commit,
+							    NULL);
+	if (!sb)
 		return NULL;
-	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
+	return lookup_stored_bitmap(sb);
 }
 
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
@@ -1699,8 +1856,9 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (revs->pending.nr != 1)
 		die("you must specify exactly one commit to test");
 
-	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
-		bitmap_git->version, bitmap_git->entry_count);
+	if (!bitmap_git->table_lookup)
+		fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
+			bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3d3ddd77345..37f86787a4d 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -26,6 +26,7 @@ struct bitmap_disk_header {
 enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 1,
 	BITMAP_OPT_HASH_CACHE = 4,
+	BITMAP_OPT_LOOKUP_TABLE = 16,
 };
 
 enum pack_bitmap_flags {
-- 
gitgitgadget

