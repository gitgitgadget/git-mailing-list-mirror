Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDDC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJIOiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJIOht (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD64275C8
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso13341wmb.5
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8v2wzdj3RYBwH0aN/4T234ARZhUZMQ2Y2dPmI5NLhs=;
        b=JlUGF5iEqZELO4o3PJJoGT2PHI65aStITXM0kYQplF0aNpuBMZStrOp3d5HwGLCLfx
         J8/XhnuDjbRqdyRbREN+c2sIm1DyttkXApWqUp+Y4QMu+s9P9yr3OaacdvXF+s3JqOaw
         XBrUYciQxHN/IU9oPWw1MT1fcbyol13VmMAwpHJzi8/25tgAkRdkyhbZvcjIpX3AdcCV
         Pm92EhRspNUHvHOh7VnaFvAwuMSoiv5F+w5QJQpB0iFbgqSklNC1l/n4DFu6zqrGHm3I
         Kp/PoGCZWjC71EVPS3NcOGyU9KTk5aZ2K+c6LC0sIEh7f6eQ91/p18WLUhUfHFcUFrsI
         0f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8v2wzdj3RYBwH0aN/4T234ARZhUZMQ2Y2dPmI5NLhs=;
        b=QP5h8qwBxJI4Pi8lr1sWzAJ0QfrKUsWSOxc/kzEY1zwYkIIEs6G2jD6shzjQwlYx0V
         tGVX4EIKD4xr358JAdimBYgJKHAoFLyFJMCD5I+e0dYD92PzMK0tTWcKrLIgzt8gWDyz
         oT8aKhnxawaUTIfTPOsNcxTwMhU2COmtyEtNjiWB28Y2nZbYw+yVkWCvGlvfsPT9Wtb0
         cm/7/48yNoAXiwRo0OpGEFkqj8vjllIx4aRLMCFIiFQM+3KnIFeqvCUTEyiehtlWqbAi
         +GcWA6IxaHwyHoJVj4Y0fIh+ByI7IdxhIvxCrkZiHQ2XXOnDbuas+UbbW0hiFr+iDKRI
         QYmA==
X-Gm-Message-State: ACrzQf1YpM2SJlHPD7OS4Zv7dsQcHbU6JJq7tWuXOftOxSPfz+tZOFaR
        8jaZtKoPW052j8d+d2jfBVR2zD0owI4=
X-Google-Smtp-Source: AMsMyM6OAgUComcfE3gJslGXcgGykPCs5IogTjmeRognCg2w/F4T/ibgbBXw8wO6XS/4YtqufpUmCQ==
X-Received: by 2002:a05:600c:3c8e:b0:3b4:d224:ae27 with SMTP id bg14-20020a05600c3c8e00b003b4d224ae27mr9728571wmb.187.1665326266378;
        Sun, 09 Oct 2022 07:37:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v24-20020a1cf718000000b003a6125562e1sm7478241wmh.46.2022.10.09.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:45 -0700 (PDT)
Message-Id: <c085fc15b314abcb5e5ca6b4ee5ac54a28327cab.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:33 +0000
Subject: [PATCH 07/12] fsmonitor: prepare to share code between Mac OS and
 Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Linux and Mac OS can share some of the code originally developed for Mac OS.
Rename the shared code from compat/fsmonitor/fsm-*-dawrin.c to
compat/fsmonitor/fsm-*-unix.c

Update the build to enable sharing of the fsm-*-unix.c files.

Minor update to compat/fsmonitor/fsm-ipc-unix.c to make it cross-platform.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                                                  | 6 +++---
 .../fsmonitor/{fsm-health-darwin.c => fsm-health-unix.c}  | 0
 compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c}     | 8 ++++----
 .../{fsm-settings-darwin.c => fsm-settings-unix.c}        | 0
 config.mak.uname                                          | 4 ++++
 contrib/buildsystems/CMakeLists.txt                       | 6 +++---
 6 files changed, 14 insertions(+), 10 deletions(-)
 rename compat/fsmonitor/{fsm-health-darwin.c => fsm-health-unix.c} (100%)
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (89%)
 rename compat/fsmonitor/{fsm-settings-darwin.c => fsm-settings-unix.c} (100%)

diff --git a/Makefile b/Makefile
index feb675a6959..31dd6ab2734 100644
--- a/Makefile
+++ b/Makefile
@@ -2038,13 +2038,13 @@ endif
 ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_COMMON).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
-	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
 
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-health-darwin.c
rename to compat/fsmonitor/fsm-health-unix.c
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
similarity index 89%
rename from compat/fsmonitor/fsm-ipc-darwin.c
rename to compat/fsmonitor/fsm-ipc-unix.c
index ce843d63348..3ba3b9e17ed 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-unix.c
@@ -10,7 +10,7 @@ static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
 const char *fsmonitor_ipc__get_path(struct repository *r)
 {
 	static const char *ipc_path = NULL;
-	SHA_CTX sha1ctx;
+	git_SHA_CTX sha1ctx;
 	char *sock_dir = NULL;
 	struct strbuf ipc_file = STRBUF_INIT;
 	unsigned char hash[SHA_DIGEST_LENGTH];
@@ -28,9 +28,9 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 		return ipc_path;
 	}
 
-	SHA1_Init(&sha1ctx);
-	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
-	SHA1_Final(hash, &sha1ctx);
+	git_SHA1_Init(&sha1ctx);
+	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	git_SHA1_Final(hash, &sha1ctx);
 
 	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
 
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-darwin.c
rename to compat/fsmonitor/fsm-settings-unix.c
diff --git a/config.mak.uname b/config.mak.uname
index d63629fe807..d454cec47c4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,7 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
@@ -165,6 +166,7 @@ ifeq ($(uname_S),Darwin)
 	ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
 	FSMONITOR_OS_SETTINGS = darwin
+	FSMONITOR_DAEMON_COMMON = unix
 	endif
 	endif
 
@@ -453,6 +455,7 @@ ifeq ($(uname_S),Windows)
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
 	FSMONITOR_OS_SETTINGS = win32
+	FSMONITOR_DAEMON_COMMON = win32
 
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
@@ -645,6 +648,7 @@ ifeq ($(uname_S),MINGW)
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
 	FSMONITOR_OS_SETTINGS = win32
+	FSMONITOR_DAEMON_COMMON = win32
 
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 787738e6fa3..0b26a1a36e3 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -315,13 +315,13 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-unix.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
 	endif()
 endif()
 
-- 
gitgitgadget

