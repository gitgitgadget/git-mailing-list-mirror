Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60EC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 10:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJNKAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJNKAs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 06:00:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD6BBF1B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 03:00:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so5006723wme.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYA1MaRUKVxEPfpPIK86dDZf5rYrt3X3cEzhFj/b564=;
        b=hGECN5FAyv5vGONRA2tvoHSh/vcSIcbVHL/R35suCR34Up4qLo5qTgC0tJQQYANlNn
         r91KFY5IoOVlTRm6f50wS8Ar5kax/D5l8fL4uic0L86uwDtGFtqnC/J6lvLbIZ9cG666
         gG+0yprVOzsDwXQ/rVl+IGSnDYWEU3hp4obDKekiuM0Lmo8y+g+6Cgiw3x6cs/Lt5cuU
         43zGh5frYZSVKrklSd0JaElpeQDHnUz48sYHagcIHX2+7H6BQLfzj9B/70o/ZYT8hcx0
         rcGDNC1YEF+tWQdoyzPrxC7eWAmw3Ak/MqB6i949vFFe4u3vZHtaOwaae7Q9+ZDoI3Ud
         zJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYA1MaRUKVxEPfpPIK86dDZf5rYrt3X3cEzhFj/b564=;
        b=ofgVyndIXupV7FuoClwEEHx+ZH50nhTcUF0uHlP/wuKTVRdSzCN7H5CKWbiTm0Qz+s
         taKUeXTohd+e8a7QmJUIddV5Uob3FLa4Gsxd10UbXEp0dDzcL2vd9ME/U9J/tI+D7pbo
         v2yXqrJSzs6KeO8fBNBpqzZpCdQjP7fI7Np6BKUmVkpy71GRJwF229Nmu4vDUGBh69+x
         wBUFV8GFr9lDtEHsEtXORRMjIBEol6Wa7gSkVSuiHbfEVuTCwNczpOuCIvFqE2gDdWw6
         8iuvmc0meMKTmHZEj/SgAxHdqAhlJTBmfBaCZ+xAbWLvrzngjiooO68at27u7DoN+/GO
         mjkQ==
X-Gm-Message-State: ACrzQf0sjUoH+cH2ySoBQWWtir8mdA7vQo8PYYnQF2xEvejzl6upCsIt
        x+gld1sq/kX7MdOQC7IuVxfEUq7ReLI=
X-Google-Smtp-Source: AMsMyM7wGbNH5xaHoPeN8pym46U/KQvWjZbe68AdlZF792bMK3LMElyNqlNaEhwqZAc4FsL+cO7Hyg==
X-Received: by 2002:a05:600c:6008:b0:3c6:c3fa:c173 with SMTP id az8-20020a05600c600800b003c6c3fac173mr3057303wmb.190.1665741638237;
        Fri, 14 Oct 2022 03:00:38 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d488b000000b0022eafed36ebsm1555355wrq.73.2022.10.14.03.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 03:00:37 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <06bc6ffe-3f64-481e-5c54-156a39865e25@dunelm.org.uk>
Date:   Fri, 14 Oct 2022 11:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/15] run-command API: pass functions & opts via
 struct
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/10/2022 22:02, Ævar Arnfjörð Bjarmason wrote:
> For a general overview see the v2 CL:
> https://lore.kernel.org/git/cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com/
> 
> Changes since v2:
> 
>   * Ejected various not-to-the-point of converting to the "opts struct"
>     per feedback about attempting to make this leaner.

We're back to the same number of patches as v1 but you've removed three 
test cleanups and squashed three patches together which means there are 
five new patches in this version - what are they doing?

>   * I kept the size_t change & the online_cpus() fallback, and updated
>     a commit message for the latter. For "int" v.s. "size_t" once we're
>     not handling "-1" to mean "use the default" it makes sense to be
>     unsigned, and if we're re-doing that at this point we'd need
>     rewrites for "!processes" assumptions.

I left some comments about this, I think the size_t change is taking us 
in the wrong direction as it is introducing a number of new implicit 
signed->unsigned conversions. I'm still not sure why you need the 
online_cups() changes c.f. 
https://lore.kernel.org/git/8f95fbdb-b211-56af-8693-0e5a84afebac@gmail.com/ 
which has never had a reply

>   * Squashed the multi-step introduction of the "opts" struct, per
>     Phillip's suggestion.
That's most welcome, thanks

