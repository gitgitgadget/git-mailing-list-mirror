Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1081C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiKVOpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiKVOpS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:45:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C354B0E
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:45:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso11441009wmp.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lvDmoTiMNpOAF7F2rGEjodSA+mxBfFzgeznvedeSVk=;
        b=VrBiSTRqXb+OE5M6kMqRCFp1dZR74Y8j8awi7IMjQOeZnK32B3c07dnTe3rk2Iuy6w
         qUI5yz8A+bn0hyX5sIJAnwuH3sDyctGApOyJBTcwcl3ZCFYz7S5wFRiGjNN2Qv0K58mM
         vFsoXz7zq8SF/uL/eYphBOMvyDWJOpQq4fKfstnSOariPgapp/a9sTD5SIUhJ8+sC+Cv
         ObODvEmPfxN3SIKY1DbhPZmghWucGE/5yWSotG54R9LukwdD2Wy90fACSFaOD5zrKtx2
         rz1XyJCPdE14rry6kgd9X0xXiIZRH57BBq+uyzgxXtBiJhQea+/4Yhq4kUpQ4bjMA8hF
         Rqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lvDmoTiMNpOAF7F2rGEjodSA+mxBfFzgeznvedeSVk=;
        b=mb9BKgwwMl2iygj6W0UJiXr/aRmt9TpzlgAzZtwKoUfLRCKKJ827Pkz5hRxBzT5/o4
         BhDxb6Bo4zVYCDBIh5qPdMAGubR7mN3bnKqatHnw9IZQIGOl9QGACUFceWRK0pahDsyc
         zyC8kWkVogXTvo/hxawD9tCJ1Fjp679SoBJFHudPtiPOUx0QgxVXd3BTVLCD1LifqjlO
         0Zr7v1Y3RCGCV1LJpSDYisnj7YACPYYf8zIirB0upnuyrNM7l3EyNBoIPFiQhX2z4vc0
         C7HP/s6yV/kdKZL+qwkzsSOnJ3eSTmUGBQ3xu6KMnm95qV77UVArWBVK4eRA7wo4/gU4
         /9YA==
X-Gm-Message-State: ANoB5pluk2WFNOIbUIFtj/IKWthn6B/JHtTuyO8I9CEJKhh+Hyh5fIqx
        MvxdT8Eq6NzoUj8zSY4yyj0=
X-Google-Smtp-Source: AA0mqf6ltVssABQnsIg4O2ocV1w6AkXWzDv0+AfTYhoOh6AXXFrP589vUYAM7yqknnFMMHCoKiphLg==
X-Received: by 2002:a1c:7504:0:b0:3cf:6b10:ca8d with SMTP id o4-20020a1c7504000000b003cf6b10ca8dmr20529084wmc.44.1669128315709;
        Tue, 22 Nov 2022 06:45:15 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003cfbe1da539sm17107421wmc.36.2022.11.22.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:45:15 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b1ac730b-b4bd-3045-ce3b-1e5d9aca169a@dunelm.org.uk>
Date:   Tue, 22 Nov 2022 14:45:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
 worktrees
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
 <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
 <20221119034728.m4kxh4tdpof7us7j@phi>
