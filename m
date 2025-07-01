Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFD1F4634
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347937; cv=none; b=fx0WAprHNa0e6wtuK52tmu/CkbiWeSGBweA7ggvxQrwthpxiZwRbNDNvuwHwGn0x+YCu//nlWQWUyHhsE3sdlpOAnxu34DVr8W4WFLnrTQIb3txeuaRPmiackuOE8P7Zu6v3gUk74g4yohxlJlNYSE1mHWmMDN236Zkon71nlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347937; c=relaxed/simple;
	bh=0KnCtYiAp+COSAKks3omhlojLj2jpOafTHBs13m7bIY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l7lUQerlB1a1S4Lv3cNGU03aG4gt5s4zaYyLohpl4p680fIsnKPX+ZVqe/k+iKr6uAOlL0Zc47pXOaBOGSaq6ND3tu3tE4WR2W4NJWj99Ewh06qiZK0+B/6dddibHfcPyYpGRY+iMgFDPofSPxfC3scEMnhJTwdvSiRgd3DXGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7e5Hwpv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7e5Hwpv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453398e90e9so22493355e9.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751347933; x=1751952733; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKr6yzk0Fj1Q7zG0BAkdK5uS5yCahKRfMFEcjM5/BOA=;
        b=K7e5Hwpv2EMVuJPWHOR7tT1jaraiOWVzPsZqiH3F73a0eMjaUaCbLbQOq4WFASjZwH
         tuD0uslsO6p/giymfXa0A4xl0b+EjjVLzOSO5+ZXrPOsZgZz4GK5gL4NP4XoXypo86em
         yYvgljiUtsSJkPshd3wmxx6ijksy/qSnARCpvvaxwIiIR31DyrDkJkPCKHGUX9iJHq/Q
         fJHFbteuTMSv7D/IwpV64bXSgHiXnOLoFYO6hLJS5H0zMES4xEbF4CpLmpNQP1fYDP+P
         zOy7shxlz4/Be2p5UHjPNvAMTGcHvHhcu7zYXnGQnrmWzHfXr6LieT/v2iqxteYtCEoQ
         +kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347933; x=1751952733;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKr6yzk0Fj1Q7zG0BAkdK5uS5yCahKRfMFEcjM5/BOA=;
        b=wIFsmdh8Un6N+g2g4XSzoRWqIk9biBOpOAbLFk44KbF1OEcTd+HVU9g5wODXBzABUh
         r15UTCCHvJx1VU17nW2p6PPjL2oT4J/INnY+5C8LK+GyEsloaK9gTQifVCNhtQSvGS/O
         2ohgdd3LN+7ZY21THO8uEdVc1yV/wH62d6QFN3nnSroL396MXawyPyNqbYiciy9GWQ10
         VFRRDrepkouopwdgoEOWj9G/N7ZvdMXXWw5peKQ8zkTM54OqDLg33zwIDR+GwLo2Q6nV
         VJmvAeLnk2InNSRqHzW+dK/rtEpSTTWLbOGg+Lo6GphXylJYpv/I7W6XuoiyTbtKBHG8
         8ZuA==
X-Gm-Message-State: AOJu0Ywg2JUkjttGvZz/rhZbaL9uTPfiAvz0pSKzwWgxcBCsYTOLbNw2
	anvoIctUHuy5Pzo7SGClbohwQjlXOnSoEqRBf7W8Nq8yZ41O6lDwya5FPfvmjg==
X-Gm-Gg: ASbGncv1oYDq3aLk/pzLFFi9Vy8UmZBcj1EpgnENPZ8UXvCQj3bebk/vUygfND3FLs5
	oO/y+VFoWQ+N3QW94brCIgTcWihIPwxlggOg7y6odpsfNWoLpVbBzQ97VQJ0WPcC5Sy87eHvdDR
	sG3Aggd0mIctotwDQpVOSmzAeUcG3ogzq8vTX5ckoulNFYMJoa+hzimqRl/RoTdXhSYf+vtMVf6
	I5M4t3V1gnSn/VTyC26lDGnv/eaUNfyajQPIRExV/XsXOYvPhKIwY6hapOFgGlPzitqVR3+bTfs
	LLCQzhCuomE38sMOVM+lIOcpKeB+aOgLuq+xlnSG3wy1iVXNnBQoDHIjAKr9qng=
