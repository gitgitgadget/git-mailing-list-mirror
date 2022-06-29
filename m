Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A2C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiF2UWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiF2UWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 16:22:07 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDDB2655C
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:22:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q4so26583051qvq.8
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QWEDw7h1383VqAi3RxehxMxpwD3GDj9um2aMqaSzPts=;
        b=C5XcTHKblWHagx9TqsGVeBiklIvei24sMPG0CyWnQCqrhSFkRMBQXlDEJ6hh0Canah
         YyYVOinEUfdpChING9/r39HVTiDRJ+uztYZjXr5ayn5pRU/4tvalqgtroDMLkja8jCzI
         uuqTthHL77BfTdoyHPjsMuJ+J9ooEMIHA7mJc0FEwt72AjciGI0RUOkA83cxCYMbLy4O
         1qkJtx4XifXeMIzOx9MGJOS4Uyri+ADOryjilgUZ2y7lSkduKdFbRIXQo41d6sEzLyBE
         b4DpspKkX3pSuXkN0wkJvqWmcFLnBRn4IayWJPbOJCrahMq2NIaTnCd+tfMPaMsC0MUH
         Hfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWEDw7h1383VqAi3RxehxMxpwD3GDj9um2aMqaSzPts=;
        b=XaVghKQi2mRjcr7POSvTSclzdOkYicNG+qCRoU4I1lfcp6o1z3Rm5eyv2tiCMuT01D
         d33J5YpJESpPViG643gxln2xxV0tq9r/7PZEeUI+kA6cQ0djCs6YJMe5V7MerIp6XKdC
         R5igA/unYLPhvD9q1+OcPBjFkdpwexE6sxpj5xR7gHWRClkig4M6BSVfulYprW5QGJJS
         fOyewLj7ppT3GQwHaEnvcmDiUZGUTQZeA9BYiNRSxOMJ+f2oORuoAAkx3UL3V5mJ4cks
         ZU6o2JBcU7OA4ct4heUIbDvjaQAKq7Tdar/vw71jTxLz8vCl8Yks/09lSkAYdm8KJ8tw
         D1ng==
X-Gm-Message-State: AJIora+BkS9dVxyR5JLTH0g8l4bPdDVIbAKlYcmPIFduvI8vGJNbh7IM
        yR0jDa1oVFdculsqaIPA/9oMzQ==
X-Google-Smtp-Source: AGRyM1vbjOMHgdo0+tTVLUJeh0kzkFarPzbl/db2cUsml287obCmEDCc/xbU35lTj4jz1COyfBF/mw==
X-Received: by 2002:a05:622a:253:b0:306:5d68:2f90 with SMTP id c19-20020a05622a025300b003065d682f90mr4277525qtx.263.1656534125832;
        Wed, 29 Jun 2022 13:22:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a414c00b006aefe22d75bsm13623046qko.80.2022.06.29.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:22:05 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:22:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/6] pack-bitmap: prepare to read lookup table
Message-ID: <Yry0bKgayLB3GdsW@nand.local>
References: <Yrol2tY4emxmYh9n@nand.local>
 <20220628085950.19288-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628085950.19288-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 02:29:50PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
>
> > ...exactly my thoughts, too. It's possible that it would be faster to
> > key this search on the object_id "oid" above, and then convert each of
> > the entries in the lookup table from a uint32_t into an object_id by
> > calling nth_bitmap_object_oid() repeatedly.
> >
> > I *think* that what Abhradeep wrote here is going to be faster more
> > often than not since it makes more efficient use of the page cache
> > rather than switching between reads across different memory mapped
> > regions at each point in the binary search.
> >
> > But of course that depends on a number of factors. Abhradeep: if you're
> > up for it, I think it would be worth trying it both ways and seeing if
> > one produces a meaningful speed-up or slow-down over the other. Like I
> > said: my guess is that what you have now will be faster, but I don't
> > have a clear sense that that is true without trying it both ways ;-).
>
> Ok. Let me try both the ways. In my opinion, I think my version has
> less searching and less computation. So, I want to stick with this
> version. But I also like to try the other one once so that we can
> get the best out of these two.

Yeah, I agree with your general sense that the version as written is
going to be faster. We're comparing a smaller datatype (IOW, a 4-byte
integer that can be checked for equality in a single instruction,
instead of comparing two 20-byte OIDs), and likely flushing the cache
far less often.

But having two concrete implementations to compare will help us know for
a fact that our intuition is correct.

I'll be curious to see what you find here!

> > I think starting off with a small array and then letting it grow
> > according to alloc_nr() would be fine here, since it will grow more and
> > more each time, so the amount of times we have to reallocate the buffer
> > will tail off over time.
>
> What should be the size of that array?

I think some small, power of 2 would be a reasonable choice here.

> > If we were really concerned about it, we could treat the buffer as a
> > static pointer and reuse it over time (making sure to clear out the
> > portions of it we're going to reuse, or otherwise ensuring that we don't
> > read old data). But I doubt it matters much either way in practice: the
> > individual records are small (at just 4 bytes each) and entry_count is
> > often less than 1,000, so I think this probably has a vanishingly small
> > impact.
>
> Before submitting it to the mailing list, I did use the ALLOC_GROW macro
> function. But my version was worse than yours. For every iteration I was
> reallocating the array to support `size+1` positions. But later I drop
> the code as this might be very much expensive.

That shouldn't be the case. When you have a chance, take a look at the
alloc_nr macro, which shows how much memory we allocate at each
step:

    #define alloc_nr(x) (((x)+16)*3/2)

Suppose we allocated 16 slots initially, so nr (the number of entries
stored in the list) is 0 and alloc (the number of entries allocated) is
16. Then when we try to add the 17th item, we'll pass 16 to alloc_nr
which will allocate 48 slots. Then 96, then 168, and so on.

We only have to reallocate and copy the array when nr > alloc, which
should be fairly infrequently, and happens less and less often the
larger the array grows.

Thanks,
Taylor
