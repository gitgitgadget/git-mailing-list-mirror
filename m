Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D57ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 08:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIWIB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIWIBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 04:01:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E4118B29
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:01:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so26238204ejn.3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=Df7xTc2PrB3BcR4kGGQ4b7MKRm13pppECxfKCeHW5XY=;
        b=KlsquQRE/L7vJZ2l2xDW8IUMPROEiL78BQE3HSAijkzju4eZIYjkuxqk/5Bf125cAR
         bf8SHDtYPEpd6qpRBln2L34ZqBTVETh8KQV0VQIRXYaThRN7oFguvs6SvTwpLnTO1uyF
         pvw/8fqYImNAxyn3EPUMbZDril/aqBq6doccAUUzQPKA7vbQtcXbAqkLi9x93a5+oqQJ
         et2M+J8FraTSoDugyHQJn6SQ84+IvOAw1qtL7DUUCUyDLzeA7UHwnKXsc7a0zMvHpar9
         EyTUZ3W1dp6HjFSPyiS1680/iPkM6PZiOzaQDaKEmhqd9xBmd4zcbKvbcVJPPCttuFIt
         RaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Df7xTc2PrB3BcR4kGGQ4b7MKRm13pppECxfKCeHW5XY=;
        b=fQzS5yyLMQIH8LhDsBofMsV1BEV0IABo9QwJtQ0+VDCvZnLlGM+7mJ+MCYLONO6Bc2
         kWsBdMiTOi6I7r2D0UpD502RG6Ty/Ly6oOz6CKEJnsJAJlZKvajF8QxqR1DIvcnZSen4
         frd2psHRDyAOsknMbFcBppO6g63gwSTxJJ5rsYW/3nO0HcR8KxcApk9XZoHsTnTIzJao
         g/LJKua4Y2HeoF9z2v5PZMSmYXjf4ZahGIpGKPW1JrJFVNZFOh3xtSOg+UiAogAQU7R+
         sjfLTMfSeV2D7KQlCvaB6+t6TjCMobXirvnWEbllue6FjGkjLTgzm1KHjIfq02CjFCz5
         fQlQ==
X-Gm-Message-State: ACrzQf3m3AIPB9CH3tjjsS8OgcJ/Nj/luP521rH3L/Md8TrAkiVKZ0tH
        AOLENJJphmCcj+qgMPMCccDNCasaMJQ=
X-Google-Smtp-Source: AMsMyM797qUy9t7PmdN5deiiO6LLOBgqAn4uXOcVxpx52fKexaFs1AZVf7MZhlpyegdzI0L+x9tFKg==
X-Received: by 2002:a17:907:96a0:b0:782:9633:2751 with SMTP id hd32-20020a17090796a000b0078296332751mr2051509ejc.359.1663920104411;
        Fri, 23 Sep 2022 01:01:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090615cb00b0078194737761sm3613105ejd.124.2022.09.23.01.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:01:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1obdcz-003FhA-1z;
        Fri, 23 Sep 2022 10:01:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
Date:   Fri, 23 Sep 2022 09:52:58 +0200
References: <20220922232947.631309-1-calvinwan@google.com>
 <20220922232947.631309-2-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220922232947.631309-2-calvinwan@google.com>
Message-ID: <220923.86sfki4ize.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 22 2022, Calvin Wan wrote:

> diff --git a/run-command.c b/run-command.c
> index 14f17830f5..893bc1d294 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1474,6 +1474,7 @@ enum child_state {
>  };
>  
>  int run_processes_parallel_ungroup;
> +int run_processes_parallel_pipe_output;
>  struct parallel_processes {
>  	void *data;
>  
> @@ -1770,10 +1771,12 @@ int run_processes_parallel(int n,
>  	int output_timeout = 100;
>  	int spawn_cap = 4;
>  	int ungroup = run_processes_parallel_ungroup;
> +	int pipe_output = run_processes_parallel_pipe_output;
>  	struct parallel_processes pp;
>  
>  	/* unset for the next API user */
>  	run_processes_parallel_ungroup = 0;
> +	run_processes_parallel_pipe_output = 0;
>  
>  	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
>  		ungroup);

I guess we could live with this, but this passing a function argument as
a global variable interface is something that came out of a topic to fix
a release regression:
https://lore.kernel.org/git/cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com/

An earlier version of that series simply changed the API to pass an
"opts" struct instead:
https://lore.kernel.org/git/patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com/

I really should have submitted those post-release cleanup patches
already, and I'm not sure whether the right thing at this point is to
take this & do the cleanup for "ungroup" *and* this new argument later.

But maybe you're interested in cherry-picking & adjusting the relevant
part of that series for this one? I.e. we're not in some post-release
regression hurry, so rather than extending the use of this odd interface
we could (and maybe should) just fix how we're doing it first.

On the implementation:

> + * If the "pipe_output" option is specified, the output will be piped
> + * to task_finished_fn in the "struct strbuf *out" variable. The output
> + * will still be printed unless the callback resets the strbuf. The
> + * "pipe_output" option can be enabled by setting the global
> + * "run_processes_parallel_pipe_output" to "1" before invoking
> + * run_processes_parallel(), it will be set back to "0" as soon as the
> + * API reads that setting.

...okey, but...

> +static int task_finished_pipe_output(int result,
> +			 struct strbuf *err,
> +			 void *pp_cb,
> +			 void *pp_task_cb)
> +{
> +	if (err && pipe_output) {
> +		fprintf(stderr, "%s", err->buf);
> +		strbuf_reset(err);

...my memory's hazy, and I haven't re-logged in any detail, but is it
really the API interface here that the "output" callback function is
responsible for resetting the strbuf that the API gives to it?

That seems backwards to me, and e.g. a look at "start_failure" shows
that we strbuf_reset() the "err".

What's the point of doing it in the API consumer? If it doesn't do it
we'll presumably keep accumulating output. Is there a use-case for that?

Or perhaps it's not needed & this is really just misleading boilerplate?

> @@ -140,6 +140,11 @@ test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
>  	test_line_count = 4 err
>  '
>  
> +test_expect_success 'run_command runs pipe_output in parallel with more jobs available than tasks' '
> +	test-tool run-command --pipe-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
> +	test_cmp expect actual
> +'
> +

Like the global argument, the copy/pasting for "ungroup" was mostly a
matter of expediency.

But at least in that case we have a different assertion (test_cmp
v.s. test_line_count).

But here this test case seems to be exactly the same as for the
"vanilla" version.

So can't we make this some:

	for opt in '' '--pipe-output'
	do
		test_expect_success ...
	done

?
