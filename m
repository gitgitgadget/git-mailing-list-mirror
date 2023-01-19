Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC8BC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 20:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjASU3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 15:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjASU2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 15:28:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB49D281
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 12:28:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4421052wmb.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 12:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6T4X/L9c8Ef+KILKhUCz/VsIiF/Cel8uQh9MFJHDCI=;
        b=GrJ2tx8eB3upJZiX8MIRTFs8oaLS+Is4Bpr1Rweods8IT9zDy++z9mIDWwCDN04RPB
         wErScnsrOaM/tzn51RCzMQm6/dhZ334ypUC2In6PKUNh5DcE/TYLkG6GDYFlAaYomouF
         RpVvSOvCWBGSjHIDNJ6kg3g53Af//kanH2tKGKI+L1/RSn1HdhLsQopwlWuXnLDgb4XH
         OQkpksCZKSZ2m4K3PoCznLXIbSfBMWMWI8CWLp/MFHoTm6FdAQn5XukZgogLVOa7xSfM
         9EY4NK/rWPqFJCZ0V1kg1WF7QSvX5msGB7OTb2Fsnd29K0u+25r2O5u+GLVDNc3lrrVa
         vp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6T4X/L9c8Ef+KILKhUCz/VsIiF/Cel8uQh9MFJHDCI=;
        b=Uo5x8MtKdDBoZmArjhuVgCrazvgRoE0fQaWfe4s19p6h/zwiNDoPuoHc8j0EFnM7px
         7e3qBz9pJr9ei+WxNFb4qIl8tIOfC23/vSKS3/bVMjkQ26SqRI8upcRqT7LdBu3VxuGb
         GbOzGIFmftKobcjz6acAIUBe/JI927vdSLleubzoKrcsJAsRiySPF7DiXknBvarOci2J
         7/b2JcYDHP5xk/AnCAzUy5y+I0nA+6v0Rdq2W+ORQTdwVkb3dh44pfA/5fxT3MSavUtQ
         JXw4habAgfJudrHT9ooL7MkmM1Fqdqca49xSBubXP0LUCo58PgQ4PhK7fi/RKX9x5uCO
         xwxA==
X-Gm-Message-State: AFqh2kpqtFJTVb/82Xc9SXFtSqs9qYdAUhV+8wR/9o7mc9NEddl3VW90
        kt8dVmfXPDA+9qz4VleU5Zw5RMYJaF4=
X-Google-Smtp-Source: AMrXdXtXCQ5o2sao9yYVl+vSFsglFGkHVzmcRtvsedVyN9ZlxvVHIWUNNVAXds/b3EbT+Du44/dt3g==
X-Received: by 2002:a1c:f310:0:b0:3db:15d9:1485 with SMTP id q16-20020a1cf310000000b003db15d91485mr6460931wmq.39.1674160132946;
        Thu, 19 Jan 2023 12:28:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b003db1d9553e7sm195288wmb.32.2023.01.19.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:28:52 -0800 (PST)
Message-Id: <pull.1439.v2.git.git.1674160131967.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.git.git.1674156875354.gitgitgadget@gmail.com>
References: <pull.1439.git.git.1674156875354.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 20:28:51 +0000
Subject: [PATCH v2] die: fix inconsistencies with usage header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

The headers for the die and usage functions
have different parameter names or are missing
the "NORETURN" attribute

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    die: fix inconsistencies with header
    
    The headers for the die and usage functions have different parameter
    names or are missing the "NORETURN" attribute
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1439%2FAtariDreams%2Fperror-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1439/AtariDreams/perror-v2
Pull-Request: https://github.com/git/git/pull/1439

Range-diff vs v1:

 1:  74e90f0fa5c ! 1:  c3b436cea9d die: fix inconsistencies with header
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    die: fix inconsistencies with header
     +    die: fix inconsistencies with usage header
      
          The headers for the die and usage functions
          have different parameter names or are missing


 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 2 +-
 contrib/credential/wincred/git-credential-wincred.c         | 2 +-
 usage.c                                                     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index e29cc28779d..fa88d621865 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -11,7 +11,7 @@ static char *password;
 static UInt16 port;
 
 __attribute__((format (printf, 1, 2)))
-static void die(const char *err, ...)
+static void NORETURN die(const char *err, ...)
 {
 	char msg[4096];
 	va_list params;
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index ead6e267c78..c0610d7648c 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -12,7 +12,7 @@
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
 __attribute__((format (printf, 1, 2)))
-static void die(const char *err, ...)
+static void NORETURN die(const char *err, ...)
 {
 	char msg[4096];
 	va_list params;
diff --git a/usage.c b/usage.c
index 5a7c6c346c1..5f5510ceeeb 100644
--- a/usage.c
+++ b/usage.c
@@ -206,7 +206,7 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 	return buf;
 }
 
-void NORETURN die_errno(const char *fmt, ...)
+void NORETURN die_errno(const char *err, ...)
 {
 	char buf[1024];
 	va_list params;
@@ -217,8 +217,8 @@ void NORETURN die_errno(const char *fmt, ...)
 		exit(128);
 	}
 
-	va_start(params, fmt);
-	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_start(params, err);
+	die_routine(fmt_with_err(buf, sizeof(buf), err), params);
 	va_end(params);
 }
 

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
