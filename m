Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F31C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 18:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJLSwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJLSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 14:52:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2F8240A9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so1722948wme.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfBoNnQwQrh1vWZNW0jjPD/LgSGd5qlX2nsxK6oTocA=;
        b=WeVQGOc2TLtl4eV0mULuBE+N8SbT2HeO5hdi3ZAYYQDAeOc6yyJGuKwceXDkHR5CNZ
         VpCFp0cFB8akZI1Pb6QFLNW/WHpX1kdXINnf1z21M2O2LASZtZizSBG55A0FhGz+0MVI
         QLZtLDhbXq3tesfUwFXKhTdMkAMrMXZck2Cln9UrS6E0GXsUt9t1oRxHgW/DIIIJ9wZe
         r4U/iSk0fe2LUdg1957s9jcOxy3bNvO8KYpDl07VQHLOI8j5F745i7qsQrlGgDPwoV0k
         EKi5Bx6ab4Zkuvaz6lz4df2xQ6dI7pt2AzOlu9uOfSDVAnoCefPVZ3vm/Igh9gBNNtTy
         M+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfBoNnQwQrh1vWZNW0jjPD/LgSGd5qlX2nsxK6oTocA=;
        b=fWI74pKbrQuNQo3Ngyi06T5qX4+6VdugWdirFNNy/WLlfcPp+IV9x3x4MryAODuU38
         U0VEfdEkMgPkz/WdU/MuEpF5HOjMEIGAK1rbVzOR3pyd1vmXbocNYdTIUXEYhM/H5oiw
         wgDrvML9Ou9QV9RTowKIMGkP+c0PXP+RX9ZPLGGikgaKC7cvq1w1+9SRwwGdeD0d4aT2
         NihWTwMczng9BkDzErtlCJffOo0o1DVnHL6bz8uzNh60MsatA1BlszNPTnOci/hHHWXL
         s4ZpMZS8FV04zgm4XLoscyrWN4IOhB89y5TXi3TpJxN34suZ3MmyrU0NfDkFwn2G7U4D
         xbOA==
X-Gm-Message-State: ACrzQf2xDOvyVp19k3qSAzoGQkafsK4w22Dex7tuOJbDrVeWtIxkYtOL
        zA+yucuF6Li0MW8PymsvIAzU2dmHDvk=
X-Google-Smtp-Source: AMsMyM6t/KM0y+X5Uwgk2mhyGrr39O8AU3M6gs7rGq37q6OqjbQWqbhKg/chuE63FoqhDWLhCZOrIw==
X-Received: by 2002:a05:600c:4f06:b0:3b4:b67c:68bb with SMTP id l6-20020a05600c4f0600b003b4b67c68bbmr3851442wmq.36.1665600752200;
        Wed, 12 Oct 2022 11:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b003a3442f1229sm2668010wmg.29.2022.10.12.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:31 -0700 (PDT)
Message-Id: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 18:52:23 +0000
Subject: [PATCH v2 0/7] Trace2 timers and counters and some cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 2 of this series to add timers and counters to Trace2.

Changes since V1:

 * I dropped the commits concerning compiler errors in Clang 11.0.0 on
   MacOS. I've sent them to the mailing list in a separate series, since
   they had nothing to do with the main topic of this series.

 * I moved the documentation changes earlier in the series to get it out of
   the way (and eliminate the need to update it later commits).

 * After a long conversation on the mailing list, I redid the two
   thread-name commits to simplify and hopefully eliminate the remaining
   misunderstandings and/or short-comings of my previous attempt and
   explanations. We now use a "const char *" for the field in the thread-ctx
   that we format and detach from a strbuf during thread-start. The goal
   here is to move away from a modifyable strbuf in the thread-ctx itself
   (to avoid giving the appearance that a caller could modify the
   thread-name at some point, when that was not intended).

The last 2 commits add the stopwatch timers and the global counters and are
unchanged from the previous version.

