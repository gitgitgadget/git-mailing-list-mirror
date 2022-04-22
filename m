Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E48DC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiDVWjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiDVWh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D80916A5FB
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so5435064wmb.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=EYOAL+u7IxfRUZy675kGvU0ayhS+1wUVHVtvuimt3Q1NVMFCaIrPGw9Y6x2aoVGhxe
         wQdxKceKuHZd4ghEmgRFkQZ4o17cyrt/mpC8y2Vr2MAJT5vvgYuF5bbVZzMVwcELyj62
         3NnFF9UChAdR72ldyFmEqBdCsn9TGPJHuw5Sp/Vryt5kLY9nDdukh6DZfpQvcBscyeAL
         yigWpa5DHkhihJAhLAJw8bkufiFaUOQo+z3Qm01xKn6L4K+gWRWaIyeUZ+A5iOkpJfoo
         QA2Kjw5KQg5CrV7eyZFbfNqWe1YUGUKDf3QaBGp+PU9e4XekalkeYwUlta6g8BYYBweD
         FgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=kOiubZDZy1imOrJzhfd7FqaeN4DpPTf/xNBtqeCMizCosgvacJISfhpHC+WkjTJJL6
         YvbLAIvCRqCiYhQLLF7xWZp0zgo76xDuGdDmP2fDmuw0Kwv1qq0+LaxzzH0bI/7YqF08
         HwPD77iPWPuPnVCB7rnJwsAieEAqqyeVWlG5fd/OSATBqE+7GQ4VvlrP1KJLKtT5tknA
         nJ2vg+WwtFLAfEauudGkNYGh83zByXxyj/Kixkf84iAnEdhwSZbfi8jAhO87KpBSMu3z
         C31c9SGBfHyzjovjoxJDaPJmjRiMI52nEZI1foReW7E25Xom63sFOS/WFpzymIvgEQ+v
         C4gw==
X-Gm-Message-State: AOAM531yVKcI4Vw5oNbBy72rXtZFVoVD1Vb5ah3a109nTdkn4bz8LeNO
        MScLeeKGhMoTMcuye88WNJpb1AqRsTk=
X-Google-Smtp-Source: ABdhPJy3/JZoypesF2BCbwTIo2BdYmtIe/7zpV/E0a5XP0Ft4TdGcZZVMssYpZPWcAnP3AiQiVgFLA==
X-Received: by 2002:a05:600c:19c9:b0:391:d98d:2cf3 with SMTP id u9-20020a05600c19c900b00391d98d2cf3mr5861288wmq.136.1650663003527;
        Fri, 22 Apr 2022 14:30:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d64ed000000b0020a9e488976sm2844859wri.25.2022.04.22.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:03 -0700 (PDT)
Message-Id: <c50ed29a31045d99374eaddde1cb9229eae3b773.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:33 +0000
Subject: [PATCH v6 07/28] fsmonitor-settings: stub in macOS-specific
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 9 +++++++++
 config.mak.uname                       | 1 +
 contrib/buildsystems/CMakeLists.txt    | 3 +++
 3 files changed, 13 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
new file mode 100644
index 00000000000..7fce32a3c5b
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-darwin.c
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
index cf224768ad6..cf911d141f2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -163,6 +163,7 @@ ifeq ($(uname_S),Darwin)
 	ifndef NO_PTHREADS
 	ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
+	FSMONITOR_OS_SETTINGS = darwin
 	endif
 	endif
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 16705da2000..b8f9f7a0388 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -295,6 +295,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
 	endif()
 endif()
 
-- 
gitgitgadget

