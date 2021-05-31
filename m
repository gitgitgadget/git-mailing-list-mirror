Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18972C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5EB610FC
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhEaRVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEaRVd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:21:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11855C034610
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:35:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso4496217otu.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tJIa6/0fZSQ+mgCp++6h6QAtSgzHrkKMNPs/j04iCdI=;
        b=WkJE2svU5DZlT1lCCp6nTiyR8uahGckDqBOcOyY0tvgr0o4qCAGqYB8JXiVIPT67U+
         z28Dpu08ly9mcrNOVYZWOqYYLvadLjfrI+mjk7eeMelajVmWd8lx2bdsytsYttIjVKQ/
         QnHbPIfXlF+d9eJazMa6vwCBAwoBfv4mWIIVHnOv4Wip2l0jRPd9qh/yZE70RxjKg5JJ
         xiA698tasFFEB5LitywkIjPxwVrz04mrKDMYmPZs5OdWJOM8SU/j5oMHZPk3c6WPIHxb
         u8NiUgli4iMPIKYXQqUiqdmBnZHrYj3Sr+D1MCX2kqkP4qL+cnqV1HvfcNFcVaBkSmRH
         Bu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tJIa6/0fZSQ+mgCp++6h6QAtSgzHrkKMNPs/j04iCdI=;
        b=RsGh87NthwTzUiOvvMN/iCmQe1xpmue7OVXHLgPL03EHj6uvS+iFTidENG/A5b6JGQ
         iFrsZLQfipcG200D/zcx4FDQkJ47l9rto+M+umWBdvbtfHQtnXmf6uK5u4Ah9iGUOexj
         05rpfHyRJkH52eWLtgG9Z8222qwLdopUtINvrZ831Ix6MCjCn6GNE8P4yrbkxpJw85Gc
         oqNPKk2/XVVHy7qF68O+Y5V7qQQKPg6bYDiTO0AnYfdZXPg5214H9vIMr27e8rYiP1B/
         f1VtVc6Rxm2VhJStxCRO4HsiVMnYHbLn26ek/fqDdnPLKoBH9EAwExLbWuoM17xx2QHL
         jBeQ==
X-Gm-Message-State: AOAM533/4v7tWJYHi9N+EpyRY1kryJ/WA5Y1jb7dEIVmgixNy5QL2Wyc
        62+gZO1+51vBOHPtKgfGkfM=
X-Google-Smtp-Source: ABdhPJwpGJ3xuqyfybiNUh4tpOL3rXs0sETZ1Ci2SDpu4+85LOxUHyTOS/APs09jJzt9BN7tXfW5iA==
X-Received: by 2002:a05:6830:208e:: with SMTP id y14mr17309852otq.15.1622475339413;
        Mon, 31 May 2021 08:35:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l128sm2874759oif.16.2021.05.31.08.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:35:38 -0700 (PDT)
Date:   Mon, 31 May 2021 10:35:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60b50249ae62a_24d2820893@natae.notmuch>
In-Reply-To: <CAOLTT8TEkrxAgHvkCVXZDQpn0xSQAe_y7uMF89Q4QWwVd7MDcA@mail.gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
 <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
 <60b25ca7a01c2_265088208af@natae.notmuch>
 <CAOLTT8TEkrxAgHvkCVXZDQpn0xSQAe_y7uMF89Q4QWwVd7MDcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu wrote:
> Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8811:24=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > Phillip Wood wrote:
> > > On 27/05/2021 17:36, Felipe Contreras wrote:
> > > > ZheNing Hu via GitGitGadget wrote:
> > > > [...]
> > > >> +static int memcasecmp(const void *vs1, const void *vs2, size_t =
n)
> > > >
> > > > Why void *? We can delcare as char *.
> > >
> > > If you look at how this function is used you'll see
> > >       int (*cmp_fn)(const void *, const void *, size_t);
> > >       cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > >                       ? memcasecmp : memcmp;
> >
> > Yeah, but why?
> >
> > We know we are comparing two char *. Presumably the reason is that
> > memcmp and memcasecmp use void *, but that could be remedied with:
> >
> >         cmp_fn =3D (int (*)(const char *, const char *, size_t))memcm=
p;
> >
> > That way the same cmp_fn could be used for the two cases.
> >
> > Either way I don't care particularly much. It also could be possible =
to
> > use void * and do the casting in tolower().
> >
> =

> I agree with Phillip's point of view here:
> It would be better for memcasecmp and memcmp to be consistent.

Fair enough.

>  static int memcasecmp(const void *vs1, const void *vs2, size_t n)
>  {
> -       size_t i;
> -       const char *s1 =3D (const char *)vs1;
> -       const char *s2 =3D (const char *)vs2;
> -
> -       for (i =3D 0; i < n; i++) {
> -               unsigned char u1 =3D s1[i];
> -               unsigned char u2 =3D s2[i];
> -               int U1 =3D toupper (u1);
> -               int U2 =3D toupper (u2);
> -               int diff =3D (UCHAR_MAX <=3D INT_MAX ? U1 - U2
> -                       : U1 < U2 ? -1 : U2 < U1);
> +       const char *s1 =3D (const void *)vs1;
> +       const char *s2 =3D (const void *)vs2;

vs1 is already a const void *, and there's not much point in adding
another line:

	const char *s1 =3D vs1, *s2 =3D vs2;

Cheers.

-- =

Felipe Contreras=
