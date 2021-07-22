Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB2C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5D66008E
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhGVI3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhGVI3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 04:29:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39575C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:10:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id u7so5498541ion.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YmATHcDBYp+fKDT2gd5OnHrVOaQzM8l1dmWbN/JTAGc=;
        b=LR/+yCOYQJXVrCWgxbVmzzqHDeAF2IKYRDawCzQEKu3wEQ+4k1Ari6w9nFmQUSMc6/
         9xOYGcvBgS1h3zGizKcXKI7ZkvEg/yrqzE29VzL25nLosaA9Up/r5VVgc5BcID12iDzd
         KV7r7hkQzXsah5Qb0iiUQzkWeNFlkTMKaGwkn4h4bMSrWvQIK4PqjweyinZFcEJuH8GG
         E8ryyYg2/+Y+psdumFgPsgklcSUIdAk9SI+6BTQ69hyBXzWW9zGg8ci0Qrg6J86sjLcG
         oH6TaOVdTeW4m4OZkcx+EABC3A2nhqhAOVNjGXiLGYEJ1UHCcaOpHqYJB5mbGML8h6Ov
         ohgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YmATHcDBYp+fKDT2gd5OnHrVOaQzM8l1dmWbN/JTAGc=;
        b=I9qyzmR6syQEghjmBJlfQmLuvJVKo3DSFQRQPa4+G/+vVe8Vc4MEJcem4xaB9XqF+s
         k/9yeKD62qvKUsu5dqNSWIjJ3LcPYT4cVtAPw7eIvD8N/yKWwjjNJppKJfar7s+XaFKO
         9naOv+5h/WmNa9tVfGGBD+izkdjzeepNcQRjx4pqAfmeHzxpWLe+3YRq17J/0ALpxajx
         pXQjALZWVbpKaY0QU0oXa1wd2B5xXAXBwWbtmAxSziyRcBdy+HTkbIBZ8VgwApuBS1cq
         Vm4DeJWCy+bSOF95+xWbKA9jbz6fqPBQU+EiCjDbi2Li9T4cjKZlmPSG4HKD2ZpuKBxJ
         ILxg==
X-Gm-Message-State: AOAM531kR0ZXZk0Eh9pZ78zgtggsm3wGudCUmdk6gw5i0Kk5YI7NwEJy
        3mVw+6uNmymIkaLkTDmQu+P8KEeTrEw9dOwaaYM=
X-Google-Smtp-Source: ABdhPJxC97hXeq8FJikXFpbnxxn7K/QytMB8CIaPlrnoVPbtSH1UPT48aMlnnyHyMDu9pexRq+N6ZnoxFzZ6Z+FiqVo=
X-Received: by 2002:a05:6638:24c3:: with SMTP id y3mr34723173jat.10.1626945022982;
 Thu, 22 Jul 2021 02:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <75eb2f6740eb5845afcb7d31956cc5b3e3957f97.1626939557.git.gitgitgadget@gmail.com>
 <874kcmvjr6.fsf@evledraar.gmail.com>
In-Reply-To: <874kcmvjr6.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 22 Jul 2021 17:10:47 +0800
Message-ID: <CAOLTT8RULMLiUwRDMRO-W6gzB8+57XHT=Hn3owoQF-fyK8_HMw@mail.gmail.com>
Subject: Re: [PATCH 5/5] [GSOC] ref-filter: add %(rest) atom
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:24=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Thu, Jul 22 2021, ZheNing Hu via GitGitGadget wrote:
>
>
> > +             } else if (atom_type =3D=3D ATOM_REST) {
> > +                     if (ref->rest)
> > +                             v->s =3D xstrdup(ref->rest);
> > +                     else
> > +                             v->s =3D xstrdup("");
> > +                     continue;
> >               } else
> >                       continue;
>
> Another light reading nit, maybe more readable as:
>
>     } else if (atom_type =3D=3D ATOM_REST && ref->rest) {
>         ...
>     } else if (atom_type =3D=3D ATOM_REST) {
>         ...
>     }
>     continue;
>
> But we can't do that "continue" at the end because there's two cases
> where we don't continue, I wondered if elimanting that special case
> would make it easier, patch below. Probably not worth it & feel free to
> ignore:

Yeah, the readability here is really bad, so many "continue" just to not ex=
ecute
part of the operation on refname. In fact, I have a similar patch
(which will not
be sent to the mailing list for the time being), it use switch and
case to replace if
and else. [1]

