Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4678C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiKPXX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiKPXXr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:23:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F636546
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so27878572wrm.13
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng/xg6yasgRwguK3X1vnGO3/VVD9jc7oLvVlSGtH/ws=;
        b=FuoZN5KL5R/rinjem8rbQymmT3o2N/bCtEsvKerpSZZOIoBOoMZI9UQvDO2tCp6dR9
         /9+1Cw7pLqvUw+/jdA87+re2fJeqilQw4QATaMZfelztc2ck8py3yq//XvNg2dmxfPVI
         eOAsrXh3JFja55KoWEfPVm7yeUap3MnXSXZ3J88SL4oGo8ibOXVJtUwmEOk0Kz6tS8Q8
         sferp6Arb9Y6s0G/7KwsUShQ1ZQNmKVHxqHPfHHivtJEOzdKkRTr35q9BL73nm/Q4OiO
         3g/Q5ycMixqdqgZnLb+3ywOOcJ/tIcJGdP1DnY90f0YusZxj819cELZSBCvj2BNueHrB
         3zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng/xg6yasgRwguK3X1vnGO3/VVD9jc7oLvVlSGtH/ws=;
        b=gSz758Am+kCMP99Ve4wswnj7J8CfBG/yIfFV4joMfsU7M+VQjV1XC94jt+nIXusNdq
         CeZRHwIDZJYjF0u5JsQt3uK9dSv7Iq+BdxKR+0gdKqbIXpe5XvnuGLFJB7PmmkiCgex2
         aQatJ0QBmBvWGhyqeFthIzu8yuRqRgiXgbl2OxX2hm1IHmdyTinlpVwcD7YFLLzoNpjv
         WMyuZMaWJIvv39ekyuFz8cbIuCq01eNCywat/6RloyFVDEuKIHxy1Bxuyruxvc7YA+RO
         0+TIrnDnY2DyN+h5URUKVCKiNINRCam4JqKpGxoEqG2+YNXmfQFK94xcYClk2/ClIrII
         V2yg==
X-Gm-Message-State: ANoB5pnNFfUvoz3MDRs8AGP+rncwzd4uTWPEaChHhPHh7KUXDiA8G8xz
        BjxMYSV4s5DQyAe7y3wKYA2AHWKBQSA=
X-Google-Smtp-Source: AA0mqf6LkDaB6J2mN+eGQ8Q9wTNHwKZ27P15M1iL33+eg4jCDL6PKtiiBhqOxlfQ6GKNn/PTFrLE3w==
X-Received: by 2002:adf:db50:0:b0:236:6db4:a5fc with SMTP id f16-20020adfdb50000000b002366db4a5fcmr15489169wrj.73.1668641024701;
        Wed, 16 Nov 2022 15:23:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b002368a6deaf8sm16390993wrb.57.2022.11.16.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:23:44 -0800 (PST)
Message-Id: <05f5b2dd4fb9656689f01ae0c39c89a8fcb0f796.1668641019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 23:23:37 +0000
Subject: [PATCH v3 4/6] fsmonitor: enable fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Update build to enable fsmonitor for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 config.mak.uname                    |  8 ++++++++
 contrib/buildsystems/CMakeLists.txt | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index d63629fe807..5890d810463 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,14 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+	ifndef NO_PTHREADS
+	ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = linux
+	FSMONITOR_OS_SETTINGS = linux
+	endif
+	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3957e4cf8cd..f058c3d19b4 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -304,7 +304,16 @@ else()
 endif()
 
 if(SUPPORTS_SIMPLE_IPC)
-	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
-- 
gitgitgadget

