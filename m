Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E61C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E3122582
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgLDGiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgLDGiU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:38:20 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDA0C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:37:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so4652533wmd.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieDpUR8OFQupheQWHsstCBtIQ/6wG8t0HH2w3ScwBLc=;
        b=o8J/SPyQHk8IVpqYiw+E5Ne2GZz0inVf5cbWHcEqqLIBS2ZMmJXPagZx8147DXS0uf
         DoLcIYm/Upqx5bEvUXJ5qRYDIKPXH12CMO/w64l56Bt/rvRySXqtS1ccjrOEya/Cnqfc
         /10whV7ZN/ry+SeMyM3d1ABR3yhcqz+E+Lvmf/G7T1w0mNa94uVwsb1asgK1XnU92BZg
         UoR9PSo64ei0pGA8rRFJ9pJP7EgD4hu/QtysrKcyatpVZ4X267wm0MbwDjur6OjqhKyj
         9YIFl8SSQaNGGOvkFHM0xPYbfpieV0qNaa4fXfWLWNGDHHcem9YTdP9q99lNLkIdEnUs
         LSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieDpUR8OFQupheQWHsstCBtIQ/6wG8t0HH2w3ScwBLc=;
        b=et2MIYM/cIn+eKUPXi2ALw269PGRDoVmf8lcgvPZkjuzJxmYJ6IG07KN/GNTjWl6Uw
         a02zLba1zIsbPiQiExsLLjkLUgF/NLUEbfYP+UQF4nXBCLfJGfrD+OdNNFZJPu9UquQJ
         2gkHyGGRXoiygw5tatin0jaJ98a51efEGpEABrd+f27s1xk4dFL0vCwaeMMu8eCIB74t
         CPOB0KFwC/phwBcvqtAHRDe59lEI5AtvQ2kop7GfaCSasRxJB9m9Qe4grGR7mWopOQCU
         SgQf5DovsJixZKCV9WdbTZh9CYR8mLRi161Gb3cvpWTjYFSR+fTfmT3SbhOvsj8plwnH
         GWYQ==
X-Gm-Message-State: AOAM533cjlMTr6Yyn7brUOPN4ZsvBZTsqLLgjEM933aL+A9yU70N7R3E
        4eOa0gTPORJhBk/lPQlGXXexHLnuCdvbOmpREvo=
X-Google-Smtp-Source: ABdhPJz6gH/KYYg+YPa1LA76sPUx1bVeMzJIWSCh9PiHngDDuk1AIQskOZA4JhKOtGidcIXqtjJhzWzymWoG73MVISw=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr2468066wml.48.1607063859095;
 Thu, 03 Dec 2020 22:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
 <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
 <xmqq7dpyix1d.fsf@gitster.c.googlers.com> <xmqqmtyuhemi.fsf@gitster.c.googlers.com>
 <xmqqpn3qfhps.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn3qfhps.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 00:37:28 -0600
Message-ID: <CAMP44s02N9LJxi_eme8+nqEQameKtpNJtTXWDT2q3_EPV09gag@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 8:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>> That would require changing the semantics of --ff-only, so that "git
> >>> pull --no-rebase --ff-only" doesn't make sense (as --ff-only is
> >>> overridden by --no-rebase).
> >>
> >> I do not think such a conclusion follows from "we do not want to use
> >> the 'by default force the --ff-only' when the user chooses between
> >> merge and rebase".  Specifically, I do not agree with "as --ff-only
> >> is overridden" in your statement.
> >
> > Ah, sorry, I mis-read your three lines above.
> > ...
> > And if we introduce a third-way, i.e. "we do not handle the case
> > where you have your own development at all, this is only to maintain
> > pristine copy from your upstream", and repurpose "--ff-only" for
> > that purpose, yes, what you said above does make sense.  At that
> > point, there is no reason to disagree with "as --ff-only is
> > overridden" part of your statement---in your new world, "--ff-only"
> > is redesigned to act that way.
>
> Just to avoid misunderstanding, I only meant to say that the first
> three lines I quoted is internally consistent (unlike the message I
> was responding to, in which I said "I disagree---the conclusion does
> not follow").  It no way means I think such a re-definition of what
> "--ff-only" means is a great design.

Yes, that's what I parsed.

> What we want to see can be done without such backward incompatible
> changes, e.g. declaring the combination of "--ff-only" and
> "--[no-]rebase" incompatible and/or the last one wins, I would say,
> and I suspect Alex's RFC was an attempt to make the first step in
> that direction.

It's debatable whether or not that is "backwards incompatible".

Currently "--no-rebase --ff-only" fails if the merge is
non-fast-forward. With the proposed change of semantics it would work.
That's a change.

> What is most missing in the current system is a fix for the way in
> which "--rebase" interacts with "--ff-only".  Immediately after
> fetching, if our current branch is not a subset of what we fetched
> from the other side, the command should die.  Otherwise, it should
> just rebase what we have (which is nothing) on top of the tip of the
> history of the other side (which is to fast-forward our tip and the
> working tree to their tip).

Keep in mind the whole point of the changes: to make --ff-only the
default. If you make "git pull --rebase --ff-only" fail if
not-fast-forward, then "git pull --rebase" will fail if you make
--ff-only the default.

I don't know if I'm not doing a good job of stating that --rebase
should override (and ignore) --ff-only, that's the way it should
interact.

Here it goes again. In short, this is the target behavior:

* git pull --ff-only # fail unless fast-forward
* git pull --merge --ff-only # ignore --ff-only
* git pull --rebase --ff-only # ignore --ff-only

> Another thing we would want to change is to make the "you must
> choose between rebase and merge" trigger a lot more lazily.  If our
> side does not have our own development and their history is a
> descendent of what we have, the user shouldn't have to choose.  Only
> when the history they have does not fast-forward, we have to abort
> giving the "you must choose between the two" warning message.

Yes, I already sent patches for that [1].

> When the user tells us to do rebase or merge, nothing (except that
> "--ff-only" should prevent the rebase from going forward) should
> have to be changed.

If --ff-only prevents the rebase and the merge from going forward,
then it cannot be the default.

Maybe my last patch series can make things clearer [2].

Cheers.

[1] https://lore.kernel.org/git/20201204061623.1170745-11-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20201204061623.1170745-1-felipe.contreras@gmail.com/T/

-- 
Felipe Contreras
