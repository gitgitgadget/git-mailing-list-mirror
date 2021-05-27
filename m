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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54ECC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B55F613D2
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhE0AMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbhE0AMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:12:13 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA2C061358
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b17-20020ac854110000b02901f279c73d75so1678671qtq.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dWpw275AjK5+uL0aEQ4VjUUzAAQyBB8ZTrC0oh2O7nE=;
        b=UbqG+GxiTOo+It1iXxgZKvX8SScOwvxUUZwKTvKjgZqZX+SWi8dMUNP/X5Uf+1nrbl
         2T4qzbBHb2m1GzFTnHqopDZoPBvxqto9vO84p+TKdPpyPaE9lyTyCwwNHMuGIGKY54Ha
         NIR0d3wdiGNka/9Tf8iK3+nSwrdJ4nkLF88ShJscGLwrKsx0qalagcNv3Adugq13WYBF
         ZS4ICtdIa/ZRZceMt9TWhs5iK11IqYsvMKVTU9CVA7yhNtPJvdbdeZWVEm68kxsP7alD
         deiGoba7wiG0rbiE0Xj2go/fqK2aC+oAKY2uJqv2heOLcdHDWRJIWXoW/zh/cgqQTwhs
         34iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dWpw275AjK5+uL0aEQ4VjUUzAAQyBB8ZTrC0oh2O7nE=;
        b=LXeKuzoJmp2Z6CviWC025vuu7XUzG6UX3nawHgo2Ia47l/ORAUb/jxdjCQ4GenrK4F
         7SfoX2bFLnffHY63H1W7oWzTyftR7hWyfajoxBsCdVfPgUQZ1vXO27zANCj1slXg9rLL
         M6UASp30/mE6ToFrqrBewvzgdptq/iCK88AW0pikVeBETxIp7pgfzDCn4Mm9Kf/8mdXr
         qYsr4b/tBdU5Qyp66EisLwC+E4NtLEW26jdsxR3E6m+RLxx+DewMbHNr/FQYDp5gF89g
         LAYLRLbpNSzVRlYApV5BfdcgFOQML96uni4vREho7zoEw5qmz6C5tzeUfzcEYsBJth1D
         XzvQ==
X-Gm-Message-State: AOAM532T22At/0dJRRmG+BjASW9U/9a9VhXdOAqsq5RItfJeWkUdNzqt
        4YYOmYvOMp3oN1PT20NePGv31APOhf6Fndj86ZGLCArcUxtnGULTmXHOitM6LRueaj7dgc8qJna
        Tj4HBuwzk5L+QtjJ0+YOM/lM0KzRRHanezeX4+gUNMpWYGcblQwJxOx0GbUr8SZ1uI4jmHPUf1g
        ==
X-Google-Smtp-Source: ABdhPJwYVULhj1mA/JGcpMjpJUJ3M3iDeOvc8XxPfjoP4RmoBNL43yp4buuJDJVEmPacU0gg7oT6JxJftaR/HJ0iUxM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:9d0e:: with SMTP id
 m14mr836637qvf.50.1622074204662; Wed, 26 May 2021 17:10:04 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:52 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-34-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 33/37] bugreport: use hook_exists instead of find_hook
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
index 9915a5841d..190272ba70 100644
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
2.31.1.818.g46aad6cb9e-goog

