Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990411F407
	for <e@80x24.org>; Sun, 10 Dec 2017 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbdLJVUm (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:20:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46130 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdLJVUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:20:38 -0500
Received: by mail-wr0-f196.google.com with SMTP id x49so15597472wrb.13
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 13:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+E4CvcY5at5vwOvoNX6XNWr38jpoNAS64PNQJfOma40=;
        b=YhyxYOgbCzTPCiM9bvb7pxhXQVGZyrDnbERDjcZIJdS5oYh/6UUawZNeCduLjb6hfz
         eZVMTE6BTH7UKnAxW5oKRRWDbYRNJdQxvG/GcPGKqMGfgecRSSeOGQRT6UQh/7fL9Ha7
         W6K6WBfZQYurh8R36NT6ENMh3TXiswXbeOAkysWTwWdSTCD7DB9WGnODbCFt95AqKvkl
         Czj5x6pbQOjCvY95LPhiH0v0U1HPe8svIECNqpXgZIZAgXaVnsRGWEzs+KgopS8sEilH
         5tggVPyD6H9jCpLdIOjd6X7iJTmMvspiNUhpuRRlVfRZ4G4/rSuf7DruUGryLRZg5phH
         pSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+E4CvcY5at5vwOvoNX6XNWr38jpoNAS64PNQJfOma40=;
        b=C6tVgi4vBilFJv3B98evUJcf5ybBCmFB9xFXVcBD7oMHZL3D5CVvLEdzJmYplKhzEq
         2xjOumG36JaekGWAMGzoe7p9Y0R2pyBTiB2+sgcX09qSVuyvoE3c8fW8G/fGP7tglwuY
         eajUtN6jJH9nWKATY8CFWalOyX3KssMLReyh62M+a0QouW1+bXWn4QgTeUMd14RYb4h8
         4CuTpePs1HL5XoCVvldpEHMOqK5qV7ZWVWc2+zALijT1k7Jwc8JaJwUnFflKi9pbJ+NA
         hVHcYj9kCPkpnJwfTI+aPqS1j60tmmvR1Khk4p/ln7WYhdz65uub4/lmbGzy6CW96uLp
         O6Cw==
X-Gm-Message-State: AJaThX6AXtF1lDAf4sb+eXFGgvHTc2bSsqiZ/TW43DXIy1TAOcbTrmwO
        nmkRDocKZp6h9W6rytHZdJSW7aKW
X-Google-Smtp-Source: AGs4zMbd9B5nNL3qblLX6XiGTwX2rZYaOKQmYhGdoMvGOgnkc8G9zaCBnRTpnZeDdiBrBlIslpKFIQ==
X-Received: by 10.223.163.133 with SMTP id l5mr35207334wrb.83.1512940836502;
        Sun, 10 Dec 2017 13:20:36 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o16sm7389608wmi.29.2017.12.10.13.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Dec 2017 13:20:35 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Date:   Sun, 10 Dec 2017 21:22:02 +0000
Message-Id: <20171210212202.28231-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103
In-Reply-To: <20171210212202.28231-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure that split index doesn't get broken, by running it on travis
CI.

Run the test suite with split index enabled in linux 64 bit mode, and
leave split index turned off in 32-bit mode.  The laternative would be
to add an extra target in the matrix, enabling split index mode, but
that would only use additional cycles on travis and would not bring that
much benefit, as we are still running the test suite in the "vanilla"
version in the 32-bit mode.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 281f101f31..c83c766dee 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,7 +39,7 @@ env:
 
 matrix:
   include:
-    - env: GETTEXT_POISON=YesPlease
+    - env: GETTEXT_POISON=YesPlease GIT_TEST_SPLIT_INDEX=YesPlease
       os: linux
       compiler:
       addons:
-- 
2.15.1.504.g5279b80103