>   * Fixed a segfault in the v2's 22/22 (this 15/15).
>   * Got rid of superfluous unsigned conversions of code related to the
>     "env" member.

I've read through to 'API: move *_tr2() users to 
"run_processes_parallel()"' and apart from my comments above they seem 
reasonable (I'm not that taken with the const struct members but it is a 
fairly small change)

Best Wishes

Phillip

> Ævar Arnfjörð Bjarmason (15):
>    run-command test helper: use "else if" pattern
>    run-command API: have "run_processes_parallel{,_tr2}()" return void
>    run-command tests: use "return", not "exit"
>    run-command API: make "n" parameter a "size_t"
>    run-command API: don't fall back on online_cpus()
>    run-command.c: use designated init for pp_init(), add "const"
>    run-command API: have run_process_parallel() take an "opts" struct
>    run-command API: move *_tr2() users to "run_processes_parallel()"
>    run-command.c: make "struct parallel_processes" const if possible
>    run-command.c: don't copy *_fn to "struct parallel_processes"
>    run-command.c: don't copy "ungroup" to "struct parallel_processes"
>    run-command.c: don't copy "data" to "struct parallel_processes"
>    run-command.c: use "opts->processes", not "pp->max_processes"
>    run-command.c: pass "opts" further down, and use "opts->processes"
>    run-command.c: remove "max_processes", add "const" to signal() handler
> 
>   builtin/fetch.c             |  25 ++--
>   builtin/submodule--helper.c |  16 ++-
>   hook.c                      |  23 ++--
>   run-command.c               | 236 ++++++++++++++++--------------------
>   run-command.h               |  71 ++++++++---
>   submodule-config.c          |   2 +
>   submodule.c                 |  18 ++-
>   t/helper/test-run-command.c |  77 +++++++-----
>   t/t5526-fetch-submodules.sh |   8 +-
>   9 files changed, 268 insertions(+), 208 deletions(-)
> 
> Range-diff against v2:
>   1:  bc51dfcb1be <  -:  ----------- hook tests: fix redirection logic error in 96e7225b310
>   2:  3027f5587a7 <  -:  ----------- submodule tests: reset "trace.out" between "grep" invocations
>   3:  c4923358bbd <  -:  ----------- run-command tests: test stdout of run_command_parallel()
>   4:  26e28086252 =  1:  d3a2489d9b2 run-command test helper: use "else if" pattern
>   5:  5e09dc68fd9 =  2:  a2e4fd652c1 run-command API: have "run_processes_parallel{,_tr2}()" return void
>   6:  e4e91dbbf9e =  3:  4a19de65783 run-command tests: use "return", not "exit"
>   7:  b90961ae76d <  -:  ----------- run-command.c: remove dead assignment in while-loop
>   8:  279b0430c5d <  -:  ----------- run-command.c: use C99 "for (TYPE VAR = ..." syntax where useful
>   9:  a900711270c !  4:  58018a79b2f run-command API: make "n" parameter a "size_t"
>      @@ Commit message
>       
>                   make run-command.o DEVOPTS=extra-all CFLAGS=-Wno-unused-parameter
>       
>      -    Only has one (and new) -Wsigned-compare warning, about a comparison of
>      -    "i" to online_cpus(), a subsequent commit will adjust & deal with
>      -    online_cpus() and that warning.
>      +    Only has one (and new) -Wsigned-compare warning relevant to a
>      +    comparison about our "n" or "{nr,max}_processes": About using our
>      +    "n" (size_t) in the same expression as online_cpus() (int). A
>      +    subsequent commit will adjust & deal with online_cpus() and that
>      +    warning.
>       
>           The only users of the "n" parameter are:
>       
>      @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp)
>        
>        	for (i = 0; i < pp->max_processes; i++)
>        		if (pp->children[i].state == GIT_CP_FREE)
>      -@@ run-command.c: static int pp_start_one(struct parallel_processes *pp)
>      -
>      - static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>      - {
>      --	int i;
>      --
>      - 	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
>      - 		if (errno == EINTR)
>      - 			continue;
>       @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>        	}
>        
> 10:  eb9d672b0d8 !  5:  e230701dff6 run-command API: don't fall back on online_cpus()
>      @@ Commit message
>           child processor, 2015-12-15).
>       
>           Most of our code in-tree that scales up to "online_cpus()" by default
>      -    calls that function by itself. By having these callers of the
>      -    "run_processes_parallel()" API do the same we can in subsequent
>      -    commits pass all arguments down as a "const struct".
>      +    calls that function by itself. Keeping this default behavior just for
>      +    the sake of two callers means that we'd need to maintain this one spot
>      +    where we're second-guessing the config passed down into pp_init().
>       
>           The preceding commit has an overview of the API callers that passed
>           "jobs = 0". There were only two of them (actually three, but they
>      @@ submodule-config.c: int parse_submodule_fetchjobs(const char *var, const char *v
>       
>        ## t/t5526-fetch-submodules.sh ##
>       @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetching submodules respects parallel settings' '
>      + 		GIT_TRACE=$(pwd)/trace.out git fetch &&
>      + 		grep "8 tasks" trace.out &&
>        		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
>      - 		grep "9 tasks" trace.out &&
>      - 		>trace.out &&
>      +-		grep "9 tasks" trace.out
>      ++		grep "9 tasks" trace.out &&
>      ++		>trace.out &&
>       +
>       +		GIT_TRACE=$(pwd)/trace.out git -c submodule.fetchJobs=0 fetch &&
>       +		grep "preparing to run up to [0-9]* tasks" trace.out &&
> 11:  aedda10d8e1 !  6:  df2ca5dd097 run-command.c: use designated init for pp_init(), add "const"
>      @@ run-command.c: void run_processes_parallel(size_t n,
>       -		ungroup);
>       +	pp_init(&pp, get_next_task, start_failure, task_finished);
>        	while (1) {
>      - 		for (int i = 0;
>      + 		for (i = 0;
>        		    i < spawn_cap && !pp.shutdown &&
> 12:  fde2af11579 <  -:  ----------- run-command API: add nascent "struct run_process_parallel_opts"
> 13:  01e894bed90 <  -:  ----------- run-command API: make run_process_parallel{,_tr2}() thin wrappers
> 14:  41c2886b44b !  7:  eaed3d8838d run-command API: have run_process_parallel() take an "opts" struct
>      @@ Metadata
>        ## Commit message ##
>           run-command API: have run_process_parallel() take an "opts" struct
>       
>      -    Have the "run_process_parallel()" function take an "opts" struct,
>      -    which allows us to eliminate it as a wrapper for
>      -    "run_processes_parallel_1()".
>      +    As noted in fd3aaf53f71 (run-command: add an "ungroup" option to
>      +    run_process_parallel(), 2022-06-07) which added the "ungroup" passing
>      +    it to "run_process_parallel()" via the global
>      +    "run_processes_parallel_ungroup" variable was a compromise to get the
>      +    smallest possible regression fix for "maint" at the time.
>      +
>      +    This follow-up to that is a start at passing that parameter and others
>      +    via a new "struct run_process_parallel_opts", as the earlier
>      +    version[1] of what became fd3aaf53f71 did.
>      +
>      +    Since we need to change all of the occurrences of "n" to
>      +    "opt->SOMETHING" let's take the opportunity and rename the terse "n"
>      +    to "processes". We could also have picked "max_processes", "jobs",
>      +    "threads" etc., but as the API is named "run_processes_parallel()"
>      +    let's go with "processes".
>       
>           Since the new "run_processes_parallel()" function is able to take an
>           optional "tr2_category" and "tr2_label" via the struct we can at this
>           point migrate all of the users of "run_processes_parallel_tr2()" over
>           to it.
>       
>      -    But let's not migrate all the API users, only the two users that
>      +    But let's not migrate all the API users yet, only the two users that
>           passed the "ungroup" parameter via the
>      -    "run_processes_parallel_ungroup" global, allowing us to delete that
>      -    global in favor of passing "ungroup" via the "opts" struct. As noted
>      -    in fd3aaf53f71 (run-command: add an "ungroup" option to
>      -    run_process_parallel(), 2022-06-07) which added
>      -    "run_processes_parallel_ungroup" passing this as a global was a hack
>      -    to produce a small regression fix for "maint".
>      +    "run_processes_parallel_ungroup" global
>      +
>      +    1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>      @@ run-command.c: enum child_state {
>        struct parallel_processes {
>        	void *const data;
>        
>      +@@ run-command.c: static void handle_children_on_signal(int signo)
>      + }
>      +
>      + static void pp_init(struct parallel_processes *pp,
>      +-		    get_next_task_fn get_next_task,
>      +-		    start_failure_fn start_failure,
>      +-		    task_finished_fn task_finished)
>      ++		    const struct run_process_parallel_opts *opts)
>      + {
>      +-	const size_t n = pp->max_processes;
>      ++	const size_t n = opts->processes;
>      ++	get_next_task_fn get_next_task = opts->get_next_task;
>      ++	start_failure_fn start_failure = opts->start_failure;
>      ++	task_finished_fn task_finished = opts->task_finished;
>      +
>      + 	if (!n)
>      + 		BUG("you must provide a non-zero number of processes!");
>       @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp)
>        	return result;
>        }
>        
>      --static void run_processes_parallel_1(const struct run_process_parallel_opts *opts, void *pp_cb)
>      +-void run_processes_parallel(size_t n,
>      +-			    get_next_task_fn get_next_task,
>      +-			    start_failure_fn start_failure,
>      +-			    task_finished_fn task_finished,
>      +-			    void *pp_cb)
>       +void run_processes_parallel(const struct run_process_parallel_opts *opts)
>        {
>      - 	int code;
>      + 	int i, code;
>        	int output_timeout = 100;
>        	int spawn_cap = 4;
>      +-	int ungroup = run_processes_parallel_ungroup;
>        	struct parallel_processes pp = {
>      - 		.max_processes = opts->processes,
>      +-		.max_processes = n,
>       -		.data = pp_cb,
>      ++		.max_processes = opts->processes,
>       +		.data = opts->data,
>        		.buffered_output = STRBUF_INIT,
>      --		.ungroup = run_processes_parallel_ungroup,
>      +-		.ungroup = ungroup,
>       +		.ungroup = opts->ungroup,
>        	};
>      - 	/* options */
>      - 	const char *tr2_category = opts->tr2_category;
>      - 	const char *tr2_label = opts->tr2_label;
>      - 	const int do_trace2 = tr2_category && tr2_label;
>      ++	/* options */
>      ++	const char *tr2_category = opts->tr2_category;
>      ++	const char *tr2_label = opts->tr2_label;
>      ++	const int do_trace2 = tr2_category && tr2_label;
>        
>       -	/* unset for the next API user */
>       -	run_processes_parallel_ungroup = 0;
>      --
>      - 	if (do_trace2)
>      - 		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
>      - 					   "max:%d", opts->processes);
>      -@@ run-command.c: static void run_processes_parallel_1(const struct run_process_parallel_opts *opt
>      - 		trace2_region_leave(tr2_category, tr2_label, NULL);
>      ++	if (do_trace2)
>      ++		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
>      ++					   "max:%d", opts->processes);
>      +
>      +-	pp_init(&pp, get_next_task, start_failure, task_finished);
>      ++	pp_init(&pp, opts);
>      + 	while (1) {
>      + 		for (i = 0;
>      + 		    i < spawn_cap && !pp.shutdown &&
>      +@@ run-command.c: void run_processes_parallel(size_t n,
>      + 		}
>      + 		if (!pp.nr_processes)
>      + 			break;
>      +-		if (ungroup) {
>      ++		if (opts->ungroup) {
>      + 			for (size_t i = 0; i < pp.max_processes; i++)
>      + 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
>      + 		} else {
>      +@@ run-command.c: void run_processes_parallel(size_t n,
>      + 	}
>      +
>      + 	pp_cleanup(&pp);
>      ++
>      ++	if (do_trace2)
>      ++		trace2_region_leave(tr2_category, tr2_label, NULL);
>        }
>        
>      --void run_processes_parallel(size_t processes,
>      --			    get_next_task_fn get_next_task,
>      --			    start_failure_fn start_failure,
>      --			    task_finished_fn task_finished,
>      --			    void *pp_cb)
>      --{
>      --	const struct run_process_parallel_opts opts = {
>      --		.processes = processes,
>      --		.ungroup = run_processes_parallel_ungroup,
>      --
>      --		.get_next_task = get_next_task,
>      --		.start_failure = start_failure,
>      --		.task_finished = task_finished,
>      --	};
>      --
>      --	run_processes_parallel_1(&opts, pp_cb);
>      --}
>      --
>      - void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
>      +-void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
>      ++void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
>        				start_failure_fn start_failure,
>        				task_finished_fn task_finished, void *pp_cb,
>      -@@ run-command.c: void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task
>      - 	const struct run_process_parallel_opts opts = {
>      - 		.tr2_category = tr2_category,
>      - 		.tr2_label = tr2_label,
>      --
>      - 		.processes = processes,
>      --		.ungroup = run_processes_parallel_ungroup,
>      + 				const char *tr2_category, const char *tr2_label)
>      + {
>      +-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
>      ++	const struct run_process_parallel_opts opts = {
>      ++		.tr2_category = tr2_category,
>      ++		.tr2_label = tr2_label,
>      ++		.processes = processes,
>        
>      - 		.get_next_task = get_next_task,
>      - 		.start_failure = start_failure,
>      - 		.task_finished = task_finished,
>      - 	};
>      +-	run_processes_parallel(n, get_next_task, start_failure,
>      +-			       task_finished, pp_cb);
>      ++		.get_next_task = get_next_task,
>      ++		.start_failure = start_failure,
>      ++		.task_finished = task_finished,
>      ++	};
>        
>      --	run_processes_parallel_1(&opts, pp_cb);
>      +-	trace2_region_leave(tr2_category, tr2_label, NULL);
>       +	run_processes_parallel(&opts);
>        }
>        
>        int run_auto_maintenance(int quiet)
>       
>        ## run-command.h ##
>      -@@ run-command.h: struct run_process_parallel_opts
>      - 	 * NULL to omit any special handling.
>      - 	 */
>      - 	task_finished_fn task_finished;
>      +@@ run-command.h: typedef int (*task_finished_fn)(int result,
>      + 				void *pp_task_cb);
>      +
>      + /**
>      +- * Runs up to n processes at the same time. Whenever a process can be
>      +- * started, the callback get_next_task_fn is called to obtain the data
>      ++ * Option used by run_processes_parallel(), { 0 }-initialized means no
>      ++ * options.
>      ++ */
>      ++struct run_process_parallel_opts
>      ++{
>      ++	/**
>      ++	 * tr2_category & tr2_label: sets the trace2 category and label for
>      ++	 * logging. These must either be unset, or both of them must be set.
>      ++	 */
>      ++	const char *tr2_category;
>      ++	const char *tr2_label;
>      ++
>      ++	/**
>      ++	 * processes: see 'processes' in run_processes_parallel() below.
>      ++	 */
>      ++	size_t processes;
>      ++
>      ++	/**
>      ++	 * ungroup: see 'ungroup' in run_processes_parallel() below.
>      ++	 */
>      ++	unsigned int ungroup:1;
>      ++
>      ++	/**
>      ++	 * get_next_task: See get_next_task_fn() above. This must be
>      ++	 * specified.
>      ++	 */
>      ++	get_next_task_fn get_next_task;
>      ++
>      ++	/**
>      ++	 * start_failure: See start_failure_fn() above. This can be
>      ++	 * NULL to omit any special handling.
>      ++	 */
>      ++	start_failure_fn start_failure;
>      ++
>      ++	/**
>      ++	 * task_finished: See task_finished_fn() above. This can be
>      ++	 * NULL to omit any special handling.
>      ++	 */
>      ++	task_finished_fn task_finished;
>       +
>       +	/**
>       +	 * data: user data, will be passed as "pp_cb" to the callback
>       +	 * parameters.
>       +	 */
>       +	void *data;
>      - };
>      -
>      - /**
>      ++};
>      ++
>      ++/**
>       + * Options are passed via the "struct run_process_parallel_opts" above.
>       + *
>      -  * Runs N 'processes' at the same time. Whenever a process can be
>      -- * started, the callback get_next_task_fn is called to obtain the data
>      ++ * Runs N 'processes' at the same time. Whenever a process can be
>       + * started, the callback opts.get_next_task is called to obtain the data
>         * required to start another child process.
>         *
>         * The children started via this function run in parallel. Their output
>      -@@ run-command.h: struct run_process_parallel_opts
>      +  * (both stdout and stderr) is routed to stderr in a manner that output
>      +  * from different tasks does not interleave (but see "ungroup" below).
>      +  *
>      +- * start_failure_fn and task_finished_fn can be NULL to omit any
>      +- * special handling.
>      +- *
>      +  * If the "ungroup" option isn't specified, the API will set the
>      +  * "stdout_to_stderr" parameter in "struct child_process" and provide
>      +  * the callbacks with a "struct strbuf *out" parameter to write output
>      +@@ run-command.h: typedef int (*task_finished_fn)(int result,
>         * NULL "struct strbuf *out" parameter, and are responsible for
>         * emitting their own output, including dealing with any race
>         * conditions due to writing in parallel to stdout and stderr.
>      @@ run-command.h: struct run_process_parallel_opts
>       - * API reads that setting.
>         */
>       -extern int run_processes_parallel_ungroup;
>      --void run_processes_parallel(size_t processes,
>      +-void run_processes_parallel(size_t n,
>       -			    get_next_task_fn,
>       -			    start_failure_fn,
>       -			    task_finished_fn,
>       -			    void *pp_cb);
>      +-void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
>      +-				task_finished_fn, void *pp_cb,
>       +void run_processes_parallel(const struct run_process_parallel_opts *opts);
>      - void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
>      - 				start_failure_fn, task_finished_fn, void *pp_cb,
>      ++void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
>      ++				start_failure_fn, task_finished_fn, void *pp_cb,
>        				const char *tr2_category, const char *tr2_label);
>      +
>      + /**
>       
>        ## t/helper/test-run-command.c ##
>       @@ t/helper/test-run-command.c: static const char * const testsuite_usage[] = {
> 15:  391d1d99d91 =  8:  c19c60b2e95 run-command API: move *_tr2() users to "run_processes_parallel()"
> 16:  acac50cc1a5 =  9:  99a4f4f6b9c run-command.c: make "struct parallel_processes" const if possible
> 17:  fdd64236985 = 10:  bf67e24bcc5 run-command.c: don't copy *_fn to "struct parallel_processes"
> 18:  17f34d81ecd = 11:  06de42adc2e run-command.c: don't copy "ungroup" to "struct parallel_processes"
> 19:  9cbee2dfe76 = 12:  3081dfc49d1 run-command.c: don't copy "data" to "struct parallel_processes"
> 20:  2dabed9e155 ! 13:  b7c10f6a23f run-command.c: use "opts->processes", not "pp->max_processes"
>      @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp,
>        
>       @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opts *opts)
>        	while (1) {
>      - 		for (int i = 0;
>      + 		for (i = 0;
>        		    i < spawn_cap && !pp.shutdown &&
>       -		    pp.nr_processes < pp.max_processes;
>       +		    pp.nr_processes < opts->processes;
> 21:  c1a286a8ebb ! 14:  4856d6a4674 run-command.c: pass "opts" further down, and use "opts->processes"
>      @@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
>       +			     const struct run_process_parallel_opts *opts,
>       +			     int output_timeout)
>        {
>      --	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
>      -+	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
>      + 	int i;
>      +
>      +-	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
>      ++	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
>        		if (errno == EINTR)
>        			continue;
>       -		pp_cleanup(pp);
> 22:  541f41566e7 ! 15:  39a20be0cbb run-command.c: remove "pp->max_processes", add "const" to signal() handler
>      @@ Metadata
>       Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## Commit message ##
>      -    run-command.c: remove "pp->max_processes", add "const" to signal() handler
>      +    run-command.c: remove "max_processes", add "const" to signal() handler
>       
>           As with the *_fn members removed in a preceding commit, let's not copy
>           the "processes" member of the "struct run_process_parallel_opts" over
>      @@ run-command.c: static void pp_init(struct parallel_processes *pp,
>       -	pp_for_signal = pp;
>       +	pp_sig->pp = pp;
>       +	pp_sig->opts = opts;
>      ++	pp_for_signal = pp_sig;
>        	sigchain_push_common(handle_children_on_signal);
>        }
>        
>       @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opts *opts)
>      - 	int code;
>      + 	int i, code;
>        	int output_timeout = 100;
>        	int spawn_cap = 4;
>       +	struct parallel_processes_for_signal pp_sig;
>      @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opt
>       -	pp_init(&pp, opts);
>       +	pp_init(&pp, opts, &pp_sig);
>        	while (1) {
>      - 		for (int i = 0;
>      + 		for (i = 0;
>        		    i < spawn_cap && !pp.shutdown &&
>       @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opts *opts)
>        				continue;