In-Reply-To: <20221119034728.m4kxh4tdpof7us7j@phi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/11/2022 03:47, Jacob Abel wrote:
> On 22/11/17 11:00AM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Tue, Nov 15 2022, Eric Sunshine wrote:
>>
>>> On Thu, Nov 10, 2022 at 6:32 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
>>>> While working with the worktree based git workflow, I realised that setting
>>>> up a new git repository required switching between the traditional and
>>>> worktree based workflows. Searching online I found a SO answer [1] which
>>>> seemed to support this and which indicated that adding support for this should
>>>> not be technically difficult.
>>>>
>>>>    * adding orphan branch functionality (as is present in `git-switch`)
>>>>      to `git-worktree-add`
>>>
>>> I haven't had a chance yet to read v3, but can we take a step back for
>>> a moment and look at this topic from a slightly different angle?
>>> Setting aside the value of adding --orphan to `git worktree add`
>>> (which, I'm perfectly fine with, as mentioned earlier), I have a
>>> question about whether the solution proposed by this series is the
>>> best we can do.
>>>
>>> As I understand it, the actual problem this series wants to solve is
>>> that it's not possible to create a new worktree from an empty bare
>>> repository; for instance:
>>>
>>>      % git init --bare foo.git
>>>      % git -C foo.git worktree add -b main bar
>>>      Preparing worktree (new branch 'main')
>>>      fatal: not a valid object name: 'HEAD'
>>>      %
>>>
>>> This series addresses that shortcoming by adding --orphan, so that the
>>> following works:
>>>
>>>      % git init --bare foo.git
>>>      % git -C foo.git worktree add --orphan main bar
>>>      Preparing worktree (new branch 'main')
>>>      %
>>>
>>> However, is this really the best and most user-friendly and most
>>> discoverable solution? Is it likely that users are somehow going to
>>> instinctively use --orphan when they see the "fatal: not a valid
>>> object name: 'HEAD'" error message?
>>>
>>> Wouldn't a better solution be to somehow fix `git worktree add -b
>>> <branch>` so that it just works rather than erroring out? I haven't
>>> delved into the implementation to determine if this is possible, but
>>> if it is, it seems a far superior "fix" for the problem shown above
>>> since it requires no extra effort on the user's part, and doesn't
>>> raise any discoverability red-flags (since nothing needs to be
>>> "discovered" if `-b <branch>` works as expected in the first place).
>>>
>>> If fixing `-b <branch>` to "just work" is possible, then --orphan is
>>> no longer a needed workaround but becomes "icing on the cake".
>>
>> That's a really good point, and we *could* "fix" that.
>>
>> But I don't see how to do it without overloading "-b" even further, in a
>> way that some users either might not mean, or at least would be
>> confusing.
>>
>> E.g. one script "manually clones" a repo because it does "git init",
>> "git remote set-url", "git fetch" etc. Another one makes worktrees from
>> those fresh checkouts once set up.
>>
>> If we "DWYM" here that second step will carry forward the bad state
>> instead of erroring early.

Wouldn't the first script error out if there was a problem?

>> I haven't fully thought this throuh, so maybe it's fine, just
>> wondering...
>>
>> ...an alternate way to perhaps to do this would be to detect this
>> situation in add(), and emit an advise() telling the user that maybe
>> they want to use "--orphan" for this?
>>
> 
> Prior to writing this patch, I tried to determine if there was a succinct way
> to make `-b` "just work" however I wasn't able to find one that wouldn't
> introduce unintuitive behavior.

Can you say a bit more about what the unintuitive behavior was? As I 
understand it the problem is that "git branch" errors out when HEAD is a 
symbolic ref pointing to a ref that does not exist. I think we can use 
read_ref() to check for that before running "git branch" and act 
accordingly. We might want to check if HEAD matches init.defaultBranch 
and only do an orphan checkout in the new worktree in that case.

> My conclusion was that it was probably best
> to break it out into a separate command as the other tools had.
> 
> I'd support adding an `advise()` for at least the basic case where you try to
> create a worktree and no branches currently exist in the repository.
> i.e. something like this:
> 
>      % git init --bare foo.git
>      % git -C foo.git branch --list
> 
>      % git -C foo.git worktree add foobar/
>      hint: If you meant to create a new initial branch for this repository,
>      hint: e.g. 'main', you can do so using the --orphan option:
>      hint:
>      hint:   git worktree add --orphan main main/
>      hint:
>      fatal: invalid reference: 'foobar'
> 
> and
> 
>      % git init --bare foo.git
>      % git -C foo.git --no-pager branch --list
> 
>      % git -C foo.git worktree add -b foobar foobardir/
>      hint: If you meant to create a new initial branch for this repository,
>      hint: e.g. 'main', you can do so using the --orphan option:
>      hint:
>      hint:   git worktree add --orphan main main/
>      hint:
>      fatal: invalid reference: 'foobar'
> 
> but not in the following circumstances:
> 
>      % git init --bare foo.git
>      % ...
>      % git -C foo.git --no-pager branch --list
>      + foo
>        bar
>      % git -C foo.git worktree add foobar/
>      Preparing worktree (new branch 'foobar')
>      HEAD is now at 319605f8f0 This is a commit message
> 
> or
> 
>      % git init --bare foo.git
>      % ...
>      % git -C foo.git --no-pager branch --list
>      + foo
>        bar
>      % git -C foo.git worktree add -b foobar foobardir/
>      Preparing worktree (new branch 'foobar)
>      HEAD is now at 319605f8f0 This is a commit message
> 
> Would there be any other circumstances where we'd definitely want an `advise()`?
> Generally I'd assume that outside of those two circumstances, most users will
> rarely intend to make an orphan without already knowing they absolutely need to
> make an orphan.

I don't think it matters if the repository is bare so I think it would 
be good to advise() on

	% git init foo
	% git -C foo worktree add bar

Best Wishes

Phillip
