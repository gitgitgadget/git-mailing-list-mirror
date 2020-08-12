Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E482AC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4922065C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 11:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPTFySG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHLLs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLLs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 07:48:58 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93952C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 04:48:58 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v13so1507713oiv.13
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mdVHmHwiEdZQjkztYEbxGZiiFvd3GEgxfJ5/E4W7TRc=;
        b=uPTFySG7MOUe7hwukMZB44sxRKvDu1koSmS3nX+f9KguPkmB/ur8E/nufqJrx/YKpD
         o+36A2jHLz1PeLhv4UxGAejDCf1wbdRlpF1ryFlc+4J3RVGE7QcklTlPAhiZ8m0D0G4E
         E8IUC/NL1n4BzasKp+aY7O7+NoaWUMq+F1zzNuQ8PEVylXfgQwe/2QPc/YwDlojHnxbQ
         2w+iCTpnUN7Yk0ZV7SvtU504eFSipqpjnjHp4TTR+9ESIvDiLxCvu4XIbPvr67dDwM8+
         Wf9QYb/lB7hYN9F8FhQNGUnoJXmsEKNFl72OV3WpmaOZgmdqkAa9jXdPNmHo/tDoT8b5
         lvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mdVHmHwiEdZQjkztYEbxGZiiFvd3GEgxfJ5/E4W7TRc=;
        b=s4YB/hZOAQYQUUvA9QBkFSo4Pzlu4rytDo6Ape5LZSHPqxZcu1Vi08Ey14Qm1JcQTX
         f5E2PzGN6wcikO1o7K/YAUSHQm/d8c9zM9sxldeYfhTAh6ENSkxuxwBO3PHo5yuuoS2w
         avliBqmmwoSyuQDZfp3poxcsbDwifkKUXgPT05zKnXRMQygVhR5RfuowHh2wckeTzHix
         6i+MJEgBBgxkXxpkpSN3OFVOHIQvnmcYUeZX1MRiHpcoB+i0E1pVpZWNPjtn7cHxSrbT
         NrIvSgX12wSQMcXG2z8uJyUpJMfDue7WuREFOtsXbzbh0hzI5qDE24rVGRl7AFcaS8yy
         3M/Q==
X-Gm-Message-State: AOAM532UsMdxXBjWmkeps73n+Dw0kH8xXxvGzuZsx0/l6GRoPDg8t9d4
        BG1C0ELjaJrBY438w53sJ/g=
X-Google-Smtp-Source: ABdhPJxv91KpfNBup5ZBbPw4JvrQV35hRfWU7n0lW0TTYxrY9636xhZ7r0EIbxs8Bt4a07u4Blh77A==
X-Received: by 2002:aca:a88e:: with SMTP id r136mr7307138oie.110.1597232937777;
        Wed, 12 Aug 2020 04:48:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14? ([2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14])
        by smtp.gmail.com with ESMTPSA id m21sm378939otr.36.2020.08.12.04.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 04:48:56 -0700 (PDT)
Subject: Re: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
 <20200811211830.GS2898@szeder.dev> <20200811212118.GA66447@syl.lan>
 <20200811212716.GA13422@szeder.dev> <20200811213411.GB66656@syl.lan>
 <20200811235537.GC13422@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d525c35e-12fb-1918-c02b-d0323ee9b664@gmail.com>
