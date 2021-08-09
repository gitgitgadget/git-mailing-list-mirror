Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF9C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F88260F56
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhHIRix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhHIRiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 13:38:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799EC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 10:38:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i4so5024050wru.0
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HKpXDB0f2UWpAKQd8SIaa4/ImiMNiqd/O5tGpTgnwuY=;
        b=To9VygYELiCqe/yZRNSQ5dfoRc6lueo55rKGrm9th9kBLe5hsiNXB/ceh/I08PL/U8
         Muq+KopZylzZoMfrP+Olol/BhO3QMQGf8uqa9H5JCdqvB14c092wvKk/OguKp05M/av9
         0UbM9cSDMR4QgbnWQEDDrkEtH3FflWSAPNuldvERYs67T7qYWPl2OW4XUTwgq8XwB4pY
         4YMwoTMAkHvI4eVugGKxbEFdCczjve+s4U8ne+QQQRgydOpUkMxNRB49G+GIIoAS93H5
         2u/CRQmRdokoNaDBAKth/JVqcLQt1a6/jPkP5+R1mZ/PMvaIFAjjcOc8aGqptBVnS9zq
         Kxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HKpXDB0f2UWpAKQd8SIaa4/ImiMNiqd/O5tGpTgnwuY=;
        b=tjsmwPvtJQHY7xxlmWkAOHm2nHKacOQGupw8jkYRY0SQTG6WWkiTQnuKviNKEe8lHr
         3Lu5Is//GuLL6AEw9kzUoGx1Wd3JQ9PITb+cz3kIxipIUu2MjngKiag+7AdaZCPaOhPi
         RqP9eZIoH7T0Z4fcCTWzxLs0xlXZbag/M5TKMnFRnKaAS9B4EeVeKEsxadRSYvNgOfoo
         DVKn8hPmXMXRJ2/PzRi5PC/dxOLY3Ujmpl5jsJOLgtPtVp1rkOmt9RGWlwjBZIdDk7tt
         Y2z6GakX/GC4lLA+7x8STtj4lO8Ldxq8QIf0NkuOSwc+V2lewMz8LhotFerj8yVJUCH5
         BvRg==
X-Gm-Message-State: AOAM53389f24XhVhJmwnqmg/97qYeXcDspwkPPN2+UwINg4BqSWyO42H
        nprwmm96dajkcmTTjXAnyhs=
X-Google-Smtp-Source: ABdhPJwV2kSvRPrN+1TXmCgSdsg/sSeve0EeN2x8M1Z8BwCbbe+/fDM+y3UX0iKTAAjcOtrvjd5EEw==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr27238130wru.33.1628530710504;
        Mon, 09 Aug 2021 10:38:30 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.232])
        by smtp.googlemail.com with ESMTPSA id t16sm20527681wmi.13.2021.08.09.10.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:38:30 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
 <4a0f088f3669a95c7f75e885d06c0a3bdaf31f42.1628055482.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f6e79035-1412-4f8b-5949-8e9cc7215785@gmail.com>
Date:   Mon, 9 Aug 2021 18:38:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4a0f088f3669a95c7f75e885d06c0a3bdaf31f42.1628055482.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 04/08/2021 06:38, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> There are a few reasons to switch the default:
>    * Correctness
>    * Extensibility
>    * Performance
> 
> I'll provide some summaries about each.
> 
> === Correctness ===
> 
> The original impetus for a new merge backend was to fix issues that were
> difficult to fix within recursive's design.  The success with this goal
> is perhaps most easily demonstrated by running the following:
> 
>    $ git grep -2 KNOWN_FAILURE t/ | grep -A 4 GIT_TEST_MERGE_ALGORITHM
>    $ git grep test_expect_merge_algorithm.failure.success t/
>    $ git grep test_expect_merge_algorithm.success.failure t/
> 
> In order, these greps show:
> 
>    * Seven sets of submodule tests (10 total tests) that fail with
>      recursive but succeed with ort
>    * 22 other tests that fail with recursive, but succeed with ort
>    * 0 tests that pass with recursive, but fail with ort

I've not followed your patches too closely but I did notice you seem to 
have put a lot of effort into improving the test coverage which is 
fantastic.

> === Extensibility ===
> 
> Being able to perform merges without touching the working tree or index
> makes it possible to create new features that were difficult with the
> old backend:
> 
>    * Merging, cherry-picking, rebasing, reverting in bare repositories...
>      or just on branches that aren't checked out.

Rebasing without updating the worktree for each commit is exciting.

I agree with others that this should be merged into next sooner rather 
than later. I also agree with Peff's point about moving it into master 
to get more people using it rather than sitting in next for too long.

