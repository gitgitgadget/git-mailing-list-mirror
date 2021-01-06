Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B36C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EB223117
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbhAFLy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFLy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:54:58 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356AC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:54:17 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v5so1826644qtv.7
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QjVwR96LfaZd8uDCS/wsJZ/agKixLMWqG+vfPnXy//s=;
        b=hlnI4AbZtIQnDhBnRGIGHIWIs/yHLApX5e82iP6+dWSlI0/eorsCmLkFeX0a7OxgaD
         Z4qyE4o5ChxQv/GdRQH23YtmG3TydQoyMQe5ofLfqjtaTF4R9GujwALULsHGIxteyvCP
         qaDfK9AJUNMqhuv5t6AKGJ2kmNjL+nDSvrvYZfxRa9ksuoBGyCoMn8Pg24SC2dJ5D5gm
         M9t+lcc4Eb/0NpoK8RXCaDhi/Pn4nUVbzKdSHxzKLr9Q2YSjF/3JsRxD7jAPdTs1VbEd
         C/tSONAXrGigPGqGLnp09fPiaGAQat64AwxY8z4oDg56943FzVVT+YBLrnM7oV3+kKUD
         b1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QjVwR96LfaZd8uDCS/wsJZ/agKixLMWqG+vfPnXy//s=;
        b=Ehd+ygS1a0VClKvjwLFh4cKA3m6WcqfRGndvOCHm9jDxoKIIESBspDfUQMu2ztS9LR
         5UqyM5lowLhKCbIKxhsNO3i+UEhJEa7B65Az9OgqZKpzngla0k2TGK+nkamB70bCAxqr
         3f+ILFkjWs8gYU9b1NnbxQ9AdK4glPl+ZEDZpFCS2wJTf1Is17jLZ6FA+hD7vjNkZZ76
         Ze8oPstWaavzRNn0lkq7OTh9lrVA0YbIBYCH5rNXgLvg/byh/uctoFmjZ1phySp3y7IM
         06w+3qm6j2IpGOqGzyBc2zkxOFRY6o93QSSVsN31vDoD3++seXgwdYN5RN2zUGnQcbat
         5mkg==
X-Gm-Message-State: AOAM532pvSzJnkd4HvwktUo7Th0spAy6N/W+ImLSU4ktYjsz1aPrW6W5
        jidGFS4J0x8ZEO9IIm8Nr5+V8LRvXbQ=
X-Google-Smtp-Source: ABdhPJz3wXD2N6lVgdtxWRq02+eXDAa0RP6M4PsLF820KID5BnGxteaItqhpcBqcOh7EUvsMTrh+8A==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr3532776qta.309.1609934056992;
        Wed, 06 Jan 2021 03:54:16 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id s21sm953838qtn.13.2021.01.06.03.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 03:54:16 -0800 (PST)
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
 <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
 <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <63e618bd-a60e-0692-6489-06b4b0504895@gmail.com>
Date:   Wed, 6 Jan 2021 06:54:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/5/2021 11:20 PM, Eric Sunshine wrote:
> On Tue, Jan 5, 2021 at 9:20 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 1/5/2021 12:55 PM, Eric Sunshine wrote:
>>> On Tue, Jan 5, 2021 at 9:44 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>> Probably not worth a re-roll, but the above has higher cognitive load than:
>>>
>>>     if (!value)
>>>         return 0;
>>>
>>> which indicates clearly that the command succeeded, whereas `return
>>> result` makes the reader scan all the code above the conditional to
>>> figure out what values `result` could possibly hold.
>>
>> True. Looking at this again, it might be better to just update the
>> loop to be
>>
>>         for (i = 0; values && i < values->nr; i++) {
>>
>> which would run the loop zero times when there are zero results.
> 
> I find the explicit `return 0` easier to reason about since I can see
> immediately that it handles a particular boundary condition, after
> which I no longer have to think about that condition as I continue
> reading the code.
> 
> That said, I don't think it matters greatly one way or the other
> whether you use `return result`, `return 0`, or adjust the loop
> condition. It might matter if more functionality is added later, but
> we don't have to worry about it now, and it's not worth re-rolling
> just for this, or spending a lot of time discussing it.

Junio made a good point that 'values' doesn't change during the loop,
so I shouldn't use it in the sentinel. I'll use your "return 0;"

>>>> +       git for-each-repo --config=bogus.config -- these args would fail
>>>
>>> The `these args would fail` arguments add mystery to the test,
>>> prompting the reader to wonder what exactly is going on: "Fail how?",
>>> "Is it supposed to fail?". It might be less confusing to use something
>>> more direct like `nonexistent` or `does not exist`.
>>
>> I guess the point is that if we actually did try running a subcommand
>> on a repo (for instance, accidentally running it on the current repo)
>> then the command would fail when running "git these args would fail".
>>
>> To me, "nonexistent" or "does not exist" doesn't adequately describe
>> this (hypothetical) situation.
>>
>> Perhaps "fail-subcommand" might be better?
> 
> I had never even looked at git-for-each-repo before, so I took the
> time to read the documentation and the source code before writing this
> reply. Now that I understand what is supposed to happen, I might be
> tempted to suggest `this-command-wont-be-run` as an argument, but
> that's a mouthful. If you want to be really explicit that it should
> fail if a bug gets re-introduced which causes the argument to be run
> even though the config is empty, then perhaps use `false`:
> 
>     git for-each-repo --config=bogus.config -- false

I'm just going to repeat that this would run "git false". It achieves
the same goal where we interpret this as a failure if the subcommand
is run.

> By the way, when reading the documentation, some questions came to mind.
> 
> Is the behavior implemented by this patch desirable? That is, if the
> user mistypes the name of the configuration variable, would it be
> better to let the user know about the problem by returning an error
> code rather than succeeding silently? Or do you foresee people
> intentionally running the command against an empty config variable?
> That might be legitimate in automation situations. If legitimate to
> have an empty config, then would it be helpful to somehow distinguish
> between an empty config variable and a non-existent one (assuming we
> can even do that)?

As mentioned in the message, this is the situation the background
maintenance would see if a user used 'git maintenance unregister' on
all of their repos or removed the 'maintenance.repo' config values
from their global config. I think it would be better to not start
failing the background commands.

Even outside of that context, we have no way to specify an "existing
but empty" multi-valued config value over a non-existing config
value. I'd rather prefer the interpretation "I succeeded in doing
nothing" instead of "I think you made a mistake, because there's
nothing to do."

Could we meet in the middle and print a warning to stderr?

	warning(_("supplied config key '%s' has no values"));

That would present a useful message to users running this command
manually (or constructing automation) without breaking scripts
that parse the output.

> Is the API of this command ideal? It feels odd to force the user to
> specify required input via a command-line option rather than just as a
> positional argument. In other words, since the config variable name is
> mandatory, an alternative invocation format would be:
> 
>     git for-each-repo <config-var> <cmd>
> 
> Or do you foresee future enhancements expanding the ways in which the
> repo list can be specified (such as from a file or stdin or directly
> via the command-line), in which case the `--config` option makes
> sense.

I believe some voice interest in specifying a list of repositories
by providing a directory instead of a config value. That would
require scanning the immediate subdirectories to see if they are Git
repos.

A --stdin option would also be a good addition, if desired.

Since this command was intended for automation, not end-users, it
seemed that future-proofing the arguments in this way would be a good
idea. We want to remain flexible for future additions without
breaking compatibility.

Thanks,
-Stolee
