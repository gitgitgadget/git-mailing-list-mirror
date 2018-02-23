Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F423F1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeBWXkg (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:36 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43346 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeBWXkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:17 -0500
Received: by mail-wr0-f195.google.com with SMTP id u49so15666395wrc.10
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ssj/LXFZYKX7mgvFf4MywixJkgdskOtA+jY2erHpbZI=;
        b=IsfwGZMmlLL0wSBVSLFTNLdxzNxIgGKbm+09jXmi+B3rZrRZBeG91uFpJgWaQ3kXY1
         M+ybrU1+u/8GYrnrcobKAg/sBJbJuMuk4w5mBgXYoyMXCNNy2KZe1exyh0FpCnbnB92J
         mS6YmzYPkRIAyDAr5KUjNZlaGbym3jt6GdKM800O4U/mfpLzr6P8zk0xYGPM0JHYOZIz
         mXxhdlgltY5gyExDGliAJ6f+ZCNw8MkhufEkhq1tyHQV7IqnWxBS6+lcliY1PLcT80nZ
         4M/1ITKoyD4+I9uMZ8btfALEEhgxwW3Eq68qsgDJiDnWrFfyp/6x7SXzcRHPQcbyziRT
         RKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ssj/LXFZYKX7mgvFf4MywixJkgdskOtA+jY2erHpbZI=;
        b=VlAAoY9HOr34GUAFCFOmTH2UUa2ZLxnsJw5mVp0niNoThKiH26Fq/zSxZRQh0NQGhe
         7mxVezgXGDVyeM4UBE/NvN96ug5glrzp+9iF+2ufQNtnOmplvgS8vjhtEaNgeMxbu9vu
         iUvtyyV40QaEWmrbdrgvWRrdONqF99jl/2jBBQ+YvCfVFPr1wIBrQ+pkJpl3VWPcVVBT
         GgvsS49pRhn8Axt4XZ8GXa9DG66g2uIcy8SD9can4rBgbuTEZDVaYG80vh6/6+wASf2g
         MWlsi1r5G5yyxMFkSodlPReKiwFQAVTsZle6haEOnXfWe67Pnz8DM9/YGbDMV3+WTFIN
         GWag==
X-Gm-Message-State: APf1xPBbOyYGmlij3rwABcMNIOZfXFpxjy555aA4sWMLCr8aQJZIF+qx
        Vv0WZvWh01MCqCHy0zoK0Ue1Ug==
X-Google-Smtp-Source: AH8x226Sp0XYTnef4YS0DyD/qnLcgxu8w4BDgP5p2Ymb44INLIiQdmEDY4EfOqxkqzVeQK+mXVNYFA==
X-Received: by 10.223.145.67 with SMTP id j61mr3248048wrj.152.1519429215908;
        Fri, 23 Feb 2018 15:40:15 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/11] t9903-bash-prompt: don't check the stderr of __git_ps1()
Date:   Sat, 24 Feb 2018 00:39:48 +0100
Message-Id: <20180223233951.11154-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test in 't9903-bash-prompt.sh' fails when the test script is run
with '-x' tracing and a Bash version not yet supporting BASH_XTRACEFD,
notably the default Bash version shipped in OSX.  The reason for the
failure is that the test checks the emptiness of __git_ps1()'s stderr,
which includes the trace of all commands executed within __git_ps1()
as well, throwing off the emptiness check.

Having only a single test checking the empty stderr doesn't bring us
much when none of the other tests do so, so remove this test for now.

After this change t9903 passes with '-x', even when running with a
Bash version not yet supporing BASH_XTRACEFD.

In the future we might want to consider checking the emptiness of
__git_ps1()'s stderr in each and every test, in which case we'd have
to mark this test script as 'test_untraceable', but that's a different
topic.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9903-bash-prompt.sh | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 97c9b32c2e..8f5c811dd7 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -735,22 +735,12 @@ test_expect_success 'prompt - hide if pwd ignored - env var set, config unset, p
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - hide if pwd ignored - inside gitdir (stdout)' '
+test_expect_success 'prompt - hide if pwd ignored - inside gitdir' '
 	printf " (GIT_DIR!)" >expected &&
 	(
 		GIT_PS1_HIDE_IF_PWD_IGNORED=y &&
 		cd .git &&
-		__git_ps1 >"$actual" 2>/dev/null
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success 'prompt - hide if pwd ignored - inside gitdir (stderr)' '
-	printf "" >expected &&
-	(
-		GIT_PS1_HIDE_IF_PWD_IGNORED=y &&
-		cd .git &&
-		__git_ps1 >/dev/null 2>"$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
-- 
2.16.2.400.g911b7cc0da

