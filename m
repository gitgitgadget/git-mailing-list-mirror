Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D250E20248
	for <e@80x24.org>; Wed, 27 Feb 2019 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfB0Rak (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 12:30:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39619 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0Rak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 12:30:40 -0500
Received: by mail-io1-f68.google.com with SMTP id x3so14197791ior.6
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lBw58kiWqRTQyS5cqw8WT5VYp27U6M1WBpEFgDLhnA=;
        b=rB3CfjcbTlnpQ/Jezb23B1u9gxoh4wN2Du1PZpalFPwjOLaPFK4LRv1qu1HFtBXV52
         bFhzdB9c3RCx/m3iJrTceH3KkgmRGyokF1J3dHMN/RIOoVdn4fKC4Bb77/k9tInREYyv
         jBBu02RnPw+nVgdvJmk0l7k6rtuy6bUce0V3ZRv6OGrc8bqXra08nZhFoVcDN2zRV7Px
         Dq1hvyPVMaFJT6NV6NO2BpygieNzy9KjX1qovutksESJnYQQ+QWFSZo7VVz2QYwifXJG
         T63aZMqYFttdRd/8Mi6x2n/vWb3IwOEGydvF6Bw+dG5BixzMxw+cAEU5vxRJXbAH+Aq3
         3dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lBw58kiWqRTQyS5cqw8WT5VYp27U6M1WBpEFgDLhnA=;
        b=rC9igW5vGJEDIKj3wdwdFdqrT/zHtRq9oofzdMTOpoJmgvG/3Cb+SlQgP6moM1tvFT
         ecnOmdL0HEc4p+V87nB3vpOf+eUgX7o3Bc6+4waLgQfW/bW8DCHzPm3SC54rtBVd4Pqg
         W4kA0SukXxtqwNxqd9Oj6lxe6IQ34T4vhJhQ+bbKXgDp19RCLmvCrhIA70mDFNn9hxwW
         7B6uBKnVoyLx6aTNhhtapkaTHA0LD5mpkPAH4g44iTlqn2xADvJXTEdA/clNqvGUCiy1
         kgSj+cHOiZXHsCdx6HiUyb+CyshmY7xbLv6qOnXyKFJYgVT5FDaOU3tjawXR4OFWwPfy
         qNLw==
X-Gm-Message-State: APjAAAUp0f5LamNfUOoAkY9CJkbi2XbMLFyvkNSoWahBluORkKHSQrdh
        DUYYu2TxcofDyvDSvBIUmB1zd1ilNbvEBYwEWwYua8BRo4E=
X-Google-Smtp-Source: APXvYqzA73sWZQ/Vt8sYmOdOvRKe8kLXgvrJC/y6CeHZuQ4iRY6usw1Qaha71wvN2D4Iequs057Sp6i5qN4QsSI4/6g=
X-Received: by 2002:a6b:c30d:: with SMTP id t13mr2977609iof.66.1551288639158;
 Wed, 27 Feb 2019 09:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226051804.10631-5-matheus.bernardino@usp.br> <CACsJy8BztC=GNuPU_CuLbPSmhsjrSk8MmkyeK6ahgjEOzY=yOQ@mail.gmail.com>
In-Reply-To: <CACsJy8BztC=GNuPU_CuLbPSmhsjrSk8MmkyeK6ahgjEOzY=yOQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 27 Feb 2019 14:30:27 -0300
Message-ID: <CAHd-oW5aOf+TE_AeA=VkaZUt7LTeSK_buojsEgb3NYMVVm1B_g@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 4/5] clone: extract function from copy_or_link_directory
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 9:18 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Extract dir creation code snippet from copy_or_link_directory to its own
> > function named mkdir_if_missing. This change will help removing
> > copy_or_link_directory's explicit recursion, which will be done in a
> > following patch. Also makes code more readable.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  builtin/clone.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index cae069f03b..fd580fa98d 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -392,6 +392,24 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
> >         fclose(in);
> >  }
> >
> > +static void mkdir_if_missing(const char *pathname, mode_t mode)
> > +{
> > +       /*
> > +        * Create a dir at pathname unless there's already one.
>
> This confused me for a second because I thought it described "st"
> variable. I think we usually put the description of the function on
> top (before the "void mkdir_if.." line). But with a such a short
> function and clear name like this, I don't think we need any comments.
>

Yes, I also don't like the description being after the function
declaration, but I did this to follow the pattern from other functions
on the same file (e.g. copy_alternates).  Anyway, I do agree with you
that this function don't need a description, so I'm removing it for
the next version. Thanks!

> > +        */
> > +       struct stat st;
> > +
> > +       if (mkdir(pathname, mode)) {
>
> Good opportunity to unindent this by doing
>
>     if (!mkdir(...
>          return;
>
> but it's up to you.
>

Ok. But being such a small snippet, is the indentation really a code
smell here? (sorry, I'm still getting used to git's coding guidelines)

> > +               if (errno != EEXIST)
> > +                       die_errno(_("failed to create directory '%s'"),
> > +                                 pathname);
> > +               else if (stat(pathname, &st))
> > +                       die_errno(_("failed to stat '%s'"), pathname);
> > +               else if (!S_ISDIR(st.st_mode))
> > +                       die(_("%s exists and is not a directory"), pathname);
> > +       }
> > +}
> > +
> >  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> >                                    const char *src_repo, int src_baselen)
> >  {
> > @@ -404,14 +422,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> >         if (!dir)
> >                 die_errno(_("failed to open '%s'"), src->buf);
> >
> > -       if (mkdir(dest->buf, 0777)) {
> > -               if (errno != EEXIST)
> > -                       die_errno(_("failed to create directory '%s'"), dest->buf);
> > -               else if (stat(dest->buf, &buf))
> > -                       die_errno(_("failed to stat '%s'"), dest->buf);
> > -               else if (!S_ISDIR(buf.st_mode))
> > -                       die(_("%s exists and is not a directory"), dest->buf);
> > -       }
> > +       mkdir_if_missing(dest->buf, 0777);
> >
> >         strbuf_addch(src, '/');
> >         src_len = src->len;
> > --
> > 2.20.1
> >
>
>
> --
> Duy