Jeff Hostetler (7):
  trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  tr2tls: clarify TLS terminology
  api-trace2.txt: elminate section describing the public trace2 API
  trace2: rename the thread_name argument to trace2_thread_start
  trace2: convert ctx.thread_name from strbuf to pointer
  trace2: add stopwatch timers
  trace2: add global counter mechanism

 Documentation/technical/api-trace2.txt | 190 +++++++++++++++++--------
 Makefile                               |   2 +
 t/helper/test-trace2.c                 | 187 ++++++++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  95 +++++++++++++
 t/t0211/scrub_perf.perl                |   6 +
 trace2.c                               | 121 +++++++++++++++-
 trace2.h                               | 101 +++++++++++--
 trace2/tr2_ctr.c                       | 101 +++++++++++++
 trace2/tr2_ctr.h                       | 104 ++++++++++++++
 trace2/tr2_tgt.h                       |  14 ++
 trace2/tr2_tgt_event.c                 |  47 +++++-
 trace2/tr2_tgt_normal.c                |  39 +++++
 trace2/tr2_tgt_perf.c                  |  43 +++++-
 trace2/tr2_tls.c                       |  34 +++--
 trace2/tr2_tls.h                       |  55 ++++---
 trace2/tr2_tmr.c                       | 182 +++++++++++++++++++++++
 trace2/tr2_tmr.h                       | 140 ++++++++++++++++++
 17 files changed, 1359 insertions(+), 102 deletions(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1373%2Fjeffhostetler%2Ftrace2-stopwatch-v4-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1373/jeffhostetler/trace2-stopwatch-v4-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1373

Range-diff vs v1:

  1:  870f29166ea <  -:  ----------- builtin/merge-file: fix compiler warning on MacOS with clang 11.0.0
  2:  43c41f7035d <  -:  ----------- builtin/unpack-objects.c: fix compiler warning on MacOS with clang 11.0.0
  3:  73704b6f660 =  1:  6e7e4f3187e trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  4:  7123886a804 =  2:  9dee7a75903 tr2tls: clarify TLS terminology
  7:  77a4daf9a4b !  3:  804dab9e1a7 api-trace2.txt: elminate section describing the public trace2 API
     @@ Documentation/technical/api-trace2.txt: take a `va_list` argument.
      -
      -These messages are concerned with Git thread usage.
      -
     --e.g: `void trace2_thread_start(const char *name_hint)`.
     +-e.g: `void trace2_thread_start(const char *thread_name)`.
      -
      -=== Region and Data Messages
      -
  5:  82f1672e180 !  4:  637b422b860 trace2: rename trace2 thread_name argument as name_hint
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    trace2: rename trace2 thread_name argument as name_hint
     +    trace2: rename the thread_name argument to trace2_thread_start
      
     -    Rename the `thread_name` argument in `tr2tls_create_self()`
     -    and `trace2_thread_start()` to be `name_hint` to make it clear
     -    that the passed argument is a hint that will be used to create
     +    Rename the `thread_name` argument in `tr2tls_create_self()` and
     +    `trace2_thread_start()` to be `thread_base_name` to make it clearer
     +    that the passed argument is a component used in the construction of
          the actual `struct tr2tls_thread_ctx.thread_name` variable.
      
     -    This should make it clearer in the API that the trace2 layer
     -    does not borrow the caller's string pointer/buffer, but rather
     -    that it will use that hint in formatting the actual thread's
     -    name.  Previous discussion on the mailing list indicated that
     -    there was confusion about this point.
     +    The base name will be used along with the thread id to create a
     +    unique thread name.
      
          This commit does not change how the `thread_name` field is
          allocated or stored within the `tr2tls_thread_ctx` structure.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     - ## Documentation/technical/api-trace2.txt ##
     -@@ Documentation/technical/api-trace2.txt: e.g: `void trace2_child_start(struct child_process *cmd)`.
     - 
     - These messages are concerned with Git thread usage.
     - 
     --e.g: `void trace2_thread_start(const char *thread_name)`.
     -+e.g: `void trace2_thread_start(const char *name_hint)`.
     - 
     - === Region and Data Messages
     - 
     -
       ## trace2.c ##
      @@ trace2.c: void trace2_exec_result_fl(const char *file, int line, int exec_id, int code)
       				file, line, us_elapsed_absolute, exec_id, code);
       }
       
      -void trace2_thread_start_fl(const char *file, int line, const char *thread_name)
     -+void trace2_thread_start_fl(const char *file, int line, const char *name_hint)
     ++void trace2_thread_start_fl(const char *file, int line, const char *thread_base_name)
       {
       	struct tr2_tgt *tgt_j;
       	int j;
     @@ trace2.c: void trace2_thread_start_fl(const char *file, int line, const char *th
       		trace2_region_enter_printf_fl(file, line, NULL, NULL, NULL,
       					      "thread-proc on main: %s",
      -					      thread_name);
     -+					      name_hint);
     ++					      thread_base_name);
       		return;
       	}
       
     @@ trace2.c: void trace2_thread_start_fl(const char *file, int line, const char *th
       	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
       
      -	tr2tls_create_self(thread_name, us_now);
     -+	tr2tls_create_self(name_hint, us_now);
     ++	tr2tls_create_self(thread_base_name, us_now);
       
       	for_each_wanted_builtin (j, tgt_j)
       		if (tgt_j->pfn_thread_start_fl)
     @@ trace2.h: void trace2_exec_result_fl(const char *file, int line, int exec_id, in
        *
      - * Thread names should be descriptive, like "preload_index".
      - * Thread names will be decorated with an instance number automatically.
     -+ * The thread name hint should be descriptive, like "preload_index" or
     ++ * The thread base name should be descriptive, like "preload_index" or
      + * taken from the thread-proc function.  A unique thread name will be
     -+ * created from the hint and the thread id automatically.
     ++ * created from the given base name and the thread id automatically.
        */
       void trace2_thread_start_fl(const char *file, int line,
      -			    const char *thread_name);
     -+			    const char *name_hint);
     ++			    const char *thread_base_name);
       
      -#define trace2_thread_start(thread_name) \
      -	trace2_thread_start_fl(__FILE__, __LINE__, (thread_name))
     -+#define trace2_thread_start(name_hint) \
     -+	trace2_thread_start_fl(__FILE__, __LINE__, (name_hint))
     ++#define trace2_thread_start(thread_base_name) \
     ++	trace2_thread_start_fl(__FILE__, __LINE__, (thread_base_name))
       
       /*
        * Emit a 'thread_exit' event.  This must be called from inside the
     @@ trace2/tr2_tls.c: void tr2tls_start_process_clock(void)
       }
       
      -struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
     -+struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
     ++struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
       					     uint64_t us_thread_start)
       {
       	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
     @@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *threa
       	if (ctx->thread_id)
       		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
      -	strbuf_addstr(&ctx->thread_name, thread_name);
     -+	strbuf_addstr(&ctx->thread_name, name_hint);
     ++	strbuf_addstr(&ctx->thread_name, thread_base_name);
       	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
       		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
       
     @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
      + * The first thread in the process will have:
      + *     { .thread_id=0, .thread_name="main" }
      + * Subsequent threads are given a non-zero thread_id and a thread_name
     -+ * constructed from the id and a "name hint" (which is usually based
     -+ * upon the name of the thread-proc function).  For example:
     ++ * constructed from the id and a thread base name (which is usually just
     ++ * the name of the thread-proc function).  For example:
      + *     { .thread_id=10, .thread_name="th10fsm-listen" }
      + * This helps to identify and distinguish messages from concurrent threads.
      + * The ctx.thread_name field is truncated if necessary to help with column
     @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
        * current thread.
        */
      -struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
     -+struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
     ++struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
       					     uint64_t us_thread_start);
       
       /*
  6:  6492b6d2b98 !  5:  4bf78e356e2 trace2: convert ctx.thread_name to flex array
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    trace2: convert ctx.thread_name to flex array
     +    trace2: convert ctx.thread_name from strbuf to pointer
      
          Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
     -    to a "flex array" at the end of the context structure.
     +    to a "const char*" pointer.
      
          The `thread_name` field is a constant string that is constructed when
          the context is created.  Using a (non-const) `strbuf` structure for it
          caused some confusion in the past because it implied that someone
          could rename a thread after it was created.  That usage was not
     -    intended.  Changing it to a "flex array" will hopefully make the
     -    intent more clear.
     -
     -    Also, move the maximum thread_name truncation to tr2_tgt_perf.c
     -    because it is the only target that needs to worry about output column
     -    alignment.
     +    intended.  Change it to a const pointer to make the intent more clear.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ trace2/tr2_tgt_event.c: static void event_fmt_prepare(const char *event_name, co
       	 * In brief mode, only emit <time> on these 2 event types.
      
       ## trace2/tr2_tgt_perf.c ##
     -@@ trace2/tr2_tgt_perf.c: static int tr2env_perf_be_brief;
     - 
     - #define TR2FMT_PERF_FL_WIDTH (28)
     - #define TR2FMT_PERF_MAX_EVENT_NAME (12)
     -+#define TR2FMT_PERF_MAX_THREAD_NAME (24)
     - #define TR2FMT_PERF_REPO_WIDTH (3)
     - #define TR2FMT_PERF_CATEGORY_WIDTH (12)
     - 
      @@ trace2/tr2_tgt_perf.c: static void perf_fmt_prepare(const char *event_name,
     - 	}
       
       	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
     --	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
     + 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
      -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
     -+	strbuf_addf(buf, "%-*.*s | %-*s | ",
     -+		    TR2FMT_PERF_MAX_THREAD_NAME,
     -+		    TR2FMT_PERF_MAX_THREAD_NAME,
     -+		    ctx->thread_name,
     -+		    TR2FMT_PERF_MAX_EVENT_NAME,
     ++		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
       		    event_name);
       
       	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
      
       ## trace2/tr2_tls.c ##
     -@@ trace2/tr2_tls.c: void tr2tls_start_process_clock(void)
     - struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
     +@@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
       					     uint64_t us_thread_start)
       {
     --	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
     -+	struct tr2tls_thread_ctx *ctx;
     -+	struct strbuf buf_name = STRBUF_INIT;
     -+	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     -+
     -+	if (thread_id)
     -+		strbuf_addf(&buf_name, "th%02d:", thread_id);
     -+	strbuf_addstr(&buf_name, name_hint);
     -+
     -+	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
     -+	strbuf_release(&buf_name);
     -+
     -+	ctx->thread_id = thread_id;
     + 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
     ++	struct strbuf buf = STRBUF_INIT;
       
       	/*
       	 * Implicitly "tr2tls_push_self()" to capture the thread's start
     -@@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
     - 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
     - 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
     +@@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
     + 
     + 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
       
     --	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     --
      -	strbuf_init(&ctx->thread_name, 0);
     --	if (ctx->thread_id)
     ++	strbuf_init(&buf, 0);
     + 	if (ctx->thread_id)
      -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
     --	strbuf_addstr(&ctx->thread_name, name_hint);
     +-	strbuf_addstr(&ctx->thread_name, thread_base_name);
      -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
      -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
     --
     ++		strbuf_addf(&buf, "th%02d:", ctx->thread_id);
     ++	strbuf_addstr(&buf, thread_base_name);
     ++	if (buf.len > TR2_MAX_THREAD_NAME)
     ++		strbuf_setlen(&buf, TR2_MAX_THREAD_NAME);
     ++	ctx->thread_name = strbuf_detach(&buf, NULL);
     + 
       	pthread_setspecific(tr2tls_key, ctx);
       
     - 	return ctx;
      @@ trace2/tr2_tls.c: void tr2tls_unset_self(void)
       
       	pthread_setspecific(tr2tls_key, NULL);
       
      -	strbuf_release(&ctx->thread_name);
     ++	free((char *)ctx->thread_name);
       	free(ctx->array_us_start);
       	free(ctx);
       }
     @@ trace2/tr2_tls.c: void tr2tls_pop_self(void)
      
       ## trace2/tr2_tls.h ##
      @@
     -  * There is NO relation to "transport layer security".
     -  */
     + #define TR2_MAX_THREAD_NAME (24)
       
     --/*
     -- * Arbitry limit for thread names for column alignment.
     -- */
     --#define TR2_MAX_THREAD_NAME (24)
     --
       struct tr2tls_thread_ctx {
      -	struct strbuf thread_name;
     ++	const char *thread_name;
       	uint64_t *array_us_start;
       	size_t alloc;
       	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
     - 	int thread_id;
     -+	char thread_name[FLEX_ARRAY];
     - };
     - 
     - /*
     -@@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
     -  * upon the name of the thread-proc function).  For example:
     -  *     { .thread_id=10, .thread_name="th10fsm-listen" }
     -  * This helps to identify and distinguish messages from concurrent threads.
     -- * The ctx.thread_name field is truncated if necessary to help with column
     -- * alignment in printf-style messages.
     -  *
     -  * In this and all following functions the term "self" refers to the
     -  * current thread.
  8:  19c7bba91ba !  6:  dd6d8e2841b trace2: add stopwatch timers
     @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
      +	struct tr2_timer_block timer_block;
      +	unsigned int used_any_timer:1;
      +	unsigned int used_any_per_thread_timer:1;
     - 	char thread_name[FLEX_ARRAY];
       };
       
     + /*
      @@ trace2/tr2_tls.h: int tr2tls_locked_increment(int *p);
        */
       void tr2tls_start_process_clock(void);
  9:  2bf7cb1f8d0 !  7:  cf012fcde37 trace2: add global counter mechanism
     @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
       	unsigned int used_any_per_thread_timer:1;
      +	unsigned int used_any_counter:1;
      +	unsigned int used_any_per_thread_counter:1;
     - 	char thread_name[FLEX_ARRAY];
       };
       
     + /*

-- 
gitgitgadget
