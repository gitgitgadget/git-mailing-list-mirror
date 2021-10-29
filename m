Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA766C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5AC6115C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhJ2LVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhJ2LVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 07:21:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F1C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 04:18:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so37782107edc.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+6rx3/52FNpCgrND2n0l8rEwlW8nVVhZzEIiCEdTdt0=;
        b=bI1epUbZ9+2Jo+djRGbWmAheE23zDtkz2EH/aElryrd62E4zy1KEn1BrGnTRd43/8U
         LC13gaMErRALkEvIh5OUM10ycZyvtRj0uenMdIh6Dx+uZ9SDQ6xVIK35xdJns64LW5m2
         a0Tzs7gFrvAuBOzb9N9P4xZ/qVFWPLrYEclh47UKM/Bu91zOx5W6XgCblykBqpEksYUm
         J57pXZbtdTltOyXxOlIV0QNCFny8uDaIgP8PzpyGb8O6yLMy/OhCf+puDsU0wu1nMr41
         CtUyI40zFUqcoXpIZzdMWA7muBHh6Tb4O6LhLDpoNnwDrXtxiPA3C6/ieuPQpcjmxQI3
         7wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+6rx3/52FNpCgrND2n0l8rEwlW8nVVhZzEIiCEdTdt0=;
        b=ZnY3bBkmvQLorVGi/2dOtI7AD/t2tpXhclq1muVwxoFWvj5NxWUCgckgYpPdJawzVH
         FfkIK4+1iew5HEMx0heoyKGYnrgBMGzH94lU7vRHg6TruL2YSGFgMH1URw3mSrz56D9L
         +DkjLBqCONG/d6DNvlNtTR1lHVUlhbLZfeh4aIcXsfrEDa58ZmgTUFOuE1rco+UaJYpq
         HUz5wKFWtrsQFbuHFBMx3tAJsOommBI2c2AivfoFpi5r136Q8KGvyZyhD/Yx0ZUMw2BV
         Duq/8SENEj+AGHokFQlw/82VIGxAohjmhsqm0KQEJ+VzXeo25Fouv75d7DJ/yW3JqgsQ
         lLjg==
X-Gm-Message-State: AOAM530fcnFLYX44Gn5I9ILXeZzI6ZyCQ3sLUFKKYJUw5jtC0bx9Lqap
        iDxTvaAgfTtRC8F/0oCfvROwof5+L5lX7Q==
X-Google-Smtp-Source: ABdhPJxcjzROVZh3YKEE7/Au48+fn77ehtHkfkEJGCyD/pAUn9CLRhBpqBCDubNT5unr+MwIRkbUGQ==
X-Received: by 2002:a17:906:1db2:: with SMTP id u18mr12744375ejh.227.1635506331355;
        Fri, 29 Oct 2021 04:18:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hv11sm2282706ejc.24.2021.10.29.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:18:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgPuM-0024of-HV;
        Fri, 29 Oct 2021 13:18:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 01/15] diff --color-moved: add perf tests
Date:   Fri, 29 Oct 2021 13:06:15 +0200
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
 <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
 <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1635336262.git.gitgitgadget@gmail.com>
 <xmqqsfwkq1h4.fsf@gitster.g>
 <b6f57fc3-75d9-d7d5-7153-28dde066a101@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <b6f57fc3-75d9-d7d5-7153-28dde066a101@gmail.com>
Message-ID: <211029.86zgqs3wpx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Phillip Wood wrote:

> Hi Junio
>
> On 28/10/2021 22:32, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Add some tests so we can monitor changes to the performance of the
>>> move detection code. The tests record the performance of a single
>>> large diff and a sequence of smaller diffs.
>> "A single large diff" meaning...?
>
> The diff of two commits that are far apart in the history so have lots
> of changes between them
>
>>> +if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
>>> +then
>>> +	skip_all='skipping because tag v2.29.0 was not found'
>>> +	test_done
>>> +fi
>> Hmph.  So this is designed only to be run in a clone of git.git with
>> that tag (and a bit of history, at least to v2.28.0 and 1000 commits)?
>> I am asking primarily because this seems to be the first instance of
>> a test that hardcodes the dependency on our history, instead of
>> allowing the tester to use their favourite history by using the
>> GIT_PERF_LARGE_REPO and GIT_PERF_REPO environment variables.
>
> p3404-rebase-interactive does the same thing. The aim is to have a
> repeatable test rather than just using whatever commit HEAD happens to 
> be pointing at when the test is run as the starting point, if you have
> any ideas for doing that another way I'm happy to change it.

I don't know if it's worth it here, but the following would work:

 1. List all tags in the repository, sorted in reverse order, so e.g.:

    git tag -l 'v*.0' --sort=version:refname

    (The glob can be configurable as an env variable, or we could fall
    back)

 2. Go down that list and find the first pair that matches some limit, I
    think say the first "major" release with 500 commits would qualify

 3. Make it a GIT_PERF_LARGE_REPO test

We've got some perf tests that do similar things. I think you'd find
that with something like this you should able to hand the perf test a
path to git.git, or linux.git, and probably any "major" repository" as
long as it follows a common "we tag our releases at some interval"
pattern.

Or perhaps more simply:

 1. Note the number of commits in the history, per "git rev-list HEAD |
    wc -l" 2.

 2. Then round that down to the nearest 10^x, so for a 250k commit
   repository round down to 100k and diff say the 90k..100kth commits,
   for git.git which has 60k that would be 10k, and the diff is commits
   9k..10k..

It means you'll get a "bump" eventually when say git.git crosses 100k
commits, but it will prorably be stable for any measurement anyone cares
to do, and means that you can get "realistic" measurements for diffing a
big chuck on of history from anything from a tiny repository with >=10
commits, to something truly gargantuan where you'd end up diffing say
900k..1m.
     

