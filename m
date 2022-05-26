Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B366C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbiEZRXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiEZRXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:23:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88783689A2
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:23:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2243844pjq.2
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6pLu7A7zGrzrzRswxKQzBlFYKHR2FwPsBmaejkG/uf4=;
        b=b3EwDmdG4YsGTlJoaY+TuTmutubXDQfxcW3xc9u5XWzhc/htzGk3Ryc36vyt0wXtGU
         pPSu6FJBtZwxwaA+ih97Cn8R9TWTpkFaPqveoL3AjvC1RtDgGZ3LgOHfvw42yfJHbvhA
         TytV7bzSqDuFAuZKTi0/dcLqpgloBP/PI9wLI3LClAQZfb1RJL9g/ttVMLyiooh1CHMr
         pyf1+R9jqAd+zHg0epipYp1ZQtnpVZPT73E6idPY8ewVPqET2pyJGULSxuNT4ErAIqFe
         AdKN91Xah1etVloX291OdcZ7reg3J2t4iSfQ/vDosYCbanF4OQ0G6ALm5tGJ8rfjfCr3
         vXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6pLu7A7zGrzrzRswxKQzBlFYKHR2FwPsBmaejkG/uf4=;
        b=MPvpRGeCuNrtZgXZjWRnuw2OlbGJrNcvEFv01SW8xyDD4E0rRek2Q/UL9wYSFH+m8E
         Pr/s8ZF2e62czuy1dtAVhbyWt6qmKhjdYBZw9Y4ezIXt1UkAU00ix/8BJYWtHJo51vPq
         0XdmfVJlurIXLo9Y8622mmroTpbCauQFAo3Z8pr7t9DDLfkWKYf/GLXwN6vclAt+RgJh
         U9GxCBs8yamcy3ftNZ2ID0pY3ugkKGhJ1ai++5G2sVAnUSmAZxSgF0l04crYaOdgLKHA
         LzAb2oEjg2Q3NN/Bbb1kbuNJmLDlwbeBH/9ACc2CXW8XokpcX2uYSMD++yfBOVpcOGxh
         TSVg==
X-Gm-Message-State: AOAM531FlG0S+U3kx7onDou735mXuoslv83kOZeY+r+PnK6QHPol9SXU
        76lf/njge8gdTbuIYS7cRttTxQ==
X-Google-Smtp-Source: ABdhPJx8NhVPe8wS1yG1LEzWf7/fYC6/BT9mEQIR7SOk9A49XVx1uzaAD9HN/DjNrlvBvCxlF3Gg9Q==
X-Received: by 2002:a17:90b:224a:b0:1e0:f91:3a3f with SMTP id hk10-20020a17090b224a00b001e00f913a3fmr3714187pjb.62.1653585799769;
        Thu, 26 May 2022 10:23:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:dcef:8d9b:c712:c6ca])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b0015e8d4eb244sm1815323plb.142.2022.05.26.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:23:19 -0700 (PDT)
Date:   Thu, 26 May 2022 10:23:14 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 8/8] hook API: fix v2.36.0 regression: hooks should be
 connected to a TTY
