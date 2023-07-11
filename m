Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4FEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKSdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 14:33:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18BC170F
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 11:33:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so925351a12.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689100408; x=1691692408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QM6aFor2mHBNKooM1VlxcyhT2njFs9JXK/3H1Wp/X/U=;
        b=QmG0PvuCFGrTBzMiP17e4X9ivvy6dGGKBvJFLZw/Sh0IDd8AOzd/zD1risy+g0+ZxA
         iFdchbfE/hxKeu+YxCw5CXpcuYszacNZ4pgelOXGxUqE2W/H7qHjrIgUOsR9O/rq9n4p
         NTiRfeBTzBIxzEWl5xg9ryCF7nIivv0hSf3HSimuOQdBxcoaUD9kneTAVNyBEuftuZkl
         jI8GvTl+Q8qU8hCUwoH7dfqJL7uXVl0yUmL8k93DvRsGVvO1lP00ZTPgE9NoRQp25y51
         2I5X1BwS0oU/+1hFr6sGGXcTAfSVCi1yVDvC3W3F9Xu8TufE1zqkoKQFjp67yeK4X88Z
         d8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689100408; x=1691692408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM6aFor2mHBNKooM1VlxcyhT2njFs9JXK/3H1Wp/X/U=;
        b=PKYzHhUPvcYUW8EdZRQKYDphHXzdwQgcm0JDGDXwnKt2aDJatIqyS0LAfJqR3azeqo
         xcxJPXhKPBfDTndMJtZg7aUroDC7xSOTBaoQeBpljKkCqa6B71dpNrFt1tJ2Rr4e6Bzb
         wJWgkYvU6LaTaMhDdWzLUiGAlPVNoVrXV4Zva5YPUj+9JqoItxF5lvILBIVlHq029LGS
         OEwHNLeGEZh1pZWsVJMOPsUGUIZa8LKDQ2R3K9OiBiyu+t5OgDR/TGXNQnX/s1ETWlTt
         Iq5QjBvSaVsDkNKrvT9GoXZpz80SMfpnEmfoAeyurHx0gi6qdTE8IPvStjjDO9tZAI89
         nVrg==
X-Gm-Message-State: ABy/qLaEQg29+kdpNHRSGtDEIZmOC6uqvYAZCEhfWOrbM5oVsy0J8/In
        ok+bL8RpH3x8OynFevGquef3ODR00Lc=
X-Google-Smtp-Source: APBJJlGmxuniK+v3mWWdHT1h3QoeotajaaW+g6E3yY5S6zS4DxTezsnya9MdCqbPmblW91aCeWBs8A==
X-Received: by 2002:aa7:d741:0:b0:51d:f37c:e3b8 with SMTP id a1-20020aa7d741000000b0051df37ce3b8mr16785835eds.13.1689100407968;
        Tue, 11 Jul 2023 11:33:27 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id be25-20020a0564021a3900b00514a5f7a145sm1592563edb.37.2023.07.11.11.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 11:33:27 -0700 (PDT)
Message-ID: <3479e947-76ce-2eb6-8ae0-5360311c5967@gmail.com>
Date:   Tue, 11 Jul 2023 19:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] push: advise about force-pushing as an alternative
 to reconciliation
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com>
 <20230706040111.81110-3-alexhenrie24@gmail.com>
 <82255166-49ac-3c10-1744-27d6d436822e@gmail.com>
 <CAMMLpeSk7_2xn_atUoVeyFSHwE3TNDijSwDMo6PVbvf4XFUvtw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAMMLpeSk7_2xn_atUoVeyFSHwE3TNDijSwDMo6PVbvf4XFUvtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 08/07/2023 19:56, Alex Henrie wrote:
> On Fri, Jul 7, 2023 at 2:49 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> +        "before pushing again, or use 'git push --force' to delete the remote\n"
>>> +        "changes and replace them with your own.\n"
>>
>> I think it would be good to give a bit more context here as to when
>> force pushing is a good idea. For example something like
>>
>>       If you have rebased the branch since you last integrated remote
>>       changes then you can use
>>       'git push --force-with-lease=<branch-ref> --force-if-includes' to
>>       safely replace the remote branch.
>>
>>       If you have deleted and then recreated the branch since you last
>>       integrated remote changes then you can use 'git push +<branch>' to
>>       replace the remote. Note that if anyone else has pushed work to
>>       this branch it will be deleted.
>>
>> It makes the advice longer  but the user get a specific suggestion for
>> their current situation rather than a generic suggestion to delete the
>> remote changes without discussing the implications. In this case we know
>> that it was the current branch that was rejected and so should fill in
>> the branch name in the advice as well.
> 
> Even if we could fill in <branch-ref> automatically, it's too much to
> ask the user to type out --force-with-lease=<branch-ref>
> --force-if-includes.

Can't they just copy and paste the command from the advice message? Even 
if the user does not copy and paste it is not that hard to type it out 
with the benefit of the shell's tab completion. You're basically saying 
this combination of options is unusable in practice because it is too 
much effort to type them. We could look to see if we can make it less 
unwieldy by changing push to allow --force-if-includes=ref imply 
--force-with-lease for instance.

> Mentioning `git push --force` with a fat warning
> about how it only makes sense in a narrow (but common) case would be
> enough to make users aware of it while deterring them from abusing it.

Having a warning in the advice message would definitely help

> The advice already refers the user to the man page for more
> information, which includes a discussion of --force-with-lease and
> --force-if-includes as alternatives to plain --force.

It is good to mention the man page in the advice but we shouldn't assume 
that users will actually go and read it before running the suggested 
command.

>> My main issue with the changes in this series is that they seem to
>> assume the user is (a) pushing a single branch and (b) they are the only
>> person who works on that branch. That is a common but narrow case where
>> force pushing is perfectly sensible but there are many other scenarios
>> where suggesting "push --force" would not be a good idea.
> 
> The goal of the series is not to assume that the user's situation is
> that narrow but common case, but rather to not assume that the user's
> situation is not that case. The most important thing is to make the
> user aware that integration/reconciliation is not the only possible
> way forward.

Thanks for clarifying, that is the sort of thing that should be in the 
commit message.

Best Wishes

Phillip

> Thanks for the feedback,
> 
> -Alex
