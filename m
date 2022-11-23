Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6328C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiKWTBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiKWTBD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:01:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18E91C3E
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n7so3216726wrr.13
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng/xg6yasgRwguK3X1vnGO3/VVD9jc7oLvVlSGtH/ws=;
        b=ZwglMKUkwA2AHb8mOeZI1l6nxfStvD5rJzNBptY+U2x/4Tjrc/Yc0PcEfDI/RespCe
         sNuiqtdS+klJBc1PyDyvsQd4a6vrwY2jZcuUSY1a3m5TwpS0uxbVLzP33TjITvkZKEjt
         fLVubaEm3Dthu4V+WFduVN/TT9NDSt5vQRmzoz0NqMKO/GrHhXGMKYJylfBsYqanOiGg
         7/qrETr616z1SKdCSces1ja8WQpDUDS+WbGA+SFLjo9U6vyPidus1ytsGbsS4eI6nNgA
         t66a8vUvZOIHanWJ/+3YHozYOMlbCUJm0ubZoDe8GJ+X9U/S3RwGikltqpoZ2oV7UeCz
         Txbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng/xg6yasgRwguK3X1vnGO3/VVD9jc7oLvVlSGtH/ws=;
        b=xJu6bodU2mBC8rAHhKpFuwX+9d5kujlgFc/4uqL3iCv2d+YJMWHvJLDVb3Rd5d+WkU
         3ts0Xcqpm8M3Y4gmUdUKl+gg3FF8E138MrkxLoQXFCImgQPU+zEOsBp3hJhZnfASrrSd
         xh10r0eBLBmcLMyQp49KGWhQKreZfm5vyT6hjTQyrh1H2Nv3xVKP/HVLUy+eBmep5y77
         Fh+k9RUwZr6F5IdigU5jG8IGv0QqJPPz++iKItjJ9jkBgosSHRslA/psDbfnDoEeevfV
         7n7YmAq9UDupv7NwKhGkfyJjNcSsi4kD07ts5E4ryGUkAUx3ppPKyPw8IClxGE23jORZ
         yVqw==
X-Gm-Message-State: ANoB5pkIzc7frySzfTVB3eNRAnMMbLon///KMLUzlAH4wjN/edjEUBKD
        BOdfwj//wOabtmXUuu+ZlN5CfxYEfns=
X-Google-Smtp-Source: AA0mqf5AxGnBo/GhSwVYSaci7IRvcPEufXZ2rNOcRGaQTDsOPUbzYAMA44Pbqyze4liKmEmvU6cOLA==
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id q4-20020adff944000000b002368f54f1f4mr18341711wrr.654.1669230052206;
        Wed, 23 Nov 2022 11:00:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05600c1e0200b003cf7055c014sm3348282wmb.1.2022.11.23.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:00:51 -0800 (PST)
Message-Id: <cb03803e3558ffbc5169b088d427ac5557d7e861.1669230044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
        <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 19:00:42 +0000
Subject: [PATCH v4 4/6] fsmonitor: enable fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
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