>
>  ref-filter.c | 63 +++++++++++++++++++++++++-----------------------------=
------
>  1 file changed, 26 insertions(+), 37 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 81e77b13ad2..189244fed6f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1890,18 +1890,26 @@ static int populate_value(struct ref_array_item *=
ref, struct strbuf *err)
>                         name++;
>                 }
>
> -               if (atom_type =3D=3D ATOM_REFNAME)
> +               if (atom_type =3D=3D ATOM_REFNAME) {
>                         refname =3D get_refname(atom, ref);
> -               else if (atom_type =3D=3D ATOM_WORKTREEPATH) {
> -                       if (ref->kind =3D=3D FILTER_REFS_BRANCHES)
> -                               v->s =3D get_worktree_path(atom, ref);
> +                       if (!deref)
> +                               v->s =3D xstrdup(refname);
>                         else
> -                               v->s =3D xstrdup("");
> -                       continue;
> -               }
> -               else if (atom_type =3D=3D ATOM_SYMREF)
> +                               v->s =3D xstrfmt("%s^{}", refname);
> +                       free((char *)refname);
> +               } else if (atom_type =3D=3D ATOM_WORKTREEPATH &&
> +                          ref->kind =3D=3D FILTER_REFS_BRANCHES) {
> +                       v->s =3D get_worktree_path(atom, ref);
> +               } else if (atom_type =3D=3D ATOM_WORKTREEPATH) {
> +                       v->s =3D xstrdup("");
> +               } else if (atom_type =3D=3D ATOM_SYMREF) {
>                         refname =3D get_symref(atom, ref);
> -               else if (atom_type =3D=3D ATOM_UPSTREAM) {
> +                       if (!deref)
> +                               v->s =3D xstrdup(refname);
> +                       else
> +                               v->s =3D xstrfmt("%s^{}", refname);
> +                       free((char *)refname);
> +               } else if (atom_type =3D=3D ATOM_UPSTREAM) {
>                         const char *branch_name;
>                         /* only local branches may have an upstream */
>                         if (!skip_prefix(ref->refname, "refs/heads/",
> @@ -1916,7 +1924,6 @@ static int populate_value(struct ref_array_item *re=
f, struct strbuf *err)
>                                 fill_remote_ref_details(atom, refname, br=
anch, &v->s);
>                         else
>                                 v->s =3D xstrdup("");
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_PUSH && atom->u.remote_r=
ef.push) {
>                         const char *branch_name;
>                         v->s =3D xstrdup("");
> @@ -1935,10 +1942,8 @@ static int populate_value(struct ref_array_item *r=
ef, struct strbuf *err)
>                         /* We will definitely re-init v->s on the next li=
ne. */
>                         free((char *)v->s);
>                         fill_remote_ref_details(atom, refname, branch, &v=
->s);
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_COLOR) {
>                         v->s =3D xstrdup(atom->u.color);
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_FLAG) {
>                         char buf[256], *cp =3D buf;
>                         if (ref->flag & REF_ISSYMREF)
> @@ -1951,24 +1956,20 @@ static int populate_value(struct ref_array_item *=
ref, struct strbuf *err)
>                                 *cp =3D '\0';
>                                 v->s =3D xstrdup(buf + 1);
>                         }
> -                       continue;
>                 } else if (!deref && atom_type =3D=3D ATOM_OBJECTNAME) {
>                            v->s =3D xstrdup(do_grab_oid("objectname", &re=
f->objectname, atom));
> -                          continue;
> +               } else if (atom_type =3D=3D ATOM_HEAD &&
> +                          atom->u.head &&
> +                          !strcmp(ref->refname, atom->u.head)) {
> +                       v->s =3D xstrdup("*");
>                 } else if (atom_type =3D=3D ATOM_HEAD) {
> -                       if (atom->u.head && !strcmp(ref->refname, atom->u=
.head))
> -                               v->s =3D xstrdup("*");
> -                       else
> -                               v->s =3D xstrdup(" ");
> -                       continue;
> +                       v->s =3D xstrdup(" ");
>                 } else if (atom_type =3D=3D ATOM_ALIGN) {
>                         v->handler =3D align_atom_handler;
>                         v->s =3D xstrdup("");
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_END) {
>                         v->handler =3D end_atom_handler;
>                         v->s =3D xstrdup("");
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_IF) {
>                         const char *s;
>                         if (skip_prefix(name, "if:", &s))
> @@ -1976,29 +1977,17 @@ static int populate_value(struct ref_array_item *=
ref, struct strbuf *err)
>                         else
>                                 v->s =3D xstrdup("");
>                         v->handler =3D if_atom_handler;
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_THEN) {
>                         v->handler =3D then_atom_handler;
>                         v->s =3D xstrdup("");
> -                       continue;
>                 } else if (atom_type =3D=3D ATOM_ELSE) {
>                         v->handler =3D else_atom_handler;
>                         v->s =3D xstrdup("");
> -                       continue;
> +               } else if (atom_type =3D=3D ATOM_REST && ref->rest) {
> +                       v->s =3D xstrdup(ref->rest);
>                 } else if (atom_type =3D=3D ATOM_REST) {
> -                       if (ref->rest)
> -                               v->s =3D xstrdup(ref->rest);
> -                       else
> -                               v->s =3D xstrdup("");
> -                       continue;
> -               } else
> -                       continue;
> -
> -               if (!deref)
> -                       v->s =3D xstrdup(refname);
> -               else
> -                       v->s =3D xstrfmt("%s^{}", refname);
> -               free((char *)refname);
> +                       v->s =3D xstrdup("");
> +               }
>         }
>
>         for (i =3D 0; i < used_atom_cnt; i++) {

[1]: https://github.com/adlternative/git/commit/bbc6ecba4c0f65e7328e571b0d3=
8ff99f800dc09
