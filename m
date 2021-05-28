Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96042C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652DC613B4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 13:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhE1NEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 09:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhE1NEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 09:04:11 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207AEC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 06:02:35 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id g11so3238188ilq.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBfr/5d7ZtN4LqrUlIUvgUJcPIpENJZgW8H1H15J8EM=;
        b=H2ugpAj5so1+7u//bR9sq/TgoYaG6NK+vm5dgHUQQV+NyA3IcRb8DrczHXm6yosl2M
         ckvqiA9iE8NfbzR2VocbZIcfg0NED+Yw5Q1boeAfs69jSUakGbnfL+w+kBQBm2ut2woF
         r8jY0iRq1JlYuokz6Mg1/Sj4/FbOEXBu7iT9PcIw7N7nfI6jLlGPSAytRh0O+LS9IRVL
         mpQh7cyTqqBXS/svrfRAbSCZWWHMpvvthX+Aw8XxLTizSmNtT4yabYRLSJc+X90KKrRX
         jfr8Oi8FG1DaGkgDOZ2P59rkVSvHi/qmuQHNkNfzPldtxqVm5f0916lkpckhepvwbR7I
         oaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBfr/5d7ZtN4LqrUlIUvgUJcPIpENJZgW8H1H15J8EM=;
        b=Z4OyWYkpvitBDdy9S4oiWoKLFemhBNJK45j1453TXX5UMqVINZnQSQiObENYUVGC9F
         tMSyUtQaEOcOlo+szRNFhbliwKlMXsbqoR9QaXW3uJiR78sZeZyR0CRd6qvMpIFY2PA6
         TUtQP1egimM2/CEb7VmS4imXjt4eyjd+Io8MVySlcYSrExbbDs1Xoel47KB3xvHsjcvW
         bNAs8+pM3pxdGMmEtbg6t7LUHwrLhTYsBs71Ptf8E/5Jo7sG9+9c18PhqyCVzgZBQHH3
         Q+CfgrmC4H5jN5miZU/96uKqehDLBJgsasVl6Lx4RlRVB70w3HM6G8AS3h67oqOIdAs2
         8xrw==
X-Gm-Message-State: AOAM533UaeDX5vsu4JE9g8W3P7D1lfS9f9Z9sVvhXdLwqsEpcZd1FNb3
        utd3YSiTZ0yvW04GMb8Nyp3DE6j17blJmkM4SSo=
X-Google-Smtp-Source: ABdhPJzgIIlFiEWE9pcd9h6f9Acj+L1VGsPPl1Fw4T8x/2wGJzlHIRkxXNJtW4sApfiwLvYHT7iuJoU2Q3dho7dk3k8=
X-Received: by 2002:a92:c7ab:: with SMTP id f11mr5787971ilk.174.1622206954466;
 Fri, 28 May 2021 06:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <60afca827a28f_265302085b@natae.notmuch>
