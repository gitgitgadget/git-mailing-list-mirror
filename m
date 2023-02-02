Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC1C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 03:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBBDvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 22:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjBBDvn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 22:51:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A97BE61
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 19:51:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d14so541184wrr.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 19:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eZrTxw1Z7UAtXJ8KgU/or07JxWldGj3608QPSFiR7Y=;
        b=oXYXWbJAjnvS5TRLEvQwHxeC00WNzOeNNH7H7ppRnM9FcFV0dyB76vu/hSF5OjZc2m
         g+b/B+T1l918d2CcOQl3yS1xz/cKhLmDFlW9CuRvI7TCpJbpNB4lgF7y9S/ziA7tK4Qr
         rKlgb7Lbsk0HwjfOB9uPa0cEmWucNG8ply9JU0CymD+qmFZt3oR3mEIPtRx0iOQOu2Gy
         xcDjhABD/7kcvHO8A8TOTsIAZjAAYxgVVoJ1zZJzaSJJCoyJksOdRZm6honMccrzQ/zB
         qvo8qYaTcXCQvhX+247O4c8I2v4Ex1lKqVOJKE+QnBW873sC5BxwE6KyRD/s2WZK/nkO
         veHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eZrTxw1Z7UAtXJ8KgU/or07JxWldGj3608QPSFiR7Y=;
        b=Ym/qgC+YAlNuwzo491c7DQJbAVh3z7XgVfTzSSfnALbnwwLX/vaxfDHnWD9/3b3msS
         Cdksjtps757XsvY0z/FN2Wmi6QPv0bMyvC3K+WdV8eg7RrXJQVPmEZUBXqk0iXwS02gk
         f1tDD1RJufK2gecKg05+yU3s+S4mEwTsnkWPBgK2OWOC8yeBMU51Gg7Ehee/OG7dSD87
         DRem72HK1n3bvXoap2hNnjTMF9TdapYmktRW327qNp3v20mZHFTva7mrAcWGk7NhwGq+
         OnOJkKxmHtkaIAG8RgVNUBJvKJ+k3zIdNVkJvxd5yUk6yGnqCM+CZOzyltD3Yvpbz6gh
         WnmA==
X-Gm-Message-State: AO0yUKXeWW+3fBCuBZ07BGNsnnKn0BEXG8jsj1fN862nGDXnn5rU+w2j
        d9TsAEYntR/FJm8+5bpzdxc0SVIMhPI=
X-Google-Smtp-Source: AK7set+gDdOQph7s0OgbukAPt28VLT3pLZ5EcXBn/hccXBAe8W/snNo9YUnWbwyJKdWcNQQ/qRcYqA==
X-Received: by 2002:adf:dd4c:0:b0:2bf:e67d:1313 with SMTP id u12-20020adfdd4c000000b002bfe67d1313mr4627660wrm.29.1675309901018;
        Wed, 01 Feb 2023 19:51:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d6d8f000000b002bfb37497a8sm19465292wrs.31.2023.02.01.19.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 19:51:40 -0800 (PST)
Message-Id: <0c0289343fb086c19831bdd38707e94ad2cb60e3.1675309898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
From:   "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 03:51:38 +0000
Subject: [PATCH v2 2/2] mingw: remove msysGit/MSYS1 support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Harshil Jani <harshiljani2002@gmail.com>,
        Harshil-Jani <harshiljani2002@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Harshil-Jani <harshiljani2002@gmail.com>

MSys has long fallen behind MSYS2 in features like Unicode or
x86_64 support or even security bug fixes, and is therefore no
longer used by anyone in the Git developer community. The Git for
Windows project itself started switching from MSys to MSYS2 early
in 2015, i.e. about eight years ago. Let's drop supporting MSys as
a development platform.

Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>
---
 config.mak.uname | 85 ++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 377667c4bbc..965ec530837 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -623,6 +623,9 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifeq ($(uname_S),MINGW)
+	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
+		$(error "Building with MSys is no longer supported")
+	endif
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
@@ -676,61 +679,43 @@ ifeq ($(uname_S),MINGW)
 	RC = windres -O coff
 	NATIVE_CRLF = YesPlease
 	X = .exe
-ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
-	htmldir = doc/git/html/
-	prefix =
+	# MSys2
+	prefix = /usr/
+	# Enable DEP
+	BASIC_LDFLAGS += -Wl,--nxcompat
+	# Enable ASLR (unless debugging)
+	ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
+		BASIC_LDFLAGS += -Wl,--dynamicbase
+	endif
+	ifeq (MINGW32,$(MSYSTEM))
+		prefix = /mingw32
+		HOST_CPU = i686
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
+	endif
+	ifeq (MINGW64,$(MSYSTEM))
+		prefix = /mingw64
+		HOST_CPU = x86_64
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+	else
+		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
+		BASIC_LDFLAGS += -Wl,--large-address-aware
+	endif
+	CC = gcc
+	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
+		-fstack-protector-strong
+	EXTLIBS += -lntdll
 	INSTALL = /bin/install
-	EXTLIBS += /mingw/lib/libz.a
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
-	NO_GETTEXT = YesPlease
-	NO_PYTHON = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS
-else
-	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
-		# MSys2
-		prefix = /usr/
-		# Enable DEP
-		BASIC_LDFLAGS += -Wl,--nxcompat
-		# Enable ASLR (unless debugging)
-		ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
-			BASIC_LDFLAGS += -Wl,--dynamicbase
-		endif
-		ifeq (MINGW32,$(MSYSTEM))
-			prefix = /mingw32
-			HOST_CPU = i686
-			BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
-		endif
-		ifeq (MINGW64,$(MSYSTEM))
-			prefix = /mingw64
-			HOST_CPU = x86_64
-			BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
-		else
-			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
-			BASIC_LDFLAGS += -Wl,--large-address-aware
-		endif
-		CC = gcc
-		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-			-fstack-protector-strong
-		EXTLIBS += -lntdll
-		INSTALL = /bin/install
-		INTERNAL_QSORT = YesPlease
-		HAVE_LIBCHARSET_H = YesPlease
-		USE_GETTEXT_SCHEME = fallthrough
-		USE_LIBPCRE = YesPlease
-		USE_NED_ALLOCATOR = YesPlease
-		ifeq (/mingw64,$(subst 32,64,$(prefix)))
-			# Move system config into top-level /etc/
-			ETC_GITCONFIG = ../etc/gitconfig
-			ETC_GITATTRIBUTES = ../etc/gitattributes
-		endif
-	else
-		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO
-		NO_CURL = YesPlease
-		NO_PYTHON = YesPlease
+	USE_GETTEXT_SCHEME = fallthrough
+	USE_LIBPCRE = YesPlease
+	USE_NED_ALLOCATOR = YesPlease
+	ifeq (/mingw64,$(subst 32,64,$(prefix)))
+		# Move system config into top-level /etc/
+		ETC_GITCONFIG = ../etc/gitconfig
+		ETC_GITATTRIBUTES = ../etc/gitattributes
 	endif
 endif
-endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
 	EXPAT_NEEDS_XMLPARSE_H = YesPlease
-- 
gitgitgadget
