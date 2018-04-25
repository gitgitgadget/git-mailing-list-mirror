Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AA91F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755758AbeDYQcC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:32:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38383 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755391AbeDYQbe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id z130-v6so26393213lff.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5wZDShF1sAMxgMuCaRsrO926tf02iRunChJXTH4b4U=;
        b=mM9LI+yq3AHWE8eziyCDPWoFv6raXP/tqyPUvrTR0aCBr1icBDwuFnVc2nplstkdnS
         4J543Ze8t3PgCEkM4Nql3hwiqSF1iXB8zyxc6mRrsIerZ67sZGhgHkj+TbaVPvajhXzz
         KMiYCnDjtP6De9xvHROcwDbnXkPCakhMbmB/clIUGGqN2V/6v9cT/Qhe1vNgJcXTSWuG
         JOMlRpOhPCdNo4bWhHdpgt07RmSMvy9RGyXXcovrfaTCY804Qjo+xCb5FxGlwDOc+umr
         g5mpGGe01Kq7bvUQfVYLCAZWen2+bciDT24RPPum7vhCFmksLzB2iJjGIIU24htN6kFJ
         yvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5wZDShF1sAMxgMuCaRsrO926tf02iRunChJXTH4b4U=;
        b=fk+pyMEagdTNMBVRW14HmtnurrhmoWe+1DqvzidU11952xU0m8XsXq94lG3vTRKxP1
         go0LAzLsmEIPfWYNSaWMR4ubkza37F/XBoTamWMjxUtNqEBJ9WBv8vuXuFv8dgOTNrGD
         TMjb68nVOQynXETICdfWUZsnMT6R3+GRUYYGnuQ3hfYfWPG8f5oElOtkJzK9Cb8QZZfM
         ds+PaFShEgoeYUYVrVFwn4/Y2oXPwpZSNixFS1i0yXF9YXPswtEhJv8522J3kvfW0bU+
         ivivv8+S9R7P/GZVDnhCfAdGM5GHWZ1SGQ2RnXqV0o8S8uTe3IE9H5ijXSf43d1vDL4c
         RiDg==
X-Gm-Message-State: ALQs6tD+Cf/Vx28ek266x2vdqwl4oiUHGJEE403pzQGLsyVyNPBKdTRr
        YdHJcA9ZtZBjEJHoQxdfBgteQg==
X-Google-Smtp-Source: AB8JxZpSkeD4aF/vX4GtXieQdgN5QOv+mQXsO1U27lg14s3t86GQ4DJF3MthQsD1WRLw+IjO+al7EQ==
X-Received: by 10.46.151.206 with SMTP id m14mr975189ljj.102.1524673893234;
        Wed, 25 Apr 2018 09:31:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 05/12] git.c: convert --list-*builtins to --list-cmds=*
Date:   Wed, 25 Apr 2018 18:31:00 +0200
Message-Id: <20180425163107.10399-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if these are hidden options, let's make them a bit more generic
since we're introducing more listing types shortly.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 12 +++++++-----
 t/t0012-help.sh                        |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..3556838759 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3049,7 +3049,7 @@ __git_complete_common () {
 __git_cmds_with_parseopt_helper=
 __git_support_parseopt_helper () {
 	test -n "$__git_cmds_with_parseopt_helper" ||
-		__git_cmds_with_parseopt_helper="$(__git --list-parseopt-builtins)"
+		__git_cmds_with_parseopt_helper="$(__git --list-cmds=parseopt)"
 
 	case " $__git_cmds_with_parseopt_helper " in
 	*" $1 "*)
diff --git a/git.c b/git.c
index 3a89893712..28bfa96d87 100644
--- a/git.c
+++ b/git.c
@@ -223,11 +223,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
-		} else if (!strcmp(cmd, "--list-builtins")) {
-			list_builtins(0, '\n');
-			exit(0);
-		} else if (!strcmp(cmd, "--list-parseopt-builtins")) {
-			list_builtins(NO_PARSEOPT, ' ');
+		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
+			if (!strcmp(cmd, "builtins"))
+				list_builtins(0, '\n');
+			else if (!strcmp(cmd, "parseopt"))
+				list_builtins(NO_PARSEOPT, ' ');
+			else
+				die("unsupported command listing type '%s'", cmd);
 			exit(0);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 487b92a5de..fd2a7f27dc 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -50,7 +50,7 @@ test_expect_success "--help does not work for guides" "
 "
 
 test_expect_success 'generate builtin list' '
-	git --list-builtins >builtins
+	git --list-cmds=builtins >builtins
 '
 
 while read builtin
-- 
2.17.0.519.gb89679a4aa

