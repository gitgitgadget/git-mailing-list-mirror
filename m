Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC64EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 11:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiDULUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiDULUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 07:20:52 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C009613F6E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 04:18:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k12so2834975ilv.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vP6KOkrRjS7uI6IhsoVOPw1WhMK9uLG22Xxkxf2eswY=;
        b=W1xoKB0QTFjJuTSuPuPBCd5KYpvuKbp75464mcFRYP/tiBX/E8JjnoYRsLn06qUK9k
         BWKPBLPwlaFIOatM+g1aKTmJ86VHRqNP3Hd4mAkbQWlykMErZbzeTkaOzJ6gQo01WT8g
         ZE9y3QqzH6CunaQ4Vv9yDoOLtqS53YOf3u8H5kuLCmtZ7lDwLqmDUnmiomylAiKag5yZ
         r+9geoQWyGX/eaxE91LmiVSih0bcg4Jmdf0RUJhBRYdKtwFkIZQWzadEqzpKc3Raaf6R
         0dtVBb7xBAyhQ9ocozD6uDdZWQG2sWGNiqmuEVWm5Y++l7YLX8mWZUwWFPt6JKKuU3WR
         Y0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vP6KOkrRjS7uI6IhsoVOPw1WhMK9uLG22Xxkxf2eswY=;
        b=Q3GjWs+T4lLo/2/RRXzwDZ4SSerJtVb/Ykhk5KiIEC10WIzibmYEth8q05hxlBawcd
         p0nHXFf93teYzBWHKdNdAhrocyqKp9bJU7Gqqyz9DPfgZZpaNSs461/fiv7F6F6g8wto
         R3i8BErc9hni0jDvXUsNb3mhoMKMs2QGCnMsGfiUclyqeeXeck9W9Flw3dMdcZZTtpWf
         nGPI9EQEwS1Ew0mU8H01Txik6XySSsYPfqaLFEMqsiiShm3v4HconxZAJBy3itluQeWM
         6+4zBrFkkAsLKAUXsX+DG69kkQ9qD5tWSsnFDQhOQSoFkyjCJ7rC3t0rXpGI7x4VwXj1
         hUXA==
X-Gm-Message-State: AOAM530gmrezKYwag6bWuPVrdSLZAc9ynSuzI/afCTHDWXac2vgI+hP8
        xD+aF3811TAkkoi22OSDkkOqzEiNxufhkbiSTAg=
X-Google-Smtp-Source: ABdhPJwpbe4vcdbvjU/Pt9weCKOPDfv0YphVNjIVIMJtDCDs769zVxEkj9yB+iNHoVKLa3G4F4YSgeene5dSJTk4Zic=
X-Received: by 2002:a05:6e02:194d:b0:2cc:526:652f with SMTP id
 x13-20020a056e02194d00b002cc0526652fmr10273781ilu.43.1650539881952; Thu, 21
 Apr 2022 04:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
 <bff6bdc8-83ef-7fa4-3554-edc0b7af1dfe@gmail.com> <CA+CkUQ9iujvFoGOqYHab-V9QKtnCvK+Zs1J7mzJDwQzH2-AOsQ@mail.gmail.com>
In-Reply-To: <CA+CkUQ9iujvFoGOqYHab-V9QKtnCvK+Zs1J7mzJDwQzH2-AOsQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 21 Apr 2022 19:17:51 +0800
Message-ID: <CAOLTT8SydsL7oOnEGD_dBw1QKefZ3E6-pdoKxXmP12RL178dwQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 02:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 18, 2022 at 11:13 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> >
> > +Cc: Christian, Hariom
> >
>
> Thanks Kaartic.
>
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > View in Google Docs:
> > > https://docs.google.com/document/d/1qq-Xze6dMGMSx3rPHD0VEc4f0a87KnHgb=
ka1Dzpf8sc/edit?usp=3Dsharing
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Proposal
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Unify ref-filters with other pretty formats.
> > >
> > > Name          :       Jaydeep Prapanch Das
> > > Email         :       jaydeepjd.8914@gmail.com
> > > Contact               :       +91 6026139802
> > > Github                :       JDeepD(https://github.com/JDeepD)
> > > Linkedin      :       https://www.linkedin.com/in/jdeepd
> > > Course                :       Computer Science and Engineering, 2025
> > > Time Zone     :       IST(+5:30)
> > >
> > > ## About me:
> > >
> > > I am a first year undergraduate at National Institute of Technology,
> > > Silchar  pursuing B.Tech in Computer Science and Engineering. My
> > > interests include FOSS development, Data Science and Robotics. I have
> > > been writing Python, C and shell scripts for about 3 years now. Apart
> > > from that I also blog[1] whenever I find an interesting topic to blog
> > > about. During the GSoC period I also plan to blog about the new thing=
s
> > > in git that I hope to learn.
> > >
> > > [1]: https://jdeep.me/
> > >
> > > ## Micro-Project:
> > >
> > > I am still a newbie in git development and made my first (minor)
> > > contribution in Feb 2022 [1]. This was a patch I made just to get
> > > familiar with the patching and sending patches to the mailing list. F=
or
> > > my micro project, I worked on adding diff driver for the Kotlin langu=
age.[2]
> > > The main objective was to make an xfuncname regex which matches keywo=
rds
> > > in Kotlin syntax so that they are considered as a single token
> > > whenever diffs are generated. Along with that, a word_regex regex pat=
tern
> > > was also needed so that variable names, compound operators etc are no=
t
> > > broken into individual tokens by git diff when there is a change in t=
hem.
> > > For ex,  if a =3D=3D b is changed to  a !=3D b , then the diff should=
 show
> > > that entire
> > > `=3D=3D` token is replaced with the token `!=3D`. While working on th=
is micro
> > > project, I learned a lot about the contribution and review workflow o=
f
> > > git. It took 7 patches to incorporate all the reviews and suggestions=
 so
> > > yeah, It did require some patience :-).
> > >
> > >
> > > Minor patch(merged in master)
> > > [1]:
> > > https://public-inbox.org/git/20220208092339.651761-2-jaydeepjd.8914@g=
mail.com/
> > >
> > > Micro Project(merged in master)
> > > [2]:
> > > https://public-inbox.org/git/20220312044832.718356-1-jaydeepjd.8914@g=
mail.com/
> > >
> > >
> > > ## Proposal:
> > >
> > > Git has an old problem of duplicated implementations of some logic. F=
or
> > > example, Git has at least 4 implementations to format commands for
> > > different commands. Previously, Olga Telezhnaya[1] and Hariom Verma[2=
]
> > > worked on this and eliminated most of the duplicate logic. But still,
> > > there are still some things left to do. Current task is to reuse
> > > ref-filter logic in pretty.
>
> Can you provide more details on what has been done? And what=E2=80=99s st=
ill left?
>
> ZheNing Hu also worked on "Use ref-filter formats in git cat-file"
> last year, maybe you can include that too.
>
>

Hi, maybe I can give some helps. I am thinking about this project occasiona=
lly
a few months. Due to the performance of the ref-filter, me, Olga, Hariom, o=
ur
patches doesn't merge to master branch.

So we'd better think of ways to improve the performance of the ref-filter.
I think there needs to be a huge refactoring here.

> Thanks,
> Hariom

Thanks.
--
ZheNing Hu
