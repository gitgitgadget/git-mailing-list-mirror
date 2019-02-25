Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B6520248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfBYXRX (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52645 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfBYXRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so597163wml.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aon5OYOC2rFznlsBfHbYdDAKc6lTu1/+Eq6HlP+TJx0=;
        b=e5qgwU/us49WaJjXLfgRapzwKNvs8NFk3lTglz5x4FY1AND7Wg7w6V0n0194so/09l
         yp1+BQ9iGpuO3KFxqnu0Cp5pU0H8q/nMdYdLX3MGbzdAQCbtFD2WoiHXQdECBJqf55LT
         qp6wc6/K16QbB8R6lJnfDZ0PFDYldZmxhRBT3ME5e/0761acxcTAFDYgOp3CcnzDCtc1
         91O/2tktawSPuHbyTVdtt1eiKJfqxHop6CvOx2JKzKVQisnqyWF5khZI/IfRo6HvzPYl
         N2CErOlBmMlZr2T+dm21aohozqCHpihUsj9ReGbTd+ol/cbeBJeNrfJbVsmik1ZPZw6P
         vptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aon5OYOC2rFznlsBfHbYdDAKc6lTu1/+Eq6HlP+TJx0=;
        b=BK8sTmgBeG4eXAeNxDcja4PZg1fZC1sHDO6Rklz7+voCQUr/FW/tEsBrvZiionGelU
         Yd79UPtAoYZXxKqjibzPukZqbcTZ6RnYqinnJlS0zXrPPN/ebP6sdNR0WNlog3d1t6j9
         RaeTlwR1d+R7QVcBIo+xKcHjhg0i6sfdDuUq3DPwVl7aDhWnE1iK9B5v3XeI8tcIgxi4
         iyWfSeC1a4hBKnDwoEecwW4NLxel6m46z/yXdB4bAYHEHBiGezG7pRPmzFn5Thw3qzEe
         QCPSbI9jgvVfH2QUJmmz1O+rwIe0PhPoEWR+XPHG/EQeR5QTEZxBzJ+PoajtzuvTbr9+
         gCvg==
X-Gm-Message-State: AHQUAuZ+PvTydrpNRyGZ6lX/FUTjiFKXcgYwSMiwojyBEuJoF3AqBJc8
        DAJYzE5zzVqk5sy44CICV21lT0eG
X-Google-Smtp-Source: AHgI3Ia9JtTz4UXDb8AR3pCHfGilVUbaAR0ZUqXcgE8AEoksrTMgUwKOPzGeKqNSRQUvfZ5sPGf8aA==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr729373wmb.10.1551136638759;
        Mon, 25 Feb 2019 15:17:18 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id k6sm16303790wrq.82.2019.02.25.15.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:17 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 19/27] stash: convert push to builtin
Date:   Mon, 25 Feb 2019 23:16:23 +0000
Message-Id: <20190225231631.30507-20-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Add stash push to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 246 +++++++++++++++++++++++++++++++++++++++-
 git-stash.sh            |   6 +-
 2 files changed, 246 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 56864c126b..30c7aad76a 100644
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
 
@@ -1088,7 +1098,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info)
+			   struct stash_info *info, struct strbuf *patch)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1101,7 +1111,6 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
-	struct strbuf patch = STRBUF_INIT;
 
 	prepare_fallback_ident("git stash", "git@stash");
 
@@ -1150,7 +1159,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, &patch);
+		ret = stash_patch(info, ps, patch);
 		if (ret < 0) {
 			fprintf_ln(stderr, _("Cannot save the current "
 					     "worktree state"));
@@ -1221,7 +1230,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 
 	memset(&ps, 0, sizeof(ps));
 	strbuf_addstr(&stash_msg_buf, stash_msg);
-	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info);
+	ret = do_create_stash(ps, &stash_msg_buf, include_untracked, 0, &info,
+			      NULL);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
@@ -1234,6 +1244,232 @@ static int create_stash(int argc, const char **argv, const char *prefix)
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
+		discard_cache();
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
@@ -1272,6 +1508,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!store_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "create"))
 		return !!create_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "push"))
+		return !!push_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index a9b3064ff0..51d7a06601 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -429,7 +429,8 @@ save)
 	;;
 push)
 	shift
-	push_stash "$@"
+	cd "$START_DIR"
+	git stash--helper push "$@"
 	;;
 apply)
 	shift
@@ -465,7 +466,8 @@ branch)
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
2.21.0.rc2.291.g17236886c5

