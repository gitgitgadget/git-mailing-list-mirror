Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B1ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIMU1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIMU1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:27:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789665830
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so22592470wrb.4
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=JX3WAV1jjQRPaHehTxErQ+t1OCHDlaNX5WB3+LJP2Cg=;
        b=Z6D+yXgS4ShVu8KymyB46C9nek3qcF2b2K2CB2D95Y3oUBmAVFE/IA2Wv3ppyyKIBU
         iHhF9YZQh1Fxln6xdK4snbJVZa645vUGSSb6uWsTR4raeAhnggNQDU/NKiVLyXX/YNxq
         wJfKr4AMmCwRemV9+mBfFeYBh7DsDXGujHzt4uCJbNzHH2rP82qHZE6zdOu9UBF9GyX7
         hMNPXMC3Xzz9+AUIm+ajaFjNlOWiVGgmFmSFjf7Nk3zquqtHwnTJhZoWewh58d2mNypZ
         uo91lRyXjer53Yg/9QeRwh0gKcotkKydCeSNJa3bVAvXYZXQWR68cEuFRfToHO4Gy0MX
         8jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JX3WAV1jjQRPaHehTxErQ+t1OCHDlaNX5WB3+LJP2Cg=;
        b=Prmxobjg9mEd6Wu10tKdHgAzEVnUh+V2smX+wZ2WefoWRQB/hbUqkqzhuEe7qhb6Ip
         KlI6YQpz28BAjQ9OrllLtbgvT3mTcVX50rnF457r+/K2Tr7U71QxENGk9hGsbaJv8VG0
         NHeCTzcG9icwMp5P9kVr6jMHX5PHG9BUJMdlSMciPY9PjVBqqrbdV7eezkeFVNkDqX3c
         BWVMD05MLJ0atre39rge9FhoXEhbTaUmXAI4Ybqm3gksO48+qddlpCeWLSz6asga81gz
         478LTV6HQ4S1UnTwts1yszlv8qm68nNcMmMMn4fPWocs/2u5RijybbV89bSQS/hL4gCC
         2QZQ==
X-Gm-Message-State: ACgBeo0oWZTeKZz/p8+fPc8c4OBzBOPfDxdJaZl3X57qB3mhprFe7w2z
        EytAYjgZLjZt15nyvWg6yILbd8xIBiQ=
X-Google-Smtp-Source: AA6agR46UlSxWJ2LZ7Ak5VG7wWuV2047fLG28YATx6gt63PmdJVmXuB30/1CiEK6z+t0CF92FHI/DA==
X-Received: by 2002:a5d:698f:0:b0:22a:bdfb:b00b with SMTP id g15-20020a5d698f000000b0022abdfbb00bmr3528276wru.355.1663100863645;
        Tue, 13 Sep 2022 13:27:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b00229d55994e0sm11173559wrp.59.2022.09.13.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 13:27:43 -0700 (PDT)
Message-Id: <edef029a298a44ba59d19db53c2f7ba07e93aec6.1663100859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 20:27:35 +0000
Subject: [PATCH v6 3/6] fsmonitor: relocate socket file if .git directory is
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
index b026f3e8cf0..5cd5ad818b8 100644
--- a/Makefile
+++ b/Makefile
@@ -2033,6 +2033,7 @@ ifdef FSMONITOR_DAEMON_BACKEND
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

