Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D81C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60F1613AE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhFAKjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhFAKjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 06:39:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B4C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 03:37:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z1so12467078ils.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0gk5ys5FrNH717DsCrU2Bqp5sHRachMjC74Pp8iy58o=;
        b=sCF0zLcsurryMH+05pCnLw2JkVDYaaI4/oo1vcimr1jz5c41+kdnR27h5MCOxf7C3s
         6UbrsR24gjMW/+Yi1V3kpulUVSiIuuq2Dl/nhpggvj+XnD64XXdhyTxDWWRaoj+/jJqc
         g895ng2rM4vJK0PxV6gp4txEXiDpillJ/HvTNp58DwT3JDe4XapwoGE9eGIEFZ0oFfX3
         3hNJ9JH0cZTa+dLpzXp0zg4vh4U/WJlaAjJcugRWv4QPOtZ1YlGGi4/7fdHs0kuitTRi
         xMJ7o1wKTsDWksShhsv//KCuYT+fFUNMK4hBybtA1Dexi3Act4cUzPSL49N4KVFTDLRo
         7Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0gk5ys5FrNH717DsCrU2Bqp5sHRachMjC74Pp8iy58o=;
        b=N5XaUmuJce23vnFXNp4yACjBxBSpHwtgrcLGN7Cse1OUG7VK5mEl2D4moNNsUYv29v
         u2tvXa9GwTp1KOw7eivW1p5H6MlSrubSOR8V8BQMVEXjWhS7NGhPyfgzr4AoOTLzbUC+
         96Zsiz6oYi+XNizKD9g+b8+AwtRlqbaSNLAU1n4mnd1NxonfLbUTAewHXKZcNlCEUTRT
         LlstHVpGbCv2XZO/BxcaAXBFYSHFA4cW1RaoDkGzdsJvDrEmEsWc28dT6jCzyT8yXhFl
         g8Bdy+X9beJ5FiIBwR+sdXheeKU6w/GRpbw1/uTGO2NL7MrbAsStGCvwG6usC+pO0R0b
         YhRQ==
X-Gm-Message-State: AOAM533xR0+jHP5KRefEW8fR4cwCh32w6Vof6IKeGjPTpK+nZdPGiSs0
        2Ng6N06k8Yuj+qIS3GgSjj5lPU4pTNH7mP9CfTI=
X-Google-Smtp-Source: ABdhPJyHQGohxIvg0b+QUSWhTQIlI1P38JOAjwDxBUpniXret72Bjra2htouFNGTAgDqNTvjxsKmThylbPepVWeqFnc=
X-Received: by 2002:a92:2004:: with SMTP id j4mr21904733ile.53.1622543846976;
 Tue, 01 Jun 2021 03:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <pull.963.v2.git.1622379718.gitgitgadget@gmail.com> <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
 <60b503ab859d_24d282087@natae.notmuch>
In-Reply-To: <60b503ab859d_24d282087@natae.notmuch>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 1 Jun 2021 18:37:15 +0800
Message-ID: <CAOLTT8SXYGVxHfZVu9gp6ZSE0xNY+kM9Lq4ifApOr3JixsScDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8831=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:41=E5=86=99=E9=81=93=
=EF=BC=9A
>
> ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
>
> > +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> > +{
> > +     const char *s1 =3D (const void *)vs1;
> > +     const char *s2 =3D (const void *)vs2;
>
> As I explained in another mail, I think this is better:
>
>         const char *s1 =3D vs1, *s2 =3D vs2;
>

OK, I understand it now.

> > +     const char *end =3D s1 + n;
> > +
> > +     for (; s1 < end; s1++, s2++) {
> > +             int diff =3D tolower(*s1) - tolower(*s2);
> > +             if (diff)
> > +                     return diff;
> > +     }
> > +     return 0;
> > +}
>
> --
> Felipe Contreras

Thanks.
--
ZheNing Hu
