Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEE21F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBHP5M (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:12 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:44537 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHP5J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:09 -0500
Received: by mail-wr0-f171.google.com with SMTP id v31so5199190wrc.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6l0qALuJxjOBBBI/kn/FxMyxgoJwMO8ZDL1GHQ8vMkw=;
        b=ARle1JK9U0bVzR+NWkdwkYrrEN0AyM3fqt3WBQl8qgswVS8rYBXT2OLMi3xJnVbr+w
         sQkl+6oJ58p91EYMGkfw3+EM+sRuBaXduv6hWm8a4B0psNh6w6rtuK0PBjsFYfPkJFeG
         DQ571AYUsG05XIZCQ1jtv7v29yxnw8Kk293GNSYw3uQEGC2A8FRX4YkN/XLJGMVnavmM
         8a+gLB8YjbK+YyWSwsaA3tszgmtD47plYQCVx/7xerOSa5QepfdOSpxlQs8ZVA3uIB9X
         Wk8Z8KXCpzmL0vU0JrncxsglMSl3LDHPKYso0k76CHfUDFYt3VVXV2yi0JPXOqv+XRrg
         OPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6l0qALuJxjOBBBI/kn/FxMyxgoJwMO8ZDL1GHQ8vMkw=;
        b=ICZxCyBIF8R2IckeoU8GghWx+4KcsumLdOP5i7nDAFCbd6k/vEvMOFLxSCqf3AAtBW
         bxz4PA0GpAE+Sm4jK9lcEUoaW00Yc+ymhE79l7Lfm8N7Ki1TTB68V5b9lG6Lyzy5QzQU
         kBsIfsiCz4MhlkOtD6piSuMv9Zlu1VMdva+skE5MFdwj28lN69q1V4YFmkG4BJQF7oqS
         udvibGhVWOWtTm+XA2d79Zf8Ys7T768vFhZfXDk7wB/bWHkR4bTT61ylWTLc3DkNLHhc
         1ITs1j9T8s+6PggTzdoHrCO9BxIR1SlJIz5w+FEbq6njMsaqeJe6AOzAZlApQrmSOv/R
         /NKA==
X-Gm-Message-State: APf1xPCqMRk/QmhB1p2o8AYBDYLZxHUVFjyvKsFkZHqw1FoozUqCGuYT
        d2rF6CE5ndu/T3d6vTP7MQk=
X-Google-Smtp-Source: AH8x224ZcjasdoGRTYKKfKEDhj9o8mGYuv8v/pnVRz6xAkP7TSPRhnepT0eCzLHmXf+o/0qKsFHr4A==
X-Received: by 10.223.196.237 with SMTP id o42mr1127630wrf.188.1518105428519;
        Thu, 08 Feb 2018 07:57:08 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:08 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/9] t5541: add 'test_i18ngrep's missing filename parameter
Date:   Thu,  8 Feb 2018 16:56:48 +0100
Message-Id: <20180208155656.9831-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'push --no-progress silences progress but not status' runs
'test_i18ngrep' without specifying a filename parameter.  This has
remained unnoticed since its introduction in e304aeba2 (t5541: test
more combinations of --progress, 2012-05-01), because that
'test_i18ngrep' is supposed to check that the given pattern is not
present in its input, and of course it won't find that pattern if its
input is empty (as it comes from /dev/null).  This also means that
this test could miss a potential breakage of 'git push --no-progress'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5541-http-push-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d38bf32470..21340e89c9 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -234,7 +234,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "^Writing objects"
+	test_i18ngrep ! "^Writing objects" output
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
-- 
2.16.1.158.ge6451079d

