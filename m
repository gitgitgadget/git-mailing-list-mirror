Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46D41F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeDUQyr (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34938 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeDUQyg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id r125-v6so9229989lfe.2
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN7NKqk7v97cOyvRTjQ+5Y4DQdj3OHaVnX3mJ0RDNLI=;
        b=kdZdlvf40aRY0V13vkevjCITWkwBjYg6UxqBTqqUc3nAR5ppsqsm7ovtww5uyuUfNb
         B7L1hwXw2tujHL4FUC5mChHh2sFKAHb9/kfOmYDFR78k1/K4jr95mf0rl1fVTKiX/mfa
         CDI/kIT4e6RZE4+SXjYeZMRnGsMDfargjE/RXcruTLntlavm5R+r91+m/rIhHZEPwUoR
         8Vyv03q346pZilKSQE4epwnSshCDos4qOfOEu6h8mx5JU7cjRAaCmcxEhB2i2dlQm3DW
         PtThKQnTgUWx6JjIIdElEQ9vQ6E2WnEtN0qzAk2jTHKtA0xYM2ZNFtfjNMIzcrDUu86u
         7nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN7NKqk7v97cOyvRTjQ+5Y4DQdj3OHaVnX3mJ0RDNLI=;
        b=X6uSve4ON9SGRSsESfeF/9CFXa1TeKsSr/XwTyoC7tUqRHf14VMi8ehuYiupxQjnZE
         QgBWKCqjtBieLeNb48tyUUhd4EcKs732xg3mRpkK4r6DxP3wQPeLvUqD7Ytdq+KxmUcw
         gqcKZa1wGLZb6iCNEtqVA8EZIuYMEgq1wlCynPyvjJxhtKNv3ikXCP0JqFKDmazgwiVE
         HWB5Wy2MkU1LIHQLaQuLS/0YzyfHfC62bro7+iy1d/vLi1R37LCiR83q8lMdEScyWeIP
         bCiEVzoSVWzW/3Ytt8yxEw+ab9HFcYFttidtFNZ58/++3DVvvm4j5dAG8QHTUX7jwLq7
         sw3w==
X-Gm-Message-State: ALQs6tDxE6VRxG2wIosnRy509vchqFubD5zabBOrDCuhoRSYaXk1KXp4
        zgY3FRuVJk7ErMZfCckaBKM=
X-Google-Smtp-Source: AIpwx4+fi270V73s7sCWHDRO03zslSBOhG5JjyPZozeIKGj3E130JllqZQOqmRHbvrQmaxv4zsXdQQ==
X-Received: by 10.46.146.131 with SMTP id d3mr9523845ljh.18.1524329675240;
        Sat, 21 Apr 2018 09:54:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 5/6] help: add "-a --verbose" to list all commands with synopsis
Date:   Sat, 21 Apr 2018 18:54:13 +0200
Message-Id: <20180421165414.30051-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lists all recognized commands [1] by category. The group order
follows closely git.txt.

[1] We may actually show commands that are not built (e.g. if you set
NO_PERL you don't have git-instaweb but it's still listed here). I
ignore the problem because on Linux a git package could be split
anyway. The "git-core" package may not contain git-instaweb even if
it's built because it may end up in a separate package. We can't know
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-help.txt |  4 ++-
 builtin/help.c             |  7 ++++
 help.c                     | 69 ++++++++++++++++++++++++++++++++++++++
 help.h                     |  1 +
 t/t0012-help.sh            |  9 +++++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 40d328a4b3..a40fc38d8b 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [-g|--guide]
+'git help' [-a|--all [--verbose]] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -42,6 +42,8 @@ OPTIONS
 --all::
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
+	When used with `--verbose` print description for all recognized
+	commands.
 
 -g::
 --guides::
diff --git a/builtin/help.c b/builtin/help.c
index 598867cfea..0e0af8426a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,6 +36,7 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
+static int verbose;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
@@ -48,6 +49,7 @@ static struct option builtin_help_options[] = {
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
+	OPT__VERBOSE(&verbose, N_("print command description")),
 	OPT_END(),
 };
 
@@ -463,6 +465,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		git_config(git_help_config, NULL);
+		if (verbose) {
+			setup_pager();
+			list_all_cmds_help();
+			return 0;
+		}
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		load_command_list("git-", &main_cmds, &other_cmds);
 		list_commands(colopts, &main_cmds, &other_cmds);
diff --git a/help.c b/help.c
index 6688653f99..ae5281601a 100644
--- a/help.c
+++ b/help.c
@@ -285,6 +285,75 @@ void list_porcelain_cmds(void)
 	}
 }
 
+static int cmd_category_cmp(const void *elem1, const void *elem2)
+{
+	const struct cmdname_help *e1 = elem1;
+	const struct cmdname_help *e2 = elem2;
+
+	if (e1->category < e2->category)
+		return -1;
+	if (e1->category > e2->category)
+		return 1;
+	return strcmp(e1->name, e2->name);
+}
+
+static void list_commands_by_category(int cat, struct cmdname_help *cmds,
+				      int nr, int longest)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct cmdname_help *cmd = cmds + i;
+
+		if (cmd->category != cat)
+			continue;
+
+		printf("   %s   ", cmd->name);
+		mput_char(' ', longest - strlen(cmd->name));
+		puts(_(cmd->help));
+	}
+}
+
+void list_all_cmds_help(void)
+{
+	int i, longest = 0;
+	int nr = ARRAY_SIZE(command_list);
+	struct cmdname_help *cmds = command_list;
+
+	for (i = 0; i < nr; i++) {
+		struct cmdname_help *cmd = cmds + i;
+
+		if (longest < strlen(cmd->name))
+			longest = strlen(cmd->name);
+	}
+
+	QSORT(cmds, nr, cmd_category_cmp);
+
+	printf("%s\n\n", _("Main Porcelain Commands"));
+	list_commands_by_category(CAT_mainporcelain, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Ancillary Commands / Manipulators"));
+	list_commands_by_category(CAT_ancillarymanipulators, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Ancillary Commands / Interrogators"));
+	list_commands_by_category(CAT_ancillaryinterrogators, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Interacting with Others"));
+	list_commands_by_category(CAT_foreignscminterface, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Low-level Commands / Manipulators"));
+	list_commands_by_category(CAT_plumbingmanipulators, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Low-level Commands / Interrogators"));
+	list_commands_by_category(CAT_plumbinginterrogators, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Low-level Commands / Synching Repositories"));
+	list_commands_by_category(CAT_synchingrepositories, cmds, nr, longest);
+
+	printf("\n%s\n\n", _("Low-level Commands / Internal Helpers"));
+	list_commands_by_category(CAT_purehelpers, cmds, nr, longest);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 33e2210ebd..62449f1b7e 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds_help(void);
 extern void list_all_cmds(void);
 extern void list_porcelain_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index fd2a7f27dc..53208ab20e 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -25,6 +25,15 @@ test_expect_success "setup" '
 	EOF
 '
 
+# make sure to exercise these code paths, the output is a bit tricky
+# to verify
+test_expect_success 'basic help commands' '
+	git help >/dev/null &&
+	git help -a >/dev/null &&
+	git help -g >/dev/null &&
+	git help -av >/dev/null
+'
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.17.0.367.g5dd2e386c3

