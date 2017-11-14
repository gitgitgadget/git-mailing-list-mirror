Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73BB1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756502AbdKNUkH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:40:07 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:52910 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756458AbdKNUkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:40:05 -0500
Received: by mail-qt0-f177.google.com with SMTP id 31so28996906qtz.9
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c1bsGTzY5YPnEQJ6RtHSIde/y/kCIpTYGmeZKMJH6xg=;
        b=dtUv+BXlh94p7AOOjxDL4vD0fIEqEA4KaSwJnEqUgQeJVEaLgjaW5BmyFFz0Lzw9Ga
         7Aa+5adKOmduN09abVF4KHELSrGA0iIQxj0ozkcbD3Lh1/f9bZaBpgj9nA9dGa+EcvhE
         5ecx7V3t+t/0pEQqlzRygdmHVgqlrQD9jx9CrelfMDCOGz/zOjiovsb7Zn6CC0Q05pxC
         Eif1t39zHmZN0PCMHsx5AfaifiSZLEBhHnjkK53RaRV8u4Hklo68QOvBXMCxuQGG21vl
         OXCsq7eazLb8Gzzhy0AZ6etr5QDz7kcP3ZyzcKRpBO2H8izfNO9LZu85y35Q4oSpZVPl
         fRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c1bsGTzY5YPnEQJ6RtHSIde/y/kCIpTYGmeZKMJH6xg=;
        b=hPGFk9AMa6CuPaAP64hK25pv2c1NCAOrxhR40fWr13gA7BmPz3IJ/+gncFtEJM2FoE
         xEgTXow+b6Zob73Lqm1/CUsShFudGYzEx0el7rlkparL7w7Xdxwyjr/eZFQKXgdSPw1d
         mGgXHKvidzWqv2DYjbnW5zxe6QV23bYdOUDNyX8XjnRLumkDJl1vcfJ8ST0QHpDS0cjT
         YvtSF2lH+8VL/2BuaRMeM4D12M4iar3U8YdjDT2tDcrxBcSCE/nLokRs0xJ33CNvp4+L
         d0FTTlJ8kZbFdG9q2EcpCMHzySotboI+bINcrk/sAWLQVwAc1TkyraKwnidbQx5Awwq7
         EVeQ==
X-Gm-Message-State: AJaThX5qYi36Z5Ss2/kzPZPIP+7xtgWpYQuERPIeKlFafqpdeQ+SlLpg
        NUkzgiORJ4uBjNob5qILJzc+f4fjZctmkOX4IvAJmg==
X-Google-Smtp-Source: AGs4zMa9zoGAiTELe4ntakoMPinFX5ewOcn3S3H8VcihQbJe9aq/1asaP0KQuG5FiZq9sZJKa8xrtb5fw0Ck+2fbOTo=
X-Received: by 10.233.239.70 with SMTP id d67mr21365241qkg.308.1510692004451;
 Tue, 14 Nov 2017 12:40:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 12:40:03 -0800 (PST)
In-Reply-To: <20171114120208.d0570f20672f117bcf8e5396@google.com>
References: <20171031211852.13001-1-sbeller@google.com> <20171102194148.2124-1-sbeller@google.com>
 <20171102194148.2124-8-sbeller@google.com> <20171114120208.d0570f20672f117bcf8e5396@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 12:40:03 -0800
Message-ID: <CAGZ79kZXxrDKr5PfJ2xx_3hhzscUiQvqOnCGURXCbJSL118trw@mail.gmail.com>
Subject: Re: [PATCHv3 7/7] builtin/describe.c: describe a blob
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 12:02 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Thu,  2 Nov 2017 12:41:48 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> Sometimes users are given a hash of an object and they want to
>> identify it further (ex.: Use verify-pack to find the largest blobs,
>> but what are these? or [1])
>>
>> "This is an interesting endeavor, because describing things is hard."
>>   -- me, upon writing this patch.
>>
>> When describing commits, we try to anchor them to tags or refs, as these
>> are conceptually on a higher level than the commit. And if there is no ref
>> or tag that matches exactly, we're out of luck.  So we employ a heuristic
>> to make up a name for the commit. These names are ambiguous, there might
>> be different tags or refs to anchor to, and there might be different
>> path in the DAG to travel to arrive at the commit precisely.
>>
>> When describing a blob, we want to describe the blob from a higher layer
>> as well, which is a tuple of (commit, deep/path) as the tree objects
>> involved are rather uninteresting.  The same blob can be referenced by
>> multiple commits, so how we decide which commit to use?  This patch
>> implements a rather naive approach on this: As there are no back pointers
>> from blobs to commits in which the blob occurs, we'll start walking from
>> any tips available, listing the blobs in-order of the commit and once we
>> found the blob, we'll take the first commit that listed the blob.  For
>> source code this is likely not the first commit that introduced the blob,
>> but rather the latest commit that contained the blob.  For example:
>>
>>   git describe v0.99:Makefile
>>   v0.99-5-gab6625e06a:Makefile
>>
>> tells us the latest commit that contained the Makefile as it was in tag
>> v0.99 is commit v0.99-5-gab6625e06a (and at the same path), as the next
>> commit on top v0.99-6-gb1de9de2b9 ([PATCH] Bootstrap "make dist",
>> 2005-07-11) touches the Makefile.
>>
>> Let's see how this description turns out, if it is useful in day-to-day
>> use as I have the intuition that we'd rather want to see the *first*
>> commit that this blob was introduced to the repository (which can be
>> achieved easily by giving the `--reverse` flag in the describe_blob rev
>> walk).
>
> The method of your intuition indeed seems better - could we just have
> this from the start?

Thanks for the review!

This series was written with the mindset, that a user would only ever
want to describe bad blobs. (bad in terms of file size, unwanted content, etc)

With the --reverse you only see the *first* introduction of said blob,
so finding out if it was re-introduced is still not as easy, whereas "when
was this blob last used" which is what the current algorithm does, covers
that case better.

> Alternatively, to me, it seems that listing commits that *introduces*
> the blob (that is, where it references the blob, but none of its parents
> do) would be the best way. That would then be independent of traversal
> order (and we would no longer need to find a tag etc. to tie the blob
> to).

What if it is introduced multiple times? (either in multiple competing
side branches; or introduced, reverted and re-introduced?)

> If we do that, it seems to me that there is a future optimization that
> could get the first commit to the user more quickly - once a commit
> without the blob and a descendant commit with the blob is found, that
> interval can be bisected, so that the first commit is found in O(log
> number of commits) instead of O(commits). But this can be done later.

bisection assumes that we only have one "event" going from good to
bad, which doesn't hold true here, as the blob can be there at different
occasions of the history.
