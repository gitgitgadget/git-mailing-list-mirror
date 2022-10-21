Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714EC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJUDbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJUDbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:31:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EE1E8B89
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:31:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy4so4106706ejc.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2sghd8lgJHI6HB9t/H+GXmmiK6DaafsVoxBd57/jZE=;
        b=NN1Hb2+KubgENoSvBYBxde8/Z+OHfzroWWrgEBGMnvAt8cENaXro5GXdtxVYpeEDLR
         jTAT8SYSL9f3g2QanPOaBTYvdyBTy7+CNmtEzUy+TpOog417e5sGDCOEDDYNCJyQhGXW
         ZiBKqwa2oolEEOaN8Ux1f01vGtXNhTawX8inuUNbb6MBNAEpFpr+a+duND/JKlhQa8X+
         UtGU9ORQtZMv2neWeSYFfb8H6nCm1CS6PdCeLSXTDDaK3B0RwE+ig7IE0SvKyJVBVtdX
         6B+TxAp0wvwrFlksNiOLETCSEy6EkdQpJQ2Wo8roUHhSIyaJWrARySPffDR4jV8GQyd1
         jz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2sghd8lgJHI6HB9t/H+GXmmiK6DaafsVoxBd57/jZE=;
        b=Pfv1Yg5lV1pD8+rJo9wj2xHbOZ3YyD59dIQaStvcTi9wWido0ohh9G87+4VJZZ6r5J
         60QYXSPwNUOWrnK4AgwEPwacP1fuAQ8B2I2jXeIu2IsRquIcLglVqtWqENcSCAo0COLY
         LySx4y/ndJyjxxpAZ7FGUbm5X69p4Q5lNyf83NTE4Af5znUIfLLzEWmYDlUaUYKst+3Y
         ve5XyN6WicOPBidyeHs9PHjAMiJgUU/864MaEKH7rP+obpq1AjD1VzX6rp4caPc72pw7
         pdKHlUdPOG67XDko2ONHy4n7PT8lT7KaEUkih6vAOq8NYz27l056LUCLdTSp/KzjR+/d
         wv1g==
X-Gm-Message-State: ACrzQf0RnkUFcR6VbAqfSVm5aFrEUDxm0b0DKgx0d45oqK4GFqAPe7rf
        NfPNXMeTkq53nnkhXofCKay85bu6sJ/tTQ==
X-Google-Smtp-Source: AMsMyM6FM+/1jTMdKOAI+AjlxgY33z+9l3AU5WwUtJpISdpg4AGytW9ngu5SeWekOS6uWhkG1vfrew==
X-Received: by 2002:a17:907:6d27:b0:78d:46f6:c59e with SMTP id sa39-20020a1709076d2700b0078d46f6c59emr13469784ejc.30.1666323089203;
        Thu, 20 Oct 2022 20:31:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sd42-20020a1709076e2a00b0076ff600bf2csm11037041ejc.63.2022.10.20.20.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:31:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olikp-006lkv-2G;
        Fri, 21 Oct 2022 05:31:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/6] run-command: add pipe_output_fn to
 run_processes_parallel_opts
Date:   Fri, 21 Oct 2022 05:11:43 +0200
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
 <20221020232532.1128326-2-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221020232532.1128326-2-calvinwan@google.com>
Message-ID: <221021.86h6zxg8ds.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 20 2022, Calvin Wan wrote:

> Add pipe_output_fn as an optionally set function in
> run_process_parallel_opts. If set, output from each child process is
> first separately stored in 'out' and then piped to the callback
> function when the child process finishes to allow for separate parsing.

The "when[...]finish[ed]" here seems a bit odd to me. Why isn't the API
to just stream this to callbacks as it comes in.

Then if a caller only cares about the output at the very end they can
manage that state between their streaming callbacks and "finish"
callback, i.e. buffer it & flush it themselves.

> diff --git a/run-command.c b/run-command.c
> index c772acd743..03787bc7f5 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1503,6 +1503,7 @@ struct parallel_processes {
>  		enum child_state state;
>  		struct child_process process;
>  		struct strbuf err;
> +		struct strbuf out;
>  		void *data;
>  	} *children;
>  	/*
> @@ -1560,6 +1561,9 @@ static void pp_init(struct parallel_processes *pp,
>  
>  	if (!opts->get_next_task)
>  		BUG("you need to specify a get_next_task function");
> +	
> +	if (opts->pipe_output && opts->ungroup)
> +		BUG("pipe_output and ungroup are incompatible with each other");
>  
>  	CALLOC_ARRAY(pp->children, n);
>  	if (!opts->ungroup)
> @@ -1567,6 +1571,8 @@ static void pp_init(struct parallel_processes *pp,
>  
>  	for (size_t i = 0; i < n; i++) {
>  		strbuf_init(&pp->children[i].err, 0);
> +		if (opts->pipe_output)
> +			strbuf_init(&pp->children[i].out, 0);

Even if we're not using this, let's init it for simplicity. We don't use
the "err" with ungroup and we're init-ing that, and...

>  		child_process_init(&pp->children[i].process);
>  		if (pp->pfd) {
>  			pp->pfd[i].events = POLLIN | POLLHUP;
> @@ -1586,6 +1592,7 @@ static void pp_cleanup(struct parallel_processes *pp,
>  	trace_printf("run_processes_parallel: done");
>  	for (size_t i = 0; i < opts->processes; i++) {
>  		strbuf_release(&pp->children[i].err);
> +		strbuf_release(&pp->children[i].out);

...here you're strbuf_relese()-ing a string that was never init'd, it's
not segfaulting because we check sb->alloc, and since we calloc'd this
whole thing it'll be 0, but let's just init it so it's a proper strbuf
(with slopbuf). It's cheap.

> +/**
> + * This callback is called on every child process that finished processing.
> + * 
> + * "struct strbuf *process_out" contains the output from the finished child
> + * process.
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel,
> + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> + *
> + * This function is incompatible with "ungroup"
> + */
> +typedef void (*pipe_output_fn)(struct strbuf *process_out,
> +			       void *pp_cb,
> +			       void *pp_task_cb);
> +
>  /**
>   * This callback is called on every child process that finished processing.
>   *
> @@ -493,6 +508,12 @@ struct run_process_parallel_opts
>  	 */
>  	start_failure_fn start_failure;
>  
> +	/**
> +	 * pipe_output: See pipe_output_fn() above. This should be
> +	 * NULL unless process specific output is needed
> +	 */
> +	pipe_output_fn pipe_output;
> +
>  	/**
>  	 * task_finished: See task_finished_fn() above. This can be
>  	 * NULL to omit any special handling.
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3ecb830f4a..e9b41419a0 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -52,6 +52,13 @@ static int no_job(struct child_process *cp,
>  	return 0;
>  }
>  
> +static void pipe_output(struct strbuf *process_out,
> +			void *pp_cb,
> +			void *pp_task_cb)
> +{
> +	fprintf(stderr, "%s", process_out->buf);

maybe print this with split lines prefixed with something so wour tests
can see that something actually happened here, & test-cmp it so we can
see what went where, as opposed to...

> +test_expect_success 'run_command runs in parallel with more jobs available than tasks --pipe-output' '
> +	test-tool run-command --pipe-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
> +	test_must_be_empty out &&
> +	test_line_count = 20 err
> +'

Just checking the number of lines, which seems to leave a lot of leeway
for the output being mixed up in all sorts of ways & the test to still
pass..

(ditto below)