I think the sequencer changes below are easier to follow in this 
version. One thing I did wonder is whether there needs to be any change 
to the CI scripts to ensure we keep testing both merge implementations.

Best wishes and congratulations on an impressive achievement

Phillip

>    * `git diff AUTO_MERGE` -- ability to see what changes the user has
>      made to resolve conflicts so far (see commit 5291828df8 ("merge-ort:
>      write $GIT_DIR/AUTO_MERGE whenever we hit a conflict", 2021-03-20)
> 
>    * A --remerge-diff option for log/show, used to show diffs for merges
>      that display the difference between what an automatic merge would
>      have created and what was recorded in the merge.  (This option will
>      often result in an empty diff because many merges are clean, but for
>      the non-clean ones it will show how conflicts were fixed including
>      the removal of conflict markers, and also show additional changes
>      made outside of conflict regions to e.g. fix semantic conflicts.)
> 
>    * A --remerge-diff-only option for log/show, similar to --remerge-diff
>      but also showing how cherry-picks or reverts differed from what an
>      automatic cherry-pick or revert would provide.
> 
> The last three have been implemented already (though only one has been
> submitted upstream so far; the others were waiting for performance work
> to complete), and I still plan to implement the first one.
> 
> === Performance ===
> 
> I'll quote from the summary of my final optimization for merge-ort
> (while fixing the testcase name from 'no-renames' to 'few-renames'):
> 
>                                 Timings
> 
>                                            Infinite
>                   merge-       merge-     Parallelism
>                  recursive    recursive    of rename    merge-ort
>                   v2.30.0      current     detection     current
>                  ----------   ---------   -----------   ---------
> few-renames:      18.912 s    18.030 s     11.699 s     198.3 ms
> mega-renames:   5964.031 s   361.281 s    203.886 s     661.8 ms
> just-one-mega:   149.583 s    11.009 s      7.553 s     264.6 ms
> 
>                             Speedup factors
> 
>                                            Infinite
>                   merge-       merge-     Parallelism
>                  recursive    recursive    of rename
>                   v2.30.0      current     detection    merge-ort
>                  ----------   ---------   -----------   ---------
> few-renames:        1           1.05         1.6           95
> mega-renames:       1          16.5         29           9012
> just-one-mega:      1          13.6         20            565
> 
> And, for partial clone users:
> 
>               Factor reduction in number of objects needed
> 
>                                            Infinite
>                   merge-       merge-     Parallelism
>                  recursive    recursive    of rename
>                   v2.30.0      current     detection    merge-ort
>                  ----------   ---------   -----------   ---------
> mega-renames:       1            1            1          181.3
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/merge.c  | 10 ++++++++--
>   builtin/rebase.c |  2 +-
>   sequencer.c      |  4 ++--
>   3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index d7b14bf4a7f..fbe21d413c1 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -88,9 +88,9 @@ static int autostash;
>   static int no_verify;
>   
>   static struct strategy all_strategy[] = {
> -	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
> +	{ "recursive",  NO_TRIVIAL },
>   	{ "octopus",    DEFAULT_OCTOPUS },
> -	{ "ort",        NO_TRIVIAL },
> +	{ "ort",        DEFAULT_TWOHEAD | NO_TRIVIAL },
>   	{ "resolve",    0 },
>   	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
>   	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
> @@ -1484,6 +1484,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   			fast_forward = FF_NO;
>   	}
>   
> +	if (!use_strategies && !pull_twohead &&
> +	    remoteheads && !remoteheads->next) {
> +		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
> +		if (default_strategy)
> +			append_strategy(get_strategy(default_strategy));
> +	}
>   	if (!use_strategies) {
>   		if (!remoteheads)
>   			; /* already up-to-date */
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 12f093121d9..587a2f1d299 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1713,7 +1713,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		int i;
>   
>   		if (!options.strategy)
> -			options.strategy = "recursive";
> +			options.strategy = "ort";
>   
>   		strbuf_reset(&buf);
>   		for (i = 0; i < strategy_options.nr; i++)
> diff --git a/sequencer.c b/sequencer.c
> index a4e5c43fcf2..d08ddae52fa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -636,7 +636,7 @@ static int do_recursive_merge(struct repository *r,
>   	for (i = 0; i < opts->xopts_nr; i++)
>   		parse_merge_opt(&o, opts->xopts[i]);
>   
> -	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
>   		memset(&result, 0, sizeof(result));
>   		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
>   					    &result);
> @@ -3988,7 +3988,7 @@ static int do_merge(struct repository *r,
>   	o.branch2 = ref_name.buf;
>   	o.buffer_output = 2;
>   
> -	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
>   		/*
>   		 * TODO: Should use merge_incore_recursive() and
>   		 * merge_switch_to_result(), skipping the call to
> 

