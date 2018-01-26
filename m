Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1971C1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeAZMh0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55863 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbeAZMhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id 143so991711wma.5
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQcx5/HYO0r1mLXZFHNMArekalt2I8aoUHoXsYYTJJU=;
        b=be13oCN6sSQcuCmEKcp9QSt+1jXGBy5BaolKTzxkEDCNTkOd8roiqu7Bxp2Wk4mkkO
         T88I2U8CTDpJNCjQGFC0N1Uy+Aq6J2S8t2SQFkzsk4Nh1i2jkhB5RMW/NwW2/1gwKDcu
         UTi+iZGQfP5ygH/rxb9xn8iVjSJpR88f/cHeqeK0680n4+55z9Mb2zka5j0KiEtCTZJW
         CFnBDCWHnr7nI/pCdBLRa8vov8arkW6nohMTCBaeXsD3CimrxeLt4DEkv9ZbSuIALZXt
         RlLc1LKDGGw6fognMthsioyfx/beDDiXn/ibOpPOVMU3RNjSlYfqkiuVUTBJZbbZlaz5
         lCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQcx5/HYO0r1mLXZFHNMArekalt2I8aoUHoXsYYTJJU=;
        b=hOKUTPw9+tXw+7/qMQa2qleuCgh/116hEQc3+NGWp6e+a8aiYT1vHlJF0wWm5GeMwE
         NclicAFf4wxnEzyM8aFiC9cTxiNsg0kiEWqTR5/5DhWpyZ0hXbABtfi4+yx4VyqYqMS0
         jXWS+Q1iBJi+PuNozydFVr0280A9QCqTwx1eGxtrpLKzdnooYX8klOJUMLVdjmyDLw2L
         +3KEtS/ulUdQnMqznrpiH+VqtwAp8pyaCXr7elib4IkxoPQUqKU9wJyze9noE8G27BIQ
         XoQA4kx09wE6b3ytwWEgJ6gd90lgHXxy4SaDDmWGjiYMREv4evaatOeUoXnrJnhwfq93
         gjfg==
X-Gm-Message-State: AKwxytcOYQ6WLGBJbPkeWo956+4u8+vNlKkZJnardYs1x4tpHRD+yoH9
        gq2abL7FsimvPavoVw42LzczWQ==
X-Google-Smtp-Source: AH8x227CHDz6AlwjT5sRff3Co0LBjxV3WEKAthr+3EAnZlhDLTu6auIenVEP8wN0SMM6Ct3/yt4D9Q==
X-Received: by 10.28.156.81 with SMTP id f78mr8127313wme.131.1516970241877;
        Fri, 26 Jan 2018 04:37:21 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/10] t5541: add 'test_i18ngrep's missing filename parameter
Date:   Fri, 26 Jan 2018 13:36:59 +0100
Message-Id: <20180126123708.21722-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
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
input is empty, (as it comes from /dev/null).  This also means that
this test could miss a potential breakage of 'git push --no-progress'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5541-http-push-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d38bf3247..21340e89c 100755
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
2.16.1.155.g5159265b1

