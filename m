Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C20EC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiCVSCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiCVSB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282C65D17
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so2451434wme.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=dHwEn4te6mWdYBuTv4fdl0TvCRo4PcZlcQd3hrhBpwosQtKNvXNgiE7+uefZebwHQu
         PW+xm0OXeqp18CqaDLTQEM5M1Idg6RqVBb4UUAjd3SH5OLqIeVAVM++NSCJmCo99qHYD
         Zs1vsdHABnidQzrzq5p464abgnsNJyo3HJ7mgi5yny7NExYbJ5F8zKevRY3vykEbKCOT
         yrciMUZuRvnsTDs0ArKeCDw7aug0q7xeKDD4h0OtFeBrnkR6ihf3VSY3WZucl+37nxkw
         Qg9CyRfazTG3IJ09Jf+94Y64E0Wad+o0ph/LucyJZ1CZC7EJoC8hU9WFtJWv50QUCR3f
         Vf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=hPkRmWOhb6vtNARhWGmZ8aJ0/o0uMsjjkCprj3+ry/krlLxUOhrfqMPCPC2MUJo3G5
         QNTjJ3OcG9jZl68Q7LeFldY+Rg3cHGzF85rxcS+zH1XuZVieGqNJ3GhlksglNpTeJipN
         9wr0fJmqYceGsxlIniGKJhuiPeDTyGd97pHg/+0tQoVBJ0EYAEk1hsCdc1cag1g31D0Q
         D4oGJqCuVREBjfQXkuTjhwoZxXNBLdF/kgXq09PuVV01jLVnEFAZ4kjmV9FWaYmor1lH
         ZaS5PvULZxA4rn2TyK+EAPkJZjF69DTXn4ZjTgYP6ip1lYVM5hd54iiL4ghSb5feVP7o
         ZCeA==
X-Gm-Message-State: AOAM530qsYCP/5s2beFUQDgZcZRqr3RwY4biawWwSoAWpbCi4RsOQ7KP
        KWOAMD3CHYzXkreJFLYo85tdheum8lQ=
X-Google-Smtp-Source: ABdhPJwwjkDqPCIoG1z4Nx9F0up2dTb0ocIlXIEuzhS2exgOFqyez67Ik3Ig7hXE+NGocqfiRYUszA==
X-Received: by 2002:a05:600c:1d88:b0:38c:b121:c669 with SMTP id p8-20020a05600c1d8800b0038cb121c669mr5054926wms.150.1647972029792;
        Tue, 22 Mar 2022 11:00:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00203db8f13c6sm15991238wru.75.2022.03.22.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:29 -0700 (PDT)
Message-Id: <2f8a42fdb93623053256939fdbb45cf02fb1c5c9.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:50 +0000
Subject: [PATCH v7 09/29] compat/fsmonitor/fsm-listen-darwin: stub in backend
 for Darwin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty implementation of fsmonitor--daemon
backend for Darwin (aka MacOS).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 20 ++++++++++++++++++++
 config.mak.uname                     | 10 ++++++++++
 contrib/buildsystems/CMakeLists.txt  |  3 +++
 3 files changed, 33 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-listen-darwin.c

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
new file mode 100644
index 00000000000..c84e3344ab9
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -0,0 +1,20 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "fsm-listen.h"
+
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	return -1;
+}
+
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsm_listen__loop(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/config.mak.uname b/config.mak.uname
index 26074f56bed..501970902da 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -157,6 +157,16 @@ ifeq ($(uname_S),Darwin)
 			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
 		endif
 	endif
+
+	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+	ifndef NO_PTHREADS
+	ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = darwin
+	endif
+	endif
+
+	BASIC_LDFLAGS += -framework CoreServices
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0963629db7f..ee0d7257b77 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -289,6 +289,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 	endif()
 endif()
 
-- 
gitgitgadget

