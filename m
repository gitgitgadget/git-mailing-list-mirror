Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B1C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352561AbiFTOUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349958AbiFTOST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 10:18:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B52FE
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 06:32:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b138so11076459iof.13
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=67VU2Y+uD9LnE1BT0BhIhdQktx1M9JHFX71v1PRmx0E=;
        b=SQPyIYvmv+aidOk60TSfKh9m47UV4Uok2dvC3CCuw0Ps0IdEmoEcXntF7g9Vfk34/v
         /bkZL0CPSjU87/kE+2MBu3dcszfM5vgkFFCApUfKOpHT2JOnGnohttCeg09q9YaurR4M
         C4+asSL1SQI+iucpuIAYQlBCbox9VBP2OolD6qy3tDV9O001KAAJ9dxciNQrB8eOdvMw
         eecc5bVFAbR6yBzNpPz5xFOsXkyN4OEoNnZmUKT8VCVmgXAVnE/xu++SAJdF5muad9+5
         PpAxK6tVJieBg7BZ/9qsBRmw6Swa2o0aOtobwyMN48Fx4kU4ts9OdZSWnMB3kgHE7bZJ
         37xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=67VU2Y+uD9LnE1BT0BhIhdQktx1M9JHFX71v1PRmx0E=;
        b=WpJyM8qCswU41P23e8edAfRA0Ttx9P/hJt1d6Rk6S0TCpI/LZzG2OkQUApYq7ZiK9L
         ZB+gpvzXoZaP/ZeYxrv8z7erILx5vmgciwTRQI55kjaGUXuIdsljKZuXZp6KoQ+AWNni
         t8DdS6Eo4GUbuykTg0pB6t+QfhR0SduAF8PxqXulq8MDaSmvw8gpcpCLCZ+O6RM7YjfT
         MqnHID9YAUfOaZDTuB6DiuTLaTF64Wx7TtFLQnQaZxuRtusdmCb1LHCaP91UxSZu3jyY
         0E5obtI7CNU8rz4PH/p6uWBuxN5uUjKySxlu880wxoaC6C6c8/Uewy4TCC6Ie2iAFhgT
         8Drg==
X-Gm-Message-State: AJIora/Gz1gpRJTxYBl+XPPr8FYaFPV/5g1MmzDPZweo0KkzIOju5JGb
        yZf3GvJd8jmV8bBEWz0bqhhI/8bfoyQF/Cx9Xak=
X-Google-Smtp-Source: AGRyM1s/rOAMwd8H3O/W6gjs3j4zEA5D2HJE6lFe/Ix1cxNbBbj6KfnqQ4eo1Rq8s4PrTtrpuJby+FIP30ihuCGssKQ=
X-Received: by 2002:a05:6638:3389:b0:331:f5e7:7dda with SMTP id
 h9-20020a056638338900b00331f5e77ddamr13049887jav.93.1655731974001; Mon, 20
 Jun 2022 06:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
 <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com> <44f572b8-6cef-fad4-04c0-3cbb79db5bf9@gmail.com>
In-Reply-To: <44f572b8-6cef-fad4-04c0-3cbb79db5bf9@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 20 Jun 2022 21:32:42 +0800
Message-ID: <CAOLTT8R_ZAWBWxzNqFOQc7igBSpODYUi1On9nfVPGkYQd47Rgg@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: introduce "--format" option
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8819=
=E6=97=A5=E5=91=A8=E6=97=A5 21:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing
>
> On 19/06/2022 10:13, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add a new option --format that output index enties
> > informations with custom format, taking inspiration
> > from the option with the same name in the `git ls-tree`
> > command.
> >
> > --format cannot used with -s, -o, -k, --resolve-undo,
> > --deduplicate and --debug.
>
> I think this is an interesting feature that provides functionality that
> is not available by feeding index entries into cat-file.
>

