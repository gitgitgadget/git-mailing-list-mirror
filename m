Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E05C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949E322B3B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbhAZFEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbhAYTZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:25:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A296C06174A
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:23:43 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n2so28892350iom.7
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GpdGX84pv2ZXJvc3tjs6DK/YI1bEy24edvNcHoo2G1g=;
        b=KDBBQM5Ryy9ubRlgqLlvxsz18CTsMYOI6nlRPZAcchrpvh+qmTmXpdc5KTExWnoQkI
         wdJJtSCvHwfNO3o4hRMWIw+iKeyI7HDKZkYaXKU4/xU7qJoMYCOXias56EtfwsB23RGS
         Gw1VMD3FfmMaQwHOBk0SDBCiEdbKI8Yer8+LwF+JhITq8yQH/XKc142EpiCY+o5Sps8M
         S589QXoC6Vj7sAtBdkZztJVrWQWCdTYs5f+J6eZsyNcTIxsPXJJQV9qlC94J2vuBnjjy
         ZyyqTOpgLircAHLACgucje5d09i19kQ8BDyLBbWv+mhmdW0yipG3k6VrTJ7exwV7EUTF
         QvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GpdGX84pv2ZXJvc3tjs6DK/YI1bEy24edvNcHoo2G1g=;
        b=o6v2uMxaESG8CIa6kSmz1us4g82R3aUWers6FTjFSKR/74XTCCCypbS9uZliL0GBeT
         vbpogqPy+87MwRuxsAlODOe6FoP4TeY+5kb+Wa29VK/eiFEOLDNBjCx0XIlomMX1LTZx
         N5Q3UMIOXt46byZVKo9bh9wCfYIM5D9Gwr250Wt3FXDG0/pHY58eHfu7Y1JQhD8nhglF
         xQoctU/2t0VZFp1fXX1hbrWG11SJGSLTtThCQ6MFJuLSDzWnY//NdgPY6ZAphLpMWNsR
         mTHo03yu9U8pgmPhiJomWLnzXwsG4jkMtlLAwLo3tK6PRDcXPfmLcsJdUMsAgniKjy2o
         ydwg==
X-Gm-Message-State: AOAM533u4Z40TG28SiRupVs2TkrXHJO7E5ccyXfJLMEeCLcBYGC9ldtk
        VtITXDP0V/bbC0jfw9oKJtKjBfZDHqd456R31lXDhr4d
X-Google-Smtp-Source: ABdhPJwXoVDlxPUXxfnXUsA6qNDXrSzmGTRQtMTf2iMzO0M+Ps0TkTIAGm/WKryzNCHkKpocl7ZHnc+TWO6iJ9lqEkE=
X-Received: by 2002:a6b:d20d:: with SMTP id q13mr1623719iob.71.1611602622713;
 Mon, 25 Jan 2021 11:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20210123154056.48234-1-mirucam@gmail.com> <20210123154056.48234-2-mirucam@gmail.com>
 <gohp6kv9bml9qc.fsf@gmail.com>
In-Reply-To: <gohp6kv9bml9qc.fsf@gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Mon, 25 Jan 2021 20:23:32 +0100
Message-ID: <CAN7CjDANLB85GHVVn32w_Y70bzvadtqdq2uRyc81j7nz+W05jA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rafael,

El dom, 24 ene 2021 a las 14:56, Rafael Silva
(<rafaeloliveira.cs@gmail.com>) escribi=C3=B3:
>
>
> Nice work on this series.
>
> I have one comment on this series regarding a behavior diff between the
> C and shell version, and small comment about style, see below.
>
> Miriam Rubio writes:
>
> > From: Pranit Bauva <pranit.bauva@gmail.com>
> >
> > Reimplement the `bisect_log()` shell function in C and also add
> > `--bisect-log` subcommand to `git bisect--helper` to call it from
> > git-bisect.sh .
> >
> > Using `--bisect-log` subcommand is a temporary measure to port shell
> > function to C so as to use the existing test suite.
> >
> > Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  builtin/bisect--helper.c | 22 +++++++++++++++++++++-
> >  git-bisect.sh            |  7 +------
> >  2 files changed, 22 insertions(+), 7 deletions(-)
> >
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 709eb713a3..a65244a0f5 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -904,6 +904,18 @@ static enum bisect_error bisect_state(struct bisec=
t_terms *terms, const char **a
> >       return bisect_auto_next(terms, NULL);
> >  }
> >
> > +static enum bisect_error bisect_log(void)
> > +{
> > +     int fd, status;
> > +     fd =3D open(git_path_bisect_log(), O_RDONLY);
> > +     if (fd < 0)
> > +             return BISECT_FAILED;
> > +
> > +     status =3D copy_fd(fd, STDOUT_FILENO);
> > +     close(fd);
> > +     return status ? BISECT_FAILED : BISECT_OK;
> > +}
> > +
>
> In the shell version, when we are not bisecting it the `git bisect log`
> command will `die` with the text "We are not bisecting." which state to
> the user that a bisect is not yet started. The shell version does that
> by checking if the `$GIT_DIR/BISECT_LOG` file doesn't exists or it's
> an empty file as the following code snippet copied from the shell
> version that is remove by this patch:
>
>    test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.=
")"
>
> This seems to be "missing" from the new C version implemented by this
> patch and perhaps we should add it. I'm not sure whether this change was
> intentional and I'm missing some context here of why we are dropping
> the message, if that's the case I apologize in advance. But, IMHO
> outputting the error message provides a better user experience as it
> would be obvious that the user forgot to `git bisect start` instead of
> silently failing.
>
> With that said, perhaps an obvious way of implementing is to use
> `is_empty_or_missing_file()`, much like `bisect_replay()` does it in the
> [2/7] patch on this series, and return the same error message from
> the shell version:
>
> -- >8 --
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index a65244a0f5..ce11383125 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -907,7 +907,12 @@ static enum bisect_error bisect_state(struct bisect_=
terms *terms, const char **a
>  static enum bisect_error bisect_log(void)
>  {
>         int fd, status;
> -       fd =3D open(git_path_bisect_log(), O_RDONLY);
> +       const char* filename =3D git_path_bisect_log();
> +
> +       if (is_empty_or_missing_file(filename))
> +               return error(_("We are not bisecting."));
> +
> +       fd =3D open(filename, O_RDONLY);
>         if (fd < 0)
>                 return BISECT_FAILED;
> -- >8 --
>
> Although I compiled and did small test on the above code snippet, don't
> trust it blindly and perform your own test and judge whether this is the
> best way to implement this shortcoming.
Ok, thank you.
I am not the original author of this subcommand reimplementation and I
don't know if there is a reason
 for the difference with the error message. Maybe we can wait for some
other reviewers opinion.
>
> >
> > @@ -210,7 +205,7 @@ case "$#" in
> >       replay)
> >               bisect_replay "$@" ;;
> >       log)
> > -             bisect_log ;;
> > +             git bisect--helper --bisect-log || exit;;
>
> Style: just a minor change to add a space between `exit` and `;;`.
Noted.
>
> --
> Thanks
> Rafael
Thank you for your suggestions.
Best,
Miriam
