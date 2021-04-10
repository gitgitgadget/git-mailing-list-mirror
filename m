Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33302C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00686610D1
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 14:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhDJOKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhDJOKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 10:10:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C95C06138A
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 07:09:55 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id n4so7084104ili.8
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rPUchtTtqGiDuMCpbw3LpNYpy+L/76Wn23xOdMdE2gY=;
        b=rpOG0g1Kl07aDgaeF+kzPxWqPl+kYD66Stg3YUVdpV54YCLLKqX8wRPqg9KVPZIZR/
         dcTfZlW5Q7ppXQKU+jbPCpJ5bfALbLrhJTA0WhdnEJPTGv4otF0zC71e5zGDUtljr7mM
         2coJliGBsZYQ7PgivFs85if99xJHYnWzaMeBrXJPZcrl89wy3Q0tp5z2CzDi178PFV5z
         p9WJYvU1GXEtobkkq0h83o9M+XjVarvPmwUKeJxAtjmpTUJGJiEh2pZpFMNbFbp21C/d
         l5du8RiRwfbrcv1bJb1gYZy15bsO42hcBZnYU1xdD4P97eUPQZ7VkF9cIucZ6tRoOdVX
         3qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rPUchtTtqGiDuMCpbw3LpNYpy+L/76Wn23xOdMdE2gY=;
        b=gLSGrt1fccucfYeV6YwYn76AuEQNJLDXdRMA+lu/oyjJYJI06yE01XtSN3l+05SxVD
         ngwB6OM8kLKomjwxwn+Ve4GgrE3Ye2gtmw0MddXVCHR5B/+yQonzj5GnTKEc+4//pgAM
         JEs5vjwXL3e4dTCxACFuBpW9V7ReXuLcKPZEJFGtUgTxjxhF2o58alMbjVKO5EYRdUDN
         cGtgBaDA4pwhMPKMMGroOOhfx7G6zmLHcQYlJzvSCQSCOHq8s3nVy0QtywXHC0CsLOBj
         6aldUlpkHF6hdhQrcHDDz/MPWPXINbC73srccajF6w0Y1yB1aOSEVTDMhcLjfCl2Mg1y
         f03w==
X-Gm-Message-State: AOAM532B+oM5xOdkLfh/r1+NUrLocUTEPSc5nK5qV0N5ffxYyHXKq4LE
        Qz3h/RLD+8ivJ7G7fWr/BvpUEKF4e1RJ9W1kktA=
X-Google-Smtp-Source: ABdhPJznDDdJe0eozhM5XyzK7Qy40YfMA36EZWG/9Ralcva8XufdKmzZDydeI5l8gYvoaaEtXgrOgAawiq9HxJNWsOY=
X-Received: by 2002:a92:d308:: with SMTP id x8mr15625445ila.301.1618063795127;
 Sat, 10 Apr 2021 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
 <pull.913.v8.git.1617975462.gitgitgadget@gmail.com> <3dc8983a47020fb417bb8c6c3d835e609b13c155.1617975462.git.gitgitgadget@gmail.com>
 <CAP8UFD2A+9eaMGdK9cCfz9Kmz9w-bgiV6x7=X2Y-hmSNAuAV=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD2A+9eaMGdK9cCfz9Kmz9w-bgiV6x7=X2Y-hmSNAuAV=Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 10 Apr 2021 22:09:39 +0800
