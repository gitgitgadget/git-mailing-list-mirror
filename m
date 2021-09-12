Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75EC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 04:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AFF60F5D
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 04:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhILEC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 00:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhILEC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 00:02:56 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15137C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 21:01:43 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b15so5981955ils.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 21:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DHM/7aFPzed1wa0PtqBlb73VVRaTEVQb1RuP9i/uhVs=;
        b=dY5BvTwvOCwd2vfoApXOCYGnDgrH/7RpB01OWMfSn9rQpK8w8bT2ss0euf7hjnP9vW
         XdN9KOjNKdrPuIIZ6eZ4bDyh8cj5E1Bgf41HEsjQlvxLau4ZgXXOAtc4IsN12x9wC8Ys
         popeilZ/37fKuM6xoJ9vSpho4tBHkB47gtWWsw81Wetqj0/f1F15cVDIibKByfFTQu0U
         QSL2ZL2GAPuAtaRoMxZVPV+KC51GHTd16Jmyz9AyJLYfn3Z0kGf8j6BcTT5IUOteHWDg
         N37gkEATcmIFr7wqYASxL20dnTvXR9k55bwlLZEHHT8xpT3hBpc+CCAq6NzM/3/BsUVb
         /TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DHM/7aFPzed1wa0PtqBlb73VVRaTEVQb1RuP9i/uhVs=;
        b=sGVio3YwWKsGZlgvBou9QPN63ELrZtM+I8B1yKHbGJNH2VQB9KOl8yBj51zqGqcExr
         Qui0kDzA/R180KYkC211+phFB4ZuoiniNpopm27Adk7T/25MwhhX6CeeGhkGLyUMhZGQ
         4OBvk+q9kxOSwciYticxoOalnj0D3LVEePTrcBaHchEyxXfDynQDu7DQNlVLt0Obb7wv
         Fb/FBo+T7cf2tn3XhaCHDI/Eo1tzCxtRSR+vSYsLVg72DGA/LiTCmTULyhRPcMop9olm
         cvRsx8JY5QSyPf2AvIOQqb+RodIEcMFXt+QTAk0Dxf8McPVrU3lSMm44n8+u7l3ViVIp
         /64Q==
X-Gm-Message-State: AOAM532fYqBxIdMyDXFUGPBwnV5YP/tMA0b45m/Jr9R3ZYc7GJQhq4yh
        mxrmDLfubwMZb0tVNR3zVBknWA==
X-Google-Smtp-Source: ABdhPJzFRjLeEvn2+bqXbKJ1tH3cCc6wJANiqyJQRWWNoymZoC2k4eeEnopYL3sPGkeVgfi2l55G/w==
X-Received: by 2002:a92:dc85:: with SMTP id c5mr3515107iln.104.1631419302402;
        Sat, 11 Sep 2021 21:01:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j14sm2079650ile.39.2021.09.11.21.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 21:01:42 -0700 (PDT)
Date:   Sun, 12 Sep 2021 00:01:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
Message-ID: <YT17pcvyq2nyyc3o@nand.local>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
 <9cdf54db-132e-d771-e177-6673f7ad02bf@gmail.com>
 <YT1dCAuCE7xIIIk/@nand.local>
 <YT1l75uQ50e2IaXM@nand.local>
 <4d76db59-e049-32c3-c4dd-ab7f70cbc20b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d76db59-e049-32c3-c4dd-ab7f70cbc20b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 11:51:36PM -0400, Derrick Stolee wrote:
> On 9/11/21 10:29 PM, Taylor Blau wrote:
> > On Sat, Sep 11, 2021 at 09:51:04PM -0400, Taylor Blau wrote:
> >> On Sat, Sep 11, 2021 at 07:59:40PM -0400, Derrick Stolee wrote:
> >>> I initially hesitated to support the drop of
> >>> nth_midxed_pack_entry(), since it was designed with things
> >>> like midx bitmaps in mind (specifically, to also support
> >>> lex-order-to-stable-order conversions).
> >>
> >> I didn't know that nth_midxed_pack_entry was designed with either
> >> purpose in mind, since it predates midx bitmaps by quite a bit.
> >
> > Thinking on it more, I can imagine that you wrote this function
> > aspirationally envisioning something like MIDX bitmaps. And since you
> > and I discussed the design together quite a bit, I imagine that that's
> > the case ;-).
> >
> > But I agree that after reading this series again, that the inline-ing
> > suggested makes sense (and doesn't conflict with any series I have in
> > flight which don't add any new callers).
>
> I'm thinking more to my original design of the multi-pack-index.
> At that time, I was thinking about the possible integration
> with bitmaps based on my experience in other systems which used
> a stable object order to allow writing bitmaps asynchronously
> with respect to the multi-pack-index write and object packing.

Makes sense, and thank you for clarifying. After re-reading my first
email, I figured that this is what you must have been talking about,
which is why I felt like I should rephrase (hence the follow-up email).

> One thing that you did when first considering bitmaps over the
> multi-pack-index was to demonstrate that a stable object order
> is not required, which surprised and delighted me. It greatly
> reduced the complexity of the problem, and being able to inline
> this method is only one small fallout from that simplicity.

This was definitely a consequence of what I had observed from seeing
what was "slow" when running bitmaps in production at GitHub. There,
repacking a repository's objects all into one pack each time we ran our
automated background jobs far outpaced the amount of time we spent
generating bitmaps.

And with your and Peff's work on improving bitmap generation itself,
things are in a pretty good place. I do have some potential ideas for
future improvement, like a mode where bitmaps are only "fast forwarded",
meaning that new bitmaps are only added between the commits selected for
bitmapping in the previous round and the current reference tips.

I think things like that end up getting you pretty far, but it may be
interesting to come back eventually and revisit adding a stable object
order. In the meantime, though... ;)

Thanks,
Taylor
