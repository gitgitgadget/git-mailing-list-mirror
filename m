Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476561F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeHaBqM (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:12 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52037 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHaBqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:07 -0400
Received: by mail-wm0-f44.google.com with SMTP id y2-v6so3342900wma.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oKhycUyYz9/bJCi0t0XFpegPC3dlxuT7dNk8agBP2XE=;
        b=iP0zhVrth4AU6GIK1kTd4EIW7SIT+OMHkwiwBd6J/zyl/lA+L4GBcQKuWUGejRTMDV
         KJ5otU4eOhoO/WzhxkmtFNjNGg5MU3SkcBPAYhJ7bauN3XAvdZH+WO3M1Uav7g5E0xTD
         NCTD4IARXowi120OCUjozZdT3LV7R38G/4N6Tw8nmc565MOo9Sx85fo0YimUjeeL76c5
         oWskmS3GvnGKY42YMHnJZaih507PxyD57yV/OUnumtgg1bX0FXz4TMzICf9dz8k+rWUS
         pnHSmWR6y7YKFNzYOL2I8vfLpLhGwpXuYC3wqUGZVHtGsJJP9oCkHWClXiNnkvZ4D/IF
         3gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKhycUyYz9/bJCi0t0XFpegPC3dlxuT7dNk8agBP2XE=;
        b=mAPzo1xQvLGOONLIhvtDOmq81vm/uF/NZ8JbvnxZURmY3BN0vfLrTJ7NzWhSK4ZAe+
         dp8bIeexePcrckNUL2Un8WcOqdFeeYZ/kFV4R6qIdpm+lUSzfbAEhZTFdgNod3OUrzUS
         iJ9p3EgZt6g7QR4GRaGiw4T1wEMNZz9Et48iIaK5cxMCukgLCnP99fs23XAGAifTeObI
         UwfyL5o+QrgsmEo18YjZZG0GbZXKvPXwc+CyMqbN7Dm5JG1Ae4v2ocLIVqhZSrbMmI+1
         OXdH/c1oluFFrz25kR846Y/0OAji97YEOsfwJZfoNWkePLcuyKekWHVRwOUjFMkQI+C/
         VazA==
X-Gm-Message-State: APzg51CNo/Uc2dTgfGWDYaIR9pscV+B5bC8NnZx0iFy3oHcSnp7o0lDd
        WMWS6+4oJ85Mm4q6+LvUqRXylR4G
X-Google-Smtp-Source: ANB0VdYp5B5u4hHCiawOMTJdDt8J7g80o0N9OxjBL7muD8JhFGsRXnj3RLupWyO6mNASxWc+bC3E4w==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr2982703wmy.11.1535665311973;
        Thu, 30 Aug 2018 14:41:51 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:51 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 15/20] stash: convert push to builtin
Date:   Fri, 31 Aug 2018 00:40:45 +0300
Message-Id: <18debd5c9b1dc11a763caac39e10d4e8d5894bcb.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash push to the helper.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 229 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            |   6 +-
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index ce360a569d..23670321d8 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -21,6 +21,9 @@ static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
+	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
+	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
@@ -69,6 +72,13 @@ static const char * const git_stash_helper_create_usage[] = {
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
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -1204,6 +1214,223 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret < 0;
 }
 
