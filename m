Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF3C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhLUOpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:45:34 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24EDC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:45:33 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y16so17954522ioc.8
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vl6lXI18Cmh3vFnIUX0LFGWD8eqmJNH9hUbPgCCvMtE=;
        b=BkQlgkxENVgVBLGavR0HWRVKoKlRDO39ugBAP+OI1VrS6HieeuIgWJ2LZfadLm+Mgi
         y12STyewMyeYnJfaqtB+RplPu0vb2Hwq6o5G0CGUl4KNeRgukniRZiiEPLBC/rSx0cOM
         8fUcq0WGjkusP5hhK6I71JuYBMZWcfvtD2qCrJhxlvnKRssgKstLOJFPIzpsepd/y2h1
         NUPNt9sTvPYfe07CHiOBy0BMf0wJNIhsf64CNArS5B5Zdk5ULH5x31qdeeQGk4q58Leo
         VzA80d6pCSf2O2gFuqp5AQBS7VioeGv7PXTaSzeoW1qrXtS9e0dRpYUd50Ca4ra9SmdC
         jvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vl6lXI18Cmh3vFnIUX0LFGWD8eqmJNH9hUbPgCCvMtE=;
        b=JtzQcFiEu9UC6lmAkk89KCHqSsFTC+h0S2ZuM7VvBlOSWcXBWF4U2WFrvmEIbNt7rP
         c2zHdB4WOa9OwUBlUYmgwh5ehHNxfkQiyTgndTwT9InbXdjGwtHfD0z5+nJajAXxA3Iq
         uN3C1Xtt33tsb/2zcwPyEzJg1U1HMZV39AcWZsDJQhpUKF9vpDgyJHVHPBZe3WwGsMaT
         g4W07KkNjcbrxmA5cCuN1N/YOI9xZApzVTNK+HNeqWy5c+guMIqndUJWbLgfs68Ncz3f
         uCrVqatNPNybUXXyMsWgG4hdfzlyJDMTdEJJ4yeX1aYkisqMeGRo9T3faThDrKPlE7uS
         F33w==
X-Gm-Message-State: AOAM531bKFVYpN/8K/QL/CjCDiUDjGdOLnVdyvviTnDpNkfzC+SEnEAX
        zRF7bC1W0+3uEPamW32UESM=
X-Google-Smtp-Source: ABdhPJxVAW9tAEHOR0fZBKEdg1+UJZ1EIGql7OssnvoPqey3quVvNRKE+BLPPnc7Qp5on+7nYa1GRQ==
X-Received: by 2002:a6b:2b12:: with SMTP id r18mr1767822ior.66.1640097933017;
        Tue, 21 Dec 2021 06:45:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c11c:699d:989:f926? ([2600:1700:e72:80a0:c11c:699d:989:f926])
        by smtp.gmail.com with ESMTPSA id k7sm10823756iom.34.2021.12.21.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 06:45:32 -0800 (PST)
Message-ID: <5f9c6997-abae-c2c7-0121-eb2d360108b8@gmail.com>
Date:   Tue, 21 Dec 2021 09:45:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 7/9] trace2: add stopwatch timers
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 10:01 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Add a stopwatch timer mechanism to Git.

> +static void *ut_009timer_thread_proc(void *_ut_009_data)
> +{
> +	struct ut_009_data *data = _ut_009_data;
> +	int k;
> +
> +	trace2_thread_start("ut_009");
> +
> +	for (k = 0; k < data->count; k++) {
> +		trace2_timer_start(TRACE2_TIMER_ID_TEST2);
> +		sleep_millisec(data->delay);
> +		trace2_timer_stop(TRACE2_TIMER_ID_TEST2);
> +	}
> +
> +	trace2_thread_exit();
> +	return NULL;
> +}
> +
> +

nit: double newline.

> +# Exercise the stopwatch timer "test" in a loop and confirm that it was
> +# we have as many start/stop intervals as expected.  We cannot really test
> +# the (elapsed, min, max) timer values, so we assume they are good.

We can't check their values, but we could check that their labels are
emitted.

> +test_expect_success 'test stopwatch timers - summary only' '
> +	test_when_finished "rm trace.perf actual" &&
> +	test_config_global trace2.perfBrief 1 &&
> +	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
> +	test-tool trace2 008timer 5 10 &&
> +	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
> +	grep "d0|summary|timer||_T_ABS_||test|name:test1 count:5" actual

adding something like " total:.* min: .* max:.*" to the end of this
pattern might be good. You could even get really specific about the ".*"
being a floating point number, but I'm not too concerned about that. I
just want to see that these other labels stay consistent in future Git
versions.

