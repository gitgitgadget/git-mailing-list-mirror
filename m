Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC4C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 15:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiBOQAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiBOP7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899BBD2FA
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so32988643wra.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BbYop8GOrn8UsIsEQsfMq536DDd+W/wsj9wQHKVyvIQ=;
        b=MaEnOtS0GnnYIHkyv4WXWIY1aLN9X4acO7SBf6xlaDhEivSskRV/N14AtFfqko1ruY
         W3rXShJx02Xv6YLcsy6zFYJEbdeVHwiMhEtxGdGihk+F9oj2ghTOAp1cNAGHxzrhbT26
         KWAUjPtQ2xlS6dTcH7Qn+XVpdb6yzn6jv2Y55HIHG/YpuUP9oDMCSJFMmrYSHrCCpHTf
         E5hCPDGGkOt8Y0aGaDk86KQNINc9wVx2Aob7Z+Zcu3vdx+uUl6Bi3HdIC5B6C2Hf9Txd
         3+p6cZu58yyIj9pfTgjWVIj5jFHiljOIAmV+7EWc0dR4w8FDfz4vFx/4AYb1h2v3cfC9
         sGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BbYop8GOrn8UsIsEQsfMq536DDd+W/wsj9wQHKVyvIQ=;
        b=GhaFGVXQBFpmhOrjPWOS7LvnxpBNYKjrVhDhrjBssrbp+xLH6mAlW1/HtKrPX9atil
         exr3D9KMagGPxMb6xE9EaZPI+hNM2CA1jEWnvmMxQRlQ0OrCIj0ktDVyWGW6EaJsIzWW
         ZHbB5BBWo6UYU1kYdvlLHBvFy+/+RgN3tJF9BYqUH7KH6et+j/P96hc6zf1MHAMiPNrT
         u1V7oBTmV/waEbbwu/rNhTjpdDgqySNFaLnTBT3mYwDEIcGvBsdaPytvhRX4XIbnN+7O
         xXAxgH0UDZkRw2H8dA1BWtKOfKxYSo2Xca6YwxlzaFQ6Z1MkISKGqleqfThsg6AWR7A5
         b4lQ==
X-Gm-Message-State: AOAM530u1mzcrlG8qweit9ZIn9Q4qBxBkh5/H0oXu4P/yU/stUutMdS+
        589RbXnntFwshGMP21uVLw/WtenAeWA=
X-Google-Smtp-Source: ABdhPJyFQchUWN4tKbrQywnhDXJVuVruyYR0ArNqsoXoMh+kOpfWCZ+n+oDG/KuXIzqK9N/6z2aEyQ==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr3728624wrk.221.1644940784009;
        Tue, 15 Feb 2022 07:59:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm20657251wri.93.2022.02.15.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:43 -0800 (PST)
Message-Id: <e5511ef0f8b1d20d2c3b8cce3e59161b14d9c37a.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:18 +0000
Subject: [PATCH 08/23] fsmonitor-settings: stub in macOS-specific
 incompatibility checking
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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
index 00000000000..176a6f5726c
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
+	return FSMONITOR_REASON_ZERO;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 219a04b4c66..529d58aae5d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -159,6 +159,7 @@ ifeq ($(uname_S),Darwin)
 	ifndef NO_PTHREADS
 	ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
+	FSMONITOR_OS_SETTINGS = darwin
 	endif
 	endif
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 7b8ea41967b..fc70dd2fc1d 100644
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

