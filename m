Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0481F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJSW7b (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32827 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeJSW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so31111490ljz.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5swyvmleAEmD9tJk4RRn4C6cOnQmAFmEHsIEtdjbmiM=;
        b=NuQqo/aOcnNRLTEvrFytGTtGrP+A8Er5fZ7X1U2Zh5FKP4pbao+IotWDIYoDuCZlo/
         wdk1KsAnXL9108oDvuYoTiE/aYh4eHyW/DLmqzSpIgJUtqR9FY1vhQk070gin+4DJLEM
         3BVktibeKwuDVRhFt/KdPtlz6JT4g8dhnqUG9uY0S3+uL5hFNnGTwyCayYF5hGhg0A3N
         +yZKogNcDQrRRvIO1AWGCUFv347jVliU4Pogc7T9vRWnaC4sEVFvjHrbEIJ9IY55VWqg
         5G0INk+Aa/sFkLm/16p90+FSp9YjPM834TL0EzDzsq+lXkwNosbUcTI5stuzucguJeTA
         Jd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5swyvmleAEmD9tJk4RRn4C6cOnQmAFmEHsIEtdjbmiM=;
        b=iLWU35guPzoNlaHJ+sVbhWlDhS7NvekUnbNbLUPI0MLH6plLo2l7d/PYuSDmcx50pH
         Bdl7sTBuUqXz5TzJva8nFU5cFjVe2XKhO6RLmhc2TbXruwSJFpk59yyZrXDBIqJ8zkZR
         aIW1wBQKsnlnfoC3BgcgPSPSkB/X+nbySzBTwwlkv4ihAY7+Vs05k//eKSrtyAEVPDx+
         zaWgNeMerc+HestmBM03K9BQlkvLzgqprKtA2gANWzOerSHRP+iyaZ6sUiP24GA975We
         N4UH2xEjZE25iaxa6qQus/+cc6p71HVdkkhNoo5Hmjs/KEekurLx1UeH2X7KzPcwGwky
         XuCw==
X-Gm-Message-State: ABuFfoj7XNWOzK1svx0GJwPWQzgH4PpIRD7aMOzGP0RRDNrMytx/dyPu
        tzhBOjYnINfroJKeBGLHaqSJvfeX
X-Google-Smtp-Source: ACcGV61VI7Wh5+tJ2DgPpL+cDRC9vAxKn8LDylPj+ib2DD7NdmPFvmvACyXL0z1voug/iwLwt/VHAA==
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr24402466ljb.119.1539960779797;
        Fri, 19 Oct 2018 07:52:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/19] merge-recursive.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:33 +0200
Message-Id: <20181019145237.16079-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/am.c              |   2 +-
 builtin/checkout.c        |   2 +-
 builtin/merge-recursive.c |   2 +-
 builtin/merge.c           |   2 +-
 merge-recursive.c         | 151 +++++++++++++++++++++-----------------
 merge-recursive.h         |   6 +-
 sequencer.c               |   4 +-
 7 files changed, 94 insertions(+), 75 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d2af94500c..65e10a5eb3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1597,7 +1597,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	 * changes.
 	 */
 
-	init_merge_options(&o);
+	init_merge_options(&o, the_repository);
 
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38b28c20e2..8ecb4c43c7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -670,7 +670,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * a pain; plumb in an option to set
 			 * o.renormalize?
 			 */
-			init_merge_options(&o);
+			init_merge_options(&o, the_repository);
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 9b2f707c29..4864f7b22f 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -28,7 +28,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	struct merge_options o;
 	struct commit *result;
 
-	init_merge_options(&o);
+	init_merge_options(&o, the_repository);
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
diff --git a/builtin/merge.c b/builtin/merge.c
index db22119c93..d2d636d979 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -701,7 +701,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			return 2;
 		}
 
