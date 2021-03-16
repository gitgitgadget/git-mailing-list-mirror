Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6ADC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F8865001
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhCPIf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbhCPIfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 04:35:36 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A664C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:35:36 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id n6-20020a4ac7060000b02901b50acc169fso3930926ooq.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Di+URnLL5AdCrln1Uhbk3REM7OgvCsZLGam1AmIC0qY=;
        b=X2dGkeBayPyPo9wmpxkIe9TxLZztOyJAqsylbJLIFXF5Lz1aCVvpHL9DoLSJbNeJJH
         D1vG0qrVKC85KwF/oza1xYWUZKY8R2xOk4wQdvAgokzyu6La/LNkGP86tIjBFMIbYsvD
         P7eKooPKEZYXPcEozuDWMutsKg/ouxB8n2SCugrSiR5q3jfd9smxDit/IRD1cVhGBAtq
         exXrtlT6aGOZqlOchyfDXMjxF14cBnT4qdIa208SGzBVyAf/OIdnP7oC6nDXqZwscoju
         HFuYPZt81d2HEygo98U4FS57PtAGYlXjwF3LyX9jbNrHjtuxVKHqwX6UM3EIezOM77PU
         VLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Di+URnLL5AdCrln1Uhbk3REM7OgvCsZLGam1AmIC0qY=;
        b=umy4ShbIV5v6hauZTW7iKtkyUi8c/ptrrPlJFoEEsDJ9WSdNxFCIYbmzB+Ovunmr9J
         ArBsIwkQLzGvKrxejSPmSFROiJg6xzVdq4APE69t1iM3SChraqWjXNuNYiHyOolmdtqp
         7yEIWSOVf+BMaixn1ceak5v0h/W1Ig2Naa+7NgpcbNbC42XsywjqksReJz8IMpWcjZst
         yrLRQYcMRMUvI5FzoGZg93jWpVHWpxM08Vnr/wwDMJndJ4bOIaNEur+prB7Er6mD7vi5
         mnRKXCpStITi5q6h/hmVV8RNnKxUlBMz+2aR34bbHUI8EAvlobBP20+MtYVjOEjnbxDQ
         C3Bw==
X-Gm-Message-State: AOAM530ro8iq0vZ36wrEzJ5a4pL8GNb3x5/6d8j76i+skAe6LWf8PWxx
        GbKj+7K7QqKBjWs2N4iBP3GWwNKLmwgd/OlfqsJmih69wtydFkXf
X-Google-Smtp-Source: ABdhPJywSSaXmrD1yl1I9T9bp9T7Rrb6THnoyG1SbhrePHNQlA5/VKHEqK0lb6yfff9DOlwbpN9XhAkJhpL1Yz95xec=
X-Received: by 2002:a4a:4958:: with SMTP id z85mr2807502ooa.3.1615883735536;
 Tue, 16 Mar 2021 01:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
 <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com> <CAP8UFD2CNAW4o8BF8NLA0pwWzNmBwZJAP7L5SGSib+LcVbSLBA@mail.gmail.com>
 <CAOLTT8QTxnykacdDaMjZMkEqTHPSrPz6HH-bSgbECo5tUgf5Gg@mail.gmail.com> <CAP8UFD0+xVTD4t=dgAx0YYxw5G5VinQL1VR+5KW+GypNg1o=Kg@mail.gmail.com>
In-Reply-To: <CAP8UFD0+xVTD4t=dgAx0YYxw5G5VinQL1VR+5KW+GypNg1o=Kg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 16 Mar 2021 16:35:24 +0800
Message-ID: <CAOLTT8Q9YX=Yw22xx4GYGf-2fPd6_UfqGCyxOtK4au8000etCQ@mail.gmail.com>
Subject: Re: [PATCH v7] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8816=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:37=E5=86=99=E9=81=93=
=EF=BC=9A

> > Thanks for reminding, generally speaking, we will put the trailer at th=
e
> > end of the commit messages.Take trailers in start, this should be
> > something I haven't considered.
>
> In general what I want to say is that `git interpret-trailers` should
> be considered to have sensible defaults, that can possibly be
> overridden using a number of config variables (or the git -c ...
> mechanism) which is a good thing. If something in it doesn't work
> well, it's possible to improve it of course. Otherwise it's better to
> just fully take advantage of it.
>
> > I notice another question:
> > if we commit this again with same trailer (even same email or same comm=
iter)
> > `--trailer` will not work again, because in `interpret_trailers`,
> > "if-exists" default
> > set to "addIfDifferentNeighbor", I addvice enforce use "if-exists=3D"ad=
d".
>
> I don't agree with using "--if-exists=3Dadd". I think the default to not
> add a trailer line if it would be just above or below the same line is
> better, as doing that wouldn't add much information. It's better to
> encourage people to use trailers in a meaningful way.
>
> And again if we use "--if-exists=3Dadd", then people who would want to
> take advantage of `git interpret-trailers` to customize what happens
> when the trailer already exists would not be able to do it.
>
> For example if we don't use "--if-exists=3Dadd", then:
>
> - people who want to customize what happens when the trailer already
> exists can do it with for example:
>
> git -c trailer.ifexists=3DaddIfDifferent commit --trailer
> "Signed-off-by:C O Mitter <committer@example.com>"
>
> - which means that people who want the "--if-exists=3Dadd" behavior can
> still have it with:
>
> git -c trailer.ifexists=3Dadd commit --trailer "Signed-off-by:C O Mitter
> <committer@example.com>"
>
> While if we use "--if-exists=3Dadd", then using `git -c
> trailer.ifexists=3D... commit ...` will not customize anything as the
> "--if-exists=3Dadd" command line option will override any config
> customization.

Well, I see what you mean, this will keep git better flexibility,
give users more personalized configuration options.
And this should be more in line with git design philosophy,
I will follow your suggestion.
