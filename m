Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D5C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245458AbiA1Twb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiA1Twa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 14:52:30 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303DC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:52:29 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id v5so6111215qto.7
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZpWNQWs/vvb2c2eh/k3kpHlTL8VNRUXYYjigwsdT62c=;
        b=mtK7ZQsDsduwq7gUjypHtjmrR2QnXqIKpC6hNCE8Ih0lJo6bJ15vLoXJlnE0yXb8UJ
         T18E2gAE8xSAphJBOM/NvUUvsq817Ts4j7NQKiHvxEyAzmv6N/PTjB/6PFpp2a78BuG3
         GAAC64Ecd3wsZWlj57Zzbm/KLx5pc47diM2tFbpD1Z6agKvCel4O8K3nyRbeh4207W3C
         8HvCRFxKP6KGFOBGOvRQOyo3XxhAIC8CUHN36AJ6hkRvc4iBXnKx5DxoHEScmrYW/RX0
         Z0/hsc4Z9hbHgWM0DjaedQBeFq2utdU2Q+SBnAtIWcK5DwqSjxuMZZ2Czxy+AuU8FCk2
         rqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZpWNQWs/vvb2c2eh/k3kpHlTL8VNRUXYYjigwsdT62c=;
        b=G4zSuArMiVxPYnYs+JiQwoCVCsVnjcWYb2566LVu8cavEM7Ub1R5+gSPXGy9rb9HG2
         k9pABu2UHhIi0WRPNx1mgDYLxTaYtPF1HDNDKFMZ6ib6gr2XTWJEowBlSHvs7c74EipT
         OxrddbK50XPzLekOlQafTX0jybF/U1aYFjlIXW9joIpjop4BDhZI3FtsqC1GBcG2xZjT
         z4mjrsmerCoJ4jPEttGs5GPOVVjbNePtcK+KRCWJkCAw7tXeIWMqwmGC1nkk/8hT8t+S
         1HgfkhC89istBxLhsnNR0p8IFqZ/pMp8Qi0tLdEuH9/sbUTpj/A3JvQqR5MUC80NQGba
         EvfQ==
X-Gm-Message-State: AOAM530JqNO4MI2lBefFf8a++4XtHjK92CibMu/hHdSNwyrfbNARIb0E
        5NgmQ6CqSH7f7nL24K29Sb+7ElL06q0=
X-Google-Smtp-Source: ABdhPJwJ70LkhoHaWN6IOZwybHBsnS35UfQI0EvHnTcV8zHrhaLoDtqxWwLJgqGvwfAnRSUaZ4rp6A==
X-Received: by 2002:a05:622a:1b86:: with SMTP id bp6mr3741852qtb.224.1643399548371;
        Fri, 28 Jan 2022 11:52:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67? ([2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67])
        by smtp.gmail.com with ESMTPSA id i5sm3934463qkn.19.2022.01.28.11.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:52:27 -0800 (PST)
Message-ID: <2150a170-bf02-f510-3995-c103650ad8fc@gmail.com>
Date:   Fri, 28 Jan 2022 14:52:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
 <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
 <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
 <220128.8635l7d7y6.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <220128.8635l7d7y6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2022 1:21 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jan 28 2022, Johannes Schindelin wrote:
