Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B2C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhLLTut (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:50:49 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51028 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLLTur (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:50:47 -0500
Received: by mail-wm1-f43.google.com with SMTP id 133so10613994wme.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OESgZipnSfYa+Z/jgwOvYK3FH5Sp8MsKwLKyqdThQNg=;
        b=H3EftNTWmTTQGGTKVqxJgBMnAOHKVrRQ1kbXiFalrov66O/uSE2BuOg5wHq8DhrczF
         eIrll4DhpQljfeHUybDfzV/dv+F8jMW86IFM6E1nZaR/3S+A2NOxDpnuRthY0yks5/2G
         y1oFRMs18P9m1tHpZvPcpaxuBDRsKLQxdNi2SlU9i7MhoiroIMzuGe6OmEsSS/TEOVj+
         7rUuyeakSDvuTLjjDaTZKV8DZ0qMgpx2XYCpVZLaVY9QpvsR+MoN5mol7cCWXrMAVFcv
         4bbb0tQWXCuJ7hJkGq+1YPUM9ZMArVMWJdONRpN/AbXnhIjCOVZ3DOF2Is/zFj2TI+b3
         /aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OESgZipnSfYa+Z/jgwOvYK3FH5Sp8MsKwLKyqdThQNg=;
        b=B6odioZ97WsFqA3NoABixEnKzCJbUBB1xFyHDRTR1E1Qu09IyF6lhf5DvGB0ohPoZO
         c0OVF2m+EfdsXviaRJ4841sngP5CEfcx22u9+IYW/UOVz0YS6LfCyZAuZKAdRNw+Vjn7
         gmbsh0hGDLcXAkEZjVmGf4kuL0s56NmoqSchS6wCfSkvy6ujD2Ystp0XL/4bcwnYTZAb
         mU579w2VUacT4qFzfCqlMrHk3uB13U4czgexa27DmgkhA3A9XZydC+tbRRZsF+VKVaBv
         k+K27jZ0XLQ5KcDckdBL83C0T3DsviENutxqDx24A8d7jQwTJNrNEpCnQR3SDrMxGg/k
         6ltQ==
X-Gm-Message-State: AOAM532jKXsaTdYXRx/3bHbJYaUIyxz43mECKCuu2dGH/csUJxinfiws
        95RweWWzpS/okjSkpEhc08ng9fQeNf3KDA==
X-Google-Smtp-Source: ABdhPJxzbXiZGsMo65zvUaLWslfzdcLk4MOlnPcITfGc8VXYUlpUn7ZbqO6THzFuInNCS0NK8K9Cjw==
X-Received: by 2002:a05:600c:35d2:: with SMTP id r18mr32196882wmq.166.1639338585808;
        Sun, 12 Dec 2021 11:49:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g4sm8293822wro.12.2021.12.12.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:49:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>, Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] git docs: split "User-facing file formats" off from "Guides"
Date:   Sun, 12 Dec 2021 20:49:36 +0100
Message-Id: <patch-v2-1.5-960574b7f05-20211212T194047Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.929.ge922d848c7a
In-Reply-To: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "User-facing file formats" section in the main "git help
git" manual page. The "Guides" section was added to the manual page in
f442f28a81b (git.txt: add list of guides, 2020-08-05), it makes sense
to list all that documentation.

But placing e.g. "gitignore(5)" in it is stretching the meaning of
what a "guide" is, ideally that section should list things similar to
"giteveryday(7)" and "gitcore-tutorial(7)".

We take a wide view of what's considered a "user format", it's not
just a file format, but e.g. githooks(5) also belongs, since the
layout of the ".git/hooks/" and the placement of hooks in it is
something the user might be expected to interact with.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile     |  1 +
 Documentation/git-help.txt | 13 +++++++++----
 Documentation/git.txt      |  7 +++++++
 Makefile                   |  1 +
 builtin/help.c             |  8 ++++++++
 command-list.txt           | 16 ++++++++++------
 help.c                     | 11 +++++++++++
 help.h                     |  1 +
 t/t0012-help.sh            | 16 +++++++++++++++-
 9 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae9..e973be97162 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -316,6 +316,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
+	cmds-userformats.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 44ea63cc6d3..32081f3030d 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,14 +9,15 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all [--[no-]verbose]]
-	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
+	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>|<doc>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
+'git help' [--user-formats]
 
 DESCRIPTION
 -----------
 
-With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
+With no options and no '<command>', '<guide>' or '<doc>' given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -26,8 +27,8 @@ printed on the standard output.
 If the option `--guides` or `-g` is given, a list of the
 Git concept guides is also printed on the standard output.
 
-If a command, or a guide, is given, a manual page for that command or
-guide is brought up. The 'man' program is used by default for this
+If a command or other documentation is given, the relevant manual page
+will be brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
@@ -62,6 +63,10 @@ OPTIONS
 --guides::
 	Prints a list of the Git concept guides on the standard output.
 
+--user-formats::
+	Prints a list of the Git user-facing format documentation on
+	the standard output.
+
 -i::
 --info::
 	Display manual page for the command in the 'info' format. The
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 13f83a2a3a1..7a8be2991df 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -337,6 +337,13 @@ The following documentation pages are guides about Git concepts.
 
 include::cmds-guide.txt[]
 
