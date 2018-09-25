Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEEB1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeIZEo0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33464 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIZEoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so212149edp.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dLElR6Ymwmwm+X7oXByW55rqJwGgRvmLKqrsIaQLzps=;
        b=haioTSnjPcxo7PsE+EVGt/8GIEI0qhziefrG0Grbf3+wtQGDiyyA0ercUZgmMio9T5
         3Bqt3iI4iW3wzwDiIuJRxvW3BmCO0ehdatKN2cvHiZGtLeXZIMgXZRd5DHivl3QoD3Gy
         PfKS1Lug3clQ7txYx+V0JyB33UlfuVC0nWkX2pmJCH2M6NIjXrQD81wRHrLUVv+KYpLG
         iokZPsiITFIE2dMH4qWhz+Sd5fNYdpyPuw6ofeoC2wWfXfNBUgOD1sxvnTlO1kqc+Fu/
         aCTHVmwMY0OHYmkqjOaBumFxGexN/pLU3j3oXD1sc38ZLNLVJuGFh27oG831kRi8HuBj
         vwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLElR6Ymwmwm+X7oXByW55rqJwGgRvmLKqrsIaQLzps=;
        b=d8cgwEDaEzEm+00usbATYomawq9kNwj/xCVowZHl0MkNNFZM+trbayCcK9lbrhJb7R
         toO7M9qyhlURfhu5WCPbI2U54Tnx16GQSu//0cU2j916f9gagTE2aWEirodPRY3NQsd7
         R2laSpMcJIGBFEbDJAdRYG28W7QIcpnPmwyVtcgNR4EuePQwKgxPq7hV+DdSO25JIC++
         kVio4tAJVd3HG1Vr1XBeMtuNoUSEu4ZxeqqMYe4DX5tGJjH82YlLHW9qi3L6E7kz7BF1
         XvNK849C/+OJtqWqW9XDzRpRxP2RvnvypdDr208tojed4NijG5itIBBERWCahWrqr1Gg
         IRZQ==
X-Gm-Message-State: ABuFfogPO0358SZN2+1p8dsk4ZDCanOAuTuo2YvHNEekJhqlC1/AKCKU
        IkryBOPbZLSIJvRzA+VnLZqywVCl
X-Google-Smtp-Source: ACcGV61Af/9JRiMAMt6+H7hHtdi9WJHpqZdc5KAG+8H9WIF9KDsfSDyI4To6XqOnIlJAIrEbgU/U1Q==
X-Received: by 2002:a50:bb69:: with SMTP id y96-v6mr5007368ede.10.1537914878337;
        Tue, 25 Sep 2018 15:34:38 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:37 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 15/21] stash: convert create to builtin
Date:   Wed, 26 Sep 2018 01:33:31 +0300
Message-Id: <2aa411b3c677f4a4cf0cba0850a96c1bd0ac2d40.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash create to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 450 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   2 +-
 2 files changed, 451 insertions(+), 1 deletion(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index b7421b68aa..49b05f2458 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,9 @@
 #include "rerere.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "diffcore.h"
+
+#define INCLUDE_ALL_FILES 2
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
@@ -63,6 +66,11 @@ static const char * const git_stash_helper_store_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_create_usage[] = {
+	N_("git stash--helper create [<message>]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -289,6 +297,24 @@ static int reset_head(void)
 	return run_command(&cp);
 }
 
+static void add_diff_to_buf(struct diff_queue_struct *q,
+			    struct diff_options *options,
+			    void *data)
+{
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		strbuf_addstr(data, q->queue[i]->one->path);
+
+		/*
+		 * The reason we add "0" at the end of this strbuf
+		 * is because we will pass the output further to
+		 * "git update-index -z ...".
+		 */
+		strbuf_addch(data, 0);
+	}
+}
+
 static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -786,6 +812,428 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	return do_store_stash(&obj, stash_msg, quiet);
 }
 
