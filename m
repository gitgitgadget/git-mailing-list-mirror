Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53939C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329AC60F5B
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhGZSSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZSSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:18:35 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB3C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:59:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 185so13166874iou.10
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjl4a6MtwykODbOFthDrYrp1vWDVJRUpF7Dkr1wKqPM=;
        b=p2pmzQE1dhZVbzac0IDcmxlXIWOLJJrN8DXt5zJEboPvMuPWecHqS3Im68KWHkGDhz
         +WHbT+411r8/cnSwxYVc1/OjTz/yJQs+yWKzFwk/JyE25RvgdqElq1a0SoCNmQYrHh4y
         YJbbnD2isUT2XoV3GjneSIxjVOI03JwaSkoemGHgT+a0n1iG3M+tqqmA0NXqy44Q+59Y
         JPRv9U+Ijh4RlqBIJBE+cAVizU0lL9gaUsM6R5KLPd+mkfrCiXu2sIKngfa2kG9rUqA8
         +dfUQd0eGvzNBrj0a2H4tCcu4y3UCFfsSy8vlKXXtHFTm/2x/XaMlO3lxX0NiGKPBVR5
         hWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjl4a6MtwykODbOFthDrYrp1vWDVJRUpF7Dkr1wKqPM=;
        b=U7syJrrd3BEkVGDeW394emp7Jp711XnOSIVM9dWoeJBL20/Q5v4n3/8cU7YHcRhvW1
         f1lwrvmUfcrOpHeL6rGZAKgJBfG1kHGedcfwmlinDr/QKej3FUikR9ctcbgExHij6Xg3
         sVKX7CKKj1MyvqoQq6HGxho07FFGSROdq3flBTf7LBCQy3DN1qbu8ikLKBzaMvDcijbV
         xsAlfLdsTimY4dm5YeGvdvjnOn7Uj6RyxEkOte/IEBSQAoOVo1lL+xyPuiEuM3Rvs/jG
         8nUmqbSSrj9yz7EbYUeUTibinAgO0O7QHdbygBZ52MkI/ftwUEHCiNmndC9LiDDzSmhI
         mpLg==
X-Gm-Message-State: AOAM533FT2W1Zl6cE3Fo2SFDkfVRSN7mtKi6y+a05DpVYjZ4Vjis1KDG
        Xc9F/UWJQzRsIPQ1tAHjNAK2HA==
X-Google-Smtp-Source: ABdhPJxADPKECScZi4wRBtQSuoC/R/eUi0TMacnQ6ao8/05uDEXY/vHbrmzOqc5lE7pY1xMqpVjJyg==
X-Received: by 2002:a6b:f101:: with SMTP id e1mr15715138iog.118.1627325943155;
        Mon, 26 Jul 2021 11:59:03 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id t11sm414654ioc.4.2021.07.26.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:59:02 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:59:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YP8F9ttlMXwNZBam@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 04:29:37AM -0400, Jeff King wrote:
> On Wed, Jul 21, 2021 at 03:22:34PM -0400, Taylor Blau wrote:
>
> > > > This avoids a problem that would arise in subsequent patches due to the
> > > > combination of 'git repack' reopening the object store in-process and
> > > > the multi-pack index code not checking whether a pack already exists in
> > > > the object store when calling add_pack_to_midx().
> > > >
> > > > This would ultimately lead to a cycle being created along the
> > > > 'packed_git' struct's '->next' pointer. That is obviously bad, but it
> > > > has hard-to-debug downstream effects like saying a bitmap can't be
> > > > loaded for a pack because one already exists (for the same pack).
> > >
> > > I'm not sure I completely understand the bug that this causes.
> >
> > Off-hand, I can't quite remember either. But it is important; I do have
> > a distinct memory of dropping this patch and then watching a 'git repack
> > --write-midx' (that option will be introduced in a later series) fail
> > horribly.
> >
> > If I remember correctly, the bug has to do with loading a MIDX twice in
> > the same process. When we call add_packed_git() from within
> > prepare_midx_pack(), we load the pack without caring whether or not it's
> > already loaded. So loading a MIDX twice in the same process will fail.
> >
> > So really I think that this is papering over that bug: we're just
> > removing one of the times that we happened to load a MIDX from during
> > the writing phase.
>
> Hmm, after staring at this for a bit, I've unconfused and re-confused
> myself several times.
>
> Here are some interesting bits:
>
>   - calling load_multi_pack_index() directly creates a new midx object.
>     None of its m->packs[] array will be filled in. Nor is it reachable
>     as r->objects->multi_pack_index.
>
>   - in using that midx, we end up calling prepare_midx_pack() for
>     various packs, which creates a new packed_git struct and adds it to
>     r->objects->packed_git (via install_packed_git()).
>
> So that's a bit weird already, because we have packed_git structs in
> r->objects that came from a midx that isn't r->objects->multi_pack_index.
> And then if we later call prepare_multi_pack_index(), for example as
> part of a pack reprepare, then we'd end up with duplicates.

Ah, this jogged my memory: this is a relic from when we generated MIDX
bitmaps in-process with the rest of the `repack` code. And when we did
that, we did have to call `reprepare_packed_git()` after writing the new
packs but before moving them into place.

So that's where the `reprepare_packed_git()` came from, but we don't
have any of that code anymore, since we now generate MIDX bitmaps by
invoking:

    git multi-pack-index write --bitmap --stdin-packs --refs-snapshot

as a sub-process of `git repack`; no need for any reprepare which is
what was triggering this bug.

To be sure, I reverted this patch out of GitHub's fork, and reran the
tests both in normal mode (just `make test`) and then once more with the
`GIT_TEST_MULTI_PACK_INDEX{,_WRITE_BITMAP}` environment variables set.
Unsurprisingly, it passed both times.

I'm happy to keep digging further, but I think that I'm 99% satisfied
here. Digging further involves resurrecting a much older version of this
series (and others adjacent to it), and there are probably other bugs
lurking that would be annoying to tease out.

In any case, let's drop this patch from the series. It's disappointing
that we can't run:

    git -c core.multiPackIndex= multi-pack-index write

anymore, but I guess that's no worse than the state we were in before
this patch, so I'm content to let it live on.

Thanks,
Taylor
