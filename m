Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D287C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 20:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6830460F93
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 20:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhG0UFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhG0UFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 16:05:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C08C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 13:05:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r6so165961ioj.8
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1TgX6BiijsqaRilu1KW4W2p9SPl7wjOyNb+kC9nOV+U=;
        b=FzQya94yd7/mn1ZTrG6lYhj8ddGFv0ce4HDnVieheKVS2z7wGk17/CaJrKq7fcwmpa
         54F9r8ajcjSn8lNEiOnwoZEhNcUuNT39Wxe9Lx6JPTkxrpK4FtLhGU2Xel6zZYry/bto
         A7uYP1dWrfPNoXJynHFWBQW44sI8hC0T42uNoIsaEswzd8EV5e5t91e6lJ0zn+vFAk2M
         hp89adUb0lv6BHlBAA6PPjebVtkHCvvdgiVNSUPz7uIBgyCMhfOZluRQArF+ALShzeoZ
         anlK1kWcS+8EojtBCPCK7YD+z1HeJrSIakFNMg8Pk/SPXj/mnG+SOEu+noZzPv5YYfRV
         cRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1TgX6BiijsqaRilu1KW4W2p9SPl7wjOyNb+kC9nOV+U=;
        b=c0Ek7J3qiUStrwR+FbSWMdG2muQL8otmgvJWYKL6EA7o0Ba1L83SUn3nHeFMs1+JA8
         bVQvR07rURctvwtw6XCL7Kx5dNnYAZcmJX2F2j4TB7I2bROJM5BrG7+IeJj7AwIb/NGv
         8TvhuQZRoZEKxIzMkZnquc4v44Tin1XgVn6EN7Hyb+mENlafXwm9Q5ax8id/B2kT18Ow
         MqXRBGNkouDVlwu6NP1iMJSTkHWSWtKPHj4HV+bbwds0v7iJE5XE52RP9qRBVm0IUQHv
         GQj3UTVeifGJ/JlcQ6jZJdj+1SixjC0meVJhcjKrZRgvRoZri07kgRg1Z5bkIC/isHZV
         c4Dw==
X-Gm-Message-State: AOAM533HxdO/qPUTWNOXB3riMcC5YDzssrBWlVgNFofRasUuEcLWq9uw
        U59x5inNa6dWwqc0KCpUjyp1lg==
X-Google-Smtp-Source: ABdhPJyzne+W9m/brL3PdTzI2tjrjOmMRA8CqFJzm5rVcJe2X/Q/fO5vUuRvKVtD8aDFz202SCAKnA==
X-Received: by 2002:a05:6602:27ca:: with SMTP id l10mr11409728ios.16.1627416340290;
        Tue, 27 Jul 2021 13:05:40 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id g15sm2292813ild.29.2021.07.27.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:05:39 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:05:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQBnE+ft/MR3zs1t@nand.local>
References: <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
 <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
 <YQBGvEQoZpw49Z7L@nand.local>
 <YQBIqO5j0VHXL6V7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQBIqO5j0VHXL6V7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:55:52PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 01:47:40PM -0400, Taylor Blau wrote:
>
> > > BTW, yet another weirdness: close_object_store() will call close_midx()
> > > on the outermost midx struct, ignoring o->multi_pack_index->next
> > > entirely. So that's a leak, but also means we may not be closing the
> > > midx we're interested in (since write_midx_internal() takes an
> > > object-dir parameter, and we could be pointing to some other
> > > object-dir's midx).
> >
> > Yuck, this is a mess. I'm tempted to say that we should be closing the
> > MIDX that we're operating on inside of write_midx_internal() so we can
> > write, but then declaring the whole object store to be bunk and calling
> > close_object_store() before leaving the function. Of course, one of
> > those steps should be closing the inner-most MIDX before closing the
> > next one and so on.
>
> That gets even weirder when you look at other callers of
> write_midx_internal(). For instance, expire_midx_packs() is calling
> load_multi_pack_index() directly, and then passing it to
> write_midx_internal().
>
> So closing the whole object store there is likewise weird.
>
> I actually think having write_midx_internal() open up a new midx is
> reasonable-ish. It's just that:
>
>   - it's weird when it stuffs duplicate packs into the
>     r->objects->packed_git list. But AFAICT that's not actually hurting
>     anything?

It is hurting us when we try to write a MIDX bitmap, because we try to
see if one already exists. And to do that, we call prepare_bitmap_git(),
which tries to call open_pack_bitmap_1 on *each* pack in the packed_git
list. Critically, prepare_bitmap_git() errors out if it is called with a
bitmap_git that has a non-NULL `->pack` pointer.

So they aren't a cycle in the sense that `p->next == p`, but it does
cause problems for us nonetheless.

I stepped away from my computer for an hour or so and thought about
this, and I think that the solution is two-fold:

  - We should be more careful about freeing up the ->next pointers of a
    MIDX, and releasing the memory we allocated to hold each MIDX struct
    in the first place.

  - We should always be operating on the repository's
    r->objects->multi_pack_index, or any other MIDX that can be reached
    via walking the `->next` pointers. If we do that consistently, then
    we'll only have at most one instance of a MIDX struct corresponding
    to each MIDX file on disk.

In the reroll that I'll send shortly, those are:

  - https://github.com/ttaylorr/git/commit/61a617715f3827401522c7b08b50bb6866f2a4e9
  - https://github.com/ttaylorr/git/commit/fd15ecf47c57ce4ff0d31621c2c9f61ff7a74939

respectively. It resolves my issue locally which was that I was
previously unable to run:

    GIT_TEST_MULTI_PACK_INDEX=1 \
    GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1 \
      t7700-repack.sh

without t7700.13 failing on me (it previously complained about a
"duplicate" .bitmap file, which is a side-effect of placing duplicates
in the packed_git list, not a true duplicate .bitmap on disk).

I'm waiting on a CI run [1], but I'm relatively happy with the result. I
think we could do something similar to the MIDX code like we did to the
commit-graph code in [2], but I'm reasonably happy with where we are
now.

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/actions/runs/1072513087
[2]: https://lore.kernel.org/git/cover.1580424766.git.me@ttaylorr.com/
