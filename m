Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58893C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BF261166
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGIRyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRyy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:54:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F2C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 10:52:11 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 53-20020a9d0eb80000b02904b6c4d33e84so1555766otj.13
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKbNzIDviKImsNWHTJOQXt2wOkHwjyHn0dkwuk14aEU=;
        b=pexMXFu4aI9OQtBM9b1mMw2heUtQTjCdofO9YuHSjrJznG4azrXREqjXLaZDsDNbjD
         k4RepIwaahY4t/452FzCock4s8MNyzy9EkNZTjkxFlNvHGVabL9gaMh0pOD7C12A+8l6
         T134w8D7+RL6+R1TaBkvrrFzRVUI9o7L5RQyOaVaSvu4Nd5r5URI8GAl/5uQUxxEqZOn
         bhrAZd2dot5+tyqCBWWZpxs7So+HyoAkOkjunDjbpdQi+HQzqlxMV4TywmjCJWcEzVph
         9yREZbEpFV0pUN0T4vkf7Ozqcu0liGc/KX6/Nqu2TkuXVo4yYA+IEAkTrCEnVz8UD9sC
         WnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKbNzIDviKImsNWHTJOQXt2wOkHwjyHn0dkwuk14aEU=;
        b=awO24hFMgsO6qV0QrqpOnUhYLwKZ8M1/o4HPFPWkWH1zdl3W6NaKVALPuCh/2f3CJm
         77zTNxr8npVIzknH3ADrq/rIzbLcZiprTCuHudXQdMGstbbTfV2H42i+eL5VgC9onNnr
         GxazSqn36ewE0TdBlXkSCkfPJmGv82O73qWNU17gUKPYUoTOCEfINELPDu6VQ26XSVLm
         VB7U5HPn2l04+VqRuQq1KyHYEMWbjw4E/kab5oXrVgjtxBOEyIMCcQNbAcRTmhb1to9b
         Y7oL59ZEokQ5+2zYEv1v8ajzJhbrbni0UvHR1GdiFWIjOATCzug8abmE0XJpswy1T5Jq
         ODaQ==
X-Gm-Message-State: AOAM531K+23PCvepnxLuTv3TmCjFTQTQv4CI9pV+Zzm1Qjv66mEOxW0s
        f5ONrje4Zbegn6r+6wLGnQwmt3yHMyrPhzHJRhg=
X-Google-Smtp-Source: ABdhPJweRFMkayi3UjqvJHRpBo+6KMQ3vR1vUKRnTjeF/FMSIHVuAOaUPG68oSyf7LphW7IgVPRm2dy3Ny5dZqPoMWM=
X-Received: by 2002:a9d:73c1:: with SMTP id m1mr26438791otk.162.1625853130540;
 Fri, 09 Jul 2021 10:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <e3d6c6d670b46d4f0dc133e83c6feede4d55c412.1625844149.git.git@grubix.eu>
 <xmqqk0lz764u.fsf@gitster.g>
In-Reply-To: <xmqqk0lz764u.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 9 Jul 2021 10:51:59 -0700
Message-ID: <CABPp-BH3-0oE8_VsXgwOky8vAv=gZvP96ym=mc4hjHDKanRmQQ@mail.gmail.com>
Subject: Re: [filter-repo PATCH] filter-repo: help with local install
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 9, 2021 at 10:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Michael J Gruber <git@grubix.eu> writes:
>
> > The Makefile suggests a local install and works almost as is, except for
> > the python path. Make it work automatically for this typical use case,
> > and give a corresponding hint in INSTALL.md.
> >
> > Signed-off-by: Michael J Gruber <git@grubix.eu>
> > ---
> >  INSTALL.md | 5 +++--
> >  Makefile   | 2 +-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/INSTALL.md b/INSTALL.md
> > index 00aabb7..d479681 100644
> > --- a/INSTALL.md
> > +++ b/INSTALL.md
> > @@ -75,8 +75,9 @@ filter-repo only consists of a few files that need to be installed:
> >      You can create this symlink to (or copy of) git-filter-repo named
> >      git_filter-repo.py and place it in your python site packages; `python
> >      -c "import site; print(site.getsitepackages())"` may help you find the
> > -    appropriate location for your system.  Alternatively, you can place
> > -    this file anywhere within $PYTHONPATH.
> > +    appropriate location for your system, `python -c "import site;
> > +    print(site.getusersitepackages())"` for a local install. Alternatively,
> > +    you can place this file anywhere within $PYTHONPATH.
> >
> >    * git-filter-repo.1
> >
> > diff --git a/Makefile b/Makefile
> > index 31f5e3a..c97d1f6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -4,7 +4,7 @@ bindir = $(prefix)/libexec/git-core
> >  localedir = $(prefix)/share/locale
> >  mandir = $(prefix)/share/man
> >  htmldir = $(prefix)/share/doc/git-doc
> > -pythondir = $(prefix)/lib64/python3.6/site-packages
> > +pythondir = $(shell python -c "import site; print(site.getusersitepackages())")
>
> There may be no "python" on $PATH, yet the user may have told the
> make via PYTHON_PATH that /usr/bin/python3 is to be used.

This was a patch for git-filter-repo.git rather than git.git; there is
no PYTHON_PATH variable in the Makefile.

That said, thanks for calling out python3.  As the git-filter-repo
script uses that, all these references to 'python' should be replaced
with 'python3' (including the two in INSTALL.md from before this
patch).
