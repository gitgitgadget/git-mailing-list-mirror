Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96AC636CC
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 16:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBRQjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 11:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRQjq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 11:39:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376DD16306
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 08:39:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w18so652263wrv.11
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cE9qPC/+EzK5WCgFt3fpTrq3wn5Ogg4q3nV/66XoNs=;
        b=c7CwaVd7fqYJjx5/TIzX8yALDbuvmq8KAi2AyKLJC61zz/uJacQ1Q/b5O3BJ4sq+jZ
         WG/CBGPvzTu7LorEj+kTaOlgmAD7SOIZOGw5nnExevbvD3yCEZVyJKw/KEMjYE38xn8f
         TkZxwVUtxaqNSDTh0bU6olgZz2qEalEL6Hjpce18DOf9SO9pd4zQ46QX4pr8HUiRYafn
         6hq2UbUlpZuqjjJaTa9lf8VczWFU4ZS7qSQpKboZc5f/Xq4kjqojZ+qH6tMUknqu3v6S
         N3OqG3UUDOrEkV50E//NCNkvMvvM8iCGmnhLJf22cBU2qa543ldfuFvHUkQ6ieLGeZE7
         e1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cE9qPC/+EzK5WCgFt3fpTrq3wn5Ogg4q3nV/66XoNs=;
        b=dHJKRDNEPX1D09DfPsvRbt0YjNuNG4SYxKqdFiOQRsn3hGslalP/DsOOKNt/hIrnFn
         AuEqSMPO7jsB7oVo2EmJ7x8zO/IFJqAf6eJ2QjLf36B8OCBENGCe0E+KxvHEVt4TXVz5
         LXtGyR3EL3axqU880mBrWPMpGyFVBQFXADYMbp/EIloDbthLbRBNU3LZ095Rw7agx3e3
         9jB9E5JGP2RQ4f8AUoTW4kY1NRRy7Yem15AvLmwGAA/UZMsrGLYBEOyQolASgnmh4c8v
         Fkgk+gsDTBG9Y30RA/jgf4Rt5bVRrnk0ql09cscinGQobr6SK7pCClVU5fsRijUD7BhD
         Knqg==
X-Gm-Message-State: AO0yUKUx4IyydSNHdYUj7zBwx8uX4gFICD15NnO/M1XPUFZAfQsOdXvZ
        yXL/5hO7PO3H9HSD1kaDssiLlg4P0xs=
X-Google-Smtp-Source: AK7set99rvCKVkubVqoMTNW6wg2+91AdjaxNeotF2lRUxBbpG4/MB1eOlr2xOqxbV38aYJh/mZk/QA==
X-Received: by 2002:a5d:6e03:0:b0:2c5:4c6f:27cc with SMTP id h3-20020a5d6e03000000b002c54c6f27ccmr3210215wrz.44.1676738383537;
        Sat, 18 Feb 2023 08:39:43 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b002c55ec7f661sm7280640wru.5.2023.02.18.08.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 08:39:43 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
Date:   Sat, 18 Feb 2023 16:39:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
In-Reply-To: <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/02/2023 03:17, Elijah Newren wrote:
> On Thu, Feb 16, 2023 at 8:02 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>>
>> On Thu, Feb 16, 2023 at 5:31 AM Tao Klerks <tao@klerks.biz> wrote:
>>>
>>> If there's an appetite for it, I would love to contribute to a
>>> multi-year adventure to change git's behavior, little by little, until
>>> the behavior of "rebase=merges" is the default, and the old behavior
>>> becomes a different option like
>>> "rebase=copy-merged-commits-to-flatten"
>>
>> I know you had a lot to say in your last email, but I'd like to focus
>> on this point. I would be OK with the proposed patch if it were part
>> of a larger effort to make --rebase-merges the default behavior of
>> `git rebase`. That seems like an achievable goal, and I don't think it
>> would take multiple years, maybe one year at the most. The process
>> would look something like this:
>>
>> 1. Add a --no-rebase-merges option to `git rebase`.
>>
>> 2. Add a rebase.merges config option.
>>
>> 3. Add a warning to `git rebase` that appears if rebase.merges is
>> unset and neither --rebase-merges nor --no-rebase-merges is given. The
>> warning would advise the user that the default behavior of `git
>> rebase` will change in a future release and suggest setting
>> rebase.merges=no-rebase-cousins to get the new behavior now.
>>
>> 4. Change the `git pull` advice to recommend --rebase=merges and
>> pull.rebase=merges.
>>
>> 5. Wait a couple of releases.
>>
>> 6. Change the default behavior of `git rebase` to `git rebase
>> --rebase-merges` and the default behavior of `git pull --rebase` to
>> `git pull --rebase=merges`. At the same time, remove the warning from
>> `git rebase`. The old `git pull` behavior would still be available as
>> `git pull --rebase=true`.
>>
>> 7. Change the `git pull` advice to recommend the short and simple
>> --rebase option again (leaving the recommendation of
>> pull.rebase=merges for the config option).
>>
>> Does that sound reasonable? I think I could lend a hand with steps 1-3.
> 
> One concern I have is that "--rebase-merges" itself has negative user
> surprises in store.  In particular, "--rebase-merges", despite its
> name, does not rebase merges.  It uses the existing author & commit
> message info, but otherwise just discards the existing merge and
> creates a new one.  Any information it contained about fixing
> conflicts, or making adjustments to make the two branches work
> together, is summarily and silently discarded.

That's a good point. Another potentially surprising behavior is that 
when I'm rebasing an integration branch with -rno-rebase-cousins then if 
one of the topic branches merged into the integration branch happens to 
share the same base as the integration branch itself the topic branch 
gets rebased as well. -rno-rebase-cousins is also slower that it needs 
to be because it creates a todo list that contains all the commits on 
the topic branches merged into the integration branch rather than just 
the merges. The commits on the topic branches are fast-forwarded rather 
than rewritten so long as they don't share the same base as the 
integration branch but it noticeably slower than using a todo list with 
just the merge commands.

> My personal opinion would be adding such a capability should be step
> 2.5 in your list, though I suspect that would make Tao unhappy (it's a
> non-trivial amount of work, unlike the other steps in your list).

I've got a couple of patches[1] that cherry-pick the merge if only one 
of the parents has changed. I've never tried upstreaming them as it is 
only a partial solution to the problem of rebasing merges but that 
approach should work well with "git pull --rebase=merges" as only the 
upstream side will have changed (when rebasing my git integration branch 
with that patch the merges are cherry-picked). They might make a useful 
starting point if anyone wants to try and improve the rebasing of merges.

Best Wishes

Phillip

[1] https://github.com/phillipwood/git/commits/rebase-cherry-pick-merges
