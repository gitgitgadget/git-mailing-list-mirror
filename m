Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417AC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 08:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJLI1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJLI1H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 04:27:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04242935A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:27:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b12so1345566edd.6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dwkQB2oh4UzJt+II8au3ikUd4uosmHVn+EawwsbEBys=;
        b=BrEdK5rRYF6skcLO2vJNTuO4f+p2AW9bYv2bbma9q5VTa2a06vD/Skz5YYOX1NlykY
         Vci1ycYvBvdAoAemxKWyQSY4kzaFK5A8gPOBv4b6xED/Q1fn+35zz98dwsfiWhfyQceC
         tN0bfWcponhlFn6u38lMBEvUVg98+u1lAIT19QCY/TyHy/i1LUi6wMhFc4fsUVxiL7mB
         cg4Pgi5GxR31+jRbfblFhwzYYGn9qqB+FWjPImyxP4VWTGukqKIvwAXEeB5PohFNcaJi
         9uhnN6K5egw5N62TI9CBkV/KLLuRnTiXViDwmykscLRRm3ytu2+QKfYdNJpY8IwoaDFF
         zu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwkQB2oh4UzJt+II8au3ikUd4uosmHVn+EawwsbEBys=;
        b=d0o2fkNReTofpk51YJDn8xBM9oZhfhQaTHl+j4NGe7OcwEMlXZLGDf5RV1dwPu9OwP
         qFw/l8rheDqsbvudaDimALK1RkxhXlVipcm1z9DqNEArZ4HfA5qVK5Q23LUmn3eOp2FV
         ojUUrb4R0JefVFg8JU6eNnrv58a64/AbGNMrLcd2oAXZ/mIEFYFJC4p10htYEA8gbXM0
         BW5PufA+XEYQWsAhu8oFjWp6osUwKFMiQOcug0F6BvVJTlwlHKhsXlzJHbQZxKEEb1U2
         waeUsC3sEUjmH+IbnO8933IJ55Fqk4ETLZUsR09WU7Nq0El1dLajXi6G7KlDXTwFb0cn
         hQng==
X-Gm-Message-State: ACrzQf1VY/X5WgubKC+92q+VJ+h41DcpCDIQU0xyMc+732EhrWYw7RTI
        g6unqvAnEikn/UXMU9OZJYiniZJJMUMo7Q==
X-Google-Smtp-Source: AMsMyM7bfLyIq8nsxbEMYwrBItx84ZLyKjXJsLvVcg28xMpbnJm8Zvz7HOmHcmxrY4cqTJat8vWB1A==
X-Received: by 2002:a05:6402:2b8b:b0:43a:5475:f1ae with SMTP id fj11-20020a0564022b8b00b0043a5475f1aemr26074102edb.363.1665563223849;
        Wed, 12 Oct 2022 01:27:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906924700b0078b551d2fa3sm842817ejx.103.2022.10.12.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:27:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiX4w-004Eg8-0G;
        Wed, 12 Oct 2022 10:27:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/4] run-command: add pipe_output_fn to
 run_processes_parallel_opts
Date:   Wed, 12 Oct 2022 09:58:32 +0200
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
 <20221011232604.839941-2-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221011232604.839941-2-calvinwan@google.com>
Message-ID: <221012.864jw9o3ah.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Calvin Wan wrote:

(re-arranging the diff a bit for discussion)

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 46bac2bb70..d3c3df7960 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -52,6 +52,18 @@ static int no_job(struct child_process *cp,
>  	return 0;
>  }
>  
> +static void pipe_output(struct strbuf *out,
> +				void *pp_cb,
> +				void *pp_task_cb)
> +{
> +	fprintf(stderr, "%s", out->buf);
> +	/*
> +	 * Resetting output to show that piped output would print the
> +	 * same as other tests without the pipe_output() function set
> +	 */
> +	strbuf_reset(out);
> +}
> +

This is still unaddressed from the last round:
https://lore.kernel.org/git/220927.86edvxytla.gmgdl@evledraar.gmail.com/

Or well, it changed a bit, but the "reset" is still there.

Whatever you're aiming for here, this is apparently doing nothing,
because if I comment out the strbuf_reset() then all your tests pass,
which...

>  	int i = pp->output_owner;
>  
>  	if (pp->children[i].state == GIT_CP_WORKING &&
>  	    pp->children[i].err.len) {
> +		if (opts->pipe_output)
> +			opts->pipe_output(&pp->children[i].err, pp->data,
> +						pp->children[i].data);
>  		strbuf_write(&pp->children[i].err, stderr);
>  		strbuf_reset(&pp->children[i].err);
>  	}

...we can see from here...

