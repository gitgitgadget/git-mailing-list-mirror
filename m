Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC8E1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJEUok (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:44:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35638 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbeJEUok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:44:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id v68-v6so904105qka.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Eu8iOUqpGftijiTMOtSI65KWri2KrKQWW1jYpzrWoUU=;
        b=FI8AF++Uzw6MFNDx8kSas13FmWqpsO6jUL2mxQMQcFS8ZiAGTgtfwKsmDAJOYP9m3Z
         Jm/pQJU+SktfMr+4uFm2DQ4L3Zj/woCPz7xzJGw4i81qLAyLAF2aGNhkgsENu9/EYXYj
         z5lJRxK/OAMfsWhBodlMM/ye9sa2EA832hSLZNvsg2lhbiSe5S2sChZfRljuPJLQxGKV
         U06QCeD7aDGf/R3M6+RcHYWeCAAqAslZ7uMbulkueTsZxbMx5v0i42hQ5PMHB2BxS+TU
         /+mXFbOEfxlcKIUPPAw2werVUVI1lzH7yz6X9C+kqMyc1IDjnPzeCgwibiICj6zNQYTN
         VwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Eu8iOUqpGftijiTMOtSI65KWri2KrKQWW1jYpzrWoUU=;
        b=AdCRHjtHN9BVMrhhbCzQqP40QGA3sA/R7pQo4/LsXfCtcgSI3Xnw10+qPSR5lmKvZl
         UVpumWO9jRNFG3FYeRZ9BAbsHD2VV1wusv5m47sOEhEEC1pYSFupRPHzG+tc8lgFsg9t
         nroFqLiCclk3MvgW++ef94UFY903l1OcsVJFiikuC0it2MpqwZjc3ZvHGd2k7JTFwbqY
         8wCoYxcHDJQhld0wFkuL8DO1PO5ulHhKPE7xrpWPk1AzItIhovOaloCz8laFpeTFKGTL
         eBDOPqbX5+sSkx+/jWCqEvpzdceetVqiRzKO4n/mgMDEFbq8Qa2iEXAtD3OHM/rswxve
         DqTQ==
X-Gm-Message-State: ABuFfoj7311pK+1bIdosnqn1N0xR1Etb3vy5ZaO8Sa40Uqmz60gHudpL
        Sa4fApyg5wcOuIKzbTj3BIWRe515
X-Google-Smtp-Source: ACcGV62ri2NOHk+SOuXne91hlJI21AVa+7772Z6Qm+qkouj9athhPfk3hlLrbGEMIBJfgaHgRQ4BIA==
X-Received: by 2002:a37:28c7:: with SMTP id o68-v6mr9089276qko.350.1538747151690;
        Fri, 05 Oct 2018 06:45:51 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id c34-v6sm3125663qkh.40.2018.10.05.06.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:45:48 -0700 (PDT)
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due
 to commit graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <87in2hgzin.fsf@evledraar.gmail.com>
 <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
 <87ftxkh7bf.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
Date:   Fri, 5 Oct 2018 09:45:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87ftxkh7bf.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2018 9:05 AM, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Oct 05 2018, Derrick Stolee wrote:
>
>> On 10/4/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>>> I don't have time to polish this up for submission now, but here's a WIP
>>> patch that implements this, highlights:
>>>
>>>    * There's a gc.clone.autoDetach=false default setting which overrides
>>>      gc.autoDetach if 'git gc --auto' is run via git-clone (we just pass a
>>>      --cloning option to indicate this).
>> I'll repeat that it could make sense to do the same thing on clone
>> _and_ fetch. Perhaps a "--post-fetch" flag would be good here to
>> communicate that we just downloaded a pack from a remote.
> I don't think that makes sense, but let's talk about why, because maybe
> I've missed something, you're certainly more familiar with the
> commit-graph than I am.
>
> The reason to do it on clone as a special-case or when the file is
> missing, is because we know the file is desired (via the GC config), and
> presumably is expected to help performance, and we have 0% of it. So by
> going from 0% to 100% on clone we'll get fast --contains and other
> goodies the graph helps with.
>
> But when we're doing a fetch, or really anything else that runs "git gc
> --auto" we can safely assume that we have a recent enough graph, because
> it will have been run whenever auto-gc kicked in.
>
> I.e.:
>
>      # Slow, if we assume background forked commit-graph generation
>      # (which I'm avoiding)
>      git clone x && cd x && git tag --contains
>      # Fast enough, since we have an existing commit-graph
>      cd x && git fetch && git tag --contains
>
> I *do* think it might make sense to in general split off parts of "gc
> --auto" that we'd like to be more aggressive about, simply because the
> ratio of how long it takes to do, and how much it helps with performance
> makes more sense than a full repack, which is what the current heuristic
> is based on.
>
> And maybe when we run in that mode we should run in the foreground, but
> I don't see why git-fetch should be a special case there, and in this
> regard, the gc.clone.autoDetach=false setting I've made doesn't make
> much sence. I.e. maybe we should also skip forking to the background in
> such a mode when we trigger such a "mini gc" via git-commit or whatever.

My misunderstanding was that your proposed change to gc computes the 
commit-graph in either of these two cases:

(1) The auto-GC threshold is met.

(2) There is no commit-graph file.

And what I hope to have instead of (2) is (3):

(3) The commit-graph file is "sufficiently behind" the tip refs.

This condition is intentionally vague at the moment. It could be that we 
hint that (3) holds by saying "--post-fetch" (i.e. "We just downloaded a 
pack, and it probably contains a lot of new commits") or we could create 
some more complicated condition based on counting reachable commits with 
infinite generation number (the number of commits not in the 
commit-graph file).

I like that you are moving forward to make the commit-graph be written 
more frequently, but I'm trying to push us in a direction of writing it 
even more often than your proposed strategy. We should avoid creating 
too many orthogonal conditions that trigger the commit-graph write, 
which is why I'm pushing on your design here.

Anyone else have thoughts on this direction?

Thanks,

-Stolee

