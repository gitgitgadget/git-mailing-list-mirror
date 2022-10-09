Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5512FC433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJIOiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJIOhv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921E2716B
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r13so13626995wrj.11
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGYyUaPSgkCtAEhuDD2/mhECBE8b1dUOf87VuRjyQ4s=;
        b=HpQoD9d4ooJauiA9Y+N//RDhRRKucp6MmBj8oFyUOZnc9tT8rYhxZaJzQD3p+awH5i
         gPCg6sP4oA2YZISrmwqbClthxB+JP8TkBWbO0IgtDg8mDCl77Tg2MrbhMtHC/yq+AYFp
         QQngDAlGc1XXDrr3yy4wg7lR+m1hco+aNygU5AqpYvo9bKz+MqRRJoZYAeK7675T4hZt
         hMuVwRxdJEb6QWrFYQC42XcW+8qiV80mHN8vP7bKOdy8RJSoeCjKlLOk8EinxX/owlhE
         IUR2lwerMXoVrjWvC9li4VaNbCfBd6cDkZFbZ3stfszNGRb5YEuSUaEhqn6CxhB6UW9v
         O5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGYyUaPSgkCtAEhuDD2/mhECBE8b1dUOf87VuRjyQ4s=;
        b=QaGRyfuXPY04KPf7F6ddIqonQAEe6TE3Ckc93HrJl0LwD5UwIlra5ct4KKFgS3vp4L
         fDucF9AijRxd0rsPa7VWC7TSUQcaR/2GBE7Gi84QLMdnnbL2pZmh/GuLEFaDsSXTQ8Tp
         iiy0HAzR3FnRu56M6pE+rDcAgNZZkT38Yulp8b3LQIuo25xiv84Cl7Bfh+0VjJzg/fyr
         KdOY30BAk30DL/nHQeRYmCr1K1FIWdgqsIEn9QQlaKtpEs7Oub+QSSiRCzsSx6uqmZeG
         qz6nnBuKnKSNEfCA31CUnAK2njUu//DqNopr3zOFLL/Ep1B1O6k/kxrwjy2SrLAt/sZo
         vRhw==
X-Gm-Message-State: ACrzQf3k2nQ7C3YK+Tcznvn/I1ovj25Y8jF764UR/SApBsO2OR7RonDY
        i5bk/fvdHD2OvXL3LyuOuBpzWYImCwI=
X-Google-Smtp-Source: AMsMyM7SAgxEs3bblmVIBO8THAyD2HjxPeo3yjHeVeiEuqyDFf3IASsegGJEcx0eYqAAkfXCKKH8Jg==
X-Received: by 2002:a5d:4050:0:b0:22c:dfcc:675b with SMTP id w16-20020a5d4050000000b0022cdfcc675bmr8502476wrp.105.1665326269281;
        Sun, 09 Oct 2022 07:37:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bt7-20020a056000080700b0022e62529888sm6873080wrb.67.2022.10.09.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:48 -0700 (PDT)
Message-Id: <3a2db9aa07697fd4b66b533d1afee4f49cef0248.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:36 +0000
Subject: [PATCH 10/12] fsmonitor: enable fsmonitor for Linux
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

Uodate build to enable fsmonitor for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 config.mak.uname                    |  9 +++++++++
 contrib/buildsystems/CMakeLists.txt | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index d454cec47c4..04988266835 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -69,6 +69,15 @@ ifeq ($(uname_S),Linux)
 		BASIC_CFLAGS += -std=c99
 	endif
 
+	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+	ifndef NO_PTHREADS
+	ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = linux
+	FSMONITOR_OS_SETTINGS = linux
+	FSMONITOR_DAEMON_COMMON = unix
+	endif
+	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0b26a1a36e3..afabfcdefdd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -304,7 +304,16 @@ else()
 endif()
 
 if(SUPPORTS_SIMPLE_IPC)
-	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-unix.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
-- 
gitgitgadget

