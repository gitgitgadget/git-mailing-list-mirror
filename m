Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBE7C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352015AbiCXQyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352165AbiCXQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E3C954AF
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so7576998wms.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=77SaOZDqR5GCe8rGTE1gWxph/6mABa7uqFiGsLfjuL0=;
        b=mYhTeF6VXbflWdGolHSYPNYElOhV+tjbQAjvs6qEP87Q6pwKFX43QHFWLqdnFTXmK+
         91NcbJg/vjETsRzGJbpLi1FmeSqlg5Ei4SatBWR0nkP0cdvNCqL2rWGWrSO020D/CrXm
         Ulw5VQyTFrZSl+j3kQ5yNdsgg9MwIEaXBIvfX24luXOXch7YU8rfkRbhAQQAN4lRZFXa
         5heTdiJzpAn4nwgTmyQe0KBO+3HUooGbNaV3TsIT9uiYYnhnPhoElRLt78r/0zuQNJ+K
         7lnb5vrtWgi/X0MTbnO5SvtOs3L3Tz0/Z8yZ583NsuaJ1IDypiMk7xqDriJCKO5FzcDp
         mciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=77SaOZDqR5GCe8rGTE1gWxph/6mABa7uqFiGsLfjuL0=;
        b=ddzcxpqqSHLV/Sm7PW6RTtJ8ELuDCi7xfPUpcIdh3diBMN1tzm4qK6oJ5GMraQzjfk
         5zAROr3FhQBeaRPXMt0tOEOr4+AgdbZ46/07a8JSzvr3TiRgoqGXWcr4kfLDFVls1eCX
         d3X1RoFYel9axf4yuWyn7U3nWI1hgngOhZtIPuYEq0OkGBetmXVWStSzD9sDR4NXxntA
         sdLpxtVHRPhPlwdpW4T9kRiRi/U4KLZ26+erVvynO5cp5swqQVJrehCvyKp77MC/8s2x
         O5bhjfPWz52jg142HbgpVVApg7Wa+Uc5Az2voo7XoKgpXU0TKj0LOpwOqoZOGj6nKp9d
         mvzg==
X-Gm-Message-State: AOAM531qWUV0ZTgQ7p7p3lh6AeGI5dj50MTqeHQYH229bry1dUvV0Pyl
        w+mvSSXcb79+5xJDY77XmuCHxcRWg4I=
X-Google-Smtp-Source: ABdhPJx87NLRkZL+xlpkWzttH89RfppMIr6BN8s23LKPkDk9tRLN44zAtKi3jcvaRrcw5x9R5O2knA==
X-Received: by 2002:a7b:c774:0:b0:38c:9f3f:4bdd with SMTP id x20-20020a7bc774000000b0038c9f3f4bddmr15660752wmk.28.1648140688865;
        Thu, 24 Mar 2022 09:51:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020adfbb0d000000b00203e0efdd3bsm3166959wrg.107.2022.03.24.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:28 -0700 (PDT)
Message-Id: <b2599bb9d2e265ab8e1b2b5297356176dad04166.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:58 +0000
Subject: [PATCH v4 05/27] fsmonitor-settings: stub in Win32-specific
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
 fsmonitor-settings.c                  | 12 ++++++++++++
 fsmonitor-settings.h                  | 13 +++++++++++++
 6 files changed, 54 insertions(+)
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
index 86c09bd35fe..8ff55f8c3fd 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -33,6 +33,18 @@ static int check_for_incompatible(struct repository *r)
 		return 1;
 	}
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+	{
+		enum fsmonitor_reason reason;
+
+		reason = fsm_os__incompatible(r);
+		if (reason != FSMONITOR_REASON_OK) {
+			set_incompatible(r, reason);
+			return 1;
+		}
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 8654edf33d8..4b35f051fb1 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -30,4 +30,17 @@ int fsm_settings__error_if_incompatible(struct repository *r);
 
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

