Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0A72098B
	for <e@80x24.org>; Mon, 17 Oct 2016 00:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756268AbcJQA0B (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 20:26:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33095 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756171AbcJQAZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 20:25:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so8163481pfa.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ud+RbHeCtfF572KahCeCJwFtcOtSjFpcfVT0DvDSeRo=;
        b=AdGwJufsucQEkM6etOGLpgnS21cgKLlgZMNgRHDwIxOyQkUte9o3LITXVieA/fuyAB
         ep8ysVLucxaocCRVprhn1u36jeTX5Nzh7O5mDVzYpXqPazxMNCkdNKe8dSyOp+Dio3gS
         HF8Lg03SOzAcQo9G7Qc481eU4xRYKSEJZhe6ut46mSboTBwAn4RjNZ9LqGz2eAWGCUn7
         3nJu5tNVrkQ/kGgGsri7hBVJ/oObImO0s9hXQ2fBLCjpjMFrKl817GKkOJC6JxXTL9af
         ag/CJv717rAeaypvnZ3z2KGZOtSV3xuGl62uNOoS1Yhn6MMFpAfKeE6aV8TBBZqeYY5I
         fW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ud+RbHeCtfF572KahCeCJwFtcOtSjFpcfVT0DvDSeRo=;
        b=M+OZq831bkLLjWRfSADcoPc4sL1k/ej90ONCTWICJBycVQOEpIc5swybOFEUJqYMSr
         WBPZYQNo+NkuuYCRqtRihuIML2ZJ0PDiSOJqIYARbtZpyPF1d1megv5vCMD3swXC8FVg
         WBiLABi5l7008mOrMbYzRk0sv+UhIYeRjJRchGtVhanW+dTUwkLllzq37TlkVotTrCuA
         DTDABSy58o5a95AA2zzupY/w5gu1H4KujIrbb6G42E+sSQ09wK+PoS78ROio/kwb04PG
         RQMCPbwF18KUSIeKnDVsBMKR7HqZUBjaygEUorld3Ei15V2m/DPg5MEBj5Rnl0OED0mv
         eXmg==
X-Gm-Message-State: AA6/9RlwJsbCBRKeF8FQ9wEIRPovui3fvuV1d95WJnrauJMjTawCDPS3SlsNLw5/bCZSkw==
X-Received: by 10.99.146.8 with SMTP id o8mr27881856pgd.55.1476663959093;
        Sun, 16 Oct 2016 17:25:59 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id 3sm42882343pfo.31.2016.10.16.17.25.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 17:25:58 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     tboegi@web.de, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and APPLE_COMMON_CRYPTO for macOS >10.11
Date:   Sun, 16 Oct 2016 17:25:49 -0700
Message-Id: <20161017002550.88782-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161017002550.88782-1-larsxschneider@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Apple removed the OpenSSL header files in macOS 10.11 and above. OpenSSL
was deprecated since macOS 10.7.

Set `NO_OPENSSL` and `APPLE_COMMON_CRYPTO` to `YesPlease` as default for
macOS. Make it possible to override this and use OpenSSL by defining
`DARWIN_OPENSSL`.

Original-patch-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 config.mak.uname | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index b232908..f0c94a9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -108,6 +108,12 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
 		HAVE_GETDELIM = YesPlease
 	endif
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 15 && echo 1),1)
+		ifndef DARWIN_OPENSSL
+			NO_OPENSSL = YesPlease
+			APPLE_COMMON_CRYPTO=YesPlease
+		endif
+	endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.10.0

