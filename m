Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C61C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607C9611C9
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 23:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhDKX34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 19:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKX34 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 19:29:56 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F04CC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 16:29:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e186so11581586iof.7
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jASSjI8Ch9sj3wp1rVxBEXie6nHmLqrD4yme392V0k0=;
        b=jZ9ODtRwsUBZomrbvHU1dG0ezAGPlcVJpHKgQGWmbUHl8p+IqmvRVZyZTC8/wwlb1c
         AjRRyk4/LCttNbe+pArRz+sCGMM38fhQr31ttLtRRIBNmAs9ziAetQTgLBNZWC96+X21
         bKiHR2Y7nxVBtWmdeMoxqTEYkHh8L0aIRV07y8mlHIBIKRnAOxhRxm1WJC/CvxSPPZsj
         h+ChcQgFXizTmT3rs4xktANZ0gCDQzBKCWDxdVRpJUEhk01rEZ8Cq84L/9k/GP/CeEsd
         cEmUMFYx5DgH8KUNR/eleCdHgnyTtS+LRtQ7bFkdJYZzaccg+zKTIVkpNQx14K/FI375
         hklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jASSjI8Ch9sj3wp1rVxBEXie6nHmLqrD4yme392V0k0=;
        b=M/9YeHcChsQ8rK1jPLWhGjoWdna3pQDsrLiRQ6LYWQUjVgRDKQFLHy1NGGDObg/R/o
         y5MSp61Z+s4eq2vcDuAnfpVu2HetIA+6nHyvu/FxsktWghCsJs86hjZptR+9fo0uIfP2
         vte/fMCqqP1rPafdTRMjwaGLmWcVMgePRBoomCVZi5957vHL1mNmZL1DzJ7re8WX0Gbb
         vu14mZzaLQosoDTm2yQFDVBTr6BAGw0/uixQp+/ELw9Ip09vfR2S3V+1dm+0VzLA4iub
         /7oao4NQ0p8N8cDWEZ+xl4+7e7KwAEBJ+fFQxRfgstzlJD3uVYNWm5C1HUu8lF+mRiog
         QUlQ==
X-Gm-Message-State: AOAM533QBrSXCUqiDalAcyswBDCLFX5P4iIanZYVq0PJGry+PYxvALrE
        auT5GzYU42LcMl+5nmYC+zZH1Uf/hYiGY7Kw4zURVJL0OAE=
X-Google-Smtp-Source: ABdhPJwWugMf8ro1663mcZKN+cWv3dHUK5+Ocu1dNIKBhXnPiJ4Vmofz/QgS450jKpBxD+g/xcoY+3uOqkAsrZ1rY18=
X-Received: by 2002:a6b:4f06:: with SMTP id d6mr6762568iob.124.1618183777519;
 Sun, 11 Apr 2021 16:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nT-68H9Vy=zxqsKeqpBqt-OJYCpVh53cm1KoeSbSVC-Q@mail.gmail.com>
 <xmqqk0p8flui.fsf@gitster.g>
In-Reply-To: <xmqqk0p8flui.fsf@gitster.g>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 11 Apr 2021 19:29:25 -0400
Message-ID: <CAH8yC8kZjFZo-si45oYTzUyH+J6YOLD62Bdmomzr0NDkDzLhRQ@mail.gmail.com>
Subject: Re: How to checkout a branch (and not a tag)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 11, 2021 at 7:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeffrey Walton <noloader@gmail.com> writes:
>
> > I'm trying to checkout a branch called REL1_35 from
> > https://github.com/wikimedia/mediawiki-skins-Cosmos. The repo also has
> > a tag called REL1_35.
> >
> > When I perform the following I apparently get the tag (with old files)
> > and not the branch (with updated files):
> >
> >     wiki_rel=REL1_53
>
> Hopefully this typo is not part of what contributed to your problem.
> Assuming that you actually used REL1_35 here...

Yes, typo.

> >     ...
> >     git fetch origin && git reset --hard "origin/${wiki_rel}" && \
>
> ...this should get their branches in refs/remotes/origin/, and would
> reset whatever local branch you are on to origin/REL1_35.  So at this
> point, HEAD is the same as their REL1_35 branch.
>
> >         git checkout -f "${wiki_rel}"
>
> And this causes the tag/REL1_35, which was obtained from them, to be
> checked out to a detached HEAD.
>
> What are you trying to do here?  Do you want your own local REL1_35
> branch, that starts at the same commit as their REL1_35 branch?

I want an exact copy of the remote branch.

After I get that copy, I usually delete unneeded fodder, like test
gear and documentation.

Jeff
