Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391454279
	for <git@vger.kernel.org>; Sun, 25 May 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748138772; cv=none; b=I01vpov4wvhfsnpAVmKexcBKDPtUNDJWfmeKE7yrwRegO8cYpSHo/EHKToMkzwuWhsUeax3lxeD4jZIm7cyx73Zc1wHxsOlJV93vUMgLwa+yNfeAFsCVNZTSpsy1HAJmJF6pwUWPnmMquaV6yW4yfpolRiQSP+d3WhMmcRe441c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748138772; c=relaxed/simple;
	bh=X+9Yi4bGGF1LBCdWwWUfAnW/gdpwerjQHLK+SKZTMHs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FvovDLw9wYqlOurhHOfRO2BdpqvHtYDsx07mW3AS0e2Cz2p0zMnhCeRm+ucjFOb62OgZWk1QYEy+LHGdiQV079VHr8AESm1mGgq5t+23wi1n+mE3UEiuZOiTTnjjt0w2xedw0TVjh7xB1JJkul5zBZPHomCtv5k3oZLcbBNF7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEb2OAq/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEb2OAq/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso6276005e9.1
        for <git@vger.kernel.org>; Sat, 24 May 2025 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748138768; x=1748743568; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzi0LU2Gy+uzAzHg7LcHkaliLyYdM072rwhyQTkDFD0=;
        b=BEb2OAq/Mfq5jb+8D4K5dwhH07oQPE9xBdulVywC0tCEkf9TCBOjfnY26ZS9YAh6un
         Df3WpU5PvQd9/CnbpqFcRWbvrbxfkAOAIeFX0RMsbumHBOoB39L1kRNUbPrfQqcEnIdb
         n8kVS2/pOdtU9Fk4g7IAxtFCA+obuWrvOmUbjSlO/YKDTl9bPy7RcpBY3HCXbLTC1U1j
         z6TMXj/ymWUONYvXyK56kZlY5nHWT0XWZYZaE7xuQRHugq661EpWHfDr2HVFLVqTfW1G
         ZEtCe5wkXV73nDV+LhVVen6S3csfeoPkR3NuGVZvvjEGKCCie04LoBw9RTV3DMKOaoQB
         5uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748138768; x=1748743568;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lzi0LU2Gy+uzAzHg7LcHkaliLyYdM072rwhyQTkDFD0=;
        b=iyuNO4JoEU+R3hW+JUBrzA3I68fLQHT6Mu/zGXWnIMYWv394fvE37SX0o1x0FfLOlf
         DNHKutTB4nhc620I9UiwQBtmWrjiywcIvyJSkXaPpVr925AIcjYtfiL5wGDbrnvhJV3R
         cYY6Givj3zHTMnHaIP3W5QgXhXDm0Rwji3w6yBUZSBNIGk6o7goym27smbY3UDurKyRB
         58LARiCxAgreqnO+qKU49TWNTeiGbBXGjZlMmr1k/9zdsKSiwOd0gB8tiffZmFjLMCGr
         OK/J/Kfq965hgS1BpWMon8gQ/kZpL/3GbPn+LPhsNs8Lx/c39JSSFcO4YQibo1GUY7RN
         b9ww==
X-Gm-Message-State: AOJu0YwCXCAwpNTeNFNFnqmn0Jnnh28KGFqH6aCMoqFo47nCCRUlHYxj
	aeU9ax1ukQO+JLm6olXYoAfZrNXEBi9T67Z5RslyV0JR1RRxsWcguf1lRXAmiA==
