Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F07C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDA62137B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5lB6LzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKMF0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgKMF0R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:26:17 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B8C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 21:26:16 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id k12so2643449uae.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8qbL2nhxKE0Uj03RmNHHx9h2V6k5/BW8sue4yLOU6Q=;
        b=a5lB6LzKqoQvz48Dhpe/dreKpIU0iAnwiJeIJIetvCYJVXUCZOwX+jcB42sHh/P4Bh
         Qn7GREKKnoI81cFZolqd7mEAprgA+hY70mJb15zFvZxIo6bnldyMRm5hqnIJellmRNwq
         R98ZJ1SmMvkXMp1epAqNLS5RcVEkYKJ4mPSviQxRv77h2XNmBkprP0GSzvJOmVpqlOte
         5601OGQkRVZzxoDOkq7v4SJ8lWls1i34JAwYPL5begFzlEntg2P1CiUFG7d6dvLevcEs
         TjKsxZ7uQ15NhiPyoHwLNKrxLpu4yYB+4HmkdzsbRXPZz4VCLnsEJZhyqOp04PuVtOFw
         CbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8qbL2nhxKE0Uj03RmNHHx9h2V6k5/BW8sue4yLOU6Q=;
        b=sQ205X1tMVnLo8v7Dqu0y/x8d9VeI9eiRRo1pf5+iVAFbxC5MMDVxjN7bylI7tUBLO
         ccdhkvZAblfwtlIC4HRs30JtBjQjCXbmMqmCdyKglsSScEGmS0+NuMb7Gr1W7UUw8EB7
         t9NGKOV6jBlKgk7a+uDb1wDW6A1iNYZ77dSi07AYVc+1PAA4UTQ44M4Ylz7/AunFxMgI
         7KFr1t3Y7m9riiRfnZZSH5RW6ZWB392FTIBhDJ6wjR+22UQcOCyc2df1ZA9WnKzCTnq4
         /Kq03QAW9b6zntuQmhu7xY+3TjNAuWKlY5F3wGs8iYX/qbrBmsx2/97veTtugRXiLQOO
         m6Hg==
X-Gm-Message-State: AOAM530fDi2aL52RllJnrRhf1tTV0pksG463+FJtfgJIGq7r+i4HUiWq
        77o4pjTo/w0GsL21pgzBtc9lN3fL1rKNFomZ04A=
X-Google-Smtp-Source: ABdhPJyFlqYhAjLQzlBlZMoHZUHpkQFXWWV5DpW6JrLGeVH9CQ957GMyorjtis3ZKGTfX8pmIO+XwdeJBZgAFQBDbM8=
X-Received: by 2002:ab0:2606:: with SMTP id c6mr147930uao.62.1605245175250;
 Thu, 12 Nov 2020 21:26:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605123652.git.me@ttaylorr.com> <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
 <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com> <20201113045700.GA743619@coredump.intra.peff.net>
In-Reply-To: <20201113045700.GA743619@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 13 Nov 2020 06:26:02 +0100
Message-ID: <CAN0heSpQURCY4xnLHzq8ok7as-YUq4VingPrZ-NJnetsv-RG1w@mail.gmail.com>
Subject: Re: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Nov 2020 at 05:57, Jeff King <peff@peff.net> wrote:
>
> On Thu, Nov 12, 2020 at 06:47:09PM +0100, Martin =C3=85gren wrote:
>
> > > +               uint32_t cache_size =3D st_mult(index->pack->num_obje=
cts, sizeof(uint32_t));
> >
> > Hmm. If `sizeof(size_t)` is 8, then this multiplication can't possibly
> > overflow. A huge value of `num_objects` (say, 0xffffffff) would give a
> > huge return value (0xffffffff<<2) which would be truncated (0xfffffffc)=
.
> > I think?
>
> Yeah, `cache_size` should absolutely be a `size_t`. If you have more
> than a billion objects, obviously your cache is going to be bigger than
> that. But most importantly, somebody can _claim_ to have a huge number
> of objects and foil the size checks by wrapping around.
>
> > Do we want a `u32_mult()`?
>
> Nah, we should be doing this as a size_t in the first place. There are
> similar problems with the .idx format, btw. I have a series to deal with
> that which I've been meaning to post.

Yes, that makes sense!

> >   if (cache_size > index_end - index->map - header_size)
>
> Yes, I agree this should be done as a subtraction as you showed to avoid
> integer overflow.

> >   -       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
> >   +       if (index->map_size < header_size + the_hash_algo->rawsz)

> Right. I think that's right, and the previous patch is just buggy.

Martin
