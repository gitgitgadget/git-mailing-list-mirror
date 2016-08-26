Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726E32047A
	for <e@80x24.org>; Fri, 26 Aug 2016 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbcHZR6y (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:58:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33297 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbcHZR6u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:58:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so231260wme.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6BMLu8cnJczjHKX94Qg1uRVoMeCKceeZg3BihEaNKM=;
        b=MdrEM6fGcVbkWeJ19/1s176WrBaAwHEG+tBzF4TqvuGsbalppPSAzmi/6Xb7OqD4vl
         +7VSfuSMwZvrw5JZjFtS1spCLJUCeksl5YdbkbuY9bFiCY3dmSQ4naN+eD1ov+RL7Nu6
         HTJsM/HeGaGFgpGjhWWU22zae04qqfAVM/go9R8VV0PT2tpXSA2U9YmaB+sIVYWv7Cjt
         CKknq1zlSGJWdoOZZvBhdm7FeS4jye1XTcPZX/xDO0glJZgMw3IqeYPPY7MMG46KMdfi
         BzoelWxtx/Obhg18vGBFmSWHSKgbXi8KO2LkQQ/4iCbt13n6Q+mUg1pTMoNxf9O/KlcQ
         FvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6BMLu8cnJczjHKX94Qg1uRVoMeCKceeZg3BihEaNKM=;
        b=VNYCiOTgT1xcNXw5RQiHO2R+fSQdR6MQhL3uwsZbFoT24A7XyZ6W9y89/C949f9OUe
         VL8xm1c/6Pxc7pb3C+2xrDtrWSphJVqqb8VhsxPozc4w3BjAO7+U4fQmVqgC3aUpbEad
         y3m/LKmrUjH6mV68C8Z/aQVWV6PFiNbYsXoFaTEYjQ3F25xv4t82VBOIQSBM7/+xmK89
         HBq7kB5Jk5EnpDceEzRYwrq4gBt/vrD4nPndB0y03TPa3IzqFB17fOKSJ7G3qQa0BXfH
         6UJMwv54cTtig3LyOM5k/tNPkyc2rZwZF7sNEYOP9dyEGVbwTQaerPjOY1tmDLpJgnqi
         7GYw==
X-Gm-Message-State: AE9vXwPFYfEZ7iQVbuWphxHidMXIvqCsURbmhkP+mBjvIA1rNV2NJoykuR7GVfPkqewp4w==
X-Received: by 10.28.47.199 with SMTP id v190mr130507wmv.28.1472234328442;
        Fri, 26 Aug 2016 10:58:48 -0700 (PDT)
Received: from localhost (cable-86-56-27-135.cust.telecolumbus.net. [86.56.27.135])
        by smtp.gmail.com with ESMTPSA id x6sm20992107wjk.26.2016.08.26.10.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 10:58:47 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        johannes.schindelin@gmx.de, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2 2/3] help: introduce option --exclude-guides
Date:   Fri, 26 Aug 2016 19:58:35 +0200
Message-Id: <20160826175836.14073-3-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160826175836.14073-1-ralf.thielow@gmail.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
 <20160826175836.14073-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce option --exclude-guides to the help command.  With this option
being passed, "git help" will open man pages only for actual commands.

Since we know it is a command, we can use function help_unknown_command
to give the user advice on typos.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
In the test script we do two things I'd like to point out:

> +       test_config help.htmlpath test://html &&

As we pass a URL, Git won't check if the given path looks like
a documentation directory.  Another solution would be to create
a directory, add a file "git.html" to it and just use this path.

> +       test_config help.browser firefox

Git checks if the browser is known, so the "test-browser" needs to
pretend it is one of them.

 Documentation/git-help.txt             |  6 +++++-
 builtin/help.c                         | 30 +++++++++++++++++++++++-------
 contrib/completion/git-completion.bash |  2 +-
 t/t0012-help.sh                        | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 9 deletions(-)
 create mode 100755 t/t0012-help.sh

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 40d328a..eeb1950 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [-g|--guide]
+'git help' [-a|--all] [-e|--exclude-guides] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -43,6 +43,10 @@ OPTIONS
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
 
+-e::
+--exclude-guides::
+	Do not show help for guides.
+
 -g::
 --guides::
 	Prints a list of useful guides on the standard output. This
diff --git a/builtin/help.c b/builtin/help.c
index e8f79d7..40901a9 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -37,8 +37,10 @@ static int show_all = 0;
 static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
+static int exclude_guides;
 static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
+	OPT_BOOL('e', "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
@@ -426,10 +428,29 @@ static void list_common_guides_help(void)
 	putchar('\n');
 }
 
+static const char *check_git_cmd(const char* cmd)
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
+	if (exclude_guides)
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
@@ -469,12 +490,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c1b2135..b148164 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1393,7 +1393,7 @@ _git_help ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--all --guides --info --man --web"
+		__gitcomp "--all --exclude-guides --guides --info --man --web"
 		return
 		;;
 	esac
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
new file mode 100755
index 0000000..fb1abd7
--- /dev/null
+++ b/t/t0012-help.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='help'
+
+. ./test-lib.sh
+
+configure_help () {
+	test_config help.format html &&
+	test_config help.htmlpath test://html &&
+	test_config help.browser firefox 
+}
+
+test_expect_success "setup" "
+	write_script firefox <<-\EOF
+	exit 0
+	EOF
+"
+
+test_expect_success "works for commands and guides by default" "
+	configure_help &&
+	git help status &&
+	git help revisions
+"
+
+test_expect_success "--exclude-guides does not work for guides" "
+	cat <<-EOF >expected &&
+		git: 'revisions' is not a git command. See 'git --help'.
+	EOF
+	test_must_fail git help --exclude-guides revisions 2>actual &&
+	test_i18ncmp expected actual
+"
+
+test_done
-- 
2.9.2.912.gd0c0e83

