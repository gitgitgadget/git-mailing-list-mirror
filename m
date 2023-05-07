Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9DC77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjEGDqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEGDqD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709935AE
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so4496475e9.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431160; x=1686023160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBdU8QJhKCk1B/G4eOQLm2KmxA0Lmdg83Sx6v70jfHg=;
        b=PrrH7x4PncpH+IbdM6RkYj1jjkSzvDRNYae2lx82PfbhKFYEi+cdtKjLnD8qpegbri
         8/pddcmgFDd1L7Ca1/HVQ2JHuTWHs8dwj4EjZVbZW7cqzIibtggTPCLRNcAvFtUM7g18
         vudMNUpJRgofVQb/+i6JsP47VLyWUBFxJoZqwjBz/nKmFJv32UGcYQo6hOVHALTvz1QK
         nNLKf17syjHKwK3JhzW39MylKyjZv0OctpfBRkVAEgRC8n2K/R9oOJakyxa/3jexoCqc
         2Qbz1KDmaKpV6Yb/C8Fr0CjimvkhQ5KNtAnI14hOniTrJ94oEDf0P7C7W1rs87CJ/QEy
         B7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431160; x=1686023160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBdU8QJhKCk1B/G4eOQLm2KmxA0Lmdg83Sx6v70jfHg=;
        b=e6ry5y8USu7vj311DviZ6dkNQdQto9nNQPkNFmiQHPVHOq3INttj2unPMi841EL8Rs
         3W2AxxRn0ybQU23GF1fbNAfgUeNy1NC+0wUvW8XhlgoQUNZVNayvYge/nb0Scbv79GCy
         NOES4WeMTG3wq+IGehghtVDTLH9mvOkBhYh2Upi+tiQ8vUG77oY1hfGh6G4MEk10hwgK
         GGkbGvyPgU8Sie7AX0Mh7lNsqA7JECSYYlByjfP26tLiYe7mteQiQsBXZdzplbwCDRfY
         z1UolayC/y8kR4J0gjArLjyoaKl293zkokqU2SD74g9p/f5ANRyqjfDYfxkBnfCxpvih
         5Qkw==
X-Gm-Message-State: AC+VfDwSjVlqJoChAHEPsmVdtEbBnjuL232wWAOE06y4hhXFQfAQ1/DQ
        IsxwlQ8XwnX+Za3Wvc+Nbxt9pjnhbQ0=
X-Google-Smtp-Source: ACHHUZ6NnywGVoaQMUTmPvstYEIrNqWshf600L6NnO5E9Wv23no5KqXRvsfQoCCe1TYCRhtudGZ/Lw==
X-Received: by 2002:a05:600c:2194:b0:3f2:507f:25a4 with SMTP id e20-20020a05600c219400b003f2507f25a4mr4018719wme.30.1683431159931;
        Sat, 06 May 2023 20:45:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b003f1978bbcd6sm1980505wms.3.2023.05.06.20.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:59 -0700 (PDT)
Message-Id: <7892ef891ed1f0e9e2842d594d0688f3490c1b3c.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:33 +0000
Subject: [PATCH 08/24] run-command.h: move declarations for run-command.c from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

