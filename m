Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EAC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088A46124B
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEaPaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhEaPZi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:25:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C2C04344C
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:15:46 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id c2so10087205ilo.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lgVc/4Q+m2QM8ExeHcpX38iGEWKGd4K5p2ftIuTUK/Y=;
        b=CrSH7u/6jgA4EsmG/JOMdvyh7vZDb0+br5I5Pae8AXWnEzXi9FCBT8ARjs56L/d3MJ
         22tkOk+tiAkHQEtW5LuWCELp4VgCK1gP7/jDvNoqtO/G/PTEnLtpgxMfDa0cb576AyQ2
         gKT4pI8Dp7oGOrBfFBreDWYvLs4nK5wRV2xtrzFK0P4SUDeOWVaVCZb0BjeIFwvwMh4c
         IVg5uryLSyMJKWOVIjh3if3b06/VAoRTYlz2pcF1azHftBdBKfG0mn5funDih+iVdzE4
         j2WWMj6DqvqBugY+Mn8mz+iSTk6HSoRrNJSsjDJD5lp74YCV5FV6qalMa0g4negl+lio
         hYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgVc/4Q+m2QM8ExeHcpX38iGEWKGd4K5p2ftIuTUK/Y=;
        b=fPKiELbQxQOptKh+3j4Op5+C7c1J73CixI2OfBSPPcNEy3cYyH5WwUH+78f2nfE4p/
         XG9Vy2EouQKCzA8YzFDglnuXP1EWQESNWPf5HU1YDOvlEp/4ZxKSxjLsrRofNVYG3spx
         TdUY6EawTDN2L9tE7JL/J7K1QH3N30nk+qFuhG0u58SM1t3/UOoa1rvp9rcG3MQQHCaX
         czEWmezMa8Rt4X+AoJRe8BWNRk8SY+VODKYZrdHuuP1tzCqqdj5srWdbF+I685z5sWkh
         VmWjw/4X9IxFPvegUcJIMYMKdg1oUK+FnG3KfsfUL1PTY3eGIyClpgGXPSuqfTs4LjnX
         TU9Q==
X-Gm-Message-State: AOAM530OWUegydTPFbsXn7njEoYJ4atNwc0UIBb0a1GEwKgcUPijgexB
        Zx4tlSzKlkYohfTEkCvtlLupUqRdwwvzse/sHvE=
X-Google-Smtp-Source: ABdhPJz408BxeHy+Qv0zEIqZG3vc78IHbC9pkPSY6Fb5VvIGPvKN0E6hNWiTZ6cdIkXXuoqBDjmtUvIt0wRZ28NiGWU=
X-Received: by 2002:a05:6e02:12c9:: with SMTP id i9mr4899494ilm.17.1622470545956;
 Mon, 31 May 2021 07:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch> <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
 <60b25ca7a01c2_265088208af@natae.notmuch> <CAOLTT8TEkrxAgHvkCVXZDQpn0xSQAe_y7uMF89Q4QWwVd7MDcA@mail.gmail.com>
 <2c28515c-89b1-79dd-35a2-492eac6b7347@gmail.com>
In-Reply-To: <2c28515c-89b1-79dd-35a2-492eac6b7347@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 22:15:34 +0800
Message-ID: <CAOLTT8QnWru=jHYUWt_vddPnUwzP5+h0dN2s-pcHpOy=ZC1+Sw@mail.gmail.com>
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

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8830=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:05=E5=86=99=E9=81=93=EF=BC=
=9A
>
> >   static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> >   {
> > -       size_t i;
> > -       const char *s1 =3D (const char *)vs1;
> > -       const char *s2 =3D (const char *)vs2;
> > -
> > -       for (i =3D 0; i < n; i++) {
> > -               unsigned char u1 =3D s1[i];
> > -               unsigned char u2 =3D s2[i];
> > -               int U1 =3D toupper (u1);
> > -               int U2 =3D toupper (u2);
> > -               int diff =3D (UCHAR_MAX <=3D INT_MAX ? U1 - U2
> > -                       : U1 < U2 ? -1 : U2 < U1);
> > +       const char *s1 =3D (const void *)vs1;
> > +       const char *s2 =3D (const void *)vs2;
>
> I think the new version looks fine apart from these casts. vs1 declared
> as 'const void *' in the function signature so this cast does not do
> anything. You could cast using (const char *) instead if you wanted but
> that is not required as you can assign a 'const void *' to 'const
> whatever *' without a cast.
>

Yes, forced conversion in "const char *s1 =3D (const char *)vs1;" is somewh=
at
redundant.

> Best Wishes
>
> Phillip
>

Thanks.
--
ZheNing Hu
