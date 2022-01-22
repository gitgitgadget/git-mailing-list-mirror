Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF7C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 18:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiAVSf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 13:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiAVSf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 13:35:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0FC06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:35:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i67so69839wma.0
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GRuLjk+87ORUoTm6GTC6yoSEVB0eBxqbO8rxyvYHxn4=;
        b=eTW04Ox0Tw2n8rey8TJi7uBk0QkfoyYth7LEKXc2b1LEMAJOqlgyTAH/+CG4CIi1RC
         pNFdHZ8EhhBnIIK9OCtR3ENyx/4mz/IZOOKiAFkZDBGMFrfXHW0r3fWYLvFMq1i1XITB
         bjpHzT4uW2zTKbGAWc1eKKFAqZhPK/GHhB2cp0ea6Rqb+zM3R6i3RJFuOWcm0mITwYAt
         JJjXBZpJgOm8VgrdWVsfs7Jr+LFIMF8S1z+HTMUkazfuuL452t0RkArGX78ge/iSJ3q5
         5aBMdwiVPuc1sYMZ8jwnAE2WF1h+iaM3pT72LYn11nqn7J+pLtng7aMnhEzHFYWT7Lsn
         xzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GRuLjk+87ORUoTm6GTC6yoSEVB0eBxqbO8rxyvYHxn4=;
        b=fDh1oBbjoVusnh9GkCcLvQrwgt7raWAbSaTwEHtKrscJWfmyTs+CzoIy3lRvxOVDo6
         KkZArbrEfQmnFxS7n0gFeLCY/HPx3vYva3WmfeUwVmhnle/E0YdMBuESzylUoFpbBNlZ
         5LRUJAmdU1qpn64GifXPTKWzRrIBF5T/0Mnaw49wie6hp9OpWdWfjzv1Cq0/3PavgFxO
         K3gQcVfxrR0WoUNCHblZ7YeH6fdI39Is+Tf0OB4OU+8V0+YriUUa87lCG3uAfNA4QTrb
         VWeO/DWZQhf3KeZtgTK5C8wFepf005/1I9gzzVPKNE8AaQLKq1z/WkpduiFhxZJ4qTth
         xIrg==
X-Gm-Message-State: AOAM530qla/ui3n79kb05dGpJAdY5N/0C+GmYrDJsFUfiYUdHMJVPbkd
        lb4tCbk5xwSccBGiA4Ak1xXOglE3RD0=
X-Google-Smtp-Source: ABdhPJyv0pdx1wWUACkc4VfZiAsnHnGgxWPTh4Ebfj2Xteb8mS1596YxErZJ5iIdD4pB/fA9SDnGeQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr5362826wme.172.1642876556104;
        Sat, 22 Jan 2022 10:35:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm11697514wrp.55.2022.01.22.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 10:35:55 -0800 (PST)
Message-Id: <81ff928567fdf274000c660fb791641fc2ceccc9.1642876553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 18:35:50 +0000
Subject: [PATCH 1/4] i18n: factorize more 'incompatible options' messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

