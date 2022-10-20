Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E85C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJTS2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJTS2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF71F5257
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u10so487390wrq.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iACA4FL6FLxqM8Gf+IfWNEBZzWlEQwVqQ42PnqkGRwo=;
        b=bKu7VPFQEkmrCde31+JHtAmOPHswNQAkrNAErRwEKUIdVmmcgh7CFSfONxrLfVgDX4
         bMBZIiZz1C5Y8+y/E3uYUr2NassJgdQJUsL2CMJbBWe4DbKLWNEawGcOIMjKx9/+qZGt
         OSgsB5YIU2GMXMIgfP6q08C4JKeCPXwLos20BUDeQ5d2X8qGRHpDXOhLRhayvkLsSN2p
         /DOCUAUOYu7PcXlI4jgvRKO/4ItDByWX4S9JRvSGCCbERgn6hUQsXgLZ/KJL/x/wbrjf
         jZSvqyfrZDhFAUypLLljR9FNoKt16pIyI24oPVfHkpH5FDNxqJmd0RXz8qHiOE/i8UM2
         tCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iACA4FL6FLxqM8Gf+IfWNEBZzWlEQwVqQ42PnqkGRwo=;
        b=U5LYc/B/zfjGCn2hMLGoTSiV0ABD4oeizp10i9Gz3w2T6PXG3NIR6cSO1FHvkOPIKc
         dILyEcw2xDV8u4JzexCZ/DhDJNMFPuoWi89vBihIkEQ5/2tQttH9PWtOZP8Jo287l3es
         Asg6t6sqLzI4qdhTg85xTKsLfv9v+rGmPfDASrCdwY/xnVbsQYVy9PFy0s1rUvYC5fW2
         5Dge7l5TCYcn7P4mEugjmRcsy8Lj0XuPprJ9Wl5mwG8derebGfWWNHhSQZNSVCxTgxKr
         V6D97ZHfqwOWo9v65CaubirW43g7DTRMuqgWmq1wfHhfymPJyN9GXlhmphuoF+xSepiK
         9u+A==
X-Gm-Message-State: ACrzQf06GCH+ZSBaugkj2mgpdxiLskA0zBlnSDqcAIytpCCsYeKTqj/A
        WdsAcj5+Wbr6CCtE/1TsZzue/wKYPPM=
X-Google-Smtp-Source: AMsMyM7vczraU3XegJakHFB60M/wuMe8JJp4iHY1nId3ppb+IYBAGRpT3f+kjRgykk1T7K6rq8V1KQ==
X-Received: by 2002:a5d:5a05:0:b0:235:474c:c12 with SMTP id bq5-20020a5d5a05000000b00235474c0c12mr3945150wrb.659.1666290493152;
        Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020adfd209000000b0022cd6e852a2sm20084523wrh.45.2022.10.20.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:12 -0700 (PDT)
Message-Id: <9dee7a75903936f086d97580441c776978d70b43.1666290489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:03 +0000
Subject: [PATCH v3 2/8] tr2tls: clarify TLS terminology
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Reduce or eliminate use of the term "TLS" in the Trace2 code.

The term "TLS" has two popular meanings: "thread-local storage" and
"transport layer security".  In the Trace2 source, the term is associated
with the former.  There was concern on the mailing list about it refering
to the latter.

Update the source and documentation to eliminate the use of the "TLS" term
or replace it with the phrase "thread-local storage" to reduce ambiguity.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt |  8 ++++----
 trace2.c                               |  2 +-
 trace2.h                               | 10 +++++-----
 trace2/tr2_tls.c                       |  6 +++---
 trace2/tr2_tls.h                       | 18 +++++++++++-------
 5 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 2afa28bb5aa..431d424f9d5 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -685,8 +685,8 @@ The "exec_id" field is a command-unique id and is only useful if the
 
 `"thread_start"`::
 	This event is generated when a thread is started.  It is
