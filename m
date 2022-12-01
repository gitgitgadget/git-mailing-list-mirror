Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49E2C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 20:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiLAUTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiLAUTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 15:19:03 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4591B2746
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 12:19:00 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l127so3235737oia.8
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nf3qVzlpOxCb780xY2/mnOYMlBykcBdy4i0yvdRsoI=;
        b=JnC50WFNKdQOxQBJLnc0ju2grdYsaFv/Zt/WP55z3F3UZlvM1BPl/TLWHcVdRmypYp
         nmNRU13D5JJ48s6yXyREGPAfXmGu02sRjsUGA9xL4dEIZeh7i09Zxzlg4Zbsm3PX9NOu
         5pDvJhHcDieysNj8jWz6iTPwTi+STacYg5U93xWiHx0LIZ5dwvT2fERhLy/9p32OzM7m
         gAVXYdJE50YpeaQWZ1g0cxRdTqZg4RAE9O0T2GeBVSv0xigx3yDjzK+tzRANbF/7JnYD
         kdySG4v+gApEC9xM7rJgtS5NJ5q296nxuanJYFm5M7Yxp5Kz0pKnWYZBO9Dw1YSRRDBQ
         8U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nf3qVzlpOxCb780xY2/mnOYMlBykcBdy4i0yvdRsoI=;
        b=6nqo15MGVqmg0PvDiNwKing5W6VtmrkQud3BxLGtdk/5imXm9U0zVAi7RCXBGfWcvr
         Xv3KO5Lv20KYrciyNe0wCSQqwvkjPoCgie5kv+kFYyqfscVqVI3sJXQeX4oiUGtNSDVd
         EAO5K7rnmI0HR5Kr3CW+lCLhtiHecK3GemdJg8HzBVN6OQ6mNPPWcGScL01wFZXQ875j
         hfoMb0c53biHHg7QJX/xmwgDQ/ie4olYqtCetaZCIGV3D9E/G43mJ3oJpSwOcmJuGaVz
         xYQ2En80d9CJGSYNO9sR0hFsVWmGmSSP+nnVRHufUOqshVB+jAOC8QwEHX9hXzQyoUuj
         yjwg==
X-Gm-Message-State: ANoB5pmlodOsBg1xmY1g6ufoCnCiBQ5TMtNPsiKuTdsqtZhitc8QHGGd
        /R1hw16wa+KsWfQf9yuKFRGX
X-Google-Smtp-Source: AA0mqf4P7/zPEtUA02i9wnrwkDkWaNhuGWuUJT93oXlXlHeM/nW8UZDi2b8PjUM7lI1k7MWXG8rjMA==
X-Received: by 2002:a05:6808:1812:b0:354:4bcd:3f53 with SMTP id bh18-20020a056808181200b003544bcd3f53mr27593641oib.135.1669925939887;
        Thu, 01 Dec 2022 12:18:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1df2:a53f:2e5b:c383? ([2600:1700:e72:80a0:1df2:a53f:2e5b:c383])
        by smtp.gmail.com with ESMTPSA id g1-20020a056830308100b006618e23df48sm2517616ots.39.2022.12.01.12.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 12:18:59 -0800 (PST)
Message-ID: <f5370fec-d517-eaa9-8e16-82fa20ac8532@github.com>
Date:   Thu, 1 Dec 2022 15:18:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
 <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
 <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30/2022 1:30 PM, Han-Wen Nienhuys wrote:
