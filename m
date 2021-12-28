Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA2C433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhL1Tgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbhL1Tgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED9FC06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k18so3436237wrg.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A5ypdyfHh2bAKzMpBSxox7x/1MKcxEji0wJh6spOIZg=;
        b=S9wspW/MArss94cLLxWaEOLiudzYsa+10Sc2/9W8JBCTPc1qjHU2Ypzp+Gz7LCu16o
         lwUwikoExcZaai2KW5h2pAr7hxyJI0Lv/KqiVNi2ZT7TT1pzdzky7V0hAIgMg3wslYvN
         vnzARfhHvt62F+/okDcQPUGmNeMARm5n/mNRcWuEpbafHSICkY5kC85+WwnzV9KaPFBb
         SFmtoFam3RS7HjkofkD6sOXXlCnLdp+eXezDCAgNVBh9eYy3UDBk4oitFLcQ3mJjlROm
         8s1U0grS94Cy2E31QIoe12TEF1/jaoxrgolTlMRkarQ/BsD3CzVc+uUCLCDrL9jLwfD2
         TIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A5ypdyfHh2bAKzMpBSxox7x/1MKcxEji0wJh6spOIZg=;
        b=THKYKGPDM8oLFU6WIZTN2nAZm0tYgNT9MvsOlGi3NSxAwFVgwb3hIp2MJJhG/3IfTN
         3cGbiDLP+vvGkV8U5L4DG7/8/j74GFKzuCIHs2d/0Om/eFOci+EONB8M6TrbkOTk/EKd
         sswm4FwEfaFxo81VJzH/ftVgWWiW6w3czjdUYQBBx3Zl6Tj9FVLRG7xGQfxXz9JuYc1B
         8uQv64F8djqgGIjSwufqpS+4MoHPh47t+oW2B34Ycx51+qw82l5e5jtHREn6CJha2a9h
         M1FCvKHliMRij7XvdQLkrRCh+1sBsgAoKQwPiAhOav8OcEPlNNPm0Le9lvAiOFzuaxWF
         Cnog==
X-Gm-Message-State: AOAM5305VE7N0rV+o+3zTi+2Sxl4ZjyW7RCb8H8xuQDG0S8Spx7+iL4/
        LAVAqkHA6bu8mrME4A1McNjxTCjoLRE=
X-Google-Smtp-Source: ABdhPJzjzzWDkVwG8EGLRIVKQaRJeX9MDP94u6rQgNAgY/0vWrjWv3ijKeL7c1sFoc2Mge8M7n+m6Q==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr17590667wrt.410.1640720203758;
        Tue, 28 Dec 2021 11:36:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm20886571wri.50.2021.12.28.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:43 -0800 (PST)
Message-Id: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:33 +0000
Subject: [PATCH v2 0/9] Trace2 stopwatch timers and global counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 2 of my series to add stopwatch timers and global counters
to Trace2. I think this version address all of the comments made on V1.

 * I moved the Trace2 "thread_name" field into a flex-array at the bottom of
   the thread local storage block. This avoids the issue of whether it
   should be allocated and by whom and its const-ness.

 * I moved the truncation of the "thread_name" into the "_perf" target
   (which was the only target that actually cared) so that columns still
   line up.

 * Started phasing out the TLS and CTX acronyms in the Trace2 code. There is
   an ambiguity between "thread local storage" and "transport layer
   security" that caused some confusion. In this patch series, I eliminated
   new uses of the TLS term. A future series will be needed to actually
   rename variables, functions, and data types to fully eliminate the TLS
   term.

 * In V1 I included a change to the "_event" target version number. I've
   rolled this back in favor of Ævar's new proposal describing when/why we
   change it. (That proposal is independent of this series.)

 * In V1 I had reported timer values {total, min, max} in floating point
   seconds with microsecond precision (using a "%9.6f" format) and was
   internally accumulating interval times in microseconds. After some
   discussion, I've changed this to accumulate in nanoseconds and report
   integer nanoseconds. This may avoid some accumulated round off error.
   (However, on some platforms getnanotime() only has microsecond accuracy,
   so this increased precision may be misleading.)

 * Refactor the pattern model used in the unit tests to make it easier to
   visually parse.

 * Some cosmetic cleanup of the private timer and counter API.

There were additional requests/comments that I have not addressed in this
version because I think they should be in their own top-level topic in a
future series rather than appended onto this series:

 * The full elimination of the TLS and CTX terms.

 * Ævar proposed a new test_trace2 test function to parse trace output. This
   would be similar to (or a generalization of) the test_region function
   that we already have in test-lib-functions.sh.

 * Ævar proposed a large refactor of the "_perf" target to have a "fmt()"
   varargs function to reduce the amount of copy-n-pasted code in many of
   the "fn" event handlers. This looks like a good change based on the
   mockup but is a large refactor.

 * Ævar proposed a new rationale for when/why we change the "_event" version
   number. That text can be added to the design document independently.

