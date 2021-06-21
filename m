Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA16BC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26D36124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFUW1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhFUW1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D42C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b7so1282321ioq.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iqI2Hj3r+FGYz7ZR5jm8I7em9zBvoF/bgSb0O3cwOUQ=;
        b=LugQlqIY5y286dp53h62xP5mv/1HNnPyTwexpuA29ZZ1x8pMppgnPHRb3G5CHYEyNC
         kDHHAeH9Rdbcx+P1BmH8jtQg9wxnfx6AmBxUvMljnrBVCSA2sUfD/XHnXKbiXY39S6Ug
         fc3mZu254G67ihwpJxeakqTC7hhb0vHMEjckhJ8WGtVL2qWmBRNYlxZ0QRzZoUiXai9P
         55kf1YERSOSqO0Yuy2ViVXPu2HYWXmOA0JC1bIYDnfu718h0Rkuykze+dk3o/HqZz/j3
         ppG2JGRFGX8v8ODBjkyM2gx40IyYPmjknykX2UWgeSJlsJKmD1UmsltRCslFd2WC52AA
         t4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iqI2Hj3r+FGYz7ZR5jm8I7em9zBvoF/bgSb0O3cwOUQ=;
        b=iePC3FxtRTGQIkNuciwtZbUOt1ObHbliuG3h99YdKpMgyT9NnLob6X9UE9Am8Jtv2L
         tWhs+nmWo+eeWRYnmfRJqZJumQRZEIzOHL70V6NcsnAH43+A6TxmHzi6wDtLPjsgsDed
         L6XRAFR8XiLLgaBaYjpRMKJWOgTjBBYmPV68eT8aHTUGCCaPmKnNJnhqa1/+hV8wRRkJ
         la37rViQQHH0PzYAGB6V7eas9J2aaS9jMzcOwVCnbCggFCx+LddkfVupXMNqB1o61AJ3
         SXeREYCRaB3AuX+MZPHcDVFX7gXz3PJsuD6oW/vB1colYa/s1QGR5wRKshr7vOzJDPca
         JzWQ==
X-Gm-Message-State: AOAM533PjYBtPu+MCI80RAsEjUPcOvjLj9LBjiaI07uQ/habCPzo1Tc+
        JbxoPRr27AhpX8DRgsRImTlRneRy341/UhFf
X-Google-Smtp-Source: ABdhPJycrwUyPc58p/iSFnUgFMKAg1WSXgDS+QdadbXJIhRdzZs551BwnnJjdZ9YlQrhWbt31T8b3w==
X-Received: by 2002:a05:6638:1446:: with SMTP id l6mr58311jad.14.1624314308460;
        Mon, 21 Jun 2021 15:25:08 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id c22sm10409028ioz.24.2021.06.21.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:08 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format' by
 default
Message-ID: <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the 'TECH_DOCS' variable was introduced all the way back in
5e00439f0a (Documentation: build html for all files in technical and
howto, 2012-10-23), the 'bitmap-format' document was never added to that
list when it was created.

Prepare for changes to this file by including it in the list of
technical documentation that 'make doc' will build by default.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767..7d7b778b28 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -90,6 +90,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
-- 
2.31.1.163.ga65ce7f831

