Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A073C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 08:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJKI7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 04:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJKI7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 04:59:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167511A11
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 01:59:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t4so8161295wmj.5
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXRjbz2kOFd/Sz15Ue5iD08hhLOs3GFc9Lf1Jvgef6w=;
        b=n7C0aMpIOa3TFsMf6G1LvkvY+r42Pdc4T9htI1ard2SLdSrt0y8bUH3LM/jc2qLoyJ
         Py5LEHEDGQ4sqDe6U2YOijFRkNYq2FWB2o0tjrgD8teRhbrLOFf/S9xCkWRmiLj8JNOG
         DvyA7sVuxddmdQAw3+w30r64ot4p+9tRzY5yBjnvORCxaYGQfff5863N35DKPOaBT8vq
         kP4WXMXyID4Zhe3FFh+3u3IjzPKZ7mR7gCZrglDUdEE+8ki8RhuGnvbeV8J3nIYh0Trq
         zZeryAk0txf7z4GTzvJtb4CABRD/PjSyMpvwEzxzL5TOJszmqYcm4186/6UhkvXGJ+A5
         I92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXRjbz2kOFd/Sz15Ue5iD08hhLOs3GFc9Lf1Jvgef6w=;
        b=GzMzWi9EvJO3j0fr23BM7PIQka8qly+pMaw7yj4lnYDWavaiZGrB7Cl13vW7qK8AYv
         imWNkIO2DNFiNTwHb+xue2EUWQjTnRgvo3XKEnMK5jZGUYpl9yPioOyXTqdqCYsziym2
         GBFZtDYoAl0K7LDryUqLhYGjAlALSA0lIstTAssJKucSMd48JdMbakPrvPmOUyC2x0ew
         eCaaMXquLk4mh6psNa7Ds7EBh4uXAQKeiAGXeJzH63kKzdU3U6Kg+xls/9EIkB3ebUiO
         LGIQHI70vzIkcUJo8v+FP5N2iTROeqFqqmrRasI++RSmdIHOKZEA8mDyCmWzgvWqu+/6
         1obA==
X-Gm-Message-State: ACrzQf0481xzlpvqY9VXuoxTQX7DTTtP7t3/AHjlvKY2QPNjRxkZacjy
        VyJyfw5P1lRGgOmFYF+Ti7U=
X-Google-Smtp-Source: AMsMyM5l+vPfY/tl+Ts4ONVof4sUYRtwq72KSgf3rjhzKGvlb6O/tOeHLcqE3f9xbT7ecJ28HcMQtg==
X-Received: by 2002:a05:600c:3c84:b0:3b4:eff4:ab69 with SMTP id bg4-20020a05600c3c8400b003b4eff4ab69mr22454370wmb.104.1665478786236;
        Tue, 11 Oct 2022 01:59:46 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id q12-20020a1ce90c000000b003b3307fb98fsm11853575wmc.24.2022.10.11.01.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:59:45 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <3384d8ab-ddbb-6e57-1663-d039fc99e0a6@dunelm.org.uk>
Date:   Tue, 11 Oct 2022 09:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] technical doc: add a design doc for the evolve
 command
To:     Victoria Dye <vdye@github.com>,
        Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
 <a5eb93254191b7ae9c17ce52e056955c669ea007.1664981958.git.gitgitgadget@gmail.com>
 <35d65b75-c5c4-132a-bbd5-49d3c012c69f@github.com>
Content-Language: en-US
In-Reply-To: <35d65b75-c5c4-132a-bbd5-49d3c012c69f@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2022 20:35, Victoria Dye wrote:
> Stefan Xenos via GitGitGadget wrote:
>> From: Stefan Xenos <sxenos@google.com>
>>
>> This document describes what a change graph for
>> git would look like, the behavior of the evolve command,
>> and the changes planned for other commands.
>>
>> It was originally proposed in 2018, see
>> https://public-inbox.org/git/20181115005546.212538-1-sxenos@google.com/
>>
>> Signed-off-by: Stefan Xenos <sxenos@google.com>
>> Signed-off-by: Chris Poucet <poucet@google.com>
>> ---
>>   Documentation/technical/evolve.txt | 1070 ++++++++++++++++++++++++++++
>>   1 file changed, 1070 insertions(+)
>>   create mode 100644 Documentation/technical/evolve.txt
>>
>> diff --git a/Documentation/technical/evolve.txt b/Documentation/technical/evolve.txt
>> new file mode 100644
>> index 00000000000..2051ea77b8a
>> --- /dev/null
>> +++ b/Documentation/technical/evolve.txt

