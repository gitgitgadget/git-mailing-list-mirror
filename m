Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC8C1F42D
	for <e@80x24.org>; Sun, 20 May 2018 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbeETIM4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 04:12:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42099 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeETIMw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 04:12:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id b18-v6so19656883lfa.9
        for <git@vger.kernel.org>; Sun, 20 May 2018 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGmOHkX49IptFIpv1XJQ/FwVRiCAk4StnrrNPi/fbpw=;
        b=IYx8wQXAoGLRohnRiYJRYupSc/NXdm2oeJqwxwaDcbw9JJ4gZXz4TMUcao5YKRs/FB
         7gT1M45gMg86V3FIwCVsUJm2D+BIFf+od+kybswsplHu5NA+eaUpZZm3olPPswwKJC77
         UB2VG1Nk2gJv0x/psE4aPPkmVOIpkAIK1a5ZI+7FqURDHMrEHaUQTmHaQJ4IF75/suo1
         HQSpxxDiZC72SJNVNEUGmdWmeTHxbqZ7hYSVIR6F50jE6pR31Gfr0IcYiAssAgzJIzK7
         yhnNczjnXBaZjkANJDBcrjif1UIXArcfhVw6yCCTdgMLhgjFtrBjBO/zr3AKzkf5gHcN
         Nwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGmOHkX49IptFIpv1XJQ/FwVRiCAk4StnrrNPi/fbpw=;
        b=hrdCTUqof6cnB+NVxBzxbYCHlpRNSqt0tqBg2yPb3T1B3e86YR8LNNE/BZh77Ffyvk
         6CXgdf+zOT6DQFZP6ac8N1ZcfgvN3gEoi+s+LKTFCz+Pa0DDjQ/XOtKuKQRWkM8dADJw
         oVvpqIMznFh2Q8l861SxinLRNWFWQRpuk0CzTHdWABCMtNwJbA+OG8HSY9zBfjlENs2z
         vUhTkkgxzMlO+vcVnrf7OXu38BqlDffKOMef9v/6Lm2Uu+jZRz0Db8bCn1STFTBQzfWM
         47xCKvwYaflI6nxiSzgmgIC0YHgguXT2pOawPoQx8U1OrKdyy4qCvF1nNQqqvgYJ1Ix3
         vLcQ==
X-Gm-Message-State: ALKqPwdxZmI60Sx486xXgLi3m9ZRztbWDS6IuBYwsAaC0bFK4uy/qyze
        REOtAoDMKg4kxyvsp8+fdovcXw==
X-Google-Smtp-Source: AB8JxZpZs/pEMC5/ppqRY23h1bwKmizuhfm3n+IwF5a5V4hRa+JcVDIS+Kd48xj2CE/HCR7sbvshpQ==
X-Received: by 2002:a2e:9756:: with SMTP id f22-v6mr10193405ljj.111.1526803969866;
        Sun, 20 May 2018 01:12:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b65-v6sm2806249lff.5.2018.05.20.01.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 01:12:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Use OPT_SET_INT_F() for cmdline option specification
Date:   Sun, 20 May 2018 10:12:44 +0200
Message-Id: <20180520081244.14619-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only thing these commands need is extra parseopt flags which can be
passed in by OPT_SET_INT_F() and it is a bit more compact than full
struct initialization.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c              |  6 ++----
 builtin/am.c           | 12 ++++++------
 builtin/branch.c       |  4 ++--
 builtin/difftool.c     |  9 ++++-----
 builtin/fetch.c        |  6 +++---
 builtin/grep.c         |  6 +++---
 builtin/log.c          |  6 +++---
 builtin/ls-files.c     |  6 +++---
 builtin/merge.c        |  6 +++---
 builtin/notes.c        | 12 ++++++------
 builtin/pack-objects.c | 24 ++++++++++++------------
 11 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/archive.c b/archive.c
index 93ab175b0b..4fe7bec60c 100644
--- a/archive.c
+++ b/archive.c
@@ -411,11 +411,9 @@ static void parse_treeish_arg(const char **argv,
 }
 
 #define OPT__COMPR(s, v, h, p) \
-	{ OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
-	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
+	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
 #define OPT__COMPR_HIDDEN(s, v, p) \
-	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
-	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
+	OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN)
 
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
diff --git a/builtin/am.c b/builtin/am.c
index d834f9e62b..666287b497 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2231,12 +2231,12 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			N_("pass -b flag to git-mailinfo"), KEEP_NON_PATCH),
 		OPT_BOOL('m', "message-id", &state.message_id,
 			N_("pass -m flag to git-mailinfo")),
