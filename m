Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767FEC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGTSis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiGTSiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:38:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10273923
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso185025wmm.5
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JWMGsY31T3LEGQ6YK4QNg917rcyopL0Wjhs3P4Ya9Dc=;
        b=ju0fJzo+UiNTSoxNx3bT738yJv2F0B/7FQ1M2ZzzKF70tIF1By4/ZqDNqbUVPTh7z5
         Za+XtqzVqAO9OULE8oaLsbbkIUQXxpLWbXpRLjwIc7r0lQFK9vAu1meruXiUuMqzp3Au
         7pFfzsoHMnPNYEE4pz2fGMmSuv/nk+z1wvKkQKsV7r1xXMLMM+G3iWUQXNBx86QDd59s
         77VbdsQSG7Kr1/qdn+fjtpVht2k0M3DKoGJnIMGuzcl9fWMhTvNSz7h8QA+hPnGY7kn0
         /T9gXPuCHDG7KdKufTq/xzGSyHzwfvu/ULEkMLT+LkHC8uVb7NZkUqGEcNw76gEllVLU
         VljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JWMGsY31T3LEGQ6YK4QNg917rcyopL0Wjhs3P4Ya9Dc=;
        b=pzQ+8fo197s4vs965aU7PxsrMfaKy8a2qCK7sB9RgGQjbUpntDxIgmyjYJFMu4l//T
         bBiLMNPbcdd0RFFQEsY2cV4THnLsLmHOkVJmCXo99+Baiy8+4SdQzhF7RZffTVo+fXK5
         IuW+sBGX7bwxyZ4zv3WQHR3tshOvZweMRxlF/h0JXXPXiCqRB58eKd4c60kPcoQxkD7q
         z0D4ljDtR11DsrNt+HXQMgapM8d31v68krgri9L54ZvDCLFsoLf1UCp4DzjmMgRsmfxN
         6/5o6L4NQjnCMSgQXFciKlww/7En6elacC3i61G6fRZ86omjXDjLM9Unay24ZPTzCwCm
         QkEQ==
X-Gm-Message-State: AJIora/hyB1ZYqtuEUsU3so/I9Nq/4Gptmg4Zgy20aJN6r7dz/E68+5m
        VBbFCZ8R2vm6HCcONq2U8KGyNMzMUso=
X-Google-Smtp-Source: AGRyM1sUd+04Cjc57L4jtIJtrhLnL/y1T3tBAn90nhG3PPPdPdDWYKvU2Z+sSbK/1x0yFG94GJOYSg==
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id d3-20020a05600c3ac300b003a045b67efbmr5050904wms.183.1658342309060;
        Wed, 20 Jul 2022 11:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020adfcf04000000b0021d7fa77710sm16189350wrj.92.2022.07.20.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:38:28 -0700 (PDT)
Message-Id: <a913e6a2cb36d8ec7900b60820d8ab3c35f60164.1658342304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
        <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:38:20 +0000
Subject: [PATCH v5 2/6] pack-bitmap-write.c: write lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The bitmap lookup table extension was documented by an earlier
change, but Git does not yet know how to write that extension.