Date:   Wed, 12 Aug 2020 07:48:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200811235537.GC13422@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2020 7:55 PM, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 05:34:11PM -0400, Taylor Blau wrote:
>> On Tue, Aug 11, 2020 at 11:27:16PM +0200, SZEDER Gábor wrote:
>>> On Tue, Aug 11, 2020 at 05:21:18PM -0400, Taylor Blau wrote:
>>>> On Tue, Aug 11, 2020 at 11:18:30PM +0200, SZEDER Gábor wrote:
>>>>> On Tue, Aug 11, 2020 at 04:51:19PM -0400, Taylor Blau wrote:
>>>>>> Many places in the code often need a pointer to the commit-graph's
>>>>>> 'struct bloom_filter_settings', in which case they often take the value
>>>>>> from the top-most commit-graph.
>>>>>>
>>>>>> In the non-split case, this works as expected. In the split case,
>>>>>> however, things get a little tricky. Not all layers in a chain of
>>>>>> incremental commit-graphs are required to themselves have Bloom data,
>>>>>> and so whether or not some part of the code uses Bloom filters depends
>>>>>> entirely on whether or not the top-most level of the commit-graph chain
>>>>>> has Bloom filters.
>>>>>>
>>>>>> This has been the behavior since Bloom filters were introduced, and has
>>>>>> been codified into the tests since a759bfa9ee (t4216: add end to end
>>>>>> tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
>>>>>> requires that Bloom filters are not used in exactly the case described
>>>>>> earlier.
>>>>>>
>>>>>> There is no reason that this needs to be the case, since it is perfectly
>>>>>> valid for commits in an earlier layer to have Bloom filters when commits
>>>>>> in a newer layer do not.
>>>>>>
>>>>>> Since Bloom settings are guaranteed to be the same for any layer in a
>>>>>> chain that has Bloom data,
>>>>>
>>>>> Is it?  Where is that guaranteed?

Perhaps instead of "guaranteed" we could say "Git never writes
a commit-graph chain with different settings between layers."

>>>> There is no mechanism whatsoever to customize these settings that is
>>>> exposed to the user (except for the undocumented 'GIT_TEST' environment
>>>> variables).
>>>
>>> Let me rephrase it, then: where is it written in the commit-graph
>>> format specification that these must be the same in all layers?
>>>
>>> Nowhere.
>>
>> OK. We can certainly document that this is the case.
> 
> IMO we absolutely must document this first; ideally it should have
> been carefully considered and documented right from the start.

You're right. One of the major difficulties in bringing a Bloom
filter implementation to the commit-graph feature when we did was
that the split commit-graph was introduced between our initial
prototypes and when it was finally prepared for a full submission.

There certainly are gaps in the implementation and documentation.
I think Taylor is doing a great job by addressing one of those gaps
in a focused, thoughtful way.

> Some thougths about this:
> 
>   https://public-inbox.org/git/20200619140230.GB22200@szeder.dev/

I appreciate your attention to detail. Your comments on the existing
implementation do point out some of its shortcomings, and that is a
valuable contribution.

Actually converting those thoughts into patches is a lot of work.

>> For this purpose,
>> all we really care about is that the graph _has_ Bloom filters anywhere.
>> If you wanted to return the exact matching settings, you could also
>> provide a commit and return the settings belonging to the graph that
>> contains that commit.
>>
>> In the case where we don't have a commit, we could use the default
>> settings instead.
>>
>> I think that we are a little bit dealing with a problem that doesn't
>> exist, since we do not document the sole method by which you would
>> change these settings. So, maybe we can think more about this, but my
>> preference would be to leave this patch alone.
> 
> Other implementations can write split commit-graphs with modified path
> Bloom filters as well, and at the moment there is nothing in the specs
> that tells them not to use different Bloom filter settings in
> different layers.

You are 100% correct that there is a gap in documentation. That should
be corrected at some point. (I don't consider it a blocker for this
series.)

But also: Git itself is the true test of a "correct" third-party
implementation. libgit2 and JGit try to match Git, "warts and all".
If another implementation wrote data that results in incorrect
behavior by Git, then that implementation is wrong.

Improving documentation can make those errors less likely.

We also must design with "future Git" in mind, presenting it with
enough flexibility to improve formats. The custom Bloom filter
settings do allow that flexibility, but the requirement that all
layers have identical settings exists for a reason (despite not
being documented). It is important that any commit walk that intends
to use the changed-path Bloom filters can compute the bloom keys
for the test paths only once.

Thanks,
-Stolee
