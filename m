Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06412C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6693610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFGMhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:31 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:46686 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFGMhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:25 -0400
Received: by mail-wm1-f41.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so5088473wmq.5
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vmwu6W4wC2XHe1k0Gpqxbz7pS0vrf/3ndg5LD7VPSvM=;
        b=ab3d0aSOhj/LnRuuAE1pHtJWrBYzC0fiKFn0ZbW7lxxBcr+c+WVGjDipv9fQIvOlBM
         9/F9ZQvBadi0BGugBgrd5U4Ht9RsIGcphpi0VLVJ7TXTW0ARA9K7Nj17/ZavNQZxnffz
         xcHwJdfykrZvTvVikXRNueYOEyJDszK8afpy9/Rp4JiAN39D2P1M52cyxJmO46ZEIUSz
         oXcY4aIf8GvBbS1v8r4hrMrlxmGb1Dsnye4l36qMFA2dA/MzKmLLR0YWtuasbkj+/445
         9dMJd0HVIAapJt+qZVs5PUpj/7z0PySDdACZoyWIz0gjwEbxiYn3bGKC8/e6GdKaXyTm
         B65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vmwu6W4wC2XHe1k0Gpqxbz7pS0vrf/3ndg5LD7VPSvM=;
        b=fNQCWeMPI4zVZTU1FhZyCWzqn3w1cTeBakN24NgGVNgUhjeoSevD2e+a7Pf2Ge10Id
         PHZKkzBbmmx+2JGRWt1oenEt2W3t50tKye7zDoDNZ/DNGCDtWQe3VNDOkv2En3XCX+YD
         E+7UJvvzBKxZMvnUBpXWV50ezxbGD161+Pe17DK7A+hgbHN/yQE43wAyrojVFR1OHV9g
         rbTR4okmiqoEs5PJyF9ipjupOrcWurk/ZA1eUdwpX2zdIaG+KjAO4JjeHZ/sj/98LcpR
         WPoGaylY2uKD2QkfgPnFztn4CKkun0szEv3hWoUcZqWJOcjjJQM7DQoAwxsnbD8cZCqz
         ixvg==
X-Gm-Message-State: AOAM533wm7KqR4hh505V8Y2mdTn4cDvfAxp+O+PEhw2JV24RZNOANgEr
        6A3m7HJ298phQ1bBdBRuiMbiuho/PHg=
X-Google-Smtp-Source: ABdhPJyP1Z+kIaDNLBcVNoivub87xxE4U3pTbLMRRmqJg0vBsqMDFC86XZwptdLratnX0emVcVAlpg==
X-Received: by 2002:a1c:3dc2:: with SMTP id k185mr5078066wma.15.1623069260116;
        Mon, 07 Jun 2021 05:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm14431982wmg.17.2021.06.07.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:19 -0700 (PDT)
Message-Id: <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:08 +0000
Subject: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While comparing an index to a tree, we may see a sparse directory entry.
In this case, we should compare that portion of the tree to the tree
represented by that entry. This could include a new tree which needs to
be expanded to a full list of added files. It could also include an
existing tree, in which case all of the changes inside are important to
describe, including the modifications, additions, and deletions. Note
that the case where the tree has a path and the index does not remains
identical to before: the lack of a cache entry is the same with a sparse
index.

In the case where a tree is modified, we need to expand the tree
recursively, and start comparing each contained entry as either an
addition, deletion, or modification. This causes an interesting
recursion that did not exist before.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff-lib.c | 188 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index b73cc1859a49..ba4c683d4bc4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -314,6 +314,48 @@ static int get_stat_data(const struct cache_entry *ce,
 	return 0;
 }
 
+struct show_new_tree_context {
+	struct rev_info *revs;
+	unsigned added:1;
+};
+
+static int show_new_file_from_tree(const struct object_id *oid,
+				   struct strbuf *base, const char *path,
+				   unsigned int mode, void *context)
+{
+	struct show_new_tree_context *ctx = context;
+	struct cache_entry *new_file = make_transient_cache_entry(mode, oid, path, /* stage */ 0);
+
+	diff_index_show_file(ctx->revs, ctx->added ? "+" : "-", new_file, oid, !is_null_oid(oid), mode, 0);
+	discard_cache_entry(new_file);
+	return 0;
+}
+
+static void show_directory(struct rev_info *revs,
+			   const struct cache_entry *new_dir,
+			   int added)
+{
+	/*
+	 * new_dir is a sparse directory entry, so we want to collect all
+	 * of the new files within the tree. This requires recursively
+	 * expanding the trees.
+	 */
+	struct show_new_tree_context ctx = { revs, added };
+	struct repository *r = revs->repo;
+	struct strbuf base = STRBUF_INIT;
+	struct pathspec ps;
+	struct tree *tree = lookup_tree(r, &new_dir->oid);
+
+	memset(&ps, 0, sizeof(ps));
+	ps.recursive = 1;
+	ps.has_wildcard = 1;
+	ps.max_depth = -1;
+
+	strbuf_add(&base, new_dir->name, new_dir->ce_namelen);
+	read_tree_at(r, tree, &base, &ps,
+			show_new_file_from_tree, &ctx);
+}
+
 static void show_new_file(struct rev_info *revs,
 			  const struct cache_entry *new_file,
 			  int cached, int match_missing)
@@ -322,6 +364,11 @@ static void show_new_file(struct rev_info *revs,
 	unsigned int mode;
 	unsigned dirty_submodule = 0;
 
+	if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
+		show_directory(revs, new_file, /*added */ 1);
+		return;
+	}
+
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working tree.
@@ -333,6 +380,136 @@ static void show_new_file(struct rev_info *revs,
 	diff_index_show_file(revs, "+", new_file, oid, !is_null_oid(oid), mode, dirty_submodule);
 }
 