Message-ID: <Yo+3gmtbaARan23V@google.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 18, 2022 at 10:05:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Fix a regression reported[1] in f443246b9f2 (commit: convert
> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
> using the run_process_parallel() API in the earlier 96e7225b310 (hook:
> add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
> stdout, and thus lose the connection to the TTY in the case of
> e.g. the "pre-commit" hook.
> 
> As a preceding commit notes GNU parallel's similar --ungroup option
> also has it emit output faster. While we're unlikely to have hooks
> that emit truly massive amounts of output (or where the performance
> thereof matters) it's still informative to measure the overhead. In a
> similar "seq" test we're now ~30% faster:
> 
> 	$ cat .git/hooks/seq-hook; git hyperfine -L rev origin/master,HEAD~0 -s 'make CFLAGS=-O3' './git hook run seq-hook'
> 	#!/bin/sh
> 
> 	seq 100000000
> 	Benchmark 1: ./git hook run seq-hook' in 'origin/master
> 	  Time (mean ± σ):     787.1 ms ±  13.6 ms    [User: 701.6 ms, System: 534.4 ms]
> 	  Range (min … max):   773.2 ms … 806.3 ms    10 runs
> 
> 	Benchmark 2: ./git hook run seq-hook' in 'HEAD~0
> 	  Time (mean ± σ):     603.4 ms ±   1.6 ms    [User: 573.1 ms, System: 30.3 ms]
> 	  Range (min … max):   601.0 ms … 606.2 ms    10 runs
> 
> 	Summary
> 	  './git hook run seq-hook' in 'HEAD~0' ran
> 	    1.30 ± 0.02 times faster than './git hook run seq-hook' in 'origin/master'
> 
> In the preceding commit we removed the "stdout_to_stderr=1" assignment
> as being redundant. This change brings it back as with ".ungroup=1"
> the run_process_parallel() function doesn't provide them for us
> implicitly.
> 
> As an aside omitting the stdout_to_stderr=1 here would have all tests
> pass, except those that test "git hook run" itself in
> t1800-hook.sh. But our tests passing is the result of another test
> blind spot, as was the case with the regression being fixed here. The
> "stdout_to_stderr=1" for hooks is long-standing behavior, see
> e.g. 1d9e8b56fe3 (Split back out update_hook handling in receive-pack,
> 2007-03-10) and other follow-up commits (running "git log" with
> "--reverse -p -Gstdout_to_stderr" is a good start).
> 
> 1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/
> 
> Reported-by: Anthony Sottile <asottile@umich.edu>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  hook.c          |  5 +++++
>  t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/hook.c b/hook.c
> index dc498ef5c39..5f31b60384a 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -54,6 +54,7 @@ static int pick_next_hook(struct child_process *cp,
>  		return 0;
>  
>  	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
> +	cp->stdout_to_stderr = 1; /* because of .ungroup = 1 */
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
>  
> @@ -126,6 +127,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
>  		.tr2_label = hook_name,
>  
>  		.jobs = jobs,
> +		.ungroup = jobs == 1,

I mentioned it on patch 5, but I actually do not see a reason why we
shouldn't do this logic in run_processes_parallel instead of just for
the hooks. If someone can mention a reason we want to buffer child
processes we're running in series I'm all ears, of course.

>  
>  		.get_next_task = pick_next_hook,
>  		.start_failure = notify_start_failure,
> @@ -136,6 +138,9 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
>  	if (!options)
>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
>  
> +	if (jobs != 1 || !run_opts.ungroup)
> +		BUG("TODO: think about & document order & interleaving of parallel hook output");

Doesn't this mean we're actually disallowing parallel hooks entirely? I
don't think that's necessary or desired. I guess right now when the
config isn't used, there's not really a way to provide parallel hooks,
but I also think this will cause unnecessary conflicts for Google who is
carrying config hooks downstream. I know that's not such a great reason.
But it seems weird to be explicitly using the parallel processing
framework, but then say, "oh, but we actually don't want to run in
parallel, that's a BUG()".

> +
>  	if (options->invoked_hook)
>  		*options->invoked_hook = 0;
>  
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 1e4adc3d53e..f22754deccc 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -4,6 +4,7 @@ test_description='git-hook command'
>  
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
>  
>  test_expect_success 'git hook usage' '
>  	test_expect_code 129 git hook &&
> @@ -120,4 +121,40 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
>  	test_cmp expect actual
>  '
>  
> +test_hook_tty() {
> +	local fd="$1" &&
> +
> +	cat >expect &&
> +
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	test_hook -C repo pre-commit <<-EOF &&
> +	{
> +		test -t 1 && echo >&$fd STDOUT TTY || echo >&$fd STDOUT NO TTY &&
> +		test -t 2 && echo >&$fd STDERR TTY || echo >&$fd STDERR NO TTY
> +	} $fd>actual
> +	EOF
> +
> +	test_commit -C repo A &&
> +	test_commit -C repo B &&
> +	git -C repo reset --soft HEAD^ &&
> +	test_terminal git -C repo commit -m"B.new" &&
> +	test_cmp expect repo/actual
> +}
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDOUT redirect' '
> +	test_hook_tty 1 <<-\EOF
> +	STDOUT NO TTY
> +	STDERR TTY
> +	EOF
> +'
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDERR redirect' '
> +	test_hook_tty 2 <<-\EOF
> +	STDOUT TTY
> +	STDERR NO TTY
> +	EOF
> +'
> +
>  test_done
> -- 
> 2.36.1.952.g0ae626f6cd7
> 
