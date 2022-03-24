Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0CC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348290AbiCXQyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352170AbiCXQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A8A996AD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so7496334wru.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=EBGczN8AHDY/I2r39PFcFpjuwf0dukUJPV/ROwlMU3GW3y6HXR2XFDv9vUi5lxit3k
         6sM0C12zOJBRSxYbRMdhmwQBePodtZ+9WGRK6qwV0i1NeQJSIIBuGrByRkKMmKUpgau2
         swCJGxujHx8hg4pCRh5M9xb6FoTn2OoXR+wKJfQf2CLgNg8LE4m5IRyBX/wDr+Ldny9u
         REOxbmWsGwvpE0ZbmVxof86Frep8SuqFhwdSKBNhhF5rf/8V+pBqyEBhgPq2Ne5/SS0g
         1NlvYGj8/w/MpNZ9EaYis4DnBQ237VKQOAKVhciuuln0bvDqn6kuLBe3P8KKNdJ8/JB4
         DhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=mJnClPD6HXcG/U3mRRCR827GwPNMM3EP0/4j+CAdBX2LPuPIXyafcAZdOgN+iH6S94
         VcbGvBQ+9tgwZ3zAI8Mvu4ZP1y8EoccIXFUxNs8/L6R7XTqqj5e3Y8WNM0gtJ9buJAUC
         K8KvjmNllwRTQTwVhToTDlm7lWSXk8cYR/x3BHph/199p+w1mnraOLuTI4Rwc9AUOGZn
         e1zcq65e0mUrPK+CS3cHgv6eHoNn+MV4aEzoJ9RSFFeQdr83xVCkJuTHmXz8ciw73sfp
         rNbQzgkLY3bOLQSYlrD/i9+i4iIXyOm0bzCGsjdcL6dzjJFmjDyTFWkF1fqV2ccSxUvs
         3VaQ==
X-Gm-Message-State: AOAM533rw3nqPDbOa/NsQL4A22IQefaqQF8J9UAV8X/mz5eeekD1Lu5i
        J121soEyETKzQ8tCe6ssYfmefO1O6aw=
X-Google-Smtp-Source: ABdhPJw8OTSi9Qw/sxHSntCHiL6F95GiaTZKP5o5Kk5rKLbefjYusDKVy/rN9bxijTOz152vHJnfDw==
X-Received: by 2002:a5d:64cf:0:b0:203:7b90:d5e2 with SMTP id f15-20020a5d64cf000000b002037b90d5e2mr5354958wri.558.1648140691290;
        Thu, 24 Mar 2022 09:51:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a056000156b00b002040674fd13sm3803694wrz.38.2022.03.24.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:30 -0700 (PDT)
Message-Id: <7652c79ab35f509d1064c7c7a20fb4d593e725a6.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:00 +0000
Subject: [PATCH v4 07/27] fsmonitor-settings: stub in macOS-specific
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

