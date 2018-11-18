Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F881F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKSDI5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:08:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38697 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSDI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:08:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so19676184lfg.5
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2w2xnGKkxFwvLv4kTorT/OhDNZZPr5EhJR+5u7oRsCo=;
        b=GKzr1BL9YBlSjhwdA0oOUJylVoLV6ucKTZNRJlB0iSXsnzDUv+4jbwaE5LeqPuIm1Y
         IZfAcDJh9O8V9LaN7r9iPuFZ0j/V24v01lY5cY0b1sHmDeeRUfyLrMxZkY93XnmWLgfg
         dkS6dzSYqbyoNkxhI20s04B2vIbBPSfge02EHLc+LrEOttSEky1ZD3mHwfYLSWA9byzl
         IVFIRpLVPK8f4+Q94hahQeC93nHzQ5VtSBYnW3RzCRxRj+S1UMx3Fm0IcuAOkGQNqiLc
         H3ifaQ2YE0TwkSXB0w5NsGO6UutgTUdO5jk1E9/OiUOZ+kvcP0bBOShze7VAh7IhDs26
         Yh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2w2xnGKkxFwvLv4kTorT/OhDNZZPr5EhJR+5u7oRsCo=;
        b=tUz67eox9Az3xfmL49VNa1oRkpGhtxecvMFPz2GtXaCn7YAGF6XhxDRhq8MrKbWYvE
         87DzUvs2W/M/rATM2u6IwuQCmXySVGw6RTQ7P5zwCbjaLZm43traNyZ9STekJ8O0tS4q
         06H8fxVKn8HkG3lqm3dM6TpLzPFcf1M4B98SDrv98K5Xe+0BBi2qmUnEcIG3KmzCbKA5
         8ric9pyx+me7p8gie52T2fzJfZvImmpTCWWpBcF7/T3fwG+Fjzb69G21MpAIAMIQZig8
         fc6AuqIXGgJwmCxySSUbr7gz4LhpqTIea1HQfWd3KT86XAS4Cun3QwV8wg1ao7fM+T2d
         BqCw==
X-Gm-Message-State: AGRZ1gIyT89PXSstvBdH1slYZHl+PnMgXamCKMngfDZmXmk2qqBDCoEq
        UZXQaC6MehTCjMLrDegLgDFJ3w/Z
X-Google-Smtp-Source: AJdET5d+lHP2TMflfiD+cYLrL2P7OcETaOrNfiboKwAAiWtap4S/PCt6WoKvxnh8XHKd3t9mDKkZXA==
X-Received: by 2002:a19:d5:: with SMTP id 204mr8542646lfa.116.1542559688892;
        Sun, 18 Nov 2018 08:48:08 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f29sm4461603lfa.46.2018.11.18.08.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:48:08 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/5] tree-walk.c: make tree_entry_interesting() take an index
Date:   Sun, 18 Nov 2018 17:47:57 +0100
Message-Id: <20181118164800.32759-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181118164800.32759-1-pclouds@gmail.com>
References: <20181118164800.32759-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to support :(attr) when matching pathspec on a tree,
tree_entry_interesting() needs to take an index (because
git_check_attr() needs it). This is the preparation step for it. This
also makes it clearer what index we fall back to when looking up
attributes during an unpack-trees operation: the source index.

