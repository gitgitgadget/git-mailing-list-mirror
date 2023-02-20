Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D23C05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 06:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBTGB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 01:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBTGB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 01:01:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011826EA8
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 22:01:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id en26so6987258edb.13
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 22:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDRRBkQWCBE4ySQoMo9VYLy0WipnpH8uSizMDdfHuO8=;
        b=CcMOH0CuDEaLHpaJZZg4JDfpCE+1vIdbDo4jUTCmc6eJ6DSMp54ANg8IRYWvQYgENC
         hCKvF8j5wgYEDxToJ3oMn6z8hdhSTA5Cl/9SGIcKyKolIx4B1AqtnBHJ293yEKrsdlEg
         9sZy+i1RWN70zarX3l8xCBdg/SwKKADxByiGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDRRBkQWCBE4ySQoMo9VYLy0WipnpH8uSizMDdfHuO8=;
        b=rAcBnOWZQcq1uOIyKcEESWCZxzQO90U/3+0yIui7hqlEUZOQs8sNBSYVHiUjWRhCmt
         SbsIJKVjQ+5nIplcncg1tcNj2Lc1RGZ1uku/lhhf9qVfP6saKJ347HKKOSpjI1eJZbrZ
         8BBFrn1pfY82SeTQLrdww5jAExuUiMdQkzQ3fx9DZvBG0JFd1DoyORH2e0wxdsBcLll8
         4kFO/UuW3kCbwRyhdQJH8CRIHPOhAVWJbKvMlLIfMfO+ZPjEKraEM8c0Mk5lssbG4tkq
         a1FEmRxjYBOPJ3JqrPNcKObIzbOX2Tr7mG/DGiRujzMoDaOGJ1hc37/MMO/8XMd4w/3+
         DMUQ==
X-Gm-Message-State: AO0yUKVepA0BxDy6wO+1yiuufTcnPHIELQ9ZK/4DP9y8Pbxztjbr2g02
        5Rdo3htnYy/8y8b6PNaxxg8saelTcp++SE3iJkilQQ==
X-Google-Smtp-Source: AK7set/pQbKye2UxQ5SMVh14iSnascuA+fUmtV7XtQTLPkW7Np5wheaJR0EWx5J95DYT28FMU8xI0mmQLbZ1+5Z4S88=
X-Received: by 2002:a17:906:fa92:b0:8ae:b14b:4b9e with SMTP id
 lt18-20020a170906fa9200b008aeb14b4b9emr3582461ejb.9.1676872884456; Sun, 19
 Feb 2023 22:01:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com> <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
In-Reply-To: <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 20 Feb 2023 07:01:14 +0100
Message-ID: <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Elijah Newren <newren@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2023 at 4:17 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Feb 16, 2023 at 8:02 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >
> > On Thu, Feb 16, 2023 at 5:31 AM Tao Klerks <tao@klerks.biz> wrote:
> > >
> > > If there's an appetite for it, I would love to contribute to a
> > > multi-year adventure to change git's behavior, little by little, until
> > > the behavior of "rebase=merges" is the default, and the old behavior
> > > becomes a different option like
> > > "rebase=copy-merged-commits-to-flatten"
> >
> > I know you had a lot to say in your last email, but I'd like to focus
> > on this point. I would be OK with the proposed patch if it were part
> > of a larger effort to make --rebase-merges the default behavior of
> > `git rebase`. That seems like an achievable goal, and I don't think it
> > would take multiple years, maybe one year at the most. The process
> > would look something like this:
> >
<SNIP>
> >
> > Does that sound reasonable? I think I could lend a hand with steps 1-3.
>
> One concern I have is that "--rebase-merges" itself has negative user
> surprises in store.  In particular, "--rebase-merges", despite its
> name, does not rebase merges.  It uses the existing author & commit
> message info, but otherwise just discards the existing merge and
> creates a new one.  Any information it contained about fixing
> conflicts, or making adjustments to make the two branches work
> together, is summarily and silently discarded.
>
> My personal opinion would be adding such a capability should be step
> 2.5 in your list, though I suspect that would make Tao unhappy (it's a
> non-trivial amount of work, unlike the other steps in your list).

I apologize for my ignorance here, but I'm not sure how this "does not
rebase merges" concern overlaps with the "pull.rebase" context I'm
most specifically concerned about.

I would have assumed that when merge commits are "dropped", as results
from the current "pull.rebase=true" option in the pull conflict
advice, any merge resolution information is *also* dropped - so there
is no loss to the user here in advising the use of
"pull.rebase=merges" instead.

Is your concern about the "pull.rebase=merges" advice change, or more
about the broader "let's encourage users to more explicitly choose
between traditional merge-dropping rebase and rebase-merges" change
Alex is advocating for as a precondition to "my" change :) ?
