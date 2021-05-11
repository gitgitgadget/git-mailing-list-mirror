Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FFEC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B30611BE
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEKFxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 01:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEKFxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 01:53:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9CC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 22:51:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id zg3so27964847ejb.8
        for <git@vger.kernel.org>; Mon, 10 May 2021 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMtaOvEw9EotADzzH4CxKYbc0x6YCSMD5ilc16+v1ys=;
        b=HeJLBgX6waDEVGrmiYs+tFOuGRmCciSGKwtCgh6SEgfV7bw0nIVwWC7LNwb1pmxfJJ
         XPxzD3mM/GZpobg2anoPQuo/E5gO1/IK3oWz42mKCQdr7bZ9Y7scwc6G0gdILG237Bi7
         faE/Utpw6OKBw45efN7gIYD4L+8pxa5lnZ5YT3/3t9ngmsboXO+BtU0BPBoCogwM6ml+
         VBLCK8OPxUDInkAh1DZ/SXcqOjBbd+3406HyOcWXL7FN0RUx16A3Rp0iG+Mwmoia6zJe
         ltwpCPh1rjob+7SpegYLo0m8Oy2iEycHuIo13JOjQjDeitaNWe+FL5sP4RK5f6R02XLf
         E6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMtaOvEw9EotADzzH4CxKYbc0x6YCSMD5ilc16+v1ys=;
        b=NELr3r2F7zZXWn/rJerY5Ac+7yEUv5rzs8a/Oo7YA45JsYyOWOzEohStDWqkEt0aj1
         vOLqGDesm/zl+j5Ckj19YXGmJ06etqx8OnY5k4ENcTpYy4xXkwErFJiWr+gAypx2BULD
         nwxSR/ZJAjb5t4M8l5gy8O9VrnQxQJShjUOIFj8100yR28nzdFfOS0iRp7CX3DS3iyxI
         8LyB4ypnVhT6ALvuGo66K7kibeD3U4yceBakQZ4rETyUUEip60P1nwBjiXxmGUXKGMjX
         foRavJUF1wyay73mzajDVtSS8yN9rJgDz3T92UtB7vWko+m/peby/LRpSvn4UoNbUcIO
         YY7g==
X-Gm-Message-State: AOAM533LewyJ0biT1SiYA20+ccNeuP+sDSdq9JErcnq6sZZYc1jkpQ+1
        HI02BY+o6257BN+SmU+M/qSMblE4fqUjS5yz5nE=
X-Google-Smtp-Source: ABdhPJyJR8GMCkvds429i0vCWQ/IMZ1zc+38nGXr7p/sQRXhdQfn1scyj4QgC6jApIEZpdB/XZo2pKfAX9htiQ/qD20=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr12577306ejh.341.1620712315733;
 Mon, 10 May 2021 22:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
 <pull.951.v2.git.1620659000.gitgitgadget@gmail.com> <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
 <xmqqh7jaow31.fsf@gitster.g>
In-Reply-To: <xmqqh7jaow31.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 11 May 2021 07:51:44 +0200
Message-ID: <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 4:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> > +/*
> > + * The enum atom_type is used as the coordinates of valid_atom entry.
> > + * In the atom parsing stage, it will be passed to used_atom.atom_type
> > + * as the identifier of the atom type. We can judge the type of used_atom
> > + * entry by `if (used_atom[i].atom_type == ATOM_*)`.
> > + *
> > + * ATOM_UNKNOWN equals to 0, used as an enumeration value of uninitialized
> > + * atom_type.
>
> Shouldn't it be (-1)?

If it's -1 instead of 0, then it might be a bit more complex to
initialize structs that contain such a field, as it cannot be done
with only xcalloc().

> And I'd assume I am right in the following.
>
> > + * ATOM_INVALID equals to the size of valid_atom array, which could help us
> > + * iterate over valid_atom array like this:
> > + *
> > + *   for (i = ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
>
> I find it far more intuitive to say
>
>         for (i = 0; i < ATOM_INVALID; i++)
>
> than having to say UNKNOWN+1.

Yeah, that's more intuitive. But in my opinion, using `ATOM_UNKNOWN +
1` instead of `0` at least shouldn't often result in more lines of
code, and should be a bit easier to get right, compared to having to
initialize the field with ATOM_UNKNOWN.

> In any case, the values should be indented, and a comment should
> ensure that the final one stays at the end, perhaps like this.
>
>         enum atom_type {
>                 ATOM_INVALID = -2,
>                 ATOM_UNKNOWN = -1,
>                 ATOM_REFNAME,
>                 ...
>                 ATOM_ELSE,
>                 ATOM_MAX /* MUST BE AT THE END */

I agree that a comment telling people that it must be at the end is good.

>         }
>
> (note that the trailing comma is deliberately omitted).

Yeah.

> It would allow people to say
>
>         for (i = 0; i < ATOM_MAX; i++)
>
> instead, which would be even nicer.

Yeah, it's also a tradeoff to have the last one called ATOM_MAX
instead of ATOM_INVALID, and to have a separate ATOM_INVALID if it's
needed.
