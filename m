Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5071F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeJOF4B (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:56:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32822 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJOFz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id l14-v6so7097238edq.0
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SM3oWfb64CaoZl7drJw0RTLkwp91vPMp/uzqrG42mgk=;
        b=PAmDOSMgA+H9PduVr++Z9KR9ZBS5IFgDTMWRK3GWFK1S+uHxySvU+xsqiuyph4W0Tg
         tIHS/dx4ZAna8n7alr76WOEvXR80fqAyyTlBmw+CXb/013RTutNGrbNszja0F5liu9xT
         mGn9v2n4eJh3sxiELQH3Jq5c9HB6Z6dLaBWF+mGtHoUKC9EPZFSzMUS3nCsq0fA+md7N
         X/FT50Tw70xFLfUtWleK+qeaX3AQ06p+4GwxsiogZvbsulDo395m8D+8AfYCOOYBySaq
         IKmQT4dWSQGezvf1HHvWbFqFARpQQo07q3uUYtGqyBS+l2RE0RuJ1ci0xI/qao5UzDwg
         cqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SM3oWfb64CaoZl7drJw0RTLkwp91vPMp/uzqrG42mgk=;
        b=Gkt2PjeDQQDoAgFJhX/RmKzzrdRpz+16gkjYMhbk/WYNyK6E4w7ImbN/MQw+SXmt4X
         p9dp6OMUK8xQJ3wLxwJlyiNsvJx8HDbgFWHNJDMYLRBZDliOWriv3zNFRwHgxkm/skTz
         lzxM/AXTJ+2YcFS6RAEcA8JL3D+t0gehKTUYpMrJWMpXWvHCPBkk5gVv7sWc3ruU4TSJ
         guPPA74WF7v7kHD/D438DiIgEtd4YTz2YlaNuMhgK37Vgaaced/KOFfb/oSn7AxZnoNG
         KYBPPX+q/XUUj2C8FBorerjxCLBPnfHx0s72SOgJid/cpZ9EMLZz2r1xbri8XqURfCI8
         Pxfw==
X-Gm-Message-State: ABuFfohm3I3FUUm1hWcElsRN9D2s05mvxKlGmH8CgvjDFiMV3dKBqv7N
        wx+Dkx5Yh46CybE+bFyqlvK5mKL6
X-Google-Smtp-Source: ACcGV63dfbZPuePH5aH+R0jtWU2FmFNGsxFVp++AP3wqvGqomFal1R4eWiQ2uvpffNcjiJyg2CDbNQ==
X-Received: by 2002:a17:906:13d9:: with SMTP id g25-v6mr16336495ejc.176.1539555208785;
        Sun, 14 Oct 2018 15:13:28 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:27 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 19/21] stash: convert `stash--helper.c` into `stash.c`
Date:   Mon, 15 Oct 2018 01:11:25 +0300
Message-Id: <004f2b2e3e8c4d1069a808034f3d6fe16853085c.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old shell script `git-stash.sh`  was removed and replaced
entirely by `builtin/stash.c`. In order to do that, `create` and
`push` were adapted to work without `stash.sh`. For example, before
this commit, `git stash create` called `git stash--helper create
--message "$*"`. If it called `git stash--helper create "$@"`, then
some of these changes wouldn't have been necessary.

This commit also removes the word `helper` since now stash is
called directly and not by a shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 .gitignore                           |   1 -
 Makefile                             |   3 +-
 builtin.h                            |   2 +-
 builtin/{stash--helper.c => stash.c} | 166 +++++++++++++++------------
 git-stash.sh                         | 153 ------------------------
 git.c                                |   2 +-
 6 files changed, 96 insertions(+), 231 deletions(-)
 rename builtin/{stash--helper.c => stash.c} (90%)
 delete mode 100755 git-stash.sh

diff --git a/.gitignore b/.gitignore
index b59661cb88..ffceea7d59 100644
--- a/.gitignore
+++ b/.gitignore
@@ -157,7 +157,6 @@
 /git-show-ref
 /git-stage
 /git-stash
-/git-stash--helper
 /git-status
 /git-stripspace
 /git-submodule
diff --git a/Makefile b/Makefile
index f900c68e69..ac1787d113 100644
--- a/Makefile
+++ b/Makefile
@@ -617,7 +617,6 @@ SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
-SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
 