X-Gm-Gg: ASbGncvRSVNmQx7WgiuRnIbDwr9JDPPiQMnZ1sB9V7UOR7RHVDzCq2wlA+81ymmMMm5
	ia3dV4ktBwNkjqA2VTigxYCbuvUkHlYdtslbiQtXpOiTVoaIftOEr4u/NLFngaL/MlESBYI2ed/
	5hrxwCfzwqkkk5sZUzvI6Fcs7OusXAUzmUMa14pi1H+Xrz/dP+BqQGVxCciBwXq6XZM+gVtBnAf
	eX7KAmWQL3ypdkuPTq5FoGYVw7h+MPMbfEdomuHog+n2Z91l3RE3ndm1ffZuvzym3kWO6/pmhZD
	zlVkzr+4mYsCB4ji2gvg3zsqpWQP7985m9hsgljhC+S8BG7FXjgU
X-Google-Smtp-Source: AGHT+IHY2CEQVn1GDuXN0fpu9bI6LtIrOcTB3dCiPBVRprm5cVAJv7xC9X/JqMz7+LhLw/AtKlbv6Q==
X-Received: by 2002:a05:600c:5006:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-44c9493e665mr35033275e9.21.1748138767960;
        Sat, 24 May 2025 19:06:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f45a8434sm203702425e9.0.2025.05.24.19.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 19:06:07 -0700 (PDT)
Message-Id: <f5371d7daa94242c13d98e2a003b9d05d4ef52a9.1748138764.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
	<pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 02:06:04 +0000
Subject: [PATCH v3 2/2] pack-bitmap: add load corrupt bitmap test
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
 pack-bitmap.c           | 73 +++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 +++++
 t/t5310-pack-bitmaps.sh | 27 +++++++++++++++
 4 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fd19c2255163..39c1c1bc4ce1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -34,6 +34,11 @@ struct stored_bitmap {
 	int flags;
 };
 
+struct stored_bitmap_tag_pos {
+	struct stored_bitmap stored;
+	size_t map_pos;
+};
+
 /*
  * The active bitmap index for a repository. By design, repositories only have
  * a single bitmap index available (the index for the biggest packfile in
@@ -148,6 +153,7 @@ static int existing_bitmaps_hits_nr;
 static int existing_bitmaps_misses_nr;
 static int roots_with_bitmaps_nr;
 static int roots_without_bitmaps_nr;
+static int tag_pos_on_bitmap;
 
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
@@ -314,13 +320,18 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 					  struct ewah_bitmap *root,
 					  const struct object_id *oid,
 					  struct stored_bitmap *xor_with,
-					  int flags)
+					  int flags, size_t map_pos)
 {
 	struct stored_bitmap *stored;
+	struct stored_bitmap_tag_pos *tagged;
 	khiter_t hash_pos;
 	int ret;
 
-	stored = xmalloc(sizeof(struct stored_bitmap));
+	tagged = xmalloc(tag_pos_on_bitmap ? sizeof(struct stored_bitmap_tag_pos) :
+					     sizeof(struct stored_bitmap));
+	stored = &tagged->stored;
+	if (tag_pos_on_bitmap)
+		tagged->map_pos = map_pos;
 	stored->root = root;
 	stored->xor = xor_with;
 	stored->flags = flags;
@@ -376,10 +387,12 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
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
@@ -402,8 +415,9 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		if (!bitmap)
 			return -1;
 
-		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
-			index, bitmap, &oid, xor_bitmap, flags);
+		recent_bitmaps[i % MAX_XOR_OFFSET] =
+			store_bitmap(index, bitmap, &oid, xor_bitmap, flags,
+				     entry_map_pos);
 	}
 
 	return 0;
@@ -869,6 +883,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	int xor_flags;
 	khiter_t hash_pos;
 	struct bitmap_lookup_table_xor_item *xor_item;
+	size_t entry_map_pos;
 
 	if (is_corrupt)
 		return NULL;
@@ -928,6 +943,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 			goto corrupt;
 		}
 
+		entry_map_pos = bitmap_git->map_pos;
 		bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
 		xor_flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
 		bitmap = read_bitmap_1(bitmap_git);
@@ -935,7 +951,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		if (!bitmap)
 			goto corrupt;
 
-		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid, xor_bitmap, xor_flags);
+		xor_bitmap = store_bitmap(bitmap_git, bitmap, &xor_item->oid,
+					  xor_bitmap, xor_flags, entry_map_pos);
 		xor_items_nr--;
 	}
 
@@ -969,6 +986,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	 * Instead, we can skip ahead and immediately read the flags and
 	 * ewah bitmap.
 	 */
