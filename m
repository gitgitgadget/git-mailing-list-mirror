Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4218EB64DD
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbjFOPrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbjFOPrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 11:47:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2E272C
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 08:47:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso7236475e9.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686844055; x=1689436055;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tugfj5KLfq1Nvj6pQ47VP9dS7SY5m6xuONOEkTMhY/c=;
        b=rj/Ra4Jpw37TPbZWwL3cSePtgmBsDvbN1hm0WYNZyJm6wz94i6tWCnYhiTxWbazH7N
         9qGq1T4A24Bp5j5eaWK9HJLknEr+7pT5l+NKbCEa+BfVIcnezaU8n5q3ejGjzyu7A817
         BhtwDNbkI8D4okCdu9u8ga8TsZF0zjRaRPbgb4KhjA0Vk9e4/6WGnH5madQqeTRaL30r
         VXvXftVLocDZUZmHOmsfrjRrJNsu7yI6rvt7A4wY/rmf0OyTJlIerzjUDWXUbD87hUOl
         3KEgMKjebkFRgCXs4Mn9sVJyE1qqqSBl22O4tNauQ/P2i+G7Aa0oTTFilUK62nz1cLyl
         FrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686844055; x=1689436055;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tugfj5KLfq1Nvj6pQ47VP9dS7SY5m6xuONOEkTMhY/c=;
        b=ELtRHXIz2UQb0VcBRKX9yeqMuqHtyF30PTDM5LyD5+sbDF1sOiyYwkntSNSQSrKO61
         coKJbYgWG/QxDYr9yburT3UPpl++11iFkuz9iZBvtQbekiQhE1mcV3s1xeaiM7zaVpax
         S2jN6ZZHbOAXIskX58K8SiUcWGeUR0FcB9ZXhe7QIpLmilAO1UMpnwOsX4BipDXgW0+Y
         sWkDacpfaR8uT6aArir35SFGa9LD6p9ZIf61hqblLG+xjzviihMqwCGx3WvETuOYe9EG
         HsqDaXxn8WZs02rnCVjbqnnH3K80Ip71g7Wm85DO4Ii64MJlG7ZFIf1xvUVPxqHKefTK
         cRFg==
X-Gm-Message-State: AC+VfDz3qTgeD0t9lFLrRzsczugCT/fvKaFg9vpBGa5LCL+Vx20Pei8y
        +iQu0magkvYYAGIEUgcogujVYavI0DM=
X-Google-Smtp-Source: ACHHUZ4lSap3EJD8yWlzGJ47m8xgleAvo4S7ix1mLWCLOgu0g6h/EODdMtmahF9pnBIA0IcWwg2n1Q==
X-Received: by 2002:a05:600c:19cb:b0:3f7:e559:ddf5 with SMTP id u11-20020a05600c19cb00b003f7e559ddf5mr4290686wmq.17.1686844055035;
        Thu, 15 Jun 2023 08:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17-20020adfded1000000b00301a351a8d6sm100790wrn.84.2023.06.15.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:47:34 -0700 (PDT)
Message-Id: <pull.1544.git.1686844054022.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 15:47:33 +0000
Subject: [PATCH] cmake: adapt to `cache.h` being no more
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a companion to 4275a22e169c (cache.h: remove this no-longer-used
header, 2023-05-16).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: adapt to cache.h being no more
    
    This is a companion to 4275a22e169c (cache.h: remove this no-longer-used
    header, 2023-05-16), based on en/header-split-cache-h-part-3.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1544%2Fdscho%2Fheader-split-cache-h-cmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1544/dscho/header-split-cache-h-cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1544

 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ffa..4faa419cc3d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -227,7 +227,7 @@ add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
 add_compile_definitions(SHA256_BLK INTERNAL_QSORT RUNTIME_PREFIX)
 add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
 			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
-			SHA1DC_CUSTOM_INCLUDE_SHA1_C="cache.h"
+			SHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"
 			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
 list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
 

base-commit: d677f7e76abb837502c589d17889cf8ad591dc09
-- 
gitgitgadget
