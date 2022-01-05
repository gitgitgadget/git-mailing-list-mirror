Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4FAC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiAEJlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 04:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiAEJk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 04:40:59 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06464C061785
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 01:40:58 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id h5so14304119vkp.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vs4vXtYmyXsgLn8jH+VistDMxRiG4pHfZDFMBRxjfIU=;
        b=a1dbINz6wRYzgnWdNgX1RD2Uspy0DrBDiPA6YV0MHR0NW7NNKdLS8A7YOY30VEyECS
         ZyariFz58/4TbW1gJY1EI9F9UeerXW0cyv4yZN/S71/fcYAw4U9Izv7Mfo4wkJlJ543u
         hYpYodBuZa2HaaH52LMErUi58vGOhFZysH9rjW65DMbiZfL4TZ8FZT31n7wEH/BxvjWd
         Sq8xeJCgvgPVW3HSeuZDl6YxLG6mKu4d2BQL+oUlSVDYu277DcYRBDfF1uWzqNbeg0h7
         JokuakNWWAiR4oND9UXNWK2g7s0Fh5WGduLPvEVGNUujrZBmDMdAvhXUaKkm/ZuvPOwH
         9Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vs4vXtYmyXsgLn8jH+VistDMxRiG4pHfZDFMBRxjfIU=;
        b=DvEUvO+VrshNOiv0N0ZflpoQ+c8i49W0pd4gD3+gf3ORekeardjy+RHTaB6VX/+NLQ
         Q08xZp65MfJ8YyBNAsxQr2E/U8AxfTQIFbgnr6E7k2QyuEjInuYTY9aW4HLW2TYaH/Vx
         ugghtt0A0/vIdpEB2hhGKlUoeYvyiLvlOXcADeeRx6emLU/9UaP7sd6Iei/1LmTA5bsx
         AgE4FZW+tbAjmPlZTv7y3JY5lTmq3EvBsaBGDNLbg/2ZYmUIs8O1NVABDdwVNaaD2mtG
         MrTLdC6OmaDXcIjGcvV7IG7wqxXsPRq5JnrwuNzysgXfyxQchsJ4XyuaLD7hIsDdmjb0
         jEdA==
X-Gm-Message-State: AOAM531IYJuMr4SQ6JD/j8dGZa7cTP6y8kMjJ+tapP/8N7Kc1adQ4M1F
        PZdlTLrJYvsFSctKsemKFmtEULagJHw4k680sEs=
X-Google-Smtp-Source: ABdhPJx2YVSp/Hwyb1cxc4GkOQhijwBf0aT5oFFmzefdQrzTykSaoAwegYGiQimU7NQwLQvbf6S1YFYbqjMPhNRwI48=
X-Received: by 2002:a05:6122:181b:: with SMTP id ay27mr18521587vkb.36.1641375658012;
 Wed, 05 Jan 2022 01:40:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641043500.git.dyroneteng@gmail.com> <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com>
 <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2201041615560.7076@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201041615560.7076@tvgsbejvaqbjf.bet>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Wed, 5 Jan 2022 17:40:47 +0800
Message-ID: <CADMgQSQ8+2pMdabbyCqZo4F8SRp-VH6wjD6tEx83m6FQhiwUHw@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] ls-tree.c: introduce "--format" option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In addition to that, you need these to quiet down the `linux-leaks` job o=
f
> our CI build, which is also failing with your patches:

Thanks.
I will fix it in next patch.

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=8C 23:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Teng,
>
> On Tue, 4 Jan 2022, Johannes Schindelin wrote:
>
> > -- snip --
> > diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> > index 6e3e5a4d0634..8301d1a15f9a 100644
> > --- a/builtin/ls-tree.c
> > +++ b/builtin/ls-tree.c
> > @@ -75,7 +75,7 @@ static void expand_objectsize(struct strbuf *line, co=
nst struct object_id *oid,
> >               else
> >                       strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
> >       } else if (padded) {
> > -             strbuf_addf(line, "%7s", "-");
> > +             strbuf_addstr(line, "-");
> >       } else {
> >               strbuf_addstr(line, "-");
> >       }
> > @@ -110,7 +110,7 @@ static size_t expand_show_tree(struct strbuf *line,=
 const char *start,
> >       } else if (skip_prefix(start, "(size)", &p)) {
> >               expand_objectsize(line, data->oid, data->type, 0);
> >       } else if (skip_prefix(start, "(object)", &p)) {
> > -             strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev)=
);
> > +             strbuf_add_unique_abbrev(line, data->oid, abbrev);
> >       } else if (skip_prefix(start, "(file)", &p)) {
> >               const char *name =3D data->base->buf;
> >               const char *prefix =3D chomp_prefix ? ls_tree_prefix : NU=
LL;
> > @@ -119,7 +119,7 @@ static size_t expand_show_tree(struct strbuf *line,=
 const char *start,
> >               strbuf_addstr(data->base, data->pathname);
> >               name =3D relative_path(data->base->buf, prefix, &sb);
> >               quote_c_style(name, &quoted, NULL, 0);
> > -             strbuf_addstr(line, quoted.buf);
> > +             strbuf_addbuf(line, &quoted);
> >       } else {
> >               errlen =3D (unsigned long)len;
> >               die(_("bad ls-tree format: %%%.*s"), errlen, start);
> > -- snap --
>
> In addition to that, you need these to quiet down the `linux-leaks` job o=
f
> our CI build, which is also failing with your patches:
>
> -- snipsnap --
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 8301d1a15f9a..0dc0327e4785 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -120,6 +120,8 @@ static size_t expand_show_tree(struct strbuf *line, c=
onst char *start,
>                 name =3D relative_path(data->base->buf, prefix, &sb);
>                 quote_c_style(name, &quoted, NULL, 0);
>                 strbuf_addbuf(line, &quoted);
> +               strbuf_release(&sb);
> +               strbuf_release(&quoted);
>         } else {
>                 errlen =3D (unsigned long)len;
>                 die(_("bad ls-tree format: %%%.*s"), errlen, start);
> @@ -197,6 +199,7 @@ static int show_tree_fmt(const struct object_id *oid,=
 struct strbuf *base,
>         strbuf_expand(&line, format, expand_show_tree, &data);
>         strbuf_addch(&line, line_termination);
>         fwrite(line.buf, line.len, 1, stdout);
> +       strbuf_release(&line);
>         strbuf_setlen(base, baselen);
>         return retval;
>  }
