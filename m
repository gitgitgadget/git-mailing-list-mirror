Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A810BC433FE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A39B60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhJHTMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbhJHTL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:11:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB235C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:10:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i12so20042709wrb.7
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tKWx5XFWAWGUG2fX/3dZLci7iB3dxtBBhmwN1/cOdiw=;
        b=S8L39ahdtAL/rM8LNXPScKzNOjLayzSGRZ/EaCU08QyFABBVpX/TO1FtFx8ZkPsDvL
         iWKoLw45LblX8ygkdDJEkbIzMyYAGTd+hjF9ufaTa2gU24snpt3WYRBJuL+UUu8niNv7
         k144+MVZoS8qCmr0+xBSoAQP1pX5EmF6092yLBSlzX3IjbtnzqWL4tFxPpm2P22WlWvj
         lQemMn0orNfR4lUFjmIUG3NEQY2EPuQ1HlE0NGQL1iVRl9ZcruhvNXT4r2fInjwW37NV
         I+2Iv6RBa5SWn3KHh41t31S3ef0pltdR8fVCqN4+wVfOqxDF1no9pztGUrA1aDWhnEwb
         MoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tKWx5XFWAWGUG2fX/3dZLci7iB3dxtBBhmwN1/cOdiw=;
        b=Zsxjv4/9rPueTT95I4JxemDn9/37m06/Bo5dQXFV+mW+x2z2b5t/6fcWOgQxeESNwX
         oaemjuH1qwNn8mxV5UNbm3w/T+JLym1H7Z3wAi5yiUBus3W68ErZQK90f51NoffktnOM
         ExNVoa8b6hZjUk3GUv/7PHcNUsew8g5zrbY/Bef3MVVPNacce3OK6Kq9/yebVK4YKLrD
         ZoZn7QM/SN23M2LvBNrjU9NZHDTQVG2qvBIp6d+0aQ0s4zgCSRzw1UKoHZPoFcIKfobg
         WeRpOAXWGoUYzZz9U8Nxmjdrqj6nGD2NqAUukLjK2DCLtOTn+a9401TOZPSbG03cddQS
         eJUw==
X-Gm-Message-State: AOAM530W0OL1u7L7tbRngl3sjZoWB65Kz6GrsmrbzbzXvtlxXLsoMJ0j
        aXQWf1axejNMd/4/zi1dVZfmUvOR5bg=
X-Google-Smtp-Source: ABdhPJygMKIB3uB08n6KQ9/a6DPXYl59uR8FMiL7PY2iBpxW4Pnv2NLwTUfmkwHjuOu9KOY+/kzfXA==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr6293323wrw.192.1633720200538;
        Fri, 08 Oct 2021 12:10:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c132sm13009381wma.22.2021.10.08.12.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:10:00 -0700 (PDT)
Message-Id: <43a701f5ffd899ae56b2db0fb865e37dd2bb4e07.1633720197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
        <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 19:09:57 +0000
Subject: [PATCH v2 5/5] userdiff-cpp: learn the C++ spaceship operator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

Since C++20, the language has a generalized comparison operator <=>.
Teach the cpp driver not to separate it into <= and > tokens.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/cpp/expect | 4 ++--
 t/t4034/cpp/post   | 2 +-
 t/t4034/cpp/pre    | 2 +-
 userdiff.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
index a3a234f5461..bf3cd2abc74 100644
--- a/t/t4034/cpp/expect
+++ b/t/t4034/cpp/expect
@@ -1,5 +1,5 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 60f3640..f6fbf7b 100644<RESET>
+<BOLD>index 144cd98..244f79c 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1,30 +1,30 @@<RESET>
@@ -25,7 +25,7 @@ str.e+<RED>65<RESET><GREEN>75<RESET>
 a<RED>*<RESET><GREEN>*=<RESET>b c<RED>/<RESET><GREEN>/=<RESET>d e<RED>%<RESET><GREEN>%=<RESET>f
 a<RED>+<RESET><GREEN>++<RESET>b c<RED>-<RESET><GREEN>--<RESET>d
 a<RED><<<RESET><GREEN><<=<RESET>b c<RED>>><RESET><GREEN>>>=<RESET>d
-a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h
+a<RED><<RESET><GREEN><=<RESET>b c<RED><=<RESET><GREEN><<RESET>d e<RED>><RESET><GREEN>>=<RESET>f g<RED>>=<RESET><GREEN>><RESET>h i<RED><=<RESET><GREEN><=><RESET>j
 a<RED>==<RESET><GREEN>!=<RESET>b c<RED>!=<RESET><GREEN>=<RESET>d
 a<RED>^<RESET><GREEN>^=<RESET>b c<RED>|<RESET><GREEN>|=<RESET>d e<RED>&&<RESET><GREEN>&=<RESET>f
 a<RED>||<RESET><GREEN>|<RESET>b
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
index f6fbf7bc04c..244f79c9900 100644
--- a/t/t4034/cpp/post
+++ b/t/t4034/cpp/post
@@ -20,7 +20,7 @@ str.e+75
 a*=b c/=d e%=f
 a++b c--d
 a<<=b c>>=d
-a<=b c<d e>=f g>h
+a<=b c<d e>=f g>h i<=>j
 a!=b c=d
 a^=b c|=d e&=f
 a|b
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
index 60f3640d773..144cd980d6b 100644
--- a/t/t4034/cpp/pre
+++ b/t/t4034/cpp/pre
@@ -20,7 +20,7 @@ str.e+65
 a*b c/d e%f
 a+b c-d
 a<<b c>>d
-a<b c<=d e>f g>=h
+a<b c<=d e>f g>=h i<=j
 a==b c!=d
 a^b c|d e&&f
 a||b
diff --git a/userdiff.c b/userdiff.c
index 1b640c7df79..13cec0b48db 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -62,7 +62,7 @@ PATTERNS("cpp",
 	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
 	 /* floatingpoint numbers that begin with a decimal point */
 	 "|\\.[0-9']+([Ee][-+]?[0-9]+)?[fFlL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
 PATTERNS("csharp",
 	 /* Keywords */
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-- 
gitgitgadget
