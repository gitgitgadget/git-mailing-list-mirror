Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0188DC43461
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C587161921
	for <git@archiver.kernel.org>; Tue, 11 May 2021 12:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhEKMjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhEKMi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 08:38:56 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E5C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:37:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z24so17990387ioi.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h6LZ9aEpU752BaPRhz8BKVSP7eTOeHZBLvld+0By/us=;
        b=NPG/q+vyHyF6JMFKDqYWb7BI6rcUFkNZgIPMfWOb9SLUFLrkW4CRhLGUz5NKMacBAo
         Tz506nUWxAsyZ8+2QrwWzNpbAwQIHZIjKW8HPDR4RbiRaksEhcDhA6Pb4Fym2O9iOJn3
         K3JAB+xn73UEtFVKuAXktMzcXo3y4OpfUi89FBiyN3UWPh8c5OHfVM/QLxUjk3kByz+w
         P6pIzhUNk7X187fzoF3jXbQHTwAIYvCH4my6BuCHHJHwHDXKmceCAdAehl80RtRmlY0U
         uz27g1pweBGM+iu02sJB/BBzdXenhSpRFQgH43ScYt3asJgkL3mKIXlQ+t8K07mFB1HI
         r/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h6LZ9aEpU752BaPRhz8BKVSP7eTOeHZBLvld+0By/us=;
        b=oiKVvc3geQ0G5cPX9aCZtVa9kNBLFvE1uekMp8URu7okKyiC+7n1K55hckIBm7RTUN
         IivI/1J+d/yG4rxIXy7DG90eiABAqjWnu9La7YtTIdYbx96TntAiUjS8ZHj/Ei00Wd4Q
         ffMgCnR8DSsFCNvxRk4QDlwPA5BmzS+D5oi7DN86Cm32CVtAVwmVgixFKUbZPC0xFDwD
         B/mgKZa1yBAoFQF526OKSKpFLY8On66F4Z1i+afmt0kmcJooMUzVBrwUWIm+LDUTJf96
         2ZXpCE6WUKcZPaU8qz8MbwBDg6PsAwjFT4wI1r0IEhbRYVubIB4fDKukLih2ILJgEQeC
         7fTg==
X-Gm-Message-State: AOAM530XE99hjjLQp9pqY4oLx0sx0o6yB9UeVMubL7TethtltbskhwQK
        EiNOGGivzudG3zmvJ6MMGu86EVnYrcsVEgFqK73GEBKsFGG/8Gef
X-Google-Smtp-Source: ABdhPJwc6mzQ5UfuybAGG+UeorRu71F++w5asabQ0mf2ai57nTwwZaVDhQjDPDUAaj+wxJMSmg4+jsnnDi8fUPzPcOs=
X-Received: by 2002:a02:84a5:: with SMTP id f34mr26272120jai.50.1620736669179;
 Tue, 11 May 2021 05:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.git.1620487353.gitgitgadget@gmail.com>
 <pull.951.v2.git.1620659000.gitgitgadget@gmail.com> <a1f70b39b7efbadff9e2202968dd1ca65ea3c1b4.1620659000.git.gitgitgadget@gmail.com>
 <xmqqh7jaow31.fsf@gitster.g> <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
In-Reply-To: <CAP8UFD3m0TA3nPDaPhaU3=FVF_r5cPM8xksVL6MpCOhNC4dT3g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 May 2021 20:37:33 +0800
Message-ID: <CAOLTT8RP9B7mmP+zfgdjrP+jjoBgJyeWmxnJitOFM87JraXCFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: introduce enum atom_type
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8811=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:51=E5=86=99=E9=81=93=
=EF=BC=9A
>
> >
> > Shouldn't it be (-1)?
>
> If it's -1 instead of 0, then it might be a bit more complex to
> initialize structs that contain such a field, as it cannot be done
> with only xcalloc().
>

I agree. If the traverse start from 0, an init atom_type will have
"ATOM_REFNAME" junk value. If let users manually adjust it to
ATOM_UNKNOWN, it seems to be very troublesome.

> > And I'd assume I am right in the following.
> >
> > > + * ATOM_INVALID equals to the size of valid_atom array, which could =
help us
> > > + * iterate over valid_atom array like this:
> > > + *
> > > + *   for (i =3D ATOM_UNKNOWN + 1; i < ATOM_INVALID; i++) {
> >
> > I find it far more intuitive to say
> >
> >         for (i =3D 0; i < ATOM_INVALID; i++)
> >
> > than having to say UNKNOWN+1.
>
> Yeah, that's more intuitive. But in my opinion, using `ATOM_UNKNOWN +
> 1` instead of `0` at least shouldn't often result in more lines of
> code, and should be a bit easier to get right, compared to having to
> initialize the field with ATOM_UNKNOWN.
>

There will be a trade-off. Traverse from 0 or does not need to adjust the
initialized atom_type =3D UNKNOWN.

>
> > It would allow people to say
> >
> >         for (i =3D 0; i < ATOM_MAX; i++)
> >
> > instead, which would be even nicer.
>
> Yeah, it's also a tradeoff to have the last one called ATOM_MAX
> instead of ATOM_INVALID, and to have a separate ATOM_INVALID if it's
> needed.

About ATOM_MAX or ATOM_INVALID, I have a idea:

enum atom_type {
ATOM_UNKNOWN,
...
ATOM_ELSE,
ATOM_INVALID,
+ATOM_MAX =3D ATOM_INVALID
 };

This might be able to do both.

Thanks.
--
ZheNing Hu
