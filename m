Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB3D1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439059AbeKWJsN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439043AbeKWJsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:48:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so10475336wmd.3
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNkjIsOpc/Shb8SgE/osuYiHJUWU2dDj6u0FzMHbzfg=;
        b=Fr5qP48wrT7xD4rOOyOXRrO7PBqz8U2uoMYgyjjrHJEhDg5Z3LCxwsnrTgVvXcqFFC
         VE8QN5OMVKoNO5U0BILOPoMQpzpL0Xb4q9BMdbhRJ01CSTT0xrIqzYWR3g+qfye3J6q3
         4SofxK8vS7Jixb/tyAgpt5Wi7doy46NqKYZzvQaTWCKbUjal/cOZY1Kd3QEFyCnYQcdh
         CfjplJ1W/k9P6skxYiNL9W3cq0lf9FesrHImXjwnA7iP3e1mtKDgHash1RyGwfo0IG3n
         uxQmZNoXC6NzDfbnPHRyw4lv6m+2Y1kEywc4U723XUF40Xiopq0CwjwilV46G5E85A1e
         BuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNkjIsOpc/Shb8SgE/osuYiHJUWU2dDj6u0FzMHbzfg=;
        b=ODRizqOl8JTrR7aNAI/kDD/8q/9B9eA5Jwolj7PET3u3lCKwJ8XVJljLkxkmenpif3
         ZHOn+P+qHnW57xGFVDFY2YvMDs9S4Sr+8j4a+ei4FvzxbiwnLdF8ItC+wzyADGkmW50Q
         2QLt0C8GThbYQlAXRGIZgt3KiuAWXPoXEO0yoNf8pHBN+AXh7hwxkBuqVl7v7thExHjJ
         /0hCfc8iCbi1AjGjayHqgdzluZIyXF0KEIMg5HEaptuu035EAxmlRIr0zgmTDm/Soho3
         wWRv77QoPhL1L7eK0S1Y0YdCs/mEUNhlsbxsVLfywBu2nfZy7cx9FGtMYT9Pn8lcrDgR
         UiwA==
X-Gm-Message-State: AA+aEWaM949n+pOh9jKKHYSXm9C/HbPCn4tkoSwPW8TlOBfsSCzg0eH1
        qZyQjlins1+KRHiv85T/fcn5VCW4
X-Google-Smtp-Source: AFSGD/UJSLWAdh9vzGdeppxWHdNkmX7cPPFK6Rl/doP6UGex8RFieplbbHXg6sFFZT4mezyRs2Tj6g==
X-Received: by 2002:a1c:35c5:: with SMTP id c188-v6mr4105828wma.116.1542927988949;
        Thu, 22 Nov 2018 15:06:28 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:28 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 17/22] stash: convert push to builtin
Date:   Fri, 23 Nov 2018 01:05:37 +0200
Message-Id: <d57ef97e09dc038aeae1353684f32ce50e851ac1.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash push to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 245 +++++++++++++++++++++++++++++++++++++++-
 git-stash.sh            |   6 +-
 2 files changed, 245 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index cd769d87b3..8683c662fc 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -23,6 +23,9 @@ static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
+	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
@@ -71,6 +74,13 @@ static const char * const git_stash_helper_create_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_push_usage[] = {
+	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [--] [<pathspec>...]]"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -1092,7 +1102,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info)
+			   struct stash_info *info, struct strbuf *patch)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1105,7 +1115,6 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
-	struct strbuf patch = STRBUF_INIT;
 
 	read_cache_preload(NULL);
 	refresh_cache(REFRESH_QUIET);
@@ -1152,7 +1161,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, &patch);
+		ret = stash_patch(info, ps, patch);
 		if (ret < 0) {
 			fprintf_ln(stderr, _("Cannot save the current "
 					     "worktree state"));
@@ -1223,7 +1232,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	strbuf_addstr(&stash_msg_buf, stash_msg);
-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info);
+	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
+			      NULL);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1237,6 +1247,231 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret < 0;
 }
 
