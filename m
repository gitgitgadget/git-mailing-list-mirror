Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E29C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 01:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiCVBRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 21:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiCVBRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 21:17:53 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF09E095
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 18:16:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i12so7135886ilu.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xdxBWLXTB35R9sDAqO3y+jQP2pi29JXn7JUnH4deBP0=;
        b=20zDs5zN+iEpenc+ckZoFOQ3E8BK7tr/O2WJFL7zgAPK24jCnKYY2awL6LSbfh46+o
         69L2n5lq+KE7XMDtwjSRLw2XbTaSedb0AAFWf7v4wPYpcJUpkafazSZu2DOQsc73Hgi4
         vNtaiIWJVW7YJCAU6w5nsPklcKVjhsnEPugQFChneViT5jfPunJftSex9B/2bN0dqG8F
         EmAzYgwGeU/1gbRcSb0oUFjk9trtuq2fKUOvnjBwrSBMt2fJGh9LK7P0mDuO9cC1mY+U
         vkJRrA8L8KkZkoRW8vBcAWe7ZNn4Wx2LIvikP7fVIUuEG7Hgss1ZjKN4wvjcZqK8Cm83
         j5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdxBWLXTB35R9sDAqO3y+jQP2pi29JXn7JUnH4deBP0=;
        b=3Z3/zUdwpb+2kN87s45B8xnRxvD4BYCvRctgvwvTSvcQgOsTH7h++R98IVNKZpgE+w
         JyoWuEUgGKR1epOujZ+R2ScoE7ZJ2/uYtdmzD2QOb1ywhZk8U4m1RZRaS1X1i2v82Lbt
         5J5MqYdF6qNla4t+Hu9Zp2qIqwdfXt/l7htsIJQh26FuZJjM5rXnlemgrv4qkWxQlFb2
         YI74NfyqZ6qfK8EouevSxd+NqYTIpz7/fCHZGtrXc46IkpFi6IGnvfpzNy0xxbORtVem
         fBRl35iwpi5PtKyNYdUfTXsSkIFbWSVJkeSx/7s+JM4h1B9CSDd8PuAJ/9LaB8+sNRJQ
         YqMw==
X-Gm-Message-State: AOAM533eIn1F2aN2ieVqRiVNjQnd8Xi4faFeoQfroUXU05q/YDscMtxZ
        it9UEhPGIRPWoJjf9Ce3SqaTif98ksxN2PAd
X-Google-Smtp-Source: ABdhPJzDHvdQthfvCJv7Po1tdqkOEzll0rjSAM27aIpoE1ilXnBdvgjJ8/c+Y+1MClnTl13qPjzG1Q==
X-Received: by 2002:a05:6e02:154c:b0:2c8:1cb3:9da7 with SMTP id j12-20020a056e02154c00b002c81cb39da7mr5315030ilu.163.1647911785739;
        Mon, 21 Mar 2022 18:16:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x14-20020a927c0e000000b002c244d8dcc8sm9840699ilc.42.2022.03.21.18.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 18:16:25 -0700 (PDT)
Date:   Mon, 21 Mar 2022 21:16:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YjkjaH61dMLHXr0d@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
 <YiZI99yeijQe5Jaq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiZI99yeijQe5Jaq@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 07, 2022 at 10:03:35AM -0800, Jonathan Nieder wrote:
> Sorry for the very slow review!  I've mentioned a few times that this
> overlaps in interesting ways with the gc mechanism described in
> hash-function-transition.txt, so I'd like to compare and see how they
> interact.

Sorry for my equally-slow reply ;). I was on vacation last week and
wasn't following the list closely.

> > +Unreachable objects aren't removed immediately, since doing so could race with
> > +an incoming push which may reference an object which is about to be deleted.
> > +Instead, those unreachable objects are stored as loose object and stay that way
> > +until they are older than the expiration window, at which point they are removed
> > +by linkgit:git-prune[1].
> > +
> > +Git must store these unreachable objects loose in order to keep track of their
> > +per-object mtimes.
>
> It's worth noting that this behavior is already racy.  That is because
> when an unreachable object becomes newly reachable, we do not update
> its mtime and the mtimes of every object reachable from it, so if it
> then becomes transiently unreachable again then it can be wrongly
> collected.

Just to be clear, the race here only happens if the object in question
becomes reachable _after_ a pruning GC determines its mtime. If that's
the case, then the object will indeed be wrongly collected. This is
consistent with the existing behavior (which is racy in the exact same
way).

(After re-reading what you wrote and my response, I think we are saying
the exact same thing, but it doesn't hurt to think aloud).

> > +
> > +== Cruft packs
> > +
> > +A cruft pack eliminates the need for storing unreachable objects in a loose
> > +state by including the per-object mtimes in a separate file alongside a single
> > +pack containing all loose objects.
>
> Can this doc say a little about how "git prune" handles these files?
> In particular, does a non cruft pack aware copy of Git (or JGit,
> libgit2, etc) do the right thing or does it fight with this mechanism?
> If the latter, do we have a repository extension (extensions.*) to
> prevent that?

I mentioned this in much more detail in [1], but the answer is that the
cruft pack looks like any other pack, it just happens to have another
metadata file (the .mtimes one) attached to it. So other implementations
of Git should treat it as they would any other pack. Like I mentioned in
[1], cruft packs were designed with the explicit goal of not requiring a
repository extension.

> > +  3. Write the pack out, along with a `.mtimes` file that records the per-object
> > +     timestamps.
>
> As a point of comparison, the design in hash-function-transition uses
> a single timestamp for the whole pack.  During read operations, objects
> in a cruft pack are considered present; during writes, they are
> considered _not present_ so that if we want to make a cruft object
> newly present then we put a copy of it in a new pack.
>
> Advantage of the mtimes file approach:
> - less duplication of storage: a revived object is only stored once,
>   in a cruft pack, and then the next gc can "graduate" it out of the
>   cruft pack and shrink the cruft pack
> - less affect on non-gc Git code: writes don't need to know that any
>   cruft objects referenced need to be copied into a new pack
>
> Advantages of the mtime per cruft pack approach:
> - easy expiration: once a cruft pack has reached its expiration date,
>   it can be deleted as a whole
> - less I/O churn: a cruft pack stays as-is until combined into another
>   cruft pack or deleted.  There is no frequently-modified mtimes file
>   associated to it
> - informs the storage layer about what is likely to be accessed: cruft
>   packs can get filesystem attributes to put them in less-optimized
>   storage since they are likely to be less frequently read
>
> [...]

The key advantage of cruft packs is that you can expire unreachable
objects in piecemeal while still retaining the benefit of being able to
de-duplicate cruft objects and store them packed against each other.

> > +Notable alternatives to this design include:
>
> This doesn't mention the approach described in
> hash-function-transition.txt (and that's already implemented and has
> been in use for many years in JGit's DfsRepository).  Does that mean
> you aren't aware of it?

Implementing the UNREACHABLE_GARBAGE concept from
hash-function-transition.txt in cruft pack-terms would be equivalent to
not writing the mtimes file at all. This follows from the fact that a
pre-cruft packs implementation of Git considers a packed object's mtime
to be the same as the pack it's contained in. (I'm deliberately
avoiding any details from the h-f-t document regarding re-writing
objects contained in a garbage pack here, since this is separate from
the pack structure itself (and could easily be implemented on top of
cruft packs)).

So I'm not sure what the alternative we'd list would be, since it
removes the key feature of the design of cruft packs.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YiZMhuI%2FDdpvQ%2FED@nand.local/