Yeah, it cares about index state. Having this feature, maybe we can
easier check index/work-tree state.

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> >   Documentation/git-ls-files.txt |  51 ++++++++++++-
> >   builtin/ls-files.c             | 130 ++++++++++++++++++++++++++++++++=
-
> >   t/t3013-ls-files-format.sh     | 130 ++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 307 insertions(+), 4 deletions(-)
> >   create mode 100755 t/t3013-ls-files-format.sh
> >
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index 0dabf3f0ddc..9a88c92f1ad 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -20,7 +20,7 @@ SYNOPSIS
> >               [--exclude-standard]
> >               [--error-unmatch] [--with-tree=3D<tree-ish>]
> >               [--full-name] [--recurse-submodules]
> > -             [--abbrev[=3D<n>]] [--] [<file>...]
> > +             [--abbrev[=3D<n>]] [--format=3D<format>] [--] [<file>...]
> >
> >   DESCRIPTION
> >   -----------
> > @@ -192,6 +192,13 @@ followed by the  ("attr/<eolattr>").
> >       to the contained files. Sparse directories will be shown with a
> >       trailing slash, such as "x/" for a sparse directory "x".
> >
> > +--format=3D<format>::
> > +     A string that interpolates `%(fieldname)` from the result being s=
hown.
> > +     It also interpolates `%%` to `%`, and `%xx` where `xx` are hex di=
gits
> > +     interpolates to character with hex code `xx`; for example `%00`
> > +     interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (=
LF).
> > +     --format cannot be combined with `-s`, `-o`, `-k`, `--resolve-und=
o` and
> > +     `--debug`.
> >   \--::
> >       Do not interpret any more arguments as options.
> >
> > @@ -223,6 +230,48 @@ quoted as explained for the configuration variable=
 `core.quotePath`
> >   (see linkgit:git-config[1]).  Using `-z` the filename is output
> >   verbatim and the line is terminated by a NUL byte.
> >
> > +It is possible to print in a custom format by using the `--format`
> > +option, which is able to interpolate different fields using
> > +a `%(fieldname)` notation. For example, if you only care about the
> > +"objectname" and "path" fields, you can execute with a specific
> > +"--format" like
> > +
> > +     git ls-files --format=3D'%(objectname) %(path)'
> > +
> > +FIELD NAMES
> > +-----------
> > +Various values from structured fields can be used to interpolate
> > +into the resulting output. For each outputting line, the following
> > +names can be used:
> > +
> > +tag::
> > +     The tag of file status.
>
> The documentation for -t strong discourages its use, so I wonder if we
> really want to expose it here.
>

I think it's ok to remove it.

> > +objectmode::
> > +     The mode of the object.
> > +objectname::
> > +     The name of the object.
> > +stage::
> > +     The stage of the file.
> > +eol::
> > +     The line endings of files.
>
> Every other option refers to either a "file" or "object" but here we
> have "files". Looking at the implementation below this will print the
> line ending from both the index and the worktree, it would be useful to
> clarify that here.
>

Sure...

> > +path::
> > +     The pathname of the object.
> > +ctime::
> > +     The create time of file.
>
> It is not clear from this whether this (and all the file attributes
> below) are coming from the worktree or the index or both like eol?
>

...I think they are basically index cache_entry attributes, except eol
cares about both
worktree and index. I will fix them.

> > +mtime::
> > +     The modify time of file.
> > +dev::
> > +     The ID of device containing file.
> > +ino::
> > +     The inode number of file.
> > +uid::
> > +     The user id of file owner.
> > +gid::
> > +     The group id of file owner.
> > +size::
> > +     The size of the file.
> > +flags::
> > +     The flags of the file.
>
> What are the flags?
>

It is cache entry flags which include In-memory only flags and some
extended on-disk flags.

> > [...]
> > +static size_t expand_show_index(struct strbuf *sb, const char *start,
> > +                            void *context)
> > +{
> > +     struct show_index_data *data =3D context;
> > +     const char *end;
> > +     const char *p;
> > +     unsigned int errlen;
>  > [...]
> > +     else if (skip_prefix(start, "(flags)", &p))
> > +             strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
> > +     else {
> > +             errlen =3D (unsigned long)len;
> > +             die(_("bad ls-files format: %%%.*s"), errlen, start);
>
> errlen is declared as an unsigned int, but you cast len which is a
> size_t to unsigned long when assigning to errlen. Then errlen is used
> where a signed int is required by die. There is also a style violation
> as if any branch of an if needs braces then they should all be braced. I
> think that the best solution would be to drop errlen and just write
>
>         else
>                 die(_("bad ls-files format: %%%.*s"), (int)len, start);
>

This piece of code is copying from ls-tree. Maybe we should fix it too.

> It would be interesting to check the performance of this implementation
> on a large repository as it is doing a lot of branching inside a loop. I
> don't think we should change it unless it turns out to be a problem.
> Then we could try switching on the first character of the format
> specifier or some other optimization.
>

Just like ref-filter or something else does, it parses atoms
and then fills buffers with information. Maybe we need such performance
optimization later, but for now, it's just easier to implement this patch :=
)

> Best Wishes
>
> Phillip

Thanks

ZheNing Hu
