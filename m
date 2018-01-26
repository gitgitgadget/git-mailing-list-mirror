Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD051F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeAZMhZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34952 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeAZMhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id r78so20984312wme.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/72yzpSdh1YuihG1jxU1AMUzF59MLaKvQUTWP8b1RQ=;
        b=r2wW+HT6po4qb5o4XP5FsGsjzjwFNyKNmHj/8vzy/Wnu6aHbHC2TxokPIG9Dg04Zkq
         rET1ZGW/0F/0pdZhUrOR943hX61/HlkKwA9fOMWiH7MtiZ+7HPmJyqwFOxq9d9JQjPqA
         ccJhRx1lMq4CdBp34oAjPKDJOglQTWshcU7/qkPf288EBiUxPwcp3jLLydlGpZ8aef4u
         hcZTpNimmvqovOIH7iJLKm+s9J2KD3nJqwryWUBjii82s9nyG2TycjDhQ+sSB3RR85QD
         tIv4wgPRoCc4fUyzvSUIpA1GlGb/FCHHTTbgL5LYFrQagsfu4Qlk2cvYlHvyXV83wgiQ
         u/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/72yzpSdh1YuihG1jxU1AMUzF59MLaKvQUTWP8b1RQ=;
        b=eqGzXmvZLQz6ang6YkVHLXwIs8M54Cvo+EJ9yEqmQCoenllWExCIXRGYMFcDZv8RjI
         kOIY2NplpvHfwBL72MtPMGApJeTTDXVYUGZt9vTZqwXnBlT0bXDJNwenYuS+5gPIotuD
         ya7Q1P9aXcItxgMBgPHhl77F4svfd8gvdqjAPkNQzki9f3WymC6rLw9JTwV3Hb0X3GYw
         w+8jAeye1hZz7b9/Ms0inkpz+1WiIDKVbTLsVG5NMaRF0KMcuyxjjz1TTpMd7e8zJehY
         YDpMfLAMXNZmwR1y1B4Tvmwc4b13OKRa+M2kBwY31y0Lw95GnfCFnHjznXqaoLVjLEM3
         Gjog==
X-Gm-Message-State: AKwxytfkZcYIK2WHVWNkTkqJ2tEQ89+cp4zDCT0Yi8zkZCMuKwBv/92Q
        UzH3nD0/GyrivnaciEWVtvZu7Q==
X-Google-Smtp-Source: AH8x226oMSSw/xf2DLR+5Y/FyUcru41jO76ZNotYp7c1mEOfzicvTist0CHKLLPDTv7himj44LX6tw==
X-Received: by 10.28.52.9 with SMTP id b9mr11515559wma.114.1516970242972;
        Fri, 26 Jan 2018 04:37:22 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/10] t5812: add 'test_i18ngrep's missing filename parameter
Date:   Fri, 26 Jan 2018 13:37:00 +0100
Message-Id: <20180126123708.21722-3-szeder.dev@gmail.com>
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

The second 'test_i18ngrep' invocation in the test 'curl redirects
respect whitelist' is missing its filename parameter.  This has
remained unnoticed since its introduction in f4113cac0 (http: limit
redirection to protocol-whitelist, 2015-09-22), because it would only
cause the test to fail if Git was built with a sufficiently old
libcurl version.  The test's two ||-chained 'test_i18ngrep'
invocations are supposed to check that either one of the two patterns
is present in 'git clone's error message.  As it happens, the first
invocation covers the error message from any reasonably up-to-date
libcurl, thus the second invocation, the one without the filename
parameter, isn't executed at all.  Apparently no one has run the test
suite's httpd tests with such an old libcurl in the last 2+ years, or
at least they haven't bothered to notify us about the failed test.

Fix this by consolidating the two patterns into a single extended
regexp, eliminating the need for an ||-chained second 'test_i18ngrep'
invocation.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5812-proto-disable-http.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index d911afd24..226a4920c 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -21,8 +21,7 @@ test_expect_success 'curl redirects respect whitelist' '
 			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
 	{
-		test_i18ngrep "ftp.*disabled" stderr ||
-		test_i18ngrep "your curl version is too old"
+		test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr
 	}
 '
 
-- 
2.16.1.155.g5159265b1

