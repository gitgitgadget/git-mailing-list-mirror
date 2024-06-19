Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056B15DBA8
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834311; cv=none; b=OMYjLBdy1YjWbgVtMtou5OWkcwieVSLOXzzc4N/rwX+Fkt6kPy9Umkml4t3vK21/gNJJHobclaTM9Hnz2GpcP8fSPO3VHc70PPq7At3ztAF/EKksdPQ6yacWOO6bejwvKNT0iOYkof3wZaPoSwDi2cYvGeCgJrYGjuH77jDat3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834311; c=relaxed/simple;
	bh=EJkvuGbB5Mho8ZJAzXf+luq5+goTwPnEryY86pw2wh8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qTcIMGVkYFWpNrMfHBD0yC0F+BoB51ijL60YI+YlQc5c7Tbef62HsmXwHT+ZR4e31FIhPM1abwRd0Uqx9zs9KDKGOzs0dYfjul0qaH+pxrfwzftsfmWg9jwPmeniMQkBkGQABp/SJwaRHJqqglS/cGOmo9bgcpGwUFrwORwgUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0sHLTBy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0sHLTBy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3639e27a43dso107030f8f.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834307; x=1719439107; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRmF5QXkD3MGeDDaTRzsQrGMPbXgrgLXbOYzwoc+vrk=;
        b=e0sHLTByoPy+ke1ysv1pXtBImYt2iO7hnDSMpa4pfdlFA8f0FwA+FiEFXxN/5r2JZ1
         Wl94JIXByNyM05wRS7o7ZJEPCRPZ6W7DbMmwwrtH7x7gwe59HOgw65ZQa+MXQ96aYakz
         4QDgyr/g8sNrPtXBCREDmJLeGx0LJXphq6UvA/71B7Ao7+Rx2aGgnWIL7IoVg38d2U7R
         CQF/Te6ALjPfyykJpNoXMqgkNOZbzzs0je3Z52eeViNtO72uiShkBs0ENSGrPqVvylh6
         EuLYpFqoWasu0ueTC3MmGG5CIV0Thi3CaXvuD2BTbQp1BQzIHKhISv1k/5HgW8bmY7Ch
         hKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834307; x=1719439107;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRmF5QXkD3MGeDDaTRzsQrGMPbXgrgLXbOYzwoc+vrk=;
        b=bXyuZ4efyvam5VQ8XkLo44Wsqg6iB0FdDLXK1HtzkcxRir7qQrHjXZlPe3JMzYPMx/
         sOpej4cMvGilTObnM4uEPUxquysC6r3SRJEUGtP2aSY1TkH5ennmefM56OvFBYHeG8A+
         xA/ms7O1hS6TDFv4zz8HqdwrjxtfUw08hkh/xos/n6R0J7zkwUFOp3BZs5c9mNZNh/iW
         i44i8I0hKLibdWnUEpXoTiAkHAS9I3E61bgc9+26pt/qNPcuJn6h/mojGj9rUo+iTx4/
         WhUyhaHOY+0IizhIMBv2XvnkQrugb1OyOXMWN32+fl3lZQGa02HzHTw+YvHHtpJno+OC
         TW7Q==
X-Gm-Message-State: AOJu0YxDbF/isG3aHdy93+EJ5Skbl9BEaHGsU6m4WxkkSwnwtVTXH0fg
	10+JbtV//Uswn2AP1XE0ITU3RWEwvlcaDYJh1akrBnJF2Bkr2YRPYhbfYw==
X-Google-Smtp-Source: AGHT+IGcHv7JqQ4DPVMWD80ryrgmqhEWj7OI8cfewqRMPZ1QCfGwTsSaMtNGbsrZ0+/rVN/qCDKmKg==
X-Received: by 2002:a5d:4709:0:b0:361:fd04:95ed with SMTP id ffacd0b85a97d-363176ad7ebmr2803945f8f.15.1718834307247;
        Wed, 19 Jun 2024 14:58:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607510340fsm18210002f8f.93.2024.06.19.14.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:26 -0700 (PDT)
