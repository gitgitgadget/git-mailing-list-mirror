Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B43C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiKGV7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKGV7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:59:16 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAE6C38
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:59:15 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x18so8070975qki.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCn3tJtsQwx5z83Bx18+tZxbCjCtgZ7WXAzjw12xDM4=;
        b=UyoA/FQT+76M3awTVYZI/IQWmlVzUobX8qIHgooVt2kGop/CDJvwnIHnrtbHSxAZvx
         bT7pVY5cX+nDQgPV7ZFhRK0+SlcMRzXOve+12kZvod1F6F+VK27xqoo8mTDzB+Iqo6IG
         tEjOeBSZYr6hw6FDKmkSoDREhbOyMS/aE0d9zaMtRt0+qW+EAQwI2Bh3AWLaTpkGe+YE
         IuR6nk2qUyCMSVLGAQlPT6bAjWj/KOoPH8uD2zHjN/1wfNJBjK5yMRkufZfF/U5rRdjB
         UJq2bgcA95crBGIaafuR1Wp6ImcvHXh6m3oqWaxv0ADK2DLWtkA+AhOsRYtorBsI+KNM
         g6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCn3tJtsQwx5z83Bx18+tZxbCjCtgZ7WXAzjw12xDM4=;
        b=K/5cKk019t2Jw0hcktIw72L9AQIwP09sC4OddOnrHg+h2pq5//VEWEoVQVwEqlswe5
         P5tPu1iqTyfng4SZne70m9PMy3ROHYH3Mafs5F7OkuJRISoXFRARD/DlpmTWkiu/ekck
         QXwwGRoe5I9JhsxiPNw4+OJJO8XR9MoCMRcU2PSDXb7Puwty7mgS24Z8yIMNrmC0eK8Z
         5pyMULngLGrzUllVqy+1udoc+uyixdDbW6CmhGNBeqjCvMGcH4C1ZNLpSdyUiVYDge/X
         u4g405XobLZ4H577M9zpRfqQpjMGoSPNTF++5CHyYmCGHLVIrxxZLiVA8rF0FqsdyEAx
         6lkg==
X-Gm-Message-State: ACrzQf02EaawXVBPgF91U6QsGCcRiem1qdi8Ui/yF3DVeY0U9KwGgB3m
        tKl9RyHcZMyVbt7/iLw2D9ouqivH7vDKN2o=
X-Google-Smtp-Source: AMsMyM7lFoVbMpHhWcNGfsbNrLIJ5OH37c9uKIXSpHjpku9hMC7Ad7s2RtS1TpA4VFXa4Qdy5eg4RQ==
X-Received: by 2002:a05:620a:2198:b0:6f1:187c:8f79 with SMTP id g24-20020a05620a219800b006f1187c8f79mr767000qka.593.1667858354225;
        Mon, 07 Nov 2022 13:59:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006cbe3be300esm8229047qkp.12.2022.11.07.13.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 13:59:13 -0800 (PST)
Message-ID: <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
Date:   Mon, 7 Nov 2022 16:59:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] ci: avoid unnecessary builds
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
 <Y2liOzOFLyz4uzd0@nand.local>
 <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
 <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/22 4:03 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 07 2022, Derrick Stolee wrote:
> 
>> On 11/7/22 2:53 PM, Taylor Blau wrote:

>>> I wonder how we should treat Ævar's concerns in this thread. I suspect
>>> that the vast majority of workflows wouldn't be affected, but I don't
>>> want to completely break Ævar's workflow, either ;-).
>>>
>>> Some kind of configuration mechanism like I proposed might be nice.
>>> Thoughts?
>>
>> Taking a look at that sub-thread, I have two thoughts:
>>
>> 1. I don't think supporting a "multiple pushes of WIP work"
>>    scenario is a good use of "free" resources. If you want to
>>    test multiple versions of something, then use multiple
>>    branches (and I think Johannes's patch allows concurrent
>>    builds for distinct branch names).
> 
> The setting Taylor proposed in
> https://lore.kernel.org/git/Y2R3vJf1A2KOZwA7@nand.local/ is off by
> default, i.e. it would behave the same way as what Johannes is
> proposing, just give you (well, me) an opt-out from the default, without
> patching main.yml on every branch.
> 
> So it seems like a win-win, why force others to change their workflow?
> Sure, I could push multiple branches, but you could also manually cancel
> your outstanding jobs before re-pushing...
> 
> I agree that cancelling the outstanding job is a better default, and if
> we had to pick one or the other I'd say "sure", but if we can have
> both...

>> Either of these points may have an incorrect assumption, so
>> I'm prepared to be wrong.
> 
> I *think* you're wrong about #2, but I'm not sure either.

At the very least, the configurable option requires fetching the
repo and checking out at least one file. I don't know how much it
actually saves one way or another.
 
> I don't think you can be wrong about #1, "others should change their
> workflow to fit a new worldview" is more of a value-judgment :)

True, but I think that the workflow you are trying to keep valid
is also indistinguishable to the typical flow of force-pushing
during incremental rewrites, so preserving your workflow will
continue to add costs to that behavior.

My value judgement is that experts can adapt their workflows as
situations change for the better of the group.

If the cost of doing the config option version is minimal over
the global concurrency issue, then I say we should go that route.
I just expect it to take up more resources than the strategy
proposed in the initial patch.

I wonder how we could determine this. Should we run a few CI
jobs with some force-pushes in either approach (config turned
off) so we know that cost?

Thanks,
-Stolee
