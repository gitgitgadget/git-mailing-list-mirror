Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6DCC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJIOhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJIOho (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692E275C8
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso3820739wmq.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxZ+ekCnhsjFbvNwp8F7hayS+Nmqoxn8PLvM43nMJw4=;
        b=ZMUbfTJ9kfunrJmA8TYP86ROD+eGhehSFp5vwZoPNXWz+fjVbkuxCIikxSc8vilGd+
         zrO2aQLuyZ90D29xuNjtcXLb2EkaFePXiOIqWQZbFjpogTRV8xRu9pm4RNcFAGaEWOjt
         lKVzUz2Z0Yr9+0pk3aPmlSTIwSze7qZsBMqpC8l3jdWpMMbTUbw/59gK0ANxwAjl93o7
         LoqtJjIQr85W/lo4t2KJWCBOJNPZNz6ywWcuPxCapS1P5iL5EuJwmA8CpO3cg68peIIK
         CWgW61OP54gjK7VXOgjcFM1/vU0Bbi4Pld2aRPZoER05ZdPXocMwd1vYhM06Ec6f3XDA
         XiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxZ+ekCnhsjFbvNwp8F7hayS+Nmqoxn8PLvM43nMJw4=;
        b=sMKFGt+6/fC/R5DBDQ4Ddqu8j4ZGtzheidZp4fNGJzozTaDvNiJBiBvWJGSaeG59DX
         ZFwblthR6Z/sDaFmngYxIUB/1bDz8RxIEdrkwdkerq+uDO+L4CjpEzyuyH3L4xN+qaCB
         PqA1wCz8SDjTN8jENCl1l/rJgFP/5zj8Wqa4vmPKJ8KcBz7u8EqSoEdIPNo3YJnXL0uJ
         TKo4P/QkRHEar9i2tEy4FH8NldH0Jv4LI7NbqJms5EiXWXWZbMTCnQmK2byD5GJABvRn
         X4ZFlcPJt+d2q5qe5uzeCbuiIXdhetY+tXYx1ot3ONL37eiUCBXYMiKEbdh2b7amuDEw
         Lanw==
X-Gm-Message-State: ACrzQf1qH8J1b+yKuz+XM5RHIDT+oy8iOoYbtMw6/1ql4DR5YJjz/LTd
        QfRDzRE39gUVrmga2XzehGOg9YWXxRk=
X-Google-Smtp-Source: AMsMyM74L7VZhA2kCIINu9Ndj3NTYxaikSUej4154kh5z8xzJD6pP69923z7jiciw2+an6YqOfOwgQ==
X-Received: by 2002:a1c:ed0b:0:b0:3c1:d16e:a827 with SMTP id l11-20020a1ced0b000000b003c1d16ea827mr9584120wmh.127.1665326261640;
        Sun, 09 Oct 2022 07:37:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d4886000000b0022cc6b8df5esm6867589wrq.7.2022.10.09.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:41 -0700 (PDT)
Message-Id: <7bf1cdfe3b259f7135f3a50dcdd653563d5e19f6.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:28 +0000
Subject: [PATCH 02/12] fsmonitor: relocate socket file if .git directory is
 remote
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

If the .git directory is on a remote filesystem, create the socket
file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                               |  1 +
 builtin/fsmonitor--daemon.c            |  3 +-
 compat/fsmonitor/fsm-ipc-darwin.c      | 52 ++++++++++++++++++++++++++
 compat/fsmonitor/fsm-ipc-win32.c       |  9 +++++
 compat/fsmonitor/fsm-settings-darwin.c |  2 +-
 contrib/buildsystems/CMakeLists.txt    |  2 +
 fsmonitor-ipc.c                        | 18 ++++-----
 fsmonitor-ipc.h                        |  4 +-
 8 files changed, 78 insertions(+), 13 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c

diff --git a/Makefile b/Makefile
index ffab427ea5b..feb675a6959 100644
--- a/Makefile
+++ b/Makefile
@@ -2039,6 +2039,7 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 2c109cf8b37..0123fc33ed2 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1343,7 +1343,8 @@ static int fsmonitor_run_daemon(void)
 	 * directory.)
 	 */
 	strbuf_init(&state.path_ipc, 0);