-		{ OPTION_SET_INT, 0, "keep-cr", &keep_cr, NULL,
-		  N_("pass --keep-cr flag to git-mailsplit for mbox format"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
-		{ OPTION_SET_INT, 0, "no-keep-cr", &keep_cr, NULL,
-		  N_("do not pass --keep-cr flag to git-mailsplit independent of am.keepcr"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+		OPT_SET_INT_F(0, "keep-cr", &keep_cr,
+			N_("pass --keep-cr flag to git-mailsplit for mbox format"),
+			1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "no-keep-cr", &keep_cr,
+			N_("do not pass --keep-cr flag to git-mailsplit for mbox format"),
+			0, PARSE_OPT_NONEG),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
diff --git a/builtin/branch.c b/builtin/branch.c
index efc9ac1922..cc089f9efb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -592,8 +592,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
-		{ OPTION_SET_INT, 0, "set-upstream", &track, NULL, N_("do not use"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, BRANCH_TRACK_OVERRIDE },
+		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
+			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
diff --git a/builtin/difftool.c b/builtin/difftool.c
index aad0e073ee..c439b64207 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -695,12 +695,11 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			 N_("use `diff.guitool` instead of `diff.tool`")),
 		OPT_BOOL('d', "dir-diff", &dir_diff,
 			 N_("perform a full-directory diff")),
-		{ OPTION_SET_INT, 'y', "no-prompt", &prompt, NULL,
+		OPT_SET_INT_F('y', "no-prompt", &prompt,
 			N_("do not prompt before launching a diff tool"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
-		{ OPTION_SET_INT, 0, "prompt", &prompt, NULL, NULL,
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
-			NULL, 1 },
+			0, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "prompt", &prompt, NULL,
+			1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "symlinks", &symlinks,
 			 N_("use symlinks in dir-diff mode")),
 		OPT_STRING('t', "tool", &difftool_cmd, N_("<tool>"),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7ee83ac0f8..b6530a5ce0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -156,9 +156,9 @@ static struct option builtin_fetch_options[] = {
 			N_("deepen history of shallow clone, excluding rev")),
 	OPT_INTEGER(0, "deepen", &deepen_relative,
 		    N_("deepen history of shallow clone")),
-	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
-		   N_("convert to a complete repository"),
-		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
+	OPT_SET_INT_F(0, "unshallow", &unshallow,
+		      N_("convert to a complete repository"),
+		      1, PARSE_OPT_NONEG),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	{ OPTION_CALLBACK, 0, "recurse-submodules-default",
diff --git a/builtin/grep.c b/builtin/grep.c
index 6e7bc76785..850bcffd99 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -885,9 +885,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   N_("indicate hit with exit status without output")),
 		OPT_BOOL(0, "all-match", &opt.all_match,
 			N_("show only matches from files that match all patterns")),
-		{ OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
-		  N_("show parse tree for grep expression"),
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
+		OPT_SET_INT_F(0, "debug", &opt.debug,
+			      N_("show parse tree for grep expression"),
+			      1, PARSE_OPT_HIDDEN),
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
diff --git a/builtin/log.c b/builtin/log.c
index 71f68a3e4f..8f27921505 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1474,9 +1474,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			 N_("output all-zero hash in From header")),
 		OPT_BOOL(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
 			 N_("don't include a patch matching a commit upstream")),
-		{ OPTION_SET_INT, 'p', "no-stat", &use_patch_format, NULL,
-		  N_("show patch format instead of default (patch + stat)"),
-		  PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1},
+		OPT_SET_INT_F('p', "no-stat", &use_patch_format,
+			      N_("show patch format instead of default (patch + stat)"),
+			      1, PARSE_OPT_NONEG),
 		OPT_GROUP(N_("Messaging")),
 		{ OPTION_CALLBACK, 0, "add-header", NULL, N_("header"),
 			    N_("add email header"), 0, header_callback },
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a71f6bd088..40d9138c46 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -556,9 +556,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
 			N_("add the standard git exclusions"),
 			PARSE_OPT_NOARG, option_parse_exclude_standard },
-		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
-			N_("make the output relative to the project top directory"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_SET_INT_F(0, "full-name", &prefix_len,
+			      N_("make the output relative to the project top directory"),
+			      0, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
 			N_("recurse through submodules")),
 		OPT_BOOL(0, "error-unmatch", &error_unmatch,
diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..4be71dd81b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -213,9 +213,9 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
-	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
-		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
+	OPT_SET_INT_F(0, "ff-only", &fast_forward,
+		      N_("abort if fast-forward is not possible"),
+		      FF_ONLY, PARSE_OPT_NONEG),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("verify that the named commit has a valid GPG signature")),
diff --git a/builtin/notes.c b/builtin/notes.c
index e5bf80eef1..4d34994c34 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -778,13 +778,13 @@ static int merge(int argc, const char **argv, const char *prefix)
 			   N_("resolve notes conflicts using the given strategy "
 			      "(manual/ours/theirs/union/cat_sort_uniq)")),
 		OPT_GROUP(N_("Committing unmerged notes")),
-		{ OPTION_SET_INT, 0, "commit", &do_commit, NULL,
-			N_("finalize notes merge by committing unmerged notes"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+		OPT_SET_INT_F(0, "commit", &do_commit,
+			      N_("finalize notes merge by committing unmerged notes"),
+			      1, PARSE_OPT_NONEG),
 		OPT_GROUP(N_("Aborting notes merge resolution")),
-		{ OPTION_SET_INT, 0, "abort", &do_abort, NULL,
-			N_("abort notes merge"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+		OPT_SET_INT_F(0, "abort", &do_abort,
+			      N_("abort notes merge"),
+			      1, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24b1c6c5dd..5134c655c7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2992,18 +2992,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not create an empty pack output")),
 		OPT_BOOL(0, "revs", &use_internal_rev_list,
 			 N_("read revision arguments from standard input")),
-		{ OPTION_SET_INT, 0, "unpacked", &rev_list_unpacked, NULL,
-		  N_("limit the objects to those that are not yet packed"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
-		{ OPTION_SET_INT, 0, "all", &rev_list_all, NULL,
-		  N_("include objects reachable from any reference"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
-		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
-		  N_("include objects referred by reflog entries"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
-		{ OPTION_SET_INT, 0, "indexed-objects", &rev_list_index, NULL,
-		  N_("include objects referred to by the index"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_SET_INT_F(0, "unpacked", &rev_list_unpacked,
+			      N_("limit the objects to those that are not yet packed"),
+			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "all", &rev_list_all,
+			      N_("include objects reachable from any reference"),
+			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "reflog", &rev_list_reflog,
+			      N_("include objects referred by reflog entries"),
+			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
+			      N_("include objects referred to by the index"),
+			      1, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
-- 
2.17.0.705.g3525833791

