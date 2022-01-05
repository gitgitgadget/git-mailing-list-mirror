Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57096C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiAEJ7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 04:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiAEJ6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 04:58:54 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B1C061785
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 01:58:53 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id l68so6397685vkh.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rIFpFVrZDJP4I9nzuWdldBCoaWHhceeuaIoJxWAzySg=;
        b=ITQiXD4fBnPOyYg26FNk3QPnEfqK9uXjVKwHOvMs97BrT6M4CQpnexvJ7cR9wFhsUT
         PY94C+Mc8qZnk2eT2N1pkv+MgaG2R/gDDHm0MPXgg7IH3gX32iEf8Y6lMEorEdy+mZnu
         NIZqkPu1QVDTZ7mSaBv1axvAeXkne//0oY47tEaZCv9q9e8KYLRXGXxLgfxTDOXgw38L
         kvV355yXObPivzjkv7FsoCX++N5D3YXwWPCznP419nnZ6aQC4bQqWz/QLQn4/3/qqkL+
         vLhpuNzBOxH2D75TzQs/sU6nc7uzGenrmbe6Jze2kGj8Ra4O0uC2D4EZYbD/mHdvW7r4
         Escw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rIFpFVrZDJP4I9nzuWdldBCoaWHhceeuaIoJxWAzySg=;
        b=0whJ2F3EUWcf58NQQQYukv4eQ9uqErlJO04urDYPTh97PeEd9uaF34Z157OrOojV2V
         Qdqx79vPHKcFjW4JnkiljfPudoW3AtcQI5sHfZ2w7zcFvxTTNB3xd2vdFEPvNsTs3bnw
         FO0yMTJJrnKsSRRKyHZfetJ2OR2zuI7H1kivZ8Cuh0J6nkCf2BXATGUBpEMlAfM3BoMu
         XbIMGVVqmF1s0aro2fxO55Pvr7tO3ntwq83+gq2D0iU9XV1bcyCaLaOQpnnY9g6Hj7rs
         X8KLJXeJwixiT07HuPsSXlpK8raCBZllV3cGJHbM6gHy4tF+5BkdMbOkEIdfUo3n866n
         7vcg==
X-Gm-Message-State: AOAM530S+G1y/KnQTfQ/HFTkElLJqxDluOa6VLShhZ4/HdsNOwU3hFVk
        VlKciZZPAQuioxWNx/AgQFLlPtLFLgr3dvmxnTLp2rur60TLfwxlGNXQpQ==
X-Google-Smtp-Source: ABdhPJxAhOUJUcIzDQRNhsNLQEh8BHFKsf6R8hRoWWiEdmR/5aS5VhQEBMkicvyFgvx9g/McfM1hApul28WThnVorMc=
X-Received: by 2002:a05:6122:181b:: with SMTP id ay27mr18540437vkb.36.1641376732884;
 Wed, 05 Jan 2022 01:58:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641043500.git.dyroneteng@gmail.com> <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com>
 <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Wed, 5 Jan 2022 17:58:41 +0800
Message-ID: <CADMgQSSjoxqzBDyGXiNC4wHqYGK7z4O0SG0zai85D-DtDHem=w@mail.gmail.com>
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

> This, along with two other similar instances, triggers the
> `static-analysis` job in the CI failure of `seen`. The suggested diff is:

The second and third I will optimize in the next patch.

The first one. Actually I am a little puzzled from this :

> -               strbuf_addf(line, "%7s", "-");
> +               strbuf_addstr(line, "-");

> But I think that the first hunk indicates a deeper issue, as `%7s`
> probably meant to pad the dash to seven dashes (which that format won't
> accomplish, but `strbuf_addchars()` would)?

"strbuf_addf(line, "%7s", "-");" here is used to align the columns
with a width of
seven chars, not repeat one DASH to seven.

A little weird about the fix recommendation of  "strbuf_addstr(line, "-");"=
 ,
