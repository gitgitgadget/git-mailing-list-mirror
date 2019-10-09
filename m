Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A711F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 03:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfJIDCW (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 23:02:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35015 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJIDCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 23:02:21 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so1730526iop.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0aXjLYLtvtcVsJMHrLNv03RbQt7xzNFcdtC4rYpPq0Y=;
        b=dfXwv1so2SKJ4q7JodCQODBj6O/X35Ldx2bwVTZvWgnIOC1kjIBUKf0Mw/h+dQDod4
         dBztHCi2yKNZhUzW75cNPT9V25LKWLJTKQtxK/u3eFHvSXYRM3wlEkOQ8S9UNCA544Ys
         6Qbkmyq2sK2OodHitVK82kVm6qBFuaDjpiSqUvhTEwAXM6ZnYF8WeJPOB0l9p9vFM2Ef
         D8L7BRFM/7WtWnXbh4jUH5Mgyd4WUPGAoQRund59VqjSJrBafC8eGuD3k15YPvcatw+s
         9r98J6HGbGe/oB6KPLzmxJkbAtvZ+AXTalx/imscXa6N+yIYYMl6X7vyxZNo1zkDsL4D
         MXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0aXjLYLtvtcVsJMHrLNv03RbQt7xzNFcdtC4rYpPq0Y=;
        b=dM2oGmTfYgOdMh/8cDRi+V4tGAqK75x2/0Y8UiUM9L8X/RuaxDoriWpj7NAkv3rcY6
         bBLeSEpBWQJt0+5G7R7RHNDH5lzoeU2SNoX+BjthdqZXPq7a9P/SmtqYLxyHV+37oLvx
         EUVMXypDkkPMq7YTr6lpiZHkbl8gbpziGiS49suQ5yHgMwHwNF356JaY1q7LA7syQfeA
         hDvZYWeu1GVLvtDuBjxt1C3p+8jy7vHpRKp0OKBW6iVNns6Tudh8x39bdXcokO186zxG
         cY+3QvuKbaq0lJjSldrJAjIYkQUyWEkXEp1pia2FJPedpEw9nkkc6R9AVEiuwaHr4gUG
         v4zg==
X-Gm-Message-State: APjAAAUOqIikRNs4SWsUcKms7jbcppQSIi/+k/utqVqlHN5Jo2a6+wwc
        jdD7K8lcaIl+1KeDxOz8NhKtu9DnaaCgAkLx+Zawrw==
X-Google-Smtp-Source: APXvYqy0QLDN9W95Xh6evneahMi3Y68swiF0/D43J4ySAxTPWvNyr/UtE1QDbMxtDWWADv0ud7zA3IrQPTG9QTTOIw4=
X-Received: by 2002:a6b:7e49:: with SMTP id k9mr1428102ioq.280.1570590140632;
 Tue, 08 Oct 2019 20:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com> <20191008184727.14337-3-lucasseikioshiro@gmail.com>
In-Reply-To: <20191008184727.14337-3-lucasseikioshiro@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 9 Oct 2019 00:02:08 -0300
Message-ID: <CAHd-oW6mK1ZSCu-igT5PSLop6gDEtKmrsg6sBsGij2NMxgy25g@mail.gmail.com>
Subject: Re: [RFC WIP PATCH 2/3] tag: factor out prepare tag template code
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kernel USP <kernel-usp@googlegroups.com>,
        rcdailey.lists@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?B=C3=A1rbara_Fernandes?= <barbara.dcf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 8, 2019 at 3:47 PM Lucas Oshiro <lucasseikioshiro@gmail.com> wr=
ote:
>
> Improve code readability by moving tag body reading to a new function cal=
led
> get_tag_body. This function will be used in the following patches to fix =
the
> --no-edit flag.

This seems to be accidentally duplicated from patch 1/3.

> Enhance legibility by encapsulating code that loads previous tag message
> (if any) in new function prepare_tag_template. This code refactoring is
> part of a series of commits that intend to implement the git tag --amend
> flag and fix the functionality of --no-edit.
>
> Co-authored-by: B=C3=A1rbara Fernandes <barbara.dcf@gmail.com>
> Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: B=C3=A1rbara Fernandes <barbara.dcf@gmail.com>

These tags can be re-ordered as I mentioned in patch 1/3, to follow a
chronological order: probably the Helped-by first followed by the
Co-authored-by, Barbara's S-o-B and then your S-o-B.

> ---
>  builtin/tag.c | 65 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index e1e3549af9..0322bdbdfb 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -244,6 +244,43 @@ static const char message_advice_nested_tag[] =3D
>            "\n"
>            "\tgit tag -f %s %s^{}");
>
> +/*
> + * Write the tag template message with previous tag body (if any) to the=
 given
> + * file.
> + */

