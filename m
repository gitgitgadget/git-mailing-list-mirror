Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD55C4361B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB564FC5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCKCMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCKCL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548BEC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n10so23628949ybb.12
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=56kVj9+hUABIsBGN/+1c7mbttDbPs4DT9BJ3q2sOpkk=;
        b=gHv/KqOzE/nZvUSbVfz9WsswQrYUCmUWppEqEl5x0KRAU2BKl2ihS41bW0GMndh+Uu
         RY97mWIUP3dewLEdES5cFJsrZTvaUNKmpVYgUKosZyKSJYKhRCypYJLXSn9tuUJdNdMQ
         LuslWl6lsZS5eFFsW5ufflhMQLAaM6VOz8aKJSMvPYGCxL8/TMHDGLnUbSmEyjTn3Dfl
         z90gbDpDdPTnM/mz6Jovf656oTXr6uYdIFKVUgK2kxwAi2vkeAlLF5MNd+358f1adcdB
         b+iCmEsGMNrR24ZJsdUNPKJ1nafLZth0rGoOmn/3lup5qXbH5ECTUVRA5gROSnJ6vRKD
         GhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=56kVj9+hUABIsBGN/+1c7mbttDbPs4DT9BJ3q2sOpkk=;
        b=p3nKBhKGT2w2Xh765Y2oUaOLOGbLf7klyb2FrtlSMgRV5l16hVwGBt/u0bo0peWTNS
         wzGZ5XIAfJ0fb9hevGqA8CchMP6casaQcSVS2y6cre8Lxf0rHS0bP/4UrAni5W9S230I
         /vgDNB/GvhoMFYtuD61F+Up/jLXoFbxyHxL8GMdsytiwoCwnIS+4T1aLlNmNvwHbuJbc
         uV9vKaLy0iPBBWkZrZtwicfd7/xTNY5rYhXqU9Ir9+mQfLkSqMpoOnKg2eRBsxLqKH5c
         /fQugydGkvI0PxHKS3CdQRNCQNvG6n7NhmHGgXyg09Hla4LWBnfyzsmiD8JB+hpuHwYt
         6jNQ==
X-Gm-Message-State: AOAM530wjV65VHNtiix5lYR1WCjv+PSN4KMjqfBPG0QEhAaKEr4q034w
        PmQ0xlpfBGpY/6yTDFbCAxwxuV+aU/uOkDtjOl3qV629U+ienF2NjZpHwAHAnrr7BAocLhNk+o4
        0BbUzmFYW3mf5h/TXWO15hDCU85wsYRMg6WJ6KOjVk2PaKvvVODfAGyEgOxGJQbGfWtJwa2X31g
        ==
X-Google-Smtp-Source: ABdhPJxr7z6Rp51ObB+rEbsrsrSXGozlYTUI9KQOYXOuIgwDDSl34O91eKIVYX8RUtqtejiWETrzHGrViC+/Hn4md7Y=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:3104:: with SMTP id
 x4mr9150111ybx.217.1615428711553; Wed, 10 Mar 2021 18:11:51 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:34 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-35-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 34/37] bugreport: use hook_exists instead of find_hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the helper in hook.h instead of the one in run-command.h, we
can also check whether a hook exists in the config - not just whether it
exists in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/bugreport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index ad3cc9c02f..eac3726527 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
-#include "run-command.h"
+#include "hook.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (find_hook(hook[i]))
+		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

