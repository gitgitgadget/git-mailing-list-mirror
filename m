Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E248C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0406720709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP6ygzjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgEOK7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgEOK7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:59:36 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B9C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:59:36 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id c187so348404ooc.2
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1DyiJnZqG7pkJLsVNu3UqwpUf1tAnBmZD+g6vFuzJ8=;
        b=hP6ygzjm5RbE9q8q6q4tTdVtgHYKZIfYQDJIEKcm2XRPsmjxsxwPHrxDx3J9WZMGoT
         jKlI0ACoN0JvoIi5xTDPaJ8syFVpwnIYHdMH3IFFJ3l7+0Xq7FP5VX9KaJnGj83Zgph5
         Y69BPRUhempSFM0YCk9t9ixLtyFQUmvdhObxdr4iS9CSAvzLdEU84ntmllq+e2CZcVBM
         RVElQ7rOrEEWRGGVi/f3YPJziMFhJTBmkL9p0IE0EhUF2c2bRLcAv+WoGNgOnPgi2kg+
         IpbYENBp8vWXUqzjrKqO5XMBxlV1DvNkDgiV2k5p8C9j024jh90wWf6YyOb8YDA67qY6
         BP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1DyiJnZqG7pkJLsVNu3UqwpUf1tAnBmZD+g6vFuzJ8=;
        b=nnPLLXdVebcNYZJ3u3n2m514cO7l/Ivy6wcfh/IkeG85MMFr58KY1TeqHITWAPSVNz
         bPOr+6Ptd3p6TL9komrTX+luNYcxAwleIv3hkQxmq6SLlarDWCCq/FjqXJdcoNUd2JoY
         TodIB/lvjHAA9eJj1GptWvCZWTDskNuXPYPhzd6yg9+4RSnpOy8T6o5pPHINmumLNWkk
         vfVCo1+8CepFm9lgIOhHR8mS7We96/i6EHQcqzBHnKwew6KcAyKjvB6V9HQcV1bEkpxa
         63Gp+k0VDYHqNx2fVxHZs6tAlEJYPlUhPtPQ+i2rOSbTJ2REIePf4CeK66S3B471hw+D
         H0mw==
X-Gm-Message-State: AOAM533+dP8lp60L3iSvKMW2eN34RAdDZy0P8nAH0+MrhB7KECkB06Hk
        g7iNHegsUpJ/+UPuQ3Orvxk=
X-Google-Smtp-Source: ABdhPJwF2gEDnrlbspzSaY9zWha+pCS4+41hjinsFt43j0R5HotTK7k216mDnSxCcVrmKa25XLnnjg==
X-Received: by 2002:a4a:9c09:: with SMTP id y9mr507929ooj.43.1589540375506;
        Fri, 15 May 2020 03:59:35 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i7sm473673otr.80.2020.05.15.03.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:34 -0700 (PDT)
Subject: Re: [PATCH] trace2: log progress time and throughput
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
References: <20200512214420.36329-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.com>
Date:   Fri, 15 May 2020 06:59:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200512214420.36329-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/12/2020 5:44 PM, Emily Shaffer wrote:
> Rather than teaching only one operation, like 'git fetch', how to write
> down throughput to traces, we can learn about a wide range of user
> operations that may seem slow by adding tooling to the progress library
> itself. Operations which display progress are likely to be slow-running
> and the kind of thing we want to monitor for performance anyways. By
> showing object counts and data transfer size, we should be able to
> make some derived measurements to ensure operations are scaling the way
> we expect.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> One note: by putting trace collection into the progress library, we end
> up with data events which have titles like "Receiving objects" - not
> very machine-parseable. An alternative might be to ask for a
> machine-readable title in the progress struct, but I didn't think it was
> worth the code churn. However, I don't have experience with processing
> the trace data after it's been collected, so if this is a bigger problem
> than I think, please say so and I'll figure something out.
> 
> CI run here, although it failed on the same error Junio noted today[1]:
> https://github.com/nasamuffin/git/runs/668457062
> 
>  - Emily
> 
> [1]: https://lore.kernel.org/git/xmqqtv0kc2q1.fsf@gitster.c.googlers.com
> 
>  progress.c                  | 17 +++++++++++++++++
>  t/t0500-progress-display.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/progress.c b/progress.c
> index 75633e9c5e..6d2dcff0b6 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -265,6 +265,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  	progress->title_len = utf8_strwidth(title);
>  	progress->split = 0;
>  	set_progress_signal();
> +	trace2_region_enter("progress", title, the_repository);
>  	return progress;
>  }
>  
> @@ -320,6 +321,22 @@ void stop_progress(struct progress **p_progress)
>  {
>  	finish_if_sparse(*p_progress);
>  
> +	if (p_progress && *p_progress) {
> +		trace2_data_intmax("progress", the_repository, "total_objects",
> +				   (*p_progress)->total);

Should this be "total_objects"? Progress can iterate over lots of things,
such as cache entries. Perhaps leave it as "total"?

> +
> +		if ((*p_progress)->throughput)
> +			trace2_data_intmax("progress", the_repository,
> +					   "total_bytes",
> +					   (*p_progress)->throughput->curr_total);

I like the extra detail here for the specific kind of progress used in
network transfer.

> +	}
> +
> +	trace2_region_leave("progress",
> +			    p_progress && *p_progress
> +				? (*p_progress)->title
> +				: NULL,
> +			    the_repository);
> +
>  	stop_progress_msg(p_progress, _("done"));
>  }

This trace2_region_leave() needs to be conditional on the progress
being non-null. The pattern used by consumers of the progress API is:

	if (my_progress_condition)
		start_progress(&progress);

	do {
		display_progress(&progress, count);
	} while (condition);

	stop_progress(&progress);

The condition to show progress or not is conditional on an option that
is external to the progress API.

The fix for this patch is simple: make the trace2_region_leave() be
conditional on "p_progress && *p_progress".

This leads to an extra problem: if a user uses an option such as "--quiet",
then the trace2 regions won't appear at all. This becomes even more important
when thinking about scripts or tools that have stderr as a non-TTY, which
disables progress most of the time.

It's best to have trace2 data be consistent across commands. I think this can
be accomplished, but it is a more invasive change to the rest of the codebase.
It requires invoking the progress API in all cases, and having the progress
API conditionally initialize the progress struct. The new pattern would look
like this:

	start_progress(&progress, my_progress_condition);

	do {
		display_progress(&progress, count);
	} while (condition);

	stop_progress(&progress);

Then, start_progress() (and variants) could always start the trace2 region,
and stop_progress() could always end the trace2 region.

>  
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index d2d088d9a0..1ed1df351c 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -283,4 +283,30 @@ test_expect_success 'cover up after throughput shortens a lot' '
>  	test_i18ncmp expect out
>  '
>  
> +test_expect_success 'progress generates traces' '
> +	cat >in <<-\EOF &&
> +	throughput 102400 1000
> +	update
> +	progress 10
> +	throughput 204800 2000
> +	update
> +	progress 20
> +	throughput 307200 3000
> +	update
> +	progress 30
> +	throughput 409600 4000
> +	update
> +	progress 40
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
> +		"Working hard" <in 2>stderr &&
> +
> +	# t0212/parse_events.perl intentionally omits regions and data.
> +	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
> +	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
> +	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
> +	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
> +'
> +

Thanks for the test! While this is sufficient to test the trace2 in the
happy path, I think that if you run a Git command such as `git commit-graph write`
that automatically quiets progress in the test suite (non-TTY stderr) you will
find the trace2 logs malformed due to excess end regions.

Thanks,
-Stolee
