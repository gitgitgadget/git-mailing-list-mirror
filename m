Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33CC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 18:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJLSwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJLSwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 14:52:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13864F4189
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1794629wmb.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iACA4FL6FLxqM8Gf+IfWNEBZzWlEQwVqQ42PnqkGRwo=;
        b=RjYDFAEPqEHw/nWs+VCqQDRvtmcE0W0Ti+MUyT4N0jFiNLOmJRzzxl7wBrrWmG7Wqz
         j1IajnBUkV7/V6XECvM7Mpo5wk8ecR6H29gRyIs31UDOxVwtwGWsKoEOPQ0k6VF1J0UO
         IEHmbFjTAjDXNnuE9adU7sBA83j19TcyZT5gFFdBkewR+0eNPNRt3FBzAJHHQKSd414K
         QdDJ2XKASUvU57RwufhL+jWO5LgGmWfx8MaaYpC4X2fQ/ADmSilTT5sBblpbtnjp4TPM
         lHPAX4/rC2Q1FedWb46DQItiUYobjdOdU720JZb+IHq7gYvLgr4xqbHlp5soY72OElEa
         QEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iACA4FL6FLxqM8Gf+IfWNEBZzWlEQwVqQ42PnqkGRwo=;
        b=RgsG8wTrclCWAjZUhz/61+2M/cA6XnYlXySS/Z7lvyqZUmziFtPilpmDiTE4ttZdog
         oNVg0k1uj/032RGr9dKlz6c0CpTXY8UQalESPKwvpeIWZM/xJEUVe28WmDbUyuoozVmR
         HoEtSHe5MIWFFGsJuxYJzfIXWHDEIK2pp8OIPwKXu0y5oQs0NyxZf+CsvCYQzS1SExU/
         pHmd20127ohCToAheyVhTMNYgROzTY4BMzf88dNFcIhgUM8K3NmbKi/2WjrdIdvqmx60
         eDlc/KWVcJ47QeQmYnWHTdI8RiolA9yLuuIs+m4cAjglhp9EApV0fhcE8KW1St0yEDE8
         3w2A==
X-Gm-Message-State: ACrzQf1ZKduFSi5L0nWPZ+ZrCnxuIp9JLzQ8ErnN26thXCHQWAJoxws/
        aqSif0UvaWnyPp1nwqKZg5+KBJLeh9s=
X-Google-Smtp-Source: AMsMyM4HMgl9IYneBiQwfCxN6AH0iKmVuRTzRozb8tNlxGDxlzDHPPGR+HJBt7sSScBDhzr9sEfT2w==
X-Received: by 2002:a05:600c:4385:b0:3b4:8fdd:ded6 with SMTP id e5-20020a05600c438500b003b48fddded6mr3766490wmn.127.1665600754302;
        Wed, 12 Oct 2022 11:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj30-20020a0560001e1e00b0022cd539ce5esm359944wrb.50.2022.10.12.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:33 -0700 (PDT)
Message-Id: <9dee7a75903936f086d97580441c776978d70b43.1665600750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 18:52:25 +0000
Subject: [PATCH v2 2/7] tr2tls: clarify TLS terminology
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

