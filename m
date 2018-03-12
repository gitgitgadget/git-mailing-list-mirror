Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE671F404
	for <e@80x24.org>; Mon, 12 Mar 2018 13:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeCLNpc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 09:45:32 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39989 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCLNpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 09:45:31 -0400
Received: by mail-qt0-f193.google.com with SMTP id y6so18789799qtm.7
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jMCvz86Ukb62GblbPj3e9P9oZ9x3mGTg14mKqNJad50=;
        b=LY8xYP6VIODmqHqwfN5fQkcxNiNg3zUYkt7eK8xUY2/zHjO7RqbLaXrRS1JjJ/nUoK
         TuV2iRLA5U15UQruKzIyZDg+dhcWeLlIJSS6k4wG05r4IySxT5fZC6gpW+bUGvKbrUk3
         bfI+z10TW0fUotb+P3I4DrkqXehw0iXAFekT0TV2ZGW/azmGmGqU6Y92VHyEhLICe64O
         IuvfeJ51tKgxbVw47ROvxJ17ttrXhbnyE07cqCPZw9Rdu+4S8ltMRCXiONy14y86upiS
         Sd8s67Y76wTCvHD28CRX44hi1G2cU3xNRvi4uLp7uDybR4EqdvMJz+Uuh+5vC8V/9DWO
         ag1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jMCvz86Ukb62GblbPj3e9P9oZ9x3mGTg14mKqNJad50=;
        b=ksu4zZMvjZDrgpzrKego8D2gY385qdfmWuya28r48PGoow91vo0N+38G2j7TvzYDYv
         LRbMkEpQx4TTamgiur1ov8r2QdjR2DLLYHjVZi/O11FIBNbakD0Rkhm2PBkpyJonHYR6
         Z2Qu3wSd+cCGVVXoVdi5DrJR9o4INJlV+8l7cLQDUI11DfljsAzdKmW4gTt7UOTI0RIt
         1pfB+JsVKPeSaXDLZFweJWMxBa+jNJ4suJjufs4k6TDh/zrRyfH2C9c/kZIr09EfMn/z
         c2tWskyWTVrSESb8WZgglJCStbE5/vDSRCcOeosl5GaHXdztXSjFdJUssQFzM0jd2AyW
         w5cw==
X-Gm-Message-State: AElRT7EsvnkIq6a1s5QmqVdkM+YObrlrt16s8Ts3K34iL7fSKRj9au7G
        8CQ6zwZhSLbQKCmwBY0MZ4W2yvQvNJA=
X-Google-Smtp-Source: AG47ELsoMhzH4JzIi54RsTnHcPsqf9aOpTgwvRz63J4yPwdCtWtZ/i6K5zM2vQSViqgONH7X/WTZvQ==
X-Received: by 10.200.63.238 with SMTP id v43mr3708571qtk.54.1520862330045;
        Mon, 12 Mar 2018 06:45:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n88sm2293222qte.66.2018.03.12.06.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 06:45:29 -0700 (PDT)
Subject: Re: [PATCH 0/4] Speed up git tag --contains
To:     Jeff King <peff@peff.net>, csilvers <csilvers@cs.stanford.edu>
Cc:     avarab@gmail.com, jrnieder@gmail.com, drizzd@aon.at,
        git@vger.kernel.org, gitster@pobox.com
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <E1ea4Ui-0005qJ-3s@theory.stanford.edu>
 <20180303051516.GE27689@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <63e9c6a8-4efc-6f86-f355-1ec40dd674e4@gmail.com>
Date:   Mon, 12 Mar 2018 09:45:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303051516.GE27689@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2018 12:15 AM, Jeff King wrote:
> On Fri, Jan 12, 2018 at 10:56:00AM -0800, csilvers wrote:
>
>>> This is a resubmission of Jeff King's patch series to speed up git tag
>>> --contains with some changes. It's been cooking for a while as:
>> Replying to this 6-year-old thread:
>>
>> Is there any chance this could be resurrected?  We are using
>> phabricator, which uses `git branch --contains` as part of its
>> workflow.  Our repo has ~1000 branches on it, and the contains
>> operation is eating up all our CPU (and time).  It would be very
>> helpful to us to make this faster!
>>
>> (The original thread is at
>> https://public-inbox.org/git/E1OU82h-0001xY-3b@closure.thunk.org/
> Sorry, this got thrown on my "to respond" pile and languished.

Thanks for adding me to the thread. It's good to know the pain point 
people are having around commit graph walks.

> There are actually three things that make "git branch --contains" slow.
>
> First, if you're filtering 1000 branches, we'll run 1000 merge-base
> traversals, which may walk over the same commits multiple times.
>
> These days "tag --contains" uses a different algorithm that can look at
> all heads in a single traversal. But the downside is that it's
> depth-first, so it tends to walk down to the roots. That's generally OK
> for tags, since you often have ancient tags that mean getting close to
> the roots anyway.
>
> But for branches, they're more likely to be recent, and you can get away
> without going very deep into the history.
>
> So it's a tradeoff. There's no run-time switch to flip between them, but
> a patch like this:
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 8dcc2ed058..4d674e86d5 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -404,6 +404,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>   
>   	memset(&array, 0, sizeof(array));
>   
> +	filter->with_commit_tag_algo = 1;
>   	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
>   
>   	if (filter->verbose)
>
> drops my run of "git branch -a --contains HEAD~100" from 8.6s to
> 0.4s on a repo with ~1800 branches. That sounds good, but on a repo with
> a smaller number of branches, we may actually end up slower (because we
> dig further down in history, and don't benefit from the multiple-branch
> speedup).

It's good to know that we already have an algorithm for the multi-head 
approach. Things like `git branch -vv` are harder to tease out because 
the graph walk is called by the line-format code.

> I tried to do a "best of both" algorithm in:
>
>   https://public-inbox.org/git/20140625233429.GA20457@sigill.intra.peff.net/
>
> which finds arbitrary numbers of merge bases in a single traversal.  It
> did seem to work, but I felt uneasy about some of the corner cases.
> I've been meaning to revisit it, but obviously have never gotten around
> to it.
>
> The second slow thing is that during the traversal we load each commit
> object from disk. The solution there is to keep the parent information
> in a faster cache. I had a few proposals over the years, but I won't
> even bother to dig them up, because there's quite recent and promising
> work in this area from Derrick Stolee:
>
>    https://public-inbox.org/git/1519698787-190494-1-git-send-email-dstolee@microsoft.com/
>
> And finally, the thing that the patches you linked are referencing is
> about using commit timestamps as a proxy for generation numbers. And
> Stolee's patches actually leave room for real, trustable generation
> numbers.
>
> Once we have the serialized commit graph and generation numbers, think
> the final step would just be to teach the "tag --contains" algorithm to
> stop walking down unproductive lines of history. And in fact, I think we
> can forget about the best-of-both multi-tip merge-base idea entirely.
> Because if you can use the generation numbers to avoid going too deep,
> then a depth-first approach is fine. And we'd just want to flip
> git-branch over to using that algorithm by default.

I'll keep this in mind as a target for performance measurements in the 
serialized commit graph patch and the following generation number patch.

Thanks,
-Stolee