-		init_merge_options(&o);
+		init_merge_options(&o, the_repository);
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
diff --git a/merge-recursive.c b/merge-recursive.c
index b025c10e31..184945ae67 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -318,22 +318,24 @@ static int add_cacheinfo(struct merge_options *o,
 			 unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage, int refresh, int options)
 {
+	struct index_state *istate = o->repo->index;
 	struct cache_entry *ce;
 	int ret;
 
-	ce = make_cache_entry(&the_index, mode, oid ? oid : &null_oid, path, stage, 0);
+	ce = make_cache_entry(istate, mode, oid ? oid : &null_oid, path, stage, 0);
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
-	ret = add_cache_entry(ce, options);
+	ret = add_index_entry(istate, ce, options);
 	if (refresh) {
 		struct cache_entry *nce;
 
-		nce = refresh_cache_entry(&the_index, ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
+		nce = refresh_cache_entry(istate, ce,
+					  CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 		if (!nce)
 			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
 		if (nce != ce)
-			ret = add_cache_entry(nce, options);
+			ret = add_index_entry(istate, nce, options);
 	}
 	return ret;
 }
@@ -361,7 +363,7 @@ static int unpack_trees_start(struct merge_options *o,
 	o->unpack_opts.merge = 1;
 	o->unpack_opts.head_idx = 2;
 	o->unpack_opts.fn = threeway_merge;
-	o->unpack_opts.src_index = &the_index;
+	o->unpack_opts.src_index = o->repo->index;
 	o->unpack_opts.dst_index = &tmp_index;
 	o->unpack_opts.aggressive = !merge_detect_rename(o);
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
@@ -371,16 +373,16 @@ static int unpack_trees_start(struct merge_options *o,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &o->unpack_opts);
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&o->repo->index->cache_tree);
 
 	/*
-	 * Update the_index to match the new results, AFTER saving a copy
+	 * Update o->repo->index to match the new results, AFTER saving a copy
 	 * in o->orig_index.  Update src_index to point to the saved copy.
 	 * (verify_uptodate() checks src_index, and the original index is
 	 * the one that had the necessary modification timestamps.)
 	 */
-	o->orig_index = the_index;
-	the_index = tmp_index;
+	o->orig_index = *o->repo->index;
+	*o->repo->index = tmp_index;
 	o->unpack_opts.src_index = &o->orig_index;
 
 	return rc;
@@ -395,12 +397,13 @@ static void unpack_trees_finish(struct merge_options *o)
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
+	struct index_state *istate = o->repo->index;
 
-	if (unmerged_cache()) {
+	if (unmerged_index(istate)) {
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < istate->cache_nr; i++) {
+			const struct cache_entry *ce = istate->cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
@@ -408,16 +411,16 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		BUG("unmerged index entries in merge-recursive.c");
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0) {
+	if (!cache_tree_fully_valid(istate->cache_tree) &&
+	    cache_tree_update(istate, 0) < 0) {
 		err(o, _("error building trees"));
 		return NULL;
 	}
 
-	result = lookup_tree(the_repository, &active_cache_tree->oid);
+	result = lookup_tree(the_repository, &istate->cache_tree->oid);
 
 	return result;
 }
@@ -487,17 +490,17 @@ static struct stage_data *insert_stage_data(const char *path,
  * Create a dictionary mapping file names to stage_data objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
-static struct string_list *get_unmerged(void)
+static struct string_list *get_unmerged(struct index_state *istate)
 {
 	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
 	int i;
 
 	unmerged->strdup_strings = 1;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
 
@@ -657,7 +660,7 @@ static int update_stages(struct merge_options *opt, const char *path,
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(opt->repo->index, path))
 			return -1;
 	if (o)
 		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
@@ -713,13 +716,14 @@ static int remove_file(struct merge_options *o, int clean,
 	int update_working_directory = !o->call_depth && !no_wd;
 
 	if (update_cache) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(o->repo->index, path))
 			return -1;
 	}
 	if (update_working_directory) {
 		if (ignore_case) {
 			struct cache_entry *ce;
-			ce = cache_file_exists(path, strlen(path), ignore_case);
+			ce = index_file_exists(o->repo->index, path, strlen(path),
+					       ignore_case);
 			if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
 				return 0;
 		}
@@ -769,7 +773,8 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
  * check the working directory.  If empty_ok is non-zero, also return
  * 0 in the case where the working-tree dir exists but is empty.
  */
-static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
+static int dir_in_way(struct index_state *istate, const char *path,
+		      int check_working_copy, int empty_ok)
 {
 	int pos;
 	struct strbuf dirpath = STRBUF_INIT;
@@ -778,12 +783,12 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 	strbuf_addstr(&dirpath, path);
 	strbuf_addch(&dirpath, '/');
 
-	pos = cache_name_pos(dirpath.buf, dirpath.len);
+	pos = index_name_pos(istate, dirpath.buf, dirpath.len);
 
 	if (pos < 0)
 		pos = -1 - pos;
-	if (pos < active_nr &&
-	    !strncmp(dirpath.buf, active_cache[pos]->name, dirpath.len)) {
+	if (pos < istate->cache_nr &&
+	    !strncmp(dirpath.buf, istate->cache[pos]->name, dirpath.len)) {
 		strbuf_release(&dirpath);
 		return 1;
 	}
@@ -826,7 +831,7 @@ static int was_tracked(struct merge_options *o, const char *path)
 	return 0;
 }
 
-static int would_lose_untracked(const char *path)
+static int would_lose_untracked(struct index_state *istate, const char *path)
 {
 	/*
 	 * This may look like it can be simplified to:
@@ -845,19 +850,19 @@ static int would_lose_untracked(const char *path)
 	 * update_file()/would_lose_untracked(); see every comment in this
 	 * file which mentions "update_stages".
 	 */
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(istate, path, strlen(path));
 
 	if (pos < 0)
 		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
+	while (pos < istate->cache_nr &&
+	       !strcmp(path, istate->cache[pos]->name)) {
 		/*
 		 * If stage #0, it is definitely tracked.
 		 * If it has stage #2 then it was tracked
 		 * before this merge started.  All other
 		 * cases the path was not tracked.
 		 */
-		switch (ce_stage(active_cache[pos])) {
+		switch (ce_stage(istate->cache[pos])) {
 		case 0:
 		case 2:
 			return 0;
@@ -917,7 +922,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	 * Do not unlink a file in the work tree if we are not
 	 * tracking it.
 	 */
-	if (would_lose_untracked(path))
+	if (would_lose_untracked(o->repo->index, path))
 		return err(o, _("refusing to lose untracked file at '%s'"),
 			   path);
 
@@ -967,7 +972,7 @@ static int update_file_flags(struct merge_options *o,
 		}
 		if (S_ISREG(mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
-			if (convert_to_working_tree(&the_index, path, buf, size, &strbuf)) {
+			if (convert_to_working_tree(o->repo->index, path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
@@ -1085,7 +1090,7 @@ static int merge_3way(struct merge_options *o,
 
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
-				&the_index, &ll_opts);
+				o->repo->index, &ll_opts);
 
 	free(base_name);
 	free(name1);
@@ -1096,7 +1101,8 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
-static int find_first_merges(struct object_array *result, const char *path,
+static int find_first_merges(struct repository *repo,
+			     struct object_array *result, const char *path,
 			     struct commit *a, struct commit *b)
 {
 	int i, j;
@@ -1116,7 +1122,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 	/* get all revisions that merge commit a */
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(repo, &revs, NULL);
 	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
@@ -1246,7 +1252,8 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
+	parent_count = find_first_merges(o->repo, &merges, path,
+					 commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
 		output(o, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
@@ -1380,7 +1387,7 @@ static int handle_rename_via_dir(struct merge_options *o,
 	 */
 	const struct diff_filespec *dest = pair->two;
 
-	if (!o->call_depth && would_lose_untracked(dest->path)) {
+	if (!o->call_depth && would_lose_untracked(o->repo->index, dest->path)) {
 		char *alt_path = unique_path(o, dest->path, rename_branch);
 
 		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
@@ -1418,8 +1425,8 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(path, !o->call_depth, 0) ||
-	    (!o->call_depth && would_lose_untracked(path))) {
+	if (dir_in_way(o->repo->index, path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(o->repo->index, path))) {
 		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
@@ -1429,7 +1436,7 @@ static int handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		ret = remove_file_from_cache(path);
+		ret = remove_file_from_index(o->repo->index, path);
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
@@ -1505,7 +1512,7 @@ static int handle_rename_delete(struct merge_options *o,
 		return -1;
 
 	if (o->call_depth)
-		return remove_file_from_cache(dest->path);
+		return remove_file_from_index(o->repo->index, dest->path);
 	else
 		return update_stages(o, dest->path, NULL,
 				     rename_branch == o->branch1 ? dest : NULL,
@@ -1567,12 +1574,12 @@ static int handle_file(struct merge_options *o,
 		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
-		if (dir_in_way(rename->path, !o->call_depth, 0)) {
+		if (dir_in_way(o->repo->index, rename->path, !o->call_depth, 0)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
 		} else if (!o->call_depth &&
-			   would_lose_untracked(rename->path)) {
+			   would_lose_untracked(o->repo->index, rename->path)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("Refusing to lose untracked file at %s; "
 				       "adding as %s instead"),
@@ -1637,14 +1644,14 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 				return -1;
 		}
 		else
-			remove_file_from_cache(a->path);
+			remove_file_from_index(o->repo->index, a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
 			if (update_file(o, 0, &add->oid, add->mode, b->path))
 				return -1;
 		}
 		else
-			remove_file_from_cache(b->path);
+			remove_file_from_index(o->repo->index, b->path);
 	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
 		return -1;
 
@@ -1654,6 +1661,7 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 static int handle_rename_rename_2to1(struct merge_options *o,
 				     struct rename_conflict_info *ci)
 {
+	struct index_state *istate = o->repo->index;
 	/* Two files, a & b, were renamed to the same thing, c. */
 	struct diff_filespec *a = ci->pair1->one;
 	struct diff_filespec *b = ci->pair2->one;
@@ -1672,8 +1680,12 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
-	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
-	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
+	remove_file(o, 1, a->path,
+		    (o->call_depth ||
+		     would_lose_untracked(istate, a->path)));
+	remove_file(o, 1, b->path,
+		    (o->call_depth ||
+		     would_lose_untracked(istate, b->path)));
 
 	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
 	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
@@ -1706,7 +1718,7 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 		if (was_dirty(o, path))
 			output(o, 1, _("Refusing to lose dirty file at %s"),
 			       path);
-		else if (would_lose_untracked(path))
+		else if (would_lose_untracked(istate, path))
 			/*
 			 * Only way we get here is if both renames were from
 			 * a directory rename AND user had an untracked file
@@ -1757,7 +1769,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	repo_diff_setup(the_repository, &opts);
+	repo_diff_setup(o->repo, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
@@ -2936,8 +2948,8 @@ static int blob_unchanged(struct merge_options *opt,
 	 * performed.  Comparison can be skipped if both files are
 	 * unchanged since their sha1s have already been compared.
 	 */
-	if (renormalize_buffer(&the_index, path, o.buf, o.len, &o) |
-	    renormalize_buffer(&the_index, path, a.buf, a.len, &a))
+	if (renormalize_buffer(opt->repo->index, path, o.buf, o.len, &o) |
+	    renormalize_buffer(opt->repo->index, path, a.buf, a.len, &a))
 		ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
 
 error_return:
@@ -3018,7 +3030,7 @@ static int handle_content_merge(struct merge_options *o,
 		a.path = (char *)path1;
 		b.path = (char *)path2;
 
-		if (dir_in_way(path, !o->call_depth,
+		if (dir_in_way(o->repo->index, path, !o->call_depth,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
@@ -3051,8 +3063,8 @@ static int handle_content_merge(struct merge_options *o,
 		pos = index_name_pos(&o->orig_index, path, strlen(path));
 		ce = o->orig_index.cache[pos];
 		if (ce_skip_worktree(ce)) {
-			pos = index_name_pos(&the_index, path, strlen(path));
-			ce = the_index.cache[pos];
+			pos = index_name_pos(o->repo->index, path, strlen(path));
+			ce = o->repo->index->cache[pos];
 			ce->ce_flags |= CE_SKIP_WORKTREE;
 		}
 		return mfi.clean;
@@ -3071,7 +3083,7 @@ static int handle_content_merge(struct merge_options *o,
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
 		if (o->call_depth) {
-			remove_file_from_cache(path);
+			remove_file_from_index(o->repo->index, path);
 		} else {
 			if (!mfi.clean) {
 				if (update_stages(o, path, &one, &a, &b))
@@ -3217,7 +3229,7 @@ static int process_entry(struct merge_options *o,
 			oid = b_oid;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path,
+		if (dir_in_way(o->repo->index, path,
 			       !o->call_depth && !S_ISGITLINK(a_mode),
 			       0)) {
 			char *new_path = unique_path(o, path, add_branch);
@@ -3228,7 +3240,7 @@ static int process_entry(struct merge_options *o,
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge = -1;
 			else if (o->call_depth)
-				remove_file_from_cache(path);
+				remove_file_from_index(o->repo->index, path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
@@ -3263,10 +3275,11 @@ int merge_trees(struct merge_options *o,
 		struct tree *common,
 		struct tree **result)
 {
+	struct index_state *istate = o->repo->index;
 	int code, clean;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
+	if (!o->call_depth && index_has_changes(istate, head, &sb)) {
 		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
 		return -1;
@@ -3294,7 +3307,7 @@ int merge_trees(struct merge_options *o,
 		return -1;
 	}
 
-	if (unmerged_cache()) {
+	if (unmerged_index(istate)) {
 		struct string_list *entries;
 		struct rename_info re_info;
 		int i;
@@ -3309,7 +3322,7 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, head);
 		get_files_dirs(o, merge);
 
-		entries = get_unmerged();
+		entries = get_unmerged(o->repo->index);
 		clean = detect_and_process_renames(o, common, head, merge,
 						   entries, &re_info);
 		record_df_conflict_files(o, entries);
@@ -3425,7 +3438,7 @@ int merge_recursive(struct merge_options *o,
 		 * overwritten it: the committed "conflicts" were
 		 * already resolved.
 		 */
-		discard_cache();
+		discard_index(o->repo->index);
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
@@ -3441,9 +3454,9 @@ int merge_recursive(struct merge_options *o,
 			return err(o, _("merge returned no commit"));
 	}
 
-	discard_cache();
+	discard_index(o->repo->index);
 	if (!o->call_depth)
-		repo_read_index(the_repository);
+		repo_read_index(o->repo);
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
@@ -3510,7 +3523,7 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(o->repo, &lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 				result);
 	if (clean < 0) {
@@ -3518,7 +3531,7 @@ int merge_recursive_generic(struct merge_options *o,
 		return clean;
 	}
 
-	if (write_locked_index(&the_index, &lock,
+	if (write_locked_index(o->repo->index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		return err(o, _("Unable to write index."));
 
@@ -3542,10 +3555,12 @@ static void merge_recursive_config(struct merge_options *o)
 	git_config(git_xmerge_config, NULL);
 }
 
-void init_merge_options(struct merge_options *o)
+void init_merge_options(struct merge_options *o,
+			struct repository *repo)
 {
 	const char *merge_verbosity;
 	memset(o, 0, sizeof(struct merge_options));
+	o->repo = repo;
 	o->verbosity = 2;
 	o->buffer_output = 1;
 	o->diff_rename_limit = -1;
diff --git a/merge-recursive.h b/merge-recursive.h
index e6a0828eca..c2b7bb65c6 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -6,6 +6,8 @@
 
 struct commit;
 
+struct repository;
+
 struct merge_options {
 	const char *ancestor;
 	const char *branch1;
@@ -34,6 +36,7 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 	struct unpack_trees_options unpack_opts;
 	struct index_state orig_index;
+	struct repository *repo;
 };
 
 /*
@@ -92,7 +95,8 @@ int merge_recursive_generic(struct merge_options *o,
 			    const struct object_id **ca,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *o);
+void init_merge_options(struct merge_options *o,
+			struct repository *repo);
 struct tree *write_tree_from_memory(struct merge_options *o);
 
 int parse_merge_opt(struct merge_options *out, const char *s);
diff --git a/sequencer.c b/sequencer.c
index 3620a42649..c5073e0b92 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -540,7 +540,7 @@ static int do_recursive_merge(struct repository *r,
 
 	repo_read_index(r);
 
-	init_merge_options(&o);
+	init_merge_options(&o, r);
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
@@ -3185,7 +3185,7 @@ static int do_merge(struct repository *r,
 	free_commit_list(bases);
 
 	repo_read_index(r);
-	init_merge_options(&o);
+	init_merge_options(&o, r);
 	o.branch1 = "HEAD";
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
-- 
2.19.1.647.g708186aaf9