-	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
+	strbuf_addstr(&state.path_ipc,
+		absolute_path(fsmonitor_ipc__get_path(the_repository)));
 
 	/*
 	 * Confirm that we can create platform-specific resources for the
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
new file mode 100644
index 00000000000..ce843d63348
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -0,0 +1,52 @@
+#include "cache.h"
+#include "config.h"
+#include "strbuf.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(struct repository *r)
+{
+	static const char *ipc_path = NULL;
+	SHA_CTX sha1ctx;
+	char *sock_dir = NULL;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (!r)
+		BUG("No repository passed into fsmonitor_ipc__get_path");
+
+	if (ipc_path)
+		return ipc_path;
+
+
+	/* By default the socket file is created in the .git directory */
+	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
+		ipc_path = fsmonitor_ipc__get_default_path();
+		return ipc_path;
+	}
+
+	SHA1_Init(&sha1ctx);
+	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	SHA1_Final(hash, &sha1ctx);
+
+	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
+
+	/* Create the socket file in either socketDir or $HOME */
+	if (sock_dir && *sock_dir) {
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	} else {
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	}
+	free(sock_dir);
+
+	ipc_path = interpolate_path(ipc_file.buf, 1);
+	if (!ipc_path)
+		die(_("Invalid path: %s"), ipc_file.buf);
+
+	strbuf_release(&ipc_file);
+	return ipc_path;
+}
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
new file mode 100644
index 00000000000..e08c505c148
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -0,0 +1,9 @@
+#include "config.h"
+#include "fsmonitor-ipc.h"
+
+const char *fsmonitor_ipc__get_path(struct repository *r) {
+	static char *ret;
+	if (!ret)
+		ret = git_pathdup("fsmonitor--daemon.ipc");
+	return ret;
+}
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 699f0b272e6..7241c4c22c9 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -26,7 +26,7 @@
 static enum fsmonitor_reason check_uds_volume(struct repository *r)
 {
 	struct fs_info fs;
-	const char *ipc_path = fsmonitor_ipc__get_path();
+	const char *ipc_path = fsmonitor_ipc__get_path(r);
 	struct strbuf path = STRBUF_INIT;
 	strbuf_add(&path, ipc_path, strlen(ipc_path));
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5482a04b3ce..787738e6fa3 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -308,6 +308,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
@@ -316,6 +317,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..c0f42301c84 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -18,7 +18,7 @@ int fsmonitor_ipc__is_supported(void)
 	return 0;
 }
 
-const char *fsmonitor_ipc__get_path(void)
+const char *fsmonitor_ipc__get_path(struct repository *r)
 {
 	return NULL;
 }
@@ -47,11 +47,9 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
-
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
-	return ipc_get_active_state(fsmonitor_ipc__get_path());
+	return ipc_get_active_state(fsmonitor_ipc__get_path(the_repository));
 }
 
 static int spawn_daemon(void)
@@ -81,8 +79,8 @@ int fsmonitor_ipc__send_query(const char *since_token,
 	trace2_data_string("fsm_client", NULL, "query/command", tok);
 
 try_again:
-	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
-				       &connection);
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
+						&options, &connection);
 
 	switch (state) {
 	case IPC_STATE__LISTENING:
@@ -117,13 +115,13 @@ try_again:
 
 	case IPC_STATE__INVALID_PATH:
 		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
-			    fsmonitor_ipc__get_path());
+			    fsmonitor_ipc__get_path(the_repository));
 		goto done;
 
 	case IPC_STATE__OTHER_ERROR:
 	default:
 		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
-			    fsmonitor_ipc__get_path());
+			    fsmonitor_ipc__get_path(the_repository));
 		goto done;
 	}
 
@@ -149,8 +147,8 @@ int fsmonitor_ipc__send_command(const char *command,
 	options.wait_if_busy = 1;
 	options.wait_if_not_found = 0;
 
-	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
-				       &connection);
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
+						&options, &connection);
 	if (state != IPC_STATE__LISTENING) {
 		die(_("fsmonitor--daemon is not running"));
 		return -1;
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index b6a7067c3af..8b489da762b 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -3,6 +3,8 @@
 
 #include "simple-ipc.h"
 
+struct repository;
+
 /*
  * Returns true if built-in file system monitor daemon is defined
  * for this platform.
@@ -16,7 +18,7 @@ int fsmonitor_ipc__is_supported(void);
  *
  * Returns NULL if the daemon is not supported on this platform.
  */
-const char *fsmonitor_ipc__get_path(void);
+const char *fsmonitor_ipc__get_path(struct repository *r);
 
 /*
  * Try to determine whether there is a `git-fsmonitor--daemon` process
-- 
gitgitgadget

