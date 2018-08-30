Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712931F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeHaBqE (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44487 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHaBqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so9357795wro.11
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mtq9wIg651vv7GvCXPasdShh7vG7pk0lWSJV2qS0sRA=;
        b=i/cwJuknninUW+wBnS3v9TGZHj8zVAkPuZ+b76FXPAs3rvBQ7N4at272BGwbBMJOkd
         Na+jkTRseIx8swehmNDmN5/PWe79SOfaEKXYeGC38FciEKQUtgLONr8OODqHuashOfPC
         pMg8yW1Ok9vYuhB8YfOm/xBg+N/Q7PUIFzDDZhOxpkb5MOzzJtgeSgnmZCXe8UmHrzfE
         859wN3zxHJVqFLWhzH/Zmx3qbnFKMqmNvId1R0DIBYSIUP7Xx4piHUWpfKFQLUrKbJ0M
         1QGHC+vBiRhbbH572/9n4mharkr6+j4z/O7ai6tIAytS9KvAvfl47xN4iL4f+XmSXgOU
         aOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mtq9wIg651vv7GvCXPasdShh7vG7pk0lWSJV2qS0sRA=;
        b=Nn0G94oA7L/ARxbfv9wj0z5eiawQNwU5e7LT2SrU0K4A/uFu3w8FBuHlq5yILi8rl1
         WHHQLr+DXflLobAVouu6Blx2I8TZM1QMeJNZ7ATfB/HOW4hv6rFxGqjSRelxaeXMgBXR
         xJqO/SPRpFY1uGrtB5FlYd3Uox2K3AIADFTt135DSrcqoovXarUALcXvr4PBA2p4qe6r
         F/YHyPPSnq7zDAsbAquy9SDVczvD9UOAF1BV9EDNk9cgLwSxUoXzcc8N2gvN31iYVku8
         MS/CjRVFnkQAIVfgnlDHFfe2Aa263B4lK2s5FMugoUeplOSjznzbielH3MRUI+OagWVV
         Xb1w==
X-Gm-Message-State: APzg51AY+1YkjSsbp2D/MdpJ+mG6ly64KiCWLFhgzZbmBVwRIhjCqH/o
        9EHpWC5d+y4dP3BEMUX3l0LTQRhL
X-Google-Smtp-Source: ANB0VdaBRsvALDuMdch7QQp4s4mMxCWd4FSQ2ZWUtg+vsmQr5y4v3AeHSn17J3CXUolxWA/NWtTh9w==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr8881467wrj.3.1535665310918;
        Thu, 30 Aug 2018 14:41:50 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:50 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 14/20] stash: convert create to builtin
Date:   Fri, 31 Aug 2018 00:40:44 +0300
Message-Id: <a4faed3c8aa5ea8f0d4c578b693f3b5de3e3a709.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash create to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 430 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   2 +-
 2 files changed, 431 insertions(+), 1 deletion(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 87568b0f34..ce360a569d 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 #include "rerere.h"
 #include "revision.h"
 #include "log-tree.h"
+#include "diffcore.h"
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
@@ -63,6 +64,11 @@ static const char * const git_stash_helper_store_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_create_usage[] = {
+	N_("git stash--helper create [<message>]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -290,6 +296,18 @@ static int reset_head(void)
 	return run_command(&cp);
 }
 
+static void add_diff_to_buf(struct diff_queue_struct *q,
+			    struct diff_options *options,
+			    void *data)
+{
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		strbuf_addstr(data, p->one->path);
+		strbuf_addch(data, 0);
+	}
+}
+
 static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -776,6 +794,416 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	return do_store_stash(argv[0], stash_msg, quiet);
 }
 
+/*
+ * `out` will be filled with the names of untracked files. The return value is:
+ *
+ * = 0 if there are not any untracked files
+ * > 0 if there are untracked files
+ */
+static int get_untracked_files(struct pathspec ps, int include_untracked,
+			       struct strbuf *out)
+{
+	int max_len;
+	int i;
+	char *seen;
+	struct dir_struct dir;
+
+	memset(&dir, 0, sizeof(dir));
+	if (include_untracked != 2)
+		setup_standard_excludes(&dir);
+
+	seen = xcalloc(ps.nr, 1);
+
+	max_len = fill_directory(&dir, the_repository->index, &ps);
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+		if (!dir_path_match(&the_index, ent, &ps, max_len, seen)) {
+			free(ent);
+			continue;
+		}
+		strbuf_addf(out, "%s%c", ent->name, '\0');
+		free(ent);
+	}
+
+	free(dir.entries);
+	free(dir.ignored);
+	clear_directory(&dir);
+	free(seen);
+	return out->len;
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
+	init_revisions(&rev, NULL);
+	rev.prune_data = ps;
+
+	rev.diffopt.flags.quick = 1;
+	rev.diffopt.flags.ignore_submodules = 1;
+	rev.abbrev = 0;
+
+	/* No initial commit. */
+	if (get_oid("HEAD", &dummy))
+		return -1;
+
+	add_head_to_pending(&rev);
+	diff_setup_done(&rev.diffopt);
+
+	if (read_cache() < 0)
+		return 1;
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
+				struct strbuf *in)
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
+	if (pipe_command(&cp_upd_index, in->buf, in->len, NULL, 0, NULL, 0)) {
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
+static struct strbuf patch = STRBUF_INIT;
+
+static int stash_patch(struct stash_info *info, struct pathspec ps)
+{
+	int i;
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
+	cp_add_i.git_cmd = 1;
+	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
+			"--", NULL);
+	for (i = 0; i < ps.nr; ++i)
+		argv_array_push(&cp_add_i.args, ps.items[i].match);
+	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp_add_i)) {
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
+	cp_diff_tree.git_cmd = 1;
+	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
+			 oid_to_hex(&info->w_tree), "--", NULL);
+	if (pipe_command(&cp_diff_tree, NULL, 0, &patch, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (!patch.len) {
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
+	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
+	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf diff_output = STRBUF_INIT;
+	struct rev_info rev;
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
+static int do_create_stash(struct pathspec ps, const char **stash_msg,
+			   int include_untracked, int patch_mode,
+			   struct stash_info *info)
+{
+	int untracked_commit_option = 0;
+	int ret = 0;
+	int flags;
+	const char *head_short_sha1 = NULL;
+	const char *branch_ref = NULL;
+	const char *branch_name = "(no branch)";
+	struct commit *head_commit = NULL;
+	struct commit_list *parents = NULL;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf commit_tree_label = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
+
+	read_cache_preload(NULL);
+	refresh_cache(REFRESH_QUIET);
+
+	if (!check_changes(ps, include_untracked)) {
+		ret = 1;
+		*stash_msg = NULL;
+		goto done;
+	}
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
+						     &out)) {
+		if (save_untracked_files(info, &msg, &out)) {
+			fprintf_ln(stderr, _("Cannot save the untracked files"));
+			ret = -1;
+			*stash_msg = NULL;
+			goto done;
+		}
+		untracked_commit_option = 1;
+	}
+	if (patch_mode) {
+		ret = stash_patch(info, ps);
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
+	strbuf_release(&out);
+	strbuf_release(&stash_msg_buf);
+	return ret;
+}
+
+static int create_stash(int argc, const char **argv, const char *prefix)
+{
+	int include_untracked = 0;
+	int ret = 0;
+	const char *stash_msg = NULL;
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
@@ -812,6 +1240,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.22.gc26283d74e

