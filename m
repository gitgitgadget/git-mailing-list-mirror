Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D69203EC
	for <e@80x24.org>; Fri, 19 Aug 2016 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbcHSAvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:51:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34232 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbcHSAu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:50:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so1543052wma.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMpganufYaZ4Fy2hXWUTLUjdmS/VgWWcyQiYqs8vxiY=;
        b=PKGyBkDgUEt0zhOjmFfu2I1WJnWUNp2g3tJ/r+8El2v4qhlnbvHOuAusxnLvczwPVc
         1OIsz/vyQO8FwCDhdAX4HpI/SiYtyRXL9TL52qW+xrg0Df92bii88pJjkHmEMTpDIH7J
         gEovQ1SEbBFcUYz3jIHIjGN7hUs0uy9Q1mo0nFuFr81rTMv8zaLfUvqTJrV39rU1GF2R
         KpGRdNmGPBNjl4JTB7wP0MtHllpC+J4C5rfXtWw9RTG6r3n8wlKeVIQf7U3uxhqvC6zG
         w9adIVI/GTvwkb6Je25E6eQ9K/oNmtaE34Xa7YGHNoGrqeYZISowbqeJrCiotlDk3a+S
         QdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LMpganufYaZ4Fy2hXWUTLUjdmS/VgWWcyQiYqs8vxiY=;
        b=fLIvjcGc75+VcooQKlAP+zBqGRgwBcnj45SKF2gsodsBrqqHFjR6Ha6mnkcQ9MdlMa
         SqJkO9GvvY2HOjCU3S2Dmt07sNjEPOkwMNisDtKamZsa0zYlfskcl0GnYfX444u+staE
         91UQ8VPvmjaZGLrGS3tiE8CWacsyYlOhQYTUnmHDFvQJElqee12ez55JrCwCKnqTTT1V
         sSHe2zyI6LpV4oETXDnjAttS2BVYln/3jWh/hLGATT8XXdluYCcH6GhbCgrZqe5feuiL
         OqanHSMxDubJj2HuFhCZBbt1TQwORSmRf6CKlaMhOVPIQygc3NtzsFeiDH1d5aFHixIk
         orOw==
X-Gm-Message-State: AEkoousVbm2bKpj4N/CkE9lWLBHRQwR0Wk800F627QtCYp9euqkhuCjcCD9nXdCD7Hyy6g==
X-Received: by 10.28.238.88 with SMTP id m85mr772403wmh.92.1471546647422;
        Thu, 18 Aug 2016 11:57:27 -0700 (PDT)
Received: from localhost (cable-86-56-90-190.cust.telecolumbus.net. [86.56.90.190])
        by smtp.gmail.com with ESMTPSA id b203sm822922wmh.20.2016.08.18.11.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 11:57:26 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 1/2] help: introduce option --command-only
Date:   Thu, 18 Aug 2016 20:57:18 +0200
Message-Id: <20160818185719.4909-2-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160818185719.4909-1-ralf.thielow@gmail.com>
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
 <20160818185719.4909-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce option --command-only to the help command.  With this option
being passed, "git help" will open man pages only for commands.

Since we know it is a command, we can use function help_unknown_command
to give the user advice on typos.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
I am not sure about the first test case, but I think it'd have
prevented me from making earlier mistakes of this change. That's
why I added it.
Just calling a git command that succeeds in a test isn't really
a check, so ... I dunno

 Documentation/git-help.txt             | 11 ++++++++---
 builtin/help.c                         | 30 +++++++++++++++++++++++-------
 contrib/completion/git-completion.bash |  2 +-
 t/t0012-help.sh                        | 21 +++++++++++++++++++++
 4 files changed, 53 insertions(+), 11 deletions(-)
 create mode 100755 t/t0012-help.sh

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 40d328a..cf6a414 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [-g|--guide]
+'git help' [-a|--all] [-c|--command-only] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -29,8 +29,9 @@ guide is brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
-Note that `git --help ...` is identical to `git help ...` because the
-former is internally converted into the latter.
+Note that `git --help ...` is almost identical to `git help ...` because
+the former is internally converted into the latter with option --command-only
+being added.
 
 To display the linkgit:git[1] man page, use `git help git`.
 
@@ -43,6 +44,10 @@ OPTIONS
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
 
+-c::
+--command-only::
+	Display help information only for commands.
+
 -g::
 --guides::
 	Prints a list of useful guides on the standard output. This
diff --git a/builtin/help.c b/builtin/help.c
index 8848013..2249a67 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -37,8 +37,10 @@ static int show_all = 0;
 static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
+static int cmd_only;
 static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
+	OPT_BOOL('c', "command-only", &cmd_only, N_("show help only for commands")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
@@ -433,10 +435,29 @@ static void list_common_guides_help(void)
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
+	if (cmd_only)
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c1b2135..354afe5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1393,7 +1393,7 @@ _git_help ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--all --guides --info --man --web"
+		__gitcomp "--all --command-only --guides --info --man --web"
 		return
 		;;
 	esac
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
new file mode 100755
index 0000000..e20f907
--- /dev/null
+++ b/t/t0012-help.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='help'
+
+. ./test-lib.sh
+
+test_expect_success "works for commands and guides by default" "
+	git help status &&
+	git help revisions
+"
+
+test_expect_success "--command-only does not work for guides" "
+	git help --command-only status &&
+	cat <<-EOF >expected &&
+		git: 'revisions' is not a git command. See 'git --help'.
+	EOF
+	(git help --command-only revisions 2>actual || true) &&
+	test_i18ncmp expected actual
+"
+
+test_done
-- 
2.9.2.912.gd0c0e83

