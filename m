Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05915B107
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834312; cv=none; b=sw8toDtUDiAscIgOyrifvgcHQppKDQD+Xi/b4/W5ewW2hUJEE3XtSzQOHECy3EtejGBcNNbcikjd5CBktuZGzXuzN825LhZt9eaMZZ0svmr3f1NvZWh5jCA6LViHsfoJTycvEN3hjdeR7GfNVQQ/fE548gLndAHzvsR4u7/Homw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834312; c=relaxed/simple;
	bh=y9kXnukQCaW2qEZVpqJ03InrVGLJdG/hB61ORUmL5vw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TiUXEXhAduysz9aiQ25Li+/Rh2CxuPwaMk9+vk9CpfkemCzpwLUNZ+0AXrtYTGXr+X+TXK21s+iy4JcZh4Kt2w331uGomZ6EYXfCFHoZrbfvrWcoVi5W+N+3AXbEg8HMKRcMuR6BO2IzoKefISoRrsL5r4OUqy7N4aVeczpLf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKxCqwPc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKxCqwPc"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so2925045e9.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834308; x=1719439108; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IACMqB6eF9Z/KR274+LycKgdN94U1Sz+Li3LNDTj2qw=;
        b=fKxCqwPcGHms86pKfOCYy6FGMGU4KNKF5rx5ji6TLqa0hWgNbdeNndw9a/FTPsuGhK
         eNh5aRlp1KDKGv1JGkHbIoWocrLvAca4LFr5l8xQaw8SfRC/+fMjm7No7Uk0PIbU92Wl
         fvKgmgdRWRF5eH3ZX8aap/7C6qyOynVGlk/R8BGtkuiDiRn9gzdE2dZMGVPdm9+DORKf
         RgFTzQELFoJpowYlMGzZA6g23+UpLzSlAgQ1Gm615aCqxnw6my9826wG/YV010QmlBFb
         SzrWMOZ5q3xBToscAxzGbec2w4UNLbh+u8OXc/ZVyDDydgz+wTM2Ia4ERgf/TMJPaADA
         BKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834308; x=1719439108;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IACMqB6eF9Z/KR274+LycKgdN94U1Sz+Li3LNDTj2qw=;
        b=o1FJKBYz3vWLCqm218vEJv3t+jduxnnvYT10RyKsx1U4u9COgMAjq09jF5JnSKkdyR
         RhOvuNqm51/9+vPdWi0SOndlCzx2A97+aKxRvdcs4Em1x8dpkmCccQKALv+3AW3RdKsv
         ZL2UT1vUrMnITZdo38vWRcurBO4VNK8OmJSwtsc2zy7hFhhdfwmKV4Mr/M6cRNe/kKyL
         I7GrOLa4gPd+8CPaGuyqaOniQgQN86h6+JBUr1axWecHvspEKANBIh/gFzf4819rWeJN
         +ew8gwzitsK3kihmke3PqiQwK/GmLBV4nV2jbyRBOgEzwMGtlN9zdVjKRbE7tpE5cQVF
         MCAA==
X-Gm-Message-State: AOJu0Yzzh4Q1mJvxHkqniB/peZajK+48WDmDRn1AXhyyWVcOJCNqxg/k
	8hd4S4COsxsJXLa80LJJo/+dhNwDPvcgS4CiPKUr1T+ahCUYP48vTiwzKw==
X-Google-Smtp-Source: AGHT+IG8GfKuO2l0KLyrgYys6pj1iwxys1Jsuh4otGspxuMlZUrFNEZ+gy20KLpkkgl16U7F5G5jZg==
X-Received: by 2002:a05:600c:2106:b0:422:e7e8:588a with SMTP id 5b1f17b1804b1-424751763ddmr26829345e9.16.1718834308332;
        Wed, 19 Jun 2024 14:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54c9sm3907805e9.27.2024.06.19.14.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:27 -0700 (PDT)
Message-Id: <46756c4e3140d34838ad4cd5e7a070d1f9f46b53.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:58:04 +0000
Subject: [PATCH v2 16/17] mktree: allow deeper paths in input
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

