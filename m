Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328711F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeDOQps (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:45:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43088 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeDOQpq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so18729627lfa.10
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EHmF/4CG+2ud23v8wZgO6gyDjfJAkAY4TrrRmSesuE=;
        b=YM6cuvMfMRtXDmVWg3la9fMndWAD6wJnAW/Je3zZXBqQBQM4QAT4UTYTstsp7d6NqZ
         bRTXbMjMuW10qAd68g+w0tYazmEv/LfK3F0wmrI5aAY2+5QsPYRBEtxI+WcHOqcLl9lc
         AIEgli51nXxB0jtPlob+T5xL7o/PHB34lOSQydQ0v10UkckqnHd+GcNHNOpSqXKMQzQC
         Efx1wSzrkIYdSpINFBz2cjq2woHpfpjsvsfaTwMft6sy5zA/U2ZF6ohwXZmfJLIBxJAz
         +rDZoW7JaeZxCgSWNj9K+G2sNmaLx/0FhoAtDngGM7Rx0Ahr1IBnSTz2i06mJCd+v7Pv
         H8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EHmF/4CG+2ud23v8wZgO6gyDjfJAkAY4TrrRmSesuE=;
        b=jQ1MtGqcbpnE5iFVn4o0tZumduzGGlpXcVWNYJ1Ukm9MEj07YNR79x7PrL3lMKaYFW
         Lma8SB+4Fg2sM+RpR5chrEpdaLSla15D7cGBCqWJLulNOaM4uW+kVjUf/40/7Oaen6Uj
         4a/2GbB+aeByCpaZCRXECPJnu29ug0ky3NVEnrILeWjmSM3jRAUWrHy6S+iZQ8Ap9poL
         hs/LEy6oLcChiiTKcMWlAa+yUYW7LGpdcIjJi5Kyr+9vBmO4fRmGOgmkyb5EgkxqbYcx
         IdlzOG0hQDo40UfPqjqWA4PYExmg2geTwiwPvSuLKXTuwasM1jz9lsPworz08Mgc1rnp
         HSHg==
X-Gm-Message-State: ALQs6tDykIdtGeYEh9sntdTu4dei0ola7wZ3PZuQnRuOcrmdWS55Pdhv
        elbtQllJspHl3UBdBezqCvc=
X-Google-Smtp-Source: AIpwx4/85tNmt0Hb1Tl9YDoxAGLQkyqmq514Suablw/x9i6G/4t8FIjkyVq5CQBdcCm9vIo5bGZrmA==
X-Received: by 10.46.21.86 with SMTP id 22mr7982790ljv.111.1523810745129;
        Sun, 15 Apr 2018 09:45:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] git.c: convert --list-builtins to --list-cmds=builtins
Date:   Sun, 15 Apr 2018 18:42:33 +0200
Message-Id: <20180415164238.9107-2-pclouds@gmail.com>
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

Even if this is a hidden option, let's make it a bit more generic
since we're introducing more listing types.

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
2.17.0.367.g5dd2e386c3

