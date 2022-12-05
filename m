Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34485C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 21:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiLEVEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiLEVE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299202AE2F
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 13:03:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d1so20687971wrs.12
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcKccdLjOL+9v9LibjhzzJs6SdwNLgSxK/R/kJMBPDI=;
        b=ZcFkU65Dj+6ykgpCmByCPvw78J/vxPq8UXlk77t0RoWZIFrswdqgnSfeKF2eQEXMNz
         ynbDf5lqlCEWiqfwuW1QMbNff9pilZl5SKEvlmXaQU3HWkE+rIhzJ5ODSHcOD5xU0C2t
         FTrsEEix0PumZov+A0mU3rD5qMpNkYezjiRBQ4vS46O+9LUktZk2nVmqI+amGG7d/pii
         DGWHVVsWdTjO+G2PVrlpj67VxlLZ5rMIZ+1YLj1yF2zFnlffaVW2CnU9LoQqbm4phNgS
         YLZ2POqdDHdIAOBycWOcGd46EHlO4XCJ5x0oor6xStMkUrpq+g5KG5impXYMx/bNPfTX
         pFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcKccdLjOL+9v9LibjhzzJs6SdwNLgSxK/R/kJMBPDI=;
        b=GQEV+DcvblkjyW2BLMYUy0BhA4+M1YxNLIGFSaXxXPUZTtbQKM6CLfwOaOS3x9HYgL
         6Iu+eZidYH0b0Zj41L1rW7QUpBwMyWpgsqUTjy8/WF886E4ZCPHk2rdtTsGCgCEs6MNM
         a4PT5xVSMMDZtW445RMAKRJlVVd8uxv5PZL/8YtUEgE77mpE5WTcMwPX0JQI2FQHjGDb
         l65pk9UMghpe2lszogztehbqSBivi1vl+vS5lRueg77URPpVtHevmJQeNPGxqAZSP5us
         s0B20rxIRL5W83V4fysNOqbTZux/hmkxvrYQc0xEEI9LQyx5lqtro4/6NNcynvX+FUq/
         0t2A==
X-Gm-Message-State: ANoB5pk7R+fw4NTVXSziN2NO3hgWE1GHZk3ifB1V1DWce4Ri/UQrDzxW
        zu7MW5JDfgfZLDdir+GlbOG6YKfNXfM=
X-Google-Smtp-Source: AA0mqf5KHjh/fbxcWTvxTd2q2XhLm/UDnP5UhqBh28IeShhKQTUUgeKpEI2kmmk0FLYVRbrXPkb4dw==
X-Received: by 2002:adf:f2d0:0:b0:242:7c:eb9c with SMTP id d16-20020adff2d0000000b00242007ceb9cmr32598697wrp.178.1670274218528;
        Mon, 05 Dec 2022 13:03:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4402000000b00226dba960b4sm14854005wrq.3.2022.12.05.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:03:37 -0800 (PST)
Message-Id: <e6d3d280a4f9216aa6e9c3c83a38b0fb8ba3a8a1.1670274213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
From:   "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 21:03:33 +0000
Subject: [PATCH 2/2] mingw: remove msysGit/MSYS1 support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Harshil Jani <harshiljani2002@gmail.com>,
        Harshil-Jani <harshiljani2002@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Harshil-Jani <harshiljani2002@gmail.com>

The msysGit (i.e. Git for Windows 1.x' SDK) is no longer used and the
last known user for MSys1 + MinGW has switched to MSys2. So there was no
reason to keep the msysGit/MSys1 config section. This Patch intends to
remove the support of both the builds and throw an error on
execution.

The output of `uname -r` if returns us with '1.' then it relates with MSys1
build environment and msysGit which we don't want to continue ahead and thus
an error can be expected.

The MSYS2 is currently used into the MinGW so we can get that part
running directly without any conditionals required.

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
