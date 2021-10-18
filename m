Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E0C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4463360EE9
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 12:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJRMlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhJRMk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 08:40:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC648C0613EE
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 05:38:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d5so1787597pfu.1
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 05:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1VBbL7RIKZk2r4wdJaD9sjlvdV55ZnHhW55f3p9Rec=;
        b=DT+7i1stcnNcrAa4zMoj6oq/R+UO/J3G/b3cbLrsvFSSihR1ga2m5IPt9NMrE84NX/
         gZdpIwtkZDsjLtDVPhFTg2EoBwZnrmfb//HlHw4fZGy0eHXy5dU0+BrPgSchWMnf8uQ8
         /9Lm8zX6esoW5L5/sTh8ZmOn3L69GqqRnegAOZkNlbsbzYbF6Y0KyPTljR4vuhi2UKml
         mPvC1XLfl9rTDnzCFes7mib1epFkJrxw2Yoeb0mGAk7oOUyzRwsWGdfA94HnMmKbG4nn
         LNzlgfRU5N+QoBVUpdl5ESYx5ZNShtt5KXd7sQhMGAsIt/DHTUoY5GtaLTvmVpl/lZAl
         07MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1VBbL7RIKZk2r4wdJaD9sjlvdV55ZnHhW55f3p9Rec=;
        b=B4+e1LOkv+UNO9H2s+jNOIF1Nq8WvxSlQBzaw+jGU0fuc36rm0ssNJDvSsRyMUl67J
         mFXgxSb74JxWZ1p3RXuGHs3NHobtWF7emxmZsJ4CwwQg5LRheAnxfotY4e+A2m0XZENv
         Jq1vTWAJM7AwHD+gcuoyZzxIXySImjDT17b36tqeUk72fxMbq6p9M21+fcWwY8JPURDZ
         ny992ZaVtd13zn+PiXD7sT1VSfRNC675V0SZSzTLo1oOxozCA5zD/p4wgxcyNCpDfn09
         9t6QZTJutyq9OFHyRWX2VzGzJ/PP1paGp0eKsqgAIzUa9KFZzGX9uUAvU5qO2KAQwVKs
         AWow==
X-Gm-Message-State: AOAM530oJZ3EhXuWtYzE/n3WxYw6Fj7rtKjBGvgqmmHwa8O3OwOF+LJg
        6bLNdOqvzdJvIfQY7rc/3VoRKs8IpzFDuQ==
X-Google-Smtp-Source: ABdhPJx8gAZiVqvYlfHu4F9mXjqYaxjA9mdj8fKDXrJm2N/sxgx4oytPqaV6iVMvDM2PBNAFsPOBbw==
X-Received: by 2002:a63:7402:: with SMTP id p2mr23475769pgc.472.1634560717192;
        Mon, 18 Oct 2021 05:38:37 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-4.three.co.id. [180.214.232.4])
        by smtp.gmail.com with ESMTPSA id m10sm19201829pjs.21.2021.10.18.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:38:36 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, vagabon.xyz@gmail.com,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] archive: describe compression level option
Date:   Mon, 18 Oct 2021 19:38:22 +0700
Message-Id: <20211018123822.541406-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Describe the only extra option in `git archive`, that is the compression
level option. Previously this option is only described for zip backend;
add description also for tar backend.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v3 [1]:
     - add description for tar backend
     - rewrite for zip

 [1]:
https://lore.kernel.org/git/b28a55da-c74b-8061-108f-10f9df2c0d6f@gmail.com/T/#t

 Documentation/git-archive.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..ca3356d543 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -93,12 +93,19 @@ BACKEND EXTRA OPTIONS
 
 zip
 ~~~
--0::
-	Store the files instead of deflating them.
--9::
-	Highest and slowest compression level.  You can specify any
-	number from 1 to 9 to adjust compression speed and ratio.
+-<compression level number>::
+	Specify compression level. Higher values enables better ratio at
+	the expense of longer time. Supported values are from `-0`
+	(store-only) to `-9` (best ratio). Default is `-6` if isn't
+	specified.
 
+tar
+~~~
+-<compression level number>::
+	Specify compression level. The value will be passed to the
+	compression command configured in `tar.<format>.command`. See
+	manual page of the configured command for the list of supported
+	levels and the default level if this option isn't specified.
 
 CONFIGURATION
 -------------

base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
-- 
An old man doll... just what I always wanted! - Clara