X-Google-Smtp-Source: AGHT+IGjvBVjbRAgGT0t39BL3Ff38SqjqBOOQ7ANv7W4D87ZMQt9iJZNtPd2et/m1szoNzE9prceSg==
X-Received: by 2002:a05:600c:a016:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-453954d7b98mr97799295e9.33.1751347932679;
        Mon, 30 Jun 2025 22:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d4asm155709105e9.3.2025.06.30.22.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:32:12 -0700 (PDT)
Message-Id: <c1b5d030133fafc6adaa70facf13027b37edf632.1751347929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
	<pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Jul 2025 05:32:09 +0000
Subject: [PATCH v6 3/3] pack-bitmap: add load corrupt bitmap test
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

t5310 lacks a test to ensure git works correctly when commit bitmap
data is corrupted. So this patch add test helper in pack-bitmap.c to
list each commit bitmap position in bitmap file and `load corrupt bitmap`
test case in t/t5310 to corrupt a commit bitmap before loading it.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c           | 62 +++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 ++++++
 t/t5310-pack-bitmaps.sh | 30 ++++++++++++++++++++
 4 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 330f07609835..499d77a1d368 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -31,6 +31,7 @@ struct stored_bitmap {
 	struct object_id oid;
 	struct ewah_bitmap *root;
 	struct stored_bitmap *xor;
+	size_t map_pos;
 	int flags;
 };
 
@@ -314,13 +315,14 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  struct ewah_bitmap *root,
 					  const struct object_id *oid,
 					  struct stored_bitmap *xor_with,
-					  int flags)
+					  int flags, size_t map_pos)
 {
 	struct stored_bitmap *stored;
 	khiter_t hash_pos;
 	int ret;
 
 	stored = xmalloc(sizeof(struct stored_bitmap));
+	stored->map_pos = map_pos;
 	stored->root = root;
 	stored->xor = xor_with;
 	stored->flags = flags;
@@ -376,10 +378,12 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		struct stored_bitmap *xor_bitmap = NULL;
 		uint32_t commit_idx_pos;
 		struct object_id oid;
+		size_t entry_map_pos;
 
 		if (index->map_size - index->map_pos < 6)
 			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
 
+		entry_map_pos = index->map_pos;
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
@@ -402,8 +406,9 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		if (!bitmap)
 			return -1;
 
-		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
-			index, bitmap, &oid, xor_bitmap, flags);
+		recent_bitmaps[i % MAX_XOR_OFFSET] =
+			store_bitmap(index, bitmap, &oid, xor_bitmap, flags,
+				     entry_map_pos);
 	}
 
 	return 0;
@@ -869,6 +874,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	int xor_flags;
 	khiter_t hash_pos;
 	struct bitmap_lookup_table_xor_item *xor_item;
+	size_t entry_map_pos;
 
 	if (is_corrupt)
 		return NULL;
@@ -928,6 +934,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 			goto corrupt;
 		}
 
+		entry_map_pos = bitmap_git->map_pos;
 		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
 		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
 		bitmap = read_bitmap_1(bitmap_git);
@@ -935,7 +942,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		if (!bitmap)
 			goto corrupt;
 
-		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
+		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid,
+					  xor_bitmap, xor_flags, entry_map_pos);
 		xor_items_nr--;
 	}
 
@@ -969,6 +977,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	 * Instead, we can skip ahead and immediately read the flags and
 	 * ewah bitmap.
 	 */
+	entry_map_pos = bitmap_git->map_pos;
 	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
 	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
 	bitmap = read_bitmap_1(bitmap_git);
@@ -976,7 +985,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	if (!bitmap)
 		goto corrupt;
 
-	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
+	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags,
+			    entry_map_pos);
 
 corrupt:
 	free(xor_items);