...

>> +P0. Any commit that may be involved in a future evolve command should not be
>> +    garbage collected. Specifically:
>> +    - Commits that obsolete another should not be garbage collected until
>> +      user-specified conditions have occurred and the change has expired from
>> +      the reflog. User specified conditions for removing changes include:
>> +      - The user explicitly deleted the change.
>> +      - The change was merged into a specific branch.
>> +    - Commits that have been obsoleted by another should not be garbage
>> +      collected if any of their replacements are still being retained.
> 
> If the creation of these linkages is passive, but requires active user
> intervention to clean up, this requirement could result in creating an
> enormous amount of cruft in repositories. I might rebase a branch 10+ times
> between pushes to make little tweaks to phrasing in commit messages, or fix
> typos, etc. It sounds like I'd be pushing an order of magnitude more objects
> than I am now, let alone the fact that they wouldn't be GC'd automatically.

That's an interesting point. When we push we only really need to push a 
map of "commits we pulled" to "commits we're pushing", we don't need to 
send all the intermediate changes. That would also help to address 
Glen's review club concerns about accidentally pushing secret information.

One of the things which I hope comes out of having all the intermediate 
changes tracked locally is a way to view the history of a particular 
commit. If I make a mistake when rebasing and don't notice it for a 
while it would be really helpful to be able to view the history and 
figure out which change introduced the mistake (You can do something 
similar with "git rev-list -g $branch | git log -p --stdin 
^${branch}@{upstream}" but you have to wade through all the commits on 
$branch).

...

>> +Similar technologies
>> +--------------------
>> +There are some other technologies that address the same end-user problem.
>> +
>> +Rebase -i can be used to solve the same problem, but users can't easily switch
>> +tasks midway through an interactive rebase or have more than one interactive
>> +rebase going on at the same time. It can't handle the case where you have
>> +multiple changes sharing the same parent when that parent needs to be rebased
>> +and won't let you collaborate with others on resolving a complicated interactive
>> +rebase. You can think of rebase -i as a top-down approach and the evolve command
>> +as the bottom-up approach to the same problem.
> 
> I think it's worth considering whether 'rebase' can be updated to handle
> these cases (since it might simplify and/or pare down your proposed design).
> 
> 1. Can't easily switch tasks midway through an interactive rebase
>     - I could imagine us introducing a 'git rebase pause' that does this,
>       although it would require changes to how rebases are tracked
>       internally.

I'm not sure how much of a problem this is in practice as one can use 
"git worktree add" to work on a different branch or is the idea to be 
able to start several rebases on the same branch? - That sounds like a 
recipe for conflicts that cannot be resolved automatically unless the 
user is very disciplined.

> 2. Can't have more than one interactive rebase going on at the same time
>     - Do you mean nested rebases, or just separate ones? I think both of them
>       could be possible (with the changes to rebase tracking in #1), but
>       nested ones might be tough to mentally keep track of.
> 3. Can't handle multiple changes sharing the same parent when the parent
>     needs to be rebased
>     - Since the introduction of '--update-refs' [1], this is technically
>       possible (although it needs a UI for the use case you mentioned).

'--update-refs' is more limited though I think. With evolve if I have

                   D (topic-2)
                  /
	A - B - C (topic-1)
                  \
                   E (topic-3)

then if I checkout topic-1 and amend one of the commits I can run "git 
evolve" to automatically rebase topic-2 & topic-3. One cannot do that 
with "rebase --update-refs". We could extend rebase (or have a new 
command) so that users can say "amend commit X and rebase all the 
branches that contain it".

> 4. Won't let you collaborate with others on resolving a complicated
>     interactive rebase
>     - This is an interesting one, since it requires being able to push a
>       mid-merge state. However, if you're planning on solving that for 'git
>       evolve', a similar solution could probably be used for 'rebase'.
>       Pushing a whole rebase script, though, would be more complicated.
> 
> The "top-down"/"bottom-up" analogy is a bit lost on me, I'm afraid. Could
> you clarify what you mean by that?

I was confused by that as well

> [1] https://lore.kernel.org/git/pull.1247.v5.git.1658255624.gitgitgadget@gmail.com/

Best Wishes

Phillip
