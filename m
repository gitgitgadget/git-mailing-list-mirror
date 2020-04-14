Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63DFC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7142076A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noMLGQb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633145AbgDNUbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633128AbgDNUbD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:31:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F053C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:31:03 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o25so11596755oic.11
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwQqrIVcYWdnvqmqTsUa7C2ddf+1WpBOmOsO5qY3AT4=;
        b=noMLGQb9fK2z2Li98UyuThbkXVANsIVVE2Ye0EubeJCfCEgbReIrZwIU+9ID1zxAZz
         N876Opd/mbY2DLzwsDtI/xGrqWXIXMICWYnTnbFEA7ja2uWi1+dVi7J5NNpdVTxoalRf
         PkJP8gFg+PeTXXx9HdqdNii8JXogzmcab20YTEqAf5tsj69sOKz3q5fcwyuxxKS1JWlI
         dbDuFvTeo6lQjPXlLuB3v0b6K3q7akWiZQLkF/lda/zxXyr5k+f7BbIAF2KFTSAFkyRc
         UimAwcvRl0ipaqnm7MKa+yVyOI/G9Jww1tREwDRrxFVzwVHYT+4+Rh218/oCSKcqmeZJ
         uQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwQqrIVcYWdnvqmqTsUa7C2ddf+1WpBOmOsO5qY3AT4=;
        b=EHf+3t+DbFA0od7pa+7ZBYvdVUkRZc9aPbh5L30TJ/yqcpwbyOYpLct4/27w1O1eVD
         b9XhkUN0moO4PVdLa0p9+MsKPKE378nx0ox1Ah97fq+9TZ+r+RaPh7/DGee3kAwNTxfQ
         lpUNVw4P1d6/i177+lia1ETZU7lL2yxDkJvwKN4FKoNgz80b/uw4Wo4f4zfoNMYhNQBF
         sd3JeY+PDjBPWmpOz+PxPJm7l/gn22cmcHaF7rLvgYFEtrh/g7FlsekLbiKfbC1zHxzj
         Bz95lQFNs4hkcU5Bu+05vEoXzNMVIUx63DeCdy8MzxXccw8e+ZcrKDs5cgst0xNcCxzj
         q4gg==
X-Gm-Message-State: AGi0Pub25p59dfn5vxIfyHKkrjK7ORf2Nr1gpsB/xTS1B8Yk1qQojvyt
        6luTlo3NgDCEb0P0DUrKbBqG37SyOsXDMeHiqFfz0/RULSo=
X-Google-Smtp-Source: APiQypIsA35z+kLTaa1QtKOsg+/PXD8uHFOde++l3bkJUfOQeo87ONbsctEJX2pWW1ssbu8LwpHU2O2eZYpN20iORGw=
X-Received: by 2002:aca:fdd5:: with SMTP id b204mr9215308oii.167.1586896262518;
 Tue, 14 Apr 2020 13:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <34B51521-42CD-445B-AE91-4A659A7FE661@me.com>
In-Reply-To: <34B51521-42CD-445B-AE91-4A659A7FE661@me.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Apr 2020 13:30:51 -0700
Message-ID: <CABPp-BGSQ-FLv-9PS8EJGCivd2pMwYi57mgqKP_7U6HoRuxgAQ@mail.gmail.com>
Subject: Re: rebase backend change interaction with rebase.abbreviateCommands
 and autostash
To:     Philippe Blain <philippe.blain@me.com>
Cc:     git <git@vger.kernel.org>, Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 1:27 PM Philippe Blain <philippe.blain@me.com> wrote:
>
> Hi,
>
> I just had a bizarre error related to the change in the merge backend. I don't have a full reproducer yet but the following sequence should hopefully give some hints.
>
> In my config for this repo I have `pull.rebase=true` and in my global config I have
>
> [rebase]
>         abbreviateCommands = true
>         autoSquash = true
>
> Also my local `master` branch tracks `origin/master`.
>
> If `master` on `origin` is at the same commit as my local master branch, and I have some uncommitted change so I must use `--autostash`:
>
> ```
> $ git pull --autostash
> Created autostash: 6a6c685
> Applied autostash.
> error: nothing to do
>
> $ git pull --autostash --apply
> # or right that just works for `git rebase`
> ```
>
> Now if `master` on `origin` is ahead of my local `master`:
>
> ```
> $ git pull --autostash
> remote: Counting objects: 6, done.
> remote: Compressing objects: 100% (6/6), done.
> remote: Total 6 (delta 4), reused 0 (delta 0)
> Unpacking objects: 100% (6/6), 758 bytes | 6.00 KiB/s, done.
> From <redacted>
>    42033de..a3d6919  master     -> origin/master
> Created autostash: cdae23b
> Applied autostash.
> error: nothing to do
>
> Now if I stash manually and re-pull:
>
> $ git stash push -m "test rebase merge"
> Saved working directory and index state On master: test rebase merge
> $ git pull
> Updating 42033de..a3d6919
> Fast-forward
>  .gitconfig | 1 +
>  .tmux.conf | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> error: nothing to do
> $ git pull
> Already up to date.
> error: nothing to do
> $ git -c rebase.abbreviateCommands=0 pull
> Already up to date.
> Successfully rebased and updated refs/heads/master.
>
> Note: I also got  "error: nothing to do"  when manually running the commands in the last test of t/t5572-pull-submodule.sh ("branch has no merge base with remote-tracking counterpart') (and again using `git -c rebase.abbreviateCommands=0` succeeded).
>
> Cheers,
> Philippe.

What version of git are you running with?  Does it include Alban's
fixed for the rebase.abbreviateCommands error?
(https://lore.kernel.org/git/20200330124236.6716-1-alban.gruin@gmail.com/)

Elijah
