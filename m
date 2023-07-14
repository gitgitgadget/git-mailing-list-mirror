Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A7EB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjGNGBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjGNGBk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91D2D43
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so14072075e9.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314498; x=1691906498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUOGi/S8harMIkeMlwlGX4B7j1x/qNSxJP2y5l0vrds=;
        b=nfr35yMklnU6PAVEx5zZcn8m07NqyGyICtLgYZjr/NCQbnLR14TPfXfhTGvOnj6QId
         ylY3ZTDRfupwBINnxo791GMq1UcCTN7t7zljXnK1UZAcBbyvE9Wz3n1y8h6sKGreFQx0
         tGewUR9HGjDN/6sTKorIg2O/85q357YzVfNpQPfr0BNnuna05Li6+wVqkdYQW4jIhlvV
         QpnNRgk/FYYgDOAY7/z2gA4fxoVFlPtH1nvB4XqVxW/pxckNipMLBUUwi71A3tEwTFaC
         oExRfRmDU1CxPu5IGx3QnUbxB/nV3tN/AKFjSBaz986WzAh2BAGrOLvijQ0/K9xT6Kw4
         K0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314498; x=1691906498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUOGi/S8harMIkeMlwlGX4B7j1x/qNSxJP2y5l0vrds=;
        b=SK7tOFtHaxNgpw180TpmwqH6l2YJL6x/2SdRpZB34ipVWP2JxuOkKLZ+UdiWrz81q6
         nUUYzDmmrWh1/5claHqPn4MkDdcDeKrUeC6cye9URp1P5FWxHHooE28ySwTz/PKFh3Ue
         mEnOhohbgwMe//TN+YK+NM7SrYUKH2su5+1qxi2K/1rbB/JkiB+MDafhOoOgOjUF3cDv
         jB54ifncFkkMPx3zpRsGZaItp+NbeNSvSHRvnAuSI+qwjnE98FURms2Oi69nGU0R1Cgm
         9hz5N44rP5Es2RpKoTu9R58IxLg2S30KRTayHJpH5FlPrjectKb4cP2jn2MU53lDT5Tz
         U5sA==
X-Gm-Message-State: ABy/qLYn09ViO3vG78NAkg80IQPgjVK1HPvM/YXxH0WJfUHgRrzR5vdf
        JSpZODnL6PGBwohH2B5IQJ6G5q6CLiE=
X-Google-Smtp-Source: APBJJlGqmsQ1cSYBVc9Zfqmq1Df+wFWeY+ZVF5TbQvvYgYyYr4TaPzdUxXOE6+y474vBXYIN2zcP8Q==
X-Received: by 2002:a1c:4b11:0:b0:3fa:962e:e8f4 with SMTP id y17-20020a1c4b11000000b003fa962ee8f4mr2969963wma.26.1689314497680;
        Thu, 13 Jul 2023 23:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c205100b003fc01f7b415sm587834wmg.39.2023.07.13.23.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:01:37 -0700 (PDT)
Message-ID: <08deed14d960b0b7de56a023a1da6ab5280e04bb.1689314493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 06:01:29 +0000
Subject: [PATCH v2 1/5] SubmittingPatches: reword awkward phrasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b218e273570..b89678cedc3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -3,8 +3,8 @@ Submitting Patches
 
 == Guidelines
 
-Here are some guidelines for people who want to contribute their code to this
-software. There is also a link:MyFirstContribution.html[step-by-step tutorial]
+Here are some guidelines for contributing back to this
+project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
 available which covers many of these same guidelines.
 
 [[base-branch]]
-- 
gitgitgadget

