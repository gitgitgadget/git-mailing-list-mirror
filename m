Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ABAC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 05:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F062221883
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 05:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk0UhljZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFRFDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgFRFDW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 01:03:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF8CC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 22:03:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so3940444oix.11
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 22:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIDh4J+zTlSxePzOWp66aw0kp0VQetdJJAopqYlkrnc=;
        b=sk0UhljZUy/GbZrMH6kwfJ0yBWDcWUSyR+mqQ1qG6Quwt58GRqMcZVz+6kFk2OWfZj
         pjWGnq2VrYa2ZfacWe1aQxRf01+Z6Yht0d9VjYWmRz5ksGw2wApkkzt55A/d5I/macWN
         EMND5W88PLbUpjpnMxog7sRUN30t4UWPpBWicLUHQW3aexAmoFcsqzw/Xa4YMkjUOLaF
         r0kF9A+Ayhx552Wvb7SR0gnZzTQ4BaA/J4UdRQFdwmh2WtuxUz2JCeXhhYgU4IaQ6JFM
         CiLFhKzb4hBqAxalo8TkRcDWkw6vaQ9VR+PR0y7RI3rFEXHmzxY/nBLLABRAysau5ULO
         m3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIDh4J+zTlSxePzOWp66aw0kp0VQetdJJAopqYlkrnc=;
        b=OcpH5Nyppw5Q4dCkhv2Tttr9vgcZA5B1fX6g2JmUiERXYvm/4seHDjFbLIyqmoV7z+
         0z6Ua0DoBoanRW2h1H76yMliknAJ6Rut78T2qoD7l/FGSZP5pRoIW2/Fs+LjhjnZX3vo
         g86eG063js48EdNRqGaY6UKnwphXBra6c3Wnxdmf2A+/A8MVLywV/yXhecfGzAgS6gx+
         iH8aovYkU8HgJ2oICDOwj7+Rxx3KN/krBxBwmLkG7/UUUqfL8778FkixEjtXNGDnFnz7
         G1q8AP0ysWl1fd/B7i3otYWutlOJLlXBXM21io2u4JpdEMuFaAMoo1yBTc0Qet1MrksW
         hDJg==
X-Gm-Message-State: AOAM533OARbB48Mcbgp7kZdgpzPtr6dl91mprZGWj2mHtdUxE5uLGXOT
        dh/SR52G2niSz/VzH+Tx4x26NMaPCyXjXyA7iQ0=
X-Google-Smtp-Source: ABdhPJzglgCXc40cKH+SxqWcyveX2n5yURw6wQgxF6GjEwIyodSn4Xa3jiLhZw8vLQXqiH9DceGOvlNZML67x8YxRsk=
X-Received: by 2002:aca:2b0d:: with SMTP id i13mr1671714oik.39.1592456600830;
 Wed, 17 Jun 2020 22:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <CABPp-BET86K_N5_W1pXMWeFccbUdxU8+vNvi+m-i6PX0MrXknw@mail.gmail.com>
 <64d477b6-7bf2-fa0d-b9b4-821285af386e@gmail.com> <CABPp-BFDcM+QSx_YSAAazkN9AoTPWVYV+ZpSQBPTihVM=gP-qw@mail.gmail.com>
 <2ee11a3c-9785-fa29-afa4-9eeac2248972@gmail.com>
In-Reply-To: <2ee11a3c-9785-fa29-afa4-9eeac2248972@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 22:03:09 -0700
Message-ID: <CABPp-BHqPqEyf_US9GXB1bqC_ks0Xt5xLcDAwdKE=GhC6CAHZw@mail.gmail.com>
Subject: Re: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 8:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/17/2020 9:59 PM, Elijah Newren wrote:
> > On Wed, Jun 17, 2020 at 6:42 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 6/17/2020 7:14 PM, Elijah Newren wrote:
> >> You mentioned in another thread that it is a bit unwieldy for a user
> >> to rely on a committed (or staged?) file, so adding the ability to
> >> check the working directory first is interesting. I wonder how the
> >> timing comes into play when changing HEAD to a new commit? Seems
> >> tricky, but solvable.
> >
> > Isn't that essentially the same timing issue that comes into play if
> > you only look at the index, and are changing HEAD to a new commit?
>
> It adds to the complexity. We can inspect the new index for the
> in-tree definition and update the skip-worktree bits before actually
> changing the working directory to match the new index. However, if
> we trust the working directory copy over the index copy, then we
> need to also decide if the working directory copy _would_ change
> in this move before using it.
>
> Of course, maybe I'm making it over-complicated. I still know so
> little about the index. I got into this feature due to a simple
> pattern-matching problem that I could understand, but now I'm
> getting lost in index states and dirty statuses. ;)

Honestly, I think your first cut for switching branches with this new
feature should just be:
  1) Do a switch/checkout exactly the way it's done today already:
    1a) Load the index and existing sparsity rules (from worktree then
index), according to what existed before the branch switch
    1b) Do the appropriate 1-way or 2-way merge from unpack_trees() to
move to the right branch (as builtin/checkout.c already does)
  2) *If* using in-tree sparsity feature, re-load the sparsity rules
(from worktree then index) and run the equivalent of `sparse-checkout
reapply`

Not only does this avoid messing up any code for the normal case, I'm
pretty sure this gets the behavior the user expects in all the special
cases.  There is one big downside, and a little downside.  The big
downside is that it'll have two progress meters instead of just one
(much like sparse-checkout init && sparse-checkout set do today).  The
little downside is that this isn't optimal from a performance
standpoint, for two reasons:
(a) some files may be updated in the working tree in step 1b despite
the fact that they'll be removed in step 2.
(b) step 2 may just be an expensive no-op, in fact I suspect it will
be most the time

The reason I think the performance isn't a big deal is because:
C) the fact that (b) is a problem means (a) is not often an issue --
the sparsity patterns are usually the same.
D) Even if the sparsity patterns differ, it's often the case that
files within the tree won't change (people tend to only modify a few
files per commit, after all, so even switching branches only updates a
subset of all files).
E) Even if the sparsity patterns differ and files differ and have to
be updated, it's still proportional at most to the number of files
selected by the sparsity patterns, so it won't feel excessive or slow
to the user.
F) `sparse-checkout reapply` is pretty cheap, especially if called as
a function instead of as a subprocess


In my opinion, other than the unfortunate dual progress meters, the
only place where this new feature gets hairy is that `git
sparse-checkout reapply` (or its libified variant) now needs to know
how to "read your new form of sparsity rules".  That sounds easy at
first but in my opinion it is a bit of a mess.  The user could have
written garbage to the file and I don't know what to do with garbage,
but I think we have to do something sane.  (Give up and checkout
everything?  Give up and checkout nothing but the toplevel directory?
Ignore each line we don't understand and treat the rest as stuff that
needs to be checked out?  Can that last one even be done with the .ini
reader?)  I don't think saying "well, tough luck the user should know
better" works because we already know that merges or rebases or
checkout -m could have written garbage to those files (in the form of
conflict markers), and users will say that *we* were the ones that
filled the file with garbage.  So we have to handle it intelligently
in some fashion.

Thoughts?
