Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64450C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4679960FE7
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJVGuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhJVGuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 02:50:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3A5C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:47:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so1255803pje.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtBoUK1IYjftW6PYj1EQ4DziP3lVodxBL/jKZzrcgxQ=;
        b=MoRvpVe0PeLzaUaBPvw7WUDpw7uNSlYg1a5XmI1TGJ/tX4MZ09/ftz3r9BHqPdKlHb
         x5HMWD8Z8vXoN22QayzEsCtO4g6db0Mwi2eSssMHIGJzapHzHLQDuukYF6r+GNsn4//O
         TBnt6Simr5Klj7lzd5nikRprRtyEEPtpx/dYklOwwVeN4BHA6TNI7uqpXab7mfnOKzva
         omX06RpQTuuYI4sEOLc4Eihy3VReA+nhPqHE4f21f2+mgBg4JgEMrJ9V33cJayIvA+pa
         jO4smxHgX0RH0FFnn8o93DF1NcnDKFK29C3PBqqjYIDtVZwOBHdTEuB1/+uV9dcuT+Co
         cRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtBoUK1IYjftW6PYj1EQ4DziP3lVodxBL/jKZzrcgxQ=;
        b=6RRRw53MI37YoAr3xVfWeb2Fx05PZFLIQyFtRPu+qUw3mQsMQbduvkHAb96/XLsTw1
         fP2gaAjsrZvVOqK4N3GhTgAY/LijEoz3EWDb6xwiK4ue8AXV0TwvVrXo8US5FdMLBq0S
         YuOikMZqRoNxvrzlygSN/kQRXgCv6kMJvnxM4ARfF+2MqbvBGy8JBPMhbvFtZUQ2m8Bg
         vo9wTcB+HmJSllLckcnh37gOyvRM5Wt0K/9t3vUd+iGXMjk8XlAXc5AzfAWi+bp82ZmD
         a/i5tg9sppK4pXf12GpOwBktGAzV0/lLhbktdoSEOghpNyERGFZ2gn+AJHlKtCLin+O0
         CFLQ==
X-Gm-Message-State: AOAM533IpuozlOW6KrWEfF7yhs+SQP2ThkpALqI3KRLlNi1CitVUiQzV
        VH/2wbuLUCu7irRhPZLsJ8yjNctgHvgq8bJr
X-Google-Smtp-Source: ABdhPJwsuTZL1dr+o+DZvIcoiaxB7nAI12D3hZ8amDUerhm2CL8J7KYdDaR4znqguWmnkcNbjVoy3g==
X-Received: by 2002:a17:902:b410:b0:13f:afe4:bf17 with SMTP id x16-20020a170902b41000b0013fafe4bf17mr9658453plr.24.1634885266988;
        Thu, 21 Oct 2021 23:47:46 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id ng5sm8450810pjb.51.2021.10.21.23.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 23:47:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     vagabon.xyz@gmail.com, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4] archive: describe compression level option
Date:   Fri, 22 Oct 2021 13:45:44 +0700
Message-Id: <20211022064543.28950-1-bagasdotme@gmail.com>
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
     - use smaller size - slower time term
     - use <digit> and <number> for compression level

 [1]: https://lore.kernel.org/git/xmqq8ryqxo72.fsf@gitster.g/T/#t
 Documentation/git-archive.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..ecfae7e268 100644
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
+-<digit>::
+	Regulate compression level using the specified <digit>. Higher
+	values enables smaller size at the expense of slower time.
+	Supported values are from `-0` (store-only) to `-9` (best ratio).
+	Default is `-6` if isn't specified.
 
+tar
+~~~
+-<number>::
+	Specify compression level. The value will be passed to the
+	compression command configured in `tar.<format>.command`. See
+	manual page of the configured command for the list of supported
+	levels and the default level if this option isn't specified.
 
 CONFIGURATION
 -------------

base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
-- 
An old man doll... just what I always wanted! - Clara

