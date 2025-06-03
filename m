Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A8185B67
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920454; cv=none; b=GUHpdfoJpyfQSQIjLdKZ7K6/0Hus0hM9VZuh7imfoQAfm858+zlxU+nOPVg70Y59ZARm8JDb6uf6XVnLgOfs07Px3gjtl/AJNpjFK1+bXS1vz2iG2M51UlddoQVwC/5b8rzcf1kvL4rb4vBhfu8rUVTFWw8Y7i8FzHbxjbKIW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920454; c=relaxed/simple;
	bh=2PNGFE1T3e6tQMnXozTPDMFIGa8534BZhmcsnmqKgwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AhBjfUgXYvLOslE0neTCJZtgOy7u8xuVbA/lRGAzsBiaLgQSFlMh9cW19uh5jyH+wQFJL7cdIVjRwYksv3i9hPOgmJ1abfq6YBpBA03SvV7I4LPPMK4zUUREirVt3+kz+Y20TaPDkFVpF1E57EqAxTbWGihecev8HOvNTK/SVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRWvrBOT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRWvrBOT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so55432965e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748920450; x=1749525250; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCx1XnuLI+dBDFQBfVBpvA9+H2N37Ao5QJ/mZIO512o=;
        b=YRWvrBOTC4iaSCTOgddQHrK1Vcy3aR2ulP2h//06EQCut8QQB/vW9Ed2rmKI2BAwKI
         FkurCM1JchVU7zXbmW5WurXTQK78DwQr+Az44Lw7vlvERAdaGXeD7hILkYqlTohmX4Ee
         qXZM7/TGHmiq0hxTrqRICzvgPq5LsEOzYwIEm5NCkhkrEcJA5rwfE/iRppVLMVCI6lZg
         wmF7NdHllGWWTV9Nne3BRDyXZDyBs9/0LaFey1kMDqriIawEaAvpjDqY5luNz3MMqVY0
         uGwsQXKnZITO+0m6EKS13NBeFpATsro383QR0nkG99NRVOqgsJj8pSYPprR4B6A68kLB
         Exiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920450; x=1749525250;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCx1XnuLI+dBDFQBfVBpvA9+H2N37Ao5QJ/mZIO512o=;
        b=AwA0/oNrQ+t6OlWF+r8PRvNpMk4VX7K9CTbcm+LOOh1hNCD2CzzlodT8iKLaPRXuqX
         LMlkjYekBPkBA9ChQVo2CDGGbiT1AtKgYIlS1ZLA9j1mlIsWcNLavJ/7UngKlyiV05YB
         F0jSpuELKpyIzGtmbE0zzDMI1LNNAdTL5BN0HWhuxULY5TJL4lSAtcMWN0l+9NLU+Ssj
         OrPM/uwO5Fr0rxISbM7n/1BTsRogoFhsjpPVORS2DHPFllo+VZb2QOFKsBVRpz6toUK9
         QCYvhmyzH3zLhQda/cnNiFFxm1eYUWuHJe2RvJFlX2ThvlI7FVJ9MbbDLBfBp6ua/xSa
         eGVw==
X-Gm-Message-State: AOJu0YzGLjd6ZfuzEEo2ohnnMOIYniqiJX1AF1ejlcPtjzjipLt1oqSW
	vrFSHBzE94kNR7CXHMicEBd8eYjoSBb/qTaS0wJo+uAAIxUPGCCWIJeOWqegCA==
X-Gm-Gg: ASbGnctCxhiJ4MF631pxHyu9dRROKtdhkTj3ot1loV1WgADnWrzprF2mWFCK4w3hTbu
	2MF85XwI8BGXUUT0qSIUHPUl1bm+SUGjxugtC2fOpqiLAnZEvjNmPGgR3s2LHMJXKVEqGfGGkXB
	C1xDVYxVPwTkyG6bt2qlCpVo9T+5SJyYxPyeR+PD76jW3JVj7oYUcmyVeFoHngppWzFFtB+oX+i
	Mmy1JeB96/MgvgCoONhXcREeRSEIKdaAVJHAq7S0zSK/OGHQ9ytcsXAWoo3oyRGENremPT+R6ks
	Y3Vnd/Qp9zwgtBsxwnzIf4xeCihtizXv5nLDo0W+N7XeFsReUN8p
X-Google-Smtp-Source: AGHT+IFXk98Z6sai4VIGKfOsUqS2xRklDo82+kdtgYRE0ObJpnOwACdZzbhwqGKmYs2TNeHa0lOGGA==
X-Received: by 2002:a05:6000:4282:b0:3a4:e93b:481c with SMTP id ffacd0b85a97d-3a4fe39192dmr7794549f8f.28.1748920449758;
        Mon, 02 Jun 2025 20:14:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm149643895e9.29.2025.06.02.20.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 20:14:09 -0700 (PDT)
Message-Id: <05140e2171d393b89faf8b47ee3bcceac3d7b2ff.1748920445.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
References: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
	<pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 03:14:04 +0000
Subject: [PATCH v5 3/3] pack-bitmap: add load corrupt bitmap test
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

This patch add test_bitmap_list_commits_offset() in patch-bitmap.c,
a new test helper command `test-tool bitmap list-commits-offset`,
and a `load corrupt bitmap` test case in t5310.

The `load corrupt bitmap` test case intentionally corrupt the
"xor_offset" field of the first entry. And the newly added helper
can help to find position of "xor_offset" in bitmap file.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c           | 62 +++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 ++++++
 t/t5310-pack-bitmaps.sh | 30 ++++++++++++++++++++
 4 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e514c9da239b..0825129b58f3 100644
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
index a62b463eaf09..df05d7419185 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -486,6 +486,36 @@ test_bitmap_cases () {
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
