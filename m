Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D6C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjDDPul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjDDPuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 11:50:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC07CE
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 08:50:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so132510666edd.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680623435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlVGHrgjvxJK31zL6DgK3uKCa4TuYuSsfzSmlsJglGI=;
        b=efFUgyif47gCK8utoTBfEpyz24PBfOaWQIXVHjinrM21uoSedB5cqA8Zc4M0R3GrOQ
         GMH11gIzeOrKOhc6F+qAdsIDY6FKdnroOqszJFqmo+XFOOc0SBSiuICYzcLLCDEQZHgf
         gYE1sioFos7yxvArWFYR0mh1SKff8IJhoiigl8dCGlOz4PIrEuK7J3yfGH/xctXidmeN
         bmfHN82W5a2QZw2aGfy1Y6FRk0EJ8uCPU/x5gErMk+ZAz3VuJe+nWVuWIiIFDOnLA4v4
         jORjF+CO2//xRklWb7nGu2aZ4WMxL0pZz0ExBu6sjlb29nWCVAzYrE2r1VXzbUMcUWEt
         YrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680623435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlVGHrgjvxJK31zL6DgK3uKCa4TuYuSsfzSmlsJglGI=;
        b=58LpW9yU7f+ccd2gsbngQzzRQ9V1U1DamFnThTaTPBqmTgCmWkUhVk/6NRmxVvg29w
         G5iYBayvvTJtB2LDY3HSm0WQdHXKzz6jylur7o6C/IRT5XSNXJbdQU3eRqNcNF/B5w4r
         bt63Ty7oVCSGkEoREkdanmvLw6Pk+dQpvThq+lBxFwBEIfhja/oQlR7IGJ/n9TDeItmM
         +5t7LP5CPzqAef0itiyXH3+dQfdDr3HoxQiLTmqVL4xrG90j1FN3y6PZDq9ycqlHRxkX
         QoM3amzgTBiY6SeG11M+XPxo6fjifK4hXOVWfiOMifqegs5gpyKa5lhzVQfhr6qC2152
         +B+g==
X-Gm-Message-State: AAQBX9ejSze+qjx8zXkFKWkcph1Nnc6yEcS1QCZ4U10bBhhCldHyKmgz
        oGfkIGOmNmHIJKD+ifA+2ZqeH4qKyPKs44ws/Z/lIPjuksakEvjWbVk=
X-Google-Smtp-Source: AKy350beImYVSRLOtfGfxkFU4plalblSVXCpjlYPO/ii3wpKkkGsKrJQuviaQuocPPipNgTWqBtIRM90BAVeeuxNzSw=
X-Received: by 2002:a17:906:3e0d:b0:92f:cbfe:1635 with SMTP id
 k13-20020a1709063e0d00b0092fcbfe1635mr11715eji.6.1680623435071; Tue, 04 Apr
 2023 08:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net> <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
 <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
In-Reply-To: <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 4 Apr 2023 23:50:23 +0800
Message-ID: <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     Phillip Susi <phill@thesusis.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 8:37=E2=80=AFAM Hongyi Zhao <hongyi.zhao@gmail.com> =
wrote:
>
> On Tue, Apr 4, 2023 at 8:20=E2=80=AFAM Hongyi Zhao <hongyi.zhao@gmail.com=
> wrote:
> >
> > On Tue, Apr 4, 2023 at 2:36=E2=80=AFAM Phillip Susi <phill@thesusis.net=
> wrote:
> > >
> > >
> > > Hongyi Zhao <hongyi.zhao@gmail.com> writes:
> > >
> > > > Hi here,
> > > >
> > > > I want to revert a previous commit partially, as follows:
> > > >
> > > > werner@X10DAi:~$ git log |grep -A3 -B5 -m1 texstudio
> > > > commit f18fbd1e16a1ca4215621768d17858c036086608
> > > > Author: Hongyi Zhao <hongyi.zhao@gmail.com>
> > > > Date:   Sun Aug 1 20:01:02 2021 +0800
> > > >
> > > >     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
> > > >     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> > > >     modified:   Public/repo/github.com/Dushistov/sdcv.git.sh
> > > >     deleted:    Public/repo/github.com/goldendict/stardict-relative=
/bigdict
> > > >
> > > > More specifically, I just want to revert the following ones:
> > > >
> > > >     deleted:    Public/CTAN/IDE/phonon/compile-install-phonon
> > > >     deleted:    Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> > > >
> > > > Is this possible?
> > >
> > > If you are comfortable with git-gui and gitk, then I would say just
> > > revert it, then click ammend the previous commit in git-gui, and clic=
k
> > > to unstage the changes you DON'T want to revert, then commit.  If you
> > > want to do it from the command line, then git-revert, then git checko=
ut
> > > HEAD~1 -- ( the other 4 file names here ) will get back the other 4
> > > files then you can git commit --amend.  Alternatively you can skip
> > > git-revert and instead git checkout f18fbd1e16~1 -- (the two files th=
at
> > > you DO want to revert), then git commit.
> >
> > Thanks for your tips. I've also figured out the similar solution based
> > on the comment here [1], as shown below:
> >
> > $ git show f18fbd1e16a1ca4215621768d17858c036086608 --
> > Public/CTAN/IDE/phonon/compile-install-phonon
> > Public/CTAN/IDE/texstudio-org/texstudio.git.sh | git apply --reverse
> > --3way
> >
> > Because the commit I want to revert is done a long time ago, which is
> > not the parent of the commit I'm currently on, so I can't use the `~1`
> > which indicates that I want to go back one commit from my current
> > position.
>
> Sorry for my inappropriate description above. In fact, it's a more
> concise method which also will do the trick, aka, as follows:
>
> $ git checkout f18fbd1e16~1 --
> Public/CTAN/IDE/phonon/compile-install-phonon
> Public/CTAN/IDE/texstudio-org/texstudio.git.sh

But I still wonder why the following method doesn't work:

werner@X10DAi:~$ git revert f18fbd1e16a1ca4215621768d17858c036086608
--no-commit -- Public/CTAN/IDE/phonon/compile-install-phonon
Public/CTAN/IDE/texstudio-org/texstudio.git.sh
fatal: bad revision 'Public/CTAN/IDE/phonon/compile-install-phonon'


> > [1] https://stackoverflow.com/questions/5669358/can-i-do-a-partial-reve=
rt-in-git
> >
> > Best,
> > Zhao
