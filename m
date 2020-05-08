Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA2C35280
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F423C208DB
	for <git@archiver.kernel.org>; Fri,  8 May 2020 01:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESqiknn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHBBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 21:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHBBU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 21:01:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C613C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 18:01:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w20so8412908ljj.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=63X6eauSgDqeYI13R4hmqvGn4C5TZwc57f2S/auFXd0=;
        b=ESqiknn1TWeDlI/+M2cKSkSTvNsqwZwy2zITYfgjbyPbP6DeoBT9NPXYpFcz3D/SRK
         BfXg4sF7aAmRZ9+WHbikdXaYg+n98G/UDw0tOgOXfTn0Ifuszhgx478L/oWkH2BNIC5l
         DbMCGiPWDTmryFXK408+AZE7226rRJvWrJxD1P/i9laZZL6CVOnRJZxpzHjwbPEHiifs
         q1mZOneTIuhdZXa3FnX9IHAqzM2EvHGDW+MwRnGclfRHXXLmdzT24dQdGWiKmih5mG8N
         SfmNvn0wFjNMEosoXPJP8yzNBCI5+Tn5ly3XyhL+tr5PM4QyEjshG+SuZ6p6JVmpaiLv
         hmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=63X6eauSgDqeYI13R4hmqvGn4C5TZwc57f2S/auFXd0=;
        b=p66UvNCBg5hPkK8QG/MdpLsbWINJ7p+2/n4UqA/qsTL7w2Br69TVADOx0YBx5mDxi4
         IXtuVBExOWCYgo0GNfB8fyllNJtKYCKXOPp+Mu+oc2u3Be20JEm76zkyR8+jW6bSkEdK
         dZNhDMYmlHKj5RQPvXWmeZWLnq3jufyhsQz8BWehaqVZ7qI/JGlKdkWMv28Dj5Yukt8D
         bLL+whqjGvqjX4tY3E2cufbNo5jePWfuJd41k7PV6hB23EtgZ6cjXUKp175op0XBLtXx
         6XAmDt/1PhxdmxFYpTSNYsUekAHtHVd7RhRXAEMPuYu3dkjOzo0PzoUPuFydJS+bRoSG
         4hvw==
X-Gm-Message-State: AGi0Pubtby1aoOpG8ZKCsVVZXLCKwk5BTlgIhLbwrJaXblYG4zki3jDR
        8TcbePDd6ROLh4mFrDcqJQ1mtIbwsAv4DYVZ8Pc=
X-Google-Smtp-Source: APiQypITvJJiNC99NDN0bmV5D6NITxzPzbHL2cS7XOoipnSJS6mzAYNYOFyk60rNhEbvgJXaDvPrSbYkMFg07yB6shE=
X-Received: by 2002:a2e:9ada:: with SMTP id p26mr10438701ljj.14.1588899676253;
 Thu, 07 May 2020 18:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <06da01d624c7$acb17090$061451b0$@nexbridge.com> <CA+KyZp7Ur3kW3qrCe3hOz16gA9y_B7rSGin62=eKMjCCqLsR4w@mail.gmail.com>
In-Reply-To: <CA+KyZp7Ur3kW3qrCe3hOz16gA9y_B7rSGin62=eKMjCCqLsR4w@mail.gmail.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 7 May 2020 18:01:04 -0700
Message-ID: <CA+KyZp7emY12sy6QdGBJ5T9e135VCfjeqTy9u_FWh+FA1d-uFg@mail.gmail.com>
Subject: Re: check if one branch contains another branch
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git branch -d foo   # safe delete

the above doesn't seem to work if you squash commits into an
integration branch, I will get something like:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 git branch -d CP-10-master
warning: deleting branch 'CP-10-master' that has been merged to
         'refs/remotes/origin/CP-10-master', but not yet merged to HEAD.
Deleted branch CP-10-master (was faeb801).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


If a branch gets squashed into another, how does merge-base do it's
thing, since it's not a fast-forward merge etc?
I assume that it's not possible, for example this script shows that if
 git merge --squash is used, git doesn't know that the unsquashed
branch is already merged:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

#!/bin/bash

set -e

git checkout master
git branch -D delete-me-1 || echo
git branch -D delete-me-2 || echo

git checkout -b delete-me-1
git checkout -b delete-me-2
git commit --allow-empty -am "first new one"
git commit --allow-empty -am "second new one"
git commit --allow-empty -am "third new one"
git checkout delete-me-1
git merge --squash delete-me-2  ### compare without squash

if git merge-base --is-ancestor delete-me-2 delete-me-1; then
  echo 'delete-me-1 is an ancestor of delete-me-2'
else
  echo 'not an ancestor'
fi
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

that will print "not an ancestor" if  --squash is used..

-alex




On Thu, May 7, 2020 at 4:37 PM Alexander Mills
<alexander.d.mills@gmail.com> wrote:
>
> I assume that:
>
> git branch -d  xxx
>
> will prevent a delete if the current branch doesn't contain xxx..
> I don't want to have to checkout  origin/dev in order to run that command=
,
> that's one part of the problem
>
>
> On Thu, May 7, 2020 at 4:31 PM Randall S. Becker <rsbecker@nexbridge.com>=
 wrote:
> >
> > On May 7, 2020 6:59 PM Alexander Mills, Wrote:
> > > To: git@vger.kernel.org
> > > Subject: check if one branch contains another branch
> > >
> > > I am looking for a command:
> > >
> > > 1>  if branch x contains branch y
> > >
> > > right now all I can find is
> > >
> > > 2> if current branch contains commit y
> > >
> > > can someone please accomplish #1 ?
> > > Crazy hard to find an answer to #1 online.
> > > The user case is to delete old local branches by comparing them with =
the
> > > remote integration branch.
> > >
> > > more info if needed:
> > > https://stackoverflow.com/questions/61669056/how-to-determine-if-
> > > integration-branch-contains-feature-branch
> >
> > Looking at this slightly differently, if you try to delete a branch, gi=
t branch -d feature-branch, and the branch has not been merged, then the de=
lete will fail. A simple way of looking at it is if the HEAD of the branch =
has no successor commits then it is not merged (not 100% decisive, but git =
branch -d is). It is not really that a branch has been merged, but that a c=
ommit has successors, meaning that it has been merged. However, unless you =
are using GitLab, a git merge --squash will not answer your question even i=
f the branch was merged.
> >
> > A better way of looking at this is in terms of Pull (GitHub, BitBucket)=
 or Merge (GitLab) requests. Has there been a Pull Request for a branch and=
 has the branch been closed? Meaning that when you do a git fetch --prune, =
your merged/deleted branches go away unless you are on that branch. Looking=
 at the Pull Request history is much more useful in determining whether a b=
ranch has been integrated into a main development branch or production bran=
ch in a GitFlow process.
> >
> > It is a different way of looking at the problem, but IMHO, a more repre=
sentative way when taking developers and deployment into account.
> >
> > Regards,
> > Randall
> >
>
>
> --
> Alexander D. Mills
> New cell phone # (415)730-1805
> linkedin.com/in/alexanderdmills



--
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills
