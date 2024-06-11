Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB884D14
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130306; cv=none; b=Z9ckCDNfVoh57TeB9ZgUXyXSs97xUjN3zqgxCNliEdLAxyko6XM9xBODxHBcupiTqgfDFAK2E6N+A9dfjWJUTiZW8LGz7fk0UiUifrBwZdyIVNGfEqk/D0gOQUqitShLu8KDqsNQEUjE3ye2wXY19iL+gXZKdR6kGj9Wnhj1fTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130306; c=relaxed/simple;
	bh=EYIU2ZUTPNHcI8Ir1ovFkeSNyZ5uNmYuDke9nuYLUW8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=svZHdfhqGp56Cb6xuWGdfYXLBLYxlAMkcYy/UFXfitqeoYzE9pilm7egGcG59RDMMWjEqoG72c8WvtrpmT0g+QearKqSsY7LzjD7DqR47oVyXz7WeV+EsX8HDQ+hzvwvO98UD0aDPN4ivDeiCZAJXh/kN/AuAvxzt3BaoLhSvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEcuC0dS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEcuC0dS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42281d8cd2dso327405e9.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130302; x=1718735102; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV51om7aiHQeQkc031BzkWonrWwPeiG+D47N+moPbpw=;
        b=SEcuC0dSNNqRQBxqpElkiMN8EKbeXhea8JFTN8XYsSno/IjDQWzjZMTpG3zE3BnJ3N
         slN84pMQSvQoPPcpdWQXEYFGLkVi+WGXY5sdQEfHLwf8cMdUuVzx+WjwXEw31+hslDlq
         GS7Sb+LT0yYtktYyAj1WQ8Z4T6YzdsePZ5aEnhHkXlCE60V6LBujk8wHUU0l6YPd6XCK
         5FCE7/eMrZdgxKGEAhrWt5l6Svr8TaGzYzVhXbDdqukmTrZknMJ9r7Niq+VlfoI1Z2l1
         txe85bKYrk1IXV3rvH/aiZOxTM7fZPgT6Mr/dBwbsvgXqjO1z8KSj7LhHMdEMW0y+U5e
         a0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130302; x=1718735102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV51om7aiHQeQkc031BzkWonrWwPeiG+D47N+moPbpw=;
        b=H+yM4XFzhp/pm4CSYSfdDE2YdtRWzHS1+9VBa6U2vJzjxjP/PxbLPrpx/mjW36Wo+Q
         S2seTZlJj6PFzz39YcGD1d4A2yn2aDSMTXQESpTphQBp3Jvv54QGM+lY3mSyUuMew+Gw
         ppBdNc1VmhFir5cSh+p4KUEPG8QKt6wYGtS+6L0Am9pYL1LtVYHRdid3FGQyvZE28Ymg
         bJGQrBtnH1FLO86Fo5IcWfIkyyW/FJ6bxRhlz1uXHHvrPAbN8I8jkQ23p3d/lxMikTls
         BDZ7Alam8rSbWG1/GwwDZDIAc0SNze72BnwwB/XX9P4X/FKO8DCzpj4GVXlDudslx5qw
         RuYg==
X-Gm-Message-State: AOJu0YxnqUOEQvKPC0uQEDgbz0rwp5UWH5VaH372AcNK95cxVxujffCW
	6rGONSovBnE7OXj7teM8RT4vCoJF8G9lPmfsz2LFFwtuXaaNgkhed9ykLA==
X-Google-Smtp-Source: AGHT+IFMRuO4rW2ZiK4v2nJ6Gh0JjbLcNz9d6VOAveyvO3UHGLq4fTQtaKGgPX5VgGgLtspdzZsnsA==
X-Received: by 2002:a05:600c:35c7:b0:422:48a:c04d with SMTP id 5b1f17b1804b1-422048ac3e8mr51040635e9.6.1718130302314;
        Tue, 11 Jun 2024 11:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4217f633f2asm113132635e9.28.2024.06.11.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:25:01 -0700 (PDT)
Message-Id: <df0c50dfea3cb77e0070246efdf7a3f070b2ad97.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:46 +0000
Subject: [PATCH 14/16] mktree: optionally add to an existing tree
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
 builtin/mktree.c             | 134 ++++++++++++++++++++++++++++++-----
 t/t1010-mktree.sh            |  36 ++++++++++
 3 files changed, 157 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index afbc846d077..99abd3c31a6 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -9,7 +9,7 @@ git-mktree - Build a tree-object from formatted tree entries
 SYNOPSIS
 --------
 [verse]
-'git mktree' [-z] [--missing] [--literally] [--batch]
+'git mktree' [-z] [--missing] [--literally] [--batch] [--] [<tree-ish>]
 
 DESCRIPTION
 -----------
@@ -40,6 +40,11 @@ OPTIONS
 	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 
+<tree-ish>::
+	If provided, the tree entries provided in stdin are added to this tree
+	rather than a new empty one, replacing existing entries with identical
+	names. Not compatible with `--literally`.
+
 INPUT FORMAT
 ------------
 Tree entries may be specified in any of the formats compatible with the
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 09b3c5c6244..9e9d2554cad 100644
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
@@ -206,45 +208,122 @@ static struct tree_entry *advance_tree_entry_iterator(struct tree_entry_iterator
 	return prev;
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
+			advance_tree_entry_iterator(&cbdata->iter);
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
 	struct tree_entry *ent;
-	struct index_state istate = INDEX_STATE_INIT(the_repository);
-	istate.sparse_index = 1;
+	struct pathspec ps = { 0 };
 
 	sort_and_dedup_tree_entry_array(arr);
 
-	init_tree_entry_iterator(&iter, arr);
+	index_state_init(&cbdata.istate, the_repository);
+	cbdata.istate.sparse_index = 1;
+	init_tree_entry_iterator(&cbdata.iter, arr);
+	cbdata.df_name_hash = &arr->df_name_hash;
 
 	/* Construct an in-memory index from the provided entries & base tree */
-	while ((ent = advance_tree_entry_iterator(&iter))) {
-		if (add_tree_entry_to_index(&istate, ent))
+	if (base_tree &&
+	    read_tree(the_repository, base_tree, &ps, build_index_from_tree, &cbdata) < 0)
+		die(_("failed to create tree"));
+
+	while ((ent = advance_tree_entry_iterator(&cbdata.iter))) {
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
+	"git mktree [-z] [--missing] [--literally] [--batch] [--] [<tree-ish>]",
 	NULL
 };
 
@@ -326,6 +405,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	int is_batch_mode = 0;
 	struct tree_entry_array arr = { 0 };
 	struct mktree_line_data mktree_line_data = { .arr = &arr };
+	struct tree *base_tree = NULL;
 	int ret;
 
 	const struct option option[] = {
@@ -338,6 +418,22 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
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
 
 	init_tree_entry_array(&arr);
 
@@ -361,7 +457,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			if (mktree_line_data.literally)
 				write_tree_literally(&arr, &oid);
 			else
-				write_tree(&arr, &oid);
+				write_tree(&arr, base_tree, &oid);
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 956692347f0..ea5a011405e 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -238,4 +238,40 @@ test_expect_success 'mktree with duplicate entries' '
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