Teach Git to write bitmap lookup table extension. The table contains
the list of `N` <commit_pos, offset, xor_row>` triplets. These
triplets are sorted according to their commit pos (ascending order).
The meaning of each data in the i'th triplet is given below:

  - commit_pos stores commit position (in the pack-index or midx).
    It is a 4 byte network byte order unsigned integer.

  - offset is the position (in the bitmap file) from which that
    commit's bitmap can be read.

  - xor_row is the position of the triplet in the lookup table
    whose bitmap is used to compress this bitmap, or `0xffffffff`
    if no such bitmap exists.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap-write.c | 112 ++++++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h       |   5 +-
 2 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c43375bd344..9843790cb60 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -650,20 +650,19 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
-				      uint32_t index_nr)
+				      uint32_t index_nr,
+				      off_t *offsets,
+				      uint32_t *commit_positions)
 {
 	int i;
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 
-		int commit_pos =
-			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+		if (offsets)
+			offsets[i] = hashfile_total(f);
 
-		if (commit_pos < 0)
-			BUG("trying to write commit not in index");
-
-		hashwrite_be32(f, commit_pos);
+		hashwrite_be32(f, commit_positions[i]);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
 
@@ -671,6 +670,81 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }
 
+static int table_cmp(const void *_va, const void *_vb, void *_data)
+{
+	uint32_t *commit_positions = _data;
+	uint32_t a = commit_positions[*(uint32_t *)_va];
+	uint32_t b = commit_positions[*(uint32_t *)_vb];
+
+	if (a > b)
+		return 1;
+	else if (a < b)
+		return -1;
+
+	return 0;
+}
+
+static void write_lookup_table(struct hashfile *f,
+			       struct pack_idx_entry **index,
+			       uint32_t index_nr,
+			       off_t *offsets,
+			       uint32_t *commit_positions)
+{
+	uint32_t i;
+	uint32_t *table, *table_inv;
+
+	ALLOC_ARRAY(table, writer.selected_nr);
+	ALLOC_ARRAY(table_inv, writer.selected_nr);
+
+	for (i = 0; i < writer.selected_nr; i++)
+		table[i] = i;
+
+	/*
+	 * At the end of this sort table[j] = i means that the i'th
+	 * bitmap corresponds to j'th bitmapped commit (among the selected
+	 * commits) in lex order of OIDs.
+	 */
+	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
+
+	/* table_inv helps us discover that relationship (i'th bitmap
+	 * to j'th commit by j = table_inv[i])
+	 */
+	for (i = 0; i < writer.selected_nr; i++)
+		table_inv[table[i]] = i;
+
+	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
+	for (i = 0; i < writer.selected_nr; i++) {
+		struct bitmapped_commit *selected = &writer.selected[table[i]];
+		uint32_t xor_offset = selected->xor_offset;
+		uint32_t xor_row;
+
+		if (xor_offset) {
+			/*
+			 * xor_index stores the index (in the bitmap entries)
+			 * of the corresponding xor bitmap. But we need to convert
+			 * this index into lookup table's index. So, table_inv[xor_index]
+			 * gives us the index position w.r.t. the lookup table.
+			 *
+			 * If "k = table[i] - xor_offset" then the xor base is the k'th
+			 * bitmap. `table_inv[k]` gives us the position of that bitmap
+			 * in the lookup table.
+			 */
+			uint32_t xor_index = table[i] - xor_offset;
+			xor_row = table_inv[xor_index];
+		} else {
+			xor_row = 0xffffffff;
+		}
+
+		hashwrite_be32(f, commit_positions[table[i]]);
+		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
+		hashwrite_be32(f, xor_row);
+	}
+	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
+
+	free(table);
+	free(table_inv);
+}
+
 static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
@@ -695,8 +769,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 {
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	off_t *offsets = NULL;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
+	uint32_t *commit_positions = NULL;
 
 	struct bitmap_disk_header header;
 
@@ -715,7 +791,25 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
-	write_selected_commits_v1(f, index, index_nr);
+
+	ALLOC_ARRAY(commit_positions, writer.selected_nr);
+	for (uint32_t i = 0; i < writer.selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer.selected[i];
+		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+
+		if (commit_pos < 0)
+			BUG(_("trying to write commit not in index"));
+
+		commit_positions[i] = commit_pos;
+	}
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		CALLOC_ARRAY(offsets, index_nr);
+
+	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		write_lookup_table(f, index, index_nr, offsets, commit_positions);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -730,4 +824,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
 
 	strbuf_release(&tmp_file);
+	free(offsets);
+	free(commit_positions);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3d3ddd77345..67a9d0fc303 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -24,8 +24,9 @@ struct bitmap_disk_header {
 #define NEEDS_BITMAP (1u<<22)
 
 enum pack_bitmap_opts {
-	BITMAP_OPT_FULL_DAG = 1,
-	BITMAP_OPT_HASH_CACHE = 4,
+	BITMAP_OPT_FULL_DAG = 0x1,
+	BITMAP_OPT_HASH_CACHE = 0x4,
+	BITMAP_OPT_LOOKUP_TABLE = 0x10,
 };
 
 enum pack_bitmap_flags {
-- 
gitgitgadget

