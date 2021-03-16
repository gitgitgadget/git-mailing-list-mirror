Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD193C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7387465009
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhCPFiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhCPFhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:37:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CECC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:37:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r17so70068943ejy.13
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nDw7GbNwQY9xnT1E0zMgswrEVp7ZB0KPDpDJDiERccI=;
        b=JjIkhD2zdfBJDsWTROVjwNRaUhwceQPf6+60DvitgwBPz5WsmvDQpNZiQ80ClyMMGv
         NO3iv5lCx0XKbwj1QEAth49AbnOZABxl2hA0flHJNWZg8XkIC6OkmzmGp5AfZ+ktS1Qa
         pAOuS2Y48/apkFTkdVECTCj6RdxQ3bEaO51a1zYXaG0zwfuw2KE2o0J7FpwmvI/yrtBa
         j8e9xUEX/l+4z3etPS9E0jxymNzlj/QhTerfTYkDt1umQ0Cl3fYtDdhc8QJSB9bbQr4v
         HdFIqmAXm1bYkslCVpjRoDb51JzFTW1ERCCQGyykwn6AQG3chof3NGHOxeh80VHgnCKL
         u6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nDw7GbNwQY9xnT1E0zMgswrEVp7ZB0KPDpDJDiERccI=;
        b=p2RhYm+2rTT+rS7RAwBRfkHV06wadVhFSCRZtr5bPwZvlVtZ/+1eU2h5qOBgyn1b0+
         k8oj8Ih9SULTTOtG3b7nRI6FXYDbFN4k1Rz/z/4sePh/SzN+7kLEuAoss3Ul0AU9tC6L
         X+7IF3lGQuKzgP5FJ8xTvKjUz8IiiQc/1LeH06k/DApwRinUw5jm36SU7ovk+27X/d1S
         FUbu3mipQCxQ8fvxaxTfbPmZAEoZg0VxGyEmWUU/c+sneg5KXTLSLczo1uWbTcDK7Rn+
         dO8EdnpJmubm56nabdaho0BIOYf14NGplJdHjieq1OLUkpCvIvOdZuejdvfdYm0CDuh+
         EuYw==
X-Gm-Message-State: AOAM533QEX26pISJ3gJFH+GbtH/LGmN2mqYbgfK2Bi7u5Pp31aQpiUbN
        bUzSLwzJaBhaAYqxRAT9pGvxzH7QXBXJbHgUMSQ=
X-Google-Smtp-Source: ABdhPJwH60HeYeWd1SlSSvuqnwN9KRn4IKMM6UxFL6unF5bM77e7wVwBpZYk87Oy2hkTBHKZ6fKMAyKGdSnhA6+zJSA=
X-Received: by 2002:a17:906:5849:: with SMTP id h9mr28048489ejs.551.1615873063637;
 Mon, 15 Mar 2021 22:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v6.git.1615790151073.gitgitgadget@gmail.com>
 <pull.901.v7.git.1615799304883.gitgitgadget@gmail.com> <CAP8UFD2CNAW4o8BF8NLA0pwWzNmBwZJAP7L5SGSib+LcVbSLBA@mail.gmail.com>
 <CAOLTT8QTxnykacdDaMjZMkEqTHPSrPz6HH-bSgbECo5tUgf5Gg@mail.gmail.com>
In-Reply-To: <CAOLTT8QTxnykacdDaMjZMkEqTHPSrPz6HH-bSgbECo5tUgf5Gg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Mar 2021 06:37:32 +0100
Message-ID: <CAP8UFD0+xVTD4t=dgAx0YYxw5G5VinQL1VR+5KW+GypNg1o=Kg@mail.gmail.com>
Subject: Re: [PATCH v7] [GSOC] commit: add --trailer option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 12:32 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:14=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Mon, Mar 15, 2021 at 10:08 AM ZheNing Hu via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> > >       + if (trailer_args.nr) {
> > >      -+         static struct child_process run_trailer =3D CHILD_PRO=
CESS_INIT;
> > >      ++         struct child_process run_trailer =3D CHILD_PROCESS_IN=
IT;
> > >       +
> > >       +         strvec_pushl(&run_trailer.args, "interpret-trailers",
> > >       +                      "--in-place", "--where=3Dend", git_path_=
commit_editmsg(), NULL);
> >
> > Actually I don't think "--where=3Dend" should be used here. "end" is th=
e
> > default for the "trailer.where" config variable, so by default if
> > nothing has been configured, it will work as if "--where=3Dend" was
> > passed above.
> >
> > If a user has configured "trailer.where" or trailer.<token>.where,
> > then this should be respected. And users should be able to override
> > such config variable using for example:
> >
> > git -c trailer.where=3Dstart commit --trailer "Signed-off-by:C O Mitter
> > <committer@example.com>"
>
> Thanks for reminding, generally speaking, we will put the trailer at the
> end of the commit messages.Take trailers in start, this should be
> something I haven't considered.

In general what I want to say is that `git interpret-trailers` should
be considered to have sensible defaults, that can possibly be
overridden using a number of config variables (or the git -c ...
mechanism) which is a good thing. If something in it doesn't work
well, it's possible to improve it of course. Otherwise it's better to
just fully take advantage of it.

> I notice another question:
> if we commit this again with same trailer (even same email or same commit=
er)
> `--trailer` will not work again, because in `interpret_trailers`,
> "if-exists" default
> set to "addIfDifferentNeighbor", I addvice enforce use "if-exists=3D"add"=
.

I don't agree with using "--if-exists=3Dadd". I think the default to not
add a trailer line if it would be just above or below the same line is
better, as doing that wouldn't add much information. It's better to
encourage people to use trailers in a meaningful way.

And again if we use "--if-exists=3Dadd", then people who would want to
take advantage of `git interpret-trailers` to customize what happens
when the trailer already exists would not be able to do it.

For example if we don't use "--if-exists=3Dadd", then:

- people who want to customize what happens when the trailer already
exists can do it with for example:

git -c trailer.ifexists=3DaddIfDifferent commit --trailer
"Signed-off-by:C O Mitter <committer@example.com>"

- which means that people who want the "--if-exists=3Dadd" behavior can
still have it with:

git -c trailer.ifexists=3Dadd commit --trailer "Signed-off-by:C O Mitter
<committer@example.com>"

While if we use "--if-exists=3Dadd", then using `git -c
trailer.ifexists=3D... commit ...` will not customize anything as the
"--if-exists=3Dadd" command line option will override any config
customization.