@@ -2857,6 +2867,48 @@ int test_bitmap_commits(struct repository *r)
 	return 0;
 }
 
+int test_bitmap_commits_with_offset(struct repository *r)
+{
+	struct object_id oid;
+	struct stored_bitmap *stored;
+	struct bitmap_index *bitmap_git;
+	size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
+		ewah_bitmap_map_pos;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git)
+		die(_("failed to load bitmap indexes"));
+
+	/*
+	 * Since this function needs to know the position of each individual
+	 * bitmap, bypass the commit lookup table (if one exists) by forcing
+	 * the bitmap to eagerly load its entries.
+	 */
+	if (bitmap_git->table_lookup) {
+		if (load_bitmap_entries_v1(bitmap_git) < 0)
+			die(_("failed to load bitmap indexes"));
+	}
+
+	kh_foreach (bitmap_git->bitmaps, oid, stored, {
+		commit_idx_pos_map_pos = stored->map_pos;
+		xor_offset_map_pos = stored->map_pos + sizeof(uint32_t);
+		flag_map_pos = xor_offset_map_pos + sizeof(uint8_t);
+		ewah_bitmap_map_pos = flag_map_pos + sizeof(uint8_t);
+
+		printf_ln("%s %"PRIuMAX" %"PRIuMAX" %"PRIuMAX" %"PRIuMAX,
+			  oid_to_hex(&oid),
+			  (uintmax_t)commit_idx_pos_map_pos,
+			  (uintmax_t)xor_offset_map_pos,
+			  (uintmax_t)flag_map_pos,
+			  (uintmax_t)ewah_bitmap_map_pos);
+	})
+		;
+
+	free_bitmap_index(bitmap_git);
+
+	return 0;
+}
+
 int test_bitmap_hashes(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 382d39499af2..1bd7a791e2a0 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -81,6 +81,7 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
+int test_bitmap_commits_with_offset(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
 int test_bitmap_pseudo_merges(struct repository *r);
 int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 3f23f2107268..16a01669e414 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -10,6 +10,11 @@ static int bitmap_list_commits(void)
 	return test_bitmap_commits(the_repository);
 }
 
+static int bitmap_list_commits_with_offset(void)
+{
+	return test_bitmap_commits_with_offset(the_repository);
+}
+
 static int bitmap_dump_hashes(void)
 {
 	return test_bitmap_hashes(the_repository);
@@ -36,6 +41,8 @@ int cmd__bitmap(int argc, const char **argv)
 
 	if (argc == 2 && !strcmp(argv[1], "list-commits"))
 		return bitmap_list_commits();
+	if (argc == 2 && !strcmp(argv[1], "list-commits-with-offset"))
+		return bitmap_list_commits_with_offset();
 	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
 		return bitmap_dump_hashes();
 	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
@@ -46,6 +53,7 @@ int cmd__bitmap(int argc, const char **argv)
 		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
 
 	usage("\ttest-tool bitmap list-commits\n"
+	      "\ttest-tool bitmap list-commits-with-offset\n"
 	      "\ttest-tool bitmap dump-hashes\n"
 	      "\ttest-tool bitmap dump-pseudo-merges\n"
 	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index b6926f102708..6718fb98c057 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -495,6 +495,36 @@ test_bitmap_cases () {
 			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
+
+	test_expect_success 'load corrupt bitmap' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+
+			test_commit base &&
+
+			git repack -adb &&
+			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
+			chmod +w $bitmap &&
+
+			test-tool bitmap list-commits-with-offset >offsets &&
+			xor_off=$(head -n1 offsets | awk "{print \$3}") &&
+			printf '\161' |
+				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$xor_off &&
+
+			git rev-list --objects --no-object-names HEAD >expect.raw &&
+			git rev-list --objects --use-bitmap-index --no-object-names HEAD \
+				>actual.raw &&
+
+			sort expect.raw >expect &&
+			sort actual.raw >actual &&
+
+		    test_cmp expect actual
+		)
+	'
 }
 
 test_bitmap_cases
-- 
gitgitgadget
