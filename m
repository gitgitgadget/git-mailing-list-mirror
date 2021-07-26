Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56B5C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEB060BD3
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZTEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:04:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662DC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 12:44:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f11so13362352ioj.3
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ER+EMb1K1Flt/+LIsk2XtXwh/qhr6pvXVKm/H/rBCS0=;
        b=kYvzLcV/2dpvfP43hGeOZ7+vd5TgEEO+AWQLEwk3KLW8wWEnwP1jldfEtjBscPK+oU
         o47jZM6df3aMaNTzbbqs1j1yBHxOjEAK7UvplI5JTfS+CPfYMK6Z8Nu6vLfHsLBFsQxt
         LAXxt16xLSekl1pXLWyDyVeBUVHtsKjyN5EgSf9p3BYRSHWBoE/BcGYAgton9Pye/MxE
         lW1SCeQsKdhP5nMoHH9TdsycJuE1kYypCregcWRpJcfNXBdiro4GaDBYIbCSghwG/Ofw
         hgf7jZTR/6tT0US6ZhBk06d4C3WZ29GxehiIagNcCbscZsjGoNd64AoLlCJOLqojxKCt
         fnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ER+EMb1K1Flt/+LIsk2XtXwh/qhr6pvXVKm/H/rBCS0=;
        b=hs8Gm5yNf47mXPQwktuXYGsRCI5BE0yruGSO8/ssdQZfLnrj4eyL2XUtZDYz2ZY11n
         tbKyQ3SSxhmtSFzK3cudL8tLqJ+m8aFXIWLNXzbPxeUnTJTlN+edqKqFG1IrCI4bESdz
         ViApjIxgx/ZhBRAUpiuVmaXwNrwgYN8umf473Lnk1x+xQbqxDBi5Md8+Su18DyxzNldh
         9O2/l8dUtkKjPK6LcAEwO8aRl4p4UJJp9sMvr6D7sOHmVUEo1owkQptjRjJYn1xxL3nE
         p+sIGEWp4t0yA1n/sCWXOsVAURxpr1c2+5gnmnpT7y3KR7gqec7PyR9UwAMO+i95Qp9I
         qt5Q==
X-Gm-Message-State: AOAM531sR/iE1NlruPZHqWaKDfdQKPyvuYB8wJUdEa/DUpRMw3KBhNZ8
        LvO0xyRxrK+ViWyLtDcpetglEw==
X-Google-Smtp-Source: ABdhPJyhbTN5PrCRDV8+lRnA2PGKnwuX6ibN1II63qUddXuRQHZ53nHQwzfY55gjKyNgqXYaoNu4IQ==
X-Received: by 2002:a6b:7619:: with SMTP id g25mr15679732iom.151.1627328667673;
        Mon, 26 Jul 2021 12:44:27 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id t15sm362343ile.28.2021.07.26.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 12:44:27 -0700 (PDT)
Date:   Mon, 26 Jul 2021 15:44:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 09/24] midx: infer preferred pack when not given one
Message-ID: <YP8QmrSd0mS26jbP@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <9495f6869d792264c4366c9914fcf93d544caa6a.1624314293.git.me@ttaylorr.com>
 <YPf4MTDpbvinoIia@coredump.intra.peff.net>
 <YPiAhw2eP2MOksUF@nand.local>
 <YPqC19c2sFwuOCY9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPqC19c2sFwuOCY9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 04:50:31AM -0400, Jeff King wrote:
> On Wed, Jul 21, 2021 at 04:16:07PM -0400, Taylor Blau wrote:
>
> > > I dunno. Like I said, I was able to follow it, so maybe it is
> > > sufficient. I'm just not sure others would be able to.
> >
> > I think that others will follow it, too. But I agree that it is
> > confusing, since we're fixing a bug that doesn't yet exist. In reality,
> > I wrote this patch after sending v1, and then reordered its position to
> > come before the implementation of MIDX bitmaps for that reason.
> >
> > So in one sense, I prefer it this way because we don't ever introduce
> > the bug.  But in another sense, it is very jarring to read about an
> > interaction that has no basis in the code (yet).
> >
> > I think that the best thing we could do without adding any significant
> > reordering would be to just call out the situation we're in. I added
> > this onto the end of the commit message which I think makes things a
> > little clearer:
> >
> >     (Note that multi-pack reachability bitmaps have yet to be
> >     implemented; so in that sense this patch is fixing a bug which does
> >     not yet exist.  But by having this patch beforehand, we can prevent
> >     the bug from ever materializing.)
>
> I do like fixing it up front. Here's my attempt at rewriting the commit
> message. I tried to omit details about pack order, and instead refer to
> the revindex code, and instead add more explanation of how this relates
> to the pack-reuse code.
>
> Something like:
>
> [...]
>
> Thoughts?

I like it, although reading it fresh I found the sentence beginning with
"So if the user did not specify a preferred pack" to be a little
confusing. To connect it back to the previous paragraph, I added:

  ... in order to avoid a situation where no pack is marked as preferred
  (breaking our assumption about the pack representing the object at the
  0th bit).

and that read out much clearer (to me at least).

Thanks,
Taylor
