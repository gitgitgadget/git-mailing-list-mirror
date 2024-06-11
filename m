Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB87CF34
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130302; cv=none; b=GXhvAeWJUE9WviFKYY6DoU4A0nLWxLLINQZrNjaw6hal3USCxFIvx2sAKnMDGM7edf9FbHn/A+l2OVmywtwJ2mOQngib2OeDUKVErEx75PvB+Ph2ovwlyJIZVxwWg1Zg4lSNP+ASwrLCSn8jtEKmv6VhvJo/xX/hHw2kBcGeS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130302; c=relaxed/simple;
	bh=IeL9Arc+h5lfuMHS8Ekfoo4iNG75KeLinD+rTjXX6t4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s6JVT7O/kikub561ceIk0Q+D18FsDqehFJwOJ3B6SRLB7E2N73FoqSn2a43wiLSC5vV8a+Lc32OQFKsu1ey4E8Jd/u8AJBzfQpVzHxmUhhQx/k4X56sIttUJT1dpTPSgXTvdQCLyYiTAucTAIDV9ybOSpBVlUXcQklD31gdMyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/WeuXs5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/WeuXs5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f1a7386d5so2657593f8f.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130298; x=1718735098; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdofFrISorqAH4y+6Ll+hv1QLg2FISrP8aD/P0mjB9Q=;
        b=B/WeuXs5B58MBmKPFlJ4QVLeNovtpEFSYlYlqWZLsOSMxXl9Fjy93N8fo0Cu7Rk1Ih
         RpEv1Wv9RmjBKgW4KUuNa7zLMSgPto7eyHLW+fXY33TPCVn9NIS9weJ94vzNVUePgJes
         GiV7xae6vSzLfRk22GZGlQ6gIBIqIHEa/EYJLSvbWTI0ld1B7S4BTN9GXcYEttpkIP0d
         VfWuOb55jUibJk68JA6ZZfd4rYanNuxqTjdidGEu7A9yIgqC4W40h6Y7oYyqN+3xUXOg
         m6atBzQxDU95gyOCLktlYzHwtEjFUuseswVggiKMquc3M/7qv/8N0V2ptpCZ9a1c1Kcl
         lQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130298; x=1718735098;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdofFrISorqAH4y+6Ll+hv1QLg2FISrP8aD/P0mjB9Q=;
        b=cLOEdc4D5NNNLg96hOFGuMBhc/Jd6dY79lfVe15OdbRPLfMrt9cl8OlGw6Pw3zV3rV
         qQ9eorGcviXXztZR2bW0BMGPn7hnBhm96kGJDk5uqHpAGJtAukIKgJgYZlfos1MXCUJ6
         5EnZdzwD9A0of+aYk2pIDnYVBtMPV3WjsBlUAy73Kju37RXk8CsVGZ1W65Z8f5sQybRo
         cl65L5NpAFYaeCFzlA7SnCb1qKGmhz+J97+dT1y5RfMFlIMPIfbSHEGpiGgWwcNd/YIT
         yPVLSfJlM70sMrs3zTpeKJLPr+wkmKzaB+d3kDYueHqv8REzsJqAU1BtPkodkf1ObMmV
         dYZg==
X-Gm-Message-State: AOJu0YxCZYSEG2Sli/2d3d52ZmM9/UeXrA2/wO2S7GoXVqlto787q2x1
	FU5+SuH9ooqwhtAwfkamT6iQsdybRhvWC2wjtZAhFZlvs0p3mLjiU9dB5A==
X-Google-Smtp-Source: AGHT+IEZmFId6IPgfxnBHyRRrtahZ4Q3DIx27XqdxGO3uHMRInF3ICvmfFVLnpS05pPOdm+Y+GujNQ==
X-Received: by 2002:adf:ef47:0:b0:35f:fb4:fc7d with SMTP id ffacd0b85a97d-35f0fb50139mr6332549f8f.31.1718130298548;
        Tue, 11 Jun 2024 11:24:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d512556sm10989465f8f.29.2024.06.11.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:58 -0700 (PDT)
Message-Id: <b59a4ad8ab4b0e47373f811700eba59141fdc6c6.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:42 +0000
Subject: [PATCH 10/16] mktree: overwrite duplicate entries
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

