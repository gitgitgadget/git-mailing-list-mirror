Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F8C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiLLV63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiLLV6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:58:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E41E02D
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so6451296wmb.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6C2Zq2Xk3A1H+56d8//SfwAzESp7nkcEKtJeqKZ3QU=;
        b=epzZm3e2/GOfJH/KZF5SAKPUF3sxdu3G9Edv1Nlx98HNQga3JGn6gndesmEE++jV37
         Xr3p9dHdnwJV6J4lE5qqd+u5fOP4jdE01AQ8K9wmbdgA9a1V5UjwvU1R02LAQeck+V+R
         0Ea81FnS+Dim1btRp64Q6nNlhXdicUWN7r3ClzUrHn9aFFL/7Qs8eI3nhD6RscZAXB1L
         7Z8mSc4UYWvzEF2T015VGXg1srcX4Y0qLV+d6d1K1HfuLreLICezlywDN2ioTAg5e5/g
         KDhbdHumSTbOd82/wFkc8ghYjC0REIIRyNyw30X9GJWk5mB9Zas4hdNgUMOcCrqeU17j
         j7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6C2Zq2Xk3A1H+56d8//SfwAzESp7nkcEKtJeqKZ3QU=;
        b=XIoIadxb6T2QMDD3H3XPullXTyqKYcqAMfkcbrmpoLjNBpOivODjeIntT51Fenc7+4
         oYJV8k5S/kYE1otbUs/o2pBpMt/VRsAWjCJ/tuzYsLxP1VgytH+b71Hvt8giZAa8bW5E
         Jmd0Ag4g/nikSKNsBuNx+Y+VlktqLP9xFN+N+TwqFl7M8eZKKUNtvFYcsJ44kOD0P6Ke
         2uOFxnNxogGCHRDyD8S/ve1an3PXo8HWybYKyHfMorpP9Zbcv0CAgtZyPc7HaSF8VSjD
         uGp+JfdtDGJ/krvMI5nYi2JBjH5QA7hhOJK+5V8xkw3xM0930cQQeNk0ip/uTk9Lky//
         BxyA==
X-Gm-Message-State: ANoB5pmnb0r/iqxOXP/Qp3k3pubT6snGdgMOoWETqtbssEPy/ahY4gUF
        PMK0lhtD6NKV1KJHmQ1tps990Vn9x5w=
X-Google-Smtp-Source: AA0mqf5fQTHHouAKh8NjeQE/g6LjFPSSLvuJSwOdd3Zc7yuqyjXorNUuINkxKsIVNFuWxRfj44li4A==
X-Received: by 2002:a05:600c:3c8d:b0:3d0:6d39:c62e with SMTP id bg13-20020a05600c3c8d00b003d06d39c62emr14261945wmb.12.1670882290824;
        Mon, 12 Dec 2022 13:58:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003b47e75b401sm11870794wmo.37.2022.12.12.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:58:10 -0800 (PST)
Message-Id: <c03070fb0a2a3e8b5588ae8c4ec868aeb9e7f4b6.1670882286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>
        <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:58:03 +0000
Subject: [PATCH v5 4/6] fsmonitor: enable fsmonitor for Linux
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
index 2f6e0197ffa..a0319527279 100644
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

