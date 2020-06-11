Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4150AC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ADF206F7
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu1V9dIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgFKAgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgFKAgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:36:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B3C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:36:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x202so3854759oix.11
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PH2hhVYJi3UkvV1vkt8DEigJ2wX3EQXZc5SJpBYncc8=;
        b=Qu1V9dIb1hv1IaP1CyE8LXg9v3xOcYVctducf6bnxWvrx3V2VQd3JQQzMyBsfWfwya
         I3PmbKfSEDoH0wX1qoA1VSrvi+Fw4YApwKzVUGUjXFtCBcF4V97g8dCFgnVqNBQAAJAF
         sFgBC5snNDSs3OpvJb2pYP3iy52GPnEeodOVxL/e1v7YcejofTcboaQBEIma/I4VR4yf
         FLdN/4+lOVXtkUzojEvBuehS2kMHG3py8p4weUKk9JJtbkFtCSfR+iuqpTtKYzMnZl79
         EI7zHxG/LJH/4+iz+DZ1HMnuyytyJI95+xA8/LjDRTffpjNWMEFtfkJxDf8vAGYITdCh
         Hmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PH2hhVYJi3UkvV1vkt8DEigJ2wX3EQXZc5SJpBYncc8=;
        b=OIWA1PfCe3Utgb2Cf7sPfqydSsNQ69rUnYdtg1IoPk5OZ7pOuAeN9UZHnD7Kj9id7q
         8oOja1udjtmsVOpAxDy67uhqpTnivyJbmyEuWMxhoDQfKafz46Zc7FMlCHc3oXCBmqT/
         LQwbJgwcdQgG0f8BQqdxRk/Rdf3Lvh62pJKFKzOZPNFq1EL5PKZUTbXNTU/cYt+wYaNe
         JShLF7k7prBLtB6dYZB+aAXh/lDFt2QE6YkApx2nTxapkKqNCDXKFWYSL24zE2FBujNb
         r4sU7FDr6gup0+U1OLPubw+1oX/Qt7HmDGvBtT1I+zfcS79fZ4eKQonv3MEpovX3bGbY
         2+sQ==
X-Gm-Message-State: AOAM531clqNvcyF/8HIP8KW9rDKMMtYdJMKBi4LiDCIP3mBmWC0Cy0wy
        qw7AOqRle+Knxdo52gmpTkl21QCQ1GE2+5O5jUU=
X-Google-Smtp-Source: ABdhPJxiru62+G+fXVOjaGsIv6suQSWSJd3mMf+TSiNplEuavk5IFxXDLPrKtXfTx5EW+6LKCpCLYAdqS+5jx8SHei0=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr4396698oic.31.1591835761048;
 Wed, 10 Jun 2020 17:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <748b1e955ccdcf7cd897a180f4b4fe82d7bfcf00.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BHzHhBVGZ+vOgE4jTCT3HJzXo+gzZ+6SVGDUWWdfkL6Dw@mail.gmail.com>
 <CAHd-oW7b41hqfPXm_GL_sth+QRfx56ceMr4VM9B9xhj3_P9iGQ@mail.gmail.com>
 <CABPp-BH0d5WKz7bXLkFQGDBKXbd0tccS_+1_iNc1Wqr93h+KaQ@mail.gmail.com> <CAHd-oW5gqs1uG5L4=JaT6Jzs58StE1WO0goPJE2atumbyC3Wow@mail.gmail.com>
In-Reply-To: <CAHd-oW5gqs1uG5L4=JaT6Jzs58StE1WO0goPJE2atumbyC3Wow@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Jun 2020 17:35:49 -0700
Message-ID: <CABPp-BFJG7uFAZNidDPK2o7eHv-eYBsmcdnVxkOnKcZo7WzmFQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] config: add setting to ignore sparsity patterns in
 some cmds
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Wed, Jun 10, 2020 at 2:15 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Jun 2, 2020 at 11:40 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Sun, May 31, 2020 at 9:46 PM Matheus Tavares Bernardino
> > <matheus.bernardino@usp.br> wrote:
> > >
> >
> > Moving it to grep's manpage seems ideal to me.  grep's behavior should
> > be defined in grep's manual.
> >
> > > sparse.restrictCmds::
> > > See complete definition in linkgit:git-config[1]. In grep, the
> > > restriction takes effect in three cases: with --cached; when a
> > > commit-ish is given; when searching a working tree where some paths
> > > excluded by the sparsity patterns are present (e.g. manually created
> > > paths or not removed submodules).
> >
> > That looks more than a little confusing.  Could this definition be
> > something more like "See base definition in linkgit:git-config[1].
> > grep honors sparse.restrictCmds by limiting searches to the sparsity
> > paths in three cases: when searching the working tree, when searching
> > the index with --cached, or when searching a specified commit"
>
> Yes, this looks better, thanks. I would only add a brief explanation
> on what we mean by limiting the search in the working tree case.

Possibly, but I think it would be easy to go overboard here.

> Since
> the working tree should already contain only the sparse paths (in most
> cases), I think this sentence may sound a little confusing without
> some explanation.

That's an interesting flag.  I'm curious, though, would they be
confused by it, or would it just seem immediately obvious and almost
not worth mentioning?  In other words, would they think "Well, if you
use sparse-checkout to get just a subset of files checked out, it
totally makes sense that grep would be limited in that case.  Why do
they even need to mention it -- just for completeness, I guess?"

And even if not all users think that way, would a large percentage of
users around them think that way and point out the obviousness of the
docs?