> On Wed, Nov 30, 2022 at 4:16 PM Derrick Stolee <derrickstolee@github.com> wrote:
>> (Note: there is a strategy that doesn't need this approach, but it's a bit
>> complicated. It would involve rotating all replicas to new repositories
>> that are configured to use reftable upon creation, getting the refs from
>> other replicas via fetches. In my opinion, this is prohibitively
>> expensive.)
> 
> I'm not sure I understand the problem. Any deletion of a ref (that is
> in packed-refs) today already requires rewriting the entire
> packed-refs file ("all or nothing" operation). Whether you write a
> packed-refs or reftable is roughly equally expensive.
> 
> Are you looking for a way to upgrade a repo, while concurrent git
> process may write updates into the repository during the update? That
> may be hard to pull off, because you probably need to rename more than
> one file atomically. If you accept momentarily failed writes, you
> could do
> 
> * rename refs/ to refs.old/ (loose ref writes will fail now)
> * collect loose refs under refs.old/ , put into packed-refs
> * populate the reftable/ dir
> * set refFormat extension.
> * rename refs.old/ to refs/ with a refs/heads a file (as described in
> the reftable spec.)
>
> See also https://gerrit.googlesource.com/jgit/+/ca166a0c62af2ea87fdedf2728ac19cb59a12601/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/FileRepository.java#734

Yes, I would ideally like for the repository to "upgrade" its ref
storage mechanism during routine maintenance in a non-blocking way
while other writes and reads continue as normal.

After discussing it a bit internally, we _could_ avoid the "rotate
the replicas" solution if there was a "git upgrade-ref-format"
command that could switch from one to another, but it would still
involve pulling that replica out of the rotation and then having
it catch up to the other replicas after that is complete. If I'm
reading your draft correctly, that is not currently available in
your work, but we could add it after the fact.

Requiring pulling replicas out of rotation is still a bit heavy-
handed for my liking, but it's much less expensive than moving
all of the Git data.

>> The reason to start with this step is that the benefits and risks are
>> clearly understood, which can motivate us to establish the mechanism for
>> changing the ref format by defining the extension.
> 
> I believe that the v2 format is a safe change with performance
> improvements, but it's a backward incompatible format change with only
> modest payoff. I also don't understand how it will help you do a stack
> of tables,
> which you need for your primary goal (ie. transactions/deletions
> writing only the delta, rather than rewriting the whole file?).

The v2 format doesn't help me on its own, but it has other benefits
in terms of size and speed, as well as the "ref count" functionality.

The important thing is that the definition of extensions.refFormat
that I'm proposing in this RFC establishes a way to make incremental
progress on the ref format, allowing the stacked format to come in
later with less friction.
 
>> * The reftable is currently fundamentally different enough that it could
>>   not be used as a replacement for the packed-refs file underneath loose
>>   refs (primarily due to its integration with the reflog). Doing so would
>>   require significant work on top of your prototype.
> 
> It could, but I don't see the point.

My point is that we can upgrade repositories by replacing packed-refs
with reftable during routine maintenance instead of the heavier
approaches discussed earlier.

* Step 1: replace packed-refs with reftable.
* Step 2: stop writing loose refs, only update reftable (but still read loose refs).
* Step 3: collapse all loose refs into reftable, stop reading or writing loose refs.
 
>> I'm going to take the following actions on my end to better understand the
>> situation:
>>
>> 1. I'll take your draft PR branch and do some performance evaluations on
>>    the speed of ref updates compared to loose refs and my prototype of a
>>    two-stack packed-ref where the second layer of the stack is only for
>>    deleted refs.
> 
> (tangent) - wouldn't that design perform poorly once the number of
> deletions gets large? You'd basically have to rewrite the
> deleted-packed-refs file all the time.
 
We have regular maintenance that is triggered by pushes that rewrites
the packed-refs file frequently, anyway. The maintenance currently is
blocked on the amount of time spent repacking object data, so a large
number of ref updates can come in during this process. (That maintenance
step would collapse the deleted-refs layer into the base layer.)

I've tested a simple version of this stack that shows that rewriting the
file with 1,000 deletions is still within 2x the cost of updating a loose
ref, so it solves the immediate problem using a much simpler stack model,
at least in the most-common case where ref deletions are less frequent
than other updates. Even if the size outgrew the 2x cost limit, the
deleted file is still going to be much smaller than the base packed-refs
file, which is currently rewritten for every deletion, so it is still an
improvement.

The more complicated stack model would be required to funnel all ref
updates into that structure and away from loose refs.

Thanks,
-Stolee
