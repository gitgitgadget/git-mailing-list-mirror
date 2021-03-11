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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446AAC43603
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B65964FD8
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCKCLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCKCL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:29 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCCC061762
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:29 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id u15so14182088qvo.13
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=++sDMC8n1GO52CUP5ppNYXHMDrDDE5ZfUW2YH+saiIQ=;
        b=SDAnlXoXN1VRq9ZzoEtO8uaymzXOqCMWxVZc9w262r8wucH/NZ3F04AKUoLI+7FQMX
         mDt58f5Q9Jf+sCD4L2KkSFS7AdBtd4sirU8TQafk3WLiPWriiMltM/4ox793mtHQYvJw
         MA0gRF8tCyEc44Fw742lmgB+mjQM1iiznEAcs34eGdQaJjR/lybDXv0dwqzdQHIvEqI3
         mlNqHszh/jVP6qO79c+B5q4VBYRjBxDN9ETmvzXlwlusp30FVY8ZACamBJHuD9m/pKHE
         ti0uHJc9zHlNIYkVKxTsuApYwzFY/jbTQD7cX6ezGZfs5xpFxpLOO44kPqvrJo8l/Hio
         61+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=++sDMC8n1GO52CUP5ppNYXHMDrDDE5ZfUW2YH+saiIQ=;
        b=Wofbb4H2aUwZqrCj+rlwQTEknI9n33fJ82XckbY24Zcs4ZXgr0OxBtJgzsfYPOSPq7
         9MOLaJoXYFiVUzWoL94OvlhZTPtqNicbLJCt/PdBv4mXmK/fCHGp9Uk77SzYhTAAq30P
         n485HkEWkgJzUyGwvl2jZ4TYhe1ypiGXWV1kZiDvOrjOwDix7zt++kVJNgNBPxPjpaee
         wbCXL2A840ZbsnH1v+fBEfaHc20LGolKldJYs5V86TQn2uVn4rPKMSB1SedCWH0xGfm7
         6FKAhRHE7hNIAEIcLyGcc7AqkR7Z7MNGNKtm+xW1eYJ7NWGXgiLxteC6NQIBEkOyFgMw
         bGjA==
X-Gm-Message-State: AOAM5333L0qWvuGEJoGcWamGzQfcAA6aXVzcnPf3q9VuX2yVLrr4JQpY
        /hMgBtPfkCfo73REM5v94eWOcjbMPQ8jTTYV3KJ7GI1FK/r5KifoKum994a/6AEUBIIcS6WaTG5
        kvc1EjenICUZSjCxflgrX8SaJDRii+IiHnN5LxnQFR+82dkq0YKm2lhS8E+PkAkS3kKPGXjwhpg
        ==
X-Google-Smtp-Source: ABdhPJwhCzWRBiX1C96AuxKTBDa4DrX0mheQGx2sD/R/CFjyIy9skym4ep2jmSNgQtnKRUSeyw5UgSBvzhZmuQQYJXw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:c68f:: with SMTP id
 d15mr5946822qvj.20.1615428688390; Wed, 10 Mar 2021 18:11:28 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:21 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-22-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 21/37] gc: use hook library for pre-auto-gc hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the hook.h library instead of the run-command.h library to run
pre-auto-gc means that those hooks can be set up in config files, as
well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 3 +++
 builtin/gc.c               | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 664ad4803e..00f88912cd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -560,6 +560,9 @@ This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
 takes no parameter, and exiting with non-zero status from this script
 causes the `git gc --auto` to abort.
 
+Hooks run during 'pre-auto-gc' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 post-rewrite
 ~~~~~~~~~~~~
 
diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bc..e62cb510ee 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -348,6 +349,8 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct run_hooks_opt hook_opt;
+	run_hooks_opt_init_async(&hook_opt);
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -394,7 +397,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc", &hook_opt))
 		return 0;
 	return 1;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