@@ -1093,7 +1092,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/stash--helper.o
+BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 317bc338f7..e60f0fc58f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -223,7 +223,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
-extern int cmd_stash__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_stash(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash.c
similarity index 90%
rename from builtin/stash--helper.c
rename to builtin/stash.c
index a0413f5d00..e945c13c42 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash.c
@@ -16,75 +16,70 @@
 
 #define INCLUDE_ALL_FILES 2
 
-static const char * const git_stash_helper_usage[] = {
-	N_("git stash--helper list [<options>]"),
-	N_("git stash--helper show [<options>] [<stash>]"),
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
-	N_("git stash--helper branch <branchname> [<stash>]"),
-	N_("git stash--helper clear"),
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_usage[] = {
+	N_("git stash list [<options>]"),
+	N_("git stash show [<options>] [<stash>]"),
+	N_("git stash drop [-q|--quiet] [<stash>]"),
+	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash branch <branchname> [<stash>]"),
+	N_("git stash clear"),
+	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
-	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_list_usage[] = {
-	N_("git stash--helper list [<options>]"),
+static const char * const git_stash_list_usage[] = {
+	N_("git stash list [<options>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_show_usage[] = {
-	N_("git stash--helper show [<options>] [<stash>]"),
+static const char * const git_stash_show_usage[] = {
+	N_("git stash show [<options>] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_drop_usage[] = {
-	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+static const char * const git_stash_drop_usage[] = {
+	N_("git stash drop [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_pop_usage[] = {
-	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+static const char * const git_stash_pop_usage[] = {
+	N_("git stash pop [--index] [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_apply_usage[] = {
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+static const char * const git_stash_apply_usage[] = {
+	N_("git stash apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_branch_usage[] = {
-	N_("git stash--helper branch <branchname> [<stash>]"),
+static const char * const git_stash_branch_usage[] = {
+	N_("git stash branch <branchname> [<stash>]"),
 	NULL
 };
 
-static const char * const git_stash_helper_clear_usage[] = {
-	N_("git stash--helper clear"),
+static const char * const git_stash_clear_usage[] = {
+	N_("git stash clear"),
 	NULL
 };
 
-static const char * const git_stash_helper_store_usage[] = {
-	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+static const char * const git_stash_store_usage[] = {
+	N_("git stash store [-m|--message <message>] [-q|--quiet] <commit>"),
 	NULL
 };
 
-static const char * const git_stash_helper_create_usage[] = {
-	N_("git stash--helper create [<message>]"),
-	NULL
-};
-
-static const char * const git_stash_helper_push_usage[] = {
-	N_("git stash--helper [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_push_usage[] = {
+	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--] [<pathspec>...]]"),
 	NULL
 };
 
-static const char * const git_stash_helper_save_usage[] = {
-	N_("git stash--helper save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
+static const char * const git_stash_save_usage[] = {
+	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
@@ -223,7 +218,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_clear_usage,
+			     git_stash_clear_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc)
@@ -528,7 +523,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_apply_usage, 0);
+			     git_stash_apply_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -601,7 +596,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_drop_usage, 0);
+			     git_stash_drop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -627,7 +622,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_pop_usage, 0);
+			     git_stash_pop_usage, 0);
 
 	if (get_stash_info(&info, argc, argv))
 		return -1;
@@ -654,7 +649,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_branch_usage, 0);
+			     git_stash_branch_usage, 0);
 
 	if (!argc) {
 		fprintf_ln(stderr, _("No branch name specified"));
@@ -689,7 +684,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_list_usage,
+			     git_stash_list_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!ref_exists(ref_stash))
@@ -769,7 +764,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (argc > 1) {
 		free_stash_info(&info);
-		usage_with_options(git_stash_helper_show_usage, options);
+		usage_with_options(git_stash_show_usage, options);
 	}
 
 	rev.diffopt.flags.recursive = 1;
@@ -815,7 +810,7 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_store_usage,
+			     git_stash_store_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
 	if (argc != 1) {
@@ -1138,7 +1133,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 			fprintf_ln(stderr, _("You do not have "
 					     "the initial commit yet"));
 		ret = -1;
-		*stash_msg = NULL;
 		goto done;
 	} else {
 		head_commit = lookup_commit(the_repository, &info->b_commit);
@@ -1146,7 +1140,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 
 	if (!check_changes(ps, include_untracked)) {
 		ret = 1;
-		*stash_msg = NULL;
 		goto done;
 	}
 
@@ -1167,7 +1160,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 			fprintf_ln(stderr, _("Cannot save the current "
 					     "index state"));
 		ret = -1;
-		*stash_msg = NULL;
 		goto done;
 	}
 
@@ -1178,14 +1170,12 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 				fprintf_ln(stderr, _("Cannot save "
 						     "the untracked files"));
 			ret = -1;
-			*stash_msg = NULL;
 			goto done;
 		}
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
 		ret = stash_patch(info, ps, patch, quiet);
-		*stash_msg = NULL;
 		if (ret < 0) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
@@ -1200,7 +1190,6 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "worktree state"));
 			ret = -1;
-			*stash_msg = NULL;
 			goto done;
 		}
 	}
@@ -1210,7 +1199,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 	else
 		strbuf_addf(&stash_msg_buf, "On %s: %s", branch_name,
 			    *stash_msg);
-	*stash_msg = strbuf_detach(&stash_msg_buf, NULL);
+	*stash_msg = xstrdup(stash_msg_buf.buf);
 
 	/*
 	 * `parents` will be empty after calling `commit_tree()`, so there is
@@ -1244,30 +1233,23 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 
 static int create_stash(int argc, const char **argv, const char *prefix)
 {
-	int include_untracked = 0;
 	int ret = 0;
 	char *stash_msg = NULL;
 	struct stash_info info;
 	struct pathspec ps;
-	struct option options[] = {
-		OPT_BOOL('u', "include-untracked", &include_untracked,
-			 N_("include untracked files in stash")),
-		OPT_STRING('m', "message", &stash_msg, N_("message"),
-			 N_("stash message")),
-		OPT_END()
-	};
+	struct strbuf stash_msg_buf = STRBUF_INIT;
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_create_usage,
-			     0);
+	/* Starting with argv[1], since argv[0] is "create" */
+	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
+	stash_msg = stash_msg_buf.buf;
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info,
-			      NULL, 0);
+	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0);
 
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
+	strbuf_release(&stash_msg_buf);
 	free(stash_msg);
 
 	/*
@@ -1495,9 +1477,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_push_usage,
-			     0);
+	if (argc)
+		argc = parse_options(argc, argv, prefix, options,
+				     git_stash_push_usage,
+				     0);
 
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
 	return do_push_stash(ps, xstrdup_or_null(stash_msg), quiet,
@@ -1530,7 +1513,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_stash_helper_save_usage,
+			     git_stash_save_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (argc) {
@@ -1546,10 +1529,12 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+int cmd_stash(int argc, const char **argv, const char *prefix)
 {
+	int i = -1;
 	pid_t pid = getpid();
 	const char *index_file;
+	struct argv_array args = ARGV_ARRAY_INIT;
 
 	struct option options[] = {
 		OPT_END()
@@ -1557,16 +1542,16 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
+	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
 
 	index_file = get_index_file();
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (argc < 1)
-		usage_with_options(git_stash_helper_usage, options);
-	if (!strcmp(argv[0], "apply"))
+	if (argc == 0)
+		return !!push_stash(0, NULL, prefix);
+	else if (!strcmp(argv[0], "apply"))
 		return !!apply_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "clear"))
 		return !!clear_stash(argc, argv, prefix);
@@ -1588,7 +1573,42 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!push_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
+	else if (*argv[0] != '-')
+		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
+			      git_stash_usage, options);
+
+	if (strcmp(argv[0], "-p")) {
+		while (++i < argc && strcmp(argv[i], "--")) {
+			/*
+			 * `akpqu` is a string which contains all short options,
+			 * except `-m` which is verified separately.
+			 */
+			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
+			    strchr("akpqu", argv[i][1]))
+				continue;
+
+			if (!strcmp(argv[i], "--all") ||
+			    !strcmp(argv[i], "--keep-index") ||
+			    !strcmp(argv[i], "--no-keep-index") ||
+			    !strcmp(argv[i], "--patch") ||
+			    !strcmp(argv[i], "--quiet") ||
+			    !strcmp(argv[i], "--include-untracked"))
+				continue;
+
+			/*
+			 * `-m` and `--message=` are verified separately because
+			 * they need to be immediately followed by a string
+			 * (i.e.`-m"foobar"` or `--message="foobar"`).
+			 */
+			if (starts_with(argv[i], "-m") ||
+			    starts_with(argv[i], "--message="))
+				continue;
+
+			usage_with_options(git_stash_usage, options);
+		}
+	}
 
-	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
-		      git_stash_helper_usage, options);
+	argv_array_push(&args, "push");
+	argv_array_pushv(&args, argv);
+	return !!push_stash(args.argc, args.argv, prefix);
 }
