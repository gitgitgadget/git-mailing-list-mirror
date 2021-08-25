Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B518C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A5561176
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHYCLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhHYCK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:10:59 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B1C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:10:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a21so28900570ioq.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1GZMS/EPLo9f4RQIE0z5RgL3krC7mL2rS6MSXQtk0E=;
        b=qQ3NZMVTylcjERHf8993IsuY506EoOFopM8dfUUVuZIh96jeYjM1tA+kRt/PB63T8Z
         eUYAkwiyivL4DzrgsxK0bWBeOpgx+mx98D8rNT8gY7ESMJahe6SwdKXBRuHSy8jsKYkm
         qwV6s83KMKshuP0fLns5sAa40CKCOZexPFd2gjgvEp2RT2IFsxSj1kcTZdxPaH7Elw3e
         TMbQ2rQd3GOzp3QMgDsdqPEfelni3Fm5c46ITNHYSEreGcKw+3htO5Tk9WGG0jkt5fcM
         q6wGiDIsete8bxHf4OmrWZiFLL+DowB3YE1MzMLaSkAwJB0hKmsDXtt5QaGbSip6jG8p
         a/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1GZMS/EPLo9f4RQIE0z5RgL3krC7mL2rS6MSXQtk0E=;
        b=n33j2sYvXqjzUN+Yc+AKUaohhtDy2clFpRG158oMar5YOTjVM+iEFr+6h9bIFsS2t0
         g93rAdaiOQ1gvXmX52HfBA1IzKaCAS5pGfC4CT+mEQuZwrq1ivURSPAycVcvdXWaJNb6
         WCn4aQ+oms6PL0R/gWtoyBPg2Dme1Wp0ogWDXyJ9yGzPCoNvkSdVQ+0ffAAfr3LyHguk
         cREwCvT4XXXspIQdXrd+8ek07lAgro9ULMwrEKJxcCJ6VEIHHPVyiuTK2meILSVENwBg
         z1BKYmx7T77GPYhf0jyEHg5ih04tQk3AS0colgP1A/M1Q2OFZ+nBrQgsAGsqjtLC3MR5
         JvOw==
X-Gm-Message-State: AOAM530Bs3NAql5yzVZvtO1I1zGPh5Z99YM3Cjux+LBEgQKF1z8R5fcT
        w0md1285Y4RSK6Y407/da3eyOg==
X-Google-Smtp-Source: ABdhPJwfvoYI2d+a8hF+rU8afRtmaBrSyWu7BFNHu9N+yEvBskkTxA52mGbcYahit7F3Is++OqxuZA==
X-Received: by 2002:a5d:8d0d:: with SMTP id p13mr33554089ioj.129.1629857413873;
        Tue, 24 Aug 2021 19:10:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p15sm7743649iop.15.2021.08.24.19.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 19:10:13 -0700 (PDT)
Date:   Tue, 24 Aug 2021 22:10:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSWmhMID1hGs7Yp1@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 08:28:36PM -0400, Jeff King wrote:
> On Tue, Aug 24, 2021 at 12:15:47PM -0400, Taylor Blau wrote:
>
> > Range-diff against v3:
> > [...]
> >  9:  40cff5beb5 !  9:  c9fea31fa8 midx: avoid opening multiple MIDXs when writing
> >     @@ Commit message
> >          one and should invalidate the object store's memory of any MIDX that
> >          might have existed beforehand.
> >
> >     +    Note that this now forbids passing object directories that don't belong
> >     +    to alternate repositories over `--object-dir`, since before we would
> >     +    have happily opened a MIDX in any directory, but now restrict ourselves
> >     +    to only those reachable by `r->objects->multi_pack_index` (and alternate
> >     +    MIDXs that we can see by walking the `next` pointer).
> >     +
> >     +    As far as I can tell, supporting arbitrary directories with
> >     +    `--object-dir` was a historical accident, since even the documentation
> >     +    says `<alt>` when referring to the value passed to this option.
> >     +
> >     +    A future patch could clean this up and provide a warning() when a
> >     +    non-alternate directory was given, since we'll still write a new MIDX
> >     +    there, we just won't reuse any MIDX that might happen to already exist
> >     +    in that directory.
> >     +
>
> So this is definitely fixed as we discussed. But since that discussion,
> we've had the thread over in:
>
>   https://lore.kernel.org/git/20210820195558.44275-1-johannes@sipsolutions.net/
>
> and its siblings:
>
>   https://lore.kernel.org/git/20210823094049.44136-1-johannes@sipsolutions.net/
>
>   https://lore.kernel.org/git/20210823171011.80588-1-johannes@sipsolutions.net/
>
> It's not clear to me that we have a resolution on whether calling "cd ..
> && git multi-pack-index write --object-dir repo.git" is supposed to
> work.

My recommendation would be to do the following things, all in a reroll
of this series:

  - Fix the bug by which we would delete a .rev or .bitmap file out of a
    different object store than we were working in (when the caller
    passes `--object-dir`).

  - Disallow running `git multi-pack-index` outside of a Git repository.

  - Restrict `--object-dir` to only work with alternates of the
    repository in the current working directory.

To me, that seems like both the least-surprising behavior, and what
would lend itself to the easiest implementation. I would probably argue
that the existing behavior (where `--object-dir` would work against
arbitrary repositories) is a bug, and shouldn't continue to be
supported.

So my plan would be to do that, which would generate something like the
following range-diff. If nobody has any objections, I'd like to send
what I currently have in ttaylorr/git on GitHub in the
tb/multi-pack-bitmaps branch as a reroll of this series, and then merge
that early in the cycle to give it a chance to be tested before we cut
2.34.

Thanks,
Taylor
