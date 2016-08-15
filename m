Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B57E1FD99
	for <e@80x24.org>; Mon, 15 Aug 2016 05:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcHOFgi (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 01:36:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36748 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcHOFgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 01:36:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so9267783wmf.3
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 22:36:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sQGXJ0N0HzewjZViVzi02hFHFRkQu5omZdvQYl/5xFY=;
        b=a4vYYgUN+/OLLvQDEpriMW+Rk1z2z3dVxWXWfVh8eFQI9tf4p/Py/HyXZopSKLC+tw
         TYrgopG4Huv9zVkxYb+Vh5fVTwm3pij5P07jBIV1pb3qb0yEk96YkLtBO2XrHCBF3RM6
         kykFzmfwZQSht/bgUrqs6m6vOw595sCYKT9mOYt06NoV2Sq8ebsFfgslV7IWm/+cGndH
         NBHLwMRfsIkV9TC6K3cf3Y2uOdQE9j3y1FK9fWCTh3083hoM53GXy8cqOSHDFOmTtI5w
         qWFJpcYu+Dnm1gaOOvCqLfJFFK7JEWq12AEQF7HtIDrmOQZZf0L9+hKHv6N/XokImoWU
         4O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sQGXJ0N0HzewjZViVzi02hFHFRkQu5omZdvQYl/5xFY=;
        b=c4oY3xElC4atUKA4+1As1fai+o5HBrluzPc5jeuHFQCkUSbv1Qln0VBWJ/UUI5Nv73
         TpzwuUePjvmQpBIGE9jEUgqJpo05zu5kvsMtozCMwtOAP5rsXPjzL/dX+5pkWfRgUmNF
         xnpoArewHPEr36vzdUMEnIxr5jjKwrhfMsgH2rZ1H/C6BqhtBbb7DJh0RyARbTemCkxF
         9Dewy7Hl9Yy95f3T1mr2DtdnH+J/6onLBI+dDSQwrNqtMjhBAbjdIe4JR7NyTIMuan2c
         4QlbcxKU0bK8o5YGra1PUrZsU/qswET6pK9I2cgYXTNXhIyVo1scPMhFjIwHvk55A5fP
         JX9g==
X-Gm-Message-State: AEkoousEbCFq6EpIYuFEmo8cT8XcaKVL7Wnvw+xizCgGecwz/7FQI1RXOUjqfpJx0Y4t0w==
X-Received: by 10.195.11.104 with SMTP id eh8mr28998665wjd.128.1471239395863;
        Sun, 14 Aug 2016 22:36:35 -0700 (PDT)
Received: from localhost (cable-86-56-34-211.cust.telecolumbus.net. [86.56.34.211])
        by smtp.gmail.com with ESMTPSA id va3sm19667909wjb.18.2016.08.14.22.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Aug 2016 22:36:35 -0700 (PDT)
From:	Ralf Thielow <ralf.thielow@gmail.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
	philipoakley@iee.org, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] help: make option --help open man pages only for Git commands
Date:	Mon, 15 Aug 2016 07:36:28 +0200
Message-Id: <20160815053628.3793-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.g51c4565.dirty
In-Reply-To: <20160812201011.20233-1-ralf.thielow@gmail.com>
References: <20160812201011.20233-1-ralf.thielow@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If option --help is passed to a Git command, we try to open
the man page of that command. However, we do it even for commands
we don't know.  Make sure the command is known to Git before try
to open the man page.  If we don't know the command, give the
usual advice.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Changes in v2:
- not only check for commands but also for guides
- use the command assumed by "help_unknown_cmd"

 builtin/help.c  | 34 +++++++++++++++++++++++++++-------
 t/t0012-help.sh | 15 +++++++++++++++
 2 files changed, 42 insertions(+), 7 deletions(-)
 create mode 100755 t/t0012-help.sh

diff --git a/builtin/help.c b/builtin/help.c
index 8848013..7d2110e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -433,10 +433,35 @@ static void list_common_guides_help(void)
 	putchar('\n');
 }
 
+static int is_common_guide(const char* cmd)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(common_guides); i++)
+		if (!strcmp(cmd, common_guides[i].name))
+			return 1;
+	return 0;
+}
+
+static const char* check_git_cmd(const char* cmd)
+{
+	char *alias;
+
+	if (is_git_command(cmd) || is_common_guide(cmd))
+		return cmd;
+
+	alias = alias_lookup(cmd);
+	if (alias) {
+		printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
+		free(alias);
+		exit(0);
+	} else
+		return help_unknown_cmd(cmd);
+}
+
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	char *alias;
 	enum help_format parsed_help_format;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -476,12 +501,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
new file mode 100755
index 0000000..0dab88d
--- /dev/null
+++ b/t/t0012-help.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='help'
+
+. ./test-lib.sh
+
+test_expect_success "pass --help to unknown command" "
+	cat <<-EOF >expected &&
+		git: '123' is not a git command. See 'git --help'.
+	EOF
+	(git 123 --help 2>actual || true) &&
+	test_i18ncmp expected actual
+"
+
+test_done
-- 
2.9.2.912.g51c4565.dirty

