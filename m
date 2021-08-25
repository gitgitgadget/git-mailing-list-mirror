Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21EC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540476109E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbhHYPnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbhHYPnH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 11:43:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4480C0617AE
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:42:21 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t35so13992160oiw.9
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8BUXOlGogqy3SZJ10b2+5yzt2u+iCuk2/1CtWw8+Oc=;
        b=gfeZieQQJecAIoxlA6tCc8Uv6BJ6ZIlU1gmhAmoKSDVoj8SVJfvWbX24KuQByUhqqW
         vx47gMrZH2lN3e/YITM2zsc6Ce12/uZ8JMEPeVblO4IlBnuposmCBXAKhKLXFI/6hBpv
         G/7GN8JFXPLVbY+8uhjPIneknFja+r8IuXI+G9kZn4ROdE6eTdIIJK1UDprFJ2DsuQqb
         IISAMvq7eVFDizb8GwTOiZtyk1YkV2VzHQpkj/PWJi+IiLLtzhShWSlU6rPNx/g04xzL
         wpmNV9CJ4Hli9/OZ9QOZYGQSKgtUBrE2+QKyunNMpAw1JtCxEj1ApBd3pYsyAlYu2e6n
         4L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8BUXOlGogqy3SZJ10b2+5yzt2u+iCuk2/1CtWw8+Oc=;
        b=eT/U2esc1C86ACvBix9i2FuDj1nlNMCxhNy7223SJtg5OLBrlg42QOFXRZVwHvfUO7
         UlvkpIPWdylsrD/lJIvT1ahFN0E0YxEZuSISvC/xYyL4Ete8u+Js/TNXpEthpUDefU3K
         GarctGWtXGtmdhJAO1lzna8KUbiXd6p8hwkIYTTL7H1Cv/1d7Nga8CATPwV4UlyOP+rJ
         Q8pK9RJRy1V2BPnaZG2vNUq5A1ezJsoWskbXHACEns8gtXbvXNDA/rND2a2OffTIJyfd
         HyZiB/HaH9OlTrAuOQDJ0GFcn4QN/3BLfnPOJ+PoAsrG/SWd+f/LO33jkMDTIhueQBjP
         BZqQ==
X-Gm-Message-State: AOAM532xtc+z6vhf2Vu54CH5lWaxgWA5JPYEhv/zQ85mVF+0Wa3Yz+QP
        pFXTW+ndkEbJ/NF5LYAgZyY7ktjGsrNvG/Du4TYy4XzWyfgtNA==
X-Google-Smtp-Source: ABdhPJzKem643k8fJoARLlqFPMBcrc5/jHDqBlPaDh1ivf5YVmeFjkS72HcxhQLWwhUz0jNVKsrOnrfBoYPEF+0AGSQ=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr7279416oib.39.1629906140732;
 Wed, 25 Aug 2021 08:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com> <YSWXSWiDWNU93lhC@coredump.intra.peff.net>
In-Reply-To: <YSWXSWiDWNU93lhC@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Aug 2021 08:42:09 -0700
Message-ID: <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
To:     Jeff King <peff@peff.net>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:09 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 24, 2021 at 09:41:49AM -0700, Yuri wrote:
>
> > In the FreeBSD ports repository I resurrected the directory (that was
> > removed a long time ago) with the command:
> >
> > > $ git checkout {hash}~1 -- math/polymake
> >
> >
> > I made local changes to this directory and called 'git add math/polymake'.
> >
> > Then 'git pull' complained:
> >
> > > $ git pull
> > > error: Your local changes to the following files would be overwritten by
> > merge:
> > >   math/polymake/Makefile math/polymake/distinfo
> > math/polymake/files/patch-Makefile
> > math/polymake/files/patch-support_install.pl math/polymake/pkg-descr
> > math/polymake/pkg-plist
> >
> >
> > No incoming changes affect math/polymake. Nobody has created this directory
> > simultaneously with me. There is no intersection with incoming changes.
> >
> >
> > Why does 'git pull' complain then?
>
> It's hard to say without seeing a full example. The merge machinery is
> supposed to handle this situation (and indeed, in a simple reproduction
> example it does). So presumably it thinks the other side may have
> touched those files for some reason. Perhaps it's confused by rename
> detection?
>
> Is it possible to give us a more complete example, including:
>
>   - a url for the repository
>   - the commit at HEAD when you ran "git checkout"
>   - the {hash} commit from which you rescued the files
>   - the state of the remote branch (i.e., what we attempted to merge
>     with "git pull")
>
> ?

The `git checkout {hash}~1 -- math/polymake` is enough to highlight
that Yuri doesn't just have local changes (which the merge machinery
should allow if the incoming changes don't touch the same files), but
local *staged* changes.  As per the merge manpage:

"""
To avoid recording unrelated changes in the merge commit, git pull and
git merge will also abort if there are any changes registered in the
index relative to the HEAD commit.
"""

While this particular example could theoretically be handled by the
merge machinery without requiring the index match HEAD, at least with
the new ort backend (it'd be way too complex with the recursive
backend, see below), in practice I'm so sick of index != HEAD bugs
that I have zero motivation to even consider it and I might even NAK
patches from others who attempted it.  For why, let me quote from the
commit message of 9822175d2b ("Ensure index matches head before
invoking merge machinery, round N", 2019-08-17), which also references
another commit that I'm tempted to also quote:

"""
Ensure index matches head before invoking merge machinery, round N

This is the bug that just won't die; there always seems to be another
form of it somewhere.  See the commit message of 55f39cf7551b ("merge:
fix misleading pre-merge check documentation", 2018-06-30) for a more
detailed explanation), but in short:

<quick summary>

builtin/merge.c contains this important requirement for merge
strategies:

    ...the index must be in sync with the head commit.  The strategies are
    responsible to ensure this.

This condition is important to enforce because there are two likely
failure cases when the index isn't in sync with the head commit:

  * we silently throw away changes the user had staged before the merge

  * we accidentally (and silently) include changes in the merge that
    were not part of either of the branches/trees being merged

Discarding users' work and mis-merging are both bad outcomes, especially
when done silently, so naturally this rule was stated sternly -- but,
unfortunately totally ignored in practice unless and until actual bugs
were found.  But, fear not: the bugs from this were fixed in commit
  ee6566e8d70d ("[PATCH] Rewrite read-tree", 2005-09-05)
through a rewrite of read-tree (again, commit 55f39cf7551b has a more
detailed explanation of how this affected merge).  And it was fixed
again in commit
  160252f81626 ("git-merge-ours: make sure our index matches HEAD", 2005-11-03)
...and it was fixed again in commit
  3ec62ad9ffba ("merge-octopus: abort if index does not match HEAD", 2016-04-09)
...and again in commit
  65170c07d466 ("merge-recursive: avoid incorporating uncommitted
changes in a merge", 2017-12-21)
...and again in commit
  eddd1a411d93 ("merge-recursive: enforce rule that index matches head
before merging", 2018-06-30)

...with multiple testcases added to the testsuite that could be
enumerated in even more commits.

Then, finally, in a patch in the same series as the last fix above, the
documentation about this requirement was fixed in commit 55f39cf7551b
("merge: fix misleading pre-merge check documentation", 2018-06-30), and
we all lived happily ever after...

</quick summary>

Unfortunately, "ever after" apparently denotes a limited time and it
expired today.
"""

and then the commit message goes on to explain multiple other bugs
found and fixed due to not strictly enforcing that the index needs to
match HEAD before starting a merge.
