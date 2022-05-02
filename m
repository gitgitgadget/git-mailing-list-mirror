Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D4C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 14:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiEBO6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbiEBO6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 10:58:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C580DECE
        for <git@vger.kernel.org>; Mon,  2 May 2022 07:54:45 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2f7bb893309so150182437b3.12
        for <git@vger.kernel.org>; Mon, 02 May 2022 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aquatic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+rqx4d+WDgIJjBcFP8WX7C/8Bf3BQd16V6oPnzhKF8=;
        b=a92bB+ZmNeHKX4WGr0JNOP52dCtRSi0wWcR4lHUDCqTzh+hNhjnWeU4J/L1odx8F/B
         8xkW3vHmPcyplhY4jSamQX5CfjYUfuk5KIi4wlTUxRLlIqmvIvQfj8jogVpvwKjmh71O
         e2M7HXFBwcqt3bJ86kOUC+/yT84sv9mQRDN46NNCTmprPyipjYdNsrRIWeqbBamUvB7y
         vctJoxbuoha/3zPJ4duApGUpqmxAOQdJw8tiOk3cBDeYrEOjfqKUsYp5amHs50ZFHf8j
         4k950B8YiGnyAvI1VACFJkHzGpDR2Z04AjnV3w38d6ReVqtkmPVpj4owNLMjnSIqeaW2
         dNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+rqx4d+WDgIJjBcFP8WX7C/8Bf3BQd16V6oPnzhKF8=;
        b=54q/I5ZnlCsywhZTD40cN2SEcLEs3W+bJSnFbeaF2UAVz0a5/NHWX0TREETsd8RosX
         En1EDQFuqpM2WOzBbmCRo+9p/ilDLugGDcge1R6l83Ntm2JKWG0quvnzcnA/JepVOxRI
         ZEjroddQJO+xHHpfizUCFvvef/EqJsIipXvgBzhhZznZgxKOy/Ba8Q675Omah9QlLFcy
         peqboR4jkoBYSmvqbfv0D1lIKmk26pWm4+4smH2IH82sg/0mgzwzSY76XF1ZYk1/chwz
         ninD333VVccyX/2aVOM9ufa/HurZpJnAyoTSxWLN46tLlJekSheriT0vPlnjXpvj2jsj
         r0Ig==
X-Gm-Message-State: AOAM530gvfsf79EMHISlyzVSI2nnsRhvowI0nkslXXbS2MjvmRNw0XIT
        1ZELVcobx++IBpQTxPYFxnXaO2DnZoMhO6Z32cdtBiq733A90v/HAKdIZpRCyTdaP7cTu18ycOE
        b3CETv9qjMu7XT5vLoadlXFJnfYyl5jzZUwmqOv23JCDmTldlhWxWGH1/2KS5KpiU7sMIupgUu0
        tXr0sEFL8/F6JUYJ96CKsoQOQzFQ5KnzIqkITAu1UAnvkzT71Er2g27iT9zWa4wMo=
X-Google-Smtp-Source: ABdhPJxH5cOnriiipTWM2XVCZ5/V3sdVhLO+Xa7XdihwPZMhtDffKMEiZGl8NCr46sML5bfCnT29E6HGVrIw5AVTrck=
X-Received: by 2002:a05:690c:110:b0:2ec:2d79:eee1 with SMTP id
 bd16-20020a05690c011000b002ec2d79eee1mr12246268ywb.21.1651503283830; Mon, 02
 May 2022 07:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAir=1MbwGtONW7yWRWoXKzAiwqwhOAqdhfWYMYLxt1vANuUOA@mail.gmail.com>
 <xmqqsfpvabib.fsf@gitster.g>
In-Reply-To: <xmqqsfpvabib.fsf@gitster.g>
From:   Austin Morton <austin.morton@aquatic.com>
Date:   Mon, 2 May 2022 14:54:33 +0000
Message-ID: <CAAir=1NY=98Z_cTrEyUn6tcPFR3UGNUmXs=2hg27LMGijGZpUw@mail.gmail.com>
Subject: Re: Able to checkout same branch in multiple worktrees when using symbolic-refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By your own definition I am not an inexperienced user (since I am
using worktrees and symbolic-refs), but this has bitten me on enough
occasions to beat me into submission and submit a bug report ;-)

I don't know why you would need to scan all the local branches, unless
that is what "git worktree list" ends up doing under the hood?

"HEAD" in a worktree that was checked out using the symbolic-ref still
contains the symbolic ref name, while the worktree list resolves it.

$ cat .git/worktrees/worktree2/HEAD
ref: refs/heads/main
$ git worktree list
/home/amorton/test/worktree1 cd8312d [master]
/home/amorton/test/worktree2 cd8312d [master]

Seems like you would "just" need to resolve the symbolic-ref in the
same way that the worktree code does when checking against existing
worktrees in find_shared_symref during checkout.

Cheers,
Austin

On Fri, Apr 29, 2022 at 8:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Austin Morton <austin.morton@aquatic.com> writes:
>
> > When using a symbolic-ref I am able to inadvertently checkout the same
> > branch in multiple worktrees when using the symbolic-ref name, despite
> > being prevented from doing so if I use the target branch name.
>
> Don't do that if it hurts ;-)
>
> If you checked out 'main' in the secondary worktree and made a
> commit there, the symbolic-ref makes 'master' to be updated,
> confusing the primary worktree whose index and the working tree
> files record work relative to the old commit before the secondary
> worktree updated it via the symbolic-ref, which is exactly the same
> situation that the "do not check out the same branch in two
> different worktrees" protection tries to save the user from, but I
> do not think we currently do so.
>
> Because this "do not check a branch out twice and let it be futzed
> with from the two places" is primarily a mechanism to help
> inexperienced users from getting confused (and there is an escape
> hatch mechanism to allow it to those who know what they are doing),
> and use of symbolic-ref to make 'main' and 'master' synonyms with
> each other is not something inexperienced users who have no clue on
> what they are doing would be doing anyway, it may not be a huge
> deal.
>
> I also suspect there is no way, other than scanning _all_ the local
> branches, to see if some other branch aliases the branch we are
> about to check out.  It may potentially be somewhat expensive.
>
> But it would be nice if it can get fixed in inexpensively.
>
> Thanks for a report.
>
>
> > Below is a minimal reproducer:
> >
> > $ git --version
> > git version 2.36.0
> > $ git init .
> > $ git status
> > $ git commit --allow-empty -m "Initial commit"
> > $ git symbolic-ref refs/heads/main refs/heads/master
> > $ git worktree add ../worktree2
> > $ git worktree list
> > /home/amorton/test/worktree1 cd8312d [master]
> > /home/amorton/test/worktree2 cd8312d [worktree2]
> > $ cd ../worktree2
> > $ git checkout master
> > fatal: 'master' is already checked out at '/home/amorton/test/worktree1'
> > $ git checkout main
> > Switched to branch 'main'
> > $ git worktree list
> > /home/amorton/test/worktree1 cd8312d [master]
> > /home/amorton/test/worktree2 cd8312d [master]
