Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFBC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 07:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D56C64EB6
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 07:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCNHKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNHJy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 03:09:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B6C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 23:09:53 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so3599428ota.0
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 23:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I0Q4FTnvY52S1MXIphuP6x6MoyBjq9X4v+V6zOS8+wk=;
        b=o0DJOfbk1xK6t2g/aSwiDc6NDTGZ28n5zLevL3BosGqqf6yCV6cQPv7pGZKNxEJuM6
         iImKM7IVq0DMmacGoHSzZvItGJxukW4qr7phWpekTiI/Of0iJ0lGBf32Kxi4gKu3QOlY
         GmzsurQsJ2RdplRicXBnGeMILI2jmrl7xVcm8wW5m9C3MIjQx0dzMUGoZ+cbfk27wUIx
         Ocbw8syXzmIUM9NqO4VtjCmBgOkE1EbCaes7i9qS4fiT83Vm6IZiwnqsmn7CvIh07ImI
         TsUy//t24JDKZVkzURphEJBSfjOYCaxykyep5QVyO5ULaaqhhiLO4p9QZ2w7GY8WMQ7w
         yKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I0Q4FTnvY52S1MXIphuP6x6MoyBjq9X4v+V6zOS8+wk=;
        b=ZB/qxe5FLDSyM7r81wKGpAmLlC+5oa/gFM6iJ8vgOuPM8sLUIzAXc6R0ccGtXLF19w
         IJMVs9rxjRQSHupsH8V+EjxFqit+kGPqcIq8GT9WC4Kb+ASKT90xky9UNymHi6Ygwy2b
         h+w5G4c8uivktov3Rx/dEmNxap/npR16AxUm7jROq7Url2MtY7FdZ4R03JThivRqjkoE
         LMliGYocQMQNWUz185t3Ei2o+hzkKnJh0PbNMF8eQNBWy4d5U97m4a02633KrejSi+Yx
         vsPpRDfUsjeba3FI0KeOs92rWYZm+PeN5A9IUi4w6mBoRPlPlVRSjPVh+fnp6xmUwzL+
         dD3g==
X-Gm-Message-State: AOAM532WrBBQG+2Hr2G1MDVB+GYaWCMYd9hGGn5x5c2d43t3AOewcacz
        UrKWjtCDaX/UTpRVjh69FM98kHMaQw4+U9e98jM=
X-Google-Smtp-Source: ABdhPJy3cQ7l/mKimpuh8eSG+3pxVqTH+S6v3P75OUEfuDmo5cRR1VOBfghDKKSJpLJqdThlsBDp8lzUvwIlZNwXJec=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr9608563oto.299.1615705792864;
 Sat, 13 Mar 2021 23:09:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
 <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com> <CAP8UFD2_SSza-zsoqS_ugQBryiTvm0PqzrJDAuriT2jmjHM-uA@mail.gmail.com>
In-Reply-To: <CAP8UFD2_SSza-zsoqS_ugQBryiTvm0PqzrJDAuriT2jmjHM-uA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Mar 2021 15:09:41 +0800
Message-ID: <CAOLTT8SVW1Yy9emwpdxX6sw5cwDFV6fkJNugRtASzA9=vOrBbQ@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] commit: add trailer command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8814=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8812:19=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Fri, Mar 12, 2021 at 4:59 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Historically, Git has supported the 'Signed-off-by' commit trailer
> > using the '--signoff' and the '-s' option from the command line.
> > But users may need to provide richer trailer information from the
> > command line such as "Helped-by", "Reported-by", "Mentored-by",
>
> Nit: not sure that "richer" is the proper word here. I would just use
> "other" instead.
>

OK.

> > Now use `--trailer <token>[(=3D|:)<value>]` pass the trailers to
> > `interpret-trailers` and generate trailers in commit messages.
>
> The subject says "add trailer command" while here you say "use". So
> which one is it? Does "--trailer" already exist, and we are just going
> to use it? Or will this patch series actually "add" it?
>
> Looking at the existing options and the code of this patch series, the
> patch series actually adds the "--trailer" (not "trailer") option, so
> "add" or "implement" would be clearer than "use".
>

You're right. "add" will be more accurate in this situation.

> So maybe something like the following might be better:
>
> "Now implement a new `--trailer <token>[(=3D|:)<value>]` option to pass
> other trailers to `interpret-trailers` and insert them into commit
> messages."
>
> Also something like "--trailer" is usually called an option (or
> sometimes a flag), not a command (especially not when the word is not
> a verb, and when the new feature isn't a new exclusive mode of
> operation). So something like "commit: add --trailer option" might be
> a better subject.
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] commit: provides multiple signatures from command line
>
> It looks like this is using the subject of a patch that previously
> attempted to add features with a similar purpose. I don't think you
> need to put it there, or if you want to refer to it, I think it might
> be better to be a bit more explicit, for example like:
>
> "This patch replaces my previous attempt to provide similar features
> in a patch called: [GSOC] commit: provides multiple signatures from
> command line."
>

I may have thought that the effect of the two patch was closer so did not
change it.

> >     Now maintainers or developers can also use commit
> >     --trailer=3D"Signed-off-by:commiter<email>" from the command line t=
o
> >     provide trailers to commit messages. This solution may be more
> >     generalized than v1.
>
> Ok, I agree that it's a good idea to have a good generic solution
> first, before having specialized options for specific trailers.
>

Thanks. :)

> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-901%2=
Fadlternative%2Fcommit-with-multiple-signatures-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-901/adlt=
ernative/commit-with-multiple-signatures-v2
> > Pull-Request: https://github.com/gitgitgadget/git/pull/901
> >
> > Range-diff vs v1:
>
> If this patch series has very few code and commit messages in common
> with a previous attempt at implementing similar features, it might be
> better to make it a new patch series rather than a v2. This could
> avoid sending range-diffs that are mostly useless.

Thank you for these pertinent suggestions. I will pay more attention.
