Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85449C77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDVUST (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjDVURv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC6211C
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f196e8e2c6so11967165e9.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194667; x=1684786667;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caqEkUUJKCXtt2lsnjPJjPm3xKgdR7jcbub+VtGBaIg=;
        b=izfYd6PuUdq0wQBjTXe93iXlYqhQNlXM6aOxNeoshnqBfh1C/BV23omE9RZ8KaqnQc
         L6XgGhwQxAVeAnEhwvGR8WQqv8h1E8N889l2E1s2zOpJzw8v0rZqAqgCThtDv8a5xnrr
         9xmkK1sMhxY5fkAfQAyHstFwEuj98GWebsefd0YeJuMnBWSan4+qCdaaPvvrTiUt7Fkb
         +FIfgnNeH941TsqVJ5BIs0batQfG3IebL49+K15ojfyS/9NcCvGB0D+GqT7ORBodJh80
         gEV8XAGqPwWYqddH3mBNIyq7WCoPlRGLFTZFnPOWCDB+ttL9ce356Pak3v7FZPHWxr+J
         GS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194667; x=1684786667;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caqEkUUJKCXtt2lsnjPJjPm3xKgdR7jcbub+VtGBaIg=;
        b=L65SozV/tv279ZY1YRiuoli+tgMHgcjV9eEpBARtjpuD8WHdwT/pUwmJ/K71/oYkKb
         TSB865y6jVovx/GyRjiSuBr9E0FrdEfHX8fMST2GoXVGhSvm9FqLGpYMfNzMJVuNTtEe
         r0iAsYIjjsS9bUwsascS7zIyJ89JvU8RfGkLTyq1tJJXjffKmYqk0rWEOHY1/9WdjOc7
         2SwpyOb8bAXiTjUQiGvXugGy/Ec04LPs4GL5zQ3RHOIDHkjFo1M7MNj6ZvxAXfUBp1Kt
         if7Mz7PHpadglE8lCX7eFUX5hVtks0NTSVdr4zHX4K4m3qRHNBneZRlrD/OEJH9/s8/M
         jwbw==
X-Gm-Message-State: AAQBX9dkSSxlGbSLwqnYYQstndqYu3uvbhgtd/X5SslsbPFx2UciBCWG
        oiDe2+LWE6KUqgwCMWtqFe+MAtQDFRs=
X-Google-Smtp-Source: AKy350a+ySs77d7yB5i0rSKngXo9jJU/grmGLqABB9zUUyKyArZS4cPpJdWAVBqR0zNBpldT3VV4XA==
X-Received: by 2002:a7b:c84c:0:b0:3f1:73c1:d1ad with SMTP id c12-20020a7bc84c000000b003f173c1d1admr4589651wml.35.1682194666892;
        Sat, 22 Apr 2023 13:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z19-20020a1c4c13000000b003f173419e7asm7972682wmf.43.2023.04.22.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:46 -0700 (PDT)
Message-Id: <80ebd46c862456bc726748ed11d7cf1bb1ba0e86.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:25 +0000
Subject: [PATCH v2 18/22] fsmonitor: reduce includes of cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/fsmonitor/fsm-health-darwin.c | 2 +-
 compat/fsmonitor/fsm-ipc-darwin.c    | 2 +-
 compat/fsmonitor/fsm-listen-darwin.c | 2 +-
 fsmonitor--daemon.h                  | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index b9f709e8548..4c291f8a066 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsm-health.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index bc68dca0cae..793073aaa72 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 18c0e3913dc..23e24b4b374 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -23,7 +23,7 @@
 #endif
 #endif
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index e24838f9a86..70d776c54f6 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -3,7 +3,6 @@
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
 
-#include "cache.h"
 #include "dir.h"
 #include "run-command.h"
 #include "simple-ipc.h"
-- 
gitgitgadget

