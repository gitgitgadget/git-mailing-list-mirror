Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C1C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A2661B39
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359298AbhKPA4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbhKOTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:20:51 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A283C061570
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:15:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n26so11147940pff.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzPbXvNBoiX1zoB/JbmyWB4y9lN9PJIETsXACWp757s=;
        b=TI2He9quu0/Ct4Frp9U6owiQ4JTo278sbrusIbK0mdoHnXEmuFcF2C29bDG6spRyNf
         K2JM77chlxI89JZERnlrSvKV0m3z7Yb+ukWd91pTIwmy51Zx1hJA1qZcM860P9/Ou0Nl
         tAiiVCehm/sir9aVHufD+m7MsDaMTgaj5FOYriTgyMf/d0Ixf2oTqaBPR1BM2MfeB4Rd
         rkd3QhcjmxWxIXJ26EGF7YgNiPzxnQm7caymE2X1v7QUugEvPoVswBxGLzjnombaL4rU
         olPP2/+5fzMGJ8zQNQ/yrSf2L6qXBS4WI9ZcpTdpLAThX2Im9jTWmJcMxxReYCmJEeSm
         rj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzPbXvNBoiX1zoB/JbmyWB4y9lN9PJIETsXACWp757s=;
        b=fu+py1SDSW79dufh/R7WyLZxlMV6DY2914OL2jdeXUoEV/ptCeHCJ4od/uD7sulcfh
         0a74J8EFDj3/5mOwrD0c+8xA3pAJc/DmWgdMi4VSh1Ht4PgJhtsiCrbjmw6pIaE+U92X
         xqcUKKIu/PQDXdWFcCqh9bfUav6sdq6Mu++jVkXBUMJv2Ml2rzHOSRkb8Rha/AoN2wBQ
         IZgqy88WPfxgE1AaItnzkQvNLffEO05L38WSJ9EKx2gEeTBEny1v7c/89bHv+sckin4m
         VaxMKymo8pz/3w59l9QzgZBHnczBPjJSX9J23TNbSdrNle4NHKvJv79Rl9e5dDHtmGb2
         wj/A==
X-Gm-Message-State: AOAM530bMOhxqoFAmSIizzMAwNPOtMD+ZIQxs66uwmjH6+8iZnxfXc8d
        hlF99UeIbqHf+lkM+RKqIrbjcLLYoqnvZK4vDqwMjEJxc9sMoQ==
X-Google-Smtp-Source: ABdhPJwNMCHFXa0oExzz6wRL3nQodkXietVZklTtArpDnR7MNGGrwsqA3ugfDlYXU5FtqWLT2bYein6T0rwtR7nEbw0=
X-Received: by 2002:a05:6a00:9a3:b0:49f:bf9b:3192 with SMTP id
 u35-20020a056a0009a300b0049fbf9b3192mr34245606pfg.44.1637000141998; Mon, 15
 Nov 2021 10:15:41 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com> <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
 <0bd032c1-f90b-1892-693c-518a01b3b671@gmail.com> <CADL96rs0M15E+CnycBsDqGbiibDFx4KeMthLspQH1=Bw3PS3gg@mail.gmail.com>
 <CADL96rtX_uw6fJEVq2u9bkPNhYXwaGT13F+cMiGgZrHQr5TP7A@mail.gmail.com>
In-Reply-To: <CADL96rtX_uw6fJEVq2u9bkPNhYXwaGT13F+cMiGgZrHQr5TP7A@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 15 Nov 2021 10:15:30 -0800
Message-ID: <CAGyf7-GjoU7VqN3bhRcoQ1xJM==h2aNm9fm_5HxDJk_hgGop1Q@mail.gmail.com>
Subject: Re: git pull bug report
To:     Erwin Villejo <erwinvillejo@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 1:40 AM Erwin Villejo <erwinvillejo@gmail.com> wrote:
>
> $ git log main github/main --graph --decorate -n 3
> * commit b73d3e132f9638afbf5b98b0c278ed6b93a3ae50 (HEAD -> main)
> | Author: Erwin Villejo <erwin.villejo@gmail.com>
> | Date:   Mon Nov 15 15:22:53 2021 +0700
> |
> |     init activity api
> |
> * commit d370bf256a756a777c14609c8ad4184aa7e9e60f (github/main)
> | Author: Erwin Villejo <erwin.villejo@gmail.com>
> | Date:   Sat Nov 13 19:18:45 2021 +0700
> |
> |     refactor partitioning migration
> |
> * commit 5124511d287f1a6c384ff9766fdcc0e3e07043e8
> | Author: Erwin Villejo <erwin.villejo@gmail.com>
> | Date:   Mon Nov 8 17:24:19 2021 +0700
> |
> |     wip pg
>
> $ git remote -v
> github    git@github.com:erwinv/database-sandbox.git (fetch)
> github    git@github.com:erwinv/database-sandbox.git (push)
>
> Link to the [upstream branch on
> GitHub](https://github.com/erwinv/database-sandbox/commits/main) so
> you could see for yourself that my local is ahead of upstream and that
> the upstream has no commits ahead of local.

Certainly looks "ahead". There _has_ been at least one confirmed bug
in 2.33 related to how "ahead" is handled[1], but it doesn't seem like
it's related to what you're seeing here. The "git pull" output
suggests you don't have "pull.ff=only" set.

Are you able to pull down either Git 2.32 or the just-released Git
2.34 and try one of those?
My suggestion to try "git fetch" could still also be useful, to see if
your "git status" output changes.

[1] https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/

>
> Best regards,
> Erwin
>
>
> On Mon, Nov 15, 2021 at 4:19 PM Erwin Villejo <erwinvillejo@gmail.com> wrote:
> >
> > > the remote mainline have three commits ahead
> > Where did you get this info? This is not true in my case.
> >
> > * local is ahead of upstream. confirmed by `git status`:
> >
> > ```
> > $ git status
> > On branch main
> > Your branch is ahead of 'github/main' by 1 commit.
> >   (use "git push" to publish your local commits)
> > ```
> >
> > If remote was ahead, `git status` would say so. And this is my
> > personal repo in GitHub with only me as the sole developer/contributor
> > so I can assure you that the upstream has no commits ahead of my
> > local.
> >
> > Best regards,
> > Erwin
> >
> > On Mon, Nov 15, 2021 at 4:12 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > >
> > > On 15/11/21 15.56, Erwin Villejo wrote:
> > > > There is nothing to reconcile since the branches have not diverged:
> > > > local is ahead of upstream. So I think it is a bug, no?
> > >
> > > You have the situation like:
> > >
> > > ---o---a (your mainline)
> > >     \
> > >      b---c---d (remote mainline)
> > >
> > > Your mainline only have one commit ahead of base point `o`, while the remote
> > > mainline have three commits ahead of `o` but unrelated. In this sense, your and
> > > remote mainline is divergent - you need to either merge or rebase.
> > >
> > > Next time, keep your mainline pristine (don't commit any local changes on it,
> > > instead branch to the topic branch and commit there).
> > >
> > > --
> > > An old man doll... just what I always wanted! - Clara
