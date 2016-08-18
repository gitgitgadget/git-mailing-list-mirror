Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E9C1FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 06:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbcHSGde (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 02:33:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34129 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753005AbcHSGd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 02:33:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so2167548wma.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 23:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KguB+2DtZSEj5axh9GG7vcLpRXOAp7QsgDlfbl2ovCk=;
        b=qrLmvY48QVmwr2wyjkM9GVm7UcHyf6dexV/BRcdhNvrNTY2rYmWdHUCnAF2+OeFEDR
         gJsLiNYvSPUwKZEFgc46fXRk5C6vTi79Uj9mdTI5L/iHin+J8Rh4TNjrkrE+7zbkU3fg
         Mm++4h1heS26Il+qNpxXOtYWUntCYmy0ZSFqsPES5EahjpabxmgIObGzNARqMJSd1zW2
         l+SPnmIwB3VVDmxjJ0jf/HgzYyJomzfNdiHgbQ6/7CwwD8rgFUl0QTiwrOroieMuGig/
         DrlLWU7A7pZcT0I/vm3GvbufobkbNBV7SYqTB6Hh0nFcVpZ1dzvKfZrxj9CJFbXFsx9C
         b/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KguB+2DtZSEj5axh9GG7vcLpRXOAp7QsgDlfbl2ovCk=;
        b=TB7JYBsT9d2Sc4RjNkQxv6r41oxIp3PhOYG6VLKtVu+9reCcEgi3syQvkUXtJEHPnl
         7FTyEhDUZDqhJkiNaLGJZ0TljLt27tXRZ3FGND+MRZrsX+uYy8U/IJ3e41LMt1ojZ8e7
         2TfJxaW5o2jWfpZt5zivwiW0i3BQZ9bjdov1IfgLIQXUM4Lx4/5tNtYqbsEyfOBKDLx2
         cp9IjQwbaiqqDv5yoaNB3g19ZOPMuvbCmEOd4OGj0ftbKQA2IsdizmcCGjo5OAFCsLUB
         SXdR2z74J9Bzr3FPTEjX6TqU2M9gmIkIcD/J9MATXvqbQn9uTh4v4oamJLLPDNPBW6Ja
         yQRA==
X-Gm-Message-State: AEkooutF6mhwNWjrNgC2R6KEFMoXoAyX6zE7zIRecxXHVdc9S5a2+YFFYq6x1/dbgTMssw==
X-Received: by 10.194.144.114 with SMTP id sl18mr3282512wjb.123.1471546648882;
        Thu, 18 Aug 2016 11:57:28 -0700 (PDT)
Received: from localhost (cable-86-56-90-190.cust.telecolumbus.net. [86.56.90.190])
        by smtp.gmail.com with ESMTPSA id e65sm864460wmg.3.2016.08.18.11.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 11:57:28 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 2/2] help: make option --help open man pages only for Git commands
Date:   Thu, 18 Aug 2016 20:57:19 +0200
Message-Id: <20160818185719.4909-3-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160818185719.4909-2-ralf.thielow@gmail.com>
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
 <20160818185719.4909-1-ralf.thielow@gmail.com>
 <20160818185719.4909-2-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If option --help is passed to a Git command, we try to open
the man page of that command.  However, we do it even for commands
we don't know.  Make sure it is a Git command.

This breaks "git <concept> --help" while "git help <concept>" still works.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git.c           | 15 ++++++++++++++-
 t/t0012-help.sh |  8 ++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 0f1937f..2cd2e06 100644
--- a/git.c
+++ b/git.c
@@ -528,10 +528,23 @@ static void handle_builtin(int argc, const char **argv)
 	strip_extension(argv);
 	cmd = argv[0];
 
-	/* Turn "git cmd --help" into "git help cmd" */
+	/* Turn "git cmd --help" into "git help --command-only cmd" */
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
+			if (!i)
+				argv_array_push(&args, "--command-only");
+		}
+
+		argc++;
+		argv = argv_array_detach(&args);
 	}
 
 	builtin = get_builtin(cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index e20f907..81fec90 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -18,4 +18,12 @@ test_expect_success "--command-only does not work for guides" "
 	test_i18ncmp expected actual
 "
 
+test_expect_success "--help does not work for guides" "
+	cat <<-EOF >expected &&
+		git: 'revisions' is not a git command. See 'git --help'.
+	EOF
+	(git revisions --help 2>actual || true) &&
+	test_i18ncmp expected actual
+"
+
 test_done
-- 
2.9.2.912.gd0c0e83

