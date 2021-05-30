Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E8AC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1AA610A6
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhE3G2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 02:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhE3G2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 02:28:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A6DC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:26:33 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a6so8711606ioe.0
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8jk/ZJpggdn7IWyJtibu57k39M2u+L0FsSmA2oAgtdE=;
        b=N3jWPiQeHOdjQ3Kt3fPvbkiagcwt0s8FAhIWEo0W/HVXK4xhJSN2FdXRcBDvqxErVo
         9SqAqn3PqL6rznIVZ9ABYK839PCt98JZ509fdf497btoZclsjmnlbxurMbqexfPEetcz
         iQsz6dpY6Ab/vZR+rKeH2bfGitz26fb6bZAwBUaz2RzpqJf4aS3OZCYMoinuyykWw7Q8
         MGnRZpF85d1jPJovMuHmqRhO3yylRZqT6VqKnWrVi5dAhX2ODgwP6X5jnwfAo7lpfewr
         ua4K+g1M/g/yCINHatVRkurSXFZ/fXCNRPKfktjkRLuWHuTRzH8qSrWvK5fCp2h9Q4Zp
         ZkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8jk/ZJpggdn7IWyJtibu57k39M2u+L0FsSmA2oAgtdE=;
        b=gvyKgO7yyHQTtr8VcW6kfaqkWQC2EdBuXi35H6EwS/58QzN1jynZJbk5V6JKBdg4U8
         shKUn4wadVj+LMSwThJiKS0pamAWNnwtdYOQIBHEWkPhCkvWYSbsV8rUBojOquqDvDbU
         aMAXb3JCgxC+5kX/hAvCWcNZ+RiL4sXwNwp3ABGRx5fEw+s/tha+DgK2e/X9BC6QfFFr
         5IwMIzB6HfWJXwJ9AlN9awOQ7bVeuEveK3JyaPyMYNdR8j4VRhzX95RnapozLXaMJMol
         l8H3S96phttYsRtwu0wAxDQ5wB6/HKIYLK1HEfr+r8URwD3YqzJUN11iyg/i4oTzveWk
         HdEA==
X-Gm-Message-State: AOAM533Hyqjl1JFGkmjB8VQCUO9TK4VFwXwjbjaRB1uSVFuA2HscR2yQ
        nyEYcrmUf/DhpzZVQdYin1BwcYixNO8m7NDRYqw=
X-Google-Smtp-Source: ABdhPJzhcEWa3lhBooGTdLcYyUFmFp8/vSHah2HVOl4ciMw06fTWPwYFa4/ntq0SJWxr4pKSa9yWMuyyujPcwWFMdDw=
X-Received: by 2002:a02:647:: with SMTP id 68mr3711272jav.29.1622355992624;
 Sat, 29 May 2021 23:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch> <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
In-Reply-To: <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 30 May 2021 14:26:20 +0800
Message-ID: <CAOLTT8QmByyue25YLTa2-=oQ00K5Cs_eoSD3_y6wRYYToa=oxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8829=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:23=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 27/05/2021 17:36, Felipe Contreras wrote:
> > ZheNing Hu via GitGitGadget wrote:
> > [...]
> >> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> >
> > Why void *? We can delcare as char *.
>
> If you look at how this function is used you'll see
>         int (*cmp_fn)(const void *, const void *, size_t);
>         cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
>                         ? memcasecmp : memcmp;
>
> So the signature must match memcmp to avoid undefined behavior (a
> ternary expression is undefined unless both sides evaluate to the same
> type and calling a function through a pointer a different type is
> undefined as well)
>

I agree.

> >> +{
> >> +    size_t i;
> >> +    const char *s1 =3D (const char *)vs1;
> >> +    const char *s2 =3D (const char *)vs2;
> >
> > Then we avoid this extra step.
> >
> >> +    for (i =3D 0; i < n; i++) {
> >> +            unsigned char u1 =3D s1[i];
> >> +            unsigned char u2 =3D s2[i];
> >
> > There's no need for two entirely new variables...
> >
> >> +            int U1 =3D toupper (u1);
> >> +            int U2 =3D toupper (u2);
> >
> > You can do toupper(s1[i]) directly (BTW, there's an extra space: `foo(x=
)`,
> > not `foo (x)`).
> >
> > While we are at it, why keep an extra index from s1, when s1 is never
> > used again?
> >
> > We can simply advance both s1 and s2:
> >
> >    s1++, s2++
> >
> >> +            int diff =3D (UCHAR_MAX <=3D INT_MAX ? U1 - U2
> >> +                    : U1 < U2 ? -1 : U2 < U1);
> >
> > I don't understand what this is supposed to achieve. Both U1 and U2 are
> > integers, pretty low integers actually.
> >
> > If we get rid if that complexity we don't even need U1 or U2, just do:
> >
> >    diff =3D toupper(u1) - toupper(u2);
> >
> >> +            if (diff)
> >> +                    return diff;
> >> +    }
> >> +    return 0;
> >> +}
> >
> > All we have to do is define the end point, and then we don't need i:
> >
> >       static int memcasecmp(const char *s1, const char *s2, size_t n)
> >       {
> >               const char *end =3D s1 + n;
> >               for (; s1 < end; s1++, s2++) {
> >                       int diff =3D tolower(*s1) - tolower(*s2);
> >                       if (diff)
> >                               return diff;
> >               }
> >               return 0;
> >       }
> >
> > (and I personally prefer lower to upper)
>
> We should be using tolower() as that is what POSIX specifies for
> strcasecmp() [1] which we are trying to emulate and there are cases[2] wh=
ere
>         (tolower(c1) =3D=3D tolower(c2)) !=3D (toupper(c1) =3D=3D toupper=
(c2))
>

I don=E2=80=99t know if we overlooked a fact: This static `memcasecmp()`
is not a POSIX version. `tolower()` or `toupper()` are in git-compat-util.h=
,
sane_istest('\0', GIT_ALPHA) =3D=3D false . So in `sane_case()`, whatever
`tolower()`, `toupper()`, they just return '\0' itself.

> Best Wishes
>
> Phillip
>
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/
> [2] https://en.wikipedia.org/wiki/Dotted_and_dotless_I#In_computing
>

Thanks.
--
ZhenNing Hu