Message-Id: <4b88f84b933b1598d12e3620f0c9fb85c559e8fb.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:58:03 +0000
Subject: [PATCH v2 15/17] mktree: optionally add to an existing tree
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

Allow users to specify a single "tree-ish" value as a positional argument.
If provided, the contents of the given tree serve as the basis for the new
tree (or trees, in --batch mode) created by 'mktree', on top of which all of
the stdin-provided tree entries are applied.

At a high level, the entries are "applied" to a base tree by iterating
through the base tree using 'read_tree' in parallel with iterating through
the sorted & deduplicated stdin entries via their iterator. That is, for
each call to the 'build_index_from_tree callback of 'read_tree':

* If the iterator entry precedes the base tree entry, add it to the in-core
  index, increment the iterator, and repeat.
* If the iterator entry has the same name as the base tree entry, add the
  iterator entry to the index, increment the iterator, and return from the
  callback to continue the 'read_tree' iteration.
* If the iterator entry follows the base tree entry, first check
  'df_name_hash' to ensure we won't be adding an entry with the same name
  later (with a different mode). If there's no directory/file conflict, add
  the base tree entry to the index. In either case, return from the callback
  to continue the 'read_tree' iteration.

Finally, once 'read_tree' is complete, add the remaining entries in the
iterator to the index and write out the index as a tree.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |   7 +-
 builtin/mktree.c             | 138 +++++++++++++++++++++++++++++------
 t/t1010-mktree.sh            |  36 +++++++++
 3 files changed, 159 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index cf1fd82f754..260d0e0bd7b 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -9,7 +9,7 @@ git-mktree - Build a tree-object from formatted tree entries
 SYNOPSIS
 --------
 [verse]
-'git mktree' [-z] [--missing] [--literally] [--batch]
+'git mktree' [-z] [--missing] [--literally] [--batch] [<tree-ish>]
 
 DESCRIPTION
 -----------
@@ -41,6 +41,11 @@ OPTIONS
 	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 
+<tree-ish>::
+	If provided, the tree entries provided in stdin are added to this
+	tree rather than a new empty one, replacing existing entries with
+	identical names. Not compatible with `--literally`.
+
 INPUT FORMAT
 ------------
 Tree entries may be specified in any of the formats compatible with the
diff --git a/builtin/mktree.c b/builtin/mktree.c
index b4d71dcdd02..96f06547a2a 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,7 +12,9 @@
 #include "read-cache-ll.h"
 #include "strbuf.h"
 #include "tree.h"
+#include "object-name.h"
 #include "parse-options.h"
+#include "pathspec.h"
 #include "object-store-ll.h"
 
 struct tree_entry {
@@ -204,47 +206,124 @@ static void tree_entry_iterator_advance(struct tree_entry_iterator *iter)
 			: NULL;
 }
 
