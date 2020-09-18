Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E4C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0542085B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uky2IfV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIRAt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 20:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRAtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 20:49:25 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A02C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 17:49:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id k25so3612037qtu.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da29aZww5fnBlbQKaGT8PulIMUy9KoUU8p3h+2QxMm0=;
        b=Uky2IfV2Qrgen/LWUHvCEMybEsau2HYHDSVXklhvPytIixXF5d5m2K3wCTmHfU6IXA
         Jg+E9rJZ0oM0aOJ51qHwskJU96NeW8ap5nA/rzfc2OtW45PX6S4M1uG6fo7zQJZx9FWM
         5agkWE2juRvK/Rx3fAYgWK3MyJ9IOtidpf8Dqa/wRqYpFbBZVOC9ZZ6Xff6kQ3avBT7F
         C9e8qalTH8rzJS5GL+pxuuxrAf/YptSQpoNi7kucKAGTkt16KszbVlycDDBZogdad4Lp
         rM33mHkDLKY4cjwfp8Yn4EknamkmdjXC3Le1BaHfmXhMvX4Ok9YWwl3IgGJ/vdqlUMyX
         GASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da29aZww5fnBlbQKaGT8PulIMUy9KoUU8p3h+2QxMm0=;
        b=GxwoG0Bd352NSoANank+u5Y0CMjQw/II3DZSsaNJuEWLFtn96crJB+WxI0vKRwGWip
         P4gO+QIGY6QCIc387leP7PQtf7XMTtLov4yoExnVtAUIEI6jec2IF1cyJB0ApEON6s9U
         yhGIurMOgTmvO0C03pTexP0UrcDLaL/AH8yv3yzOiwj7LKIDWqeE38B7JXkrr/mt2BkX
         Pg74I76uWhIWCDrsWZf1zibbGDEfBiF/YWNh0w7U0YYFrD9JOfCY1P7f2LZ14C42VuUj
         Qav96E9dkBHjF3ctRKgLNFf6owuqQpRz4QYB+jpC14WRcMCiMLf9NyqNmqVRNKOJ/nMw
         owZw==
X-Gm-Message-State: AOAM532sXvOgG/ui+1fqu+G4K5b6h7m2XSNc5xqYxsYhydAp10bh0HqQ
        ivg2EU1plNWxIpT6+lNUy/hJHvbnAA+uDWTB
X-Google-Smtp-Source: ABdhPJxIwOxZnOVWRIg+OgO0kPUiF1eAmV/ODLNbQWLaayjjzI+udYrVRh/U4+7xPVV2GuNtimWAzg==
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr29440362qtv.89.1600390164198;
        Thu, 17 Sep 2020 17:49:24 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id o13sm1003686qtq.41.2020.09.17.17.49.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 17:49:23 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH 2/2] Doc: prefer more specific file name
Date:   Thu, 17 Sep 2020 20:49:09 -0400
Message-Id: <20200918004909.32474-3-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200918004909.32474-1-alipman88@gmail.com>
References: <20200916020840.84892-1-alipman88@gmail.com>
 <20200918004909.32474-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change filters.txt to ref-reachability-filters.txt in order to avoid
squatting on a file name that might be useful for another purpose.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/git-branch.txt                                | 2 +-
 Documentation/git-for-each-ref.txt                          | 2 +-
 Documentation/git-tag.txt                                   | 2 +-
 Documentation/{filters.txt => ref-reachability-filters.txt} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/{filters.txt => ref-reachability-filters.txt} (100%)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 290b90639c..ace4ad3da8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -368,7 +368,7 @@ serve four related but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
-include::filters.txt[]
+include::ref-reachability-filters.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7b9cf0ef1f..2962f85a50 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -409,7 +409,7 @@ will be reported.
 NOTES
 -----
 
-include::filters.txt[]
+include::ref-reachability-filters.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index cc667d7d01..56656d1be6 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -380,7 +380,7 @@ include::date-formats.txt[]
 NOTES
 -----
 
-include::filters.txt[]
+include::ref-reachability-filters.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/filters.txt b/Documentation/ref-reachability-filters.txt
similarity index 100%
rename from Documentation/filters.txt
rename to Documentation/ref-reachability-filters.txt
-- 
2.24.3 (Apple Git-128)

