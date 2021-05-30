Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D228FC47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC26C610FC
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhE3GbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 02:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE3GbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 02:31:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F5C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:29:41 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r4so8679447iol.6
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3WgQoUGxf2bb6w4t2n+Lf3ZqjuJSZSslqYl9qftxgwQ=;
        b=A9l2RNKs3VAIxX/kedVzvg12u9eMZ0nXyOwQpj/MMQk1ZYU/ni+3HJNQFFciuiqT+y
         z812rVVrCFgbnbiEQibXDLGnbrFKy99YqA7h760FVierU5fKzjJVlXTnGJLbzNNNXJDv
         sIBvTTu8rkvusdE/exWikV/JlwUZI6U5tfj2Bx+9dpf4OF5tA312e/w/Tps061axINTq
         5/SOwdHeZJCTqiSdWpzc9IkLubfmzj6kdcN3p0Yvj+y6Z3wD+DFUjXngXYJ0LsYNziLA
         Owjkm5X97EFi9tY5V1JLrujTooyzPLwqUays8bLnRvsQ0PFtwW7q+BpSGky6wz1vl0EI
         pf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3WgQoUGxf2bb6w4t2n+Lf3ZqjuJSZSslqYl9qftxgwQ=;
        b=O1TFJMu1967hINOgDRY1+MBjnKYEL1CommtfVQQJMoyCJwi3XG04Zplnu3iz9uYEM9
         Nmvooi7Sh5jmvrx8VIVaYZAiW5HHAo5rafIQlYZCz3o8gIWSrU7/uPnrklbPWsDw/Ntn
         zHhsO28Z8Mh/gCV0+slKSPezjVArtjScoiOUgJWP1Q03A/qBobyBhrQNb0AZKYhO1WnI
         6LAVo7Z2aQAazGrIHaNDoykBaz7+x5jNaCY3/yDaVNflXZRpB/8boAujzo6lrtHq2owv
         1qgS9fRyfYUmCEo5sFooAzNyhPmoc8hNAdyZGZgeucGpEf3xBsgrQeqfkDQjl13qeWpE
         2Ivg==
X-Gm-Message-State: AOAM532dUKinUx6DNNubgEX3x8bPJhL0EcKSWF4VB0gffQGt0/mR19nH
        Gm51KiiguL3MCQIVg0cZHiD+7rihX6v2LndaUT4=
X-Google-Smtp-Source: ABdhPJzxNa4CEPRRd4OhQaApT8Ly2UJcdetA1ySZ1jdE8b8KzEBLjfuPCOLuT8SPWxmyXwo5vg5kjY5oLBVS8f3Rg0o=
X-Received: by 2002:a02:b084:: with SMTP id v4mr3136926jah.130.1622356180827;
 Sat, 29 May 2021 23:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch> <13c63e79-27fd-58d5-9a4c-6b58c40ef4b8@gmail.com>
 <60b25ca7a01c2_265088208af@natae.notmuch>
In-Reply-To: <60b25ca7a01c2_265088208af@natae.notmuch>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 30 May 2021 14:29:28 +0800
Message-ID: <CAOLTT8TEkrxAgHvkCVXZDQpn0xSQAe_y7uMF89Q4QWwVd7MDcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
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

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8829=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8811:24=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Phillip Wood wrote:
> > On 27/05/2021 17:36, Felipe Contreras wrote:
> > > ZheNing Hu via GitGitGadget wrote:
> > > [...]
> > >> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> > >
> > > Why void *? We can delcare as char *.
> >
> > If you look at how this function is used you'll see
> >       int (*cmp_fn)(const void *, const void *, size_t);
> >       cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> >                       ? memcasecmp : memcmp;
>
> Yeah, but why?
>
> We know we are comparing two char *. Presumably the reason is that
> memcmp and memcasecmp use void *, but that could be remedied with:
>
>         cmp_fn =3D (int (*)(const char *, const char *, size_t))memcmp;
>
> That way the same cmp_fn could be used for the two cases.
>
> Either way I don't care particularly much. It also could be possible to
> use void * and do the casting in tolower().
>

I agree with Phillip's point of view here:
It would be better for memcasecmp and memcmp to be consistent.

> > > (and I personally prefer lower to upper)
> >
> > We should be using tolower() as that is what POSIX specifies for
> > strcasecmp() [1] which we are trying to emulate and there are cases[2] =
where
> >       (tolower(c1) =3D=3D tolower(c2)) !=3D (toupper(c1) =3D=3D toupper=
(c2))
>
> That's true.
>

How about something like this:

 static int memcasecmp(const void *vs1, const void *vs2, size_t n)
 {
-       size_t i;
-       const char *s1 =3D (const char *)vs1;
-       const char *s2 =3D (const char *)vs2;
-
-       for (i =3D 0; i < n; i++) {
-               unsigned char u1 =3D s1[i];
-               unsigned char u2 =3D s2[i];
-               int U1 =3D toupper (u1);
-               int U2 =3D toupper (u2);
-               int diff =3D (UCHAR_MAX <=3D INT_MAX ? U1 - U2
-                       : U1 < U2 ? -1 : U2 < U1);
+       const char *s1 =3D (const void *)vs1;
+       const char *s2 =3D (const void *)vs2;
+       const char *end =3D s1 + n;
+
+       for (; s1 < end; s1++, s2++) {
+               int diff =3D tolower(*s1) - tolower(*s2);
                if (diff)
                        return diff;
        }
}

> --
> Felipe Contreras

Thanks.
--
ZheNing Hu
