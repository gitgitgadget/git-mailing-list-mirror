Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0487FC636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 14:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjBVO1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 09:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjBVO1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 09:27:21 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243839CE8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 06:27:19 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z5so7999738ljc.8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0FLCyNgNYQtEW6P76gKg+9AfTZ9yVhdIVdp1AQ/3Ws=;
        b=RvOvkKx8oK9FoihwY5wLbXFACYY4FjAxiUM/aa5zr8cE1P2yNlIAJOLVOETyM3A/jL
         ZFLbgPFZpIc4+8wzk2NifTVmQBlhkbqjhYfiOhcd4ephmGI7AiND9MuwEjNGFWnEbOJL
         29JuvMfRhia2mF270ElWXvxIKfOcxpNMS3qmlN+yUp/uQLlYOdR1iUNM1IdZ0R22t91C
         jqZQzt8WErfyKfaoUdnyG4BBRBjPgWGV+9kqIkN1rfAgLA05IgwflawCpWOYSOws7zPF
         D+RzjNFUOvUsbuPGu1R0GY/MxBtJhwfpy+DCFx64x45YEJzaVHpz1BCur7q/KW00dBJL
         0XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0FLCyNgNYQtEW6P76gKg+9AfTZ9yVhdIVdp1AQ/3Ws=;
        b=HS+dVteLB5MRbrL48qNlqpPbBb9jX1geHyKjmX7g+/QwCNkW/FIXRLtC4UAzKeZpE6
         gptRYKtSGWlJko6xUSOJ43vX4sjtxeDOrsSSawLXeBcPsM37q/H0K3eOgcuyWmq0zDoi
         Iq7xTnXLB/B8/WX/usEQX4L1SmxfLSUXIRR1QHt9961ai1G/7Y5pR4zPQVlDqVc3/y9u
         2GrqWaeC/fgWW6z+hUif41BOD47xWK2dlPyvq1r58RJjPt+RPyjHCH/Fn4VxJjnBCxdI
         CK4OvfTnTrK8STVNXL71JSnJ8rS0p30q1kyrRvGp/8mWmFuW+kjQYzM9Tq1Jzp2SRpRT
         BGqg==
X-Gm-Message-State: AO0yUKWYAN2DwcxKTdmnYpJFwlxjdX6ZZstc2jRpDJmxiFMHP08L3ZK0
        zNEwf8KI9nH2FENCGysYSMA=
X-Google-Smtp-Source: AK7set8GiwiT0Q4lLb0MSTgAjNavjVJUCLJdolQU0V2pyBzueDRHdS0SDBSQfm0VZeBmAKz6poOu+Q==
X-Received: by 2002:a05:651c:a0e:b0:293:4cfe:ad31 with SMTP id k14-20020a05651c0a0e00b002934cfead31mr6101845ljq.14.1677076037149;
        Wed, 22 Feb 2023 06:27:17 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j16-20020a2e3c10000000b0029352e4ba6esm810518lja.90.2023.02.22.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:27:16 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
        <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
        <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
        <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
        <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
        <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
        <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
Date:   Wed, 22 Feb 2023 17:27:15 +0300
Message-ID: <87a615vkqk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Sat, Feb 18, 2023 at 5:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 18/02/2023 03:17, Elijah Newren wrote:

[...]

>> > My personal opinion would be adding such a capability should be step
>> > 2.5 in your list, though I suspect that would make Tao unhappy (it's a
>> > non-trivial amount of work, unlike the other steps in your list).
>>
>> I've got a couple of patches[1] that cherry-pick the merge if only one
>> of the parents has changed. I've never tried upstreaming them as it is
>> only a partial solution to the problem of rebasing merges but that
>> approach should work well with "git pull --rebase=merges" as only the
>> upstream side will have changed (when rebasing my git integration branch
>> with that patch the merges are cherry-picked). They might make a useful
>> starting point if anyone wants to try and improve the rebasing of merges.
>>
>
> This is awesome!
>
> It feels like the first step towards the general strategy that was (I
> believe) best described by Buga at
> https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
> !

Being the provoker of all the fuss then, as well as the author of basic
original method, I agree Buga has summarized and described all the ideas
in existence at that time extremely well.

>
> (unless I'm missing something, the result of this is exactly the same
> as the result of that strategy, in these "simple" cases where it kicks
> in)
>
> The one concern I have with this is that, *if I understand correctly*,
> it sometimes throws away the existing merge information, and sometimes
> doesn't, and there's no easy way to know which it is at runtime.

As far as I'm aware, it's not the case. The originally described method
indeed misbehaved, but this simple mistake has been quickly fixed, and
the description by Buga you've referenced already discusses updated
version.

> Would adding a warning on stderr when a both-parents merge is
> encountered (and any merge resolutions or related changes are still
> discarded) be enough to make this shippable?

Even if there are in fact such corner cases, we could make ourselves
very cautious and stop even after non-conflicting rebase, if we detect
that U1' and U2' don't match, and let user decide if the result is
acceptable (similar to what rerere does on successful application of
replayed resolutions).

I also agree (in particular with Buga) that from the POV of user
experience the method suggested by Phillip should be superior, as it
emphasizes the natural dominance of the "current branch", as opposed to
originally described symmetric method that is more suitable for formal
analysis than for actual convenient implementation. Yet creating U1' and
U2' from the original method could be useful for the purpose of checking
for possible problems with automatic rebase that the user may need to be
aware of.

The biggest problem here, as I see it, is designing UI that'd make sense
in the case of conflicts in multiple stages of the suggested algorithms,
but I think we can simplify it for now by stopping and suggesting blind
re-merge in case of any conflict but that on rebasing of changes to the
first parent. Even this would be a huge step forward compared to silent
drop of merge commits and blindly re-merging of updated parents.

>
> Are there *any* circumstances where the new cherry-picking behavior
> introduced here wouldn't be the right thing to have happen?

None that I'm aware off, but I admit I'm not familiar with later Elijah
work on the subject, so I could be mistaken. I only got a sketchy look
at what Elijah did, and it looks like advanced material to me. I'd
incline to rather get solid implementation of basics first, probably
using Phillip method, then consider advanced methods if practice reveals
demands for further improvements.

I'm afraid that there is no ideal general solution for the problem of
rebasing merge commits, so we need to limit ourselves and get a
practical one that has already been described.

Overall, I'd love to finally have reliable Git behavior when rebasing
merge commits, even though I've already got a habit to perform all the
merges in 2 steps: auto-merge resolving textual conflicts only (if any),
followed by a fixup for semantics conflicts (if any).

Thanks,
-- Sergey Organov

