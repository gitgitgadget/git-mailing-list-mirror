Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8A71F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeHHVUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35822 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeHHVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so3868681wmc.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mbe3YH4LDvchfoNBLfsfb0BWIjsnq+ldsg3Lc+LZ5CY=;
        b=X7xEEqj6FVrHglF+7lIWN32wNR2YtxmTlQbPfDx2tUyPMAQoEfZot3KI59hK85ORod
         fTOmvdQTEIMxLOE6C8khghToCEks2joiK44wzhtQP0AYh+pnReWs1wR9MtM/fSYJSOUv
         8TyYUxu/ZjKmAMe/qb/rltrz0ZK4t3m984xnry4yuDf+lNgo6pwczwWBVg5BaQ+j49wP
         ALsjKy8D0BSYA9tvipCwc7WjyJcJMEub8MW8STLoiduzKal07fRpBPAZAYMZMc1nc0Fd
         5ioZP1KQUy5IvH3ERd4s9CfE1imuC93rZQtj+lG7Fwhb+IhYZhArhCfrwl4XiBvg9BOU
         HdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mbe3YH4LDvchfoNBLfsfb0BWIjsnq+ldsg3Lc+LZ5CY=;
        b=GoHWZLOxqDAEAzRY1xp1DaKw/qSL69obMcZqMPkHGvGViocdntb250Ecsd/Yf7YpCq
         DBB9LzvtGoj95C3wbS3S1k88KjqeLRbvkwOYbr9SowakQjHKhRbu2AEu+IcpjoiFckrh
         Dv6BO5Hpi+OJp8059I7XpGBRaDarZyj0+QCd4pgwsvBaId655/mg/Iwv/M+jS6TetOJ2
         OohzZD8VIDaEfRucxPXaZnSzgEl1aCJZ1z2smX07NTIcCYnIlOU9dtfk8O7un1PoMJq0
         Q5IZSlctV38vVLk9wM9XKjWyFl8D8QpuvVlUyWfUmqGdTsUlzRW5oJnV6FnmIe4nCPJm
         xrgQ==
X-Gm-Message-State: AOUpUlFMcZDWSWp2tFgDiSViJjsDcpTSvbEFRf15W3MvS5xG5zRGcH/F
        2QkZIKMdyn5LRrCd32KK+BC2Kw4X
X-Google-Smtp-Source: AA+uWPxXkE0gyEn8MRbBm0+A1Z9iN+nrHyHvAn9OKT4kJ/Y2DIe6/pFX9e5/9Txsg7KIJtxqzGmrUg==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196-v6mr2800575wmd.114.1533754770121;
        Wed, 08 Aug 2018 11:59:30 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:29 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 15/26] stash: convert create to builtin
Date:   Wed,  8 Aug 2018 21:58:54 +0300
Message-Id: <0393bbd09daeb7ab67da4a343ba58d824c35532b.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash create to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 406 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   2 +-
 2 files changed, 407 insertions(+), 1 deletion(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 5ff810f8c..a4e57899b 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -21,6 +21,7 @@ static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+	N_("git stash--helper create [<message>]"),
 	NULL
 };
 
@@ -64,6 +65,11 @@ static const char * const git_stash_helper_store_usage[] = {
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
@@ -781,6 +787,404 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	return do_store_stash(argv[0], stash_msg, quiet);
 }
 
