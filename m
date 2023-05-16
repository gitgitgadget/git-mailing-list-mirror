Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D2C7EE26
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjEPGex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjEPGeh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0740E9
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so3061627f8f.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218865; x=1686810865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBdU8QJhKCk1B/G4eOQLm2KmxA0Lmdg83Sx6v70jfHg=;
        b=Zk0h9Cxk4tGJo+OgDpTuH6zoHB0FSBG9jIEwytqKcS3XQfElEL62ZPwtTq2qzGU9vx
         LDDvPT/zCe4m0OsyuwHOcSPSbeDA9amYKc1zs/O7oUZrla+suke3Zmu6xkle1kR7eznA
         Irh4PfBcejQT93U1oOqGJLLvxd1rULx+/2RTczVwo1ooLyZc+qccvyUNsVYS1IVGpxz5
         eDDlah5miowmX0p9FhC9DfaBLhe0p/x5LH+tqqXyaOmwXmo3m10aetyE5ruVVyV5agUS
         CvNNLGiQ8VWH3BCAPlDO6W1jA+BjDQr2jOSMaJAt+lT4vtYS3+4P9OvdgUlLLlnwA9VT
         Krdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218865; x=1686810865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBdU8QJhKCk1B/G4eOQLm2KmxA0Lmdg83Sx6v70jfHg=;
        b=Z3mnRxXw36vcUu2pf2xC+Qxj7dCD8lm7rEhrsivcnBjKWO0vx/NWlmBteolWlXV4X0
         lcZjHHZqENMXLgHreO4C3s3TSdEVy8csH2NYAaawVJ/czFMpV34FMexrrIH2HtA+f5KS
         16izr4g9YZNNMkV4d2Y9D8YRzl2PnrIQSfxgHQOsn2TOQfkMiShwnGR7yDDF67pNbpnt
         3WKRPvEfEXthYM+Lco9Bfa1ryhTf20bqFsvy89aXC0wWCy3dcgwVrEA/KojEOcyKKmDG
         WiIv3GvXPha6ER4Fe22hSH53wGeBm4c2Yvv4JY8jI96p4Mw7C05bgowBIbggDRgTDv25
         Ap+Q==
X-Gm-Message-State: AC+VfDy6fpmjC2LargNBGzi/SzSKRQxd/XIq48f+eSxQuOgwppGCQ9+p
        OBOPJ3OuRaEQCotd4NdiEOmtUNZ6jVo=
X-Google-Smtp-Source: ACHHUZ7YcOg125Xl2a+uyKvoH0+4SHga6BYL5uxXFE/r+tOG7a7ObptqAa9PA0qdbB8HN00EtP/hBA==
X-Received: by 2002:a05:6000:11cd:b0:306:2638:6fea with SMTP id i13-20020a05600011cd00b0030626386feamr28240851wrx.54.1684218865130;
        Mon, 15 May 2023 23:34:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d644c000000b003062c0ef959sm1368168wrw.69.2023.05.15.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:24 -0700 (PDT)
Message-Id: <706e02727fc3a4b1ea3b4d76349fbadf8412d98b.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:49 +0000
Subject: [PATCH v3 09/28] run-command.h: move declarations for run-command.c
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h       | 3 ---
 exec-cmd.c    | 3 ++-
 run-command.c | 2 +-
 run-command.h | 2 ++
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 891e5fec744..d31b1515069 100644
--- a/cache.h
+++ b/cache.h
@@ -555,7 +555,4 @@ int checkout_fast_forward(struct repository *r,
 			  const struct object_id *to,
 			  int overwrite_ignore);
 
-
-int sane_execvp(const char *file, char *const argv[]);
-
 #endif /* CACHE_H */
diff --git a/exec-cmd.c b/exec-cmd.c
index 1e34e48c0e4..1d597e84ea7 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -1,10 +1,11 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "path.h"
 #include "quote.h"
+#include "run-command.h"
 #include "strvec.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/run-command.c b/run-command.c
index d4247d5fcc6..1873d0ba8e7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "run-command.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/run-command.h b/run-command.h
index 072db56a4df..9e47f91d462 100644
--- a/run-command.h
+++ b/run-command.h
@@ -564,4 +564,6 @@ enum start_bg_result start_bg_command(struct child_process *cmd,
 				      void *cb_data,
 				      unsigned int timeout_sec);
 
+int sane_execvp(const char *file, char *const argv[]);
+
 #endif
-- 
gitgitgadget

