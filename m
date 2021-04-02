Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F3C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 02:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832A8610D2
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 02:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhDBCIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhDBCIk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 22:08:40 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02150C0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 19:08:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e8so4107018iok.5
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oKOkYUgTYxGhFkeNdDJODK72loRJSHevCxo0MBkYYY4=;
        b=FBYzqMHWs9HA2HE+OMZy1ngZuSpHEFV+JePqTkUt5YVN2l2oTJEofr5m9Yxhvw8IEA
         ueUVqU937nekHbShirP6xclqi5CrVTAmiQ/4MWV9FfEDcAc7aPIRAVmhL3c77agbBDNy
         /60MZqQ31TWFAxYSjhOgM0gaw4+/5i+/NszwvZG7FNBoJ1p83UfhTz0ZoZdYzb1M5th3
         g0jSYjaPfUUU7EKY+HZWunO7iY/x9LkPmHTPpp1ISPR2b14TbnJC6GAyDeaBbag81xAO
         Y/IPHHY9ULjKbTzFGzZzxO7Ephs+bWthe2XDl7kD8VgJ2TxapqsqLgiN9IZyoQn+x+EC
         h2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oKOkYUgTYxGhFkeNdDJODK72loRJSHevCxo0MBkYYY4=;
        b=UcTH7uvriYB7Q+bWhA8Pzq1sCqFKd/TtEdjL8MfOvM0geZXljmLI7zr2LWw4lIraEH
         Kpc4IzSv7Wl9wD3R3F3pzKHh0I9PH2TJ2KEfaCt516v5ksCsNf5xNLrvDNmlbEP0NM73
         AKYZ8WzA+be9N1/ZbHTUEytlcAB6Izw6VP5LhkJH1MTEfnbEbquWAwPFYkq1DMrd8DMn
         EbvRwkUC8uB+ncsbgAgspfEeL62dDkNO61mFYOlE8b9G5Z5yyLjSaidAWpsiJo2r+2Kt
         oR5qpNYHJyxhZa/I+nbYXN+sk/GSsjZDmHXvngt46stmbZYeOUvbmDT5imiRMghrTutx
         LNKQ==
X-Gm-Message-State: AOAM5338ZZ9wTKP9NQLvTgOd/h52XHMIJ+I50e+lO6aNpLKTLkdeR5MW
        YfZJFLA06+yHGs9k8k76aniDa3R+Ue6sgwcIDTs=
X-Google-Smtp-Source: ABdhPJy7jtGVq1jFsBDxicJAwrBUKC3ptCnnyYu+w2fLSW4w2fiNdE4dDz8UTZcR+UE7exV6mwQ2Zws5aHHhiDFHH3U=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr9302848iom.68.1617329318729;
 Thu, 01 Apr 2021 19:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
 <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
 <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
 <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com>
 <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com>
 <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
 <CAOLTT8SPRArgwwd_isw48gWQysgqJ9JJpn9JNGH+=9aY+0=SPA@mail.gmail.com>
 <xmqqwntoef81.fsf@gitster.g> <CAOLTT8SLX7wVfND9ru8NPx_YhvP2Ed17UcuRdY6Uioj9XSFmwQ@mail.gmail.com>
 <xmqqeefv89tc.fsf@gitster.g> <xmqq7dln89dd.fsf@gitster.g> <CAOLTT8SV_ixYWTV-83vY6B6HUTwW1hTWJqamstf=F6tzkJm3aQ@mail.gmail.com>
 <xmqqlfa13hw3.fsf@gitster.g>
In-Reply-To: <xmqqlfa13hw3.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 2 Apr 2021 10:08:26 +0800
Message-ID: <CAOLTT8TDiAxJh3xn1WdF5mTtbA29nTSP0ohyi6aqGds8p6vd1A@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:49=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> The way to do the same without an extra script on disk is for you to
> >> use sh-c yourself.
> >>
> >>     .cmd =3D sh -c 'echo 123'
> >
> > This is indeed a viable solution, But the extra "sh -c" seems to put an
> > unnecessary burden on the user.
>
> Nobody forces you to write long script in the configuration file.
> In fact, the "find author from history" is so useful that I'd think
> people have an alias or a script in ~/bin/ already for their own
> interactive use.  E.g.
>
>     $ cat ~/bin/git-who
>     #!/bin/sh
>     git log -1 --format=3D"%an <%ae>" --author=3D"$1"
>     $ cat ~/bin/git-one
>     #!/bin/sh
>     git show -s --pretty=3Dreference "$1"
>
> and with them:
>
>         trailer.key.cmd =3D git who
>
> that is internally wrapped into
>
>         sh -c 'git who "$@"'
>
> and fed "gitster@" as the first parameter when "--trailer=3Dkey:gitster@"
> is given would work just fine.
>

Okay, now I get it. This allows us to run some common scripts or just use
"sh -c". I might need some additional tests to illustrate those changes mad=
e
by using '.cmd'.

> > Sometimes I wonder, why not recommend using environment variables
> > like $ARG?
>
> I am also fine with that; when we discovered the design flaw of
> .command, I think I suggested either would make a viable choice.
> The only downside is that it would squat on a good name $ARG and
> forbids end-users from using the symbol for other purpose, but as
> long as the application is limited in scope, that would be fine.

I agree with you. This may indeed be a minor drawback.

Thanks, Junio.

--
ZheNing Hu
