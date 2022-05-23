Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACAC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiEWUNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiEWUM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:12:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C2F8CB05
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so228952wmr.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V2qiF7m8aSYTil3cDpJgcVX4oQxYDeEfetoj3qel4cE=;
        b=JlhH2lvwuGeinzGT2btLrzMNP2RdiG93uWsWK08w8eeKk3M0YxmMbUx10+EWYLmJcn
         X35Rn93GwAGjA8p8CckYIKVZWGzB+tPb+O7gF0z8TbirgJ90btDfKefNhmRSdr70vvj1
         bwRo6Rjb1oK2TNmlxCbfpBCdy+JPvzWVUxMFHkKqeWqHxyNZ/rRNrPyqyk8PQFZFg++k
         1DM37ukp7o3HERCcjjNrozNXEwo7pVwVKw3SzvGlm6DyGbpF9LlQVRgikUcxe7bvKVvm
         MSnYYKafSfAei08qab52UvwHDSwWRl3hZD6qXslnw+CGkQ0Ax/zWtzMvXRGQSjrP6wwf
         FA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V2qiF7m8aSYTil3cDpJgcVX4oQxYDeEfetoj3qel4cE=;
        b=w+qASRrpx5ghMlvSZ4l0DnQDbwbZLJotczgS/XwjY6+e0+P1XE+qZEwzRcWRuvXpw5
         vK/kZ9yDpa2dUrZXkx/2u59VCPulLUvO/5xhr69WTUa9oScw1Xd2TpFUiaJ2Uo7/O+jD
         PppnbBQrKg9ZpFSSS1pPB+vdsI1yYzTb2R2X+eavAH6boHaX2D6y+TWuSihAn7y4f5Sa
         E0qGfQwxqth3zJ3TJCGduK3Y58StDJa0sTBqVijSaep1Vo7vVc6XMvQOSxaDAfIcJNWo
         KVpR1zZngM/Jgoy9JSThJPPhvc9PbV0zmRi4V9bTEVJW5LrLwyYTkvVczBkPVDujxFLF
         nYcQ==
X-Gm-Message-State: AOAM532fqkXCt8TNNcGrNvuNBw/GXzwbuDrgEHog8Z0Bm7nfDjlwJfJv
        HOX7qUO6usWsUEyAxv9Sj+/xvrU2PmU=
X-Google-Smtp-Source: ABdhPJwsi8QMyFD7fUi0yKdddoRzmeOmvQZQEoMhkYXX4cHXr1bB2XwuheVvuSv/PN35EtoxfZ+dbg==
X-Received: by 2002:a05:600c:2148:b0:397:3d3e:dfcf with SMTP id v8-20020a05600c214800b003973d3edfcfmr645029wml.126.1653336776358;
        Mon, 23 May 2022 13:12:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020adfba09000000b0020d07d90b71sm11125392wrg.66.2022.05.23.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:55 -0700 (PDT)
Message-Id: <7cb0180a1ed95f9ebecc605cd1d968bced46d375.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:20 +0000
Subject: [PATCH v7 05/30] fsmonitor-settings: stub in Win32-specific
 incompatibility checking
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Extend generic incompatibility checkout with platform-specific
mechanism.  Stub in Win32 version.

In the existing fsmonitor-settings code we have a way to mark
types of repos as incompatible with fsmonitor (whether via the
hook and IPC APIs).  For example, we do this for bare repos,
since there are no files to watch.

Extend this exclusion mechanism for platform-specific reasons.
This commit just creates the framework and adds a stub for Win32.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                              | 13 +++++++++++++
 compat/fsmonitor/fsm-settings-win32.c |  9 +++++++++
 config.mak.uname                      |  4 ++++
 contrib/buildsystems/CMakeLists.txt   |  3 +++
 fsmonitor-settings.c                  | 10 ++++++++++
 fsmonitor-settings.h                  | 13 +++++++++++++
 6 files changed, 52 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c

diff --git a/Makefile b/Makefile
index daa21bed6c3..93604fe8ef7 100644
--- a/Makefile
+++ b/Makefile
@@ -475,6 +475,11 @@ all::
 # `compat/fsmonitor/fsm-listen-<name>.c` that implements the
 # `fsm_listen__*()` routines.
 #
+# If your platform has OS-specific ways to tell if a repo is incompatible with
+# fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
+# to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
+# that implements the `fsm_os_settings__*()` routines.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1979,6 +1984,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
+ifdef FSMONITOR_OS_SETTINGS
+	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2901,6 +2911,9 @@ GIT-BUILD-OPTIONS: FORCE
 ifdef FSMONITOR_DAEMON_BACKEND
 	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
 endif
+ifdef FSMONITOR_OS_SETTINGS
+	@echo FSMONITOR_OS_SETTINGS=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_OS_SETTINGS)))'\' >>$@+
+endif
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
new file mode 100644
index 00000000000..7fce32a3c5b
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -0,0 +1,9 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+#include "fsmonitor-settings.h"
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+{
+	return FSMONITOR_REASON_OK;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 501970902da..cf224768ad6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -450,6 +450,8 @@ ifeq ($(uname_S),Windows)
 	# These are always available, so we do not have to conditionally
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
+	FSMONITOR_OS_SETTINGS = win32
+
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -639,6 +641,8 @@ ifeq ($(uname_S),MINGW)
 	# These are always available, so we do not have to conditionally
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
+	FSMONITOR_OS_SETTINGS = win32
+
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ee0d7257b77..16705da2000 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -289,6 +289,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 7d3177d441a..f67db913f57 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -23,6 +23,16 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 		return FSMONITOR_REASON_BARE;
 	}
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+	{
+		enum fsmonitor_reason reason;
+
+		reason = fsm_os__incompatible(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
+#endif
+
 	return FSMONITOR_REASON_OK;
 }
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 8d9331c0c0a..6cb0d8e7d9f 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -34,4 +34,17 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 
 struct fsmonitor_settings;
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+/*
+ * Ask platform-specific code whether the repository is incompatible
+ * with fsmonitor (both hook and ipc modes).  For example, if the working
+ * directory is on a remote volume and mounted via a technology that does
+ * not support notification events, then we should not pretend to watch it.
+ *
+ * fsm_os__* routines should considered private to fsm_settings__
+ * routines.
+ */
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
+#endif /* HAVE_FSMONITOR_OS_SETTINGS */
+
 #endif /* FSMONITOR_SETTINGS_H */
-- 
gitgitgadget

