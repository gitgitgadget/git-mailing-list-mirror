Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F5C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 03:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF37206E2
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 03:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpluPchz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBVDDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 22:03:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBVDDM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 22:03:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id w6so3946085otk.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 19:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1WK1rP0IIeWr/BJdJ/UTl33KsmBQDurIb/QwB197bY=;
        b=YpluPchzHrS0ZlpStRZLjA4HXRJQkkkzu8R3PxgIkpzC16+htBwzdP2RXfBulCvWho
         +SEzkQTB0NZ6PGnzOddpHXsrt24+eWByoR5FN9paAsdXDQD3svB56+w0XtBh6gLxRfBT
         rQCSR4PZte/GhYRHNAYTtQu4OOHv6tPGbVkfI6xPOlIhhtU+F4WCifflXGT/7w+z+eff
         bmgSTANqn2PodchOI4yOJXfkJsOlCV1B7SCx91dAYLnQLRWVJXR7cPODT2dkLT2qUNT9
         Ff1bXidAdpGu79kOepCfX/23iUvOFfGJ0J5D+zVVzAbxGp8BAaCpy4ynnfPOiiabXlBy
         RwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1WK1rP0IIeWr/BJdJ/UTl33KsmBQDurIb/QwB197bY=;
        b=I+fHBIemtMTlq8CARaFV45WPmLkvXUjZhrGQPeLMWVI18NHOPz4T2jmF3q634ztZs6
         ptoxqYe2HB1v9NAk26HKFVDriJjAeP3Ls2LIxZXyvR8iLkNrqEFAgV+WxhrF3GaSd71p
         PTApfA6nuWsoMQ92hnncNJIePFC8/6YHwmcRyZWL4FokXiigD9WF+OwG+o5O67R2fh3Q
         XYkGilmoMOx0HOPCH8Nhn9QQMbv+CVHgi/iiwpVM6QcZrpbX58M19pQGFSmkSUsPg97c
         JJb/JLhlkJbiFaGt2toZrH0QVGVPLC0IKBzHTtQrHy/E7tEwbM25FgES25WdH6OycNY6
         iGDA==
X-Gm-Message-State: APjAAAVuLlpp2MSeGcflsLqSMnCUdg+CpUyviKhb6ra281Lua31loj2l
        wt+ui2D/EKegNF5oCsZ9FZXyYJYWR+TxhG5Jeqld7g==
X-Google-Smtp-Source: APXvYqxHnCrIkZ5pMASvKhRwNn0+PvS0UK+quWgsmvBiVODEG8kIQIUe1tQlEEIN5WrP7yEw0Th+MyETD1WEOP3wXj8=
X-Received: by 2002:a05:6830:13ca:: with SMTP id e10mr31482479otq.267.1582340591664;
 Fri, 21 Feb 2020 19:03:11 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com> <e9984c53-7266-c438-87f5-7f5474e3adce@gmail.com>
In-Reply-To: <e9984c53-7266-c438-87f5-7f5474e3adce@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Feb 2020 19:03:04 -0800
Message-ID: <CABPp-BE_ktNmDB43N_qijzYzhXvsK8Fi7TJQ7goHu+MzGvdpBQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 8:26 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 17/02/2020 22:08, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> >
> > Accumulated fixes on the 'master' front have been flushed to 'maint'
> > and a new maintenance release 2.25.1 has been tagged.
> > [...]
> > [Stalled]
> >
> > * pw/advise-rebase-skip (2019-12-06) 9 commits
> >   - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
> >   - rebase: fix advice when a fixup creates an empty commit
> >   - commit: give correct advice for empty commit during a rebase
> >   - commit: encapsulate determine_whence() for sequencer
> >   - commit: use enum value for multiple cherry-picks
> >   - sequencer: write CHERRY_PICK_HEAD for reword and edit
> >   - cherry-pick: check commit error messages
> >   - cherry-pick: add test for `--skip` advice in `git commit`
> >   - t3404: use test_cmp_rev
> >
> >   The mechanism to prevent "git commit" from making an empty commit
> >   or amending during an interrupted cherry-pick was broken during the
> >   rewrite of "git rebase" in C, which has been corrected.
> >
> >   What's the status of this one?
> >   The tip two are still RFC.
>
> The tip "rebase -i: leave CHERRY_PICK_HEAD when there are conflicts"
> needs reworking and can be dropped (cf
> <7e1b92f5-48df-e202-ebcc-5b15987a7d63@gmail.com>). The other RFC patch
> "rebase: fix advice when a fixup creates an empty commit" [1] could do
> with someone commenting on it (I've Cc'd dscho and Elijah). I think the

I'll try to take a look early to middle of next week.

> messages in it could be improved, but if the idea of different messages
> for fixups that make a commit empty is not popular then the rest of the
> series can be simplified by dropping some earlier patches including
> patch 6 which you had some doubts about. (I tired to address those
> <141f95b0-cae0-06f6-2c29-618dc22ae000@gmail.com> but I don't know if I
> convinced you)
>
> Best Wishes
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/20191206160614.631724-9-phillip.wood123@gmail.com/
