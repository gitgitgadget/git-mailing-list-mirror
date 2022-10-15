Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE1C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 14:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJOOto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJOOtn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 10:49:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C81DA65
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 07:49:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-35711e5a5ceso70726237b3.13
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjNud/jKZHH/648iDkTw1TzI14ycdicPTnBeYwuDPlo=;
        b=K6kDdK2SbBzEk6luyqZ2f3euYXKffVERKH3De94cTpwjDsNefp8YpQpu0+vho0c4G8
         bu3VLaAdOGK+PuFIETxS1U29NMRQ3dTI9EQWyGYwnNNzEWNTEx3URUssmz3IXVasiIlQ
         Y6VeRiebIU/wkylI1te8EoylUYZx4nfVMeiv9Au4bBK0x2cpJBF17e0BPKq4fQmqajIb
         n3H7sqve1443LDRxQFUrvY+l0d63DI6Wwut5jz3aiu1AL6oULiM2K+T5UoDwiX8W3Gi7
         aztA+ee3U6VIEzyipcux9Go/8kfnroY/wi/fcHr8GOxTw+8j/DAFHlpqsj99bSBnCmdm
         3Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjNud/jKZHH/648iDkTw1TzI14ycdicPTnBeYwuDPlo=;
        b=IBuxaHoYD3l+BCaA+BNMbmvDXKLHwD24A4X0C7get3V8pBZeRvAvyGaFY8RbbTBSO/
         APf6l/xyNxxfXl5Bpss5BWOdG50IzfUV7RB6H+b0F7IzEps3wmPKxPxiI7Ft8IG4HhU9
         +xhpkszxdYojaOoBS2w2gl01UlQysBpI+hm+As9PzHkz6GnTXV43hPsZMZscVOWxNNQg
         k6RZg/U1m7IIXND7MGTMfg0FgS7enjXr0+JwaRbmUuCguB5dNr8X8ThAxXzECK+eHCpg
         l2b/bE89kYkpjo/X5Kwe5rVBUo8jIa8LnimdZljl0jUpt1/XR2bVSsM8wxi+ajhX+vw9
         +zcA==
X-Gm-Message-State: ACrzQf2md6Jpr8CxC4ng5eR6AMrD/yy8e914XszE8fNgSWIu6MFM2ekF
        d0GCEF1522BgDbcXB8DuPqOPbTMnaoPxykckUqc=
X-Google-Smtp-Source: AMsMyM4j+jUPcsX2M7So4eJMIU50juNJGRpGK59aJzOBvvhz+lPdz/olYYYHYkGF3/75Epd6TCAs2xFG74FCg1PmZ9s=
X-Received: by 2002:a81:17d0:0:b0:361:4985:7ebd with SMTP id
 199-20020a8117d0000000b0036149857ebdmr2432646ywx.307.1665845378786; Sat, 15
 Oct 2022 07:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <CAOLTT8T7V0oYpS5XMWbhRi75z7cSVTcWsK76BdwGXAYYh=skPQ@mail.gmail.com>
 <CABPp-BFwiMrgm+_sO6TsLUj77r_krgzYEWZanbyx2Fnn4rM8tg@mail.gmail.com>
 <CAOLTT8R0MxEWErrw80-F+b1higbuWuQjvkEGi2c4ARzuRzeNWw@mail.gmail.com> <CABPp-BHX+qfWxkGvFx+SyGsiUbp5OVHx3MbWa96JtDnnows0ZA@mail.gmail.com>
In-Reply-To: <CABPp-BHX+qfWxkGvFx+SyGsiUbp5OVHx3MbWa96JtDnnows0ZA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 15 Oct 2022 22:49:27 +0800
Message-ID: <CAOLTT8S=eq4j6ENLWJAd_tGo+EyMVETHchn6NGgVii2LAM5T3w@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8815=E6=97=
=A5=E5=91=A8=E5=85=AD 12:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 14, 2022 at 7:17 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=886=E6=
=97=A5=E5=91=A8=E5=9B=9B 15:53=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Sep 30, 2022 at 2:54 AM ZheNing Hu <adlternative@gmail.com> w=
rote:
> > > >
> > > > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=89 13:38=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> [...]
> > > As an example, the repository where we first applied sparse-checkouts
> > > to (and which had the complicated dependencies) does not use partial
> > > clones or a sparse-index.   While partial clone and sparse-index migh=
t
> > > help a little, the .git directory for a full clone is merely 2G, and
> > > there are less than 100K entries in the index.  However,
> > > sparse-checkout helps out a lot.
> >
> > Yes, you make a good explanation here that we don't necessarily need
> > to apply all these kinds of features. But I still feel a little confuse=
: Where
> > does the time savings come from? Is it saved by the time reduction of
> > git checkout? Or is it the reduction of some unnecessary working tree s=
cans
> > during test/build time?
>
> It is neither git checkout time, nor tree scans; it's the ability to
> avoid building larging parts of the project coupled with the
> significantly better responsiveness of IDEs when project scope is
> limited.  When directories are entirely missing, we don't need to
> build any of the code in those directories and can instead just use
> already built artifacts from the most recent point in history that has
> been built on our continuous integration infrastructure.  (Note: our
> sparsification tool will keep any modules/directories where there have
> been modifications since the most recent upstream commit that has been
> built, so we don't risk getting a wrong build via this strategy.)
>

So these users are just building/testing on a few projects and save time
from building/testing on some other projects. This is reasonable.

> [...]
> > > > 1. mount the large git repo on the server to local.
> > > > 2. just ssh to a remote server to run integration tests.
> > > > 3. use an external tool to run integration tests on the remote serv=
er.
> > >
> > > Are you suggesting #1 as a way for just handling the git history, or
> > > also for handling the worktree with some kind of virtual file system
> > > where not all files are actually written locally?  If you're only
> > > talking about the history, then you're kind of going on a tangent
> > > unrelated to this document.  If you're talking about worktrees and
> > > virtual file systems, then Git proper doesn't have anything of the
> > > sort currently.  There are at least two solutions in this space --
> > > Microsoft's Git-VFS (which I think they are phasing out) and Google's
> > > similar virtual file system -- but I'm not currently particularly
> > > interested in either one.
> > >
> >
> > Here I mean git nfs, or some kind of git virtual file system, or some
> > git workspace, I don't really understand why they are now
> > phasing out?
>
> You'd have to ask them, or read their comments on it.  I think they
> believe sparse-checkout with a normal file system is or will be better
> than the behavior they are getting from their virtual file system (and
> they've put a lot of really good work behind making sure that is the
> case).
>

Okay.

> [...]
> > Some users may really want to focus only on their subprojects, so I thi=
nk
> > "git log -p" shouldn't show files that don't satisfy the
> > sparse-checkout patterns,
> > and "git grep" too. But some users may need to search something globall=
y,
> > and I think those people are in the minority, so maybe there should be =
a
> > "git log -p --scrope=3Dall" or "git grep --scrope=3Dall" for them.
>
> Good to know you're in the "Behavior A" camp and we've got another
> vote for implementing things in that direction.  A couple of small
> points, though:
>   * It's --scope rather than --scrope.  ;-)
>   * I have to disagree here slightly about people using a --scope=3Dall
> flag -- I don't think users should have to specify it with every grep
> or log invocation.  Users in the "Behavior B" camp would want
> `--scope=3Dall` behavior for nearly every grep and log -p invocation
> they make; it's annoying and unfair to force them to spell it out
> every time.  So, I think we need a configuration option.
>

Fine, this configuration looks like it can balance the needs of both camps.

Thanks,
ZheNing Hu