-static int add_tree_entry_to_index(struct index_state *istate,
+struct build_index_data {
+	struct tree_entry_iterator iter;
+	struct hashmap *df_name_hash;
+	struct index_state istate;
+};
+
+static int add_tree_entry_to_index(struct build_index_data *data,
 				   struct tree_entry *ent)
 {
 	struct cache_entry *ce;
-	struct strbuf ce_name = STRBUF_INIT;
-	strbuf_add(&ce_name, ent->name, ent->len);
-
-	ce = make_cache_entry(istate, ent->mode, &ent->oid, ent->name, 0, 0);
+	ce = make_cache_entry(&data->istate, ent->mode, &ent->oid, ent->name, 0, 0);
 	if (!ce)
 		return error(_("make_cache_entry failed for path '%s'"), ent->name);
 
-	add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
-	strbuf_release(&ce_name);
+	add_index_entry(&data->istate, ce, ADD_CACHE_JUST_APPEND);
 	return 0;
 }
 
-static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
+static int build_index_from_tree(const struct object_id *oid,
+				 struct strbuf *base, const char *filename,
+				 unsigned mode, void *context)
 {
-	struct tree_entry_iterator iter = { NULL };
-	struct index_state istate = INDEX_STATE_INIT(the_repository);
-	istate.sparse_index = 1;
+	int result;
+	struct tree_entry *base_tree_ent;
+	struct build_index_data *cbdata = context;
+	size_t filename_len = strlen(filename);
+	size_t path_len = S_ISDIR(mode) ? st_add3(filename_len, base->len, 1)
+					: st_add(filename_len, base->len);
+
+	/* Create a tree entry from the current entry in read_tree iteration */
+	base_tree_ent = xcalloc(1, st_add3(sizeof(struct tree_entry), path_len, 1));
+	base_tree_ent->len = path_len;
+	base_tree_ent->mode = mode;
+	oidcpy(&base_tree_ent->oid, oid);
+
+	memcpy(base_tree_ent->name, base->buf, base->len);
+	memcpy(base_tree_ent->name + base->len, filename, filename_len);
+	if (S_ISDIR(mode))
+		base_tree_ent->name[base_tree_ent->len - 1] = '/';
+
+	while (cbdata->iter.current) {
+		struct tree_entry *ent = cbdata->iter.current;
+
+		int cmp = name_compare(ent->name, ent->len,
+				       base_tree_ent->name, base_tree_ent->len);
+		if (!cmp || cmp < 0) {
+			tree_entry_iterator_advance(&cbdata->iter);
+
+			if (add_tree_entry_to_index(cbdata, ent) < 0) {
+				result = error(_("failed to add tree entry '%s'"), ent->name);
+				goto cleanup_and_return;
+			}
+
+			if (!cmp) {
+				result = 0;
+				goto cleanup_and_return;
+			} else
+				continue;
+		}
+
+		break;
+	}
+
+	/*
+	 * If the tree entry should be replaced with an entry with the same name
+	 * (but different mode), skip it.
+	 */
+	hashmap_entry_init(&base_tree_ent->ent,
+			   memhash(base_tree_ent->name, df_path_len(base_tree_ent->len, base_tree_ent->mode)));
+	if (hashmap_get_entry(cbdata->df_name_hash, base_tree_ent, ent, NULL)) {
+		result = 0;
+		goto cleanup_and_return;
+	}
+
+	if (add_tree_entry_to_index(cbdata, base_tree_ent)) {
+		result = -1;
+		goto cleanup_and_return;
+	}
+
+	result = 0;
+
+cleanup_and_return:
+	FREE_AND_NULL(base_tree_ent);
+	return result;
+}
+
+static void write_tree(struct tree_entry_array *arr, struct tree *base_tree,
+		       struct object_id *oid)
+{
+	struct build_index_data cbdata = { 0 };
+	struct pathspec ps = { 0 };
 
 	sort_and_dedup_tree_entry_array(arr);
 
-	tree_entry_iterator_init(&iter, arr);
+	index_state_init(&cbdata.istate, the_repository);
+	cbdata.istate.sparse_index = 1;
+	tree_entry_iterator_init(&cbdata.iter, arr);
+	cbdata.df_name_hash = &arr->df_name_hash;
 
 	/* Construct an in-memory index from the provided entries & base tree */
-	while (iter.current) {
-		struct tree_entry *ent = iter.current;
-		tree_entry_iterator_advance(&iter);
+	if (base_tree &&
+	    read_tree(the_repository, base_tree, &ps, build_index_from_tree, &cbdata) < 0)
+		die(_("failed to create tree"));
+
+	while (cbdata.iter.current) {
+		struct tree_entry *ent = cbdata.iter.current;
+		tree_entry_iterator_advance(&cbdata.iter);
 
-		if (add_tree_entry_to_index(&istate, ent))
+		if (add_tree_entry_to_index(&cbdata, ent))
 			die(_("failed to add tree entry '%s'"), ent->name);
 	}
 
 	/* Write out new tree */
-	if (cache_tree_update(&istate, WRITE_TREE_SILENT | WRITE_TREE_MISSING_OK))
+	if (cache_tree_update(&cbdata.istate, WRITE_TREE_SILENT | WRITE_TREE_MISSING_OK))
 		die(_("failed to write tree"));
-	oidcpy(oid, &istate.cache_tree->oid);
+	oidcpy(oid, &cbdata.istate.cache_tree->oid);
 
-	release_index(&istate);
+	release_index(&cbdata.istate);
 }
 
 static void write_tree_literally(struct tree_entry_array *arr,
@@ -268,7 +347,7 @@ static void write_tree_literally(struct tree_entry_array *arr,
 }
 
 static const char *mktree_usage[] = {
-	"git mktree [-z] [--missing] [--literally] [--batch]",
+	"git mktree [-z] [--missing] [--literally] [--batch] [<tree-ish>]",
 	NULL
 };
 
@@ -334,6 +413,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	struct tree_entry_array arr = { 0 };
 	struct mktree_line_data mktree_line_data = { .arr = &arr };
 	struct strbuf line = STRBUF_INIT;
+	struct tree *base_tree = NULL;
 	int ret;
 
 	const struct option option[] = {
@@ -346,6 +426,22 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	};
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
+	if (ac > 1)
+		usage_with_options(mktree_usage, option);
+
+	if (ac) {
+		struct object_id base_tree_oid;
+
+		if (mktree_line_data.literally)
+			die(_("option '%s' and tree-ish cannot be used together"), "--literally");
+
+		if (repo_get_oid(the_repository, av[0], &base_tree_oid))
+			die(_("not a valid object name %s"), av[0]);
+
+		base_tree = parse_tree_indirect(&base_tree_oid);
+		if (!base_tree)
+			die(_("not a tree object: %s"), oid_to_hex(&base_tree_oid));
+	}
 
 	tree_entry_array_init(&arr);
 
@@ -373,7 +469,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			if (mktree_line_data.literally)
 				write_tree_literally(&arr, &oid);
 			else
-				write_tree(&arr, &oid);
+				write_tree(&arr, base_tree, &oid);
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 08760141d6f..435ac23bd50 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -234,4 +234,40 @@ test_expect_success 'mktree with duplicate entries' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mktree with base tree' '
+	tree_oid=$(cat tree) &&
+	folder_oid=$(git rev-parse ${tree_oid}:folder) &&
+	before_oid=$(git rev-parse ${tree_oid}:before) &&
+	head_oid=$(git rev-parse HEAD) &&
+
+	{
+		printf "040000 tree $folder_oid\ttest\n" &&
+		printf "100644 blob $before_oid\ttest.txt\n" &&
+		printf "040000 tree $folder_oid\ttest-\n" &&
+		printf "160000 commit $head_oid\ttest0\n"
+	} >top.base &&
+	git mktree <top.base >tree.base &&
+
+	{
+		printf "100755 blob $before_oid\tz\n" &&
+		printf "160000 commit $head_oid\ttest.xyz\n" &&
+		printf "040000 tree $folder_oid\ta\n" &&
+		printf "100644 blob $before_oid\ttest\n"
+	} >top.append &&
+	git mktree $(cat tree.base) <top.append >tree.actual &&
+
+	{
+		printf "040000 tree $folder_oid\ta\n" &&
+		printf "100644 blob $before_oid\ttest\n" &&
+		printf "040000 tree $folder_oid\ttest-\n" &&
+		printf "100644 blob $before_oid\ttest.txt\n" &&
+		printf "160000 commit $head_oid\ttest.xyz\n" &&
+		printf "160000 commit $head_oid\ttest0\n" &&
+		printf "100755 blob $before_oid\tz\n"
+	} >expect &&
+	git ls-tree $(cat tree.actual) >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

