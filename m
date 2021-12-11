Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DB2C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhLKHvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHvN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:51:13 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE8C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:51:13 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id r15so20693475uao.3
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TmViMDdY8mKcDD+kT8SUkD8V/9QPKcfv8FUdg3eeE18=;
        b=neoDTKG+qGyTSqxXvDXfcKY43nUodek2pGo/o7pYdzdSytPwh0li2W+DAg/9E+6hwh
         kC6QsScWVR9IczdHQkAOrn6ghVsm9ThIkgPRFFirxTG/WyYnrlVZg0fh6d+gr5lgh8Th
         OQuo20CGhEBZdeZdxCbZYX8oIKz6QO21PlgRR4r1rqxuNS8v7TqiMmKe9Brc9GKWpDDL
         yJo6zNGCXm1wyDZNH5HFrIMiSkKo6VgGuPq8bgHEt3enVvNKINXnPVRR5pkfmCN85uZO
         T2MZr/rj0EQ11gs2ODQ0TYFi+6tG7sWh4E/bwGHT0nHYra5WIj6eVY7dAaQLoYeTxEsc
         +VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TmViMDdY8mKcDD+kT8SUkD8V/9QPKcfv8FUdg3eeE18=;
        b=3Pio8KFeVN41Wq5eWRI5cAS1wvErXiqomuKB/+6Bkpw8wNKRrZ0KMjoqMaPsqrLwHG
         EOAKS5JQt9uKosmUCrQsJSdTu0if9mmWtzMOIP2jhMamnykRpFoRIuUtTc8cd/FPxpMM
         YB4l54wXcEWyvvFIYVGfTp4CsP5Rr1xWOE218gGyweYWubc5erY/r7WYEZunw1VNH3iX
         WeKaQQyW4QeIMaJg6CDLYs6Z6yieD4gVP37QsPlSH5hjGQBIMFkKyrm3HCagvNrPc7H5
         s/K068NhEBMhHbg1O4QNNXxl/CLUuRlAKg9cvAMHN+JDnsq3PWNEjitO8yqoepH8Xsb8
         kLzg==
X-Gm-Message-State: AOAM533ZKrNVAVx17I4aK8BGFHLwThNCXjCkPlm9nfXDmwrnvP2qYxKy
        0Dj5vumw+XouokUBfhZhJi90gAHPiwKtwuQ0fbQ=
X-Google-Smtp-Source: ABdhPJzwgvbcbbBv0FA5uH/fX85qPig/QQMLXELAkcIzkEU9AmN0cjFq4yp1h3xxhmzalNMZed4RHtEQm9cwFBKbk08=
X-Received: by 2002:a67:3382:: with SMTP id z124mr20050920vsz.57.1639209072058;
 Fri, 10 Dec 2021 23:51:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
 <xmqq5yrwm7km.fsf@gitster.g>
In-Reply-To: <xmqq5yrwm7km.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 11 Dec 2021 15:51:01 +0800
Message-ID: <CAOLTT8Rx9M9=a5M8UeDrJqMayTXo=dvdanVDLi7QLdPX8W_Tzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=85=AD 06:14=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we want checkout to a branch (e.g. dev1) which reference
> > to a commit, but sometimes we only remember the tag (e.g. v1.1)
> > on it, we will use `git checkout v1.1` to find the commit first,
> > git will be in the state of deatching HEAD, so we have to search the
> > branches on the commit and checkout the branch we perfer. This will
> > be a bit cumbersome.
> >
> > Introduce "--to-branch" option, `git checkout --to-branch <tag>`
> > and `git checkout --to-branch <commit>` will search all branches
> > and find a unique branch reference to the commit (or the commit which
> > the tag reference to) and checkout to it. If the commit have more
> > than one branches, it will report error "here are more than one
> > branch on commit".
>
> Sorry, but the above explanation does not make any sense to me.
>
> It is unclear if you mean "dev1" exactly point at the commit tagged
> as v1.1, or you want the branch "dev1" that is a descedanant of
> v1.1.  Without telling that to the reader, the above explanation is
> useless.
>

I meant the former.

> And whether you meant the former or the latter, neither use case does
> not make much sense.
>
> First, suppose you meant "checkout --to-branch v1.1" to find a
> branch whose tip exactly points at v1.1.  You instead check out
> "dev1" branch, and work on it to advance its history.  When you are
> done, you may go to another branch and work on something else.
>
> But then what?  When you need another topic that also needs to be
> later merge-able to v1.1, "checkout --to-branch v1.1" no longer will
> be able to find "dev1", because, well, you have already used it to
> build something else.
>
> So, "--to-branch v1.1" that finds and checks out a branch whose tip
> exactly points at v1.1 would be pretty useless.
>

Well, I didn't consider what you said before. I just want to find a shortcu=
t
for "oid -> branches" and "tag -> branches". And I can quickly use it to
switch branches.

> So let's correct the unwritten assumption and say "--to-branch v1.1"
> finds a branch that is descendant of the tag.  It is like I have
> maint-2.33 branch to prepare for v2.33.1, v2.33.2,... maintenance
> releases and being able to find maint-2.33 by saying v2.33.2 (or
> v2.33.1) _might_ be convenient.
>
> But that would only be true if there is only one single branch per
> family of tags (in the above example, v2.33.* tags).  You cannot use
> the workflow where many topic branches run in parallel, and get
> merged to the integration branch(es) only after they are ready,
> because you need bugfix-1-for-v2.33, bugfix-2-for-v2.33,... branches
> all forked from v2.33.0 (or a commit with a later tag in the v2.33.*
> family) to cook these independent fixes that are destined for the
> maint-2.33 integration branch, so you cannot uniquely find maint-2.33
> by saying v2.33.0 or v2.33.1 or whatever.
>

Well, in the case of many branches pointing to one commit, this "--to-branc=
h"
is not very useful.

> I also sense that the first paragraph of the proposed log message
> for this commit hints that the user needs a bit more studying of
> existing tools.  When we know v1.1 but do not know if we already
> have branches that are based on it, we DO NOT do "git checkout v1.1".
> Instead the first thing we would do is "git branch --contains v1.1"
> (add "--no-merged main" to exclude the branches that have already
> graduated to 'main').
>

"git branch --contains v1.1" can find all branches whose history contains t=
he
 commit tagged as v1.1. So what if "git checkout --contains v1.1"?

If there is only one branch, checkout to it; if there are multiple branches=
,
it will degenerate into "git branch --contains v1.1" to show these branches=
 to
the user. Of course this feature is not very consistent with my
original intention...

> So, for this partcular topic, what I would recommend is *not* jump
> in and add a new feature, but to study what's available and build a
> workflow around the existing features.
>
>

Thanks.
--
ZheNing Hu