> 
>> On Thu, 27 Jan 2022, Derrick Stolee wrote:
>>
>>> The biggest benefits of using handle_options() is for other pre-command
>>> options such as --exec-path, which I use on a regular basis when testing
>>> new functionality.
>>>
>>> There are other options in handle_options() that might not be
>>> appropriate, or might be incorrect if we just make handle_options()
>>> non-static. For example, `scalar --list-cmds=parseopt` wouldn't show the
>>> scalar commands and would instead show the git commands.
>>
>> Right, and since `handle_options()` lives in the same file as `git`'s
>> `cmd_main()` function, we would not only have to disentangle options that
>> work only for `git` from those that would also work for `scalar`, but we
>> would have to extract the `handle_options()` function into a separate
>> file.
>>
>> And while at it, a tangent someone with infinite time on their hands might
>> suggest is: why not convert `handle_options()` to the `parse_options()`
>> machinery? Which would of course solve one issue by adding several new
>> ones. Don't get me wrong: I would find it useful to convert
>> `git.c:handle_options()` to a function in `libgit.a` which uses the
>> `parse_options()` machinery. It'll just require a lot of time, and I do
>> not see enough benefit that would make it worth embarking on that
>> particular journey.
>>
>> But since I had a look at `handle_options()` anyway, I might just as well
>> summarize my insights about how applicable the supported options are for
>> `scalar` here:
>> [...]
>> # Detrimental
>>
>>   --exec-path
>>
>> 	Since `scalar` is tightly coupled to a specific Git version, it
>> 	would cause much more harm than benefit to encourage users to use
>> 	a different Git version by offering them this option.
> 
> So just to clarify, do you and Stolee disagree about scalar supporting
> --exec-path, per his comments above?

I think it would be nice, but it's also not a blocker for me.

> In this case I don't mind much, but speaking generally I see you and
> Stolee tying yourselves in knots again about scalar being in contrib so
> we shouldn't use libgit.
> 
> It already uses libgit, there's even (last I checked) at least one
> function in it only used directly by the scalar code.

My concern is not that we shouldn't use libgit (because we do) but that
we shouldn't make significant changes to libgit.a only for Scalar's
benefit until it is incorporated in a more final way.

In my opinion, well-architected code is code that is easy to delete.
Until we have Scalar mostly feature-complete and can make a decision
about it living in the Git tree long-term (and _where_ it resides), I
would like to have the following property: If I were to revert all
commits that touch contrib/scalar/ and squash them into a single commit,
then we would have a bunch of file deletions and a very small set of
edits to the Makefile. I don't know how much the ship has sailed there
already, but keeping the size of that "revert diff" small means that we
are keeping the coupling low during this review process.
 
> I don't remember anyone having any objection to scalar using libgit
> code, or even that there's libgit code just to help it along. That's a
> self-imposed limitation you two seem to have invented.
> 
> Personally I find a patch like the below much easier to review. It's the
> parts that aren't easy to review boilerplate are all things that we have
> in-tree already.
> 
> Whereas proposing a new way to parse -c or -C will lead (at least me) to
> carefully eyeballing that new implementation, looking at how it differs
> (if at all) from the existing one, wondering why the i18n strings are
> subtly different etc (I saw one reason is that since the code was
> copy/pasted initially the git.c version was updated, but your patch
> wasn't updated to copy it).

> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 1ce9c2b00e8..ee793ff6ccc 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c

> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 1ce9c2b00e8..ee793ff6ccc 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c

Was this diff double-copied or something?

> +	while (argc > 1 && *argv[0] == '-') {
> +		int show_usage = 0;
> +
> +		if (gity_handle_options(&argv, &argc, NULL, &show_usage)) {
> +			(argv)++;
> +			(argc)--;
> +
> +			if (show_usage)
> +				goto usage;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	if (argc) {

This loop seemed a tad cumbersome for something calling a helper
method, BUT....

> @@ -322,6 +295,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			} else {
>  				exit(list_cmds(cmd));
>  			}
> +		} else if (gity_handle_options(argv, argc, envchanged,
> +					       &show_usage)) {
> +			if (show_usage)
> +				usage(git_usage_string);

...by checking this at the end of your loop here, you have solved
the concern I was talking about with something like

	git --no-pager -C <X> status

having the -C parsing fail because it doesn't recognize --no-pager.

I think this patch you present here would be a good approach to
start transitioning options out of handle_options(), perhaps one
at a time.

But due to my stated goal of "let's not modify things in libgit.a
for Scalar unless absolutely necessary", this approach should be
delayed until at least Scalar is more final.

Thanks,
-Stolee
