Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A98C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJNVqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJNVp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:45:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021F16386E
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u10so9578935wrq.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LckyfNVoYdL232Tax7sXGyYKzM8LJlSJVTs/P20Tba4=;
        b=nw08t7XAO+upe7zeHsli/Ql4LBQ7sK+QD48URIkPHYV+2urcp0MIyoHcIzdzSOj45N
         8K1UoAYbuD19JQ5VHzgS7Ig0omTprKxAgE1n6IG1oe0WjMIGh10ArMN6ekOr1QnLu3Oo
         BwLVMDpdyR83lYai1E1yljrigNxkGhZw+pVrBlBj3fq8Pu2Ly/USDaQdX1WiC45mCE5W
         hTw9dy87ksGhAu2O6qSjkIucbQG9IGMnoMoCoYeGyHWhNKw/U4I7g4oovKxy/9OzKGy9
         awHWUffnI7NRNltMhMP27Hzo7JovG+Kgq69Qcnp3mxxVdTy9O5eN6d9wzTBP9J+unnoT
         giqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LckyfNVoYdL232Tax7sXGyYKzM8LJlSJVTs/P20Tba4=;
        b=ulwSBR1xQnsfXeWuy8PBTUug0cEkZVV65mT3ESL+WJx9qubAjtZiCdC0YEEOOGTGHM
         Xvtu/e+b7EAEAwxd4KjUJ+XoCYYHkuegBn75I2rmuyL4+GFzm2EKN39zNxQNAtLETDnH
         YDcUacKSGZql4/zhHknZg/FWC20scoDeYuan+RoRLl7nvyNYFsb35okFLGjlrQue2d4b
         rWWI9XmKjsZIq0KP9R5Pu0aoEK9xVdiuXmTcRrdA+qbXkwSrTSYqvZO9hditiQUJ4eIW
         UC/cvA/ChxOlLV7wE8sRpZ2HJj2hunc2e0KC6+JVc2ENNVhz2xa06awYZY/SaEB7x1ng
         humw==
X-Gm-Message-State: ACrzQf0hefXbOo2UyFNSjyYI9ikl4XWw8l2tmfGkRGXLEUC3Nm5PZuNS
        JqLVgqFqvM94mJo2QWQXVwFpaZ9ZcMI=
X-Google-Smtp-Source: AMsMyM6tuXJAUhCYpWnys+zpbu/MdeGL3PBwYKSokFKgLcqrQ85tNnrRnWNmUa/XI6KOI5AmDsB0dw==
X-Received: by 2002:a5d:52cb:0:b0:21a:3cc5:f5f4 with SMTP id r11-20020a5d52cb000000b0021a3cc5f5f4mr4779555wrv.367.1665783954727;
        Fri, 14 Oct 2022 14:45:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25-20020a7bc019000000b003c6b874a0dfsm3922084wmb.14.2022.10.14.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:54 -0700 (PDT)
Message-Id: <295beb89ab10f001724fb64fa55944d05ee29fc7.1665783945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:39 +0000
Subject: [PATCH v2 07/12] fsmonitor: prepare to share code between Mac OS and
 Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Linux and Mac OS can share some of the code originally developed for Mac OS.

Minor update to compat/fsmonitor/fsm-ipc-unix.c to make it cross-platform.
Mac OS and Linux can share fsm-ipc-unix.c

Both platforms can also share compat/fsmonitor/fsm-settings-unix.c but we
will leave room for future, platform-specific checks by having the platform-
specific implementations call into fsm-settings-unix.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                                      |  9 ++-
 compat/fsmonitor/fsm-health-linux.c           | 24 +++++++
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |  8 +--
 compat/fsmonitor/fsm-settings-darwin.c        | 57 +----------------
 compat/fsmonitor/fsm-settings-linux.c         | 11 ++++
 compat/fsmonitor/fsm-settings-unix.c          | 62 +++++++++++++++++++
 compat/fsmonitor/fsm-settings-unix.h          | 11 ++++
 config.mak.uname                              |  1 +
 contrib/buildsystems/CMakeLists.txt           | 17 ++++-
 9 files changed, 138 insertions(+), 62 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (89%)
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.h

diff --git a/Makefile b/Makefile
index 9553d590824..bbbde00ce49 100644
--- a/Makefile
+++ b/Makefile
@@ -2036,13 +2036,20 @@ endif
 
 ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
+	ifdef FSMONITOR_DAEMON_COMMON
+		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
+	else
+		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
+	endif
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	ifdef FSMONITOR_DAEMON_COMMON
+		COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
+	endif
 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
 endif
diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
new file mode 100644
index 00000000000..b9f709e8548
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state)
+{
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state)
+{
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
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
 
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 6abbc7af3ab..2f5c6a88bf0 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,62 +1,11 @@
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
-#include "fsmonitor-settings.h"
 #include "fsmonitor-path-utils.h"
-
- /*
- * For the builtin FSMonitor, we create the Unix domain socket for the
- * IPC in the .git directory.  If the working directory is remote,
- * then the socket will be created on the remote file system.  This
- * can fail if the remote file system does not support UDS file types
- * (e.g. smbfs to a Windows server) or if the remote kernel does not
- * allow a non-local process to bind() the socket.  (These problems
- * could be fixed by moving the UDS out of the .git directory and to a
- * well-known local directory on the client machine, but care should
- * be taken to ensure that $HOME is actually local and not a managed
- * file share.)
- *
- * FAT32 and NTFS working directories are problematic too.
- *
- * The builtin FSMonitor uses a Unix domain socket in the .git
- * directory for IPC.  These Windows drive formats do not support
- * Unix domain sockets, so mark them as incompatible for the daemon.
- *
- */
-static enum fsmonitor_reason check_uds_volume(struct repository *r)
-{
-	struct fs_info fs;
-	const char *ipc_path = fsmonitor_ipc__get_path(r);
-	struct strbuf path = STRBUF_INIT;
-	strbuf_add(&path, ipc_path, strlen(ipc_path));
-
-	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
-		strbuf_release(&path);
-		return FSMONITOR_REASON_ERROR;
-	}
-
-	strbuf_release(&path);
-
-	if (fs.is_remote ||
-		!strcmp(fs.typename, "msdos") ||
-		!strcmp(fs.typename, "ntfs")) {
-		free(fs.typename);
-		return FSMONITOR_REASON_NOSOCKETS;
-	}
-
-	free(fs.typename);
-	return FSMONITOR_REASON_OK;
-}
+#include "fsmonitor-settings.h"
+#include "fsm-settings-unix.h"
 
 enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
 {
-	enum fsmonitor_reason reason;
-
-	if (ipc) {
-		reason = check_uds_volume(r);
-		if (reason != FSMONITOR_REASON_OK)
-			return reason;
-	}
-
-	return FSMONITOR_REASON_OK;
+    return fsm_os__incompatible_unix(r, ipc);
 }
diff --git a/compat/fsmonitor/fsm-settings-linux.c b/compat/fsmonitor/fsm-settings-linux.c
new file mode 100644
index 00000000000..2f5c6a88bf0
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-linux.c
@@ -0,0 +1,11 @@
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+#include "fsmonitor-settings.h"
+#include "fsm-settings-unix.h"
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
+{
+    return fsm_os__incompatible_unix(r, ipc);
+}
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-settings-unix.c
new file mode 100644
index 00000000000..6b43e26720e
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-unix.c
@@ -0,0 +1,62 @@
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+#include "fsm-settings-unix.h"
+
+ /*
+ * For the builtin FSMonitor, we create the Unix domain socket for the
+ * IPC in the .git directory.  If the working directory is remote,
+ * then the socket will be created on the remote file system.  This
+ * can fail if the remote file system does not support UDS file types
+ * (e.g. smbfs to a Windows server) or if the remote kernel does not
+ * allow a non-local process to bind() the socket.  (These problems
+ * could be fixed by moving the UDS out of the .git directory and to a
+ * well-known local directory on the client machine, but care should
+ * be taken to ensure that $HOME is actually local and not a managed
+ * file share.)
+ *
+ * FAT32 and NTFS working directories are problematic too.
+ *
+ * The builtin FSMonitor uses a Unix domain socket in the .git
+ * directory for IPC.  These Windows drive formats do not support
+ * Unix domain sockets, so mark them as incompatible for the daemon.
+ *
+ */
+static enum fsmonitor_reason check_uds_volume(struct repository *r)
+{
+	struct fs_info fs;
+	const char *ipc_path = fsmonitor_ipc__get_path(r);
+	struct strbuf path = STRBUF_INIT;
+	strbuf_add(&path, ipc_path, strlen(ipc_path));
+
+	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
+		strbuf_release(&path);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	strbuf_release(&path);
+
+	if (fs.is_remote ||
+		!strcmp(fs.typename, "msdos") ||
+		!strcmp(fs.typename, "ntfs")) {
+		free(fs.typename);
+		return FSMONITOR_REASON_NOSOCKETS;
+	}
+
+	free(fs.typename);
+	return FSMONITOR_REASON_OK;
+}
+
+enum fsmonitor_reason fsm_os__incompatible_unix(struct repository *r, int ipc)
+{
+	enum fsmonitor_reason reason;
+
+	if (ipc) {
+		reason = check_uds_volume(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
diff --git a/compat/fsmonitor/fsm-settings-unix.h b/compat/fsmonitor/fsm-settings-unix.h
new file mode 100644
index 00000000000..8a62971190b
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-unix.h
@@ -0,0 +1,11 @@
+#ifndef FSM_SETTINGS_UNIX_H
+#define FSM_SETTINGS_UNIX_H
+
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+/*
+ * Check for compatibility on unix-like systems (e.g. Darwin and Linux)
+ */
+enum fsmonitor_reason fsm_os__incompatible_unix(struct repository *r, int ipc);
+#endif /* HAVE_FSMONITOR_OS_SETTINGS */
+
+#endif /* FSM_SETTINGS_UNIX_H */
diff --git a/config.mak.uname b/config.mak.uname
index d63629fe807..9f716cfba81 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -165,6 +165,7 @@ ifeq ($(uname_S),Darwin)
 	ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
 	FSMONITOR_OS_SETTINGS = darwin
+	FSMONITOR_DAEMON_COMMON = unix
 	endif
 	endif
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 787738e6fa3..4c6e84da346 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -304,7 +304,17 @@ else()
 endif()
 
 if(SUPPORTS_SIMPLE_IPC)
-	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
@@ -315,12 +325,13 @@ if(SUPPORTS_SIMPLE_IPC)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
 	endif()
 endif()
-- 
gitgitgadget

