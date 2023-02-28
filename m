Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331CAC64EC4
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjB1XjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjB1XjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8973199CE
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:17 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id d6so6713940pgu.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V32gHRTQe0M9ZrgiRRBu/GPgdm/6292eQEjf3fgmmsw=;
        b=EAueFSadMm2r5lpMiVTwQHJ4ApiUxAFUvFRgHVBDtQD7OdDHvXzwgif2aJpCTprkxF
         CwzYchk8SpK6dfnTGNXGgnSuzrJQYbwFcA1zW9XO9KLOUhzoZqkpjn5pWNv5veDT4y3Q
         z750AMCULwuG5agDJ9qiWMz6loqPE566sDmIlcAvzgyVwWTdn5MJiwPsHQLFkcZX9IEO
         Opd3A49lbIcYOe8rpou/4X0/V1f7Wj3S6hCMaTEp3MQ8zYo/dT3Zv3bC7wg3cnRAceJO
         tCfm2S1m9Cp39DbgoqvnkwOaWIqTdgU/Fbe2il2ng+dIWbuVGJWyXxHd0CLTKo5Ob9IJ
         1rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V32gHRTQe0M9ZrgiRRBu/GPgdm/6292eQEjf3fgmmsw=;
        b=K7sNr5bAw9FVqyEMof7hGMma5xabIVHxny1byo25BlfOTB8lKQkPVRVmuLx/iS074s
         SyvCRiqqd9wHfxKZUdr99ddhUvB8rXOsAWf2+5o2iqlcP5bwoGo5MhWRMVN3bNkzHC0F
         4UrrJLj015004xZZM6xtd6hTZo9hVUZIs5UXLA8cX0LQn8Vzg9eJxDHuOrwKDEiVaP3x
         nriln9hzjGK9xxkb9PcnMQmT7r0p1sq4l+tXOL7hBhoz6G4P6gcvVEWffnINAuOe0oWP
         FqExv4kmP6IFT2FuUryAvWCFbChHwBKK49Pi39KBzg8ZQITP+pmbxd/RxerCFtJzqw5g
         qjxA==
X-Gm-Message-State: AO0yUKXJRMyp8NuNI5/z6tpfZoEwwin7hJ3acWEl+AdIMEZTyX2mGY0f
        hs48yBqDycXks80K2sDtvck8q9ak7Go=
X-Google-Smtp-Source: AK7set+Tf+SoBntD5VEnaUccPbzvgpybPMbwE+YYdbhdmYNSZD7hAZ8jwijgmd87lZ9flWcii0Y8iQ==
X-Received: by 2002:a05:6a00:47:b0:5a9:b4eb:d262 with SMTP id i7-20020a056a00004700b005a9b4ebd262mr4209575pfk.1.1677627556958;
        Tue, 28 Feb 2023 15:39:16 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k26-20020aa790da000000b005d6dff9bbecsm6611807pfk.62.2023.02.28.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 04/20] t5551: drop redundant grep for Accept-Language
Date:   Tue, 28 Feb 2023 15:38:57 -0800
Message-Id: <20230228233913.684853-4-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit b0c4adcdd7 (remote-curl: send Accept-Language header to server,
2022-07-11) added tests to make sure the header is sent via HTTP.
However, it checks in two places:

  1. In the expected trace output, we check verbatim for the header and
     its value.

  2. Afterwards, we grep for the header again in the trace file.

This (2) is probably cargo-culted from the earlier grep for
Accept-Encoding. It is needed for the encoding because we smudge the
value of that header when doing the verbatim check; see 1a53e692af
(remote-curl: accept all encodings supported by curl, 2018-05-22).

But we don't do so for the language header, so any problem that the
"grep" would catch in (2) would already have been caught by (1).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 10b7e7cda2..29d489768e 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -103,10 +103,7 @@ test_expect_success 'clone http repository' '
 		test_cmp exp actual.smudged &&
 
 		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
-		test_line_count = 2 actual.gzip &&
-
-		grep "Accept-Language: ko-KR, *" actual >actual.language &&
-		test_line_count = 2 actual.language
+		test_line_count = 2 actual.gzip
 	fi
 '
 
-- 
2.40.0-rc0-32-ga0f05f6840

