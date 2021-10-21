Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD5C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621056120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJUO14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhJUO1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2812CC061228
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s19so212857wra.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+eOVCZWU398AerN/KdOMojVbpQkA5PVr3C5mOF5Dy3I=;
        b=FPUIwMi3oDXUUVvSPWvbvqopuP3C/uQy+iJG6Q8IHIVX0n83ADIVVKvRfFYGXHqvZs
         95L5sq5SiAaz8qOXCXdMP14hnd7NrW0aHFP+CM16cj6gNKHQdp0ZBR8MOUCGI8Pu8VFj
         6/4/l+LxNNmARYXEuZ7jRfhvTnOU0KlB6Qpx2weDqGHshJpS4uGh8k2phAW+FC6v0C/9
         afOSQ8PK90Ttd0v8xSVffkqWwOBw1Qy1cxI/G1LUfxoXXBGXXN979I1b5lj0H9aEesvx
         MrmLpaCqQNbrS0U14r/7meowDQlaI8gq49rxkF32jLW2S6Ttd7XbzSQgV+nZvatsAF5Z
         8sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+eOVCZWU398AerN/KdOMojVbpQkA5PVr3C5mOF5Dy3I=;
        b=lOIPX0pZlVpj92NF5WsAAX6XkFr8sYYg0iFZCXnMQnmF4PUawJ1/PpD/lmaLdKxphe
         GyRa4Jt3ip1hsf/xx5HaX9cd9klOikUkwL2JLIixrv3IRzjOfNH1x1rQfWaC7AcvJDtX
         6pqfNS3cNY17qILjtNS6sraDoBf4kFceyUTm2gbCT8Eey8V+4YXHO5iq2yHC51Nrqtym
         YH6s6ogmFqqhHZt305a/JGQo40yGOMYmu9c9/zkS3SQ1ylcr4OXPrnMh+Kl0NCr+wFWu
         w4zYFG/DNhzVV9rV6LEiZ29eND3TrSscjQbiO2uZNpBU5jE/u2GXWd8OG6nLHDV/CDm0
         xeLQ==
X-Gm-Message-State: AOAM530KzNigBKTNm/YAcNsUPUZEqmiOiZ1n/GRaiFgjrvNixIIQR+Sg
        VzdUqA0fOTsj0L3jQ3wJyzdAaP2DlPo=
X-Google-Smtp-Source: ABdhPJx/+hZMunM7x07L0baMfeIk1hDGYcjwseP/pup0c2vSnzb5F5gNXPDgL6Vi+xLtCuN9TqGr2Q==
X-Received: by 2002:adf:a48c:: with SMTP id g12mr7717017wrb.341.1634826316822;
        Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm9456190wmi.0.2021.10.21.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
Message-Id: <ed5819e29f8743abb8812c21649a785bd451d78a.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:49 +0000
Subject: [PATCH v4 09/29] compat/fsmonitor/fsm-listen-darwin: stub in backend
 for Darwin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
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
index e6a900c6fd4..81f21d9e201 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -153,6 +153,16 @@ ifeq ($(uname_S),Darwin)
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
index 24a26743dcd..41395705ac6 100644
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