+static void add_pathspecs(struct argv_array *args,
+				       struct pathspec ps) {
+	int i;
+
+	for (i = 0; i < ps.nr; i++)
+		argv_array_push(args, ps.items[i].match);
+}
+
+/*
+ * `untracked_files` will be filled with the names of untracked files.
+ * The return value is:
+ *
+ * = 0 if there are not any untracked files
+ * > 0 if there are untracked files
+ */
+static int get_untracked_files(struct pathspec ps, int include_untracked,
+			       struct strbuf *untracked_files)
+{
+	int i;
+	int max_len;
+	int found = 0;
+	char *seen;
+	struct dir_struct dir;
+
+	memset(&dir, 0, sizeof(dir));
+	if (include_untracked != INCLUDE_ALL_FILES)
+		setup_standard_excludes(&dir);
+
+	seen = xcalloc(ps.nr, 1);
+
+	max_len = fill_directory(&dir, the_repository->index, &ps);
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		if (dir_path_match(&the_index, ent, &ps, max_len, seen)) {
+			found++;
+			strbuf_addstr(untracked_files, ent->name);
+			/* NUL-terminate: will be fed to update-index -z */
+			strbuf_addch(untracked_files, 0);
+		}
+		free(ent);
+	}
+
+	free(seen);
+	free(dir.entries);
+	free(dir.ignored);
+	clear_directory(&dir);
+	return found;
+}
+
+/*
+ * The return value of `check_changes()` can be:
+ *
+ * < 0 if there was an error
+ * = 0 if there are no changes.
+ * > 0 if there are changes.
+ */
+static int check_changes(struct pathspec ps, int include_untracked)
+{
+	int result;
+	int ret = 0;
+	struct rev_info rev;
+	struct object_id dummy;
+	struct strbuf out = STRBUF_INIT;
+
+	/* No initial commit. */
+	if (get_oid("HEAD", &dummy))
+		return -1;
+
+	if (read_cache() < 0)
+		return -1;
+
+	init_revisions(&rev, NULL);
+	rev.prune_data = ps;
+
+	rev.diffopt.flags.quick = 1;
+	rev.diffopt.flags.ignore_submodules = 1;
+	rev.abbrev = 0;
+
+	add_head_to_pending(&rev);
+	diff_setup_done(&rev.diffopt);
+
+	result = run_diff_index(&rev, 1);
+	if (diff_result_code(&rev.diffopt, result))
+		return 1;
+
+	object_array_clear(&rev.pending);
+	result = run_diff_files(&rev, 0);
+	if (diff_result_code(&rev.diffopt, result))
+		return 1;
+
+	if (include_untracked && get_untracked_files(ps, include_untracked,
+						     &out)) {
+		strbuf_release(&out);
+		return 1;
+	}
+
+	strbuf_release(&out);
+	return 0;
+}
+
+static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
+				struct strbuf files)
+{
+	int ret = 0;
+	struct strbuf untracked_msg = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+
+	cp_upd_index.git_cmd = 1;
+	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
+			 "--remove", "--stdin", NULL);
+	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
+	if (pipe_command(&cp_upd_index, files.buf, files.len, NULL, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_write_tree.git_cmd = 1;
+	argv_array_push(&cp_write_tree.args, "write-tree");
+	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+	get_oid_hex(out.buf, &info->u_tree);
+
+	if (commit_tree(untracked_msg.buf, untracked_msg.len,
+			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
+		ret = -1;
+		goto done;
+	}
+
+done:
+	strbuf_release(&untracked_msg);
+	strbuf_release(&out);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int stash_patch(struct stash_info *info, struct pathspec ps,
+		       struct strbuf *out_patch)
+{
+	int ret = 0;
+	struct strbuf out = STRBUF_INIT;
+	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
+	struct child_process cp_add_i = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
+
+	remove_path(stash_index_path.buf);
+
+	cp_read_tree.git_cmd = 1;
+	argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
+	argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp_read_tree)) {
+		ret = -1;
+		goto done;
+	}
+
+	/* Find out what the user wants. */
+	cp_add_i.git_cmd = 1;
+	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
+			 "--", NULL);
+	add_pathspecs(&cp_add_i.args, ps);
+	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp_add_i)) {
+		ret = -1;
+		goto done;
+	}
+
+	/* State of the working tree. */
+	cp_write_tree.git_cmd = 1;
+	argv_array_push(&cp_write_tree.args, "write-tree");
+	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	get_oid_hex(out.buf, &info->w_tree);
+
+	cp_diff_tree.git_cmd = 1;
+	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
+			 oid_to_hex(&info->w_tree), "--", NULL);
+	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (!out_patch->len) {
+		fprintf_ln(stderr, _("No changes selected"));
+		ret = 1;
+	}
+
+done:
+	strbuf_release(&out);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int stash_working_tree(struct stash_info *info, struct pathspec ps)
+{
+	int ret = 0;
+	struct rev_info rev;
+	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf diff_output = STRBUF_INIT;
+
+	set_alternate_index_output(stash_index_path.buf);
+	if (reset_tree(&info->i_tree, 0, 0)) {
+		ret = -1;
+		goto done;
+	}
+	set_alternate_index_output(NULL);
+
+	git_config(git_diff_basic_config, NULL);
+	init_revisions(&rev, NULL);
+	rev.prune_data = ps;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = add_diff_to_buf;
+	rev.diffopt.format_callback_data = &diff_output;
+
+	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+		ret = -1;
+		goto done;
+	}
+
+	add_pending_object(&rev, parse_object(the_repository, &info->b_commit), "");
+	if (run_diff_index(&rev, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_upd_index.git_cmd = 1;
+	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
+			 "--remove", "--stdin", NULL);
+	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
+			 NULL, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp_write_tree.git_cmd = 1;
+	argv_array_push(&cp_write_tree.args, "write-tree");
+	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	get_oid_hex(out.buf, &info->w_tree);
+
+done:
+	UNLEAK(rev);
+	strbuf_release(&out);
+	object_array_clear(&rev.pending);
+	strbuf_release(&diff_output);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int do_create_stash(struct pathspec ps, char **stash_msg,
+			   int include_untracked, int patch_mode,
+			   struct stash_info *info)
+{
+	int ret = 0;
+	int flags = 0;
+	int untracked_commit_option = 0;
+	const char *head_short_sha1 = NULL;
+	const char *branch_ref = NULL;
+	const char *branch_name = "(no branch)";
+	struct commit *head_commit = NULL;
+	struct commit_list *parents = NULL;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf commit_tree_label = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct strbuf patch = STRBUF_INIT;
+
+	read_cache_preload(NULL);
+	refresh_cache(REFRESH_QUIET);
+
+	if (get_oid("HEAD", &info->b_commit)) {
+		fprintf_ln(stderr, _("You do not have the initial commit yet"));
+		ret = -1;
+		*stash_msg = NULL;
+		goto done;
+	} else {
+		head_commit = lookup_commit(the_repository, &info->b_commit);
+	}
+
+	if (!check_changes(ps, include_untracked)) {
+		ret = 1;
+		*stash_msg = NULL;
+		goto done;
+	}
+
+	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
+	if (flags & REF_ISSYMREF)
+		branch_name = strrchr(branch_ref, '/') + 1;
+	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
+					     DEFAULT_ABBREV);
+	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
+	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
+
+	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
+	commit_list_insert(head_commit, &parents);
+	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
+	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
+			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
+		fprintf_ln(stderr, _("Cannot save the current index state"));
+		ret = -1;
+		*stash_msg = NULL;
+		goto done;
+	}
+
+	if (include_untracked && get_untracked_files(ps, include_untracked,
+						     &untracked_files)) {
+		if (save_untracked_files(info, &msg, untracked_files)) {
+			fprintf_ln(stderr, _("Cannot save the untracked files"));
+			ret = -1;
+			*stash_msg = NULL;
+			goto done;
+		}
+		untracked_commit_option = 1;
+	}
+	if (patch_mode) {
+		ret = stash_patch(info, ps, &patch);
+		*stash_msg = NULL;
+		if (ret < 0) {
+			fprintf_ln(stderr, _("Cannot save the current worktree state"));
+			goto done;
+		} else if (ret > 0) {
+			goto done;
+		}
+	} else {
+		if (stash_working_tree(info, ps)) {
+			fprintf_ln(stderr, _("Cannot save the current worktree state"));
+			ret = -1;
+			*stash_msg = NULL;
+			goto done;
+		}
+	}
+
+	if (!*stash_msg || !strlen(*stash_msg))
+		strbuf_addf(&stash_msg_buf, "WIP on %s", msg.buf);
+	else
+		strbuf_addf(&stash_msg_buf, "On %s: %s", branch_name,
+			    *stash_msg);
+	*stash_msg = strbuf_detach(&stash_msg_buf, NULL);
+
+	/*
+	 * `parents` will be empty after calling `commit_tree()`, so there is
+	 * no need to call `free_commit_list()`
+	 */
+	parents = NULL;
+	if (untracked_commit_option)
+		commit_list_insert(lookup_commit(the_repository, &info->u_commit), &parents);
+	commit_list_insert(lookup_commit(the_repository, &info->i_commit), &parents);
+	commit_list_insert(head_commit, &parents);
+
+	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
+			parents, &info->w_commit, NULL, NULL)) {
+		fprintf_ln(stderr, _("Cannot record working tree state"));
+		ret = -1;
+		goto done;
+	}
+
+done:
+	strbuf_release(&commit_tree_label);
+	strbuf_release(&msg);
+	strbuf_release(&untracked_files);
+	strbuf_release(&stash_msg_buf);
+	return ret;
+}
+
+static int create_stash(int argc, const char **argv, const char *prefix)
+{
+	int include_untracked = 0;
+	int ret = 0;
+	char *stash_msg = NULL;
+	struct stash_info info;
+	struct pathspec ps;
+	struct option options[] = {
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_STRING('m', "message", &stash_msg, N_("message"),
+			 N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_create_usage,
+			     0);
+
+	memset(&ps, 0, sizeof(ps));
+	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info);
+
+	if (!ret)
+		printf_ln("%s", oid_to_hex(&info.w_commit));
+
+	/*
+	 * ret can be 1 if there were no changes. In this case, we should
+	 * not error out.
+	 */
+	free((char *) stash_msg);
+	return ret < 0;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -822,6 +1270,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!show_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "store"))
 		return !!store_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "create"))
+		return !!create_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 5739c51527..ab06e4ffb8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -425,7 +425,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash -m "$*" && echo "$w_commit"
+	git stash--helper create --message "$*"
 	;;
 store)
 	shift
-- 
2.19.0.rc0.23.g1fb9f40d88

