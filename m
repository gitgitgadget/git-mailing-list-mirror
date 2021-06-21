Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D40C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C3961108
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhFURBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhFURBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:03 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF19C061787
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:46 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so2965648oos.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erQeQ0mydMl7JVGKvU1fBxUQnmPTFqD9sNT7Zkq0MJI=;
        b=nMr6VxPBR5rVJIG32H176BbXbj+MII02gx2RFkSVVVFLAc95LJSpNs2hQIb2nWgf4t
         M0hPStgmkDANP2z+Ib0oDRJRRN6FFQYNthPleJ/g5XiSKuCUB92Fi69DRILCbMuHe1p9
         sXDtc8Q3mmFK7YyW5qibCDQKErLnEH3eww5wkydQ2A5GRXUhXhxMpwlz3b9Jy2cEAH58
         uq69kkj8MpsjSRHIVGcwU+KB3Zx4wvgh6ov1RHIlxBmpX0EE4mSAGrbFa4N7rQMSRdnM
         KeAXuvkC+7sOKESi79B6RVrArcC7nlbUe35DrAQ0VpFusexvLKCPZIZBZWJW5YBHTfmO
         QHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erQeQ0mydMl7JVGKvU1fBxUQnmPTFqD9sNT7Zkq0MJI=;
        b=B65MiJ2nd6Z4ceyBi85JQth3QKcFl3lAbVh4Mlt0Y9lFnAZDgQjdL1hAaMF1vp1C2D
         CGgQvwuOKJ110Okt6KjzOSy1CUspIbZ/XkaLyEDWGjtCOWeayPPjyGAXLaWxGCrOrPbU
         0YqAwdBGp5lp/4cX2fJ1l3t7DROtpz6jtALHL0hrWW001loNhvJl4MK2i3itA8Nz6cOy
         F6LC634EEoL9kZLdxjo2oFy9GWJ0CskpvWIAgO+wot5GC4zl7OCp2BAFUes8VwYQprwh
         nYVserQsCCjjYeHSDWeFNILCV+aDbDYzzNEh2bXSLDlbqDGVzF4VhtlJlenLPOH6c3n+
         liWg==
X-Gm-Message-State: AOAM533bnfJLYbtXHaz4Y3HLYXblctg86+olzqZ0zLqsk7aJ+GNRGDez
        1Rr/sMUiO31tVRMzZDKFsFUJK+v3Xo/Osw==
X-Google-Smtp-Source: ABdhPJz6FWN1O6IFXHg+wDRxYFQGCSiY1H3vJ2/kUfE/NWs3xmpl/dLt1OMGrh/thnkbF26J2bpWEg==
X-Received: by 2002:a4a:97ab:: with SMTP id w40mr21474402ooi.19.1624293105463;
        Mon, 21 Jun 2021 09:31:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s123sm2272338oos.12.2021.06.21.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/23] doc: asciidoctor: specify name of our group
Date:   Mon, 21 Jun 2021 11:30:59 -0500
Message-Id: <20210621163110.1074145-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doesn't do anything, but otherwise we get a random name.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 51981af13c..b36317e4d2 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,6 +1,6 @@
 require 'asciidoctor/extensions'
 
-Asciidoctor::Extensions.register do
+Asciidoctor::Extensions.register :git do
 
   doc = document
 
-- 
2.32.0