diff --git a/git-stash.sh b/git-stash.sh
deleted file mode 100755
index 695f1feba3..0000000000
--- a/git-stash.sh
+++ /dev/null
@@ -1,153 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2007, Nanako Shiraishi
-
-dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="list [<options>]
-   or: $dashless show [<stash>]
-   or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-   or: $dashless branch <branchname> [<stash>]
-   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		      [-u|--include-untracked] [-a|--all] [<message>]
-   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [-m <message>]
-		       [-- <pathspec>...]]
-   or: $dashless clear"
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-START_DIR=$(pwd)
-. git-sh-setup
-require_work_tree
-prefix=$(git rev-parse --show-prefix) || exit 1
-cd_to_toplevel
-
-TMP="$GIT_DIR/.git-stash.$$"
-TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
-trap 'rm -f "$TMP-"* "$TMPindex"' 0
-
-ref_stash=refs/stash
-
-if git config --get-colorbool color.interactive; then
-       help_color="$(git config --get-color color.interactive.help 'red bold')"
-       reset_color="$(git config --get-color '' reset)"
-else
-       help_color=
-       reset_color=
-fi
-
-#
-# Parses the remaining options looking for flags and
-# at most one revision defaulting to ${ref_stash}@{0}
-# if none found.
-#
-# Derives related tree and commit objects from the
-# revision, if one is found.
-#
-# stash records the work tree, and is a merge between the
-# base commit (first parent) and the index tree (second parent).
-#
-#   REV is set to the symbolic version of the specified stash-like commit
-#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
-#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
-#   s is set to the SHA1 of the stash commit
-#   w_commit is set to the commit containing the working tree
-#   b_commit is set to the base commit
-#   i_commit is set to the commit containing the index tree
-#   u_commit is set to the commit containing the untracked files tree
-#   w_tree is set to the working tree
-#   b_tree is set to the base tree
-#   i_tree is set to the index tree
-#   u_tree is set to the untracked files tree
-#
-#   GIT_QUIET is set to t if -q is specified
-#   INDEX_OPTION is set to --index if --index is specified.
-#   FLAGS is set to the remaining flags (if allowed)
-#
-# dies if:
-#   * too many revisions specified
-#   * no revision is specified and there is no stash stack
-#   * a revision is specified which cannot be resolve to a SHA1
-#   * a non-existent stash reference is specified
-#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
-#
-
-test "$1" = "-p" && set "push" "$@"
-
-PARSE_CACHE='--not-parsed'
-# The default command is "push" if nothing but options are given
-seen_non_option=
-for opt
-do
-	case "$opt" in
-	--) break ;;
-	-*) ;;
-	*) seen_non_option=t; break ;;
-	esac
-done
-
-test -n "$seen_non_option" || set "push" "$@"
-
-# Main command set
-case "$1" in
-list)
-	shift
-	git stash--helper list "$@"
-	;;
-show)
-	shift
-	git stash--helper show "$@"
-	;;
-save)
-	shift
-	cd "$START_DIR"
-	git stash--helper save "$@"
-	;;
-push)
-	shift
-	cd "$START_DIR"
-	git stash--helper push "$@"
-	;;
-apply)
-	shift
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	;;
-clear)
-	shift
-	git stash--helper clear "$@"
-	;;
-create)
-	shift
-	git stash--helper create --message "$*"
-	;;
-store)
-	shift
-	git stash--helper store "$@"
-	;;
-drop)
-	shift
-	git stash--helper drop "$@"
-	;;
-pop)
-	shift
-	cd "$START_DIR"
-	git stash--helper pop "$@"
-	;;
-branch)
-	shift
-	cd "$START_DIR"
-	git stash--helper branch "$@"
-	;;
-*)
-	case $# in
-	0)
-		cd "$START_DIR"
-		git stash--helper push &&
-		say "$(gettext "(To restore them type \"git stash apply\")")"
-		;;
-	*)
-		usage
-	esac
-	;;
-esac
diff --git a/git.c b/git.c
index 3c0e762d7d..78548397cf 100644
--- a/git.c
+++ b/git.c
@@ -544,7 +544,7 @@ static struct cmd_struct commands[] = {
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
-- 
2.19.0.rc0.23.g10a62394e7

