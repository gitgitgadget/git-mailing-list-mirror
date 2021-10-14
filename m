Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5151C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 12:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905E46101D
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 12:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhJNMFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhJNMFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 08:05:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4DC06174E
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 05:03:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g5so4040213plg.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yvlIDPIRUbrjIhtPS/ztuKi9WUhG61Lvz8W3CYk+xY=;
        b=DmBYEqPkgipGpbdyEEImVO40VSwa+9Dutdaob7Re7Ywx/h8DcTxISVqCLFHyTaMHNF
         wVhUGQkgmDd4yOawiPmn7pWnlkHTf1ZbGtminsCmLni9JBO21njmrGxn2UGDIDXRzq/a
         jWKOp1AW/1xyLr2MAYmH6cSwvOtX6ttmcI3nY8I4QsC5yEsYVfhi6w5dePVB5nCZQQzF
         Jqv/dX9y+XdTqv5FdwWNLzpY/pPJZnK+G1UPY/47+r31zyKdIJOklCo+p4a7y628mCSH
         k7fjJlWESvAzYosD3ITXA/FYuZAfXcNGzjB/WvjUKA8NdbaRj1kzgfywmZStDO8p4PUl
         YGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yvlIDPIRUbrjIhtPS/ztuKi9WUhG61Lvz8W3CYk+xY=;
        b=IFtsxiqpzaI8OSWNbpL+ClicrFZ4kCj56m1DloC39o2t7IVUVHnNrL6uqC7S3U+HJm
         G6K7RDLvilEg7G+bJS8FeJxsIt5Odu6nwzjltYDnU9lTtefMi4q52+ki4CALOniFFR5Z
         UHKCfsDfeOVGikyVoe63vYeclNsDYLMfLGezYcgB+MjsfGAiundnb/VCG8q4zBq1yMki
         7XC58SpoM3VPVGaX/Bi6ZLNsJ6MgrfhH3AkBibx225SZJxUrMg1ep1v3mjDcSZZj+d9g
         v3ot7ottUA9kQYmwWyToR8pLqpHTOtBLHjp8wX5G8NiFpBEPYe4b3OgEHct+gt7L4KNB
         V+ZQ==
X-Gm-Message-State: AOAM531GTrCmtuvpbtNrBILfZl2C1sUVER+wIIFJl66Aqkhaa5AAMJGN
        CMjkywycov911IkcGJox53fMT0pGYyY3YbWY
X-Google-Smtp-Source: ABdhPJwQdcWXky9VlL8sLqR6bs6h9sxCgnxpDO9URk0MalXH7TfZFmSc9DZcS6dXaM8nAleIxSe2DA==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr20205687pjj.147.1634212982702;
        Thu, 14 Oct 2021 05:03:02 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id x20sm2301507pjp.48.2021.10.14.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 05:03:02 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     vagabon.xyz@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND] archive: rewrite description for compression level option
Date:   Thu, 14 Oct 2021 19:02:34 +0700
Message-Id: <20211014120233.7834-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the description of compression level option (`-<number>` or
`-#`) only specifies two level (`-0` and `-9`), giving the impression
that only both levels are accepted, although other level number can be
specified. Rewrite the description.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-archive.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..097b999bbd 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -93,12 +93,11 @@ BACKEND EXTRA OPTIONS
 
 zip
 ~~~
--0::
-	Store the files instead of deflating them.
--9::
-	Highest and slowest compression level.  You can specify any
-	number from 1 to 9 to adjust compression speed and ratio.
-
+-<number>::
+	Select the compression level. Higher number indicates better
+	compression at the expense of longer time to compress. Valid
+	values are from 0 to 9. If 0 is selected, the files will be
+	stored without compressing.
 
 CONFIGURATION
 -------------

base-commit: 2bd2f258f4195ac54293a3f45b86457c0bd5fc11
-- 
An old man doll... just what I always wanted! - Clara

