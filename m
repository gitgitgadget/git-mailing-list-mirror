Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD1E1F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756932AbeEJIrl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35783 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbeEJIrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id y72-v6so1834909lfd.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CytcvYi6xndprx6d6BcYZHom78069XQzG0s5f4shChg=;
        b=Qj8MToDDhbgq6igl6FLhplMGHILhy4+bjpWWkU4ZtT67+y+dTLDxfbZg6UcgHHwd0Y
         GVwrPvbrzzF/oXi2B4RcJWQh/KoR9Wc3Wc24x0pIGiu+0zgv+kzWEP82UVRwZRPOvG9o
         zRJXEVULlCgSYMEc0NOktxTky/yX/bNOri/dvNJ6PmWZoJccIc7eMhzy1btdrFXRCOsr
         AqEbgjAwarX8GTaE+qIBeT7DoqmMoRR7wIuy+vEsTh/lW+KNfQ3tPdiHD71SWYqFDLKA
         1bqMUzFLPD3128tnVatuZ6bCaJvwQ5pZ5KyBUqIwwjfdW+6uFlVaZP1l8s6tXVj5Q+MF
         ZiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CytcvYi6xndprx6d6BcYZHom78069XQzG0s5f4shChg=;
        b=oE/TsU1Upi1mNkhD4fJeBtnBdPnVYerWvvjWWtdmM78FTPDk2C0k19ZRM05UGX7rO+
         SyxYm0trdAz9fq+fRMFZNXKsYVg+9p6lbpbSGl/iBbeT5O1oBPL8f7+Hog4RbmrK+uxn
         gayZ9KfEwri81siIs5oPAu/NkuFURA0pOEwsCnCB2NFKQ3jvAut7ClkXl4+iqvM8rM+p
         rp3dtpvIAeh7pmbopKSL4eoSCNgICI4COtoDZZu9nJt9969YlLUtdigcsU3TtDwVCqKh
         YGkEs7oZWTN10xpB9kqaySUeLGQXapQUd7gNEeEvbv60mAVQV0f5ibv279W3F3XBTB/S
         r1tQ==
X-Gm-Message-State: ALKqPweVlCCaRKMnb6f0PF8bWOZ8MtYMP3FPFUDf1QnO0mSMNi2Cq8l6
        gutdKPryAxeH0xMs7NUwhUU=
X-Google-Smtp-Source: AB8JxZrwb00aZ5WlJT6IZpvSMqa2iJm48Mm8pEQi2UuDzsp+Oqgh/QBwNH5fHCCwl0RJN6Nt88aDWw==
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr491165lja.100.1525942028923;
        Thu, 10 May 2018 01:47:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 09/13] help: add "-a --verbose" to list all commands with synopsis
Date:   Thu, 10 May 2018 10:46:48 +0200
Message-Id: <20180510084652.25880-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
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
 Documentation/git-help.txt |  4 +++-
 builtin/help.c             |  7 +++++++
 help.c                     | 16 ++++++++++++++++
 help.h                     |  2 ++
 t/t0012-help.sh            |  9 +++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)

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
index 1117f7d1d1..c7df1d2338 100644
--- a/help.c
+++ b/help.c
@@ -27,6 +27,17 @@ static struct category_description common_categories[] = {
 	{ CAT_remote, N_("collaborate (see also: git help workflows)") },
 	{ 0, NULL }
 };
+static struct category_description main_categories[] = {
+	{ CAT_mainporcelain, N_("Main Porcelain Commands") },
+	{ CAT_ancillarymanipulators, N_("Ancillary Commands / Manipulators") },
+	{ CAT_ancillaryinterrogators, N_("Ancillary Commands / Interrogators") },
+	{ CAT_foreignscminterface, N_("Interacting with Others") },
+	{ CAT_plumbingmanipulators, N_("Low-level Commands / Manipulators") },
+	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
+	{ CAT_synchingrepositories, N_("Low-level Commands / Synching Repositories") },
+	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
+	{ 0, NULL }
+};
 
 static const char *drop_prefix(const char *name)
 {
@@ -352,6 +363,11 @@ void list_cmds_by_category(struct string_list *list,
 	}
 }
 
+void list_all_cmds_help(void)
+{
+	print_cmd_by_category(main_categories);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 734bba32d3..40917fc38c 100644
--- a/help.h
+++ b/help.h
@@ -19,6 +19,8 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds_help(void);
+
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
 extern void list_cmds_by_category(struct string_list *list,
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 3c91a9024a..060df24c2d 100755
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
2.17.0.705.g3525833791

