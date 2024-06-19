Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1E15E5B6
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834313; cv=none; b=EXdWhz1fwLlZ0VdJJG9KgV2nUHOa98gWP9V4woMIvK/LCfDGGikx5Dg9wm8Foq1J3PfSj4vY8t/nlQ2rzGdkj4ngvu14U1Maekdwqhwrjlonhx+mZ/YTqIHonS2wxHbkSUZq7QjlzlRXSIAFtn3J6Iv+r+McbNzCKm6eEndZ6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834313; c=relaxed/simple;
	bh=1qdLIoFSUgyvssKL+DH0shSkFtdUFYfnIwnU85xRdZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GCGJ9jJmaYmjqcfIDnjPW8Lk3YgfUi2Is/8zkLhb0zbvsPONQcck44LUqIDO2wmUqNmmpLniVt52k1ULKsJcvScdIcI+fIeMIU8G6onWQRk48YQQkXQQXdinxAvalibG65S8UkaeRTE7VPuhHmHXgBZZyzTKhs8QWbAaJR1zzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFOlGt4Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFOlGt4Z"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so2684375e9.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834310; x=1719439110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKVNq4r8msXSpCZMZ10W80EOKH6+V9QNxWEoviIrmrM=;
        b=HFOlGt4ZF0sUpiI5Xhnozjrv+ScHKd4wnsCU+sGO0EWkqI8gwzdriAYPYy0zYGRxyG
         aUbVoYVlSvEgWkHUy9oslEtDw/S3jx8T5Yi84HCnHOSrzQ9t37WTHyPR4Zbcr8+eooFT
         eMh/5ja95UBVVt+17c9ZVaOm0NNhcLKWh/t4WNdusvf4bXtTpn5nKI/yFUglQAXF2JQe
         2VCyplqC9r5r4M/eRFdIU04OKaOt0z4yxwdwQTmcZco0rVGM1nkCQr13cKLo6duZlTuz
         SS/ha29bj83jtSDUUZDIvQuo0j5nnYYMpoNJdQCZS/4PsN9L9T3t0qFDn9dNDi/PPW9u
         no5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834310; x=1719439110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKVNq4r8msXSpCZMZ10W80EOKH6+V9QNxWEoviIrmrM=;
        b=TJsiBvcdQ57TJ2iTGhJhb/GbDyLCXI/bVKvxq1toNjVMXwcL/RR1olXO8Ixus01HAG
         y9ktf/FhG7tlnBBbONz3gjHFfgPZCl8xZqHzCPy9ilyuln6la7colLeWzYhu8ur1crYT
         U6FL+wwD3K9KUf0eaKm7uSwR+HYhmgzwIQQKQmU/vKbB3BhzRmhzipEDxNVYXosP+9v3
         erOR+wU3HEYkeVVJChLt5CyxZGrt3ZGHLfn90nMMfhux5Ot/3PSohH9ZsT30yei4JLN/
         K3AKsr7k8FW0DEihjfuz6wbpyj2skGZujdMi8wrfsCUuC+qiAx/UOi8Skr6k/n7xkXJh
         L4rg==
X-Gm-Message-State: AOJu0Yx60/Rs9wkNi9AwnOjfVCW/WDp5XnvG8LdWo7wZzBQDerxQPyIs
	vZaY3M/vf7XQoiOzqscJSI59Z/VfM6UnMgehxO07TejS4s7VqBniSix0JA==
X-Google-Smtp-Source: AGHT+IEPP2F8/N+4wecG7jD/zqNAfbKIv2z2uSk0T0OH4jLu0suqEL9KDo6NAg3Qb2hADxqTwAE2dQ==
X-Received: by 2002:a05:600c:214c:b0:422:615f:649c with SMTP id 5b1f17b1804b1-42475078374mr29183765e9.7.1718834309773;
        Wed, 19 Jun 2024 14:58:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c0d56sm3828205e9.13.2024.06.19.14.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:28 -0700 (PDT)
Message-Id: <d392c440b8a243a9fa3e5b603c42a81f02c26e62.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:58:05 +0000
Subject: [PATCH v2 17/17] mktree: remove entries when mode is 0
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

If tree entries are specified with a mode with value '0', remove them from
the tree instead of adding/updating them. If the mode is '0', both the
provided type string (if specified) and the object ID of the entry are
ignored.

Note that entries with mode '0' are added to the 'struct tree_ent_array'
with a trailing slash so that it's always treated like a directory. This is
a bit of a hack to ensure that the removal supercedes any preceding entries
with matching names, as well as any nested inside a directory matching its
name.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |  4 ++++
 builtin/mktree.c             | 16 +++++++++++----
 t/t1010-mktree.sh            | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 43cd9b10cc7..52e6005c1d3 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -63,6 +63,10 @@ entries nested within one or more directories. These entries are inserted
 into the appropriate tree in the base tree-ish if one exists. Otherwise,
 empty parent trees are created to contain the entries.
 
