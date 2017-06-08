Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F491FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdFHA5H (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:57:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36384 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdFHA5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:57:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id v18so2841590pgb.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xvE1LjJscTEILxhp91KxOFskKjqG67JBLl8W2dbx5Ic=;
        b=BWajbFpy1U8rbDtqjDF0wTJIlxgvcUJU3mP2GMdGzOySHOnU+hGfHfjoNhexnL/72s
         zeObim90mlqMgYxjJ+J4OIuH3p1aw1e/y2g3M3IgNDz8xd69LrZiDWzBqS2x63UiCVux
         TelizNlfMUbfJ6ElUQWgWSxjUH9fUgoAsHnj/7rH1CLuvb7tBUeIjVCMELrfc/LxP4QG
         Bw+sLy8k0Tsm/L3kFAgnNDCaa5hQoM7/qxcTMic6lsXZQt855poRNCMLvuQE2b05ghmG
         2GXkvHUeVFhctXJosw+pTV4E/RfYQx2Z7CPNGIvzJ5A/ohWTyQA7tN8N74fvp3YWiqpo
         t0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xvE1LjJscTEILxhp91KxOFskKjqG67JBLl8W2dbx5Ic=;
        b=G7bjbZADPioRgn9dFcsdHlLl131UkSK/4H1gEVBKJ5ioeoTva6wSjc3WMlEMqgitS9
         vihdJRxroQr4M0fIFg4F0i+LzbDaTHkotmjBvJlNn5iEK7YQoysj69SwawkPgNej59fS
         ws2WjzNK5UIqSGLxF3tjxbrI0Ufd8Va4vxTsTtrWAsk36ai7LH/TVl7F88urIwMCwnpo
         /eLByWtaHqcaxbAw9a25XzDVtjn0Ow3bZcFOg+9Vcq/kxwfu3pvQz45niO3dJa9zwQ0I
         IAk1jETxJxT/w25/DkYfp0GPkSExWarhqkPaS5bwo1oMTwW49BZ2U70DYnPUP9e2lnMu
         mZ4A==
X-Gm-Message-State: AODbwcBmA9o6pCDPCi/6NQNxn5lUnPECLyAoLTvlOpWh/9juUd1oyV6s
        OTLZjNTW27m6gi49KTo=
X-Received: by 10.98.219.5 with SMTP id f5mr3693788pfg.2.1496883425896;
        Wed, 07 Jun 2017 17:57:05 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id s17sm6418848pfk.112.2017.06.07.17.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 17:57:05 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 1/5] stash: add test for stash create with no files
Date:   Wed,  7 Jun 2017 17:55:31 -0700
Message-Id: <20170608005535.13080-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170608005535.13080-1-joel@teichroeb.net>
References: <20170608005535.13080-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure the command gives the correct return code

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3b4bed5c9a..cc923e6335 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,14 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'stash create - no changes' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	git stash create >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.13.0