-	generated from *within* the new thread's thread-proc (for TLS
-	reasons).
+	generated from *within* the new thread's thread-proc (because
+	it needs to access data in the thread's thread-local storage).
 +
 ------------
 {
@@ -698,7 +698,7 @@ The "exec_id" field is a command-unique id and is only useful if the
 
 `"thread_exit"`::
 	This event is generated when a thread exits.  It is generated
-	from *within* the thread's thread-proc (for TLS reasons).
+	from *within* the thread's thread-proc.
 +
 ------------
 {
@@ -1206,7 +1206,7 @@ worked on 508 items at offset 2032.  Thread "th04" worked on 508 items
 at offset 508.
 +
 This example also shows that thread names are assigned in a racy manner
-as each thread starts and allocates TLS storage.
+as each thread starts.
 
 Config (def param) Events::
 
diff --git a/trace2.c b/trace2.c
index 0c0a11e07d5..c1244e45ace 100644
--- a/trace2.c
+++ b/trace2.c
@@ -52,7 +52,7 @@ static struct tr2_tgt *tr2_tgt_builtins[] =
  * Force (rather than lazily) initialize any of the requested
  * builtin TRACE2 targets at startup (and before we've seen an
  * actual TRACE2 event call) so we can see if we need to setup
- * the TR2 and TLS machinery.
+ * private data structures and thread-local storage.
  *
  * Return the number of builtin targets enabled.
  */
diff --git a/trace2.h b/trace2.h
index 88d906ea830..af3c11694cc 100644
--- a/trace2.h
+++ b/trace2.h
@@ -73,8 +73,7 @@ void trace2_initialize_clock(void);
 /*
  * Initialize TRACE2 tracing facility if any of the builtin TRACE2
  * targets are enabled in the system config or the environment.
- * This includes setting up the Trace2 thread local storage (TLS).
- * Emits a 'version' message containing the version of git
+ * This emits a 'version' message containing the version of git
  * and the Trace2 protocol.
  *
  * This function should be called from `main()` as early as possible in
@@ -302,7 +301,8 @@ void trace2_exec_result_fl(const char *file, int line, int exec_id, int code);
 
 /*
  * Emit a 'thread_start' event.  This must be called from inside the
- * thread-proc to set up the trace2 TLS data for the thread.
+ * thread-proc to allow the thread to create its own thread-local
+ * storage.
  *
  * Thread names should be descriptive, like "preload_index".
  * Thread names will be decorated with an instance number automatically.
@@ -315,8 +315,8 @@ void trace2_thread_start_fl(const char *file, int line,
 
 /*
  * Emit a 'thread_exit' event.  This must be called from inside the
- * thread-proc to report thread-specific data and cleanup TLS data
- * for the thread.
+ * thread-proc so that the thread can access and clean up its
+ * thread-local storage.
  */
 void trace2_thread_exit_fl(const char *file, int line);
 
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 7da94aba522..8d2182fbdbb 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -69,9 +69,9 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void)
 	ctx = pthread_getspecific(tr2tls_key);
 
 	/*
-	 * If the thread-proc did not call trace2_thread_start(), we won't
-	 * have any TLS data associated with the current thread.  Fix it
-	 * here and silently continue.
+	 * If the current thread's thread-proc did not call
+	 * trace2_thread_start(), then the thread will not have any
+	 * thread-local storage.  Create it now and silently continue.
 	 */
 	if (!ctx)
 		ctx = tr2tls_create_self("unknown", getnanotime() / 1000);
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index a90bd639d48..1297509fd23 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -3,6 +3,12 @@
 
 #include "strbuf.h"
 
+/*
+ * Notice: the term "TLS" refers to "thread-local storage" in the
+ * Trace2 source files.  This usage is borrowed from GCC and Windows.
+ * There is NO relation to "transport layer security".
+ */
+
 /*
  * Arbitry limit for thread names for column alignment.
  */
@@ -17,9 +23,7 @@ struct tr2tls_thread_ctx {
 };
 
 /*
- * Create TLS data for the current thread.  This gives us a place to
- * put per-thread data, such as thread start time, function nesting
- * and a per-thread label for our messages.
+ * Create thread-local storage for the current thread.
  *
  * We assume the first thread is "main".  Other threads are given
  * non-zero thread-ids to help distinguish messages from concurrent
@@ -35,7 +39,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
 					     uint64_t us_thread_start);
 
 /*
- * Get our TLS data.
+ * Get the thread-local storage pointer of the current thread.
  */
 struct tr2tls_thread_ctx *tr2tls_get_self(void);
 
@@ -45,7 +49,7 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void);
 int tr2tls_is_main_thread(void);
 
 /*
- * Free our TLS data.
+ * Free the current thread's thread-local storage.
  */
 void tr2tls_unset_self(void);
 
@@ -81,12 +85,12 @@ uint64_t tr2tls_region_elasped_self(uint64_t us);
 uint64_t tr2tls_absolute_elapsed(uint64_t us);
 
 /*
- * Initialize the tr2 TLS system.
+ * Initialize thread-local storage for Trace2.
  */
 void tr2tls_init(void);
 
 /*
- * Free all tr2 TLS resources.
+ * Free all Trace2 thread-local storage resources.
  */
 void tr2tls_release(void);
 
-- 
gitgitgadget

