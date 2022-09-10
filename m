Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198BEECAAD3
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIJUCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Sep 2022 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIJUCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2022 16:02:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57047BE37
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 13:00:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso4225056wms.2
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Hv/cPzF/fvyiQwf4EpBftGXrXXIIzkQVDoj6j7X7gus=;
        b=KwTXV7/S1Krn3h+jEjsdSat9c7Mhr2m2eHJDFOHEuxOP15H509TCQO7lAQa0YGgY2F
         99xsqpUEvxKXmQqWH5sTrosumEoBHExy0RgN/4FYjow0ZrFHKXi2jWKm5O+iAeJ21ATb
         PuPIDl17RmWdHCLXUfP6AmDqJecLI0NbLneHdtoijd+SRcoXjKOYS4fOB53j1FoDfl9H
         mY4NygCZ6fWUIllxmWnuSGVC/zF1Zlt3mDwP4RgLa4X0no0SqmcllZdZMkWAvXucMH6/
         eI4bGRS9gH8eh4WJvcgMmfOnDDxqEqyKQmBzKrIHP46DhwWX0vGwzOXJbvuQAybD+JcN
         YU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hv/cPzF/fvyiQwf4EpBftGXrXXIIzkQVDoj6j7X7gus=;
        b=zklOc4nQHPc/exP9wNdVbK+x+THspjilO6IBhF1Xaj3YwU2MmQWXFiVHOqaNIV13/F
         lBbUmm4oAV0iLLbeHK9YAbwJUDiG1opjDGE63FHyZKi3WNgQSnWdj/ZZ5mPI/GBwRi0E
         i12Vtw5LZkQnAB/xS4DfTaIAdAEpwV02HGKWKA5TbJQnR1JqPq6IVDU8rzWb3WUJDg/L
         R4KDKJl19JhFdCcJlz00k4gIpVsmuyCzQqKWlGlgzVu8pJ8AXEH5cGlgTNJqe9+kzU1h
         nF4lT1uvxdobMgZhVlF1KY3YvFPJdgty8n7Tn6U3UcUpXHNT08EheeWwuBJE7xe2VnEM
         E6Yw==
X-Gm-Message-State: ACgBeo2Md2WeFOS+p2/9tiMywZGXBD2LUBvxIob3RK9JoTT/3RsskL5Y
        kDA9HGMLZS/xxFYBJX7Xip3xD+Sbbq0=
X-Google-Smtp-Source: AA6agR4YfB8g41Y6O10yTclgQlg9xPyFxyM7VczyDzVDNW8MH/nzNgEczYClBVJLi1ze/jxzkN1cKA==
X-Received: by 2002:a05:600c:3b07:b0:3b3:3ec4:6ccb with SMTP id m7-20020a05600c3b0700b003b33ec46ccbmr7046634wms.69.1662840036285;
        Sat, 10 Sep 2022 13:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe110000000b00229b76f872asm4080059wrz.27.2022.09.10.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 13:00:35 -0700 (PDT)
Message-Id: <28d08bcf80810f0453c9c9ff03d45dd0e5795961.1662840031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Sep 2022 20:00:29 +0000
Subject: [PATCH v5 2/4] fsmonitor: relocate socket file if .git directory is
 remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If the .git directory is on a remote file system, create the socket
file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                            |  1 +
 compat/fsmonitor/fsm-ipc-darwin.c   | 46 +++++++++++++++++++++++++++++
 compat/fsmonitor/fsm-ipc-win32.c    |  4 +++
 contrib/buildsystems/CMakeLists.txt |  2 ++
 fsmonitor-ipc.c                     |  2 --
 5 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c

diff --git a/Makefile b/Makefile
index 265fc585286..cf9c51040a0 100644
--- a/Makefile
+++ b/Makefile
@@ -2037,6 +2037,7 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
new file mode 100644
index 00000000000..afaca96dab9
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -0,0 +1,46 @@
+#include "cache.h"
+#include "config.h"
+#include "strbuf.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(void)
+{
+	static const char *ipc_path;
+	SHA_CTX sha1ctx;
+	char *sock_dir;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (ipc_path)
+		return ipc_path;
+
+	ipc_path = fsmonitor_ipc__get_default_path();
+
+	/* By default the socket file is created in the .git directory */
+	if (fsmonitor__is_fs_remote(ipc_path) < 1)
+		return ipc_path;
+
+	SHA1_Init(&sha1ctx);
+	SHA1_Update(&sha1ctx, the_repository->worktree, strlen(the_repository->worktree));
+	SHA1_Final(hash, &sha1ctx);
+
+	repo_config_get_string(the_repository, "fsmonitor.socketdir", &sock_dir);
+
+	/* Create the socket file in either socketDir or $HOME */
+	if (sock_dir && *sock_dir)
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+	else
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
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
index 00000000000..769a88639f6
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -0,0 +1,4 @@
+#include "cache.h"
+#include "fsmonitor-ipc.h"
+
+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index b88494bf59b..7e7b6b9a362 100644
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
index 789e7397baa..caad2e246a0 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -47,8 +47,6 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
-
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
 	return ipc_get_active_state(fsmonitor_ipc__get_path());
-- 
gitgitgadget