Update 'git mktree' to handle entries nested inside of directories (e.g.
'path/to/a/file.txt'). This functionality requires a series of changes:

* In 'sort_and_dedup_tree_entry_array()', remove entries inside of
  directories that come after them in input order.
* Also in 'sort_and_dedup_tree_entry_array()', mark directories that contain
  entries that come after them in input order (e.g., 'folder/' followed by
  'folder/file.txt') as "need to expand".
* In 'add_tree_entry_to_index()', if a tree entry is marked as "need to
  expand", recurse into it with 'read_tree_at()' & 'build_index_from_tree'.
* In 'build_index_from_tree()', if a user-specified tree entry is contained
  within the current iterated entry, return 'READ_TREE_RECURSIVE' to recurse
  into the iterated tree.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |   5 ++
 builtin/mktree.c             | 101 ++++++++++++++++++++++++++++++---
 t/t1010-mktree.sh            | 107 +++++++++++++++++++++++++++++++++--
 3 files changed, 200 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 260d0e0bd7b..43cd9b10cc7 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -58,6 +58,11 @@ Higher stages represent conflicted files in an index; this information
 cannot be represented in a tree object. The command will fail without
 writing the tree if a higher order stage is specified for any entry.
 
+Entries may use full pathnames containing directory separators to specify
+entries nested within one or more directories. These entries are inserted
+into the appropriate tree in the base tree-ish if one exists. Otherwise,
+empty parent trees are created to contain the entries.
+
 The order of the tree entries is normalized by `mktree` so pre-sorting the
 input by path is not required. Multiple entries provided with the same path
 are deduplicated, with only the last one specified added to the tree.
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 96f06547a2a..74cec92a517 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -22,6 +22,7 @@ struct tree_entry {
 
 	/* Internal */
 	size_t order;
+	int expand_dir;
 
 	unsigned mode;
 	struct object_id oid;
@@ -39,6 +40,7 @@ struct tree_entry_array {
 	struct tree_entry **entries;
 
 	struct hashmap df_name_hash;
+	int has_nested_entries;
 };
 
 static int df_name_hash_cmp(const void *cmp_data UNUSED,
@@ -70,6 +72,13 @@ static void tree_entry_array_push(struct tree_entry_array *arr, struct tree_entr
 	arr->entries[arr->nr++] = ent;
 }
 
+static struct tree_entry *tree_entry_array_pop(struct tree_entry_array *arr)
+{
+	if (!arr->nr)
+		return NULL;
+	return arr->entries[--arr->nr];
+}
+
 static void tree_entry_array_clear(struct tree_entry_array *arr, int free_entries)
 {
 	if (free_entries) {
@@ -109,8 +118,10 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 
 		if (!verify_path(ent->name, mode))
 			die(_("invalid path '%s'"), path);
-		if (strchr(ent->name, '/'))
-			die("path %s contains slash", path);
+
+		/* mark has_nested_entries if needed */
+		if (!arr->has_nested_entries && strchr(ent->name, '/'))
+			arr->has_nested_entries = 1;
 
 		/* Add trailing slash to dir */
 		if (S_ISDIR(mode))
@@ -168,6 +179,46 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	ignore_mode = 0;
 	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
 
+	if (arr->has_nested_entries) {
+		struct tree_entry_array parent_dir_ents = { 0 };
+
+		count = arr->nr;
+		arr->nr = 0;
+
+		/* Remove any entries where one of its parent dirs has a higher 'order' */
+		for (size_t i = 0; i < count; i++) {
+			const char *skipped_prefix;
+			struct tree_entry *parent;
+			struct tree_entry *curr = arr->entries[i];
+			int skip_entry = 0;
+
+			while ((parent = tree_entry_array_pop(&parent_dir_ents))) {
+				if (!skip_prefix(curr->name, parent->name, &skipped_prefix))
+					continue;
+
+				/* entry in dir, so we push the parent back onto the stack */
+				tree_entry_array_push(&parent_dir_ents, parent);
+
+				if (parent->order > curr->order)
+					skip_entry = 1;
+				else
+					parent->expand_dir = 1;
+
+				break;
+			}
+
+			if (!skip_entry) {
+				arr->entries[arr->nr++] = curr;
+				if (S_ISDIR(curr->mode))
+					tree_entry_array_push(&parent_dir_ents, curr);
+			} else {
+				FREE_AND_NULL(curr);
+			}
+		}
+
+		tree_entry_array_release(&parent_dir_ents, 0);
+	}
+
 	/* Finally, initialize the directory-file conflict hash map */
 	for (size_t i = 0; i < count; i++) {
 		struct tree_entry *curr = arr->entries[i];
@@ -212,15 +263,40 @@ struct build_index_data {
 	struct index_state istate;
 };
 
+static int build_index_from_tree(const struct object_id *oid,
+				 struct strbuf *base, const char *filename,
+				 unsigned mode, void *context);
+
 static int add_tree_entry_to_index(struct build_index_data *data,
 				   struct tree_entry *ent)
 {
-	struct cache_entry *ce;
-	ce = make_cache_entry(&data->istate, ent->mode, &ent->oid, ent->name, 0, 0);
-	if (!ce)
-		return error(_("make_cache_entry failed for path '%s'"), ent->name);
+	if (ent->expand_dir) {
+		int ret = 0;
+		struct pathspec ps = { 0 };
+		struct tree *subtree = parse_tree_indirect(&ent->oid);
+		struct strbuf base_path = STRBUF_INIT;
+		strbuf_add(&base_path, ent->name, ent->len);
+
+		if (!subtree)
+			ret = error(_("not a tree object: %s"), oid_to_hex(&ent->oid));
+		else if (read_tree_at(the_repository, subtree, &base_path, 0, &ps,
+				 build_index_from_tree, data) < 0)
+			ret = -1;
+
+		strbuf_release(&base_path);
+		if (ret)
+			return ret;
+
+	} else {
+		struct cache_entry *ce = make_cache_entry(&data->istate,
+							  ent->mode, &ent->oid,
+							  ent->name, 0, 0);
+		if (!ce)
+			return error(_("make_cache_entry failed for path '%s'"), ent->name);
+
+		add_index_entry(&data->istate, ce, ADD_CACHE_JUST_APPEND);
+	}
 
-	add_index_entry(&data->istate, ce, ADD_CACHE_JUST_APPEND);
 	return 0;
 }
 
@@ -247,10 +323,12 @@ static int build_index_from_tree(const struct object_id *oid,
 		base_tree_ent->name[base_tree_ent->len - 1] = '/';
 
 	while (cbdata->iter.current) {
+		const char *skipped_prefix;
 		struct tree_entry *ent = cbdata->iter.current;
+		int cmp;
 
-		int cmp = name_compare(ent->name, ent->len,
-				       base_tree_ent->name, base_tree_ent->len);
+		cmp = name_compare(ent->name, ent->len,
+				   base_tree_ent->name, base_tree_ent->len);
 		if (!cmp || cmp < 0) {
 			tree_entry_iterator_advance(&cbdata->iter);
 
@@ -264,6 +342,11 @@ static int build_index_from_tree(const struct object_id *oid,
 				goto cleanup_and_return;
 			} else
 				continue;
+		} else if (skip_prefix(ent->name, base_tree_ent->name, &skipped_prefix) &&
+			   S_ISDIR(base_tree_ent->mode)) {
+			/* The entry is in the current traversed tree entry, so we recurse */
+			result = READ_TREE_RECURSIVE;
+			goto cleanup_and_return;
 		}
 
 		break;
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 435ac23bd50..9b0e0cf302f 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -85,12 +85,21 @@ test_expect_success 'mktree with invalid submodule OIDs' '
 	done
 '
 
-test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
-	test_must_fail git mktree <all
+test_expect_success 'mktree reads ls-tree -r output (1)' '
+	git mktree <all >actual &&
+	test_cmp tree actual
 '
 
-test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
-	test_must_fail git mktree <all.withsub
+test_expect_success 'mktree reads ls-tree -r output (2)' '
+	git mktree <all.withsub >actual &&
+	test_cmp tree.withsub actual
+'
+
+test_expect_success 'mktree de-duplicates files inside directories' '
+	git ls-tree $(cat tree) >everything &&
+	cat <all >top_and_all &&
+	git mktree <top_and_all >actual &&
+	test_cmp tree actual
 '
 
 test_expect_success 'mktree fails on malformed input' '
@@ -234,6 +243,50 @@ test_expect_success 'mktree with duplicate entries' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mktree adds entry after nested entry' '
+	tree_oid=$(cat tree) &&
+	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
+	one_oid=$(git rev-parse ${tree_oid}:folder/one) &&
+
+	{
+		printf "040000 tree $folder_oid\tearly\n" &&
+		printf "100644 blob $one_oid\tearly/one\n" &&
+		printf "100644 blob $one_oid\tlater\n" &&
+		printf "040000 tree $EMPTY_TREE\tnew-tree\n" &&
+		printf "100644 blob $one_oid\tnew-tree/one\n" &&
+		printf "100644 blob $one_oid\tzzz\n"
+	} >top.rec &&
+	git mktree <top.rec >tree.actual &&
+
+	{
+		printf "040000 tree $folder_oid\tearly\n" &&
+		printf "100644 blob $one_oid\tlater\n" &&
+		printf "040000 tree $folder_oid\tnew-tree\n" &&
+		printf "100644 blob $one_oid\tzzz\n"
+	} >expect &&
+	git ls-tree $(cat tree.actual) >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree inserts entries into directories' '
+	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
+	one_oid=$(git rev-parse ${tree_oid}:folder/one) &&
+	blob_oid=$(git rev-parse ${tree_oid}:before) &&
+	{
+		printf "040000 tree $folder_oid\tfolder\n" &&
+		printf "100644 blob $blob_oid\tfolder/two\n"
+	} | git mktree >actual &&
+
+	{
+		printf "100644 blob $one_oid\tfolder/one\n" &&
+		printf "100644 blob $blob_oid\tfolder/two\n"
+	} >expect &&
+	git ls-tree -r $(cat actual) >actual &&
+
+	test_cmp expect actual
+'
+
 test_expect_success 'mktree with base tree' '
 	tree_oid=$(cat tree) &&
 	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
@@ -270,4 +323,50 @@ test_expect_success 'mktree with base tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mktree with base tree (deep)' '
+	tree_oid=$(cat tree) &&
+	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
+	before_oid=$(git rev-parse ${tree_oid}:before) &&
+	folder_one_oid=$(git rev-parse ${tree_oid}:folder/one) &&
+	head_oid=$(git rev-parse HEAD) &&
+
+	{
+		printf "100755 blob $before_oid\tfolder/before\n" &&
+		printf "100644 blob $before_oid\tfolder/one.txt\n" &&
+		printf "160000 commit $head_oid\tfolder/sub\n" &&
+		printf "040000 tree $folder_oid\tfolder/one\n" &&
+		printf "040000 tree $folder_oid\tfolder/one/deeper\n"
+	} >top.append &&
+	git mktree <top.append $(cat tree) >tree.actual &&
+
+	{
+		printf "100755 blob $before_oid\tfolder/before\n" &&
+		printf "100644 blob $before_oid\tfolder/one.txt\n" &&
+		printf "100644 blob $folder_one_oid\tfolder/one/deeper/one\n" &&
+		printf "100644 blob $folder_one_oid\tfolder/one/one\n" &&
+		printf "160000 commit $head_oid\tfolder/sub\n"
+	} >expect &&
+	git ls-tree -r $(cat tree.actual) -- folder/ >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree fails on directory-file conflict' '
+	tree_oid="$(cat tree)" &&
+	blob_oid="$(git rev-parse $tree_oid:folder.txt)" &&
+
+	{
+		printf "100644 blob $blob_oid\ttest\n" &&
+		printf "100644 blob $blob_oid\ttest/deeper\n"
+	} |
+	test_must_fail git mktree 2>err &&
+	test_grep "You have both test and test/deeper" err &&
+
+	{
+		printf "100644 blob $blob_oid\tfolder/one/deeper/deep\n"
+	} |
+	test_must_fail git mktree $tree_oid 2>err &&
+	test_grep "You have both folder/one and folder/one/deeper/deep" err
+'
+
 test_done
-- 
gitgitgadget