+static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
+			 int keep_index, int patch_mode, int include_untracked)
+{
+	int ret = 0;
+	struct stash_info info;
+	struct strbuf patch = STRBUF_INIT;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
+
+	if (patch_mode && keep_index == -1)
+		keep_index = 1;
+
+	if (patch_mode && include_untracked) {
+		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
+				     " or --all at the same time"));
+		ret = -1;
+		goto done;
+	}
+
+	read_cache_preload(NULL);
+	if (!include_untracked && ps.nr) {
+		int i;
+		char *ps_matched = xcalloc(ps.nr, 1);
+
+		for (i = 0; i < active_nr; i++)
+			ce_path_match(&the_index, active_cache[i], &ps,
+				      ps_matched);
+
+		if (report_path_error(ps_matched, &ps, NULL)) {
+			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
+			ret = -1;
+			free(ps_matched);
+			goto done;
+		}
+		free(ps_matched);
+	}
+
+	if (refresh_cache(REFRESH_QUIET)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (!check_changes(ps, include_untracked)) {
+		if (!quiet)
+			printf_ln(_("No local changes to save"));
+		goto done;
+	}
+
+	if (!reflog_exists(ref_stash) && do_clear_stash()) {
+		ret = -1;
+		fprintf_ln(stderr, _("Cannot initialize stash"));
+		goto done;
+	}
+
+	if (stash_msg)
+		strbuf_addstr(&stash_msg_buf, stash_msg);
+	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
+			    &info, &patch)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
+		ret = -1;
+		fprintf_ln(stderr, _("Cannot save the current status"));
+		goto done;
+	}
+
+	printf_ln(_("Saved working directory and index state %s"),
+		  stash_msg_buf.buf);
+
+	if (!patch_mode) {
+		if (include_untracked && !ps.nr) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "clean", "--force",
+					 "--quiet", "-d", NULL);
+			if (include_untracked == INCLUDE_ALL_FILES)
+				argv_array_push(&cp.args, "-x");
+			if (run_command(&cp)) {
+				ret = -1;
+				goto done;
+			}
+		}
+		if (ps.nr) {
+			struct child_process cp_add = CHILD_PROCESS_INIT;
+			struct child_process cp_diff = CHILD_PROCESS_INIT;
+			struct child_process cp_apply = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			cp_add.git_cmd = 1;
+			argv_array_push(&cp_add.args, "add");
+			if (!include_untracked)
+				argv_array_push(&cp_add.args, "-u");
+			if (include_untracked == INCLUDE_ALL_FILES)
+				argv_array_push(&cp_add.args, "--force");
+			argv_array_push(&cp_add.args, "--");
+			add_pathspecs(&cp_add.args, ps);
+			if (run_command(&cp_add)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp_diff.git_cmd = 1;
+			argv_array_pushl(&cp_diff.args, "diff-index", "-p",
+					 "--cached", "--binary", "HEAD", "--",
+					 NULL);
+			add_pathspecs(&cp_diff.args, ps);
+			if (pipe_command(&cp_diff, NULL, 0, &out, 0, NULL, 0)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp_apply.git_cmd = 1;
+			argv_array_pushl(&cp_apply.args, "apply", "--index",
+					 "-R", NULL);
+			if (pipe_command(&cp_apply, out.buf, out.len, NULL, 0,
+					 NULL, 0)) {
+				ret = -1;
+				goto done;
+			}
+		} else {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
+					 NULL);
+			if (run_command(&cp)) {
+				ret = -1;
+				goto done;
+			}
+		}
+
+		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
+			struct child_process cp_ls = CHILD_PROCESS_INIT;
+			struct child_process cp_checkout = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			if (reset_tree(&info.i_tree, 0, 1)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp_ls.git_cmd = 1;
+			argv_array_pushl(&cp_ls.args, "ls-files", "-z",
+					 "--modified", "--", NULL);
+
+			add_pathspecs(&cp_ls.args, ps);
+			if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp_checkout.git_cmd = 1;
+			argv_array_pushl(&cp_checkout.args, "checkout-index",
+					 "-z", "--force", "--stdin", NULL);
+			if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
+					 0, NULL, 0)) {
+				ret = -1;
+				goto done;
+			}
+		}
+		goto done;
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		cp.git_cmd = 1;
+		argv_array_pushl(&cp.args, "apply", "-R", NULL);
+
+		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
+			fprintf_ln(stderr, _("Cannot remove worktree changes"));
+			ret = -1;
+			goto done;
+		}
+
+		if (keep_index < 1) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
+			add_pathspecs(&cp.args, ps);
+			if (run_command(&cp)) {
+				ret = -1;
+				goto done;
+			}
+		}
+		goto done;
+	}
+
+done:
+	strbuf_release(&stash_msg_buf);
+	return ret;
+}
+
+static int push_stash(int argc, const char **argv, const char *prefix)
+{
+	int keep_index = -1;
+	int patch_mode = 0;
+	int include_untracked = 0;
+	int quiet = 0;
+	const char *stash_msg = NULL;
+	struct pathspec ps;
+	struct option options[] = {
+		OPT_BOOL('k', "keep-index", &keep_index,
+			 N_("keep index")),
+		OPT_BOOL('p', "patch", &patch_mode,
+			 N_("stash in patch mode")),
+		OPT__QUIET(&quiet, N_("quiet mode")),
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_SET_INT('a', "all", &include_untracked,
+			    N_("include ignore files"), 2),
+		OPT_STRING('m', "message", &stash_msg, N_("message"),
+			   N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_push_usage,
+			     0);
+
+	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
+	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
+			     include_untracked);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1275,6 +1510,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!store_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "create"))
 		return !!create_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "push"))
+		return !!push_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index ab06e4ffb8..c3146f62ab 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -412,7 +412,8 @@ save)
 	;;
 push)
 	shift
-	push_stash "$@"
+	cd "$START_DIR"
+	git stash--helper push "$@"
 	;;
 apply)
 	shift
@@ -448,7 +449,8 @@ branch)
 *)
 	case $# in
 	0)
-		push_stash &&
+		cd "$START_DIR"
+		git stash--helper push &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
-- 
2.19.1.878.g0482332a22

