Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4617CC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AA321D91
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8gOR0yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKLRrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgKLRrW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 12:47:22 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3314C0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 09:47:22 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id p12so2137191uam.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnB4l5XnBiIFxPIIQ2XlxQhaobBt1sXQ1g4+Cile9Uc=;
        b=s8gOR0ygILrFG1C0owStVHxZySnuXNa9Mc43soKgLR6MgDkshko8p+YwiaM0vrYFWb
         2+0Gm4Dse3oeFuVpm2g32euWDWJeALIePX0/+F1vxv1io9C2gSMaML1jSnzaXWDY2Eih
         SLHCmVn530pkiu3KTAaRj6a9gyFvWG3Tt1frgrUqJhOdpWaTsjRJP0CIcdSaOGNvlz+x
         fVMQFx+pS3oB97ivAWtnt3bIoW+Mu7R9YxJO9wUpmqsqD68NFnSNa3tW79GebL6Cgo+4
         ibfyXa+k1klk7/NWt9qV9czkx4PX4njpya0euoWFaNNV/LPxZgRnLvZsbQR3/XRH/P4F
         hTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnB4l5XnBiIFxPIIQ2XlxQhaobBt1sXQ1g4+Cile9Uc=;
        b=fWjAEHWyTqJYGEaaxyFfBoFENFmcGKVTczkEMD9xbCSXPg+dODp365d3m+jKAt1m+e
         j9p9LDo/aq8zemjvFmI4UIPQ2Oxep/3IKQGJ66eKPuXWQgU8CaIVAjQCVSUTpsM7/9Ld
         ZmpMIlihi09k7y1Qw4yMF4vFytdEhKoMmLoY2ei3qYTuxThV1PKL8l2BWWGKav85t5aC
         0YT9tITOLzQBWhcOmOMafzNHsnBPD1N4BSolaa6O6IZx4arX127heqBLdLvkLM4xwf0d
         cWXXlDlRgnwK40ZOG4znwje4kONi7zG6/XGNlnldXnJ+ADp05ak3u1qN3akNDUxvr0cx
         CMyg==
X-Gm-Message-State: AOAM533/81JUUhYNT3EmzWox0gSBdfA9r7ZWEaajMKYwux6E8hwosE4Q
        a2wL3RbW3m5apttpHDRklYBZJIFIT0jUWAYVdnMXm/dvqb2ZZg==
X-Google-Smtp-Source: ABdhPJzgjNrvOInYG2moG0meILXj89z9VkVRooXiHZ/08YuskqiuRUY/SUxQKbrVpnNAi7XQ25h7eyQYOOoOSm+lHxM=
X-Received: by 2002:ab0:8b:: with SMTP id 11mr473403uaj.15.1605203241884; Thu,
 12 Nov 2020 09:47:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605123652.git.me@ttaylorr.com> <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
In-Reply-To: <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 12 Nov 2020 18:47:09 +0100
Message-ID: <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com>
Subject: Re: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Nov 2020 at 20:43, Taylor Blau <me@ttaylorr.com> wrote:
>
> A .bitmap file may have a "name hash cache" extension, which puts a
> sequence of uint32_t bytes (one per object) at the end of the file. When

s/bytes/values/, perhaps?

> we see a flag indicating this extension, we blindly subtract the
> appropriate number of bytes from our available length. However, if the
> .bitmap file is too short, we'll underflow our length variable and wrap
> around, thinking we have a very large length. This can lead to reading
> out-of-bounds bytes while loading individual ewah bitmaps.

> +               uint32_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));

Hmm. If `sizeof(size_t)` is 8, then this multiplication can't possibly
overflow. A huge value of `num_objects` (say, 0xffffffff) would give a
huge return value (0xffffffff<<2) which would be truncated (0xfffffffc).
I think?

Do we want a `u32_mult()`?

> +               unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;

The addition should be ok or mmap has failed on us. Do we know that we
have room for the final hash there so that the subtraction is ok? Yes,
from the previous commit, we know we have room for the header, which is
even larger. But that's cheating a bit -- see below.

> +                       if (index->map + header_size + cache_size > index_end)
> +                               return error("corrupted bitmap index file (too short to fit hash cache)");
> +                       index->hashes = (void *)(index_end - cache_size);
> +                       index_end -= cache_size;

If the header size we're adding is indeed too large, the addition in the
check would be undefined behavior, if I'm not mistaken. In practical
terms, with 32-bit pointers and a huge size, we'd wrap around, decide
that everything is ok and go on to do the same erroneous subtraction as
before.

Maybe shuffle a few things over from the left to the right to only make
subtractions that we know are ok:

  if (cache_size > index_end - index->map - header_size)

One could substitute for `index_end - index_map` and end up with

  if (cache_size > index->map_size - header_size - the_hash_algo->rawsz)

Maybe that's clearer in a way, or maybe then it's not so obvious that
the subtraction that follows matches this check.

But I don't think we can fully trust those subtractions. We're
subtracting the size of two hashes (one in the header, one in the
footer), but after the previous patch, we only know that there's room
for one. So probably the previous patch could go

  +       /*
  +        * Verify that we have room for the header and the
  +        * trailing checksum hash, so we can safely subtract
  +        * their sizes from map_size. We can afford to be
  +        * a bit imprecise with the error message.
  +        */
  -       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
  +       if (index->map_size < header_size + the_hash_algo->rawsz)

I *think* I've got most of my comments here somewhat right, but I could
easily have missed something.

Martin
