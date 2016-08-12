Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931BE1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 20:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcHLUKQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 16:10:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35142 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbcHLUKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 16:10:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so4850739wmg.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 13:10:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bSG/1+Bs/X3f3oaZCnP3ftXOQTEsvAY/l2SZ/9ZyYwc=;
        b=S1GAwsvAG0qn7iaTxU103HzjRW+KAaK1ZMhf/zLYcnRHp5hldLa7oqTyzsFPf2s+Ns
         PjNioO4w1dvPyyyLb8PRlWyIkZAdjGYHgfVs112NNc43vYhbqCABx2vNdnJNZMCLqqZb
         FXzYtqpKldeCSciZcvD4zsFJLAAofZ2PNloToc5UxmZeszXJzDb/Y8cAN79pLGHAY8v1
         NVE9TurISwynGgheEL6GvSb3O+gJ8ZKCnPGObqtRy+hd3SxV83EzXbhX06oivC5VnBCq
         dIcbmwu41PnHFwgbF0fzI0dofZ9U1dVIXD2pb+bYuMz3qiun82tCUPzwNBM74FUaociX
         +RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bSG/1+Bs/X3f3oaZCnP3ftXOQTEsvAY/l2SZ/9ZyYwc=;
        b=VyR1e4n7RtgFoKhKHRoP2ZgTFYDRDoZ3noSGKGmfiSZclUrcKui/gAHTgUPmbMR1e3
         tBoBfI/aJh6wSaQ4HU/d/wyFk1U0a6h7qg6thvzolEXhZDp5QzjNohzgBLH3cvBH2IqO
         TtoFV9IiNV4Be0Q7jsgkcpf+UQa5NB25fjEmpQYx/vslP+zrLw6zIr1Z/lQjjzfLMqJj
         LRJqovJGEoH9TnpJ2NL1gmyeLnZSyil9XglNkgjNu66xhw5OjEunWk5k3XO4S/P/k+H1
         Ku70nD+UiksCBDxty87PxJEXkPG25blkg6lkAO2cS56hA82GRcqZ/q5dlqw64wSttZ5x
         OwgA==
X-Gm-Message-State: AEkoouuGEaVMCNEza5DCP0W4qP0HSlJcoZI4nEAuqJxwpl6wOa6lt09LwTvAa1pHiS2TTg==
X-Received: by 10.28.64.86 with SMTP id n83mr730027wma.52.1471032614358;
        Fri, 12 Aug 2016 13:10:14 -0700 (PDT)
Received: from localhost (cable-158-181-75-206.cust.telecolumbus.net. [158.181.75.206])
        by smtp.gmail.com with ESMTPSA id kq2sm8933914wjc.41.2016.08.12.13.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2016 13:10:13 -0700 (PDT)
From:	Ralf Thielow <ralf.thielow@gmail.com>
To:	git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
	me@jnm2.com
Cc:	Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] help: make option --help open man pages only for Git commands
Date:	Fri, 12 Aug 2016 22:10:11 +0200
Message-Id: <20160812201011.20233-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.911.g31804cd.dirty
In-Reply-To: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
References: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
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
 builtin/help.c  | 21 ++++++++++++++-------
 t/t0012-help.sh | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100755 t/t0012-help.sh

diff --git a/builtin/help.c b/builtin/help.c
index 8848013..55d45de 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -433,10 +433,22 @@ static void list_common_guides_help(void)
 	putchar('\n');
 }
 
+static void check_git_cmd(const char* cmd) {
+	char *alias = alias_lookup(cmd);
+
+	if (!is_git_command(cmd)) {
+		if (alias) {
+			printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
+			free(alias);
+			exit(0);
+		} else
+			help_unknown_cmd(cmd);
+	}
+}
+
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	char *alias;
 	enum help_format parsed_help_format;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
@@ -476,12 +488,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (help_format == HELP_FORMAT_NONE)
 		help_format = parse_help_format(DEFAULT_HELP_FORMAT);
 
-	alias = alias_lookup(argv[0]);
-	if (alias && !is_git_command(argv[0])) {
-		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
-		free(alias);
-		return 0;
-	}
+	check_git_cmd(argv[0]);
 
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
2.9.2.911.g31804cd.dirty