Jeff Hostetler (9):
  trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  trace2: convert tr2tls_thread_ctx.thread_name from strbuf to flex
    array
  trace2: defer free of thread local storage until program exit.
  trace2: add thread-name override to event target
  trace2: add thread-name override to perf target
  trace2: add timer events to perf and event target formats
  trace2: add stopwatch timers
  trace2: add counter events to perf and event target formats
  trace2: add global counters

 Documentation/technical/api-trace2.txt | 157 +++++++++++++++++++++
 Makefile                               |   2 +
 t/helper/test-trace2.c                 | 183 +++++++++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  88 ++++++++++++
 t/t0212-trace2-event.sh                |  86 ++++++++++++
 trace2.c                               | 106 ++++++++++++++
 trace2.h                               |  75 ++++++++++
 trace2/tr2_ctr.c                       |  67 +++++++++
 trace2/tr2_ctr.h                       |  79 +++++++++++
 trace2/tr2_tgt.h                       |  39 ++++++
 trace2/tr2_tgt_event.c                 | 111 +++++++++++----
 trace2/tr2_tgt_normal.c                |   2 +
 trace2/tr2_tgt_perf.c                  | 114 ++++++++++-----
 trace2/tr2_tls.c                       | 119 +++++++++++++---
 trace2/tr2_tls.h                       |  51 +++++--
 trace2/tr2_tmr.c                       | 136 ++++++++++++++++++
 trace2/tr2_tmr.h                       | 139 +++++++++++++++++++
 17 files changed, 1465 insertions(+), 89 deletions(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h


base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1099%2Fjeffhostetler%2Ftrace2-stopwatch-v2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1099/jeffhostetler/trace2-stopwatch-v2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1099

Range-diff vs v1:

  1:  96f6896a13e =  1:  96f6896a13e trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  2:  3a4fe07e40e !  2:  ff8df1b148e trace2: convert tr2tls_thread_ctx.thread_name from strbuf to char*
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    trace2: convert tr2tls_thread_ctx.thread_name from strbuf to char*
     +    trace2: convert tr2tls_thread_ctx.thread_name from strbuf to flex array
      
     -    Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
     -    The thread name is set when the thread is created and should not be
     -    be modified afterwards.  Replace the strbuf with an allocated pointer
     -    to make that more clear.
     +    Move the thread name to a flex array at the bottom of the Trace2
     +    thread local storage data and get rid of the strbuf.
      
     -    This was discussed in: https://lore.kernel.org/all/xmqqa6kdwo24.fsf@gitster.g/
     +    Let the flex array have the full computed value of the thread name
     +    without truncation.
     +
     +    Change the PERF target to truncate the thread name so that the columns
     +    still line up.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ trace2/tr2_tgt_event.c: static void event_fmt_prepare(const char *event_name, co
       	 * In brief mode, only emit <time> on these 2 event types.
      
       ## trace2/tr2_tgt_perf.c ##
     +@@ trace2/tr2_tgt_perf.c: static int tr2env_perf_be_brief;
     + 
     + #define TR2FMT_PERF_FL_WIDTH (28)
     + #define TR2FMT_PERF_MAX_EVENT_NAME (12)
     ++#define TR2FMT_PERF_MAX_THREAD_NAME (24)
     + #define TR2FMT_PERF_REPO_WIDTH (3)
     + #define TR2FMT_PERF_CATEGORY_WIDTH (12)
     + 
      @@ trace2/tr2_tgt_perf.c: static void perf_fmt_prepare(const char *event_name,
     + 	}
       
       	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
     - 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
     +-	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
      -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
     -+		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
     - 		    event_name);
     +-		    event_name);
     ++	strbuf_addf(buf, "%-*.*s | %-*s | ", TR2FMT_PERF_MAX_THREAD_NAME,
     ++		    TR2FMT_PERF_MAX_THREAD_NAME, ctx->thread_name,
     ++		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
       
       	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
     + 	if (repo)
      
       ## trace2/tr2_tls.c ##
     -@@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
     +@@ trace2/tr2_tls.c: void tr2tls_start_process_clock(void)
     + struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
       					     uint64_t us_thread_start)
       {
     - 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
     +-	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
     ++	struct tr2tls_thread_ctx *ctx;
      +	struct strbuf buf_name = STRBUF_INIT;
     ++	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     ++
     ++	if (thread_id)
     ++		strbuf_addf(&buf_name, "th%02d:", thread_id);
     ++	strbuf_addstr(&buf_name, thread_name);
     ++
     ++	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
     ++	strbuf_release(&buf_name);
     ++
     ++	ctx->thread_id = thread_id;
       
       	/*
       	 * Implicitly "tr2tls_push_self()" to capture the thread's start
      @@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
     + 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
     + 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
       
     - 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     - 
     +-	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     +-
      -	strbuf_init(&ctx->thread_name, 0);
     - 	if (ctx->thread_id)
     +-	if (ctx->thread_id)
      -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
      -	strbuf_addstr(&ctx->thread_name, thread_name);
      -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
      -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
     -+		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
     -+	strbuf_addstr(&buf_name, thread_name);
     -+	if (buf_name.len > TR2_MAX_THREAD_NAME)
     -+		strbuf_setlen(&buf_name, TR2_MAX_THREAD_NAME);
     -+
     -+	ctx->thread_name = strbuf_detach(&buf_name, NULL);
     - 
     +-
       	pthread_setspecific(tr2tls_key, ctx);
       
     + 	return ctx;
      @@ trace2/tr2_tls.c: void tr2tls_unset_self(void)
       
       	pthread_setspecific(tr2tls_key, NULL);
       
      -	strbuf_release(&ctx->thread_name);
     -+	free(ctx->thread_name);
       	free(ctx->array_us_start);
       	free(ctx);
       }
     @@ trace2/tr2_tls.c: void tr2tls_pop_self(void)
      
       ## trace2/tr2_tls.h ##
      @@
     - #define TR2_MAX_THREAD_NAME (24)
       
     + #include "strbuf.h"
     + 
     +-/*
     +- * Arbitry limit for thread names for column alignment.
     +- */
     +-#define TR2_MAX_THREAD_NAME (24)
     +-
       struct tr2tls_thread_ctx {
      -	struct strbuf thread_name;
     -+	char *thread_name;
       	uint64_t *array_us_start;
       	size_t alloc;
       	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
     + 	int thread_id;
     ++	char thread_name[FLEX_ARRAY];
     + };
     + 
     + /*
     +@@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
     +  * non-zero thread-ids to help distinguish messages from concurrent
     +  * threads.
     +  *
     +- * Truncate the thread name if necessary to help with column alignment
     +- * in printf-style messages.
     +- *
     +  * In this and all following functions the term "self" refers to the
     +  * current thread.
     +  */
  3:  e0c41e1fc78 !  3:  11c8d8cdf1a trace2: defer free of TLS CTX until program exit.
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    trace2: defer free of TLS CTX until program exit.
     +    trace2: defer free of thread local storage until program exit.
      
     -    Defer freeing of the Trace2 thread CTX data until program exit.
     -    Create a global list of thread CTX data to own the storage.
     +    Defer freeing of the Trace2 per-thread thread local storage until
     +    program exit.  Create a global list to own them.
      
     -    TLS CTX data is allocated when a thread is created and associated
     -    with that thread.  Previously, that storage was deleted when the
     -    thread exited.  Now we simply disassociate the CTX data from the
     -    thread when it exits and let the global CTX list manage the cleanup.
     +    Trace2 thread local storage data is allocated when a thread is created
     +    and associated with that thread.  Previously, that storage was deleted
     +    when the thread exited.  Now at thread exit, we simply disassociate
     +    the data from the thread and let the global list manage the cleanup.
      
          This will be used by a later commit when we add "counters" and
     -    stopwatch-style "timers" to the Trace2 API.  We will add those
     -    fields to the CTX block and allow threads to efficiently (without
     -    locks) accumulate counter and timer data using TLS.  At program
     -    exit, the main thread can run thru the global list and compute
     -    totals before it frees them.
     +    stopwatch-style "timers" to the Trace2 API.  We will add those fields
     +    to the thread local storage block and allow each thread to efficiently
     +    (without locks) accumulate counter and timer data.  At program exit,
     +    the main thread will run thru the global list and compute and report
     +    totals before freeing the list.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ trace2/tr2_tls.c: static uint64_t tr2tls_us_start_process;
       static pthread_mutex_t tr2tls_mutex;
       static pthread_key_t tr2tls_key;
       
     --static int tr2_next_thread_id; /* modify under lock */
      +/*
      + * This list owns all of the thread-specific CTX data.
      + *
      + * While a thread is alive it is associated with a CTX (owned by this
      + * list) and that CTX is installed in the thread's TLS data area.
     ++ * When a thread exits, it is disassociated from its CTX, but the (now
     ++ * dormant) CTX is held in this list until program exit.
      + *
      + * Similarly, `tr2tls_thread_main` points to a CTX contained within
      + * this list.
      + */
      +static struct tr2tls_thread_ctx *tr2tls_ctx_list; /* modify under lock */
     + static int tr2_next_thread_id; /* modify under lock */
       
       void tr2tls_start_process_clock(void)
     - {
      @@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
       	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
       	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
       
     --	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
     ++	/*
     ++	 * Link this CTX into the CTX list and make it the head.
     ++	 */
      +	pthread_mutex_lock(&tr2tls_mutex);
     -+	if (tr2tls_ctx_list)
     -+		ctx->thread_id = tr2tls_ctx_list->thread_id + 1;
      +	ctx->next_ctx = tr2tls_ctx_list;
      +	tr2tls_ctx_list = ctx;
      +	pthread_mutex_unlock(&tr2tls_mutex);
     ++
     + 	pthread_setspecific(tr2tls_key, ctx);
       
     - 	if (ctx->thread_id)
     - 		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
     + 	return ctx;
      @@ trace2/tr2_tls.c: int tr2tls_is_main_thread(void)
       
       void tr2tls_unset_self(void)
     @@ trace2/tr2_tls.c: int tr2tls_is_main_thread(void)
      -
       	pthread_setspecific(tr2tls_key, NULL);
      -
     --	free(ctx->thread_name);
      -	free(ctx->array_us_start);
      -	free(ctx);
       }
     @@ trace2/tr2_tls.c: void tr2tls_init(void)
      +	while (ctx) {
      +		struct tr2tls_thread_ctx *next = ctx->next_ctx;
      +
     -+		free(ctx->thread_name);
      +		free(ctx->array_us_start);
      +		free(ctx);
      +
     @@ trace2/tr2_tls.c: void tr2tls_init(void)
      
       ## trace2/tr2_tls.h ##
      @@
     - #define TR2_MAX_THREAD_NAME (24)
     + #include "strbuf.h"
       
       struct tr2tls_thread_ctx {
      +	struct tr2tls_thread_ctx *next_ctx;
     - 	char *thread_name;
       	uint64_t *array_us_start;
       	size_t alloc;
     + 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
      @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx *tr2tls_get_self(void);
       int tr2tls_is_main_thread(void);
       
  4:  e5021ab7f58 !  4:  531a1ee45c2 trace2: add thread-name override to event target
     @@ Metadata
       ## Commit message ##
          trace2: add thread-name override to event target
      
     -    Teach the Trace2 event target to allow the thread-name field to
     -    be specified rather than always inherited from the TLS CTX.
     +    Teach the message formatter in the Trace2 event target to take an
     +    optional thread-name argument.  This overrides the thread name
     +    inherited from the thread local storage data.
      
          This will be used in a future commit for global events that should
          not be tied to a particular thread, such as a global stopwatch timer
  5:  51f53633889 !  5:  82c445b75f1 trace2: add thread-name override to perf target
     @@ Metadata
       ## Commit message ##
          trace2: add thread-name override to perf target
      
     -    Teach the Trace2 perf target to allow the thread-name field be
     -    specified rather than always inherited from the TLS CTX.
     +    Teach the message formatter in the Trace2 perf target to accept an
     +    optional thread name argument.  This will override the thread name
     +    inherited from the thread local storage data block.
      
          This will be used in a future commit for global events that should
          not be tied to a particular thread, such as a global stopwatch timer.
     @@ trace2/tr2_tgt_perf.c: static void perf_fmt_prepare(const char *event_name,
      @@ trace2/tr2_tgt_perf.c: static void perf_fmt_prepare(const char *event_name,
       
       	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
     - 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
     --		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
     -+		    thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
     - 		    event_name);
     + 	strbuf_addf(buf, "%-*.*s | %-*s | ", TR2FMT_PERF_MAX_THREAD_NAME,
     +-		    TR2FMT_PERF_MAX_THREAD_NAME, ctx->thread_name,
     ++		    TR2FMT_PERF_MAX_THREAD_NAME, thread_name,
     + 		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
       
       	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
      @@ trace2/tr2_tgt_perf.c: static void perf_io_write_fl(const char *file, int line, const char *event_name,
  6:  c5d5ff05e6c !  6:  62a5c8b0356 trace2: add timer events to perf and event target formats
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Documentation/technical/api-trace2.txt ##
     -@@ Documentation/technical/api-trace2.txt: only present on the "start" and "atexit" events.
     - {
     - 	"event":"version",
     - 	...
     --	"evt":"3",		       # EVENT format version
     -+	"evt":"4",		       # EVENT format version
     - 	"exe":"2.20.1.155.g426c96fcdb" # git version
     - }
     - ------------
      @@ Documentation/technical/api-trace2.txt: The "value" field may be an integer or a string.
       }
       ------------
     @@ Documentation/technical/api-trace2.txt: The "value" field may be an integer or a
      +	...
      +	"name":"test",      # timer name
      +	"count":42,         # number of start+stop intervals
     -+	"t_total":1.234,    # sum of all intervals (by thread or globally)
     -+	"t_min":0.1,        # shortest interval
     -+	"t_max":0.9,        # longest interval
     ++	"ns_total":1234,    # sum of all intervals in nanoseconds
     ++	"ns_min":11,        # shortest interval in nanoseconds
     ++	"ns_max":789,       # longest interval in nanoseconds
      +}
      +------------
      ++
     @@ trace2/tr2_tgt.h: typedef void(tr2_tgt_evt_printf_va_fl_t)(const char *file, int
       					 const char *fmt, va_list ap);
       
      +/*
     -+ * Stopwatch timer event.  This function writes the previously accumlated
     ++ * Stopwatch timer event.  This function writes the previously accumulated
      + * stopwatch timer values to the event streams.  Unlike other Trace2 API
      + * events, this is decoupled from the data collection.
      + *
      + * This does not take a (file,line) pair because a timer event reports
     -+ * the cummulative time spend in the timer over a series of intervals
     ++ * the cumulative time spend in the timer over a series of intervals
      + * -- it does not represent a single usage (like region or data events
      + * do).
      + *
      + * The thread name is optional.  If non-null it will override the
     -+ * value inherited from the caller's TLS CTX.  This allows data
     -+ * for global timers to be reported without associating it with a
     -+ * single thread.
     ++ * value inherited from the caller's thread local storage.  This
     ++ * allows timer data to be aggregated and reported without associating
     ++ * it to a specific thread.
      + */
      +typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
      +				  const char *thread_name,
      +				  const char *category,
      +				  const char *timer_name,
      +				  uint64_t interval_count,
     -+				  uint64_t us_total_time,
     -+				  uint64_t us_min_time,
     -+				  uint64_t us_max_time);
     ++				  uint64_t ns_total_time,
     ++				  uint64_t ns_min_time,
     ++				  uint64_t ns_max_time);
      +
       /*
        * "vtable" for a TRACE2 target.  Use NULL if a target does not want
     @@ trace2/tr2_tgt.h: struct tr2_tgt {
       
      
       ## trace2/tr2_tgt_event.c ##
     -@@ trace2/tr2_tgt_event.c: static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
     -  * interpretation of existing events or fields. Smaller changes, such as adding
     -  * a new field to an existing event, do not require an increment to the EVENT
     -  * format version.
     -+ *
     -+ * Verison 1: original version
     -+ * Version 2: added "too_many_files" event
     -+ * Version 3: added "child_ready" event
     -+ * Version 4: added "timer" event
     -  */
     --#define TR2_EVENT_VERSION "3"
     -+#define TR2_EVENT_VERSION "4"
     - 
     - /*
     -  * Region nesting limit for messages written to the event target.
      @@ trace2/tr2_tgt_event.c: static void fn_data_json_fl(const char *file, int line,
       	}
       }
     @@ trace2/tr2_tgt_event.c: static void fn_data_json_fl(const char *file, int line,
      +		     const char *category,
      +		     const char *timer_name,
      +		     uint64_t interval_count,
     -+		     uint64_t us_total_time,
     -+		     uint64_t us_min_time,
     -+		     uint64_t us_max_time)
     ++		     uint64_t ns_total_time,
     ++		     uint64_t ns_min_time,
     ++		     uint64_t ns_max_time)
      +{
      +	const char *event_name = "timer";
      +	struct json_writer jw = JSON_WRITER_INIT;
      +	double t_abs = (double)us_elapsed_absolute / 1000000.0;
      +
     -+	double t_total = (double)us_total_time / 1000000.0;
     -+	double t_min   = (double)us_min_time   / 1000000.0;
     -+	double t_max   = (double)us_max_time   / 1000000.0;
     -+
      +	jw_object_begin(&jw, 0);
      +	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
      +	jw_object_double(&jw, "t_abs", 6, t_abs);
      +	jw_object_string(&jw, "name", timer_name);
      +	jw_object_intmax(&jw, "count", interval_count);
     -+	jw_object_double(&jw, "t_total", 6, t_total);
     -+	jw_object_double(&jw, "t_min", 6, t_min);
     -+	jw_object_double(&jw, "t_max", 6, t_max);
     ++	jw_object_intmax(&jw, "ns_total", ns_total_time);
     ++	jw_object_intmax(&jw, "ns_min", ns_min_time);
     ++	jw_object_intmax(&jw, "ns_max", ns_max_time);
      +
      +	jw_end(&jw);
      +
     @@ trace2/tr2_tgt_perf.c: static void fn_printf_va_fl(const char *file, int line,
      +		     const char *category,
      +		     const char *timer_name,
      +		     uint64_t interval_count,
     -+		     uint64_t us_total_time,
     -+		     uint64_t us_min_time,
     -+		     uint64_t us_max_time)
     ++		     uint64_t ns_total_time,
     ++		     uint64_t ns_min_time,
     ++		     uint64_t ns_max_time)
      +{
      +	const char *event_name = "timer";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	double t_total = (double)us_total_time / 1000000.0;
     -+	double t_min   = (double)us_min_time   / 1000000.0;
     -+	double t_max   = (double)us_max_time   / 1000000.0;
     -+
     -+	strbuf_addf(&buf_payload, "name:%s", timer_name);
     -+	strbuf_addf(&buf_payload, " count:%"PRIu64, interval_count);
     -+	strbuf_addf(&buf_payload, " total:%9.6f", t_total);
     -+	strbuf_addf(&buf_payload, " min:%9.6f", t_min);
     -+	strbuf_addf(&buf_payload, " max:%9.6f", t_max);
     ++	strbuf_addf(&buf_payload, ("name:%s"
     ++				   " count:%"PRIu64
     ++				   " ns_total:%"PRIu64
     ++				   " ns_min:%"PRIu64
     ++				   " ns_max:%"PRIu64),
     ++		    timer_name, interval_count, ns_total_time, ns_min_time,
     ++		    ns_max_time);
      +
      +	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
      +			 &us_elapsed_absolute, NULL,
  7:  dd4f0576254 !  7:  36e57a22d70 trace2: add stopwatch timers
     @@ Commit message
          event is logged (one per timer) at program exit.
      
          Optionally, timer data may also be reported by thread for certain
     -    timers.  (See trace2/tr2_tmr.c:tr2tmr_def_block[].)
     +    timers.  (See trace2/tr2_tmr.c:tr2_timer_def_block[].)
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ Documentation/technical/api-trace2.txt: at offset 508.
      +in some circumstances.
      ++
      +Timers are defined in `enum trace2_timer_id` in trace2.h and in
     -+`trace2/tr2_tmr.c:tr2tmr_def_block[]`.
     ++`trace2/tr2_tmr.c:tr2_timer_def_block[]`.
      ++
      +----------------
      +static void *unpack_compressed_entry(struct packed_git *p,
     @@ Documentation/technical/api-trace2.txt: at offset 508.
      +...
      +$ cat ~/log.perf
      +...
     -+d0 | summary                  | timer        |     |  0.111026 |           | test         | name:test1 count:4 total: 0.000393 min: 0.000006 max: 0.000302
     ++d0 | summary                  | timer        |     |  0.111026 |           | test         | name:test1 count:4 ns_total:393000 ns_min:6000 ns_max:302000
      +d0 | main                     | atexit       |     |  0.111026 |           |              | code:0
      +----------------
      ++
     @@ t/helper/test-trace2.c: static int ut_007bug(int argc, const char **argv)
      +	return NULL;
      +}
      +
     -+
      +/*
      + * Multi-threaded timer test.  Create several threads that each create
      + * several intervals using the TEST2 timer.  The test script can verify
     @@ t/t0211-trace2-perf.sh: test_expect_success 'using global config, perf stream, r
       
      +# Exercise the stopwatch timer "test" in a loop and confirm that it was
      +# we have as many start/stop intervals as expected.  We cannot really test
     -+# the (elapsed, min, max) timer values, so we assume they are good.
     -+#
     ++# the actual (total, min, max) timer values, so we assume they are good,
     ++# but we can test the keys for them.
     ++
     ++have_timer_event () {
     ++	thread=$1
     ++	name=$2
     ++	count=$3
     ++	file=$4
     ++
     ++	pattern="d0|${thread}|timer||_T_ABS_||test"
     ++	pattern="${pattern}|name:${name}"
     ++	pattern="${pattern} count:${count}"
     ++	pattern="${pattern} ns_total:.*"
     ++	pattern="${pattern} ns_min:.*"
     ++	pattern="${pattern} ns_max:.*"
     ++
     ++	grep "${pattern}" ${file}
     ++
     ++	return $?
     ++}
     ++
      +test_expect_success 'test stopwatch timers - summary only' '
      +	test_when_finished "rm trace.perf actual" &&
      +	test_config_global trace2.perfBrief 1 &&
      +	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
      +	test-tool trace2 008timer 5 10 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
     -+	grep "d0|summary|timer||_T_ABS_||test|name:test1 count:5" actual
     ++
     ++	have_timer_event "summary" "test1" 5 actual
      +'
      +
      +test_expect_success 'test stopwatch timers - summary and threads' '
     @@ t/t0211-trace2-perf.sh: test_expect_success 'using global config, perf stream, r
      +	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
      +	test-tool trace2 009timer 5 10 3 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
     -+	grep "d0|th01:ut_009|timer||_T_ABS_||test|name:test2 count:5" actual &&
     -+	grep "d0|th02:ut_009|timer||_T_ABS_||test|name:test2 count:5" actual &&
     -+	grep "d0|th02:ut_009|timer||_T_ABS_||test|name:test2 count:5" actual &&
     -+	grep "d0|summary|timer||_T_ABS_||test|name:test2 count:15" actual
     ++
     ++	have_timer_event "th01:ut_009" "test2" 5 actual &&
     ++	have_timer_event "th02:ut_009" "test2" 5 actual &&
     ++	have_timer_event "th03:ut_009" "test2" 5 actual &&
     ++	have_timer_event "summary" "test2" 15 actual
      +'
      +
       test_done
     @@ t/t0212-trace2-event.sh: test_expect_success 'discard traces when there are too
      +	count=$3
      +	file=$4
      +
     -+	grep "\"event\":\"timer\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"count\":${count}" $file
     ++	pattern="\"event\":\"timer\""
     ++	pattern="${pattern}.*\"thread\":\"${thread}\""
     ++	pattern="${pattern}.*\"name\":\"${name}\""
     ++	pattern="${pattern}.*\"count\":${count}"
     ++	pattern="${pattern}.*\"ns_total\":[0-9]*"
     ++	pattern="${pattern}.*\"ns_min\":[0-9]*"
     ++	pattern="${pattern}.*\"ns_max\":[0-9]*"
     ++
     ++	grep "${pattern}" ${file}
      +
      +	return $?
      +}
     @@ t/t0212-trace2-event.sh: test_expect_success 'discard traces when there are too
      +	test_config_global trace2.eventBrief 1 &&
      +	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
      +	test-tool trace2 008timer 5 10 &&
     ++
      +	have_timer_event "summary" "test1" 5 trace.event
      +'
      +
     @@ t/t0212-trace2-event.sh: test_expect_success 'discard traces when there are too
      +	test_config_global trace2.eventBrief 1 &&
      +	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
      +	test-tool trace2 009timer 5 10 3 &&
     ++
      +	have_timer_event "th01:ut_009" "test2" 5 trace.event &&
      +	have_timer_event "th02:ut_009" "test2" 5 trace.event &&
      +	have_timer_event "th03:ut_009" "test2" 5 trace.event &&
     @@ trace2.c: static void tr2_tgt_disable_builtins(void)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     -+	struct tr2tmr_block merged;
     ++	struct tr2_timer_block merged = { { { 0 } } };
      +
     -+	memset(&merged, 0, sizeof(merged));
     -+
     -+	/*
     -+	 * Sum across all of the per-thread stopwatch timer data into
     -+	 * a single composite block of timer values.
     -+	 */
     -+	tr2tls_aggregate_timer_blocks(&merged);
     ++	tr2_summarize_timers(&merged);
      +
      +	/*
      +	 * Emit "summary" timer events for each composite timer value
     @@ trace2.c: static void tr2_tgt_disable_builtins(void)
      +	 */
      +	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_timer)
     -+			tr2tmr_emit_block(tgt_j->pfn_timer,
     -+					  us_elapsed_absolute,
     -+					  &merged, "summary");
     ++			tr2_emit_timer_block(tgt_j->pfn_timer,
     ++					     us_elapsed_absolute,
     ++					     &merged, "summary");
      +}
      +
      +static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
     @@ trace2.c: static void tr2_tgt_disable_builtins(void)
      +
      +	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_timer)
     -+			tr2tls_emit_timer_blocks_by_thread(tgt_j->pfn_timer,
     -+							   us_elapsed_absolute);
     ++			tr2_emit_timers_by_thread(tgt_j->pfn_timer,
     ++						  us_elapsed_absolute);
      +}
      +
       static int tr2main_exit_code;
     @@ trace2.c: const char *trace2_session_id(void)
      +		return;
      +
      +	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
     -+		BUG("invalid timer id: %d", tid);
     ++		BUG("trace2_timer_start: invalid timer id: %d", tid);
      +
     -+	tr2tmr_start(tid);
     ++	tr2_start_timer(tid);
      +}
      +
      +void trace2_timer_stop(enum trace2_timer_id tid)
     @@ trace2.c: const char *trace2_session_id(void)
      +		return;
      +
      +	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
     -+		BUG("invalid timer id: %d", tid);
     ++		BUG("trace2_timer_stop: invalid timer id: %d", tid);
      +
     -+	tr2tmr_stop(tid);
     ++	tr2_stop_timer(tid);
      +}
      
       ## trace2.h ##
     @@ trace2.h: void trace2_collect_process_info(enum trace2_process_info_reason reaso
      + * elsewhere as array indexes).
      + *
      + * Any values added to this enum must also be added to the timer definitions
     -+ * array.  See `trace2/tr2_tmr.c:tr2tmr_def_block[]`.
     ++ * array.  See `trace2/tr2_tmr.c:tr2_timer_def_block[]`.
      + */
      +enum trace2_timer_id {
      +	/*
     @@ trace2/tr2_tls.c: int tr2tls_locked_increment(int *p)
       	return current_value;
       }
      +
     -+void tr2tls_aggregate_timer_blocks(struct tr2tmr_block *merged)
     ++void tr2_summarize_timers(struct tr2_timer_block *merged)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
      +
      +	while (ctx) {
      +		struct tr2tls_thread_ctx *next = ctx->next_ctx;
      +
     -+		tr2tmr_aggregate_timers(merged, &ctx->timers);
     ++		tr2_merge_timer_block(merged, &ctx->timers);
      +
      +		ctx = next;
      +	}
      +}
      +
     -+void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *pfn,
     -+					uint64_t us_elapsed_absolute)
     ++void tr2_emit_timers_by_thread(tr2_tgt_evt_timer_t *pfn,
     ++			       uint64_t us_elapsed_absolute)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
      +
      +	while (ctx) {
      +		struct tr2tls_thread_ctx *next = ctx->next_ctx;
      +
     -+		tr2tmr_emit_block(pfn, us_elapsed_absolute, &ctx->timers,
     -+				  ctx->thread_name);
     ++		tr2_emit_timer_block(pfn, us_elapsed_absolute, &ctx->timers,
     ++				     ctx->thread_name);
      +
      +		ctx = next;
      +	}
     @@ trace2/tr2_tls.h
       #include "strbuf.h"
      +#include "trace2/tr2_tmr.h"
       
     - /*
     -  * Arbitry limit for thread names for column alignment.
     + struct tr2tls_thread_ctx {
     + 	struct tr2tls_thread_ctx *next_ctx;
      @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
       	size_t alloc;
       	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
       	int thread_id;
      +
     -+	struct tr2tmr_block timers;
     ++	struct tr2_timer_block timers;
     ++
     + 	char thread_name[FLEX_ARRAY];
       };
       
      +/*
     -+ * Iterate over the global list of TLS CTX data and aggregate the timer
     -+ * data into the given timer block.
     ++ * Iterate over the global list of threads and aggregate the timer
     ++ * data into the given timer block.  The resulting block will contain
     ++ * the global summary of timer usage.
      + */
     -+void tr2tls_aggregate_timer_blocks(struct tr2tmr_block *merged);
     ++void tr2_summarize_timers(struct tr2_timer_block *merged);
      +
      +/*
     -+ * Iterate over the global list of TLS CTX data (the complete set of
     -+ * threads that have used Trace2 resources) data and emit "per-thread"
     -+ * timer data for each.
     ++ * Iterate over the global list of threads and emit "per-thread"
     ++ * timer data.
      + */
     -+void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *pfn,
     -+					uint64_t us_elapsed_absolute);
     ++void tr2_emit_timers_by_thread(tr2_tgt_evt_timer_t *pfn,
     ++			       uint64_t us_elapsed_absolute);
      +
       /*
        * Create TLS data for the current thread.  This gives us a place to
     @@ trace2/tr2_tmr.c (new)
      +#include "trace2/tr2_tls.h"
      +#include "trace2/tr2_tmr.h"
      +
     ++#define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
     ++#define MY_MIN(a, b) ((a) < (b) ? (a) : (b))
     ++
      +/*
      + * Define metadata for each stopwatch timer.  This list must match the
      + * set defined in "enum trace2_timer_id".
      + */
     -+struct tr2tmr_def {
     ++struct tr2_timer_def {
      +	const char *category;
      +	const char *name;
      +
      +	unsigned int want_thread_events:1;
      +};
      +
     -+static struct tr2tmr_def tr2tmr_def_block[TRACE2_NUMBER_OF_TIMERS] = {
     ++static struct tr2_timer_def tr2_timer_def_block[TRACE2_NUMBER_OF_TIMERS] = {
      +	[TRACE2_TIMER_ID_TEST1] = { "test", "test1", 0 },
      +	[TRACE2_TIMER_ID_TEST2] = { "test", "test2", 1 },
      +};
      +
     -+void tr2tmr_start(enum trace2_timer_id tid)
     ++void tr2_start_timer(enum trace2_timer_id tid)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     -+	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
     ++	struct tr2_timer *t = &ctx->timers.timer[tid];
      +
      +	t->recursion_count++;
      +	if (t->recursion_count > 1)
      +		return; /* ignore recursive starts */
      +
     -+	t->start_us = getnanotime() / 1000;
     ++	t->start_ns = getnanotime();
      +}
      +
     -+void tr2tmr_stop(enum trace2_timer_id tid)
     ++void tr2_stop_timer(enum trace2_timer_id tid)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     -+	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
     -+	uint64_t us_now;
     -+	uint64_t us_interval;
     ++	struct tr2_timer *t = &ctx->timers.timer[tid];
     ++	uint64_t ns_now;
     ++	uint64_t ns_interval;
      +
      +	assert(t->recursion_count > 0);
      +
      +	t->recursion_count--;
     -+	if (t->recursion_count > 0)
     -+		return; /* still in recursive call */
     ++	if (t->recursion_count)
     ++		return; /* still in recursive call(s) */
      +
     -+	us_now = getnanotime() / 1000;
     -+	us_interval = us_now - t->start_us;
     ++	ns_now = getnanotime();
     ++	ns_interval = ns_now - t->start_ns;
      +
     -+	t->total_us += us_interval;
     ++	t->total_ns += ns_interval;
      +
     ++	/*
     ++	 * min_ns was initialized to zero (in the xcalloc()) rather
     ++	 * than "(unsigned)-1" when the block of timers was allocated,
     ++	 * so we should always set both the min_ns and max_ns values
     ++	 * the first time that the timer is used.
     ++	 */
      +	if (!t->interval_count) {
     -+		t->min_us = us_interval;
     -+		t->max_us = us_interval;
     ++		t->min_ns = ns_interval;
     ++		t->max_ns = ns_interval;
      +	} else {
     -+		if (us_interval < t->min_us)
     -+			t->min_us = us_interval;
     -+		if (us_interval > t->max_us)
     -+			t->max_us = us_interval;
     ++		t->min_ns = MY_MIN(ns_interval, t->min_ns);
     ++		t->max_ns = MY_MAX(ns_interval, t->max_ns);
      +	}
      +
      +	t->interval_count++;
      +}
      +
     -+void tr2tmr_aggregate_timers(struct tr2tmr_block *merged,
     -+			     const struct tr2tmr_block *src)
     ++void tr2_merge_timer_block(struct tr2_timer_block *merged,
     ++			   const struct tr2_timer_block *src)
      +{
      +	enum trace2_timer_id tid;
      +
      +	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
     -+		struct tr2tmr_timer *t_merged = &merged->timer[tid];
     -+		const struct tr2tmr_timer *t = &src->timer[tid];
     ++		struct tr2_timer *t_merged = &merged->timer[tid];
     ++		const struct tr2_timer *t = &src->timer[tid];
      +
      +		t_merged->is_aggregate = 1;
      +
     -+		if (t->recursion_count > 0) {
     ++		if (t->recursion_count) {
      +			/*
      +			 * A thread exited with a stopwatch running.
      +			 *
     @@ trace2/tr2_tmr.c (new)
      +			 * for the open interval.  I'm going to ignore it
      +			 * and keep going because we may have valid data
      +			 * for previously closed intervals on this timer.
     ++			 *
     ++			 * That is, I'm going to ignore the value of
     ++			 * "now - start_ns".
      +			 */
      +		}
      +
      +		if (!t->interval_count)
      +			continue; /* this timer was not used by this thread. */
      +
     -+		t_merged->total_us += t->total_us;
     ++		t_merged->total_ns += t->total_ns;
      +
      +		if (!t_merged->interval_count) {
     -+			t_merged->min_us = t->min_us;
     -+			t_merged->max_us = t->max_us;
     ++			t_merged->min_ns = t->min_ns;
     ++			t_merged->max_ns = t->max_ns;
      +		} else {
     -+			if (t->min_us < t_merged->min_us)
     -+				t_merged->min_us = t->min_us;
     -+			if (t->max_us > t_merged->max_us)
     -+				t_merged->max_us = t->max_us;
     ++			t_merged->min_ns = MY_MIN(t->min_ns, t_merged->min_ns);
     ++			t_merged->max_ns = MY_MAX(t->max_ns, t_merged->max_ns);
      +		}
      +
      +		t_merged->interval_count += t->interval_count;
     @@ trace2/tr2_tmr.c (new)
      +	merged->is_aggregate = 1;
      +}
      +
     -+void tr2tmr_emit_block(tr2_tgt_evt_timer_t *pfn, uint64_t us_elapsed_absolute,
     -+		       const struct tr2tmr_block *blk, const char *thread_name)
     ++void tr2_emit_timer_block(tr2_tgt_evt_timer_t *pfn,
     ++			  uint64_t us_elapsed_absolute,
     ++			  const struct tr2_timer_block *blk,
     ++			  const char *thread_name)
      +{
      +	enum trace2_timer_id tid;
      +
      +	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
     -+		const struct tr2tmr_timer *t = &blk->timer[tid];
     -+		const struct tr2tmr_def *d = &tr2tmr_def_block[tid];
     ++		const struct tr2_timer *t = &blk->timer[tid];
     ++		const struct tr2_timer_def *d = &tr2_timer_def_block[tid];
      +
      +		if (!t->interval_count)
      +			continue; /* timer was not used */
     @@ trace2/tr2_tmr.c (new)
      +			continue; /* per-thread events not wanted */
      +
      +		pfn(us_elapsed_absolute, thread_name, d->category, d->name,
     -+		    t->interval_count, t->total_us, t->min_us, t->max_us);
     ++		    t->interval_count, t->total_ns, t->min_ns, t->max_ns);
      +	}
      +}
      
     @@ trace2/tr2_tmr.h (new)
      + * dynamically allocating a timer on demand and sharing that
      + * definition with other threads.
      + *
     -+ * Timer values are stored in a fixed size "timer block" inside the
     -+ * TLS CTX.  This allows data to be collected on a thread-by-thread
     -+ * basis without locking.
     ++ * Timer values are stored in a fixed size "timer block" inside thread
     ++ * local storage.  This allows data to be collected on a
     ++ * thread-by-thread basis without locking.
     ++ *
     ++ * Using this "timer block" model costs ~48 bytes per timer per thread
     ++ * (we have about six uint64 fields per timer).  This does increase
     ++ * the size of the thread local storage block, but it is allocated (at
     ++ * thread create time) and not on the thread stack, so I'm not worried
     ++ * about the size.  Using an array of timers in this block gives us
     ++ * constant time access to each timer within each thread, so we don't
     ++ * need to do expensive lookups (like hashmaps) to start/stop a timer.
      + *
      + * We define (at compile time) a set of "timer ids" to access the
     -+ * various timers inside the fixed size "timer block".
     ++ * various timers inside the fixed size "timer block".  See
     ++ * `trace2_timer_id` in `trace2/trace2.h`.
      + *
     -+ * Timer definitions include the Trace2 "category" and similar fields.
     -+ * This eliminates the need to include those args on the various timer
     -+ * APIs.
     ++ * Timer definitions also include "category", "name", and similar
     ++ * fields.  These are defined in a parallel table in `tr2_tmr.c` and
     ++ * eliminate the need to include those args in the various timer APIs.
      + *
      + * Timer results are summarized and emitted by the main thread at
     -+ * program exit by iterating over the global list of CTX data.
     ++ * program exit by iterating over the global list of thread local
     ++ * storage data blocks.
      + */
      +
      +/*
      + * The definition of an individual timer and used by an individual
      + * thread.
      + */
     -+struct tr2tmr_timer {
     ++struct tr2_timer {
      +	/*
     -+	 * Total elapsed time for this timer in this thread.
     ++	 * Total elapsed time for this timer in this thread in nanoseconds.
      +	 */
     -+	uint64_t total_us;
     ++	uint64_t total_ns;
      +
      +	/*
      +	 * The maximum and minimum interval values observed for this
      +	 * timer in this thread.
      +	 */
     -+	uint64_t min_us;
     -+	uint64_t max_us;
     ++	uint64_t min_ns;
     ++	uint64_t max_ns;
      +
      +	/*
      +	 * The value of the clock when this timer was started in this
      +	 * thread.  (Undefined when the timer is not active in this
      +	 * thread.)
      +	 */
     -+	uint64_t start_us;
     ++	uint64_t start_ns;
      +
      +	/*
      +	 * Number of times that this timer has been started and stopped
     @@ trace2/tr2_tmr.h (new)
      +};
      +
      +/*
     -+ * A compile-time fixed-size block of timers to insert into the TLS CTX.
     ++ * A compile-time fixed-size block of timers to insert into thread
     ++ * local storage.
      + *
      + * We use this simple wrapper around the array of timer instances to
      + * avoid C syntax quirks and the need to pass around an additional size_t
      + * argument.
      + */
     -+struct tr2tmr_block {
     -+	struct tr2tmr_timer timer[TRACE2_NUMBER_OF_TIMERS];
     ++struct tr2_timer_block {
     ++	struct tr2_timer timer[TRACE2_NUMBER_OF_TIMERS];
      +
      +	/*
      +	 * Has data from multiple threads been combined into this block.
     @@ trace2/tr2_tmr.h (new)
      + * Private routines used by trace2.c to actually start/stop an individual
      + * timer in the current thread.
      + */
     -+void tr2tmr_start(enum trace2_timer_id tid);
     -+void tr2tmr_stop(enum trace2_timer_id tid);
     ++void tr2_start_timer(enum trace2_timer_id tid);
     ++void tr2_stop_timer(enum trace2_timer_id tid);
      +
      +/*
     -+ * Accumulate timer data from source block into the merged block.
     ++ * Accumulate timer data for all of the individual timers in the source
     ++ * block into the corresponding timers in the merged block.
     ++ *
     ++ * This will aggregate data from one block (from an individual thread)
     ++ * into the merge block.
      + */
     -+void tr2tmr_aggregate_timers(struct tr2tmr_block *merged,
     -+			     const struct tr2tmr_block *src);
     ++void tr2_merge_timer_block(struct tr2_timer_block *merged,
     ++			   const struct tr2_timer_block *src);
      +
      +/*
      + * Send stopwatch data for all of the timers in this block to the
     -+ * target.
     ++ * trace target destination.
      + *
     -+ * This will generate an event record for each timer that had activity
     -+ * during the program's execution.
     ++ * This will generate an event record for each timer in the block that
     ++ * had activity during the program's execution.  (If this is called
     ++ * with a per-thread block, we emit the per-thread data; if called
     ++ * with a aggregate block, we emit summary data.)
      + */
     -+void tr2tmr_emit_block(tr2_tgt_evt_timer_t *pfn, uint64_t us_elapsed_absolute,
     -+		       const struct tr2tmr_block *blk, const char *thread_name);
     ++void tr2_emit_timer_block(tr2_tgt_evt_timer_t *pfn,
     ++			  uint64_t us_elapsed_absolute,
     ++			  const struct tr2_timer_block *blk,
     ++			  const char *thread_name);
      +
      +#endif /* TR2_TM_H */
  8:  3e39c8172f5 !  8:  0ef23190759 trace2: add counter events to perf and event target formats
     @@ Documentation/technical/api-trace2.txt: may exceed the "atexit" elapsed time of
      
       ## trace2/tr2_tgt.h ##
      @@ trace2/tr2_tgt.h: typedef void(tr2_tgt_evt_timer_t)(uint64_t us_elapsed_absolute,
     - 				  uint64_t us_min_time,
     - 				  uint64_t us_max_time);
     + 				  uint64_t ns_min_time,
     + 				  uint64_t ns_max_time);
       
      +/*
      + * Item counter event.
     @@ trace2/tr2_tgt.h: struct tr2_tgt {
       
      
       ## trace2/tr2_tgt_event.c ##
     -@@ trace2/tr2_tgt_event.c: static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
     -  * Verison 1: original version
     -  * Version 2: added "too_many_files" event
     -  * Version 3: added "child_ready" event
     -- * Version 4: added "timer" event
     -+ * Version 4: added "timer" and "counter" events
     -  */
     - #define TR2_EVENT_VERSION "4"
     - 
      @@ trace2/tr2_tgt_event.c: static void fn_timer(uint64_t us_elapsed_absolute,
       	jw_release(&jw);
       }
     @@ trace2/tr2_tgt_perf.c: static void fn_timer(uint64_t us_elapsed_absolute,
      +	const char *event_name = "counter";
      +	struct strbuf buf_payload = STRBUF_INIT;
      +
     -+	strbuf_addf(&buf_payload, "name:%s", counter_name);
     -+	strbuf_addf(&buf_payload, " value:%"PRIu64, value);
     ++	strbuf_addf(&buf_payload, "name:%s value:%"PRIu64, counter_name, value);
      +
      +	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL,
      +			 &us_elapsed_absolute, NULL,
  9:  596caede216 !  9:  4d6155e4e4c trace2: add global counters
     @@ Documentation/technical/api-trace2.txt: d0 | main                     | atexit
      +	int i;
      +	unsigned long src_offset = start_offset;
      +
     -+	trace2_counter_add(TRACE2_COUNTER_ID_TEST2, nr);
     ++	trace2_counter_increment(TRACE2_COUNTER_ID_TEST2, nr);
      +
      +	for (i = offset; i < offset + nr; i++) {
      +		...
     @@ Makefile: LIB_OBJS += trace.o
       LIB_OBJS += trace2/tr2_tmr.o
      
       ## t/helper/test-trace2.c ##
     +@@ t/helper/test-trace2.c: static int ut_009timer(int argc, const char **argv)
     + 	const char *usage_error =
     + 		"expect <count> <ms_delay> <threads>";
     + 
     +-	struct ut_009_data data = { 0, 0 };
     ++	struct ut_009_data data = { 0 };
     + 	int nr_threads = 0;
     + 	int k;
     + 	pthread_t *pids = NULL;
      @@ t/helper/test-trace2.c: static int ut_009timer(int argc, const char **argv)
       	return 0;
       }
     @@ t/helper/test-trace2.c: static struct unit_test ut_table[] = {
      
       ## t/t0211-trace2-perf.sh ##
      @@ t/t0211-trace2-perf.sh: test_expect_success 'test stopwatch timers - summary and threads' '
     - 	grep "d0|summary|timer||_T_ABS_||test|name:test2 count:15" actual
     + 	have_timer_event "summary" "test2" 15 actual
       '
       
      +# Exercise the global counter "test" in a loop and confirm that we get an
      +# event with the sum.
      +#
     ++
     ++have_counter_event () {
     ++	thread=$1
     ++	name=$2
     ++	value=$3
     ++	file=$4
     ++
     ++	pattern="d0|${thread}|counter||_T_ABS_||test"
     ++	pattern="${pattern}|name:${name}"
     ++	pattern="${pattern} value:${value}"
     ++
     ++	grep "${pattern}" ${file}
     ++
     ++	return $?
     ++}
     ++
      +test_expect_success 'test global counters - global, single-thead' '
      +	test_when_finished "rm trace.perf actual" &&
      +	test_config_global trace2.perfBrief 1 &&
      +	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
      +	test-tool trace2 010counter 2 3 5 7 11 13  &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
     -+	grep "d0|summary|counter||_T_ABS_||test|name:test1 value:41" actual
     ++
     ++	have_counter_event "summary" "test1" 41 actual
      +'
      +
      +test_expect_success 'test global counters - global+threads' '
     @@ t/t0211-trace2-perf.sh: test_expect_success 'test stopwatch timers - summary and
      +	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
      +	test-tool trace2 011counter 5 10 3 &&
      +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
     -+	grep "d0|th01:ut_011|counter||_T_ABS_||test|name:test2 value:15" actual &&
     -+	grep "d0|th02:ut_011|counter||_T_ABS_||test|name:test2 value:15" actual &&
     -+	grep "d0|th02:ut_011|counter||_T_ABS_||test|name:test2 value:15" actual &&
     -+	grep "d0|summary|counter||_T_ABS_||test|name:test2 value:45" actual
     ++
     ++	have_counter_event "th01:ut_011" "test2" 15 actual &&
     ++	have_counter_event "th02:ut_011" "test2" 15 actual &&
     ++	have_counter_event "th03:ut_011" "test2" 15 actual &&
     ++	have_counter_event "summary" "test2" 45 actual
      +'
      +
       test_done
     @@ t/t0212-trace2-event.sh: test_expect_success 'test stopwatch timers - global+thr
      +	value=$3
      +	file=$4
      +
     -+	grep "\"event\":\"counter\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"value\":${value}" $file
     ++	pattern="\"event\":\"counter\""
     ++	pattern="${pattern}.*\"thread\":\"${thread}\""
     ++	pattern="${pattern}.*\"name\":\"${name}\""
     ++	pattern="${pattern}.*\"value\":${value}"
     ++
     ++	grep "${pattern}" ${file}
      +
      +	return $?
      +}
     @@ t/t0212-trace2-event.sh: test_expect_success 'test stopwatch timers - global+thr
      +	test_config_global trace2.eventBrief 1 &&
      +	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
      +	test-tool trace2 010counter 2 3 5 7 11 13 &&
     ++
      +	have_counter_event "summary" "test1" 41 trace.event
      +'
      +
     @@ t/t0212-trace2-event.sh: test_expect_success 'test stopwatch timers - global+thr
      +	test_config_global trace2.eventBrief 1 &&
      +	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
      +	test-tool trace2 011counter 5 10 3 &&
     ++
      +	have_counter_event "th01:ut_011" "test2" 15 trace.event &&
      +	have_counter_event "th02:ut_011" "test2" 15 trace.event &&
      +	have_counter_event "th03:ut_011" "test2" 15 trace.event &&
     @@ trace2.c
       #include "trace2/tr2_sid.h"
       #include "trace2/tr2_sysenv.h"
      @@ trace2.c: static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
     - 							   us_elapsed_absolute);
     + 						  us_elapsed_absolute);
       }
       
      +static void tr2main_emit_summary_counters(uint64_t us_elapsed_absolute)
      +{
      +	struct tr2_tgt *tgt_j;
      +	int j;
     -+	struct tr2ctr_block merged;
     -+
     -+	memset(&merged, 0, sizeof(merged));
     ++	struct tr2_counter_block merged = { { { 0 } } };
      +
      +	/*
      +	 * Sum across all of the per-thread counter data into
     @@ trace2.c: static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
      +	 */
      +	for_each_wanted_builtin (j, tgt_j)
      +		if (tgt_j->pfn_counter)
     -+			tr2ctr_emit_block(tgt_j->pfn_counter,
     -+					  us_elapsed_absolute,
     -+					  &merged, "summary");
     ++			tr2_emit_counter_block(tgt_j->pfn_counter,
     ++					       us_elapsed_absolute,
     ++					       &merged, "summary");
      +}
      +
      +static void tr2main_emit_thread_counters(uint64_t us_elapsed_absolute)
     @@ trace2.c: static void tr2main_atexit_handler(void)
       			tgt_j->pfn_atexit(us_elapsed_absolute,
      @@ trace2.c: void trace2_timer_stop(enum trace2_timer_id tid)
       
     - 	tr2tmr_stop(tid);
     + 	tr2_stop_timer(tid);
       }
      +
      +void trace2_counter_add(enum trace2_counter_id cid, uint64_t value)
     @@ trace2.c: void trace2_timer_stop(enum trace2_timer_id tid)
      +	if (cid < 0 || cid >= TRACE2_NUMBER_OF_COUNTERS)
      +		BUG("invalid counter id: %d", cid);
      +
     -+	tr2ctr_add(cid, value);
     ++	tr2_counter_increment(cid, value);
      +}
      
       ## trace2.h ##
     @@ trace2.h: enum trace2_timer_id {
      + * as array indexes).
      + *
      + * Any value added to this enum must also be added to the counter
     -+ * definitions array.  See `trace2/tr2_ctr.c:tr2ctr_def_block[]`.
     ++ * definitions array.  See `trace2/tr2_ctr.c:tr2_counter_def_block[]`.
      + */
      +enum trace2_counter_id {
      +	/*
     @@ trace2/tr2_ctr.c (new)
      + * Define metadata for each global counter.  This list must match the
      + * set defined in "enum trace2_counter_id".
      + */
     -+struct tr2ctr_def {
     ++struct tr2_counter_def {
      +	const char *category;
      +	const char *name;
      +
      +	unsigned int want_thread_events:1;
      +};
      +
     -+static struct tr2ctr_def tr2ctr_def_block[TRACE2_NUMBER_OF_COUNTERS] = {
     ++static struct tr2_counter_def tr2_counter_def_block[TRACE2_NUMBER_OF_COUNTERS] = {
      +	[TRACE2_COUNTER_ID_TEST1] = { "test", "test1", 0 },
      +	[TRACE2_COUNTER_ID_TEST2] = { "test", "test2", 1 },
      +};
      +
     -+void tr2ctr_add(enum trace2_counter_id cid, uint64_t value)
     ++void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
     -+	struct tr2ctr_counter *c = &ctx->counters.counter[cid];
     ++	struct tr2_counter *c = &ctx->counters.counter[cid];
      +
      +	c->value += value;
      +}
      +
     -+void tr2ctr_aggregate_counters(struct tr2ctr_block *merged,
     -+			       const struct tr2ctr_block *src)
     ++void tr2_merge_counter_block(struct tr2_counter_block *merged,
     ++			     const struct tr2_counter_block *src)
      +{
      +	enum trace2_counter_id cid;
      +
      +	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
     -+		struct tr2ctr_counter *c_merged = &merged->counter[cid];
     -+		const struct tr2ctr_counter *c = &src->counter[cid];
     ++		struct tr2_counter *c_merged = &merged->counter[cid];
     ++		const struct tr2_counter *c = &src->counter[cid];
      +
      +		c_merged->is_aggregate = 1;
      +
     @@ trace2/tr2_ctr.c (new)
      +	merged->is_aggregate = 1;
      +}
      +
     -+void tr2ctr_emit_block(tr2_tgt_evt_counter_t *pfn, uint64_t us_elapsed_absolute,
     -+		       const struct tr2ctr_block *blk, const char *thread_name)
     ++void tr2_emit_counter_block(tr2_tgt_evt_counter_t *pfn,
     ++			    uint64_t us_elapsed_absolute,
     ++			    const struct tr2_counter_block *blk,
     ++			    const char *thread_name)
      +{
      +	enum trace2_counter_id cid;
      +
      +	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
     -+		const struct tr2ctr_counter *c = &blk->counter[cid];
     -+		const struct tr2ctr_def *d = &tr2ctr_def_block[cid];
     ++		const struct tr2_counter *c = &blk->counter[cid];
     ++		const struct tr2_counter_def *d = &tr2_counter_def_block[cid];
      +
      +		if (!c->value)
      +			continue; /* counter was not used */
     @@ trace2/tr2_ctr.h (new)
      + *
      + * A counter defintion table provides the counter category and name
      + * so we can eliminate those arguments from the public counter API.
     ++ * These are defined in a parallel tabel in `tr2_ctr.c`.
      + *
     -+ * Each active thread maintains a counter block in its TLS CTX and
     -+ * increments them without locking.  At program exit, the counter
     -+ * blocks from all of the individual CTXs are added together to give
     -+ * the final summary value for the each global counter.
     ++ * Each thread has a private block of counters in its thread local
     ++ * storage data so no locks are required for a thread to increment
     ++ * it's version of the counter.  At program exit, the counter blocks
     ++ * from all of the per-thread counters are added together to give the
     ++ * final summary value for the each global counter.
      + */
      +
      +/*
      + * The definition of an individual counter.
      + */
     -+struct tr2ctr_counter {
     ++struct tr2_counter {
      +	uint64_t value;
      +
      +	unsigned int is_aggregate:1;
     @@ trace2/tr2_ctr.h (new)
      +/*
      + * Compile time fixed block of all defined counters.
      + */
     -+struct tr2ctr_block {
     -+	struct tr2ctr_counter counter[TRACE2_NUMBER_OF_COUNTERS];
     ++struct tr2_counter_block {
     ++	struct tr2_counter counter[TRACE2_NUMBER_OF_COUNTERS];
      +
      +	unsigned int is_aggregate:1;
      +};
     @@ trace2/tr2_ctr.h (new)
      +/*
      + * Add "value" to the global counter.
      + */
     -+void tr2ctr_add(enum trace2_counter_id cid, uint64_t value);
     ++void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value);
      +
      +/*
      + * Accumulate counter data from the source block into the merged block.
      + */
     -+void tr2ctr_aggregate_counters(struct tr2ctr_block *merged,
     -+			       const struct tr2ctr_block *src);
     ++void tr2_merge_counter_block(struct tr2_counter_block *merged,
     ++			       const struct tr2_counter_block *src);
      +
      +/*
      + * Send counter data for all counters in this block to the target.
      + *
      + * This will generate an event record for each counter that had activity.
      + */
     -+void tr2ctr_emit_block(tr2_tgt_evt_counter_t *pfn, uint64_t us_elapsed_absolute,
     -+		       const struct tr2ctr_block *blk, const char *thread_name);
     ++void tr2_emit_counter_block(tr2_tgt_evt_counter_t *pfn,
     ++			    uint64_t us_elapsed_absolute,
     ++			    const struct tr2_counter_block *blk,
     ++			    const char *thread_name);
      +
      +#endif /* TR2_CTR_H */
      
     @@ trace2/tr2_tls.c
       #include "trace2/tr2_tls.h"
       #include "trace2/tr2_tmr.h"
       
     -@@ trace2/tr2_tls.c: void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *pfn,
     +@@ trace2/tr2_tls.c: void tr2_emit_timers_by_thread(tr2_tgt_evt_timer_t *pfn,
       		ctx = next;
       	}
       }
      +
     -+void tr2tls_aggregate_counter_blocks(struct tr2ctr_block *merged)
     ++void tr2tls_aggregate_counter_blocks(struct tr2_counter_block *merged)
      +{
      +	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
      +
      +	while (ctx) {
      +		struct tr2tls_thread_ctx *next = ctx->next_ctx;
      +
     -+		tr2ctr_aggregate_counters(merged, &ctx->counters);
     ++		tr2_merge_counter_block(merged, &ctx->counters);
      +
      +		ctx = next;
      +	}
     @@ trace2/tr2_tls.c: void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *p
      +	while (ctx) {
      +		struct tr2tls_thread_ctx *next = ctx->next_ctx;
      +
     -+		tr2ctr_emit_block(pfn, us_elapsed_absolute, &ctx->counters,
     -+				  ctx->thread_name);
     ++		tr2_emit_counter_block(pfn, us_elapsed_absolute, &ctx->counters,
     ++				       ctx->thread_name);
      +
      +		ctx = next;
      +	}
     @@ trace2/tr2_tls.h
      +#include "trace2/tr2_ctr.h"
       #include "trace2/tr2_tmr.h"
       
     - /*
     + struct tr2tls_thread_ctx {
      @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
     - 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
       	int thread_id;
       
     -+	struct tr2ctr_block counters;
     - 	struct tr2tmr_block timers;
     + 	struct tr2_timer_block timers;
     ++	struct tr2_counter_block counters;
     + 
     + 	char thread_name[FLEX_ARRAY];
       };
       
      +/*
     -+ * Iterate over the global list of TLS CTX data and aggregate the
     -+ * counter data into the given counter block.
     ++ * Iterate over the global list of threads and aggregate the
     ++ * counter data into the given counter block.  The resulting block
     ++ * will contain the global counter sums.
      + */
     -+void tr2tls_aggregate_counter_blocks(struct tr2ctr_block *merged);
     ++void tr2tls_aggregate_counter_blocks(struct tr2_counter_block *merged);
      +
      +/*
     -+ * Iterate over the global list of TLS CTX data (the complete set of
     -+ * threads that have used Trace2 resources) data and emit "per-thread"
     ++ * Iterate over the global list of threads and emit "per-thread"
      + * counter data for each.
      + */
      +void tr2tls_emit_counter_blocks_by_thread(tr2_tgt_evt_counter_t *pfn,
      +					  uint64_t us_elapsed_absolute);
      +
       /*
     -  * Iterate over the global list of TLS CTX data and aggregate the timer
     -  * data into the given timer block.
     +  * Iterate over the global list of threads and aggregate the timer
     +  * data into the given timer block.  The resulting block will contain

-- 
gitgitgadget
