Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0718BC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF23720829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOFH+7NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgG3N7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgG3N7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 09:59:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E5C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:59:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so21512422qkf.10
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7vyk8enPI3gwr2ZHpGPyAUheqmL92CxjWlmxUk1rkM=;
        b=fOFH+7NPXZRhgzwwOaA9enjgaFmX9+pPNHBRO0ZSJ9T9GX05YW+doGt0l0yvDxiQ2J
         JKwJWMbptn9CmZu8nHONe8MWILqe724OEbg+xJTYIfLCrntXU4YJzfJUUIjVpol/JCmM
         yvA+uckH/AWpgNNC/tWKMGg+l3ZO2VC4ybixed/ALisGrL+XxO2MHzweWROmU/hPZXOg
         GP28lj2wR4g39JBdPt74zV4xiXY6lZOkQi8E6KePyoQpgowldRvIT0L0l3MD6Q6VA6aq
         PEbTP8GVOIDGmSTPZ5EdxF/iX+UV63FP8KYtRdZkgmEPT7wBcUffMtsjPxtYpBLkobQN
         De+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7vyk8enPI3gwr2ZHpGPyAUheqmL92CxjWlmxUk1rkM=;
        b=Kiv9YMQ/xjGmnApfvOaZG3P2jATkzt0mMpKMi0XlyKg2GgiwyPieyEukpcmDHnbpvP
         Ul4j8lR11MHO7KhyX+scxM6SGFc9gwjclQm674h2SaPJyK2aKfYfeYpqRi4asdAMvQV2
         2r0gpvM5HX4+wr5HapR1ujKlC+FW/jVcqx/Ur0yVeGbfGvuHkfkp+4comvLPfcvW421S
         ki4ubw04+wIpzi4q3neG7hs8WVRMNkWG7ZCMlHXjqMvrmfzDbYT2ZYA1Bc1ebsFtUZ0c
         qn6Aiz5xQbOBSV+QQ9I+fSTVn2xL7UVycKbGC6c/S6EYpsnMYLN0u4KlfRNft3Qlb8Wx
         Aw1g==
X-Gm-Message-State: AOAM532907ptk2Jo9C7YN5u78lGO4Ozzou/nvtDrdoeI7R85SB9lLHUY
        fWrl2JxRb3yopvOsyxYMdFWvOxBw8fITIw==
X-Google-Smtp-Source: ABdhPJw0wI+rGwQTKNkMuB9nBGXfPAfrj8qNbNd8T6L6h4rwgjM4FfKUvO5bLYiOZn9xjPI0BOVZjA==
X-Received: by 2002:a37:e110:: with SMTP id c16mr37132528qkm.243.1596117563202;
        Thu, 30 Jul 2020 06:59:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id f4sm4356776qtp.38.2020.07.30.06.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:59:22 -0700 (PDT)
Subject: Re: [PATCH v2 05/18] maintenance: add commit-graph task
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <04552b1d2ed751a11eb7c50f6898cbc078b552b4.1595527000.git.gitgitgadget@gmail.com>
 <xmqq4kpyq8wh.fsf@gitster.c.googlers.com>
 <b0bc5d89-52fa-e0f4-e3af-5eb6c76d312e@gmail.com>
 <xmqqy2n8lmq3.fsf@gitster.c.googlers.com> <20200725015240.GD35171@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b20e2e46-ff71-b84f-19da-9d8873ef08c3@gmail.com>
