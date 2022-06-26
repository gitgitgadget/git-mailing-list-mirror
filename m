Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32519C43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiFZNK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiFZNKY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4BA46A
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so1524844wmi.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CUil831QgYbwZEuou9/h47jJVdMvKqvGtYftNx2sG6U=;
        b=a/dGU2LK7hyIOZPgGm7QJvHxaaIg3k/EU2ra1ecPxbC2S9RmtPPKBbC1ghNFglaIpo
         7QZpVm6Pn7mVCxkrEk6008dj9OCdLc4Qn5xD0pw2Eiunz72GOaoU4wPddXRlIBM9quzt
         wWBBrWcYYjSdaRt6MG7k00PHAnNsTNQIkOznXjAnexNFWITXplTOX+sBoLxObVhrpy5Z
         7D3YN1fXWnLkbzNT9YRuZcVtFFe4LkV1nYJPlDU3l/cBJbV9PDQtDndYzjzZ93JN0Npl
         Vd2afyY6jSG9fysizhyYIxiQXq6ioRlNGZwpnN4xAQrD+nMaDxMK4nK7WQwq8HC3nm6u
         WW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CUil831QgYbwZEuou9/h47jJVdMvKqvGtYftNx2sG6U=;
        b=vZtw1Q1C9e4CkYC+CfiNy4Ud3xGgg8CIK38tDKCjSVbIMA7Vs3vw1Q0aPylq1fXg4+
         isVyUvt6oNDdMCbRVwiWQ4LGVvXTTM60BDaoks5MiFVc1oAaTCKn7DIgfoa0YmNrnveR
         gfuFuLzW7SAAtqSHer/iPxVQy2rRQM6yr8b+w7OVJ3G5gu2nVXSQz5q6KgIUsQBdOUr6
         Ougkgtx2gcCjM7+qGacqEB4huAteC67Ya54lejejCMklhNUKv5eiLRK2gMRHeJnxlQwC
         BLa72Rqk+Ylr+0HVcI4EnAwmgHIZgctol1iPxjry9L5U8CSljJ/LjiQAFPP0/mO7MxOK
         3J+A==
X-Gm-Message-State: AJIora9B0CkNv5mwGS3IQD6dlEgRuLYXfxyZ81WwXqkioxUIG0hvv4kH
        g5yeWkbFvGiYDdCmH9+WSy1bKZ3TEDO4EA==
X-Google-Smtp-Source: AGRyM1sLME/Nv4iRDzTesxEK+QnhsEKUSkq8hL0DxVyvQqp8aDYAY1ghs2H227hhNR5pqcV/YILTvw==
X-Received: by 2002:a05:600c:34c5:b0:3a0:4187:22d0 with SMTP id d5-20020a05600c34c500b003a0418722d0mr7890492wmq.54.1656249021996;
        Sun, 26 Jun 2022 06:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b003975c7058bfsm9549259wmr.12.2022.06.26.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:21 -0700 (PDT)
Message-Id: <d118f1d45e6202925d4efd5435acdd08545bf132.1656249017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
        <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:13 +0000
Subject: [PATCH v2 2/6] pack-bitmap-write.c: write lookup table extension
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

The bitmap lookup table extension was documentated by an earlier
change, but Git does not yet knowhow to write that extension.

Teach git to write bitmap lookup table extension. The table contains
the list of `N` <commit pos, offset, xor offset>` triplets. These
triplets are sorted according to their commit pos (ascending order).
The meaning of each data in the i'th triplet is given below:

  - Commit pos is the position of the commit in the pack-index
    (or midx) to which the i'th bitmap belongs. It is a 4 byte
    network byte order integer.

  - offset is the position of the i'th bitmap.

  - xor offset denotes the position of the triplet with whose
    bitmap the current triplet's bitmap need to xor with.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap-write.c | 72 +++++++++++++++++++++++++++++++++++++++++++--
 pack-bitmap.h       |  5 ++--
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c43375bd344..899a4a941e1 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -650,7 +650,9 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
-				      uint32_t index_nr)
+				      uint32_t index_nr,
+				      uint64_t *offsets,
+				      uint32_t *commit_positions)
 {
 	int i;
 
@@ -663,6 +665,11 @@ static void write_selected_commits_v1(struct hashfile *f,
 		if (commit_pos < 0)
 			BUG("trying to write commit not in index");
 
+		if (offsets)
+			offsets[i] = hashfile_total(f);
+		if (commit_positions)
+			commit_positions[i] = commit_pos;
+
 		hashwrite_be32(f, commit_pos);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
@@ -671,6 +678,55 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }
 
+static int table_cmp(const void *_va, const void *_vb, void *commit_positions)
+{
+	int8_t result = 0;
+	uint32_t *positions = (uint32_t *) commit_positions;
+	uint32_t a = positions[*(uint32_t *)_va];
+	uint32_t b = positions[*(uint32_t *)_vb];
+
+	if (a > b)
+		result = 1;
+	else if (a < b)
+		result = -1;
+	else
+		result = 0;
+
+	return result;
+}
+
+static void write_lookup_table(struct hashfile *f,
+			       uint64_t *offsets,
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
+	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
+
+	for (i = 0; i < writer.selected_nr; i++)
+		table_inv[table[i]] = i;
+
+	for (i = 0; i < writer.selected_nr; i++) {
+		struct bitmapped_commit *selected = &writer.selected[table[i]];
+		uint32_t xor_offset = selected->xor_offset;
+
+		hashwrite_be32(f, commit_positions[table[i]]);
+		hashwrite_be64(f, offsets[table[i]]);
+		hashwrite_be32(f, xor_offset ?
+				table_inv[table[i] - xor_offset]: 0xffffffff);
+	}
+
+	free(table);
+	free(table_inv);
+}
+
 static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
@@ -695,6 +751,8 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 {
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	uint64_t *offsets = NULL;
+	uint32_t *commit_positions = NULL;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
 
@@ -715,8 +773,16 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
-	write_selected_commits_v1(f, index, index_nr);
 
+	if (options & BITMAP_OPT_LOOKUP_TABLE) {
+		CALLOC_ARRAY(offsets, index_nr);
+		CALLOC_ARRAY(commit_positions, index_nr);
+	}
+
+	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		write_lookup_table(f, offsets, commit_positions);
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
@@ -730,4 +796,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
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