This also fixes revs->pruning.repo initialization that should have
been done in 2abf350385 (revision.c: remove implicit dependency on
the_index - 2018-09-21). Without it, skip_uninteresting() will
dereference a NULL pointer through this call chain

  get_revision(revs)
  get_revision_internal
  get_revision_1
  try_to_simplify_commit
  rev_compare_tree
  diff_tree_oid(..., &revs->pruning)
  ll_diff_tree_oid
  diff_tree_paths
  ll_diff_tree
  skip_uninteresting

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c       |  3 ++-
 builtin/merge-tree.c |  2 +-
 list-objects.c       |  3 ++-
 revision.c           |  1 +
 tree-diff.c          |  3 ++-
 tree-walk.c          | 22 ++++++++++++++--------
 tree-walk.h          | 10 ++++++----
 tree.c               |  3 ++-
 unpack-trees.c       |  6 +++---
 9 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 56e4a11052..f6e086c287 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -568,7 +568,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 
 		if (match != all_entries_interesting) {
 			strbuf_addstr(&name, base->buf + tn_len);
-			match = tree_entry_interesting(&entry, &name,
+			match = tree_entry_interesting(repo->index,
+						       &entry, &name,
 						       0, pathspec);
 			strbuf_setlen(&name, name_base_len);
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 70f6fc9167..4984b7e12e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -346,7 +346,7 @@ static void merge_trees(struct tree_desc t[3], const char *base)
 
 	setup_traverse_info(&info, base);
 	info.fn = threeway_callback;
-	traverse_trees(3, t, &info);
+	traverse_trees(&the_index, 3, t, &info);
 }
 
 static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..63c395d9c2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -113,7 +113,8 @@ static void process_tree_contents(struct traversal_context *ctx,
 
 	while (tree_entry(&desc, &entry)) {
 		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&entry, base, 0,
+			match = tree_entry_interesting(ctx->revs->repo->index,
+						       &entry, base, 0,
 						       &ctx->revs->diffopt.pathspec);
 			if (match == all_entries_not_interesting)
 				break;
diff --git a/revision.c b/revision.c
index bdd3e7c9f1..7ced1ee02b 100644
--- a/revision.c
+++ b/revision.c
@@ -1459,6 +1459,7 @@ void repo_init_revisions(struct repository *r,
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
+	revs->pruning.repo = r;
 	revs->pruning.flags.recursive = 1;
 	revs->pruning.flags.quick = 1;
 	revs->pruning.add_remove = file_add_remove;
diff --git a/tree-diff.c b/tree-diff.c
index 0e54324610..34ee3b13b8 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -299,7 +299,8 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
 	enum interesting match;
 
 	while (t->size) {
-		match = tree_entry_interesting(&t->entry, base, 0, &opt->pathspec);
+		match = tree_entry_interesting(opt->repo->index, &t->entry,
+					       base, 0, &opt->pathspec);
 		if (match) {
 			if (match == all_entries_not_interesting)
 				t->size = 0;
diff --git a/tree-walk.c b/tree-walk.c
index 79bafbd1a2..517bcdecf9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -365,7 +365,8 @@ static void free_extended_entry(struct tree_desc_x *t)
 	}
 }
 
-static inline int prune_traversal(struct name_entry *e,
+static inline int prune_traversal(struct index_state *istate,
+				  struct name_entry *e,
 				  struct traverse_info *info,
 				  struct strbuf *base,
 				  int still_interesting)
@@ -374,10 +375,13 @@ static inline int prune_traversal(struct name_entry *e,
 		return 2;
 	if (still_interesting < 0)
 		return still_interesting;
-	return tree_entry_interesting(e, base, 0, info->pathspec);
+	return tree_entry_interesting(istate, e, base,
+				      0, info->pathspec);
 }
 
-int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
+int traverse_trees(struct index_state *istate,
+		   int n, struct tree_desc *t,
+		   struct traverse_info *info)
 {
 	int error = 0;
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
@@ -461,7 +465,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		}
 		if (!mask)
 			break;
-		interesting = prune_traversal(e, info, &base, interesting);
+		interesting = prune_traversal(istate, e, info, &base, interesting);
 		if (interesting < 0)
 			break;
 		if (interesting) {
@@ -928,7 +932,8 @@ static int match_wildcard_base(const struct pathspec_item *item,
  * Pre-condition: either baselen == base_offset (i.e. empty path)
  * or base[baselen-1] == '/' (i.e. with trailing slash).
  */
-static enum interesting do_match(const struct name_entry *entry,
+static enum interesting do_match(struct index_state *istate,
+				 const struct name_entry *entry,
 				 struct strbuf *base, int base_offset,
 				 const struct pathspec *ps,
 				 int exclude)
@@ -1090,12 +1095,13 @@ static enum interesting do_match(const struct name_entry *entry,
  * Pre-condition: either baselen == base_offset (i.e. empty path)
  * or base[baselen-1] == '/' (i.e. with trailing slash).
  */
-enum interesting tree_entry_interesting(const struct name_entry *entry,
+enum interesting tree_entry_interesting(struct index_state *istate,
+					const struct name_entry *entry,
 					struct strbuf *base, int base_offset,
 					const struct pathspec *ps)
 {
 	enum interesting positive, negative;
-	positive = do_match(entry, base, base_offset, ps, 0);
+	positive = do_match(istate, entry, base, base_offset, ps, 0);
 
 	/*
 	 * case | entry | positive | negative | result
@@ -1132,7 +1138,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 	    positive <= entry_not_interesting) /* #1, #2, #11, #12 */
 		return positive;
 
-	negative = do_match(entry, base, base_offset, ps, 1);
+	negative = do_match(istate, entry, base, base_offset, ps, 1);
 
 	/* #8, #18 */
 	if (positive == all_entries_interesting &&
diff --git a/tree-walk.h b/tree-walk.h
index 196831007e..eefd26bb62 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,6 +1,7 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+struct index_state;
 struct strbuf;
 
 struct name_entry {
@@ -48,7 +49,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid);
 
 struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
-int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
+int traverse_trees(struct index_state *istate, int n, struct tree_desc *t, struct traverse_info *info);
 
 enum follow_symlinks_result {
 	FOUND = 0, /* This includes out-of-tree links */
@@ -98,8 +99,9 @@ enum interesting {
 	all_entries_interesting = 2 /* yes, and all subsequent entries will be */
 };
 
-extern enum interesting tree_entry_interesting(const struct name_entry *,
-					       struct strbuf *, int,
-					       const struct pathspec *ps);
+enum interesting tree_entry_interesting(struct index_state *istate,
+					const struct name_entry *,
+					struct strbuf *, int,
+					const struct pathspec *ps);
 
 #endif
diff --git a/tree.c b/tree.c
index ecd8c8ac29..0b5c84d0d7 100644
--- a/tree.c
+++ b/tree.c
@@ -78,7 +78,8 @@ static int read_tree_1(struct repository *r,
 
 	while (tree_entry(&desc, &entry)) {
 		if (retval != all_entries_interesting) {
-			retval = tree_entry_interesting(&entry, base, 0, pathspec);
+			retval = tree_entry_interesting(r->index, &entry,
+							base, 0, pathspec);
 			if (retval == all_entries_not_interesting)
 				break;
 			if (retval == entry_not_interesting)
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..7f9548e741 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -794,6 +794,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    struct name_entry *names,
 				    struct traverse_info *info)
 {
+	struct unpack_trees_options *o = info->data;
 	int i, ret, bottom;
 	int nr_buf = 0;
 	struct tree_desc t[MAX_UNPACK_TREES];
@@ -804,7 +805,6 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 
 	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
 	if (nr_entries > 0) {
-		struct unpack_trees_options *o = info->data;
 		int pos = index_pos_by_traverse_info(names, info);
 
 		if (!o->merge || df_conflicts)
@@ -863,7 +863,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	}
 
 	bottom = switch_cache_bottom(&newinfo);
-	ret = traverse_trees(n, t, &newinfo);
+	ret = traverse_trees(o->src_index, n, t, &newinfo);
 	restore_cache_bottom(&newinfo, bottom);
 
 	for (i = 0; i < nr_buf; i++)
@@ -1550,7 +1550,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
-		ret = traverse_trees(len, t, &info);
+		ret = traverse_trees(o->src_index, len, t, &info);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
-- 
2.19.1.1327.g328c130451.dirty