In-Reply-To: <60afca827a28f_265302085b@natae.notmuch>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 28 May 2021 21:02:23 +0800
Message-ID: <CAOLTT8RbVsZuAwUZ-yn_Wwnvq7qyziA=4z=skMoGdPCTdQ5KPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
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
=8828=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:36=E5=86=99=E9=81=93=
=EF=BC=9A
>
> ZheNing Hu via GitGitGadget wrote:
>
> > +static int raw_atom_parser(const struct ref_format *format, struct use=
d_atom *atom,
> > +                             const char *arg, struct strbuf *err)
> > +{
> > +     if (!arg) {
> > +             atom->u.raw_data.option =3D RAW_BARE;
> > +     } else if (!strcmp(arg, "size"))
>
> No need for braces.
>
>   if (!arg)
>     ...
>   else
>

I sometimes forget this detail, I will pay attention.

> > @@ -1307,10 +1349,22 @@ static void grab_sub_body_contents(struct atom_=
value *val, int deref, void *buf)
> >                       continue;
> >               if (deref)
> >                       name++;
> > -             if (strcmp(name, "body") &&
> > -                 !starts_with(name, "subject") &&
> > -                 !starts_with(name, "trailers") &&
> > -                 !starts_with(name, "contents"))
> > +
> > +             if (starts_with(name, "raw")) {
> > +                     if (atom->u.raw_data.option =3D=3D RAW_BARE) {
> > +                             v->s =3D xmemdupz(buf, buf_size);
> > +                             v->s_size =3D buf_size;
> > +                     } else if (atom->u.raw_data.option =3D=3D RAW_LEN=
GTH)
> > +                             v->s =3D xstrfmt("%"PRIuMAX, (uintmax_t)b=
uf_size);
>
> I think it's better to be consistent: if you used braces in the if, uses
> braces in else.
>

OK.

> > +                     continue;
> > +             }
>
> > +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
>
> Why void *? We can delcare as char *.
>
> > +{
> > +     size_t i;
> > +     const char *s1 =3D (const char *)vs1;
> > +     const char *s2 =3D (const char *)vs2;
>
> Then we avoid this extra step.
>
> > +     for (i =3D 0; i < n; i++) {
> > +             unsigned char u1 =3D s1[i];
> > +             unsigned char u2 =3D s2[i];
>
> There's no need for two entirely new variables...
>
> > +             int U1 =3D toupper (u1);
> > +             int U2 =3D toupper (u2);
>
> You can do toupper(s1[i]) directly (BTW, there's an extra space: `foo(x)`=
,
> not `foo (x)`).
>
> While we are at it, why keep an extra index from s1, when s1 is never
> used again?
>
> We can simply advance both s1 and s2:
>
>   s1++, s2++
>
> > +             int diff =3D (UCHAR_MAX <=3D INT_MAX ? U1 - U2
> > +                     : U1 < U2 ? -1 : U2 < U1);
>
> I don't understand what this is supposed to achieve. Both U1 and U2 are
> integers, pretty low integers actually.
>
> If we get rid if that complexity we don't even need U1 or U2, just do:
>
>   diff =3D toupper(u1) - toupper(u2);
>
> > +             if (diff)
> > +                     return diff;
> > +     }
> > +     return 0;
> > +}
>
> All we have to do is define the end point, and then we don't need i:
>
>         static int memcasecmp(const char *s1, const char *s2, size_t n)
>         {
>                 const char *end =3D s1 + n;
>                 for (; s1 < end; s1++, s2++) {
>                         int diff =3D tolower(*s1) - tolower(*s2);
>                         if (diff)
>                                 return diff;
>                 }
>                 return 0;
>         }
>
> (and I personally prefer lower to upper)
>

Sorry for the weird, unclean `memcasecmp()`, I referred to memcmp()
in glibc before, and then I was afraid that my writing was not standard
enough like "UCHAR_MAX <=3D INT_MAX", I can't consider such an
extreme situation. So I copied it directly from gnulib:
https://github.com/gagern/gnulib/blob/master/lib/memcasecmp.c

> Check the following resource for a detailed explanation of why my
> modified version is considered good taste:
>
> https://github.com/felipec/linked-list-good-taste
>

OK. I will gradually standardize my code style.

> >  static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_ite=
m *a, struct ref_array_item *b)
> >  {
> >       struct atom_value *va, *vb;
> > @@ -2304,6 +2382,7 @@ static int cmp_ref_sorting(struct ref_sorting *s,=
 struct ref_array_item *a, stru
> >       int cmp_detached_head =3D 0;
> >       cmp_type cmp_type =3D used_atom[s->atom].type;
> >       struct strbuf err =3D STRBUF_INIT;
> > +     size_t slen =3D 0;
> >
> >       if (get_ref_atom_value(a, s->atom, &va, &err))
> >               die("%s", err.buf);
> > @@ -2317,10 +2396,32 @@ static int cmp_ref_sorting(struct ref_sorting *=
s, struct ref_array_item *a, stru
> >       } else if (s->sort_flags & REF_SORTING_VERSION) {
> >               cmp =3D versioncmp(va->s, vb->s);
> >       } else if (cmp_type =3D=3D FIELD_STR) {
> > -             int (*cmp_fn)(const char *, const char *);
> > -             cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > -                     ? strcasecmp : strcmp;
> > -             cmp =3D cmp_fn(va->s, vb->s);
> > +             if (va->s_size =3D=3D ATOM_VALUE_S_SIZE_INIT &&
> > +                 vb->s_size =3D=3D ATOM_VALUE_S_SIZE_INIT) {
> > +                     int (*cmp_fn)(const char *, const char *);
> > +                     cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > +                             ? strcasecmp : strcmp;
> > +                     cmp =3D cmp_fn(va->s, vb->s);
> > +             } else {
> > +                     int (*cmp_fn)(const void *, const void *, size_t)=
;
> > +                     cmp_fn =3D s->sort_flags & REF_SORTING_ICASE
> > +                             ? memcasecmp : memcmp;
> > +
> > +                     if (va->s_size !=3D ATOM_VALUE_S_SIZE_INIT &&
> > +                         vb->s_size !=3D ATOM_VALUE_S_SIZE_INIT) {
> > +                             cmp =3D cmp_fn(va->s, vb->s, va->s_size >=
 vb->s_size ?
> > +                                    vb->s_size : va->s_size);
> > +                     } else if (va->s_size =3D=3D ATOM_VALUE_S_SIZE_IN=
IT) {
> > +                             slen =3D strlen(va->s);
> > +                             cmp =3D cmp_fn(va->s, vb->s, slen > vb->s=
_size ?
> > +                                          vb->s_size : slen);
> > +                     } else {
> > +                             slen =3D strlen(vb->s);
> > +                             cmp =3D cmp_fn(va->s, vb->s, slen > va->s=
_size ?
> > +                                          slen : va->s_size);
> > +                     }
> > +                     cmp =3D cmp ? cmp : va->s_size - vb->s_size;
> > +             }
>
> This hurts my eyes. I think the complexity of this chunk warrants a
> separate function. Then the logic would be easer to see.
>

Fine. This piece of the situation is a bit complicated...

> Cheers.
>
> --
> Felipe Contreras

Thanks.
--
ZheNing Hu
