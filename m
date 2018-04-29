Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79331F42F
	for <e@80x24.org>; Sun, 29 Apr 2018 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeD2ST1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:19:27 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33320 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754080AbeD2STN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:19:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id m18-v6so9376470lfb.0
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXyAApOVnG83dSaAbEkLdx14DSDcpqQoxL2NVZixFPo=;
        b=sltEwK6ZxYhMxxeInuHhtlglsHLPwDmUgZyZQaEqT6OvuPhQdzfovDywS1BQi35o5h
         MsTL+VZJyepyBmOeDC0aaKlY4/ii4SDFiexTiILxA0ymX2OhPkgrIuwji5gj+2rMCqe5
         /0nHvlO3UKfVBBVCZxuVILHIfmIFyBm+NF7DWIS4VwhHtWSsK203Fwmzgf78nxhs8dcj
         bFia6BJw3wp8kgGD0rh4ZWQidLoQdw1ECVYIoFcRKLcQ5DrH+HsIfMX65+TRiP6r0Yf9
         kuXsyvhpI+wr+oUvxLDZ18zCVL7zq4oDxzwxwTkae4kN1oyoo9pbf9warGvplq8IWjTS
         mjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXyAApOVnG83dSaAbEkLdx14DSDcpqQoxL2NVZixFPo=;
        b=gUkbsdQUVkwwJz3B2JeN1reYnfcqQNRy4zaeS4G3NlgArq2JQOAn6P7RhpctIBbZdP
         ri6iBAzmso4NMmCPGwEwSL3ASAGBlvNTa2pzVn8CxGQ+eD+nRkuC+2f3IPzlap9gpF9o
         2rvdc8nE2gDF2nSPcCuNXzUYv6sIHpV3kr1EsyngDLuWib9ja9OU9DN4mF62NfH0XhoJ
         GNGsmCwDSdt1SXy7DIUWFm7F0bzw85b4Bx6xmcQrW6WzmVGzuhVm8IkN47zgoYJBHZ7b
         wnOXL4ZN0zHnLSEdZ675VbwaOCGVKfrUaa4tjszqt16zjfR7YUSDMTgcTSV2tXndd+BH
         kWUg==
X-Gm-Message-State: ALQs6tD/qIHnw9ueKCw0/WRaz5nkTvrCFa3jl+xAbqxJbcqwq48BrP4a
        8dpjnsTCP/2rvGj7e4a1EAk=
X-Google-Smtp-Source: AB8JxZr+sT0pt5B+U8zdop3wnkUsQi9glCF4fQIjgbvF4SQvn34YaPRdF4lFp9L1gs7dqkOVpHJq4A==
X-Received: by 2002:a2e:95d6:: with SMTP id y22-v6mr6025200ljh.90.1525025952170;
        Sun, 29 Apr 2018 11:19:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r78-v6sm975376ljb.20.2018.04.29.11.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 11:19:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v5 08/10] help: add "-a --verbose" to list all commands with synopsis
Date:   Sun, 29 Apr 2018 20:18:42 +0200
Message-Id: <20180429181844.21325-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.664.g8924eee37a
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180429181844.21325-1-pclouds@gmail.com>
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
 help.h                     |  1 +
 t/t0012-help.sh            |  9 +++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

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
index 2d51071429..83a7d73afe 100644
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
index 156dde1bea..f9da0214f1 100644
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
@@ -351,6 +362,11 @@ void list_cmds_by_category(const char *cat)
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
index 752368840a..090d46ba01 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds_help(void);
 extern void list_all_main_cmds(void);
 extern void list_all_other_cmds(void);
 extern void list_cmds_by_category(const char *category);
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
2.17.0.664.g8924eee37a

