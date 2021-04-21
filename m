Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B6C43460
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE6613B6
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbhDUTwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhDUTwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 15:52:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACECDC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:51:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m7so38277249ljp.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fX0JthvcPLmifeMXVMI2YFQ8w5bBK0DVJDZe5jsSzjE=;
        b=k72vAjQOThOHFhwxW0v4tmg2OpYceo+W5gCrU/EIg8k613yZ6l6DmGDMAzv3tpHHw8
         /Oe5DVe+oOliH6ZF7OwO4UD731Gwb6V9v9jznuFDvJSW0XQR/U+zlA23Xw3A2euwk0P4
         VUrYjwA60tRaJtFk/GuUGJ3dUmYstpRZCf5Cr4OznrzMfa5qBBPyoFmm+CP27Q5h8/qW
         LEWuUgdZT+Vb89IE2tm5ofJvJ7XEmJgYKStXmcJmoFYPAAh0H7VM72cxgE5r84U6141w
         9SvIouMeRz1AOBNG54irncUy7+Fm3rN+rnFQlyai1xdKPDO3tKTPoE2viHJTROjdvS6e
         Sa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fX0JthvcPLmifeMXVMI2YFQ8w5bBK0DVJDZe5jsSzjE=;
        b=ipfQDxR8rwZ6Jnq9gl0E57EdqcsrrHqIoalBzDf0PT6+E7mBw76dsP42KDjoA8eV1o
         MA+6KrJpfZ074iEplbz+XozuvDmEPA89U3cXRyMI5ttoUSu3Y6h5SBIHX/j7SlUYB9l4
         N9FctyOuCkikmrMbJefhc0uQ4w2rnCHRIsmGpJa4K4dbausrX3S7QtQGxHrOBwqEP391
         b/91HfaYi9yrmDzbVTSgqrD8BOZJBAuaCIaCMPeum4lKBBquM1t5YXrKZaFD/ceqROmB
         6CRZ40ISX69SfchChIcvT7Jnn6gO7vhCsZwMpzpYJRs6MthxYjzWIIHUgR5UcnCF6PUu
         f6/A==
X-Gm-Message-State: AOAM530F1RqRdYIgpOeEBIiAWo8so2LbnfCGKT3vbtP/KYEl4On7YUBS
        QEfUIFvvmnmwng6VaK7DT4PKzjGePqts+M4Lb24CGfo+9FOOwA==
X-Google-Smtp-Source: ABdhPJxsPZDaaz5RImnROLbB5+tl5CwHmEkPNs4WEfQ3fUzb/B+5OnF+uHpNZkcJKz59pVAyM3YbP/mLnipFjJcVL1Y=
X-Received: by 2002:a2e:9b50:: with SMTP id o16mr20190431ljj.8.1619034716152;
 Wed, 21 Apr 2021 12:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
 <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com> <CAHd-oW76_8D_wu7dixX+2i7-_M3Je=JGk3JonL18yeA5PRrsRg@mail.gmail.com>
 <CABPp-BG5uSUHy6bQ7xEWSQ8VAy0GCqX0P670HfcopZPUwAfQcw@mail.gmail.com>
