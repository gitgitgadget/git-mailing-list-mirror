Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2961F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeBWXkg (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:36 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38434 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeBWXkP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:15 -0500
Received: by mail-wr0-f195.google.com with SMTP id n7so15699153wrn.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqRpEGl5lg2r2RIlAXw6q5051ZrdNM+BYigwN+h0MJk=;
        b=oH2J5jpMTcqyDZ/PGXKQUU4+zd4Twk7xzALeVBJXjNewIyJ3fqcmSF7RJ46jwUehSb
         WNzpzAcb55yo/9skSTM59PxzgVEbgRdcSeYbd8subNyOAo4cpkmbGJD80YWNfLYqQbvv
         sQylRn//KsXF/3UmCyj/Sr7IYZ8jfFRuuCUQzp0cSLL09c+eLLDJwcKtIsXigY8H8oGh
         T8Oa0v++Nqz73OTlNXzU9QtJLqX9FVqAogr8Wuzv6itWZrVp08pB6HYNQe8s8pKQvM0D
         EFeM0rfuA0e/LzhTx+8lx3NH6WXHayyOyENCJcQU/pBHdA3zhqIq0b5BVsNlB4LDiT7H
         udxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqRpEGl5lg2r2RIlAXw6q5051ZrdNM+BYigwN+h0MJk=;
        b=JifQlF6NEcZJQNSarZ2CdjYbcJLJXzvy1EIBFaUoHR/6x9+OpXyF45hXoHzrozBHM8
         3iK75Prsl6/UqvfxkdY1cOGVSYxqcXtAob69oYXHbSzS1zQ8CNch62sL/mXo8i2GxPyX
         hbqTePU/1NENw1IPxA5kinMAS6cCSXI/7kzsAsOnyu2g8pW+Mt7Zsuucweldc8az0q3G
         O3FoKtgON+B6PH122YYslZSln001HHZ4MAYN8+95XJjAQ/2YntEyEXEJ3tH1Hi91brjr
         bylDs2uLqkK0DjN/ebJlE0cb1UoQ/fRJTpHbozxpHIt2s7GHNZ50hEl8HeLztW59o01T
         27fg==
X-Gm-Message-State: APf1xPCqKYcZSKF1FTAksVZql1Rh1Xu2xe0/GG4vfWJHteXK/mASURzK
        ZBkMzDTibSM+AtCTnWCZdMBmoQ==
X-Google-Smtp-Source: AH8x225ZjyOiW6rQ2YQ7YoGP8THRQ/pFTiNOUCTPllCl8ulQvLJTwyK3F2/92Z10pJbi5Xnjf83M8g==
X-Received: by 10.223.165.67 with SMTP id j3mr3242715wrb.111.1519429214168;
        Fri, 23 Feb 2018 15:40:14 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:13 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/11] t5526: use $TRASH_DIRECTORY to specify the path of GIT_TRACE log file
Date:   Sat, 24 Feb 2018 00:39:46 +0100
Message-Id: <20180223233951.11154-7-szeder.dev@gmail.com>
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

The test 'fetch --recurse-submodules -j2 has the same output
behaviour' in 't5526-fetch-submodules.sh' fails when the test script
is run with '-x' tracing (and using a shell other than a Bash version
supporting BASH_XTRACEFD).  The reason of that failure is the
following command:

  GIT_TRACE=$(pwd)/../trace.out git fetch <...> 2>../actual.err

because the trace of executing 'pwd' in the command substitution ends
up in 'actual.err' as well, throwing off the subsequent
'test_i18ncmp'.

Use $TRASH_DIRECTORY to specify the path of the GIT_TRACE log file
instead of $(pwd), so the command's stderr remains free from tracing
output.

After this change t5526 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5526-fetch-submodules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a552ad4ead..ce44d8aa46 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -85,7 +85,7 @@ test_expect_success "fetch --recurse-submodules -j2 has the same output behaviou
 	add_upstream_commit &&
 	(
 		cd downstream &&
-		GIT_TRACE=$(pwd)/../trace.out git fetch --recurse-submodules -j2 2>../actual.err
+		GIT_TRACE="$TRASH_DIRECTORY/trace.out" git fetch --recurse-submodules -j2 2>../actual.err
 	) &&
 	test_must_be_empty actual.out &&
 	test_i18ncmp expect.err actual.err &&
-- 
2.16.2.400.g911b7cc0da