If not, maybe we just add a "(obviously)" comment right after "working tree"?

> Even further, some users might expect that `git -c
> sparse.restrictCmds=false grep $pattern` would restore the previous
> behavior of falling back to the cache for non-present entries, which
> is not true.

10 years from now, I don't want our docs to consist of a long
explanation of all the bugs that existed in various ancient versions
of git and how modern behavior differs from each previous iteration.
There are times when it's worth calling out bugs in prior versions to
bring it to the attention of our users, but I don't see how this is
one of them.  The previous behavior was just outright buggy and
inconsistent, and from my viewpoint, was also a regression.  I think
it should have been reverted regardless of your series, though
skip_worktree stuff was dormant and went unused for a really long
time.

Also, this is a special area of git where focusing too much on
backward compatibility might actually be detrimental.  Backward
compatibility is a really good goal to keep in mind in general, but
the SKIP_WORKTREE usability was traditionally really, really bad -- so
much so that outright replacing was contemplated by its author[A], and
we placed a HUGE ALL CAPS DISCLAIMER in the documentation of
sparse-checkout about how users should expect the behavior of commands
to change[B].  So, unlike other areas of git, we should focus on
getting sparse-checkout behavior right more than on bug compatibility
with previous code and long migration stories.  Given the context of
such disclaimers and changes, the idea of trying to document those
changes makes me think that in the not too distant future we would
have the equivalent of the following humorous driving directions from
the era before smartphones: "To get to Joe's place, you turn right on
the first road after where Billy's Barn burned down 5 years ago..."
(when the burned Barn was cleared out 4 years ago and there's no
indication of where it once was)

[A] https://lore.kernel.org/git/CABPp-BGE-m_UFfUt_moXG-YR=ZW8hMzMwraD7fkFV-+sEHw36w@mail.gmail.com/
[B] https://git-scm.com/docs/git-sparse-checkout#_description

> In particular, I would like to emphasize that the use for
> `sparse.restrictCmds=false` in the working tree case, is for
> situations like the one you described in [1]:
>
> * uses sparse-checkout to remove a bunch of files/directories they
> don't care about
> * creates a new file that happens to have the same name as an
> (unfortunately) generically worded filename that exists in the index
> (but is marked SKIP_WORKTREE and had previously been removed)
>
> In this situation, grep would ignore the said file by default, but
> search it with `sparse.restrictCmds=false`.

I think this is such a weird and unusual case that I'm not sure it
merits mentioning in the docs.

But if others disagree and think this case is worth mentioning in the
docs, then it shouldn't just be mentioned in "git grep".  All affected
manpages should be updated to discuss how they handle this obscure
corner case.  For example, `git diff` and `git status` just ignore
these files and do not print out any information about them.  So it's
kind of like these files are ignored...but even `git status --ignored`
won't show anything about such files.

Anyway, I think this is a pretty obscure case whose discussion would
dilute the value of the manual in teaching people the basics of
commands.

> So what do you think of the following:
>
> sparse.restrictCmds::
> See base definition in linkgit:git-config[1]. grep honors
> sparse.restrictCmds by limiting searches to the sparsity paths in
> three cases: when searching the working tree, when searching the index
> with --cached, and when searching a specified commit.

Good up to here.  I think I'd like to use just this text as-is (or
maybe with the "(obviously)" addition) and then see if we get feedback
that we need clarifications, because I'm worried our attempts at
clarifying might backfire.  For example...

> Note: when this
> option is set to true (default), the working tree search will ignore
> paths that are present despite not matching the sparsity patterns.

You've run into the same problem Stolee and I did by trying to provide
details about one case, but overlooking others.  ;-)  This "Note:"
statement is not correct; there's a couple cases it gets wrong:

merge/rebase/cherry-pick can unset the SKIP_WORKTREE bit even for
paths that do not match the sparsity patterns in order to be able to
materialize a file and show conflicts.  In fact, they are allowed to
unset the bit for other files and materialize them too (see
https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/).
Such paths, despite not matching the sparsity patterns, will not have
the SKIP_WORKTREE bit set.  And it is the SKIP_WORKTREE bit, rather
than the sparsity patterns, that git-grep uses for deciding which
files in the working tree to search.

Also, if someone runs sparse-checkout init/set, and sparse-checkout
would normally remove some file but notices that the file has local
modifications, then sparse-checkout will avoid removing the file AND
will avoid setting the SKIP_WORKTREE bit on that file.  See commit
681c637b4a ("unpack-trees: failure to set SKIP_WORKTREE bits always
just a warning", 2020-03-27)

> This can happen, for example, if you create a new file in a path that
> was previously removed by git-sparse-checkout.

This is that obscure corner case discussed above.

> Or if you don't
> deinitialize a submodule that is excluded by the sparsity patterns
> (thus remaining in the working copy, anyway).

This case requires more thought.  If a submodule doesn't match the
sparsity patterns, we already said elsewhere that sparse-checkout
should not remove the submodule (since doing so would risk data loss).
But do we set the SKIP_WORKTREE bit for it?  Generally,
sparse-checkout avoids removing files with modifications, and if it
doesn't remove them it also doesn't set the SKIP_WORKTREE bit.  For
consistency, should sparse-checkout not set SKIP_WORKTREE for
initialized submodules?

If we don't set the SKIP_WORKTREE bit for initialized submodules, then
we don't actually have a second different case to mention here.

Granted, that's more an issue for `sparse-checkout` than `grep`.


Hope that all helps.  Let me know if it doesn't, if you disagree with
any parts, or some parts aren't clear.
Elijah
