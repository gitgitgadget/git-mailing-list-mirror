Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B101F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeGPUpr (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:45:47 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35574 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPUpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:45:47 -0400
Received: by mail-vk0-f65.google.com with SMTP id p12-v6so428129vkf.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fmIcGl2HovHrAbZ/JRxwaNDrxWHfhr2e3YTI4v0IwXQ=;
        b=l5+no0EG5ZlfUkhQ2c6f2XyJHRKlGqpReNa7qw8c47Sr5k4lj19KN2VeauqwePaJng
         +9rcG9fvcoaIJ2FWfbuWW6l8/g/62r335x1xPgpz0HgswpKUG0urA6jVArjeAAqrzdYH
         e/q2A/fM3BAcE9pWqhwGaR8qbhcnCH9U8s9UWbFBKLKB4pno8R5Yu0tzVZgQ6nQi/s2G
         ElC87qpnIA27cfL5y08HrGMtMEskCyp60oCSgfacQMKkccCT1ZsD8vFaQDoGmu52F13e
         XzBRVwfszvAzH7SqZ/T52FanjFjGOIRK0fP4wQ5ElxwAGhNgMFtMkkSl+dEqnVhka7I0
         EhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fmIcGl2HovHrAbZ/JRxwaNDrxWHfhr2e3YTI4v0IwXQ=;
        b=MUiq9TvIU4bKd4ypxxCknAU3EnWDg+hBIr4NYX02D5g3taHwY5WvKgIcY+7+HfjVw7
         x0L3pknXdcYhj9F7yXZXgwb/7gtiPmyqkVvm03G7eB7ozfZVQvaqPXMMGUDw6yVwTUBW
         GMqCtSSydiBQzV2tEgDW6Ax1AGVQ/lIH5ncr2ODzqhZhTjUDKvq8zY6l/VW7LN8zVdld
         /3rB8mw/5zr2/35J/iGKH/y7gGTr8Q8SbfWygcxHA3pPjrvybF7zsgT6CTElcyZ3mFZ3
         1+t2aoSFXdcKdkMH9dtCLTtxRLQwPU3/9PFA8NEW92i+YycTpAO33197uciGbVJSbw/R
         FCDg==
X-Gm-Message-State: AOUpUlF8zQuBFkYYM4uNVfU7Foiait7ohXyk6YBMgiCHa2J3HaKaSPmP
        kZUN73LXSFQTCovluBPYbhCmfagLZArIyzsUoDE=
X-Google-Smtp-Source: AAOMgpeAVtoelML91CUSb1/DidHIITfYW5X7dig+6EoAelabvfc1VPie17pAsUMhymw8zXH9fV+GtlynF7P2finjxqw=
X-Received: by 2002:a1f:a182:: with SMTP id k124-v6mr10458964vke.118.1531772206576;
 Mon, 16 Jul 2018 13:16:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 13:16:45
 -0700 (PDT)
In-Reply-To: <20180716195226.GB25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com> <20180716195226.GB25189@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Jul 2018 13:16:45 -0700
Message-ID: <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 12:52 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 16, 2018 at 12:15:05PM -0700, Elijah Newren wrote:
>
>> The basic problem here, at least for us, is that gc has enough
>> information to know it could expunge some objects, but because of how
>> it is structured in terms of several substeps (reflog expiration,
>> repack, prune), the information is lost between the steps and it
>> instead writes them out as unreachable objects.  If we could prune (or
>> avoid exploding) loose objects that are only reachable from reflog
>> entries that we are expiring, then the problem goes away for us.  (I
>> totally understand that other repos may have enough unreachable
>> objects for other reasons that Peff's suggestion to just pack up
>> unreachable objects is still a really good idea.  But on its own, it
>> seems like a waste since it's packing stuff that we know we could just
>> expunge.)
>
> No, we should have expunged everything that could be during the "repack"
> and "prune" steps. We feed the expiration time to repack, so that it
> knows to drop objects entirely instead of exploding them loose.

Um, except it doesn't actually do that.  The testcase I provided shows
that it leaves around 10000 objects that are totally deletable and
were only previously referenced by reflog entries -- entries that gc
removed without removing the corresponding objects.


I will note that my testcase was slightly out-of-date; with current
git it needs a call to 'wait_for_background_gc_to_finish' right before
the 'git gc --quiet' to avoid erroring out.

> You
> could literally just do:
>
>   find .git/objects/?? -type f |
>   perl -lne 's{../.{38}$} and print "$1$2"' |
>   git pack-objects .git/objects/pack/cruft-pack
>
> But:
>
>   - that will explode them out only to repack them, which is inefficient
>     (if they're already packed, you can probably reuse deltas, not to
>     mention the I/O savings)
>
>   - there's the question of how to handle timestamps. Some of those
>     objects may have been _about_ to expire, but now you've just put
>     them in a brand-new pack that adds another 2 weeks to their life
>
>   - the find above is sloppy, and will race with somebody adding new
>     objects to the repo
>
> So probably you want to have pack-objects write out the list of objects
> it _would_ explode, rather than exploding them. And then before
> git-repack deletes the old packs, put those into a new cruft pack. That
> _just_ leaves the timestamp issue (which is discussed at length in the
> thread I linked earlier).
>
>> git_actual_garbage_collect() {
>>     GITDIR=$(git rev-parse --git-dir)
>>
>>     # Record all revisions stored in reflog before and after gc
>>     git rev-list --no-walk --reflog >$GITDIR/gc.original-refs
>>     git gc --auto
>>     wait_for_background_gc_to_finish
>>     git rev-list --no-walk --reflog >$GITDIR/gc.final-refs
>>
>>     # Find out which reflog entries were removed
>>     DELETED_REFS=$(comm -23 <(sort $GITDIR/gc.original-refs) <(sort $GITDIR/gc.final-refs))
>
> This is too detailed, I think. There are other reasons to have
> unreachable objects than expired reflogs. I think you really just want
> to consider all unreachable objects (like the pack-objects thing I
> mentioned above).

Yes, like I said, coarse workaround and I never had time to create a
real fix.  But I thought the testcase might be useful as a
demonstration of how git gc leaves around loose objects that were
previously reference by reflogs that gc itself pruned.