When more than two options are mutually exclusive, print the ones
which are actually on the command line.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/commit.c                          | 39 ++++++++++++++---------
 builtin/difftool.c                        | 18 +++++++++--
 builtin/grep.c                            |  4 +--
 builtin/log.c                             | 20 ++++++++++--
 builtin/merge-base.c                      |  4 +--
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 6 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b9ed0374e30..910f4c912bf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1243,6 +1243,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 				      struct wt_status *s)
 {
 	int f = 0;
+	char * f_options[4];
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	finalize_deferred_config(s);
@@ -1251,7 +1252,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		force_author = find_author_by_nickname(force_author);
 
 	if (force_author && renew_authorship)
-		die(_("Using both --reset-author and --author does not make sense"));
+		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
 
 	if (logfile || have_option_m || use_message)
 		use_editor = 0;
@@ -1268,19 +1269,19 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
-		die(_("Options --squash and --fixup cannot be used together"));
-	if (use_message)
-		f++;
-	if (edit_message)
-		f++;
-	if (fixup_message)
-		f++;
-	if (logfile)
-		f++;
+		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
+	f_options[f] = "-C";
+	f+=	!!use_message;
+	f_options[f] = "-c";
+	f+=!!edit_message;
+	f_options[f] = "-F";
+	f+=!!logfile;
+	f_options[f] = "--fixup";
+	f+=!!fixup_message;
 	if (f > 1)
-		die(_("Only one of -c/-C/-F/--fixup can be used."));
+		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
 	if (have_option_m && (edit_message || use_message || logfile))
-		die((_("Option -m cannot be combined with -c/-C/-F.")));
+		die(_("options '%s' and '%s' cannot be used together"), "-m", f_options[0]);
 	if (f || have_option_m)
 		template_file = NULL;
 	if (edit_message)
@@ -1305,9 +1306,17 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (patch_interactive)
 		interactive = 1;
-
-	if (also + only + all + interactive > 1)
-		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
+	f = 0;
+	f_options[f] = "-i/--include";
+	f += also;
+	f_options[f] = "-o/--only";
+	f += only;
+	f_options[f] = "-a/--all";
+	f += all;
+	f_options[f] = "--interactive/-p/--patch";
+	f += interactive;
+	if (f > 1)
+		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
 
 	if (fixup_message) {
 		/*
diff --git a/builtin/difftool.c b/builtin/difftool.c
index c79fbbf67e5..92854bc7737 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -685,6 +685,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
 	    tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
+	int f = 0;
+	char *f_options[3];
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
 			 N_("use `diff.guitool` instead of `diff.tool`")),
@@ -732,8 +734,20 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
-	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
-		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
+	if (use_gui_tool) {
+		f_options[f] = "--gui";
+		f++;
+	}
+	if (difftool_cmd) {
+		f_options[f] = "--tool";
+		f++;
+	}
+	if (extcmd) {
+		f_options[f] = "--extcmd";
+		f++;
+	}
+	if (f > 1)
+		die(_("options '%s' and '%s' cannot be used together"), f_options[0], f_options[1]);
 
 	if (use_gui_tool)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
diff --git a/builtin/grep.c b/builtin/grep.c
index 9e34a820ad4..b199781cb27 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1168,10 +1168,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (!use_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index"));
+		die(_("options '%s' and '%s' cannot be used together"),"--cached/--untracked", "--no-index");
 
 	if (untracked && cached)
-		die(_("--untracked cannot be used with --cached"));
+		die(_("options '%s' and '%s' cannot be used together"), "--untracked", "--cached");
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
diff --git a/builtin/log.c b/builtin/log.c
index 4b493408cc5..59b4a2fd380 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1759,6 +1759,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff_title = STRBUF_INIT;
 	int creation_factor = -1;
 
+	int f = 0;
+	char * f_options[4];
+
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
@@ -1978,8 +1981,21 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
-		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
+	if (use_stdout) {
+		f_options[f] = "--stdout";
+		f++;
+	}
+	if (rev.diffopt.close_file) {
+		f_options[f] = "--output";
+		f++;
+	}
+	if (output_directory) {
+		f_options[f] = "--output-directory";
+		f++;
+	}
+
+	if (f > 1)
+		die(_("options '%s'and '%s' cannot be used together"), f_options[0], f_options[1]);
 
 	if (use_stdout) {
 		setup_pager();
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6719ac198dc..1447f1c493a 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -159,12 +159,12 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 		if (argc < 2)
 			usage_with_options(merge_base_usage, options);
 		if (show_all)
-			die("--is-ancestor cannot be used with --all");
+			die(_("options '%s' and '%s' cannot be used together"),"--is-ancestor", "--all");
 		return handle_is_ancestor(argc, argv);
 	}
 
 	if (cmdmode == 'r' && show_all)
-		die("--independent cannot be used with --all");
+		die(_("options '%s' and '%s' cannot be used together"),"--independent", "--all");
 
 	if (cmdmode == 'o')
 		return handle_octopus(argc, argv, show_all);
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 91964653a0b..5fcaa0b4f2a 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -442,7 +442,7 @@ test_expect_success '--fixup=reword: give error with pathsec' '
 '
 
 test_expect_success '--fixup=reword: -F give error message' '
-	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
+	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
 	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