+User-facing file formats
+------------------------
+
+This documentation discusses file formats that users are expected to
+edit. These can also be listed with 'git help --user-formats'.
+
+include::cmds-userformats.txt[]
 
 Configuration Mechanism
 -----------------------
diff --git a/Makefile b/Makefile
index ed75ed422b5..c59fd6c2be9 100644
--- a/Makefile
+++ b/Makefile
@@ -3304,6 +3304,7 @@ check-docs::
 		sed -e '1,/^### command list/d' \
 		    -e '/^#/d' \
 		    -e '/guide$$/d' \
+		    -e '/formats$$/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/builtin/help.c b/builtin/help.c
index 75cd2fb407f..5e842ea5a26 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -43,6 +43,7 @@ static enum help_action {
 	HELP_ACTION_ALL = 1,
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
+	HELP_ACTION_USER_FORMATS,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
@@ -64,6 +65,8 @@ static struct option builtin_help_options[] = {
 
 	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
 		    HELP_ACTION_GUIDES),
+	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
+		    HELP_ACTION_USER_FORMATS),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -79,6 +82,7 @@ static const char * const builtin_help_usage[] = {
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
+	N_("git help [--user-formats]"),
 	NULL
 };
 
@@ -613,6 +617,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		no_extra_argc(argc);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
+	case HELP_ACTION_USER_FORMATS:
+		no_extra_argc(argc);
+		list_user_formats_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		no_extra_argc(argc);
 		list_config_help(SHOW_CONFIG_SECTIONS);
diff --git a/command-list.txt b/command-list.txt
index 675c28f0bd0..e4118533e93 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -43,6 +43,10 @@
 # specified here, which can only have "guide" attribute and nothing
 # else.
 #
+# User-facing file formats such as documentation for the .gitmodules,
+# .mailmap etc. files lives in man section 5. These entries can only
+# have the "userformats" attribute and nothing else.
+#
 ### command list (do not change this line)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -191,7 +195,7 @@ git-verify-tag                          ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
-gitattributes                           guide
+gitattributes                           userformats
 gitcli                                  guide
 gitcore-tutorial                        guide
 gitcredentials                          guide
@@ -200,14 +204,14 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitglossary                             guide
-githooks                                guide
-gitignore                               guide
+githooks                                userformats
+gitignore                               userformats
 gitk                                    mainporcelain
-gitmailmap                              guide
-gitmodules                              guide
+gitmailmap                              userformats
+gitmodules                              userformats
 gitnamespaces                           guide
 gitremote-helpers                       guide
-gitrepository-layout                    guide
+gitrepository-layout                    userformats
 gitrevisions                            guide
 gitsubmodules                           guide
 gittutorial                             guide
diff --git a/help.c b/help.c
index 973e47cdc30..a7b5c909056 100644
--- a/help.c
+++ b/help.c
@@ -37,6 +37,7 @@ static struct category_description main_categories[] = {
 	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
+	{ CAT_userformats, N_("User-facing file formats") },
 	{ 0, NULL }
 };
 
@@ -422,6 +423,16 @@ void list_guides_help(void)
 	putchar('\n');
 }
 
+void list_user_formats_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_userformats, N_("The user-facing file formats are:") },
+		{ 0, NULL }
+	};
+	print_cmd_by_category(catdesc, NULL);
+	putchar('\n');
+}
+
 static int get_alias(const char *var, const char *value, void *data)
 {
 	struct string_list *list = data;
diff --git a/help.h b/help.h
index 9d383f1a0b2..d01908078dc 100644
--- a/help.h
+++ b/help.h
@@ -22,6 +22,7 @@ static inline void mput_char(char c, unsigned int num)
 void list_common_cmds_help(void);
 void list_all_cmds_help(void);
 void list_guides_help(void);
+void list_user_formats_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 91b68c74a15..6a20a7303f8 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -41,6 +41,8 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -g add &&
 	test_expect_code 129 git help -a -g &&
 
+	test_expect_code 129 git help --user-formats add &&
+
 	test_expect_code 129 git help -g -c &&
 	test_expect_code 129 git help --config-for-completion add &&
 	test_expect_code 129 git help --config-sections-for-completion add
@@ -78,9 +80,15 @@ test_expect_success 'git help' '
 	test_i18ngrep "^   commit " help.output &&
 	test_i18ngrep "^   fetch  " help.output
 '
+
+test_expect_success 'git help -a' '
+	git help -a >help.output &&
+	grep "^Main Porcelain Commands" help.output &&
+	grep "^User-facing file formats" help.output
+'
+
 test_expect_success 'git help -g' '
 	git help -g >help.output &&
-	test_i18ngrep "^   attributes " help.output &&
 	test_i18ngrep "^   everyday   " help.output &&
 	test_i18ngrep "^   tutorial   " help.output
 '
@@ -101,6 +109,12 @@ test_expect_success 'git help succeeds without git.html' '
 	test_cmp expect test-browser.log
 '
 
+test_expect_success 'git help --formats' '
+	git help --user-formats >help.output &&
+	grep "^   gitattributes   " help.output &&
+	grep "^   gitmailmap   " help.output
+'
+
 test_expect_success 'git help -c' '
 	git help -c >help.output &&
 	cat >expect <<-\EOF &&
-- 
2.34.1.929.ge922d848c7a