In-Reply-To: <CABPp-BG5uSUHy6bQ7xEWSQ8VAy0GCqX0P670HfcopZPUwAfQcw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 21 Apr 2021 16:51:45 -0300
Message-ID: <CAHd-oW4xm_Uis6yCNtCJZ9qm7a6Oy4ty-05E1VPYGZvvXqaRwg@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 4:11 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Apr 21, 2021 at 11:55 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > On Wed, Apr 21, 2021 at 2:27 PM Derrick Stolee <stolee@gmail.com> wrote:
> > >
> > > On 4/20/2021 7:00 PM, Elijah Newren wrote:
> > > > On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> > > > <gitgitgadget@gmail.com> wrote:
> > >
> > > >> diff --git a/read-cache.c b/read-cache.c
> > > >> index 29ffa9ac5db9..6308234b4838 100644
> > > >> --- a/read-cache.c
> > > >> +++ b/read-cache.c
> > > >> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> > > >>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
> > > >>                         continue;
> > > >>
> > > >> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> > > >> +                       continue;
> > > >> +
> > > >
> > > > I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> > > > !ignore_skip_worktree and why it'd be desirable to refresh
> > > > skip-worktree entries.  However, this is tangential to your patch and
> > > > has apparently been around since 2009 (in particular, from 56cac48c35
> > > > ("ie_match_stat(): do not ignore skip-worktree bit with
> > > > CE_MATCH_IGNORE_VALID", 2009-12-14)).
> > >
> > > I did some more digging on this part here. There has been movement in
> > > this space!
> > >
> > > The thing that triggers this ignore_skip_worktree variable inside
> > > refresh_index() is now the REFRESH_IGNORE_SKIP_WORKTREE flag which was
> > > introduced recently and is set only by builtin/add.c:refresh(), by
> > > Matheus: a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
> > > 2021-04-08).
> > >
> > > This means that we can (for now) keep the behavior the same by adding
> > >
> > >         if (ignore_skip_worktree)
> > >                 ensure_full_index(istate);
> > >
> > > before the loop.
> >
> > Hmm, I don't think we need to expand the index here.
> > ignore_skip_worktree makes the loop below ignore entries with the
> > skip_worktree bit set. Since sparse dirs also have this bit set, we
> > will already get the behavior we want :)
> >
> > However, I think we will need to expand the index at
> > `find_pathspecs_matching_against_index()` in order to find and warn
> > about the pathspecs that have matches among skip_worktree entries...
> >
> > > This prevents the expansion during 'git status', but
> > > requires modification before we are ready for 'git add' to work
> > > correctly. Specifically, 'git add' currently warns only when adding
> > > something that exactly matches a tracked file with SKIP_WORKTREE. It
> > > does _not_ warn when adding something that is untracked but would have
> > > the SKIP_WORKTREE bit if it was tracked. We will need to add that
> > > extra warning if we want to avoid expanding during 'git add'.
> >
> > Hmm, I see :( I was trying to think if it would be possible to do the
> > pathspec matching (for the warning) without having to expand the
> > index, but then there are the untracked files... If the user gives
> > "a/*/c" and we have "a/b/" as a sparse dir, we don't know if "a/b/c"
> > is a skip_worktree entry or an untracked file without expanding the
> > index...
>
> I thought Stolee's series added something that could allow us to check
> that e.g. "a/b/c" corresponded to an entry under the sparse directory
> "a/b/" and thus is a would-be-sparse entry.  Can we use that?

Yes, you mean for the warning on untracked paths that would become
sparse entries, right? The problem I was considering there was the
warning on tracked entries only, in which case I'm not sure if it
would help.

> > > Alternatively, we can decide to change the behavior here and send an
> > > error() and return failure if they try to add something that would
> > > live within a sparse-directory entry.
> >
> > I think this behavior would be tricky to replicate on non-sparse-index
> > sparse-checkouts, if we were to do that. We would have to pathspec
> > match each untracked file against the sparsity patterns, perhaps?
>
> By way of analogy, don't we have to pay the cost of pathspec matching
> each tree entry against the sparsity patterns when doing a checkout
> before putting those entries into the index?  Since "git add" is
> trying to put new entries into the index, doesn't it make sense for it
> to pay the same cost for the untracked paths it is about to place
> there?
>
> Sure, that can be expensive for non-cone mode, but that's the price
> users pay for using sparse-checkouts and not using cone mode, and they
> pay it every time they try to update the index with some new checkout.
> I think "git add" should be treated similarly as another way to update
> the index -- especially since users will get confused (and have gotten
> confused) by subsequent commands if we don't do those checks.

Good point. Yeah, that all makes sense :)
