Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C8C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353611AbiBKU4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353514AbiBKU4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A4CFC
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s10so3657201wrb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dlvkZAttyPi8xzLxTX0k7UH8DRN8Z/IbRQPwhiWRp1k=;
        b=JXAt1nTHxFhcolMY/mjbeuC6L8f8+WBOXq7j7st4NdBRS76KMEJq/a1Jxse3yDiCib
         8jPADO7D6vMgHUCZD1XJpxFrfBUICucwmlaE20woE0JcL9SBV8LaHkdvKw1edo2IyshL
         j38n90pkHNIKMF5Jf/0zMRTI35B5xoFrt8lixvhTq++2L3Mu/oGbyewmlA2H/XjEUVdF
         wVs/Vn99GSZmen+uPIPEKXy79vjabc3vj4lGjIKLUzwC7OSD4p3hgzRvL1FJdi//8x//
         smeqxIoOOAp+mw5TTvVcj6txolTLdC7lhEC0WXZIoue46vHqu/59GmyIQvBtada9aEqv
         DAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dlvkZAttyPi8xzLxTX0k7UH8DRN8Z/IbRQPwhiWRp1k=;
        b=pjUB07uVxBVzoUp0hRYsdLNEQ/6aSChuZ4bcCA9hGKFxdgE5SBYVKWDuVV1umw7taX
         GKWxADce5hqVCiGoYEcIA1u8tHMfIqqt9Ruod37gK14Ri2aNPaf9iKdUxFhWqPgEboxl
         Pc1u+UIecBgmKXOou4gRLkJ23U+OZPb/+BQgnV1o1u9IMTZPh0kX+jby/eSweojHCXTN
         vtq+Er98wJ7HHx7ZkaMLPQZTdnWmTWdy2YRlB8+IoJx2efmtZ0toeXV9Ey85q8lLO/Gn
         6CXmrjCMsnxDyXggPe+rVT6l9yKdm22qVSVIzOimue3tkEuiO0QNfEI4Y0ENpMUYJrSx
         8wOg==
X-Gm-Message-State: AOAM532V7PaumyehpzGqxPKO1nQdUCbu+j2KCzKe9dL0wqgJxKHpGpGY
        hmZIwgkiFjyUA5hBXROd+E3YO58zW7Q=
X-Google-Smtp-Source: ABdhPJz5EyGrEyrjYZtCuql8YX6/I8ofmREWCPoWsPkaFdDn9Pgji/fsHNVPLxd+vhInmTvIWvGNtQ==
X-Received: by 2002:adf:e0c3:: with SMTP id m3mr2566048wri.216.1644612988388;
        Fri, 11 Feb 2022 12:56:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm2535685wrp.25.2022.02.11.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:28 -0800 (PST)
Message-Id: <7de3d01ccccb7afce6a9b66bb834402541d1ae1c.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:58 +0000
Subject: [PATCH v5 09/30] compat/fsmonitor/fsm-listen-darwin: stub in backend
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty implementation of fsmonitor--daemon
backend for Darwin (aka MacOS).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
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
index 9c88e1b244e..d65a5eb807c 100644
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
index 1525a81109c..7da31c38f48 100644
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

