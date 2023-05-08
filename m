Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8713C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjEHRRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjEHRRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:17:07 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22FE76
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:17:05 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-18f4a6d2822so32754419fac.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566224; x=1686158224;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UB5uy649apfhSd/qPwqHD/n7DD6u1phF1fHrh/Rh5A=;
        b=KXMvmQjGJmiiq1MJNPrhJOkFs2t/nY7hLtz+RWSreAkj5O4Z2D6xWDFITKF8O6soEI
         w51y/l9ZG36IcrT14HMjTdRHPijxcZpNrQxIYXlt5CnCoJ3flszEauBVcHTiPHbKlQlL
         aJJdLwcDmdXbpo4U3hNN7Eyvn6K/mgAcwCWN0gaGdKR/IgmIAaaF6aoLqYVnVHXgb8zq
         Su6JcUcEhRg3XILQINmf+X1XtnxFKYncE3/OL8G5PtFzPIOcD98pk8eD0XCiJfsKWT4y
         /vrZuO/BQbpk/FvuAU5YDV5/rBighPiQFnRYzBFvk6MWTzqSeQqUSWaHmmTuaVFiUJ5K
         l8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566224; x=1686158224;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UB5uy649apfhSd/qPwqHD/n7DD6u1phF1fHrh/Rh5A=;
        b=bXP4Grtq957OStt5gw2tFEG5oXGPsIaS+bFg4+02KNqNpAgaUzG6uKIUGrOINxeeCK
         qy5LNQ2TSK/836GgLZftO8aFmZBmlORIgPQCqJBfR/dHLuX46U0/7nwapaBQuXn/KBmn
         cetvzKEJ+9y+RNK/943OP6VWURPT1dF/QhmW/goUNxlm1D4tnLKsBvkwiovn9cF2GQrd
         La4r8cAppT9JJl2vrtN1fSgKfNrzbKqvxYrVtSFhCVgOE6ovbbqcuLgXyLx2Nstzmc6i
         2uOlVBhDzhkzG01679YMi1jgY5TPwFV+0YBGNVc50Xn+tRyqyf7ASuzHezAtoqJWtggR
         sbxA==
X-Gm-Message-State: AC+VfDzPmwRDzonMH85xwVcBxhCXK6xpzldO08lY10gpYndMsiv1fLI6
        jOuFIlU6ZxYyt4IGXsfNlx0=
X-Google-Smtp-Source: ACHHUZ6fmuS8XFjUfjUVnleDDyi5zpw9qo5Q1XlAsGMIPSZDE3GWjbv8UQEm6ARV3a3jd2mFdhUTzA==
X-Received: by 2002:aca:c246:0:b0:38e:2d70:9d58 with SMTP id s67-20020acac246000000b0038e2d709d58mr7517391oif.18.1683566223814;
        Mon, 08 May 2023 10:17:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b003908004b37dsm205674oiy.26.2023.05.08.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:17:03 -0700 (PDT)
Date:   Mon, 08 May 2023 11:17:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dan Stromberg <strombrg@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Thomas Guyot <tguyot@gmail.com>, git@vger.kernel.org
Message-ID: <64592e8e848f2_8a9f294a3@chronos.notmuch>
In-Reply-To: <CAOvKW57WdwNoYXJyebMf-V4mQBz5CjvD=qhGxtht_2YKuygL1g@mail.gmail.com>
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
 <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
 <CAMP44s23Qsw3behbm57BNKeT9w_u1OunV04A9uzz85rDcD_Uug@mail.gmail.com>
 <CAOvKW55MbXF8sDaGTTk9XJxw6Ln9E9G8qOF4wbXzEKY=GH=Zag@mail.gmail.com>
 <64590f5430b36_79d229439@chronos.notmuch>
 <CAOvKW57WdwNoYXJyebMf-V4mQBz5CjvD=qhGxtht_2YKuygL1g@mail.gmail.com>
Subject: Re: Weird merge records
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Stromberg wrote:
> On Mon, May 8, 2023 at 8:03=E2=80=AFAM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > > You seem to be implying that I shouldn't use 'git pull --rebase
> > > upstream "$branch"'.
> >
> > If you know what you are doing, then do whatever you want. `git pull =
--rebase
> > upstream $branch` is fine, if you know what that does.
> =

> I consider myself a git neophyte.  It's a large topic.
> =

> > I would just keep in mind that `git pull` wasn't meant to merge your =
changes to
> > upstream, it was meant to merge $branch to your integration branch.
> =

> I see.
> =

> > > If that's the case, what would you recommend?
> >
> > I would recommend `git fetch` + `git rebase` (or merge). If you are e=
xplicit
> > about what you want to do, surprises are minimized.
> =

> Might that look like:
>         git checkout "$branch"
>         git fetch upstream
>         git rebase "$branch"

With `git rebase` you specify the upstream branch you want to rebase to, =
so:

  git rebase upstream/master

This can be configured with the "upstream tracking branch" info, so:

  git rebase "$branch"@{upstream}

But this is the default of `git rebase`, so just:

  git rebase

>         git push origin "$branch"

If the branch already exists in the remote, you are probably going to nee=
d --force there.

Also, you don't need to checkout the branch, as `git rebase` can do that =
for you.

This is what I would do:

  git fetch upstream
  git rebase upstream/master $branch
  git push --force origin $branch

Hopefully in this scenario "upstream" is the upstream repository and "ori=
gin"
is your personal fork.

-- =

Felipe Contreras=
