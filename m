Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA00C1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeJOFz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36267 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeJOFzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id c26-v6so16082622edt.3
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urHn8Q9NnLAg0o+ei5Oo+gyb915lkyIFWDgeEtdsuYM=;
        b=iJg17ZCctXDCgMEiWL3x4QqHnACx7AMdXeqb9AOXpJC3FKvuAq7JCVFK7SNObSNExY
         un/96aLZR+bmhyDr76zHJUsZmTb70RQFKewAfleno/16cFuuctlyK2JnJk7rkFZifS7n
         i+bJANsyEGGVEUWNkEjaHpgGIRXIejhpTpYsjTKR/r5xWWaAOVm1h4yKvSo0t851FWYj
         O5NgDPv8tclseRFQVTeDZGgukBWZO0Y5EioicbrXNN7+Pd51nWi4KUsrbkbT46pblohb
         T6k3h/Y8hn7/E1eDpxRqFRD59ZvoAF5Iszcsj+o1JWEKpOh97Daj9PO5Js50qxBEnrnL
         1Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urHn8Q9NnLAg0o+ei5Oo+gyb915lkyIFWDgeEtdsuYM=;
        b=bnWYyLk1K4RU9Shj7xITjvHyFF4+iO4AxGpcJKYywiTgBVDr7ODSuSNd2RQm+o0ZkC
         uRsFr5+xyt+OVYYmyVIzw+eD7pkirPAOLDb/2epCB+YgIqO4/4rAqC1U/1rDgEuWVXSM
         7fTmk2Hnsancfs1EFWXa0r33C7kY0Wwu8GSY52HWjKLuvqvhjP/8IJdGXgtnGvYzAh9i
         wZ9OEDiih2lYfSU9LC46Ff2VZjCSo+p+SKfDlIorVMEELivxQHMYxnEFGWOX9+obT8Yr
         URbpVWY7gXIdt+/WXr8FL72KAsXwrZ5q+D6D9Bd7EBFS62VZgg9nsF/e+o3Rm7exZq5j
         67Wg==
X-Gm-Message-State: ABuFfojj8ffh6s3kIXGQRelrCzgRyo6djSa+ci8p/P9cmV5+YAP2EKcb
        AfZAnTaWGlsJ6i62TBlZXOdOJvw4
X-Google-Smtp-Source: ACcGV613gpNVHDMjcWPqiBZ/H8lbgzfueBP8CQ3riF8RIdFdBk2rRo7ReFJ2F8fWfMFNDnudP+JQyQ==
X-Received: by 2002:a50:97c8:: with SMTP id f8-v6mr21346423edb.243.1539555205422;
        Sun, 14 Oct 2018 15:13:25 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:24 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 16/21] stash: convert push to builtin
Date:   Mon, 15 Oct 2018 01:11:22 +0300
Message-Id: <efb1f1bba1aec287bf79452477611fa4b042b280.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash push to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 241 +++++++++++++++++++++++++++++++++++++++-
 git-stash.sh            |   6 +-
 2 files changed, 241 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index b8e69c1050..23f1329637 100644
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
 
@@ -1095,7 +1105,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 
 static int do_create_stash(struct pathspec ps, char **stash_msg,
 			   int include_untracked, int patch_mode,
-			   struct stash_info *info)
+			   struct stash_info *info, struct strbuf *patch)
 {
 	int ret = 0;
 	int flags = 0;
@@ -1109,7 +1119,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	struct strbuf commit_tree_label = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
-	struct strbuf patch = STRBUF_INIT;
 
 	read_cache_preload(NULL);
 	refresh_cache(REFRESH_QUIET);
@@ -1160,7 +1169,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, &patch);
+		ret = stash_patch(info, ps, patch);
 		*stash_msg = NULL;
 		if (ret < 0) {
 			fprintf_ln(stderr, _("Cannot save the current "
@@ -1234,7 +1243,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 			     0);
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info);
+	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
+			      NULL);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1248,6 +1258,227 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret < 0;
 }
 
+static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
+			 int keep_index, int patch_mode, int include_untracked)
+{
+	int ret = 0;
+	struct stash_info info;
+	struct strbuf patch = STRBUF_INIT;
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
+	if (do_create_stash(ps, &stash_msg, include_untracked, patch_mode,
+			    &info, &patch)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (do_store_stash(&info.w_commit, stash_msg, 1)) {
+		ret = -1;
+		fprintf_ln(stderr, _("Cannot save the current status"));
+		goto done;
+	}
+
+	printf_ln(_("Saved working directory and index state %s"), stash_msg);
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
+	free(stash_msg);
+	return ret;
+}
+
+static int push_stash(int argc, const char **argv, const char *prefix)
+{
+	int keep_index = -1;
+	int patch_mode = 0;
+	int include_untracked = 0;
+	int quiet = 0;
+	char *stash_msg = NULL;
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
+	return do_push_stash(ps, xstrdup_or_null(stash_msg), quiet,
+			     keep_index, patch_mode, include_untracked);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1286,6 +1517,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.23.g10a62394e7