> @@ -1716,6 +1720,10 @@ static int pp_collect_finished(struct parallel_processes *pp,
>  
>  		code = finish_command(&pp->children[i].process);
>  
> +		if (opts->pipe_output)
> +			opts->pipe_output(&pp->children[i].err, pp->data,
> +						pp->children[i].data);
> +
>  		if (opts->task_finished)
>  			code = opts->task_finished(code, opts->ungroup ? NULL :
>  						   &pp->children[i].err, pp->data,

...and in particular here, where the "err" is subsequently passed to
"task_finished" *would* actually have an impact, but (again,
re-arranging he diff a bit) ...

> @@ -439,6 +451,12 @@ int cmd__run_command(int argc, const char **argv)
>  		opts.ungroup = 1;
>  	}
>  
> +	if (!strcmp(argv[1], "--pipe-output")) {
> +		argv += 1;
> +		argc -= 1;
> +		opts.pipe_output = pipe_output;
> +	}
> +
>  	jobs = atoi(argv[2]);
>  	strvec_clear(&proc.args);
>  	strvec_pushv(&proc.args, (const char **)argv + 3);

...here to test that we'd need our tests to combine "pipe_output" with
"task_finished".

Which we should do in either case, e.g. if you define both and append to
"err" in what order do we call them, and does "err" accumulate? (I think
it should), in any case...

> +	/**
> +	 * pipe_output: See pipe_output_fn() above. This should be
> +	 * NULL unless process specific output is needed
> +	 */
> +	pipe_output_fn pipe_output;


...since we're on the topic we really should document what the behavior
is. My understanding of this API has been that the "err" is not "const"
because the callback is supposed to *append errors*, and there's an
implicit contract to do nothing else than that. But looking at your new
API docs:

> + * This callback is periodically called while child processes are
> + * running and also when a child process finishes.

Whatever you think this should be doing isn't documented precisely,
i.e. is it called before/after some other callbacks, should the user
rely on that at all, and...

> + * "struct strbuf *out" contains the output collected from pp_task_cb
> + * since the last call of this function.

...this just seems wrong. We don't collect outptu "from pp_task_cb", do
you mean to say something, well, I was about to put words in your mouth,
but I honestly don't know what you expect, so ...

*I'd* this to be documented as something like (which every other
 callback does):

	See run_processes_parallel() below for a discussion of the "struct
	strbuf *out" parameter.

Now *those* docs could be improved a bit, but how we handle "err/out"
really needs to be documented holistically, as it's shared betwene
callbacks.

> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel,
> + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> + *
> + * This function is incompatible with "ungroup"

I'll re-roll the base series, which has a good place to add a BUG() if
incompatible options are combined, which would be good to add, i.e.:

	if (opts->pipe_output && opts->ungroup)
		BUG(...);

> +for opt in '' '--pipe-output'
> +do
> +	test_expect_success "run_command runs in parallel with more jobs available than tasks $opt" '
> +		test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +		test_must_be_empty out &&
> +		test_cmp expect err
> +	'
> +done

I take an earlier comment back, you do have tests that would change if
that strbuf_reset() was removed, you're just not running them. You
forgot to put an "$opt" into the "test-tool" invocations:
	
	diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
	index feabb3717b0..19a674480cd 100755
	--- a/t/t0061-run-command.sh
	+++ b/t/t0061-run-command.sh
	@@ -162,7 +162,7 @@ test_expect_success 'run_command runs ungrouped in parallel with as many jobs as
	 for opt in '' '--pipe-output'
	 do
	 	test_expect_success "run_command runs in parallel with more tasks than jobs available $opt" '
	-		test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
	+		test-tool run-command $opt run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
	 		test_must_be_empty out &&
	 		test_cmp expect err
	 	'
	@@ -186,7 +186,7 @@ EOF
	 for opt in '' '--pipe-output'
	 do
	 	test_expect_success "run_command is asked to abort gracefully $opt" '
	-		test-tool run-command run-command-abort 3 false >out 2>err &&
	+		test-tool run-command $opt run-command-abort 3 false >out 2>err &&
	 		test_must_be_empty out &&
	 		test_cmp expect err
	 	'
	@@ -205,7 +205,7 @@ EOF
	 for opt in '' '--pipe-output'
	 do
	 	test_expect_success "run_command outputs $opt" '
	-		test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
	+		test-tool run-command $opt run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
	 		test_must_be_empty out &&
	 		test_cmp expect err
	 	'
	

With that all except 1 of your tests pass, now if I remove
strbuf_reset() and tweak the test so we can see what output comes from
what, then:
	
	diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
	index ce246dfa4bc..690467e75c0 100644
	--- a/t/helper/test-run-command.c
	+++ b/t/helper/test-run-command.c
	@@ -56,12 +56,11 @@ static void pipe_output(struct strbuf *out,
	 				void *pp_cb,
	 				void *pp_task_cb)
	 {
	-	fprintf(stderr, "%s", out->buf);
	-	/*
	-	 * Resetting output to show that piped output would print the
	-	 * same as other tests without the pipe_output() function set
	-	 */
	-	strbuf_reset(out);
	+	struct strbuf sb = STRBUF_INIT;
	+
	+	strbuf_add_lines(&sb, "pipe_output: ", out->buf, out->len);
	+	fputs(sb.buf, stderr);
	+	strbuf_release(&sb);
	 }
	 
	 static int task_finished(int result,

The first test we fail (but with the reset we don't fail this one) is:
	
	+ diff -u expect err
	--- expect      2022-10-12 08:22:58.032264828 +0000
	+++ err 2022-10-12 08:22:58.068264515 +0000
	@@ -1,12 +1,24 @@
	+pipe_output: preloaded output of a child
	+pipe_output: Hello
	+pipe_output: World
	 preloaded output of a child
	 Hello
	 World
	+pipe_output: preloaded output of a child
	+pipe_output: Hello
	+pipe_output: World
	+pipe_output: preloaded output of a child
	+pipe_output: Hello
	+pipe_output: World
	 preloaded output of a child
	 Hello
	 World
	 preloaded output of a child
	 Hello
	 World
	+pipe_output: preloaded output of a child
	+pipe_output: Hello
	+pipe_output: World
	 preloaded output of a child
	 Hello
	 World

So, the apparent reason for the strbuf_reset() is that at some point in
the past you passed $out, but wanted to "reset" it so that you could
re-use the existing test_cmp.

But that's just wrong, because we'd be sweeping under the rug exactly
what we want to be testing here. Instead of hiding this you should be
test_cmp-ing the full thing.