Message-ID: <CAOLTT8SHu6HmuZYGSz2aboMi8M4Qzf5dZL_k=CUH5Yo-qAu2cw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] [GSOC] trailer: add new .cmd config option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=8810=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:19=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Fri, Apr 9, 2021 at 3:37 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > The `trailer.<token>.command` configuration variable
> > specifies a command (run via the shell, so it does not have
> > to be a single name of or path to the command, but can be a
>
> s/of or/or/
>
> > shell script), and the first occurrence of substring $ARG is
> > replaced with the value given to the `interpret-trailer`
> > command for the token.  This has two downsides:
>
> Maybe: s/for the token/for the token in a '--trailer <token>=3D<value>' a=
rgument/
>
> > * The use of $ARG in the mechanism misleads the users that
> > the value is passed in the shell variable, and tempt them
> > to use $ARG more than once, but that would not work, as
> > the second and subsequent $ARG are not replaced.
> >
> > * Because $ARG is textually replaced without regard to the
> > shell language syntax, even '$ARG' (inside a single-quote
> > pair), which a user would expect to stay intact, would be
> > replaced, and worse, if the value had an unmatched single
> > quote (imagine a name like "O'Connor", substituted into
> > NAME=3D'$ARG' to make it NAME=3D'O'Connor'), it would result in
> > a broken command that is not syntactically correct (or
> > worse).
> >
> > Introduce a new `trailer.<token>.cmd` configuration that
> > takes higher precedence to deprecate and eventually remove
> > `trailer.<token>.command`, which passes the value as an
> > argument to the command.  Instead of "$ARG", users can
> > refer to the value as positional argument, $1, in their
> > scripts.
>
> Good!
>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Helped-by: Christian Couder <christian.couder@gmail.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  Documentation/git-interpret-trailers.txt | 90 ++++++++++++++++++++----
> >  t/t7513-interpret-trailers.sh            | 84 ++++++++++++++++++++++
> >  trailer.c                                | 37 +++++++---
> >  3 files changed, 187 insertions(+), 24 deletions(-)
> >
> > diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/g=
it-interpret-trailers.txt
> > index 3e5aa3a65ae9..1a874a93f49b 100644
> > --- a/Documentation/git-interpret-trailers.txt
> > +++ b/Documentation/git-interpret-trailers.txt
> > @@ -236,21 +236,38 @@ trailer.<token>.command::
> >         be called to automatically add or modify a trailer with the
> >         specified <token>.
> >  +
> > -When this option is specified, the behavior is as if a special
> > -'--trailer <token>=3D<value>' argument was added at the beginning of
> > -the "git interpret-trailers" command, where <value> is taken to be the
> > -standard output of the specified command with any leading and trailing
> > -whitespace trimmed off.
> > +When this option is specified, the first occurrence of substring $ARG =
is
> > +replaced with the value given to the `interpret-trailer` command for t=
he
> > +same token. It passes the value through `$ARG`, otherwise this option =
behaves
> > +in the same way as 'trailer.<token>.cmd'.
>
> Actually I think that we should say first that this behaves in the
> same way as the 'trailer.<token>.cmd'.
>
> And this should also replace the first paragraph in the description of
> 'trailer.<token>.command', not just the second one.
>

Make sence. After all, the primary purpose of this patch is to show that
".command" has been deprecated.

> Maybe:
>
> "This option behaves in the same way as 'trailer.<token>.cmd', except
> that it doesn't pass anything as argument to the specified command.
> Instead the first occurrence of substring $ARG is replaced by the
> value that would be passed as argument."
>
> > +The 'trailer.<token>.command' option has been deprecated due to the fa=
ct
>
> s/deprecated/deprecated in favor of 'trailer.<token>.cmd'/
>
> > +that $ARG in the user's command can only be replaced once and that the
>
> s/can only be/is only/
>
> > +original way of replacing $ARG was not safe.
>
> s/was/is/
>
> > Now the preferred option is 'trailer.<token>.cmd', which uses a positio=
nal argument to pass the value.
>
> I think we can remove this sentence especially if we say "deprecated
> in favor of 'trailer.<token>.cmd'" above.
>

I agree.

> > -The first occurrence of substring `$ARG` will be replaced with the
> > -<value> part of an existing trailer with the same <token>, if any,
> > -before the command is launched.
> > +When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are give=
n
> > +for the same <token>, 'trailer.<token>.cmd' is used and
> > +'trailer.<token>.command' is ignored.
>
> Ok.
>
> > +trailer.<token>.cmd::
>
> I think we should base the description of this option on what I
> suggest in patch 1/2. So let's agree on patch 1/2 before discussing
> this.

Yes, The description of the new .cmd is best approximated by
the .command in 1/2 .

I should @Junio, I don't know if he has any other opinions.

--
ZheNing Hu