+static int show_modified(struct rev_info *revs,
+			 const struct cache_entry *old_entry,
+			 const struct cache_entry *new_entry,
+			 int report_missing,
+			 int cached, int match_missing);
+
+static int compare_within_sparse_dir(int n, unsigned long mask,
+				     unsigned long dirmask, struct name_entry *entry,
+				     struct traverse_info *info)
+{
+	struct rev_info *revs = info->data;
+	struct object_id *oid0 = &entry[0].oid;
+	struct object_id *oid1 = &entry[1].oid;
+
+	if (oideq(oid0, oid1))
+		return mask;
+
+	/* Directory/file conflicts are handled earlier. */
+	if (S_ISDIR(entry[0].mode) && S_ISDIR(entry[1].mode)) {
+		struct tree_desc t[2];
+		void *buf[2];
+		struct traverse_info info_r = { NULL, };
+
+		info_r.name = xstrfmt("%s%s", info->traverse_path, entry[0].path);
+		info_r.namelen = strlen(info_r.name);
+		info_r.traverse_path = xstrfmt("%s/", info_r.name);
+		info_r.fn = compare_within_sparse_dir;
+		info_r.prev = info;
+		info_r.mode = entry[0].mode;
+		info_r.pathlen = entry[0].pathlen;
+		info_r.df_conflicts = 0;
+		info_r.data = revs;
+
+		buf[0] = fill_tree_descriptor(revs->repo, &t[0], oid0);
+		buf[1] = fill_tree_descriptor(revs->repo, &t[1], oid1);
+
+		traverse_trees(NULL, 2, t, &info_r);
+
+		free((char *)info_r.name);
+		free((char *)info_r.traverse_path);
+		free(buf[0]);
+		free(buf[1]);
+	} else {
+		char *old_path = NULL, *new_path = NULL;
+		struct cache_entry *old_entry = NULL, *new_entry = NULL;
+
+		if (entry[0].path) {
+			old_path = xstrfmt("%s%s", info->traverse_path, entry[0].path);
+			old_entry = make_transient_cache_entry(
+					entry[0].mode, &entry[0].oid,
+					old_path, /* stage */ 0);
+			old_entry->ce_flags |= CE_SKIP_WORKTREE;
+		}
+		if (entry[1].path) {
+			new_path = xstrfmt("%s%s", info->traverse_path, entry[1].path);
+			new_entry = make_transient_cache_entry(
+					entry[1].mode, &entry[1].oid,
+					new_path, /* stage */ 0);
+			new_entry->ce_flags |= CE_SKIP_WORKTREE;
+		}
+
+		if (entry[0].path && entry[1].path)
+			show_modified(revs, old_entry, new_entry, 0, 1, 0);
+		else if (entry[0].path)
+			diff_index_show_file(revs, revs->prefix,
+					     old_entry, &entry[0].oid,
+					     0, entry[0].mode, 0);
+		else if (entry[1].path)
+			show_new_file(revs, new_entry, 1, 0);
+
+		discard_cache_entry(old_entry);
+		discard_cache_entry(new_entry);
+		free(old_path);
+		free(new_path);
+	}
+
+	return mask;
+}
+
+static void show_modified_sparse_directory(struct rev_info *revs,
+			 const struct cache_entry *old_entry,
+			 const struct cache_entry *new_entry,
+			 int report_missing,
+			 int cached, int match_missing)
+{
+	struct tree_desc t[2];
+	void *buf[2];
+	struct traverse_info info = { NULL };
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf parent_path = STRBUF_INIT;
+	char *last_dir_sep;
+
+	if (oideq(&old_entry->oid, &new_entry->oid))
+		return;
+
+	info.fn = compare_within_sparse_dir;
+	info.prev = &info;
+
+	strbuf_add(&name, new_entry->name, new_entry->ce_namelen - 1);
+	info.name = name.buf;
+	info.namelen = name.len;
+
+	strbuf_add(&parent_path, new_entry->name, new_entry->ce_namelen - 1);
+	if ((last_dir_sep = find_last_dir_sep(parent_path.buf)) > parent_path.buf)
+		strbuf_setlen(&parent_path, (last_dir_sep - parent_path.buf) - 1);
+	else
+		strbuf_setlen(&parent_path, 0);
+
+	info.pathlen = parent_path.len;
+
+	if (parent_path.len)
+		info.traverse_path = parent_path.buf;
+	else
+		info.traverse_path = "";
+
+	info.mode = new_entry->ce_mode;
+	info.df_conflicts = 0;
+	info.data = revs;
+
+	buf[0] = fill_tree_descriptor(revs->repo, &t[0], &old_entry->oid);
+	buf[1] = fill_tree_descriptor(revs->repo, &t[1], &new_entry->oid);
+
+	traverse_trees(NULL, 2, t, &info);
+
+	free(buf[0]);
+	free(buf[1]);
+	strbuf_release(&name);
+	strbuf_release(&parent_path);
+}
+
 static int show_modified(struct rev_info *revs,
 			 const struct cache_entry *old_entry,
 			 const struct cache_entry *new_entry,
@@ -343,6 +520,17 @@ static int show_modified(struct rev_info *revs,
 	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
 
+	/*
+	 * If both are sparse directory entries, then expand the
+	 * modifications to the file level.
+	 */
+	if (old_entry && new_entry &&
+	    S_ISSPARSEDIR(old_entry->ce_mode) &&
+	    S_ISSPARSEDIR(new_entry->ce_mode)) {
+		show_modified_sparse_directory(revs, old_entry, new_entry, report_missing, cached, match_missing);
+		return 0;
+	}
+
 	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
-- 
gitgitgadget