+/*
+ * `out` will be filled with the names of untracked files. The return value is:
+ *
+ * < 0 if there was a bug (any arg given outside the repo will be detected
+ *     by `setup_revision()`)
+ * = 0 if there are not any untracked files
+ * > 0 if there are untracked files
+ */
+static int get_untracked_files(const char **argv, int line_term,
+			       int include_untracked, struct strbuf *out)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "ls-files", "-o", NULL);
+	if (line_term)
+		argv_array_push(&cp.args, "-z");
+	if (include_untracked != 2)
+		argv_array_push(&cp.args, "--exclude-standard");
+	argv_array_push(&cp.args, "--");
+	if (argv)
+		argv_array_pushv(&cp.args, argv);
+
+	if (pipe_command(&cp, NULL, 0, out, 0, NULL, 0))
+		return -1;
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
+static int check_changes(const char **argv, int include_untracked,
+			 const char *prefix)
+{
+	int result;
+	int ret = 0;
+	struct rev_info rev;
+	struct object_id dummy;
+	struct strbuf out = STRBUF_INIT;
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	init_revisions(&rev, prefix);
+	parse_pathspec(&rev.prune_data, 0, PATHSPEC_PREFER_FULL,
+		       prefix, argv);
+
+	rev.diffopt.flags.quick = 1;
+	rev.diffopt.flags.ignore_submodules = 1;
+	rev.abbrev = 0;
+
+	/* No initial commit. */
+	if (get_oid("HEAD", &dummy)) {
+		ret = -1;
+		goto done;
+	}
+
+	add_head_to_pending(&rev);
+	diff_setup_done(&rev.diffopt);
+
+	if (read_cache() < 0) {
+		ret = -1;
+		goto done;
+	}
+	result = run_diff_index(&rev, 1);
+	if (diff_result_code(&rev.diffopt, result)) {
+		ret = 1;
+		goto done;
+	}
+
+	object_array_clear(&rev.pending);
+	result = run_diff_files(&rev, 0);
+	if (diff_result_code(&rev.diffopt, result)) {
+		ret = 1;
+		goto done;
+	}
+
+	if (include_untracked && get_untracked_files(argv, 0,
+						     include_untracked, &out))
+		ret = 1;
+
+done:
+	strbuf_release(&out);
+	argv_array_clear(&args);
+	return ret;
+}
+
+static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
+				struct strbuf *out)
+{
+	int ret = 0;
+	struct strbuf untracked_msg = STRBUF_INIT;
+	struct strbuf out2 = STRBUF_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct child_process cp2 = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "update-index", "-z", "--add",
+			 "--remove", "--stdin", NULL);
+	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
+	if (pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp2.git_cmd = 1;
+	argv_array_push(&cp2.args, "write-tree");
+	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp2, NULL, 0, &out2, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+	get_oid_hex(out2.buf, &info->u_tree);
+
+	if (commit_tree(untracked_msg.buf, untracked_msg.len,
+			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
+		ret = -1;
+		goto done;
+	}
+
+done:
+	strbuf_release(&untracked_msg);
+	strbuf_release(&out2);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static struct strbuf patch = STRBUF_INIT;
+
+static int stash_patch(struct stash_info *info, const char **argv)
+{
+	int ret = 0;
+	struct strbuf out2 = STRBUF_INIT;
+	struct child_process cp0 = CHILD_PROCESS_INIT;
+	struct child_process cp1 = CHILD_PROCESS_INIT;
+	struct child_process cp2 = CHILD_PROCESS_INIT;
+	struct child_process cp3 = CHILD_PROCESS_INIT;
+
+	remove_path(stash_index_path.buf);
+
+	cp0.git_cmd = 1;
+	argv_array_pushl(&cp0.args, "read-tree", "HEAD", NULL);
+	argv_array_pushf(&cp0.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp1.git_cmd = 1;
+	argv_array_pushl(&cp1.args, "add--interactive", "--patch=stash",
+			"--", NULL);
+	if (argv)
+		argv_array_pushv(&cp1.args, argv);
+	argv_array_pushf(&cp1.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (run_command(&cp1)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp2.git_cmd = 1;
+	argv_array_push(&cp2.args, "write-tree");
+	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp2, NULL, 0, &out2, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	get_oid_hex(out2.buf, &info->w_tree);
+
+	cp3.git_cmd = 1;
+	argv_array_pushl(&cp3.args, "diff-tree", "-p", "HEAD",
+			 oid_to_hex(&info->w_tree), "--", NULL);
+	if (pipe_command(&cp3, NULL, 0, &patch, 0, NULL, 0))
+		ret = -1;
+
+	if (!patch.len) {
+		fprintf_ln(stdout, "No changes selected");
+		ret = 1;
+	}
+
+done:
+	strbuf_release(&out2);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int stash_working_tree(struct stash_info *info, const char **argv)
+{
+	int ret = 0;
+	struct child_process cp0 = CHILD_PROCESS_INIT;
+	struct child_process cp1 = CHILD_PROCESS_INIT;
+	struct child_process cp2 = CHILD_PROCESS_INIT;
+	struct child_process cp3 = CHILD_PROCESS_INIT;
+	struct strbuf out1 = STRBUF_INIT;
+	struct strbuf out3 = STRBUF_INIT;
+
+	cp0.git_cmd = 1;
+	argv_array_push(&cp0.args, "read-tree");
+	argv_array_pushf(&cp0.args, "--index-output=%s", stash_index_path.buf);
+	argv_array_pushl(&cp0.args, "-m", oid_to_hex(&info->i_tree), NULL);
+	if (run_command(&cp0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp1.git_cmd = 1;
+	argv_array_pushl(&cp1.args, "diff-index", "--name-only", "-z",
+			"HEAD", "--", NULL);
+	if (argv)
+		argv_array_pushv(&cp1.args, argv);
+	argv_array_pushf(&cp1.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	if (pipe_command(&cp1, NULL, 0, &out1, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp2.git_cmd = 1;
+	argv_array_pushl(&cp2.args, "update-index", "-z", "--add",
+			 "--remove", "--stdin", NULL);
+	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+
+	if (pipe_command(&cp2, out1.buf, out1.len, NULL, 0, NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	cp3.git_cmd = 1;
+	argv_array_push(&cp3.args, "write-tree");
+	argv_array_pushf(&cp3.env_array, "GIT_INDEX_FILE=%s",
+			 stash_index_path.buf);
+	if (pipe_command(&cp3, NULL, 0, &out3, 0,NULL, 0)) {
+		ret = -1;
+		goto done;
+	}
+
+	get_oid_hex(out3.buf, &info->w_tree);
+
+done:
+	strbuf_release(&out1);
+	strbuf_release(&out3);
+	remove_path(stash_index_path.buf);
+	return ret;
+}
+
+static int do_create_stash(int argc, const char **argv, const char *prefix,
+			   const char **stash_msg, int include_untracked,
+			   int patch_mode, struct stash_info *info)
+{
+	int untracked_commit_option = 0;
+	int ret = 0;
+	int subject_len;
+	int flags;
+	const char *head_short_sha1 = NULL;
+	const char *branch_ref = NULL;
+	const char *head_subject = NULL;
+	const char *branch_name = "(no branch)";
+	struct commit *head_commit = NULL;
+	struct commit_list *parents = NULL;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf commit_tree_label = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf final_stash_msg = STRBUF_INIT;
+
+	read_cache_preload(NULL);
+	refresh_cache(REFRESH_QUIET);
+
+	if (!check_changes(argv, include_untracked, prefix)) {
+		ret = 1;
+		goto done;
+	}
+
+	if (get_oid("HEAD", &info->b_commit)) {
+		fprintf_ln(stderr, "You do not have the initial commit yet");
+		ret = -1;
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
+	subject_len = find_commit_subject(get_commit_buffer(head_commit, NULL),
+					  &head_subject);
+	strbuf_addf(&msg, "%s: %s %.*s\n", branch_name, head_short_sha1,
+		    subject_len, head_subject);
+
+	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
+	commit_list_insert(head_commit, &parents);
+	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
+	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
+			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
+		fprintf_ln(stderr, "Cannot save the current index state");
+		ret = -1;
+		goto done;
+	}
+
+	if (include_untracked && get_untracked_files(argv, 1,
+						     include_untracked, &out)) {
+		if (save_untracked_files(info, &msg, &out)) {
+			printf_ln("Cannot save the untracked files");
+			ret = -1;
+			goto done;
+		}
+		untracked_commit_option = 1;
+	}
+	if (patch_mode) {
+		ret = stash_patch(info, argv);
+		if (ret < 0) {
+			printf_ln("Cannot save the current worktree state");
+			goto done;
+		} else if (ret > 0) {
+			goto done;
+		}
+	} else {
+		if (stash_working_tree(info, argv)) {
+			printf_ln("Cannot save the current worktree state");
+			ret = -1;
+			goto done;
+		}
+	}
+
+	if (!*stash_msg || !strlen(*stash_msg))
+		strbuf_addf(&final_stash_msg, "WIP on %s", msg.buf);
+	else
+		strbuf_addf(&final_stash_msg, "On %s: %s\n", branch_name,
+			    *stash_msg);
+	*stash_msg = strbuf_detach(&final_stash_msg, NULL);
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
+		printf_ln("Cannot record working tree state");
+		ret = -1;
+		goto done;
+	}
+
+done:
+	strbuf_release(&commit_tree_label);
+	strbuf_release(&msg);
+	strbuf_release(&out);
+	strbuf_release(&final_stash_msg);
+	return ret;
+}
+
+static int create_stash(int argc, const char **argv, const char *prefix)
+{
+	int include_untracked = 0;
+	int ret = 0;
+	const char *stash_msg = NULL;
+	struct stash_info info;
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
+	ret = do_create_stash(argc, argv, prefix, &stash_msg,
+			      include_untracked, 0, &info);
+
+	if (!ret)
+		printf_ln("%s", oid_to_hex(&info.w_commit));
+
+	/*
+	 * ret can be 1 if there were no changes. In this case, we should
+	 * not error out.
+	 */
+	return ret < 0;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -817,6 +1221,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!show_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "store"))
 		return !!store_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "create"))
+		return !!create_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 5739c5152..ab06e4ffb 100755
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
2.18.0.573.g56500d98f

