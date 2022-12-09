Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D94C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 07:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLIHPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 02:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLIHPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 02:15:35 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BE9303E7
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 23:15:34 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id f139so4250205yba.8
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 23:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OewNzycnZvV/froHJgCfTv1ueEkdqzXmgvw0jKe80N8=;
        b=XR5oYg149KAFgWZNleFRpRf4/bNWzMgSqBhTyn4d7u58VtmQijp2xqxI71hy6N5zdr
         dWadGmftz6n7uM6g6xI7CxLByovPPToMNPcUrllnJseV9W95Em3bVDTA8hcMOliF7fjI
         s5oDhj8jcwjUDxLTxXoMNTrrh/lQGairu/01ZFtSXRJBztuvreENO75VInfZIoefFSH4
         HBXmlyOOvxfWyZzYpN+r1ceD4bIesY1x3kfkTSLgdsFzwoH9V7dmvZq+4Atnyn5QoPUi
         Pk+y+ZOri2Cf5GputhP2/qe9/aLR8QcIkqr+R4uBktNbCzckHOD/FDaOnnu0k3tCji8W
         HiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OewNzycnZvV/froHJgCfTv1ueEkdqzXmgvw0jKe80N8=;
        b=yXQ+sjwMrdO3SpLX7SzYPex98uZD6heik39TkKLRbcNL+8Y+oh4IzBEyanZmnmp8GY
         pvjFUeo3DceO2rJBHdtTHSbL6yyFRDdnO/5/yq6hyMuQc8wsItnuztMNV5YsLjCNBEoj
         DRy8EJkhPxLtMLeaake8URNfw/PfT4EnVajg0xE7xKJuoeusANASfvzoYFPu1TNgP/ne
         9XZVaIvM+/QJ1cusIffA7c3kcuhuwBe3I7MqJWPxJ8uRgvKncKPAMQm3hvdwYImujlrW
         cgaxwdTVz4iUcVndGZk0lr337xxgSZST8doMyPqYmQDfB3Oq5MDvRRAXqGRjdxlVUggU
         Yp8Q==
X-Gm-Message-State: ANoB5pmVwb5ffDuEnD0WguSzzkOztpS3Nub9ONC6KUWbVlYbL560uOMp
        mzAtSRDK0rBm4ZgJtOu8BB7u90lV6AHpN3Z+1TONokP97dgMsA==
X-Google-Smtp-Source: AA0mqf6ElMoMUS2flLCPofcy9zGwrh7kYhbSkpR02d1uS7rjkPmzQZD30yk+QLelCDfixIJpywJUnbej7f+N/b+YuO0=
X-Received: by 2002:a25:254c:0:b0:707:78b7:5ab with SMTP id
 l73-20020a25254c000000b0070778b705abmr6862817ybl.300.1670570131279; Thu, 08
 Dec 2022 23:15:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com> <20221208011631.GH28810@kitsune.suse.cz>
In-Reply-To: <20221208011631.GH28810@kitsune.suse.cz>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 9 Dec 2022 15:15:19 +0800
Message-ID: <CAOLTT8TMWzmxRD+sPiNuCQ12iLB-qt__q_Y1m_hDUZ_ggExyRg@mail.gmail.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> =E4=BA=8E2022=E5=B9=B412=E6=9C=888=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 08, 2022 at 12:57:45AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
> >
> > On Wed, Dec 07 2022, ZheNing Hu wrote:
> >
> > > I would like to run git gc on my git server periodically, which shoul=
d help
> > > reduce storage space and optimize the read performance of the reposit=
ory.
> > > I know github, gitlab all have this process...
> > >
> > > But the concurrency between git gc and other git commands is holding
> > > me back a bit.
> > >
> > > git-gc [1] docs say:
> > >
> > >     On the other hand, when git gc runs concurrently with another pro=
cess,
> > >     there is a risk of it deleting an object that the other process i=
s using but
> > >     hasn=E2=80=99t created a reference to. This may just cause the ot=
her process to
> > >     fail or may corrupt the repository if the other process later add=
s
> > > a reference
> > >     to the deleted object.
> > >
> > > It seems that git gc is a dangerous operation that may cause data cor=
ruption
> > > concurrently with other git commands.
> > >
> > > Then I read the contents of Github's blog [2], git gc ---cruft seems =
to be used
> > > to keep those expiring unreachable objects in a cruft pack, but the b=
log says
> > > github use some special "limbo" repository to keep the cruft pack for=
 git data
> > > recover. Well, a lot of the details here are pretty hard to understan=
d for me :(
> > >
> > > However, on the other hand, my git server is still at v2.35, and --cr=
uft was
> > > introduced in v2.38, so I'm actually more curious about: how did the =
server
> > > execute git gc correctly in the past? Do we need a repository level "=
big lock"
> > > that blocks most/all other git operations? What should the behavior o=
f users'
> > > git clone/push be at this time? Report error that the git server is p=
erforming
> > > git gc? Or just wait for git gc to complete?
> > >
> > > Thanks for any comments and help!
> > >
> > > [1]: https://git-scm.com/docs/git-gc
> > > [2]: https://github.blog/2022-09-13-scaling-gits-garbage-collection/
> >
> > Is this for a very large hosting site that's anywhere near GitHub,
> > GitLab's etc. scale?
> >
> > A "git gc" on a "live" repo is always racy in theory, but the odds that
> > you'll run into data corrupting trouble tends to approach zero as you
> > increase the gc.pruneExpire setting, with the default 2 weeks being mor=
e
> > than enough for even the most paranoid user.
>
> And that two weeks expiration applies to what, exactly?
>
> For commits there is author date and commit date but many other objecs
> won't have these I suppose. And the date when the object is pushed into
> the repository is unrelated to these two, anyway.
>
> > So, I think you probably don't need to worry about it. Other major
> > hosting sites do run "git gc" on live repositories, but as always take
> > backups etc.
>
> Actually, it is a real problem. With <100 users and some scripting I got
> unexplained repository corruptions which went away when gc was disabled.
>
> YMMV
>
> Bad locking design is always a landmine waiting to get triggered. If you
> step carefully you might avoid it for some time.
>

I agree with this. What I hope to be able to do more is "no error at all"
rather than "small probability of error"

> Thanks
>
> Michal