+static void add_ps_items_to_argv_array(struct argv_array *args,
+				       struct pathspec ps) {
+	int i;
+	for (i = 0; i < ps.nr; ++i)
+		argv_array_push(args, ps.items[i].match);
+}
+
+static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
+			 int keep_index, int patch_mode, int include_untracked)
+{
+	int ret = 0;
+	struct stash_info info;
+	if (patch_mode && keep_index == -1)
+		keep_index = 1;
+
+	if (patch_mode && include_untracked) {
+		fprintf_ln(stderr, _("Can't use --patch and --include-untracked or --all at the same time"));
+		return -1;
+	}
+
+	read_cache_preload(NULL);
+	if (!include_untracked && ps.nr) {
+		int i;
+		char *ps_matched = xcalloc(ps.nr, 1);
+
+		for (i = 0; i < active_nr; ++i) {
+			const struct cache_entry *ce = active_cache[i];
+			ce_path_match(&the_index, ce, &ps, ps_matched);
+		}
+
+		if (report_path_error(ps_matched, &ps, NULL)) {
+			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
+			return -1;
+		}
+		free(ps_matched);
+	}
+
+	if (refresh_cache(REFRESH_QUIET))
+		return -1;
+
+	if (!check_changes(ps, include_untracked)) {
+		printf_ln(_("No local changes to save"));
+		return 0;
+	}
+
+	if (!reflog_exists(ref_stash) && do_clear_stash()) {
+		fprintf_ln(stderr, _("Cannot initialize stash"));
+		return -1;
+	}
+
+	if (do_create_stash(ps, &stash_msg, include_untracked, patch_mode,
+			    &info)) {
+		ret = -1;
+		goto done;
+	}
+
+	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
+		fprintf(stderr, _("Cannot save the current status"));
+		ret = -1;
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
+			if (include_untracked == 2)
+				argv_array_push(&cp.args, "-x");
+			if (run_command(&cp)) {
+				ret = -1;
+				goto done;
+			}
+		}
+		if (ps.nr) {
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			struct child_process cp2 = CHILD_PROCESS_INIT;
+			struct child_process cp3 = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			cp1.git_cmd = 1;
+			argv_array_push(&cp1.args, "add");
+			if (!include_untracked)
+				argv_array_push(&cp1.args, "-u");
+			if (include_untracked == 2)
+				argv_array_push(&cp1.args, "--force");
+			argv_array_push(&cp1.args, "--");
+			add_ps_items_to_argv_array(&cp1.args, ps);
+			if (run_command(&cp1)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp2.git_cmd = 1;
+			argv_array_pushl(&cp2.args, "diff-index", "-p",
+					 "--cached", "--binary", "HEAD", "--",
+					 NULL);
+			add_ps_items_to_argv_array(&cp2.args, ps);
+			if (pipe_command(&cp2, NULL, 0, &out, 0, NULL, 0)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp3.git_cmd = 1;
+			argv_array_pushl(&cp3.args, "apply", "--index", "-R",
+					 NULL);
+			if (pipe_command(&cp3, out.buf, out.len, NULL, 0, NULL,
+					 0)) {
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
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			struct child_process cp2 = CHILD_PROCESS_INIT;
+			struct strbuf out = STRBUF_INIT;
+
+			if (reset_tree(&info.i_tree, 0, 1)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp1.git_cmd = 1;
+			argv_array_pushl(&cp1.args, "ls-files", "-z",
+					 "--modified", "--", NULL);
+			add_ps_items_to_argv_array(&cp1.args, ps);
+			if (pipe_command(&cp1, NULL, 0, &out, 0, NULL, 0)) {
+				ret = -1;
+				goto done;
+			}
+
+			cp2.git_cmd = 1;
+			argv_array_pushl(&cp2.args, "checkout-index", "-z",
+					 "--force", "--stdin", NULL);
+			if (pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL,
+					 0)) {
+				ret = -1;
+				goto done;
+			}
+		}
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
+			int i;
+			struct child_process cp = CHILD_PROCESS_INIT;
+
+			cp.git_cmd = 1;
+			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
+			for (i = 0; i < ps.nr; ++i)
+				argv_array_push(&cp.args, ps.items[i].match);
+			if (run_command(&cp)) {
+				ret = -1;
+				goto done;
+			}
+		}
+	}
+done:
+	free((char *) stash_msg);
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
+		OPT_SET_INT('k', "keep-index", &keep_index,
+			N_("keep index"), 1),
+		OPT_BOOL('p', "patch", &patch_mode,
+			N_("stash in patch mode")),
+		OPT__QUIET(&quiet, N_("quiet mode")),
+		OPT_BOOL('u', "include-untracked", &include_untracked,
+			 N_("include untracked files in stash")),
+		OPT_SET_INT('a', "all", &include_untracked,
+			    N_("include ignore files"), 2),
+		OPT_STRING('m', "message", &stash_msg, N_("message"),
+			 N_("stash message")),
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
@@ -1242,6 +1469,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
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
2.19.0.rc0.22.gc26283d74e

