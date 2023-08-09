Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9FC001E0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjHIQyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjHIQyw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 12:54:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728181FDE
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 09:54:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe5eb84dceso26613565e9.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691600090; x=1692204890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGgoTlT1wizP6UyIm4BwwFeqtuVC2ysuKyz8xYzrUE0=;
        b=GDBszfkLFDNTo/qzDiGUE2JLGlyilpfLgwuJ5hRflmksdS4cIVgaQyG64gXG0LqWX8
         ZKwPX23Jec1mUJrbIi1cXRyRfL7bER4vhwVMZsTcoWw4g/JNeR37WYOoc72W705po1ee
         nTyLmk5omkykktyLXAS6VxP9vBSmNCamamkPPLZs1SslpIP6lHTCDDHdoO5TfHdzRsHF
         rYwX90+l/+AqkcX7Oi4lsB9IYy2a39QP98ZZ/se/1lUpABKP28RxKqzPox/LR5PhtyDk
         BOYuoF1PEzzgGMzIEnMVUsp7mcrrEbAZEL3MQ9rxzrQ4fAK3R6FUGfDPpkqhYEbInnsO
         vAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600090; x=1692204890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGgoTlT1wizP6UyIm4BwwFeqtuVC2ysuKyz8xYzrUE0=;
        b=XKYW57ZREX3wdSt2A02sZGOUTfAgGtG76mwkJpDj25+h9PolpbOfWSwB+J73+165T9
         ozhW+fwzvH0qOgT4s1nyS+YCrsQRuW8gs9eJEjj7E3P0g8TZceCNYuvGElIm8BeO/3ys
         ac/lRcnSkR45rq3ZFfLX7FQVsCJHDjdkCrZLzc5dIvXt2RMfUj4pK01/Rd+OoNw0QDvU
         /2et0Ppah5M0/PvH2rExBtDqpavnLh/QN0KPU5ZJ6+JDiRVb0m4RGbFnbs/iXzcXHuUW
         rCeb4ldKX99JhfsvVWmvy/wVCfnKCfTTLYOp1bABPtb8LElCieCv4n0WDhOgMngxk9HM
         I1oQ==
X-Gm-Message-State: AOJu0Yz2I3EoF26vo4s97dhlxM2U0tw/hgIUyA1dVuwzqR9Gwl1brmVR
        fteW/U+g8SDqspaMVE8zB4+mRHOEcGI=
X-Google-Smtp-Source: AGHT+IFO4krEGfQ6/hdT7AoaTkOmcH0/l7K/tKafIWB0sKg9lMXja/SyQNCE7kga3yy+xcJEwohVYA==
X-Received: by 2002:a05:600c:21c2:b0:3f4:d18f:b2fb with SMTP id x2-20020a05600c21c200b003f4d18fb2fbmr2661588wmj.8.1691600089616;
        Wed, 09 Aug 2023 09:54:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b003fc01189b0dsm2476586wme.42.2023.08.09.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:54:49 -0700 (PDT)
Message-ID: <d27cda48a5910940a1ca2ed0f04fdf80bb325c28.1691600087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1570.git.1691600087.gitgitgadget@gmail.com>
References: <pull.1570.git.1691600087.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Aug 2023 16:54:47 +0000
Subject: [PATCH 2/2] git maintenance: avoid console window in scheduled tasks
 on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We just introduced a helper to avoid showing a console window when the
scheduled task runs `git.exe`. Let's actually use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 19d73067aad..5c4315f0d81 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2068,7 +2068,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	      "</Settings>\n"
 	      "<Actions Context=\"Author\">\n"
 	      "<Exec>\n"
-	      "<Command>\"%s\\git.exe\"</Command>\n"
+	      "<Command>\"%s\\headless-git.exe\"</Command>\n"
 	      "<Arguments>--exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
 	      "</Exec>\n"
 	      "</Actions>\n"
-- 
gitgitgadget
