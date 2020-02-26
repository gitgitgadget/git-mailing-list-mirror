Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E5FC4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2137A24653
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDOTk1Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgBZUEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:04:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36834 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBZUEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:04:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so834121oic.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fZiRr119lRw0u4rOPtgLjMSrq1YWRMuL6mwypptCLc=;
        b=MDOTk1MzpYUTIIv6hQz9N9MssCv4ZnpjcW2Et4jNaJtzEXK9zFOqrog76M2umYLch+
         14/CGSD0GW1hIpIJGgOmBqnfgCnUwCxXciAE1qu3SPATbI9PRYW46oHoCTSEWKoWT12N
         PPK2fPbJGdO/jQCrA6qoq7IY4h89JbR68TPLJwuy7jMw3Xl/7S3ZeauzHiW+HXRX/AoB
         jknjpLk92oniL7dWfp+Xbjd5kbjig+pMwDFzdgnayBk6BlH45pxFsY3T5m9hYJe/wAHI
         8kSDaTKPefX9zRQHve1Gesw/L9OE6c4+6TsySqkYQ/67VlIiGzUU8UFAS+HqIyCfJkfK
         zenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fZiRr119lRw0u4rOPtgLjMSrq1YWRMuL6mwypptCLc=;
        b=LsUJh9DGJR7m58ORxVphCb9+ixRT2H+1eA6JW0Tq1/b7RcA4QfXtpWX2ATJ5npfZ8t
         Scmpy/G/Ju0UYsZGNK9PJbjhI6UEK0uCFb5JeQIxIJHqn55gzpMenDUB/2EEaBBmeV7i
         zO7Wq0YV4sqQuZHe83s/gxfMm/HECjWE95yu94CuprQaxTeKgmZgiOM6fauatzdj1q/5
         n/mQrtyjHkYUJ2nio6+oZg//khHAdXe6H/dBHl1OECDLGYos9/hwdDUn0tc83drsZEAv
         oQ2tn0YpWYWZhjKYK/nOfzGTm0H01WIsNh0zR4AgUkf1xVVshJpXMzor3CFk6oam0CVM
         tYpQ==
X-Gm-Message-State: APjAAAXi6iN324pJhecx0KPh+SEcRQ9tR7KMyZsyo36aVR/sJX3VX/4S
        IbdJMDz1ph1Yko2QHn+zAqdGb/XE6d+clgTIPaI=
X-Google-Smtp-Source: APXvYqzECZqbZlHCV+zGHd88OqcJx8B67+mzgs3UmQGlBvnt6V7dBomBtgQGe4EWbo0XODmtQ/ZoZ+KNpay7kLvHiQw=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr571425oib.6.1582747458950;
 Wed, 26 Feb 2020 12:04:18 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com> <e9984c53-7266-c438-87f5-7f5474e3adce@gmail.com>
 <CABPp-BE_ktNmDB43N_qijzYzhXvsK8Fi7TJQ7goHu+MzGvdpBQ@mail.gmail.com>
In-Reply-To: <CABPp-BE_ktNmDB43N_qijzYzhXvsK8Fi7TJQ7goHu+MzGvdpBQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Feb 2020 12:04:08 -0800
Message-ID: <CABPp-BG_qoGFYhEMAtq0J8ZjS8SxC7WA=FjzWnNpM84CZTSVNw@mail.gmail.com>
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

On Fri, Feb 21, 2020 at 7:03 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Feb 21, 2020 at 8:26 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > On 17/02/2020 22:08, Junio C Hamano wrote:
> > > Here are the topics that have been cooking.  Commits prefixed with
> > > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > > the integration branches, but I am still holding onto them.
> > >
> > > Accumulated fixes on the 'master' front have been flushed to 'maint'
> > > and a new maintenance release 2.25.1 has been tagged.
> > > [...]
> > > [Stalled]
> > >
> > > * pw/advise-rebase-skip (2019-12-06) 9 commits
> > >   - rebase -i: leave CHERRY_PICK_HEAD when there are conflicts
> > >   - rebase: fix advice when a fixup creates an empty commit
> > >   - commit: give correct advice for empty commit during a rebase
> > >   - commit: encapsulate determine_whence() for sequencer
> > >   - commit: use enum value for multiple cherry-picks
> > >   - sequencer: write CHERRY_PICK_HEAD for reword and edit
> > >   - cherry-pick: check commit error messages
> > >   - cherry-pick: add test for `--skip` advice in `git commit`
> > >   - t3404: use test_cmp_rev
> > >
> > >   The mechanism to prevent "git commit" from making an empty commit
> > >   or amending during an interrupted cherry-pick was broken during the
> > >   rewrite of "git rebase" in C, which has been corrected.
> > >
> > >   What's the status of this one?
> > >   The tip two are still RFC.
> >
> > The tip "rebase -i: leave CHERRY_PICK_HEAD when there are conflicts"
> > needs reworking and can be dropped (cf
> > <7e1b92f5-48df-e202-ebcc-5b15987a7d63@gmail.com>). The other RFC patch
> > "rebase: fix advice when a fixup creates an empty commit" [1] could do
> > with someone commenting on it (I've Cc'd dscho and Elijah). I think the
>
> I'll try to take a look early to middle of next week.
>
> > messages in it could be improved, but if the idea of different messages
> > for fixups that make a commit empty is not popular then the rest of the
> > series can be simplified by dropping some earlier patches including
> > patch 6 which you had some doubts about. (I tired to address those
> > <141f95b0-cae0-06f6-2c29-618dc22ae000@gmail.com> but I don't know if I
> > convinced you)

Sorry for the delay.  I can see how different messages might be useful
in the case where a fixup creates an empty commit, but I think it
would need more care since users won't know whether instructions are
referring to the combined changes of the original commit plus the
fixup, or if the instructions about skipping/dropping/whatever are
just referring to the changes from the fixup.  It wasn't clear to me.

Added a few other comments on that patch too.  Most of the patches
earlier in the series looked good to me; I was slightly
concerned/confused initially by patch 6 and part of patch 8 for
similar reasons on the determine_whence stuff.  This was only a minor
concern and I wouldn't hold up the patches over this, but I did I
throw an idea out there as an alternative -- though it might possibly
be worse.  (Nothing like throwing a bad idea out there to get creative
juices flowing, right?)  I skipped patch 9 since you already mentioned
it needs fixes.
