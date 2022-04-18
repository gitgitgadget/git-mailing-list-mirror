Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19677C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 19:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbiDRTox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347724AbiDRTow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 15:44:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E740E24961
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 12:42:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u7so25742593lfs.8
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=luLXixzsFYQ6PHCpG5WEw3t7HZbnyC1XK6kyroBzh1o=;
        b=A3VvVA6Qq4rHcN4VV0LSjlBW/Av07iYNDsY4PNjg0ZGazFzbY4jSCGffUdWxInt2aj
         iQq9Y7v/J0BSzuAjJ6w38LRNpw5UP4bqhqDT/spfh40a8YcRQEmC0BFi9nP4T9OsmMK/
         UdyblweI+Ha05IFV5X//aQ01Hd+gIG08Hd8xbhcTFkGpHHNdLLFxZmhUEtCyWhw6E+Uf
         c5+omEoiS/sbttsFPBzocMLw0AMHMiCPDxQzdAufRHdBrZ3Brd1/VCb0yjreZUwEux9t
         n8KN+xhUAp3aSmPOzeAz8suh15VEWt/ky+7JkZnXMz3PzbJ0Guh62pgeYavsILz0LUW/
         I2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=luLXixzsFYQ6PHCpG5WEw3t7HZbnyC1XK6kyroBzh1o=;
        b=zpHr8nLWEkMUdb+wCjHi9C36sMT1/Kx7wwOi7co5q/yfiCcU5SniA6/opVU8SOPOiS
         nbo3+SK+qR6a6r81GLE7AWyYz5NxIb1qQfxt4k6Cp3M5tdStakmYsjbejy7q+p1QbVxs
         oobKU/6gQlA7Yb5tCP11oCOp4f/9WxBsijrdaPt+YrE+fHDzZvIXzsMeEquOxw30UWfL
         UOFWWQM/CHLfTBm1yxj46DE+fFXD1tngOWmY6NMNuLC1REErx1dng+9BRAykRqLRzSwO
         qm8mggIOuMZZ+IpbHBQ42XNo9EcMUXEzApDYDikPrhsuI27/V9hMDLyVcSx0rJvel5Uq
         8ocw==
X-Gm-Message-State: AOAM531/EUmAph5ff7HM1xCrxuH+nplKZhzb5g8qHBxrV5aGGzV63FtD
        ds3FqzST3qNAOEHvJ2rvWpXm0lCwVv8wOoOI4rk=
X-Google-Smtp-Source: ABdhPJwlR4qeEBHmWBFXTxb7ioC4vyogqhg6JA8qvi8zV79q8Y4qozNzc0iOKjA0/XEZwkiRmBaT3IgYMLf2ct+4hCc=
X-Received: by 2002:a05:6512:51b:b0:46f:bfa8:cdad with SMTP id
 o27-20020a056512051b00b0046fbfa8cdadmr8875879lfb.147.1650310929754; Mon, 18
 Apr 2022 12:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com> <bff6bdc8-83ef-7fa4-3554-edc0b7af1dfe@gmail.com>
In-Reply-To: <bff6bdc8-83ef-7fa4-3554-edc0b7af1dfe@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Tue, 19 Apr 2022 01:11:58 +0530
Message-ID: <CA+CkUQ9iujvFoGOqYHab-V9QKtnCvK+Zs1J7mzJDwQzH2-AOsQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2022 at 11:13 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> +Cc: Christian, Hariom
>

Thanks Kaartic.

> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > View in Google Docs:
> > https://docs.google.com/document/d/1qq-Xze6dMGMSx3rPHD0VEc4f0a87KnHgbka=
1Dzpf8sc/edit?usp=3Dsharing
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Proposal
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Unify ref-filters with other pretty formats.
> >
> > Name          :       Jaydeep Prapanch Das
> > Email         :       jaydeepjd.8914@gmail.com
> > Contact               :       +91 6026139802
> > Github                :       JDeepD(https://github.com/JDeepD)
> > Linkedin      :       https://www.linkedin.com/in/jdeepd
> > Course                :       Computer Science and Engineering, 2025
> > Time Zone     :       IST(+5:30)
> >
> > ## About me:
> >
> > I am a first year undergraduate at National Institute of Technology,
> > Silchar  pursuing B.Tech in Computer Science and Engineering. My
> > interests include FOSS development, Data Science and Robotics. I have
> > been writing Python, C and shell scripts for about 3 years now. Apart
> > from that I also blog[1] whenever I find an interesting topic to blog
> > about. During the GSoC period I also plan to blog about the new things
> > in git that I hope to learn.
> >
> > [1]: https://jdeep.me/
> >
> > ## Micro-Project:
> >
> > I am still a newbie in git development and made my first (minor)
> > contribution in Feb 2022 [1]. This was a patch I made just to get
> > familiar with the patching and sending patches to the mailing list. For
> > my micro project, I worked on adding diff driver for the Kotlin languag=
e.[2]
> > The main objective was to make an xfuncname regex which matches keyword=
s
> > in Kotlin syntax so that they are considered as a single token
> > whenever diffs are generated. Along with that, a word_regex regex patte=
rn
> > was also needed so that variable names, compound operators etc are not
> > broken into individual tokens by git diff when there is a change in the=
m.
> > For ex,  if a =3D=3D b is changed to  a !=3D b , then the diff should s=
how
> > that entire
> > `=3D=3D` token is replaced with the token `!=3D`. While working on this=
 micro
> > project, I learned a lot about the contribution and review workflow of
> > git. It took 7 patches to incorporate all the reviews and suggestions s=
o
> > yeah, It did require some patience :-).
> >
> >
> > Minor patch(merged in master)
> > [1]:
> > https://public-inbox.org/git/20220208092339.651761-2-jaydeepjd.8914@gma=
il.com/
> >
> > Micro Project(merged in master)
> > [2]:
> > https://public-inbox.org/git/20220312044832.718356-1-jaydeepjd.8914@gma=
il.com/
> >
> >
> > ## Proposal:
> >
> > Git has an old problem of duplicated implementations of some logic. For
> > example, Git has at least 4 implementations to format commands for
> > different commands. Previously, Olga Telezhnaya[1] and Hariom Verma[2]
> > worked on this and eliminated most of the duplicate logic. But still,
> > there are still some things left to do. Current task is to reuse
> > ref-filter logic in pretty.

Can you provide more details on what has been done? And what=E2=80=99s stil=
l left?

ZheNing Hu also worked on "Use ref-filter formats in git cat-file"
last year, maybe you can include that too.


> > [1]: https://github.com/telezhnaya/git/commits/format
> > [2]:
> > https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail=
.com/
> >
> > ## Previous Work:
> > Previous GSoC mentee Hariom Verma worked on this[1]. He worked on
> > removing duplicate logic and reuse ref-filter=E2=80=99s logic in pretty=
.
> > However, as per his report, some tasks are still left to do.

Maybe include what=E2=80=99s left.

> > -> Around 30% log related tests are failing

Elaborate those.

I didn=E2=80=99t get the time to read all of it. Maybe Christian can add so=
me
more pointers.

Thanks,
Hariom
