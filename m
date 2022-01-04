Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B733C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiADCCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiADCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:02:36 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADFC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 18:02:36 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id o63so60695532uao.5
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73vYcxqyHFoDtr6LFrtqgiiZAIS3v0o0B26gmCjepdU=;
        b=loPJeyCulgW4FOniMFl0P5R54OHHHvxVy+nQBUKM13Jla2IG6lHwgOXVvG3il1GU63
         XcMixYPvTC/+nerdKm5es9eRxKpXON2o33yU/4yq8sF7Syo/Q6wm+EEjy77NCnuoXT2E
         gJIUBgKyiw24Xw98UDm+lbMqtPA3qOa2Z7tg+uz+v2SGHco4FnHXZKVYzFXhrwnmsfPe
         AAb1tHqZNsofUWPqK5noX+EYgi8YYxu199nZdJSdO+vfC6mvalhwVUGibFwX0rGLIevD
         /Ve7Zt+SDt+pO9q2iwBGiwvHmmm8SPUqEe3PDtkSvx/EO8gVKHFCqG/YRLfABOEAULhE
         2G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73vYcxqyHFoDtr6LFrtqgiiZAIS3v0o0B26gmCjepdU=;
        b=uYCFrK7hYGsBPYwp6x42bEviHbQPb6UBfDbBHBmlyikItjt2P2Ug5GcXhMXnoiUH4p
         WFz2pvAtEi75cyJiUaRDTltqBF8HrysFLdPAyh7toRWBli0Q/s6UYroyaqEdkmthFc7o
         HHN2RKQsSpU8sdlpPsKeR9VhcxRSoGGVAHztYh0QjOA2/nVjodVnaG7yTHhLULPEPY/I
         3m0ostt18KbI1y94PX0r1dO8e8m20Mfb5NIbVmFIFJluCO9Whlre4jrNZH2iqzeRASqv
         O0o1TRaw5fhxKBxPFAQ4JfzINC2sDjdioy8i/W+2JFazL9/NxSQ5gWIrNT0FkBtCHrU8
         F/Xw==
X-Gm-Message-State: AOAM533Y+2NdpYAn53ZZSZ96ZgU3u9oYh9MbfSMai/C5RnTMC0gOqVli
        HoG39mNvklNCEbSyF8AhyqRl5E7uzjgxVt+IeLE=
X-Google-Smtp-Source: ABdhPJyfvZoxWFcZkOlbuBRlQ+5kWnVNvXVQznLh7qbRzSh1xJvSX7Ld0cIVTVX8U1IJyx1c0PyD/4lr9Owmz4IPCWw=
X-Received: by 2002:ab0:6956:: with SMTP id c22mr7484500uas.51.1641261755755;
 Mon, 03 Jan 2022 18:02:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641043500.git.dyroneteng@gmail.com> <296ebacafe4d40ffc5282aebb9fee972866c4ccc.1641043500.git.dyroneteng@gmail.com>
 <xmqqilv0iewz.fsf@gitster.g>
In-Reply-To: <xmqqilv0iewz.fsf@gitster.g>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Tue, 4 Jan 2022 10:02:24 +0800
Message-ID: <CADMgQSTBp9ykxtPUHgA1LCQQ1zCmfsUMLGa=ccyqjci9VXVsRg@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] ls-tree.c: introduce struct "shown_data"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> "show_data" is a struct that packages the necessary fields for

>Is that shown_data?

Yes, sorry for that mislead.

>> reusing. This commit is a front-loaded commit for support
>> "--format" argument and does not affect any existing functionality.

> What's a front-loaded commit?  Is that some joke around a washing
> machine that I do not quite get, or something?

I know this word recently (from an English training institute), feel
sorry if it confuses you, I think it means pre-prepared.

I found two demo sentences from:
https://dictionary.cambridge.org/us/dictionary/english/front-load

I'm not sure that I used it right or wrong, if it's the wrong way or
just make others feel like in haze, I will use =E2=80=9Cpre-prepared=E2=80=
=9D
preferentially
next time.