+	entry_map_pos = bitmap_git->map_pos;
 	bitmap_git->map_pos += sizeof(uint32_t) + sizeof(uint8_t);
 	flags = read_u8(bitmap_git->map, &bitmap_git->map_pos);
 	bitmap = read_bitmap_1(bitmap_git);
@@ -976,7 +994,8 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	if (!bitmap)
 		goto corrupt;
 
-	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
+	return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags,
+			    entry_map_pos);
 
 corrupt:
 	free(xor_items);
@@ -2856,6 +2875,48 @@ int test_bitmap_commits(struct repository *r)
 	return 0;
 }
 
+int test_bitmap_commits_offset(struct repository *r)
+{
+	struct object_id oid;
+	struct stored_bitmap_tag_pos *tagged;
+	struct bitmap_index *bitmap_git;
+	size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
+		ewah_bitmap_map_pos;
+
+	tag_pos_on_bitmap = 1;
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git)
+		die(_("failed to load bitmap indexes"));
+
+	/*
+	 * As this function is only used to print bitmap selected
+	 * commits, we don't have to read the commit table.
+	 */
+	if (bitmap_git->table_lookup) {
+		if (load_bitmap_entries_v1(bitmap_git) < 0)
+			die(_("failed to load bitmap indexes"));
+	}
+
+	kh_foreach (bitmap_git->bitmaps, oid, tagged, {
+		commit_idx_pos_map_pos = tagged->map_pos;
+		xor_offset_map_pos = tagged->map_pos + sizeof(uint32_t);
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
index 382d39499af2..96880ba3d72d 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -81,6 +81,7 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
+int test_bitmap_commits_offset(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
 int test_bitmap_pseudo_merges(struct repository *r);
 int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 3f23f2107268..65a1ab29192b 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -10,6 +10,11 @@ static int bitmap_list_commits(void)
 	return test_bitmap_commits(the_repository);
 }
 
+static int bitmap_list_commits_offset(void)
+{
+	return test_bitmap_commits_offset(the_repository);
+}
+
 static int bitmap_dump_hashes(void)
 {
 	return test_bitmap_hashes(the_repository);
@@ -36,6 +41,8 @@ int cmd__bitmap(int argc, const char **argv)
 
 	if (argc == 2 && !strcmp(argv[1], "list-commits"))
 		return bitmap_list_commits();
+	if (argc == 2 && !strcmp(argv[1], "list-commits-offset"))
+		return bitmap_list_commits_offset();
 	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
 		return bitmap_dump_hashes();
 	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
@@ -46,6 +53,7 @@ int cmd__bitmap(int argc, const char **argv)
 		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
 
 	usage("\ttest-tool bitmap list-commits\n"
+	      "\ttest-tool bitmap list-commits-offset\n"
 	      "\ttest-tool bitmap dump-hashes\n"
 	      "\ttest-tool bitmap dump-pseudo-merges\n"
 	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a62b463eaf09..ef4c5fbaae83 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -486,6 +486,33 @@ test_bitmap_cases () {
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
+			read oid commit_off xor_off flag_off ewah_off <<-EOF &&
+				$(test-tool bitmap list-commits-offset | head -n 1)
+			EOF
+			printf '\161' |
+				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$xor_off &&
+
+
+			git rev-list --count HEAD > expect &&
+			git rev-list --use-bitmap-index --count HEAD > actual &&
+			test_cmp expect actual
+		)
+	'
 }
 
 test_bitmap_cases
-- 
gitgitgadget
