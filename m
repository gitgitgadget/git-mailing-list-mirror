Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D28C47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093A5613CD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhE0AMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhE0AL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:27 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E41C061350
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f3-20020ac849830000b02901e0f0a55411so1673483qtq.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FejbK8e94WcgIFCcypxbkEKEaBwHy1lP2msQLc2cmUQ=;
        b=rMDgGqNp+4HYo64RaeIwfGNoJT8OOk7zKyt0IJtDSVmc3oTZFa5LeUgnGGd0AuTYtv
         Au/CWByC5WGgi5Y098+gQECeWDwef/1Ri2lWKHqFgHWEb6Iz2yRr/q0i/2xHbv4pI9pu
         zbv9bIO53ee8snoRKei/Brttl4FVQPz7n9S2s6h4IvZq3i3XWuqNfy3TXADReW+auZix
         px3wFI1cPceyu9gHcx+uUiW+mS3YyvfkHt5SCkvM3mU5jZY/tNQ1R1v8ADepk/3e0pzf
         nrmmRZcbSdz/n+ZZxvRhCE0RZlQXai6LIAjV0nqjuue/+RWfCwbsI9wnEjoc9doJzcav
         KRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FejbK8e94WcgIFCcypxbkEKEaBwHy1lP2msQLc2cmUQ=;
        b=WLwwtdFjIJ+Gip+X2qDXvr/BcEjbT9qS4b2w1F9Q2hx2AzZx54Y22loeIjHJRGGEa1
         4lCQG5kmxYuzYp3F0YPa0R1FxqZ/sJ0aE01k7KwUewji0SRw1zrNzLv5iMrN3UuJbdBa
         /KfnDfKwGfftLy0YrOb7YZoWDCW9NAIwYo+9yGF/5qgSQas2uhtl1Jd0j0r/FIZILNhK
         jQtSDW+K4OuZoiqEZBDXL0c3NOYB4xuIW+A8lVZuxtwV884vq50rd8XyaW/yvc2RBO5n
         sdwsmmAqYR4/0Wo2Fe5fLLHILjAXSL+ix1isM7T+tLTCJxBTCzYoV2Cn1qHfLz9fRWrs
         hmNQ==
X-Gm-Message-State: AOAM532qtXSuO2jLfF6C2TZCPH6wuPr7t9KjNbhba5D/H9iWq20LjxLn
        Wt+OZezM2kPpCCw+wYlQoOIofwQidPbcuacLzDfLKkkYNJ1csTQbIgyqpUKDBY6Ku+GCv+zMqqA
        Z1I5sEAygJfEitcAaGClCHsc33xnQ8GHZu814Pyu4CUZNRc3ISoHxDS8yFGOxAGJMfUa/jeWy4w
        ==
X-Google-Smtp-Source: ABdhPJx0pVEyU/ye0y8Ug5mKXD2LbdJcgLNhPyD7uGHQsAORj2qSKxOGCQfDVVazJ6XVbhFQCGFLeWRcy9eV6LjAycs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:fa4e:: with SMTP id
 k14mr807886qvo.51.1622074183805; Wed, 26 May 2021 17:09:43 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:41 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-23-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 22/37] read-cache: convert post-index-change hook to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to run, post-index-change hooks
can now be specified in the config in addition to the hookdir.
post-index-change is not run anywhere besides in read-cache.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  3 +++
 read-cache.c               | 14 +++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7ae24d65ec..5efa25a44a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -729,6 +729,9 @@ and "0" meaning they were not.
 Only one parameter should be set to "1" when the hook runs.  The hook
 running passing "1", "1" should not be possible.
 
+Hooks run during 'post-index-change' will be run in parallel, unless hook.jobs
+is configured to 1.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/read-cache.c b/read-cache.c
index 1b3c2eb408..6a5c9403f4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -26,6 +26,8 @@
 #include "thread-utils.h"
 #include "progress.h"
 #include "sparse-index.h"
+#include "hook.h"
+>>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use config)
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -3131,6 +3133,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 {
 	int ret;
 	int was_full = !istate->sparse_index;
+	struct run_hooks_opt hook_opt;
 
 	ret = convert_to_sparse(istate);
 
@@ -3159,9 +3162,14 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hook_le(NULL, "post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	run_hooks_opt_init_async(&hook_opt);
+	strvec_pushl(&hook_opt.args,
+		     istate->updated_workdir ? "1" : "0",
+		     istate->updated_skipworktree ? "1" : "0",
+		     NULL);
+	run_hooks("post-index-change", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
+
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
-- 
2.31.1.818.g46aad6cb9e-goog

