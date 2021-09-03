Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E956C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFC160F4B
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbhICCeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbhICCeS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 22:34:18 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C902C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 19:33:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so3869365ilm.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppMRHa75TqTKMiG72RXGkemx5pkwe7GZ9ca2yvWslNE=;
        b=K95SUDVAewrg3D/N+mIUtsTvuWt0TrZsLQWQMQyOvo0TVpnWY4OACe4i8OrR3X9Jx0
         ZDNzZwYPIZOIIo5fBf8hV0idmfZHYi8HWJtL2dqa1FN7MjlN2HqTebAGvV90jh/w+xpg
         3dLuyOosIyHvE4Y2wxlgx+aZdieXo7+UNiUHujfmQh+VrqZfzN3vO0UqIZujZcHP03qW
         aqF5xNku2/ypHVKrCZhP57KwucZidFLnm+EVf9ZVHUnJxavpyFZ1GfTQcp9aR3YoBA6Z
         Fuf8TpR37XF7zylDmQlpARGrqOC03ZpT0zFsaj8gYMT1Eu44p8OO5pUx24z/ZxT7HQrq
         lppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppMRHa75TqTKMiG72RXGkemx5pkwe7GZ9ca2yvWslNE=;
        b=W/TQbrdoAt3L4dYM9gkTzJN0+KNtMXH3JFeREymOZMyCKfLpE5m8xAPR0ea9wVgODN
         WYv7aPOEHI4ymqAZBYy66QaQIXLRv/ir3T0tPyXqfotDv/uesU9Q8mS72eEETA4PyAeb
         O98ddCJCbwCwgtakKGM8Xrx8isXQgxAWqcQReQczo++eH43lmgBTjnX9bmSQuISp19Nx
         R/5WoKjnCVvf8k/0KZmWCsmXh+OUR/sbAKGPLO0haBUiGJwX6HC/KYoyHgLJapUQGANI
         JvXDQF3k6hbfCwNX+X8YXqovBWMYY+yQxWxxz+9QAbCJSyAefIfRaMCGjVWO1LfEVQiw
         j9bQ==
X-Gm-Message-State: AOAM530dn0PMzgTlgiiKvwman84aIcu9KK2b9PxyHiYCX1muGMZwovL9
        qC1Ml5JWgQS5cSu+WxaVCfqNVbwLaou1sMM9
X-Google-Smtp-Source: ABdhPJzIRrTfsgsqeo+JIDiKi1az4O/uNzZTCEl6uZ90jW4L9AdLFRWTwJXEpTJngjnYz2FV3TOQJQ==
X-Received: by 2002:a92:c841:: with SMTP id b1mr929565ilq.300.1630636398765;
        Thu, 02 Sep 2021 19:33:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t15sm2006377ioi.7.2021.09.02.19.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 19:33:18 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:33:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] builtin/pack-objects.c: simplify
 add_objects_in_unpacked_packs()
Message-ID: <YTGJbYmq7O2OvqIJ@nand.local>
References: <cover.1630291682.git.me@ttaylorr.com>
 <c857e12a032f197626cd6a5eb0eafc66afbb5bed.1630291682.git.me@ttaylorr.com>
 <YTFYhG+nK49/jR/v@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTFYhG+nK49/jR/v@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 07:04:36PM -0400, Jeff King wrote:
> On Sun, Aug 29, 2021 at 10:48:54PM -0400, Taylor Blau wrote:
>
> > +static int add_object_in_unpacked_pack(const struct object_id *oid,
> > +				       struct packed_git *pack,
> > +				       uint32_t pos,
> > +				       void *_data)
> >  {
> > [...]
> > +	struct object *obj = lookup_unknown_object(the_repository, oid);
> > +	if (obj->flags & OBJECT_ADDED)
> > +		return 0;
> > +	add_object_entry(oid, obj->type, "", 0);
> > +	obj->flags |= OBJECT_ADDED;
> > +	return 0;
> >  }
>
> This is not new in your patch series, but while merging this with
> another topic I had, I noticed another opportunity for optimization
> here. We already know the pack/pos in which we found the object. But
> when we call add_object_entry(), it will do another lookup, via
> want_object_in_pack().
>
> [...]
>
> It would also probably involve some slight refactoring of
> add_object_entry() to avoid duplication (though possibly the result
> could reduce similar duplication with the bitmap variant). Hmm, actually
> looking further, we already have add_object_entry_from_pack() for
> --stdin-packs.

I was trying to remember how I handled this for cruft packs (which want
to take a slightly different path to add_object_entry() in order to
record the object mtimes along the way). Indeed, in that case there is a
special add_cruft_object_entry() which uses pack and offset directly.

Having looked at all of these functions which are layered on top of
add_object_entry() recently, I tend to agree that there is some room
for clean-up there.

I plan on sending the cruft pack series soon, after I untangle all of
the `repack` + multi-pack bitmaps stuff, so perhaps that will be a good
time to pursue this.

Anyway, just to say that I probably agree that the pack mru cache is
helping us enough to make this negligible, but that it is on my mind and
we'll have a chance to look at it soon.

Thanks,
Taylor