Date:   Thu, 30 Jul 2020 09:59:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <20200725015240.GD35171@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/24/2020 9:52 PM, Taylor Blau wrote:
> On Fri, Jul 24, 2020 at 12:47:00PM -0700, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> But you are discussing here how the _behavior_ can change when
>>> --auto is specified. And specifically, "git gc --auto" really
>>> meant "This is running after a foreground command, so only do
>>> work if necessary and do it quickly to minimize blocking time."
>>>
>>> I'd be happy to replace "--auto" with "--quick" in the
>>> maintenance builtin.
>>>
>>> This opens up some extra design space for how the individual
>>> tasks perform depending on "--quick" being specified or not.
>>> My intention was to create tasks that are already in "quick"
>>> mode:
>>>
>>> * loose-objects have a maximum batch size.
>>> * incremental-repack is capped in size.
>>> * commit-graph uses the --split option.
>>>
>>> But this "quick" distinction might be important for some of
>>> the tasks we intend to extract from the gc builtin.
>>
>> Yup.  To be honest, I came to this topic from a completely different
>> direction.  The field name "auto" alone (and no other field name)
>> had to have an extra cruft (i.e. "_flag") attached to it, which is
>> understandable but ugly.  Then I started thinking if 'auto(matic)'
>> is really the right word to describe what we want out of the option,
>> and came to the realization that there may be better words.
> 
> I wonder what the quick and slow paths are here. For the commit-graph
> code, what you wrote here seems to match what I'd expect with passing
> '--auto' in the sense of running 'git gc'. That is, I'm leaving it up to
> the commit-graph machinery's idea of the normal '--split' rules to
> figure out when to roll up layers of a commit-graph, as opposed to
> creating a new layer and extending the chain.

I had intended all of my new tasks to be the "quick" version of their
operations. The "slow" version would abandon hope of doing a small
amount of work to create the best possible world for the repository.
This would include:

 * The commit-graph would collapse all layers into one file.
 * The multi-pack-index repack would rewrite all object data into one
   pack-file.
 * The loose-objects task would not stop at a maximum number of loose
   objects (and would probably want to repack everything, anyway).

I'm open to making this possibility more explicit by renaming "--auto"
and just performing a translation to 'git gc --auto'. So, what should
the name be? Here are a few options to consider:

 --quick
 --fast
 --limited
 --incremental
 -O[0|1|2...] (think GCC optimization flags, exposing granularity)
 --[non-]aggressive

Regardless, this makes me rethink that the --[no-]maintenance option
from PATCH 03/18 is better than --[no-]auto-maintenance, since we are
really saying "run _some_ maintenance or _no_ maintenance" and the "how"
of the maintenance is left intentionally vague. I've already made the
change locally to add "auto-" so I'll wait for confirmation before
reverting that change.

> So, I think that makes sense if the caller gave '--auto'. But, I'm not
> sure that it makes sense if they didn't, in which case I'd imagine
> something quicker to happen. There, I'd expect something more like:
> 
>   1. Run 'git commit-graph write --reachable --split=no-merge'.
>   2. Run 'git commit-graph verify'.
>   3. If 'git commit-graph verify' failed, drop the existing commit graph
>      and rebuild it with 'git commit-graph --reachable --split=replace'.
>   4. Otherwise, do nothing.
> 
> I'm biased, of course, but I think that that matches roughly what I'd
> expect to happen in the fast/slow path. Granted, the steps to rebuild
> the commit graph are going to be slow no matter what (depending on the
> size of the repository), and so in that case maybe the commit-graph
> should just be dropped. I'm not really sure what to do about that...

I think this approach is the best we can do given the current behavior
inside the commit-graph builtin. Perhaps in the future we could change
the commit-graph builtin to include a "--verify" option so it could do
the "git commit-graph verify --shallow" on the new layer before committing
the new commit-graph-chain file and expiring old layers. That way, we
would not need to delete and rewrite the whole thing when there is a
problem writing the top layer.

>>> Since the tasks are frequently running subcommands, returning
>>> 0 for success and non-zero for error matches the error codes
>>> returned by those subcommands.
>>
>> As long as these will _never_ be called from other helper functions
>> but from the cmd_foo() top-level and their return values are only
>> used directly as the top-level's return value, I do not mind too
>> much.
>>
>> But whenever I am writing such a code, I find myself not brave
>> enough to make such a bold promise (I saw other people call the
>> helpers I wrote in unintended ways and had to adjust the semantics
>> of them to accomodate the new callers too many times), so I'd rather
>> see the caller do "return !!helper_fn()" to allow helper_fn() to be
>> written more naturally (e.g. letting them return error(...)).

I will try to be consistent here with the behavior:

 * 0 is success
 * 1 is failure

Which is what I think you are implying by "return !!helper_fn()".

Thanks,
-Stolee
