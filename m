Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC841F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbcHPQV2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:21:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33893 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcHPQVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:21:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so17290925wma.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 09:20:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiHkp5yP0l912nohVnrknxWKbbHtlleMcqMV0Utpr7Q=;
        b=VlE1I8g3fbh5rkA2zgNwfnz8Bw+2Vt25ggG4QnTqjK6HgP0A6UzbpTbam1S/IZNyil
         iePyQ39s8+/hsA8gbS0vefwy/AhhQaLYoTVE2xt5YgVxDsQRx/sj6CXkzv9erjHMF4Gq
         ffcoMpSJo5pbQMKR+sry2fD1IB5DbtUMhzTdHjW0FutcW8BmloXV+//85px3Veh9MgAP
         VNRlTJGcK9TRNZ+VRHVKzy3pa+0uZ74W9WMct9jJ88stnCPUE/3O50u49WWDYNZ4Q2WT
         8TJBtgFphQSw5SThBrml9poOOjwet5sETn00ytdbRaT/OCC1YeEd2GTPmYcQUHVf74vn
         oFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uiHkp5yP0l912nohVnrknxWKbbHtlleMcqMV0Utpr7Q=;
        b=GDDsIsufwz5snwTQyJw8mrv3F1KzIPqyNWwn+WUQ5ntS7tqUDP1gdx+82DnnktzBJZ
         a68K/Y8tAcRG5sgIZisxnWnbMrLKw0DGpLp0GosN2TrQ4d94UEqj9TKQWu773ouIJLr1
         LTRxwEgP6RIL/X71P8AskrAgmjidI9rdZkmElV5ycS+fSz7wZ8QiDl5XZH6TyCBin1sO
         uy7IqDLr3i40+xYiWWE3IxCTb96cyLrB+utNA/cSm6X6jIPgQBipnkF3xxaM0m9gW4pr
         AmwJS+Boxv2zjRlJZjdhhF9Y3cJyWON8akwbckfwf4pnZ+iwYWnDbRNOfm9Y1yq6tOED
         Kmzw==
X-Gm-Message-State: AEkoouvN+cZW/BibFQYWH7pTmxrnFZvGrC8B+03zE1l7Uiq4q3avbUw2OoAam9to0N9R2w==
X-Received: by 10.194.105.201 with SMTP id go9mr38320189wjb.177.1471364433643;
        Tue, 16 Aug 2016 09:20:33 -0700 (PDT)
Received: from localhost (cable-86-56-49-178.cust.telecolumbus.net. [86.56.49.178])
        by smtp.gmail.com with ESMTPSA id yz6sm27417362wjb.35.2016.08.16.09.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2016 09:20:33 -0700 (PDT)
From:	Ralf Thielow <ralf.thielow@gmail.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
	philipoakley@iee.org, john@keeping.me.uk,
	Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3] help: make option --help open man pages only for Git commands
Date:	Tue, 16 Aug 2016 18:20:30 +0200
Message-Id: <20160816162030.27754-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.g69c5047
In-Reply-To: <20160815053628.3793-1-ralf.thielow@gmail.com>
References: <20160815053628.3793-1-ralf.thielow@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If option --help is passed to a Git command, we try to open
the man page of that command.  However, we do it even for commands
we don't know.  Make sure it is a Git command by using "help_unknown_cmd"
which is even able to assume a command if the user made a typo.

This breaks "git <concept> --help" while "git help <concept>" still works.

As "<cmd> --help" will internally be turned into "help <cmd>",
introduce the hidden option "--swapped" in order to know which
version has been called.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Thanks, all, for the help!

Changes since v2:
- don't check for common guides as the list is very incomplete
- only check for git commands when called via <cmd> --help (introduce
  option --swapped for that), as suggested by Junio
- change test case to check for --help being passed to a concept
  used as a git command

 builtin/help.c  | 30 +++++++++++++++++++++++-------
 git.c           | 15 ++++++++++++++-
 t/t0012-help.sh | 15 +++++++++++++++
 3 files changed, 52 insertions(+), 8 deletions(-)
 create mode 100755 t/t0012-help.sh

diff --git a/builtin/help.c b/builtin/help.c
index 8848013..76f07c7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -37,7 +37,9 @@ static int show_all = 0;
 static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
+static int swapped = 0;
 static struct option builtin_help_options[] = {
+	OPT_BOOL('s', "swapped", &swapped, "mark as being called by <cmd> --help"),
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
@@ -433,10 +435,29 @@ static void list_common_guides_help(void)
 	putchar('\n');
 }
 
+static const char* check_git_cmd(const char* cmd)
+{
+	char *alias;
+
+	if (is_git_command(cmd))
+		return cmd;
+
+	alias = alias_lookup(cmd);
+	if (alias) {
+		printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
+		free(alias);
+		exit(0);
+	}
+
+	if (swapped)
+		return help_unknown_cmd(cmd);
+
+	return cmd;
+}
+
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	char *alias;
 	enum help_format parsed_help_format;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -476,12 +497,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (help_format == HELP_FORMAT_NONE)
 		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
 
-	alias = alias_lookup(argv[0]);
-	if (alias && !is_git_command(argv[0])) {
-		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
-		free(alias);
-		return 0;
-	}
+	argv[0] = check_git_cmd(argv[0]);
 
 	switch (help_format) {
 	case HELP_FORMAT_NONE:
diff --git a/git.c b/git.c
index 0f1937f..71ea983 100644
--- a/git.c
+++ b/git.c
@@ -528,10 +528,23 @@ static void handle_builtin(int argc, const char **argv)
 	strip_extension(argv);
 	cmd = argv[0];
 
-	/* Turn "git cmd --help" into "git help cmd" */
+	/* Turn "git cmd --help" into "git help --swapped cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
+		struct argv_array args;
+		int i;
+
 		argv[1] = argv[0];
 		argv[0] = cmd = "help";
+
+		argv_array_init(&args);
+		for (i = 0; i < argc; i++) {
+			argv_array_push(&args, argv[i]);
+			if (i == 0)
+				argv_array_push(&args, "--swapped");
+		}
+
+		argc++;
+		argv = argv_array_detach(&args);
 	}
 
 	builtin = get_builtin(cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
new file mode 100755
index 0000000..6f700b1
--- /dev/null
+++ b/t/t0012-help.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='help'
+
+. ./test-lib.sh
+
+test_expect_success "pass --help to common guide" "
+	cat <<-EOF >expected &&
+		git: 'revisions' is not a git command. See 'git --help'.
+	EOF
+	(git revisions --help 2>actual || true) &&
+	test_i18ncmp expected actual
+"
+
+test_done
-- 
2.9.2.912.g69c5047

