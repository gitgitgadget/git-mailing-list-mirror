Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C89CC433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112F9611F2
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 09:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhIKJfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhIKJfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 05:35:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E8C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so2998166wms.2
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tonfJRNugWaQnE1NJWdysbaFoIv02QBwjz55j2hSIQ8=;
        b=bC5SUCysbmEDTdJGlbgVGysPZp2RKxtsJ5NSn1wm0cdw+RLwijNZFvI8mIpjWXC8n1
         p+yFbQQQ/SpGyi0qCGvKEXArnIqPlIzAZP4Q+cJ/SsoNy8lg2OW+wq8pIn5cwcvnBE3B
         32WBf+VvxFeqbnQ3XRisLyLKwDAHGzMc17rD+lxE3R3Hh6x0+MWnSyLXYYM3LRXwFk0q
         pUjktiBm2FPYaqvyIZxkGBipZKeVV4swQRVnArqCy2GQPwgWTFpAKtYx8Dl5nT1170Rk
         K0Uw8dU0zhMQPZJDBk+3LZ9YvdOJCStIwE/7xY+y4FveoXxxkv0O2TjkLKeDpW5kUQ1u
         UxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tonfJRNugWaQnE1NJWdysbaFoIv02QBwjz55j2hSIQ8=;
        b=kzdYvh+Nd4FDWKUxCjmYk+kq1UMuVkbav2RtXhEDpDgdTUGC4K1ptOHNm61xBkutyF
         jZbkZjbdvJP8l5tMF3Ell8I7MzSVCfG6nRI6qPl7qyVZCUNLQvrJk+qyq5JLyBNCXUJb
         rE09Y+tothlhzmXNSqbVx+BnXtnZ7EjY7Ly2uRNM32zel0skxm8bRHNRx7fgkQ2AXb57
         9olLxov9UJGPkHO8W4ln4O+TWH/WqAsJkj7mDzVcpSBmzUMOmH73NhaQs/w2DYNzrdVV
         hZznIOumaaqtpaHyLboPzbEvmS6YbMwN84TrwegGJlp2Il43rFRiNFff3E9BNnU6mhGK
         VmgA==
X-Gm-Message-State: AOAM5309ElwzEk3agMR3D96ivEcoRjK4cnbn0F8kBx7iyTzfbVJlEJrq
        xb04Op0XoBe1xh4XwauK3rHz7ARx9Z1WLg==
X-Google-Smtp-Source: ABdhPJwgUhjS6aDc/ydNFMS0cqw/m9b8mJ7RCx3scWprQTX1LZdYvg9J3YJibfAwZ6WPWFt0Vkvbow==
X-Received: by 2002:a1c:a747:: with SMTP id q68mr1957254wme.180.1631352867787;
        Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm1161753wrg.42.2021.09.11.02.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 02:34:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] INSTALL: mention that we need libcurl 7.19.4 or newer to build
Date:   Sat, 11 Sep 2021 11:34:17 +0200
Message-Id: <patch-v3-3.9-dce6520a5c9-20210911T092751Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without NO_CURL=Y we require at least version "7.19.4" of libcurl, see
644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30). Let's
document this in the "INSTALL" document.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/INSTALL b/INSTALL
index d593f628749..795b02b6f96 100644
--- a/INSTALL
+++ b/INSTALL
@@ -144,6 +144,10 @@ Issues of note:
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
+	  Git requires version "7.19.4" or later of "libcurl", to
+	  build (without NO_CURL). This version requirement may be
+	  bumped in the future.
+
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
 	  (with NO_EXPAT).
-- 
2.33.0.984.gea2c3555113