Thanks.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=8C 07:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Teng Long <dyroneteng@gmail.com> writes:
>
> > "show_data" is a struct that packages the necessary fields for
>
> Is that shown_data?
>
> > reusing. This commit is a front-loaded commit for support
> > "--format" argument and does not affect any existing functionality.
>
> What's a front-loaded commit?  Is that some joke around a washing
> machine that I do not quite get, or something?
>
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> >  builtin/ls-tree.c | 47 +++++++++++++++++++++++++++++------------------
> >  1 file changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> > index 85ca7358ba..009ffeb15d 100644
> > --- a/builtin/ls-tree.c
> > +++ b/builtin/ls-tree.c
> > @@ -34,6 +34,14 @@ static unsigned int shown_bits;
> >  #define SHOW_MODE (1 << 4)
> >  #define SHOW_DEFAULT 29 /* 11101 size is not shown to output by defaul=
t */
> >
> > +struct shown_data {
> > +     unsigned mode;
> > +     enum object_type type;
> > +     const struct object_id *oid;
> > +     const char *pathname;
> > +     struct strbuf *base;
> > +};
> > +
> >  static const  char * const ls_tree_usage[] =3D {
> >       N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
> >       NULL
> > @@ -98,17 +106,15 @@ static int show_recursive(const char *base, size_t=
 baselen,
> >       return 0;
> >  }
> >
> > -static int show_default(const struct object_id *oid, enum object_type =
type,
> > -                     const char *pathname, unsigned mode,
> > -                     struct strbuf *base)
> > +static int show_default(struct shown_data *data)
> >  {
> > -     size_t baselen =3D base->len;
> > +     size_t baselen =3D data->base->len;
> >
> >       if (shown_bits & SHOW_SIZE) {
> >               char size_text[24];
> > -             if (type =3D=3D OBJ_BLOB) {
> > +             if (data->type =3D=3D OBJ_BLOB) {
> >                       unsigned long size;
> > -                     if (oid_object_info(the_repository, oid, &size) =
=3D=3D OBJ_BAD)
> > +                     if (oid_object_info(the_repository, data->oid, &s=
ize) =3D=3D OBJ_BAD)
> >                               xsnprintf(size_text, sizeof(size_text), "=
BAD");
> >                       else
> >                               xsnprintf(size_text, sizeof(size_text),
> > @@ -116,18 +122,18 @@ static int show_default(const struct object_id *o=
id, enum object_type type,
> >               } else {
> >                       xsnprintf(size_text, sizeof(size_text), "-");
> >               }
> > -             printf("%06o %s %s %7s\t", mode, type_name(type),
> > -             find_unique_abbrev(oid, abbrev), size_text);
> > +             printf("%06o %s %s %7s\t", data->mode, type_name(data->ty=
pe),
> > +             find_unique_abbrev(data->oid, abbrev), size_text);
> >       } else {
> > -             printf("%06o %s %s\t", mode, type_name(type),
> > -             find_unique_abbrev(oid, abbrev));
> > +             printf("%06o %s %s\t", data->mode, type_name(data->type),
> > +             find_unique_abbrev(data->oid, abbrev));
> >       }
> > -     baselen =3D base->len;
> > -     strbuf_addstr(base, pathname);
> > -     write_name_quoted_relative(base->buf,
> > +     baselen =3D data->base->len;
> > +     strbuf_addstr(data->base, data->pathname);
> > +     write_name_quoted_relative(data->base->buf,
> >                                  chomp_prefix ? ls_tree_prefix : NULL, =
stdout,
> >                                  line_termination);
> > -     strbuf_setlen(base, baselen);
> > +     strbuf_setlen(data->base, baselen);
> >       return 1;
> >  }
> >
> > @@ -154,11 +160,16 @@ static int show_tree(const struct object_id *oid,=
 struct strbuf *base,
> >  {
> >       int retval =3D 0;
> >       size_t baselen;
> > -     enum object_type type =3D OBJ_BLOB;
> > +     struct shown_data data =3D {
> > +             .mode =3D mode,
> > +             .type =3D OBJ_BLOB,
> > +             .oid =3D oid,
> > +             .pathname =3D pathname,
> > +             .base =3D base,
> > +     };
> >
> > -     if (show_tree_init(&type, base, pathname, mode, &retval))
> > +     if (show_tree_init(&data.type, base, pathname, mode, &retval))
> >               return retval;
> > -
> >       if (!(shown_bits ^ SHOW_OBJECT_NAME)) {
> >               printf("%s%c", find_unique_abbrev(oid, abbrev), line_term=
ination);
> >               return retval;
> > @@ -175,7 +186,7 @@ static int show_tree(const struct object_id *oid, s=
truct strbuf *base,
> >
> >       if (!(shown_bits ^ SHOW_DEFAULT) ||
> >           !(shown_bits ^ (SHOW_DEFAULT | SHOW_SIZE)))
> > -             show_default(oid, type, pathname, mode, base);
> > +             show_default(&data);
> >
> >       return retval;
> >  }