Maybe mention that the function creates the file at the given path?

> +static void prepare_tag_template(struct strbuf *given_msg,
> +                                struct create_tag_options *opt,
> +                                struct object_id *prev, char *path,
> +                                const char *tag)

I'm wondering if we could simplify this signature. Maybe we could
resolve whether a message was given at CLI, and if a previous tag
already exists, before getting to this function. This way, 'given_msg'
and 'prev' could be collapsed into a single 'struct strbuf *tag_body'
(and we could replace checking 'opt->message_given' and
'is_null_oid(prev)' by checking if 'tag_body' is not NULL). Then, we
could also pass just the 'cleanup_mode" instead of the whole
'create_tag_options'. Does this makes sense?

> +{
> +       int fd;
> +
> +       fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> +       if (fd < 0)
> +               die_errno(_("could not create file '%s'"), path);
> +
> +       if (opt->message_given) {
> +               write_or_die(fd, given_msg->buf, given_msg->len);
> +               strbuf_reset(given_msg);

I think keeping this reset at create_tag() (right before
lauch_editor() is called and only if 'opt->message_given') makes it
easier to understand what's happening (because there, we are cleaning
the given 'buf' to use it in lauch_editor()). Calling it here may be
misleading as 'given_msg' is not used in this function anymore.

> +       } else if (!is_null_oid(prev)) {
> +               write_tag_body(fd, prev);
> +       } else {
> +               struct strbuf template =3D STRBUF_INIT;
> +               strbuf_addch(&template, '\n');
> +               if (opt->cleanup_mode =3D=3D CLEANUP_ALL) {
> +                       strbuf_commented_addf(&template, _(tag_template),=
 tag,
> +                                             comment_line_char);
> +               } else {
> +                       strbuf_commented_addf(&template,
> +                                             _(tag_template_nocleanup), =
tag,
> +                                             comment_line_char);
> +               }
> +               write_or_die(fd, template.buf, template.len);
> +               strbuf_release(&template);
> +       }
> +       close(fd);
> +}
> +
>  static void create_tag(const struct object_id *object, const char *objec=
t_ref,
>                        const char *tag,
>                        struct strbuf *buf, struct create_tag_options *opt=
,
> @@ -251,7 +288,7 @@ static void create_tag(const struct object_id *object=
, const char *object_ref,
>  {
>         enum object_type type;
>         struct strbuf header =3D STRBUF_INIT;
> -       char *path =3D NULL;
> +       char *path =3D git_pathdup("TAG_EDITMSG");
>
>         type =3D oid_object_info(the_repository, object, NULL);
>         if (type <=3D OBJ_NONE)
> @@ -271,31 +308,7 @@ static void create_tag(const struct object_id *objec=
t, const char *object_ref,
>                     git_committer_info(IDENT_STRICT));
>
>         if (!opt->message_given || opt->use_editor) {
> -               int fd;
> -
> -               /* write the template message before editing: */
> -               path =3D git_pathdup("TAG_EDITMSG");
> -               fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> -               if (fd < 0)
> -                       die_errno(_("could not create file '%s'"), path);
> -
> -               if (opt->message_given) {
> -                       write_or_die(fd, buf->buf, buf->len);
> -                       strbuf_reset(buf);
> -               } else if (!is_null_oid(prev)) {
> -                       write_tag_body(fd, prev);
> -               } else {
> -                       struct strbuf buf =3D STRBUF_INIT;
> -                       strbuf_addch(&buf, '\n');
> -                       if (opt->cleanup_mode =3D=3D CLEANUP_ALL)
> -                               strbuf_commented_addf(&buf, _(tag_templat=
e), tag, comment_line_char);
> -                       else
> -                               strbuf_commented_addf(&buf, _(tag_templat=
e_nocleanup), tag, comment_line_char);
> -                       write_or_die(fd, buf.buf, buf.len);
> -                       strbuf_release(&buf);
> -               }
> -               close(fd);
> -
> +               prepare_tag_template(buf, opt, prev, path, tag);
>                 if (launch_editor(path, buf, NULL)) {
>                         fprintf(stderr,
>                         _("Please supply the message using either -m or -=
F option.\n"));
> --
> 2.23.0
>
