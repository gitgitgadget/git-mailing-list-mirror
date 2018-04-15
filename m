Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1741F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDOQqF (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:46:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34412 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeDOQpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:51 -0400
Received: by mail-lf0-f65.google.com with SMTP id r7-v6so11640003lfr.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5poF3PdOACskE3pg7UFiNrDDd4QUyifjcO387hbuuow=;
        b=qBTloZ0x97nnnotFP/XrR24eRVwikKersYDEu3Bp97XIFzZ+z5CcpqzOL/SAIIIzOx
         /p3XO69tTQe+ZdrqFhz0ApcaDvGqfnAey9IpkfM6yy3LcrU45SvOYAP5H2LIGe5YXZeL
         CGwHttF4HVZcvbJFaimG9P3q/kc1Pyv1KZJcR4fEqtRK6qwDjJ8lBeDnf5JmCBBff6JM
         THo9C1pIHq1hnG4BhoMV4wDkOZU9FNf+xhVIaOS0u2bbac2uwlTApbOf29+HL9CQUE+/
         FqdOtqj4abclJ9yG3Z8G553OzoxbdSH2NmubJc7Oad29ZISVmBErfccMw00Mrsa13CIk
         FHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5poF3PdOACskE3pg7UFiNrDDd4QUyifjcO387hbuuow=;
        b=DoN8DIjz5ZXK5hz5B2GJloJBQQZAenv3wjgzlJ28YrtYVx40Cj/vCSHHousFneiivf
         WDiUdKziWgBbydrq1R6wIxoiTxeswkjO7rxVafxYY6p/PHUQ4ji/ibLl9XWJaJkRTdtW
         KACixDuQv6CFodY3thfmO8cZu33ziySQjYYBuC4a8K0OjH0HJ4joOiqp0so7wYq6+E5f
         N/dtfWW+YPJzDVboORipdgBENIusJHb8qtzqaLVLt2eiaZgijjqx1MS28v1pf+sv4ZUL
         /3KyPsNPnu9X5IcgFR74u37/VV9lTm1CSC1ODidnkAQpMvVFVf7W4AVFjKgt4LTMvxC6
         fsGg==
X-Gm-Message-State: ALQs6tCSV6qs4hG/xbKNOYCMungrHoHMvk63VYz+5Q8Q6RrlHvLomKPo
        vZaTlbCgLhgSZkEYWLaXUYg=
X-Google-Smtp-Source: AIpwx49uZcogSXQeRqh/tdJv6s5eiWJ6qYcf+pveNkm1eItgvO7kwPibrrrNCRxC/j8rDt1XTftZjg==
X-Received: by 2002:a19:5c05:: with SMTP id q5-v6mr7969145lfb.14.1523810750321;
        Sun, 15 Apr 2018 09:45:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] help: add "-a --verbose" to list all commands with synopsis
Date:   Sun, 15 Apr 2018 18:42:37 +0200
Message-Id: <20180415164238.9107-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415164238.9107-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180415164238.9107-1-pclouds@gmail.com>
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
 4 files changed, 80 insertions(+), 1 deletion(-)

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
index 1523ca175c..7f72051641 100644
--- a/help.c
+++ b/help.c
@@ -284,6 +284,75 @@ void list_porcelain_cmds(void)
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
-- 
2.17.0.367.g5dd2e386c3