> +# Exercise the stopwatch timer "test" in a loop and confirm that it was
> +# we have as many start/stop intervals as expected.  We cannot really test
> +# the (t_timer, t_min, t_max) timer values, so we assume they are good.
Similar, we can do something such as...

> +have_timer_event () {
> +	thread=$1
> +	name=$2
> +	count=$3
> +	file=$4
> +
> +	grep "\"event\":\"timer\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"count\":${count}" $file

Adding more detail to this pattern.

This helper could probably benefit from constructing the regex across
multiple string concatenations, so we can see the different pieces.
Something like

	pattern="\"event\":\"timer\""
	pattern="$pattern.*\"thread\":\"${thread}\""
	pattern="$pattern.*\"name\":\"${name}\""
	pattern="$pattern.*\"count\":\"${count}\""
	pattern="$pattern.*\"t_total\":"
	pattern="$pattern.*\"t_min\":"
	pattern="$pattern.*\"t_max\":"

	grep "$pattern" $file

> +
> +	return $?

If we used && throughout this method, would this return not be
necessary?

> +static void tr2main_emit_summary_timers(uint64_t us_elapsed_absolute)
> +{
> +	struct tr2_tgt *tgt_j;
> +	int j;
> +	struct tr2tmr_block merged;
> +
> +	memset(&merged, 0, sizeof(merged));
> +
> +	/*
> +	 * Sum across all of the per-thread stopwatch timer data into
> +	 * a single composite block of timer values.
> +	 */
> +	tr2tls_aggregate_timer_blocks(&merged);
> +
> +	/*
> +	 * Emit "summary" timer events for each composite timer value
> +	 * that had activity.
> +	 */
> +	for_each_wanted_builtin (j, tgt_j)
> +		if (tgt_j->pfn_timer)
> +			tr2tmr_emit_block(tgt_j->pfn_timer,
> +					  us_elapsed_absolute,
> +					  &merged, "summary");

I'd put braces at the for-loop level, even though this is semantically
correct without them.

> +}
> +
> +static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
> +{
> +	struct tr2_tgt *tgt_j;
> +	int j;
> +
> +	for_each_wanted_builtin (j, tgt_j)
> +		if (tgt_j->pfn_timer)
> +			tr2tls_emit_timer_blocks_by_thread(tgt_j->pfn_timer,
> +							   us_elapsed_absolute);

(same here)

> +/*
> + * Define the set of stopwatch timers.
> + *
> + * We can add more at any time, but they must be defined at compile
> + * time (to avoid the need to dynamically allocate and synchronize
> + * them between different threads).
> + *
> + * These must start at 0 and be contiguous (because we use them
> + * elsewhere as array indexes).

I was worried at first about using an array here, but this is essentially
one chunk of global memory per process that will not be very large, even
if we add a lot of timer IDs here. If we use this API enough that that
memory is a problem, then we can refactor the memory to be a hashmap that
only populates entries for IDs that are used by the process.

> + * Any values added to this enum must also be added to the timer definitions
> + * array.  See `trace2/tr2_tmr.c:tr2tmr_def_block[]`.
> + */
> +enum trace2_timer_id {
> +	/*
> +	 * Define two timers for testing.  See `t/helper/test-trace2.c`.
> +	 * These can be used for ad hoc testing, but should not be used
> +	 * for permanent analysis code.
> +	 */
> +	TRACE2_TIMER_ID_TEST1 = 0, /* emits summary event only */
> +	TRACE2_TIMER_ID_TEST2,     /* emits summary and thread events */
> +
> +
> +	/* Add additional timer definitions before here. */
> +	TRACE2_NUMBER_OF_TIMERS
> +};

...

> +static struct tr2tmr_def tr2tmr_def_block[TRACE2_NUMBER_OF_TIMERS] = {
> +	[TRACE2_TIMER_ID_TEST1] = { "test", "test1", 0 },
> +	[TRACE2_TIMER_ID_TEST2] = { "test", "test2", 1 },
> +};

Although this will always be populated, so maybe my thoughts about how
to reduce memory load in the hypothetical future are worthless.

> +void tr2tmr_start(enum trace2_timer_id tid)
> +{
> +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
> +	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
> +
> +	t->recursion_count++;
> +	if (t->recursion_count > 1)
> +		return; /* ignore recursive starts */
> +
> +	t->start_us = getnanotime() / 1000;

Using nanotime gives us the best precision available, and dividing
by 1000 will lose some precision. This is likely why we saw some
0.000000 values for t_min in some of your experiments. That should
be rare for real uses of this API (such as wrapping lstat() calls).

But why do we divide by 1000 here at all? 2^63 nanoseconds is
still 292 years, so we don't risk overflow. You specify uint64_t
so this isn't different on 32-bit machines.

Thanks,
-Stolee
