Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D7C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4835861B6F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhKOJm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKOJmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 04:42:38 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F90C061746
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 01:39:39 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id s17so1678622vka.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUyX2osQgObhG/+UE+RmAiNdRArfV6ag1AU0/4xLpb4=;
        b=o2Z2OhR4HRck1JzXGTYnSCxZ8XdjwdJxfjcqNfAnHQTI19pVzYYu1eB0woIYYEBgfQ
         +iwbt59nxCcWrGRPPJd7e7B8Z02z1KAJjpB8w+PbM/x/tRTLOZjsKPL9YubPRvlBRSz4
         ou2JWBQ4N7xDIp4AUbGv+5KlNVTXOZuQJrQqhHPubGFFiUFtZuk1GTGFm4d/iR7PVsiE
         nIT4EcO4X1lliSaMpMeBnFHmqtvuy+JWsBSHgW2NmQudiffwV87IsIaXSa4TblMBNgVN
         JhSPzkgkeOxkHCNAoDFqlM+RQ8WSlR+l7XrevHjbE/fyqrCg6zUupkyhRbZm9Sxz6Mtn
         2D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUyX2osQgObhG/+UE+RmAiNdRArfV6ag1AU0/4xLpb4=;
        b=QSpZNQScfB0+Tyq/dpKrTsc4vsl8QuT4IiUZqMq2C6H8dnT3QlOXbjKlxMD5BL5YT0
         peyaWaeJ7ygNDKahsW26iQTwdJagD/bcnKnloTE3nNQOO34+AnYhmJ8j+ULeU9F+UXJ2
         wyv7J5OurcyI+jWYvQuxesrhzxhruoL8Iavt/wMwoYZVxgwPJp0Zsn8H09y8bmzvT39l
         Fous6GrmroBz/Wht2V8oo+v7gvWzpHBqqlLcno+Amiu3GIPU+6IPoZPGURKj0JxU4kba
         BpP/oAKqG5O+M4NZcw8dzOOk1PNlire+1C9fL5M8ozmGMcYRg0Z68E0ABs6sT9Qz7Amm
         yWIA==
X-Gm-Message-State: AOAM532nh4ao/KnIvMUz18VVx/dYk38mKPD8Ea6o+zoAumYpf7Fpa+9Q
        ncgY4CviP0ZwD3ZVMvCdmzuVh+ZHjD2XwbFR1dwZm3cW
X-Google-Smtp-Source: ABdhPJwf3Eb78OKPAb8G6iHQS2vVUb0kX5gTFcY+529cV0ZHsrleNe4ixmZYz//odNxmkP14sLPCxVRz+Of0VmGmIzs=
X-Received: by 2002:a05:6122:507:: with SMTP id x7mr57050294vko.18.1636969178026;
 Mon, 15 Nov 2021 01:39:38 -0800 (PST)
MIME-Version: 1.0
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
 <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com> <CADL96rvWidDUEChJX8JCruUKjaOWqXrZn6-sG0EYb82_k_LTsA@mail.gmail.com>
 <0bd032c1-f90b-1892-693c-518a01b3b671@gmail.com> <CADL96rs0M15E+CnycBsDqGbiibDFx4KeMthLspQH1=Bw3PS3gg@mail.gmail.com>
In-Reply-To: <CADL96rs0M15E+CnycBsDqGbiibDFx4KeMthLspQH1=Bw3PS3gg@mail.gmail.com>
From:   Erwin Villejo <erwinvillejo@gmail.com>
Date:   Mon, 15 Nov 2021 16:39:26 +0700
Message-ID: <CADL96rtX_uw6fJEVq2u9bkPNhYXwaGT13F+cMiGgZrHQr5TP7A@mail.gmail.com>
Subject: Re: git pull bug report
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git log main github/main --graph --decorate -n 3
* commit b73d3e132f9638afbf5b98b0c278ed6b93a3ae50 (HEAD -> main)
| Author: Erwin Villejo <erwin.villejo@gmail.com>
| Date:   Mon Nov 15 15:22:53 2021 +0700
|
|     init activity api
|
* commit d370bf256a756a777c14609c8ad4184aa7e9e60f (github/main)
| Author: Erwin Villejo <erwin.villejo@gmail.com>
| Date:   Sat Nov 13 19:18:45 2021 +0700
|
|     refactor partitioning migration
|
* commit 5124511d287f1a6c384ff9766fdcc0e3e07043e8
| Author: Erwin Villejo <erwin.villejo@gmail.com>
| Date:   Mon Nov 8 17:24:19 2021 +0700
|
|     wip pg

$ git remote -v
github    git@github.com:erwinv/database-sandbox.git (fetch)
github    git@github.com:erwinv/database-sandbox.git (push)

Link to the [upstream branch on
GitHub](https://github.com/erwinv/database-sandbox/commits/main) so
you could see for yourself that my local is ahead of upstream and that
the upstream has no commits ahead of local.

Best regards,
Erwin


On Mon, Nov 15, 2021 at 4:19 PM Erwin Villejo <erwinvillejo@gmail.com> wrote:
>
> > the remote mainline have three commits ahead
> Where did you get this info? This is not true in my case.
>
> * local is ahead of upstream. confirmed by `git status`:
>
> ```
> $ git status
> On branch main
> Your branch is ahead of 'github/main' by 1 commit.
>   (use "git push" to publish your local commits)
> ```
>
> If remote was ahead, `git status` would say so. And this is my
> personal repo in GitHub with only me as the sole developer/contributor
> so I can assure you that the upstream has no commits ahead of my
> local.
>
> Best regards,
> Erwin
>
> On Mon, Nov 15, 2021 at 4:12 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > On 15/11/21 15.56, Erwin Villejo wrote:
> > > There is nothing to reconcile since the branches have not diverged:
> > > local is ahead of upstream. So I think it is a bug, no?
> >
> > You have the situation like:
> >
> > ---o---a (your mainline)
> >     \
> >      b---c---d (remote mainline)
> >
> > Your mainline only have one commit ahead of base point `o`, while the remote
> > mainline have three commits ahead of `o` but unrelated. In this sense, your and
> > remote mainline is divergent - you need to either merge or rebase.
> >
> > Next time, keep your mainline pristine (don't commit any local changes on it,
> > instead branch to the topic branch and commit there).
> >
> > --
> > An old man doll... just what I always wanted! - Clara
