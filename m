Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA47C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 12:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353072AbiFAMov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353067AbiFAMos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 08:44:48 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A245C85D
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 05:44:46 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id el14so1337856qvb.7
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baller-tv.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hyzFCL4BFtKD5V+/9qxAZUB9Pu20st1Xxa8Czap5sB4=;
        b=PMHVlcNtKjPP+8cuMoueIRTRAxAUZYRo2XsgA2SF5umCL7yPvWmSBS/N3yHRKHbfrE
         ThY/DTA/Zw5TgiJGPdR+T3R6y5QzfKX5jcbTU9BMsOoQ2chLs6q8XLvSQ0qq0lP4tNWL
         ZmzVcZOpCCaSBhibJEBhEW9xckeFa7h03cHSSkdlmRyMWdz/9HvmexsPBbJYlTx+R5fn
         2QM7irO8uaeeH8TczCvmnCQIDzjINNLuMrCFtC2Ajs6ytL5eDj1oA7IzEIsXrhWP/qmc
         OCV81aoiBiyhDTRnULvZT0bAQf6diR6rtGdhyUIIO4u/eC9fS+WLv0EJEeS32zSWsS+I
         YHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyzFCL4BFtKD5V+/9qxAZUB9Pu20st1Xxa8Czap5sB4=;
        b=rTz9NE/yt+c0S1J5HtIdcX4CIv4Lt31N5EsIDIIrIHjSupfaXs8lxHEruyTHQz5q8A
         YFOBrGzXpg5NvlQ1Bvlpy5g7yIEPbr1gF5+BPzKyZYokFWMcJXYe3JEzpQi8RZmSiWpD
         6syOL17Mb0OfrCEyGBNiw+C5eJ823H+gC7pBu8SGpm40dbKcavc7dJguyQ27NaZ84c0a
         gdy2BDtY0WzHZ2J8geoA+PQjm3WUxCnzsf81Erk8masSv/dpDBY4hdca3J6IJLbArkCJ
         2jdw3j/480vtZ1lSjV12aVzNqTEa6IlMWYyOosS2oN6AnAAWmIBR0Bq3b/hLW2KMXvX2
         LiHA==
X-Gm-Message-State: AOAM533573oyxNO/Rb6QbTQDxVU60ngYXVAnKtLak21k7XH1+WMdeH4F
        v1Vqd0HBoaa6VOmo9RSiweR1G2BjeCcyz+lHwUBQp9qo4+JZdw==
X-Google-Smtp-Source: ABdhPJyL8fyWaguqP3Vq2NZfmbhvhKHDNGNyHhr/FUUwIns+TS1uL8eRINXGdzCZ8JUzmBy5HqO1gx6ol4FYvKHaaTo=
X-Received: by 2002:a05:6214:1c05:b0:462:134d:6fac with SMTP id
 u5-20020a0562141c0500b00462134d6facmr48225327qvc.76.1654087485175; Wed, 01
 Jun 2022 05:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
 <xmqq4k1x8gqj.fsf@gitster.g> <01e601d86492$43bb70b0$cb325210$@pdinc.us> <271b6a9a-a5f4-0336-51b8-860ad07f2609@iee.email>
In-Reply-To: <271b6a9a-a5f4-0336-51b8-860ad07f2609@iee.email>
From:   Addison Klinke <addison@baller.tv>
Date:   Wed, 1 Jun 2022 06:44:33 -0600
Message-ID: <CAE9CXuiTDjbncEzWJpHN5N0CukcmXbhxQJtzDDhuy0er4Se2DA@mail.gmail.com>
Subject: Re: [FR] supporting submodules with alternate version control systems
 (new contributor)
To:     philipoakley@iee.email
Cc:     Jason Pyeron <jpyeron@pdinc.us>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Addison Klinke <agk38@case.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> rsbecker: move code into a submodule from your own VCS system
into a git repository and the work with the submodule without the git
code-base knowing about this

> Philip: uses a proper sub-module that within it then has
the single 'large' file git-lfs style that hosts the hash reference for
the data VCS

The downside I see with both of these approaches is that translating
the native data VCS to git (or LFS) negates all the benefits of having
a VCS purpose-built for data. That's why the majority of data
versioning tools exist - because git (or LFS) are not ideal for
handling machine learning datasets

On Tue, May 10, 2022 at 2:54 PM Philip Oakley <philipoakley@iee.email> wrot=
e:
>
> On 10/05/2022 18:20, Jason Pyeron wrote:
> >> -----Original Message-----
> >> From: Junio C Hamano
> >> Sent: Tuesday, May 10, 2022 1:01 PM
> >> To: Addison Klinke <addison@baller.tv>
> >>
> >> Addison Klinke <addison@baller.tv> writes:
> >>
> >>> Is something along these lines feasible?
> >> Offhand, I only think of one thing that could make it fundamentally
> >> infeasible.
> >>
> >> When you bind an external repository (be it stored in Git or
> >> somebody else's system) as a submodule, each commit in the
> >> superproject records which exact commit in the submodule is used
> >> with the rest of the superproject tree.  And that is done by
> >> recording the object name of the commit in the submodule.
> >>
> >> What it means for the foreign system that wants to "plug into" a
> >> superproject in Git as a submodule?  It is required to do two
> >> things:
> >>
> >>   * At the time "git commit" is run at the superproject level, the
> >>     foreign system has to be able to say "the version I have to be
> >>     used in the context of this superproject commit is X", with X
> >>     that somehow can be stored in the superproject's tree object
> >>     (which is sized 20-byte for SHA-1 repositories; in SHA-256
> >>     repositories, it is a bit wider).
> >>
> >>   * At the time "git chekcout" is run at the superproject level, the
> >>     superproject will learn the above X (i.e. the version of the
> >>     submodule that goes with the version of the superproject being
> >>     checked out).  The foreign system has to be able to perform a
> >>     "checkout" given that X.
> >>
> >> If a foreign system cannot do the above two, then it fundamentally
> >> would be incapable of participating in such a "superproject and
> >> submodule" relationship.
>
> The sub-modules already have that problem if the user forgets publish
> their sub-module (see notes in the docs ;-).
> > The submodule "type" could create an object (hashed and stored) that co=
ntains the needed "translation" details. The object would be hashed using S=
HA1 or SHA256 depending on the git config. The format of the object's conte=
nts would be defined by the submodule's "code".
> >
> Another way of looking at the issue is via a variant of Git-LFS with a
> smudge/clean style filter. I.e. the DataVCS would be treated as a 'file'.
>
> The LFS already uses the .gitattributes to define a 'type', while the
> submodules don't yet have that capability. There is just a single
> special type within a tree object of "sub-module"  being a mode 16000
> commit (see https://longair.net/blog/2010/06/02/git-submodules-explained/=
).
>
> One thought is that one uses a proper sub-module that within it then has
> the single 'large' file git-lfs style that hosts the hash reference for
> the data VCS
> (https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md). It would be
> the regular sub-modules .gitattributes file that handles the data
> conversion.
>
> It may be converting an X-Y problem into an X-Y-Z solution, or just
> extending the problem.
>
> --
> Philip
>
>
