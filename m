Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135B8595F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130307; cv=none; b=q+yg4ZAcQxIo0K8eKcNdxU2m/qDl4Hh2mu5nEfvgn+/7M6xW4Y1hf+XGMDpp+un8H80jUdG0Pnum096+j2wA7UzHFXBp/OeGmeW60yBlS44gbwPuGZ4UFquzZA0iKFPzjLUWQ0TdQItmrEspYkGl8j04xn8T2nxbv435kzJeI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130307; c=relaxed/simple;
	bh=0IVyjfuzNt8rxSM0c/CZCQ9n39ivfh64zsuV2ro/GjE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vkr+CyW1W7rYynpuiDZoNgLZLOSNrpd+Fy3oEfNNWk8i1arT2Uhfg+oHWkPX6eC/07sAVCw0FS2SDM6/RHB+xZ+DprbQ7JD+PS4KDLYna2pnxRobTq+M2XDxJFw6Eoe7+8d817rTKrYJ27iq1hXXx4LALl5NGNWHkTAWZbNDr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATjfvY1Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATjfvY1Z"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso25889725e9.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130303; x=1718735103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMUgIifCil1XQvF8cIEvY0+SJAPRnU7WEq//C93eiBY=;
        b=ATjfvY1ZjJ1CI6B+UFiqhSU0YqGpR7aBKSwfO1w12oPO14PuDEKKMu99bxtpAOg6ik
         J9DOxCXIh4JkonPeANh6tdZYKVW02bKAJAQUqJ6yHfZtS71m5sog97AjBDz7+t/ZSxZ3
         Dghx2vmu7UdOvYJMPRi2GYW591ZQtFXwGdWk/AJMZojNWhC70qn5GjwJ6q620vC55PZl
         69DwzUSy9/3E3iZkQeiRb87JQKdrm7tDQ4MOIfZArNJCW/1JQ1FKhJq0KkBkQru5dSrP
         tGc/NXnoRSUgrGg8Y9FwAoosEnEiIevIaMNsbKFNnYcsSuZGHwIZwq3Mk9U3vxJCxYM3
         XHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130303; x=1718735103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMUgIifCil1XQvF8cIEvY0+SJAPRnU7WEq//C93eiBY=;
        b=oHCkKv6XLwrB3D0Sv/whSd8tOn3vJo8R9dHEXhEVQSXnVxD7ajEpF9CYyGwoXK9ppa
         PqXDRvc4el2Tg0wCCSuRyMPoa5qrkAiXdtqHgjej2T3f86LyPG7/vTpcwQq9Hj4roUvj
         RIF860Kn43D5L1sGWbEpRrqilkJ2bVs0dFnSrInlSh7wTeRNmKFeMqjl6Ui9KXE0af21
         e54ePEWywVZJarGUpcT/OkSHLGQMFS8eiyTqY9DbzNCygjKcf6FPn1fIm4DXgR7o8zsZ
         J48tNq1IDsmvFR0t6buQi/XBZiWrvO7IAeILnbdMQuum7Mq8+O6yFexuJGI58A8oTH7A
         vEEQ==
X-Gm-Message-State: AOJu0YwvvuXus9iPjelfZVD3cDEV2A4SwMOHCsQ35u5qD//M9/N7a4Tk
	JGvPPbm5AyMV4M0WYqtbDNN9irYaZywg5BDwsrLmudzgmj+naR7RMWrsDQ==
X-Google-Smtp-Source: AGHT+IEFNizW+ECTuQqUy3hJ1PoqvU5o9nnPjfS/WCSrWj7jrHsQq1J1W3jvZm0zWVz/9QCnASpWGA==
X-Received: by 2002:a05:6000:367:b0:357:7590:921d with SMTP id ffacd0b85a97d-35efee184f5mr10825665f8f.66.1718130302999;
        Tue, 11 Jun 2024 11:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23a651d4sm6430408f8f.50.2024.06.11.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:25:02 -0700 (PDT)
Message-Id: <058354f45f7b837ebeb08337a8dfd6e0ec1e9d1b.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:47 +0000
Subject: [PATCH 15/16] mktree: allow deeper paths in input
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
index 99abd3c31a6..db90fdcdc8f 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -50,6 +50,11 @@ INPUT FORMAT
 Tree entries may be specified in any of the formats compatible with the
 `--index-info` option to linkgit:git-update-index[1].
 
+Entries may use full pathnames containing directory separators to specify
+entries nested within one or more directories. These entries are inserted into
+the appropriate tree in the base tree-ish if one exists. Otherwise, empty parent
+trees are created to contain the entries.
+
 The order of the tree entries is normalized by `mktree` so pre-sorting the input
 by path is not required. Multiple entries provided with the same path are
 deduplicated, with only the last one specified added to the tree.
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 9e9d2554cad..00b77869a56 100644
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
 static void clear_tree_entry_array(struct tree_entry_array *arr)
 {
 	hashmap_clear(&arr->df_name_hash);
@@ -107,8 +116,10 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 
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
@@ -167,6 +178,46 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
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
+		release_tree_entry_array(&parent_dir_ents);
+	}
+
 	/* Finally, initialize the directory-file conflict hash map */
 	for (size_t i = 0; i < count; i++) {
 		struct tree_entry *curr = arr->entries[i];
@@ -214,15 +265,40 @@ struct build_index_data {
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
 
@@ -249,10 +325,12 @@ static int build_index_from_tree(const struct object_id *oid,
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
 			advance_tree_entry_iterator(&cbdata->iter);
 
@@ -266,6 +344,11 @@ static int build_index_from_tree(const struct object_id *oid,
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
index ea5a011405e..1d6365141fc 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -89,12 +89,21 @@ test_expect_success 'mktree with invalid submodule OIDs' '
 	grep "object $tree_oid is a tree but specified type was (commit)" err
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
@@ -238,6 +247,50 @@ test_expect_success 'mktree with duplicate entries' '
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
@@ -274,4 +327,50 @@ test_expect_success 'mktree with base tree' '
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
+	grep "You have both test and test/deeper" err &&
+
+	{
+		printf "100644 blob $blob_oid\tfolder/one/deeper/deep\n"
+	} |
+	test_must_fail git mktree $tree_oid 2>err &&
+	grep "You have both folder/one and folder/one/deeper/deep" err
+'
+
 test_done
-- 
gitgitgadget

