Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF30D1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeKJPam (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:30:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43954 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPam (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:30:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so2815278lff.10
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMS9j06YdD85fbjplFFHEePeqtWkhVO8ReNL27iZ+qo=;
        b=AC+MiRYvCu1qjHfLKIl1eU0kWjDlQVE1BOzzFLx/SWJd2x9ul3zUgNxIxrepgyPifX
         ENoP4BLz/On8FxUJbJBSpyZSif9Jc53nbMi/4vvwIG8rCiQ+oWdA+ZKnS5kA3C5rRDE5
         60o4W2jhqn849E4hS+nT0q83tULeu2r5J7eMaEY+LOx5PCVkoggMslBTq0/Rl8t+ZPId
         OVRAO9G1J92YQi88MHpeE3qCmZ+Ll7a5yiMTf0sdyFSdtDrHbHQ1pDteJJsgF21DHqeN
         BnyxSQrf/ccORiz2cXGjanxGjW5yygOBXXjF2Mg0MyOvVY960xV8y76UZmeQWYi2HxXQ
         fWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMS9j06YdD85fbjplFFHEePeqtWkhVO8ReNL27iZ+qo=;
        b=r7Oa5vwNFKk6K4D2S+5/OnwqSrvTyVJM5HKfIos7aXUeZIRTLs3Ry5+QIb0N78AHDF
         erlwgKUhot5ZNO/3XRrv0rvZG+XGJcNkEIni949AhEOrm4yBHT5RdYDQRw3tijs1ymR5
         7bF+NYbLj730WeBxTnXMIKYeWK6O3gBJzrXz3lvrbHRfYBcGTz1fs9Hgcqkq+YPeubmA
         ewPU/Q4L2y+YhqN5WKJikzQX6nJC7ynWaPo2O7tr1/HQm1vajIYgavpXZwHtyRG4/WLY
         6jvlmceYgxsPaQyZP6w9MtPo0O91q7yr9eM15dsq3JKee/4CBkt/+Ks6xvq6MWvnZbe9
         t3Mw==
X-Gm-Message-State: AGRZ1gKLlY9T4650QFLgUD7KHpgmVxbw3rUCWz349tNmlQTqbc3OffBW
        M6AxS8ZqjyOcVe2tkuklJoUPj+f9
X-Google-Smtp-Source: AJdET5fRNOAja0Tgo5Sx9RN8QFnbLLNP38O/hr/n57O4zt7f4YLH6Fydbh+dky4hhPRV/AybXcesuA==
X-Received: by 2002:a19:aace:: with SMTP id t197mr6912603lfe.7.1541828814344;
        Fri, 09 Nov 2018 21:46:54 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2441597ljg.9.2018.11.09.21.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:46:53 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/22] wt-status.c: remove implicit dependency on the_index
Date:   Sat, 10 Nov 2018 06:46:25 +0100
Message-Id: <20181110054646.10149-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054646.10149-1-pclouds@gmail.com>
References: <20181110054646.10149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c |  2 +-
 builtin/pull.c   |  3 +-
 builtin/rebase.c |  7 +++--
 sequencer.c      |  8 ++---
 wt-status.c      | 76 +++++++++++++++++++++++++++---------------------
 wt-status.h      | 17 +++++++----
 6 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 074bd9a551..6637a928a7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -185,7 +185,7 @@ static void determine_whence(struct wt_status *s)
 
 static void status_init_config(struct wt_status *s, config_fn_t fn)
 {
-	wt_status_prepare(s);
+	wt_status_prepare(the_repository, s);
 	init_diff_ui_defaults();
 	git_config(fn, s);
 	determine_whence(s);
diff --git a/builtin/pull.c b/builtin/pull.c
index c21aa276f1..6026ce1a69 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -888,7 +888,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			require_clean_work_tree(N_("pull with rebase"),
+			require_clean_work_tree(the_repository,
+				N_("pull with rebase"),
 				_("please commit or stash them."), 1, 0);
 
 		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..b9eb958454 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -983,7 +983,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					     &lock_file);
 		rollback_lock_file(&lock_file);
 
-		if (has_unstaged_changes(1)) {
+		if (has_unstaged_changes(the_repository, 1)) {
 			puts(_("You must edit all merge conflicts and then\n"
 			       "mark them as resolved using git add"));
 			exit(1);
@@ -1351,7 +1351,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			update_index_if_able(&the_index, &lock_file);
 		rollback_lock_file(&lock_file);
 
-		if (has_unstaged_changes(1) || has_uncommitted_changes(1)) {
+		if (has_unstaged_changes(the_repository, 1) ||
+		    has_uncommitted_changes(the_repository, 1)) {
 			const char *autostash =
 				state_dir_path("autostash", &options);
 			struct child_process stash = CHILD_PROCESS_INIT;
@@ -1397,7 +1398,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (require_clean_work_tree("rebase",
+	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
 		ret = 1;
 		goto cleanup;
diff --git a/sequencer.c b/sequencer.c
index 9e1ab3a2a7..0b8f18fd36 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2773,7 +2773,7 @@ static int do_exec(const char *command_line)
 	if (discard_cache() < 0 || read_cache() < 0)
 		return error(_("could not read index"));
 
-	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
+	dirty = require_clean_work_tree(the_repository, "rebase", NULL, 1, 1);
 
 	if (status) {
 		warning(_("execution failed: %s\n%s"
@@ -3714,10 +3714,10 @@ static int commit_staged_changes(struct replay_opts *opts,
 	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 	unsigned int final_fixup = 0, is_clean;
 
-	if (has_unstaged_changes(1))
+	if (has_unstaged_changes(the_repository, 1))
 		return error(_("cannot rebase: You have unstaged changes."));
 
-	is_clean = !has_uncommitted_changes(0);
+	is_clean = !has_uncommitted_changes(the_repository, 0);
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
@@ -4847,7 +4847,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 ;
-	if (require_clean_work_tree("rebase", "", 1, 1))
+	if (require_clean_work_tree(the_repository, "rebase", "", 1, 1))
 		return -1;
 
 	return sequencer_continue(opts);
diff --git a/wt-status.c b/wt-status.c
index 187568a112..6d401b2c24 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -119,9 +119,10 @@ static void status_printf_more(struct wt_status *s, const char *color,
 	va_end(ap);
 }
 
-void wt_status_prepare(struct wt_status *s)
+void wt_status_prepare(struct repository *r, struct wt_status *s)
 {
 	memset(s, 0, sizeof(*s));
+	s->repo = r;
 	memcpy(s->color_palette, default_wt_status_colors,
 	       sizeof(default_wt_status_colors));
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
@@ -494,19 +495,19 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 	}
 }
 
-static int unmerged_mask(const char *path)
+static int unmerged_mask(struct index_state *istate, const char *path)
 {
 	int pos, mask;
 	const struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(istate, path, strlen(path));
 	if (0 <= pos)
 		return 0;
 
 	mask = 0;
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < istate->cache_nr) {
+		ce = istate->cache[pos++];
 		if (strcmp(ce->name, path) || !ce_stage(ce))
 			break;
 		mask |= (1 << (ce_stage(ce) - 1));
@@ -566,7 +567,8 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			s->committable = 1;
 			break;
 		case DIFF_STATUS_UNMERGED:
-			d->stagemask = unmerged_mask(p->two->path);
+			d->stagemask = unmerged_mask(s->repo->index,
+						     p->two->path);
 			/*
 			 * Don't bother setting {mode,oid}_{head,index} since the print
 			 * code will output the stage values directly and not use the
@@ -585,7 +587,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
 
-	repo_init_revisions(the_repository, &rev, NULL);
+	repo_init_revisions(s->repo, &rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.flags.dirty_submodules = 1;
@@ -610,7 +612,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	repo_init_revisions(the_repository, &rev, NULL);
+	repo_init_revisions(s->repo, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
@@ -643,14 +645,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
+	struct index_state *istate = s->repo->index;
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = istate->cache[i];
 
-		if (!ce_path_match(&the_index, ce, &s->pathspec, NULL))
+		if (!ce_path_match(istate, ce, &s->pathspec, NULL))
 			continue;
 		if (ce_intent_to_add(ce))
 			continue;
@@ -684,6 +687,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	int i;
 	struct dir_struct dir;
 	uint64_t t_begin = getnanotime();
+	struct index_state *istate = s->repo->index;
 
 	if (!s->show_untracked_files)
 		return;
@@ -698,25 +702,25 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		if (s->show_ignored_mode == SHOW_MATCHING_IGNORED)
 			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
 	} else {
-		dir.untracked = the_index.untracked;
+		dir.untracked = istate->untracked;
 	}
 
 	setup_standard_excludes(&dir);
 
-	fill_directory(&dir, &the_index, &s->pathspec);
+	fill_directory(&dir, istate, &s->pathspec);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
-		    dir_path_match(&the_index, ent, &s->pathspec, 0, NULL))
+		if (index_name_is_other(istate, ent->name, ent->len) &&
+		    dir_path_match(istate, ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
-		    dir_path_match(&the_index, ent, &s->pathspec, 0, NULL))
+		if (index_name_is_other(istate, ent->name, ent->len) &&
+		    dir_path_match(istate, ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
 	}
@@ -1009,7 +1013,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	int dirty_submodules;
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	repo_init_revisions(the_repository, &rev, NULL);
+	repo_init_revisions(s->repo, &rev, NULL);
 	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
@@ -1326,7 +1330,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
 	} else if (s->state.rebase_in_progress ||
-		   !stat(git_path_merge_msg(the_repository), &st)) {
+		   !stat(git_path_merge_msg(s->repo), &st)) {
 		print_rebase_state(s, color);
 		if (s->hints)
 			status_printf_ln(s, color,
@@ -2135,6 +2139,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
+	struct index_state *istate = s->repo->index;
 	const struct cache_entry *ce;
 	struct strbuf buf_index = STRBUF_INIT;
 	const char *path_index = NULL;
@@ -2173,11 +2178,11 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	 */
 	memset(stages, 0, sizeof(stages));
 	sum = 0;
-	pos = cache_name_pos(it->string, strlen(it->string));
+	pos = index_name_pos(istate, it->string, strlen(it->string));
 	assert(pos < 0);
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < istate->cache_nr) {
+		ce = istate->cache[pos++];
 		stage = ce_stage(ce);
 		if (strcmp(ce->name, it->string) || !stage)
 			break;
@@ -2302,12 +2307,12 @@ void wt_status_print(struct wt_status *s)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-int has_unstaged_changes(int ignore_submodules)
+int has_unstaged_changes(struct repository *r, int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
 
-	repo_init_revisions(the_repository, &rev_info, NULL);
+	repo_init_revisions(r, &rev_info, NULL);
 	if (ignore_submodules) {
 		rev_info.diffopt.flags.ignore_submodules = 1;
 		rev_info.diffopt.flags.override_submodule_config = 1;
@@ -2321,15 +2326,16 @@ int has_unstaged_changes(int ignore_submodules)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-int has_uncommitted_changes(int ignore_submodules)
+int has_uncommitted_changes(struct repository *r,
+			    int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
 
-	if (is_cache_unborn())
+	if (is_index_unborn(r->index))
 		return 0;
 
-	repo_init_revisions(the_repository, &rev_info, NULL);
+	repo_init_revisions(r, &rev_info, NULL);
 	if (ignore_submodules)
 		rev_info.diffopt.flags.ignore_submodules = 1;
 	rev_info.diffopt.flags.quick = 1;
@@ -2340,7 +2346,7 @@ int has_uncommitted_changes(int ignore_submodules)
 		 * We have no head (or it's corrupt); use the empty tree,
 		 * which will complain if the index is non-empty.
 		 */
-		struct tree *tree = lookup_tree(the_repository, the_hash_algo->empty_tree);
+		struct tree *tree = lookup_tree(r, the_hash_algo->empty_tree);
 		add_pending_object(&rev_info, &tree->object, "");
 	}
 
@@ -2353,24 +2359,28 @@ int has_uncommitted_changes(int ignore_submodules)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
+int require_clean_work_tree(struct repository *r,
+			    const char *action,
+			    const char *hint,
+			    int ignore_submodules,
+			    int gently)
 {
 	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
 
 	fd = hold_locked_index(&lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
-		update_index_if_able(&the_index, &lock_file);
+		update_index_if_able(r->index, &lock_file);
 	rollback_lock_file(&lock_file);
 
-	if (has_unstaged_changes(ignore_submodules)) {
+	if (has_unstaged_changes(r, ignore_submodules)) {
 		/* TRANSLATORS: the action is e.g. "pull with rebase" */
 		error(_("cannot %s: You have unstaged changes."), _(action));
 		err = 1;
 	}
 
-	if (has_uncommitted_changes(ignore_submodules)) {
+	if (has_uncommitted_changes(r, ignore_submodules)) {
 		if (err)
 			error(_("additionally, your index contains uncommitted changes."));
 		else
diff --git a/wt-status.h b/wt-status.h
index 1fcf93afbf..8375e816fb 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -7,6 +7,7 @@
 #include "pathspec.h"
 #include "remote.h"
 
+struct repository;
 struct worktree;
 
 enum color_wt_status {
@@ -83,6 +84,7 @@ struct wt_status_state {
 };
 
 struct wt_status {
+	struct repository *repo;
 	int is_initial;
 	char *branch;
 	const char *reference;
@@ -128,7 +130,7 @@ struct wt_status {
 
 size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
-void wt_status_prepare(struct wt_status *s);
+void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_collect_free_buffers(struct wt_status *s);
@@ -144,9 +146,14 @@ __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
 /* The following functions expect that the caller took care of reading the index. */
-int has_unstaged_changes(int ignore_submodules);
-int has_uncommitted_changes(int ignore_submodules);
-int require_clean_work_tree(const char *action, const char *hint,
-	int ignore_submodules, int gently);
+int has_unstaged_changes(struct repository *repo,
+			 int ignore_submodules);
+int has_uncommitted_changes(struct repository *repo,
+			    int ignore_submodules);
+int require_clean_work_tree(struct repository *repo,
+			    const char *action,
+			    const char *hint,
+			    int ignore_submodules,
+			    int gently);
 
 #endif /* STATUS_H */
-- 
2.19.1.1231.g84aef82467