If multiple tree entries with the same name are provided as input to
'mktree', only write the last one to the tree. Entries are considered
duplicates if they have identical names (*not* considering mode); if a blob
and a tree with the same name are provided, only the last one will be
written to the tree. A tree with duplicate entries is invalid (per 'git
fsck'), so that condition should be avoided wherever possible.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |  8 ++++---
 builtin/mktree.c             | 45 ++++++++++++++++++++++++++++++++----
 t/t1010-mktree.sh            | 36 +++++++++++++++++++++++++++--
 3 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index fb07e40cef0..afbc846d077 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -43,9 +43,11 @@ OPTIONS
 INPUT FORMAT
 ------------
 Tree entries may be specified in any of the formats compatible with the
-`--index-info` option to linkgit:git-update-index[1]. The order of the tree
-entries is normalized by `mktree` so pre-sorting the input by path is not
-required.
+`--index-info` option to linkgit:git-update-index[1].
+
+The order of the tree entries is normalized by `mktree` so pre-sorting the input
+by path is not required. Multiple entries provided with the same path are
+deduplicated, with only the last one specified added to the tree.
 
 GIT
 ---
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 29e9dc6ce69..e9e2134136f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -15,6 +15,9 @@
 #include "object-store-ll.h"
 
 struct tree_entry {
+	/* Internal */
+	size_t order;
+
 	unsigned mode;
 	struct object_id oid;
 	int len;
@@ -72,15 +75,49 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 	oidcpy(&ent->oid, oid);
 
 	/* Append the update */
+	ent->order = arr->nr;
 	tree_entry_array_push(arr, ent);
 }
 
-static int ent_compare(const void *a_, const void *b_)
+static int ent_compare(const void *a_, const void *b_, void *ctx)
 {
+	int cmp;
 	struct tree_entry *a = *(struct tree_entry **)a_;
 	struct tree_entry *b = *(struct tree_entry **)b_;
-	return base_name_compare(a->name, a->len, a->mode,
-				 b->name, b->len, b->mode);
+	int ignore_mode = *((int *)ctx);
+
+	if (ignore_mode)
+		cmp = name_compare(a->name, a->len, b->name, b->len);
+	else
+		cmp = base_name_compare(a->name, a->len, a->mode,
+					b->name, b->len, b->mode);
+	return cmp ? cmp : b->order - a->order;
+}
+
+static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
+{
+	size_t count = arr->nr;
+	struct tree_entry *prev = NULL;
+
+	int ignore_mode = 1;
+	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
+
+	arr->nr = 0;
+	for (size_t i = 0; i < count; i++) {
+		struct tree_entry *curr = arr->entries[i];
+		if (prev &&
+		    !name_compare(prev->name, prev->len,
+				  curr->name, curr->len)) {
+			FREE_AND_NULL(curr);
+		} else {
+			arr->entries[arr->nr++] = curr;
+			prev = curr;
+		}
+	}
+
+	/* Sort again to order the entries for tree insertion */
+	ignore_mode = 0;
+	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
 }
 
 static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
@@ -88,7 +125,7 @@ static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 	struct strbuf buf;
 	size_t size = 0;
 
-	QSORT(arr->entries, arr->nr, ent_compare);
+	sort_and_dedup_tree_entry_array(arr);
 	for (size_t i = 0; i < arr->nr; i++)
 		size += 32 + arr->entries[i]->len;
 
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index e0263cb2bf8..956692347f0 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -6,11 +6,16 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-	for d in a a- a0
+	for d in folder folder- folder0
 	do
 		mkdir "$d" && echo "$d/one" >"$d/one" &&
 		git add "$d" || return 1
 	done &&
+	for f in before folder.txt later
+	do
+		echo "$f" >"$f" &&
+		git add "$f" || return 1
+	done &&
 	echo zero >one &&
 	git update-index --add --info-only one &&
 	git write-tree --missing-ok >tree.missing &&
@@ -175,7 +180,7 @@ test_expect_success '--literally can create invalid trees' '
 
 test_expect_success 'mktree validates path' '
 	tree_oid="$(cat tree)" &&
-	blob_oid="$(git rev-parse $tree_oid:a/one)" &&
+	blob_oid="$(git rev-parse $tree_oid:folder.txt)" &&
 	head_oid="$(git rev-parse HEAD)" &&
 
 	# Valid: tree with or without trailing slash, blob without trailing slash
@@ -206,4 +211,31 @@ test_expect_success 'mktree validates path' '
 	grep "invalid path ${SQ}.git/${SQ}" err
 '
 
+test_expect_success 'mktree with duplicate entries' '
+	tree_oid=$(cat tree) &&
+	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
+	before_oid=$(git rev-parse ${tree_oid}:before) &&
+	head_oid=$(git rev-parse HEAD) &&
+
+	{
+		printf "100755 blob $before_oid\ttest\n" &&
+		printf "040000 tree $folder_oid\ttest-\n" &&
+		printf "160000 commit $head_oid\ttest.txt\n" &&
+		printf "040000 tree $folder_oid\ttest\n" &&
+		printf "100644 blob $before_oid\ttest0\n" &&
+		printf "160000 commit $head_oid\ttest-\n"
+	} >top.dup &&
+	git mktree <top.dup >tree.actual &&
+
+	{
+		printf "160000 commit $head_oid\ttest-\n" &&
+		printf "160000 commit $head_oid\ttest.txt\n" &&
+		printf "040000 tree $folder_oid\ttest\n" &&
+		printf "100644 blob $before_oid\ttest0\n"
+	} >expect &&
+	git ls-tree $(cat tree.actual) >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