because it will only add a single DASH here.

It's the identical result which compares to the "master"[1]  I think with t=
he
current codes and I tested the "strbuf_addf()" simply and it seems to work
fine.

[1] https://github.com/git/git/blob/master/builtin/ls-tree.c#L106

Thanks.

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=8C 22:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Teng,
>
> On Sat, 1 Jan 2022, Teng Long wrote:
>
> > diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> > index 009ffeb15d..6e3e5a4d06 100644
> > --- a/builtin/ls-tree.c
> > +++ b/builtin/ls-tree.c
> > @@ -56,23 +56,75 @@ enum {
> >
> >  static int cmdmode =3D MODE_UNSPECIFIED;
> >
> > -static int parse_shown_fields(void)
> > +static const char *format;
> > +static const char *default_format =3D "%(mode) %(type) %(object)%x09%(=
file)";
> > +static const char *long_format =3D "%(mode) %(type) %(object) %(size:p=
added)%x09%(file)";
> > +static const char *name_only_format =3D "%(file)";
> > +static const char *object_only_format =3D "%(object)";
> > +
> > +static void expand_objectsize(struct strbuf *line, const struct object=
_id *oid,
> > +                           const enum object_type type, unsigned int p=
added)
> >  {
> > -     if (cmdmode =3D=3D MODE_NAME_ONLY) {
> > -             shown_bits =3D SHOW_FILE_NAME;
> > -             return 0;
> > +     if (type =3D=3D OBJ_BLOB) {
> > +             unsigned long size;
> > +             if (oid_object_info(the_repository, oid, &size) < 0)
> > +                     die(_("could not get object info about '%s'"),
> > +                         oid_to_hex(oid));
> > +             if (padded)
> > +                     strbuf_addf(line, "%7" PRIuMAX, (uintmax_t)size);
> > +             else
> > +                     strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
> > +     } else if (padded) {
> > +             strbuf_addf(line, "%7s", "-");
>
> This, along with two other similar instances, triggers the
> `static-analysis` job in the CI failure of `seen`. The suggested diff is:
>
>
> -- snip --
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 6e3e5a4d0634..8301d1a15f9a 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -75,7 +75,7 @@ static void expand_objectsize(struct strbuf *line, cons=
t struct object_id *oid,
>                 else
>                         strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
>         } else if (padded) {
> -               strbuf_addf(line, "%7s", "-");
> +               strbuf_addstr(line, "-");
>         } else {
>                 strbuf_addstr(line, "-");
>         }
> @@ -110,7 +110,7 @@ static size_t expand_show_tree(struct strbuf *line, c=
onst char *start,
>         } else if (skip_prefix(start, "(size)", &p)) {
>                 expand_objectsize(line, data->oid, data->type, 0);
>         } else if (skip_prefix(start, "(object)", &p)) {
> -               strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev)=
);
> +               strbuf_add_unique_abbrev(line, data->oid, abbrev);
>         } else if (skip_prefix(start, "(file)", &p)) {
>                 const char *name =3D data->base->buf;
>                 const char *prefix =3D chomp_prefix ? ls_tree_prefix : NU=
LL;
> @@ -119,7 +119,7 @@ static size_t expand_show_tree(struct strbuf *line, c=
onst char *start,
>                 strbuf_addstr(data->base, data->pathname);
>                 name =3D relative_path(data->base->buf, prefix, &sb);
>                 quote_c_style(name, &quoted, NULL, 0);
> -               strbuf_addstr(line, quoted.buf);
> +               strbuf_addbuf(line, &quoted);
>         } else {
>                 errlen =3D (unsigned long)len;
>                 die(_("bad ls-tree format: %%%.*s"), errlen, start);
> -- snap --
>
> But I think that the first hunk indicates a deeper issue, as `%7s`
> probably meant to pad the dash to seven dashes (which that format won't
> accomplish, but `strbuf_addchars()` would)?
>
> Ciao,
> Dscho
>
> > +     } else {
> > +             strbuf_addstr(line, "-");
> >       }
> > -     if (cmdmode =3D=3D MODE_OBJECT_ONLY) {
> > -             shown_bits =3D SHOW_OBJECT_NAME;
> > -             return 0;
> > +}
> > +
> > +static size_t expand_show_tree(struct strbuf *line, const char *start,
> > +                            void *context)
> > +{
> > +     struct shown_data *data =3D context;
> > +     const char *end;
> > +     const char *p;
> > +     unsigned int errlen;
> > +     size_t len;
> > +     len =3D strbuf_expand_literal_cb(line, start, NULL);
> > +     if (len)
> > +             return len;
> > +
> > +     if (*start !=3D '(')
> > +             die(_("bad ls-tree format: as '%s'"), start);
> > +
> > +     end =3D strchr(start + 1, ')');
> > +     if (!end)
> > +             die(_("bad ls-tree format: element '%s' does not end in '=
)'"), start);
> > +
> > +     len =3D end - start + 1;
> > +     if (skip_prefix(start, "(mode)", &p)) {
> > +             strbuf_addf(line, "%06o", data->mode);
> > +     } else if (skip_prefix(start, "(type)", &p)) {
> > +             strbuf_addstr(line, type_name(data->type));
> > +     } else if (skip_prefix(start, "(size:padded)", &p)) {
> > +             expand_objectsize(line, data->oid, data->type, 1);
> > +     } else if (skip_prefix(start, "(size)", &p)) {
> > +             expand_objectsize(line, data->oid, data->type, 0);
> > +     } else if (skip_prefix(start, "(object)", &p)) {
> > +             strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev)=
);
> > +     } else if (skip_prefix(start, "(file)", &p)) {
> > +             const char *name =3D data->base->buf;
> > +             const char *prefix =3D chomp_prefix ? ls_tree_prefix : NU=
LL;
> > +             struct strbuf quoted =3D STRBUF_INIT;
> > +             struct strbuf sb =3D STRBUF_INIT;
> > +             strbuf_addstr(data->base, data->pathname);
> > +             name =3D relative_path(data->base->buf, prefix, &sb);
> > +             quote_c_style(name, &quoted, NULL, 0);
> > +             strbuf_addstr(line, quoted.buf);
> > +     } else {
> > +             errlen =3D (unsigned long)len;
> > +             die(_("bad ls-tree format: %%%.*s"), errlen, start);
> >       }
> > -     if (!ls_options || (ls_options & LS_RECURSIVE)
> > -         || (ls_options & LS_SHOW_TREES)
> > -         || (ls_options & LS_TREE_ONLY))
> > -             shown_bits =3D SHOW_DEFAULT;
> > -     if (cmdmode =3D=3D MODE_LONG)
> > -             shown_bits =3D SHOW_DEFAULT | SHOW_SIZE;
> > -     return 1;
> > +     return len;
> >  }
> >
> >  static int show_recursive(const char *base, size_t baselen,
> > @@ -106,6 +158,75 @@ static int show_recursive(const char *base, size_t=
 baselen,
> >       return 0;
> >  }
> >
> > +static int show_tree_init(enum object_type *type, struct strbuf *base,
> > +                       const char *pathname, unsigned mode, int *retva=
l)
> > +{
> > +     if (S_ISGITLINK(mode)) {
> > +             *type =3D OBJ_COMMIT;
> > +     } else if (S_ISDIR(mode)) {
> > +             if (show_recursive(base->buf, base->len, pathname)) {
> > +                     *retval =3D READ_TREE_RECURSIVE;
> > +                     if (!(ls_options & LS_SHOW_TREES))
> > +                             return 1;
> > +             }
> > +             *type =3D OBJ_TREE;
> > +     }
> > +     else if (ls_options & LS_TREE_ONLY)
> > +             return 1;
> > +     return 0;
> > +}
> > +
> > +static int show_tree_fmt(const struct object_id *oid, struct strbuf *b=
ase,
> > +                      const char *pathname, unsigned mode, void *conte=
xt)
> > +{
> > +     size_t baselen;
> > +     int retval =3D 0;
> > +     struct strbuf line =3D STRBUF_INIT;
> > +     struct shown_data data =3D {
> > +             .mode =3D mode,
> > +             .type =3D OBJ_BLOB,
> > +             .oid =3D oid,
> > +             .pathname =3D pathname,
> > +             .base =3D base,
> > +     };
> > +
> > +     if (show_tree_init(&data.type, base, pathname, mode, &retval))
> > +             return retval;
> > +
> > +     baselen =3D base->len;
> > +     strbuf_expand(&line, format, expand_show_tree, &data);
> > +     strbuf_addch(&line, line_termination);
> > +     fwrite(line.buf, line.len, 1, stdout);
> > +     strbuf_setlen(base, baselen);
> > +     return retval;
> > +}
> > +
> > +static int parse_shown_fields(void)
> > +{
> > +     if (cmdmode =3D=3D MODE_NAME_ONLY ||
> > +         (format && !strcmp(format, name_only_format))) {
> > +             shown_bits =3D SHOW_FILE_NAME;
> > +             return 1;
> > +     }
> > +
> > +     if (cmdmode =3D=3D MODE_OBJECT_ONLY ||
> > +         (format && !strcmp(format, object_only_format))) {
> > +             shown_bits =3D SHOW_OBJECT_NAME;
> > +             return 1;
> > +     }
> > +
> > +     if (!ls_options || (ls_options & LS_RECURSIVE)
> > +         || (ls_options & LS_SHOW_TREES)
> > +         || (ls_options & LS_TREE_ONLY)
> > +             || (format && !strcmp(format, default_format)))
> > +             shown_bits =3D SHOW_DEFAULT;
> > +
> > +     if (cmdmode =3D=3D MODE_LONG ||
> > +             (format && !strcmp(format, long_format)))
> > +             shown_bits =3D SHOW_DEFAULT | SHOW_SIZE;
> > +     return 1;
> > +}
> > +
> >  static int show_default(struct shown_data *data)
> >  {
> >       size_t baselen =3D data->base->len;
> > @@ -137,24 +258,6 @@ static int show_default(struct shown_data *data)
> >       return 1;
> >  }
> >
> > -static int show_tree_init(enum object_type *type, struct strbuf *base,
> > -                       const char *pathname, unsigned mode, int *retva=
l)
> > -{
> > -     if (S_ISGITLINK(mode)) {
> > -             *type =3D OBJ_COMMIT;
> > -     } else if (S_ISDIR(mode)) {
> > -             if (show_recursive(base->buf, base->len, pathname)) {
> > -                     *retval =3D READ_TREE_RECURSIVE;
> > -                     if (!(ls_options & LS_SHOW_TREES))
> > -                             return 1;
> > -             }
> > -             *type =3D OBJ_TREE;
> > -     }
> > -     else if (ls_options & LS_TREE_ONLY)
> > -             return 1;
> > -     return 0;
> > -}
> > -
> >  static int show_tree(const struct object_id *oid, struct strbuf *base,
> >               const char *pathname, unsigned mode, void *context)
> >  {
> > @@ -196,6 +299,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
> >       struct object_id oid;
> >       struct tree *tree;
> >       int i, full_tree =3D 0;
> > +     read_tree_fn_t fn =3D show_tree;
> >       const struct option ls_tree_options[] =3D {
> >               OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
> >                       LS_TREE_ONLY),
> > @@ -218,6 +322,9 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
> >               OPT_BOOL(0, "full-tree", &full_tree,
> >                        N_("list entire tree; not just current directory=
 "
> >                           "(implies --full-name)")),
> > +             OPT_STRING_F(0, "format", &format, N_("format"),
> > +                          N_("format to use for the output"),
> > +                          PARSE_OPT_NONEG),
> >               OPT__ABBREV(&abbrev),
> >               OPT_END()
> >       };
> > @@ -238,6 +345,10 @@ int cmd_ls_tree(int argc, const char **argv, const=
 char *prefix)
> >           ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
> >               ls_options |=3D LS_SHOW_TREES;
> >
> > +     if (format && cmdmode)
> > +             usage_msg_opt(
> > +                     _("--format can't be combined with other format-a=
ltering options"),
> > +                     ls_tree_usage, ls_tree_options);
> >       if (argc < 1)
> >               usage_with_options(ls_tree_usage, ls_tree_options);
> >       if (get_oid(argv[0], &oid))
> > @@ -261,6 +372,18 @@ int cmd_ls_tree(int argc, const char **argv, const=
 char *prefix)
> >       tree =3D parse_tree_indirect(&oid);
> >       if (!tree)
> >               die("not a tree object");
> > -     return !!read_tree(the_repository, tree,
> > -                        &pathspec, show_tree, NULL);
> > +
> > +     /*
> > +      * The generic show_tree_fmt() is slower than show_tree(), so
> > +      * take the fast path if possible.
> > +      */
> > +     if (format && (!strcmp(format, default_format) ||
> > +                                !strcmp(format, long_format) ||
> > +                                !strcmp(format, name_only_format) ||
> > +                                !strcmp(format, object_only_format)))
> > +             fn =3D show_tree;
> > +     else if (format)
> > +             fn =3D show_tree_fmt;
> > +
> > +     return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
> >  }
> > diff --git a/t/t3105-ls-tree-format.sh b/t/t3105-ls-tree-format.sh
> > new file mode 100755
> > index 0000000000..92b4d240e8
> > --- /dev/null
> > +++ b/t/t3105-ls-tree-format.sh
> > @@ -0,0 +1,55 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'ls-tree --format'
> > +
> > +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'ls-tree --format usage' '
> > +     test_expect_code 129 git ls-tree --format=3Dfmt -l &&
> > +     test_expect_code 129 git ls-tree --format=3Dfmt --name-only &&
> > +     test_expect_code 129 git ls-tree --format=3Dfmt --name-status &&
> > +     test_expect_code 129 git ls-tree --format=3Dfmt --object-only
> > +'
> > +
> > +test_expect_success 'setup' '
> > +     mkdir dir &&
> > +     test_commit dir/sub-file &&
> > +     test_commit top-file
> > +'
> > +
> > +test_ls_tree_format () {
> > +     format=3D$1 &&
> > +     opts=3D$2 &&
> > +     shift 2 &&
> > +     git ls-tree $opts -r HEAD >expect.raw &&
> > +     sed "s/^/> /" >expect <expect.raw &&
> > +     git ls-tree --format=3D"> $format" -r HEAD >actual &&
> > +     test_cmp expect actual
> > +}
> > +
> > +test_expect_success 'ls-tree --format=3D<default-like>' '
> > +     test_ls_tree_format \
> > +             "%(mode) %(type) %(object)%x09%(file)" \
> > +             ""
> > +'
> > +
> > +test_expect_success 'ls-tree --format=3D<long-like>' '
> > +     test_ls_tree_format \
> > +             "%(mode) %(type) %(object) %(size:padded)%x09%(file)" \
> > +             "--long"
> > +'
> > +
> > +test_expect_success 'ls-tree --format=3D<name-only-like>' '
> > +     test_ls_tree_format \
> > +             "%(file)" \
> > +             "--name-only"
> > +'
> > +
> > +test_expect_success 'ls-tree --format=3D<object-only-like>' '
> > +     test_ls_tree_format \
> > +             "%(object)" \
> > +             "--object-only"
> > +'
> > +
> > +test_done
> > --
> > 2.33.0.rc1.1802.gbb1c3936fb.dirty
> >
> >
> >