+An entry with a mode of "0" will remove an entry of the same name from the
+base tree-ish. If no tree-ish argument is given, or the entry does not exist
+in that tree, the entry is ignored.
+
 The order of the tree entries is normalized by `mktree` so pre-sorting the
 input by path is not required. Multiple entries provided with the same path
 are deduplicated, with only the last one specified added to the tree.
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 74cec92a517..e7adcb384c8 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -32,7 +32,7 @@ struct tree_entry {
 
 static inline size_t df_path_len(size_t pathlen, unsigned int mode)
 {
-	return S_ISDIR(mode) ? pathlen - 1 : pathlen;
+	return (S_ISDIR(mode) || !mode) ? pathlen - 1 : pathlen;
 }
 
 struct tree_entry_array {
@@ -108,7 +108,7 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 		size_t len_to_copy = len;
 
 		/* Normalize and validate entry path */
-		if (S_ISDIR(mode)) {
+		if (S_ISDIR(mode) || !mode) {
 			while(len_to_copy > 0 && is_dir_sep(path[len_to_copy - 1]))
 				len_to_copy--;
 			len = len_to_copy + 1; /* add space for trailing slash */
@@ -124,7 +124,7 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 			arr->has_nested_entries = 1;
 
 		/* Add trailing slash to dir */
-		if (S_ISDIR(mode))
+		if (S_ISDIR(mode) || !mode)
 			ent->name[len - 1] = '/';
 	}
 
@@ -209,7 +209,7 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 
 			if (!skip_entry) {
 				arr->entries[arr->nr++] = curr;
-				if (S_ISDIR(curr->mode))
+				if (S_ISDIR(curr->mode) || !curr->mode)
 					tree_entry_array_push(&parent_dir_ents, curr);
 			} else {
 				FREE_AND_NULL(curr);
@@ -270,6 +270,9 @@ static int build_index_from_tree(const struct object_id *oid,
 static int add_tree_entry_to_index(struct build_index_data *data,
 				   struct tree_entry *ent)
 {
+	if (!ent->mode)
+		return 0;
+
 	if (ent->expand_dir) {
 		int ret = 0;
 		struct pathspec ps = { 0 };
@@ -450,6 +453,10 @@ static int mktree_line(unsigned int mode, struct object_id *oid,
 	if (stage)
 		die(_("path '%s' is unmerged"), path);
 
+	/* OID ignored for zero-mode entries; append unconditionally */
+	if (!mode)
+		goto append_entry;
+
 	if (obj_type != OBJ_ANY && mode_type != obj_type)
 		die("object type (%s) doesn't match mode type (%s)",
 		    type_name(obj_type), type_name(mode_type));
@@ -484,6 +491,7 @@ static int mktree_line(unsigned int mode, struct object_id *oid,
 		}
 	}
 
+append_entry:
 	append_to_tree(mode, oid, path, data->arr, data->literally);
 	return 0;
 }
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 9b0e0cf302f..5ed4352054a 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -369,4 +369,42 @@ test_expect_success 'mktree fails on directory-file conflict' '
 	test_grep "You have both folder/one and folder/one/deeper/deep" err
 '
 
+test_expect_success 'mktree with remove entries' '
+	tree_oid="$(cat tree)" &&
+	blob_oid="$(git rev-parse $tree_oid:folder.txt)" &&
+
+	{
+		printf "100644 blob $blob_oid\ttest/deeper/deep.txt\n" &&
+		printf "100644 blob $blob_oid\ttest.txt\n" &&
+		printf "100644 blob $blob_oid\texample\n" &&
+		printf "100644 blob $blob_oid\texample.a/file\n" &&
+		printf "100644 blob $blob_oid\texample.txt\n" &&
+		printf "040000 tree $tree_oid\tfolder\n" &&
+		printf "0 $ZERO_OID\tfolder\n" &&
+		printf "0 $ZERO_OID\tmissing\n"
+	} | git mktree >tree.base &&
+
+	{
+		printf "0 $ZERO_OID\texample.txt\n" &&
+		printf "0 $ZERO_OID\ttest/deeper\n"
+	} | git mktree $(cat tree.base) >tree.actual &&
+
+	{
+		printf "100644 blob $blob_oid\texample\n" &&
+		printf "100644 blob $blob_oid\texample.a/file\n" &&
+		printf "100644 blob $blob_oid\ttest.txt\n"
+	} >expect &&
+	git ls-tree -r $(cat tree.actual) >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'type and oid not checked if entry mode is 0' '
+	# type and oid do not match
+	printf "0 commit $EMPTY_TREE\tfolder.txt\n" |
+	git mktree >tree.actual &&
+
+	test "$(cat tree.actual)" = $EMPTY_TREE
+'
+
 test_done
-- 
gitgitgadget
