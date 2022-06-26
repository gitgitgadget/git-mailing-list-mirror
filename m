Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4590C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiFZNFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiFZNFd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:05:33 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1C11C37
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:05:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l24so7095730ion.13
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L8ZBk8vksWcePYCUSHDgQl6UuuJsis7CCkGjYHVTRRs=;
        b=b/UsCWKzv2w3Yist4TbbrwltbBhomCNY+xqQJ4akTYu0A+zdtgywwGc6Gn8agDqJEL
         ckI9tPxChoX1Q02VXGczWxUKdLp4PCam4nKEjKcCnpbAVw4aTL0diY38rYhUnDZ/d6dv
         XwODCNHJ95T9n3vBlJeMrYRg+JrR4dN3UOJfDWhkVuFnip9eRSjmkB9wkQ+/D0QhK7xU
         XHoJLErMhf02EVygKMwLB6P/BGYklmv86nEKplu/F9u8JXqdo4UPka23LMgHeIN+IsBU
         3r5OIuXK7sUQGoN5K2rLVRLFPKQGv2yTItoh1Ym+xl2L5JwqZYPLmCakq5DfcuucQwGB
         HnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L8ZBk8vksWcePYCUSHDgQl6UuuJsis7CCkGjYHVTRRs=;
        b=uJLS7qiioSOAbraUtEbzACCH1Qciu7gH6DdPIJakhbf0b9JLGf5s21mVfsI83Lhi1G
         MAEnPFNU/V+iHlCLx3OfmFrp1d5Wztwb2rwDYjtmCka3aq5WCSiDmzT/MJ2diZn9T9qp
         yfMKMPIqttC/VrFvig/FxFK+FF+j0uOSKY4lZNCCUAuYbhRDWLRHLmS/B03+E212nwTB
         4bDeIQTGSrm52DGI3pFt2aCT4uikR2cEasFbXYV24J0tMmcMuf3ytzYBHNYfcr4wKfG0
         UubD4zvE/966aJAaSRhMmHaiERvyeiNe6MSrVVWuDA6m+bmPQOm8ruXqAeB0HzqiRiw1
         op9A==
X-Gm-Message-State: AJIora883V8qhva3eZZH6GglI9lzFyV45oxTuBL5vc2MhFKxbQznSzyp
        DNoshJLioIB2UzqRTVqWlf98TNHcxp+ra6n1QeqtOAC29yM=
X-Google-Smtp-Source: AGRyM1s56kjsTeNjY22dacpxpAonK0adZCpyVM6OxH/uYEMTUHXggpZR03E+CExHTPIPx72qcFH2LbYWhqkmrqbRddw=
X-Received: by 2002:a02:8609:0:b0:330:e92c:2cc4 with SMTP id
 e9-20020a028609000000b00330e92c2cc4mr4834317jai.95.1656248732211; Sun, 26 Jun
 2022 06:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com> <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
 <xmqqv8sr1iex.fsf@gitster.g> <db23bf2a-e661-906f-f8ed-fc2ab3d3ce41@gmail.com>
In-Reply-To: <db23bf2a-e661-906f-f8ed-fc2ab3d3ce41@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 26 Jun 2022 21:05:21 +0800
Message-ID: <CAOLTT8Swhow5yvcTbPfmqNCedhJTxwxK0=-C7mqey8DxCA3EwA@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=BA=94 18:16=E5=86=99=E9=81=93=EF=BC=9A

> >>> +ctime::
> >>> +   The create time of file which is in the index.
> >>
> >> This is printed with a prefix 'ctime:' (the same applies to the format
> >> specifiers below) I think we should omit that and just print the data
> >> so the user can choose the format they want.
> >>
> >>> +mtime::
> >>> +   The modified time of file which is in the index.
> >
> > These are only the low-bits of the full timestamp, not ctime/mtime
> > themselves.
> >
> > But stepping back a bit, why do we need to include them in the
> > output?  What workflow and use case are we trying to help?  Dump
> > output from "stat <path>" equivalent from ls-files and compare with
> > "stat ." output to see which ones are stale?  Or is there any value
> > to see the value of, say, ctime as an individual data item?
> >
> >>> +dev::
> >>> +   The ID of device containing file which is in the index.
> >>> +ino::
> >>> +   The inode number of file which is in the index.
> >>> +uid::
> >>> +   The user id of file owner which is in the index.
> >>> +gid::
> >>> +   The group id of file owner which is in the index.
> >
> > Again, why do we need to include these in the output?
> >
> > Wouldn't it be sufficient, as well as a lot more useful, to show a
> > single bit "the cached stat info matches what is in the working tree
> > (yes/no)"?
>
> That does sound useful
>
> >>> +flags::
> >>> +   The flags of the file in the index which include
> >>> +   in-memory only flags and some extended on-disk flags.
> >>
> >> If %(flags) is going to be useful then I think we need to think about
> >> how they are printed and document that. At the moment they are printed
> >> as a hexadecimal number which is fine for debugging but probably not
> >> going to be useful for something like --format. I think printing
> >> documented symbolic names with some kind of separator (a comma maybe)
> >> between them is probably more useful
> >
> > I am guessing that most of the above are only useful for curious
> > geeks and those who are debugging their new tweak to the code that
> > touches the index, i.e. a debugging feature.  But these folks can
> > run "git" under a debugger, and they probably have to do so when
> > they are seeing an unexpected value in the flags member of a cache
> > entry anyway.  So I am not sure whom this field is intended to help.
>
> I wondered about that as well, but thought there might be a plausible
> use if someone wants to check if an entry is marked intent-to-add, or
> has the skip-worktree/spare-index bits set (are there other ways to
> inspect those?)
>

I think this feature will be useful too, but it may not belong to this patc=
h.
We can discuss how to implement it later.

> Best Wishes
>
> Phillip

ZheNing Hu
