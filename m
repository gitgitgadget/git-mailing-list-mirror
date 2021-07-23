Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F02C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6B460E8F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGWTaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWTaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:30:23 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BB4C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:10:55 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id y11-20020a4ade0b0000b029024b4146e2f5so670473oot.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVY7Twu87kwaWMalBkhYj1fLYXk6gpw0vJXcNdmH8Rs=;
        b=o+WHO7chMXjf00vqZdHTCGFh3r+KgUatUmZh+kXOnr3KxSpb7z9kOcOa7MgJJTbT7Y
         Qsu4PkdoP1lzHUSvI5Qpua87HIbj6Ng0/jAJp3kyNS2WuL0SS9dgIQnNvfizhduCLSks
         Sv0Abw3I7TOjEy4k0pgHprNRWk0KOTr8aZVT0q7GhVSmk75JHW85cQn5KzzfUjdD6vtn
         sGTlmaca2QCNRoibkersxQb1/YZC2TB6FeQzqU92l6V0f0bzKIIqa/TBgTVldtlKK607
         3sm0RCNp4y+0EPSLKT23aoBdurkJr+lPY+bwXO2A/2LU/C20kYM5RSw8Ej4radS7kEa5
         wwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVY7Twu87kwaWMalBkhYj1fLYXk6gpw0vJXcNdmH8Rs=;
        b=Jh6AWbSlY9X+hZzptURnuVLbzyshYeuR1bJqTJPbBY6Y6r7OTXoK2i/qni8nT451us
         DStnBzBLQIEUuUOiB7wcCHWjn+uy5R+3QHvGJHshx5aU2sUfhXuwDovuk7RXSey0Zgm/
         sHTKkeCRruQU7y719rIeU8zPApwyyke95GEPeWt/9OOW7g3nQAaNtPViyURd1xTNft1N
         onABPqLmwGOC5Cm9pQOVZjerbApPmT7IdCbGIvfKNY8jTssDFvU3SJ6kO4cFGNgG7+pV
         1WD/Kysb985dYaMVZvqKnJ9jKTDf8tpnxA3lPJurj3QZn5/lvydZ/NfV7hzO14a8Wope
         AjRA==
X-Gm-Message-State: AOAM533feBq7o/14/R/yTntVQGzPcMIYPZ2cwA9K9VgddvjszXBjyDWb
        bYml4eWG6K3o9/M+SCUR8GiZqdVtAb587yjG3IU=
X-Google-Smtp-Source: ABdhPJym12cHj/NePPLoAyj0JpLcozjSdqfsCXgKmrkybFy4RbR1q5cnspCRbrt2aYPkEQ/XLoik57u9BdEap67oCnk=
X-Received: by 2002:a4a:a385:: with SMTP id s5mr3718735ool.7.1627071054630;
 Fri, 23 Jul 2021 13:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com> <CABPp-BGBwbV7x8i=OVbPnMgWcfdLrEh3-yUi=Amw+XBwpf7A6Q@mail.gmail.com>
In-Reply-To: <CABPp-BGBwbV7x8i=OVbPnMgWcfdLrEh3-yUi=Amw+XBwpf7A6Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 13:10:43 -0700
Message-ID: <CABPp-BFMZwUOJgHDWHuHQ6LXt9HvC8WFJKn=duVFtvB=EXy0fQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Sparse Index: Integrate with 'git add'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 5:51 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi,
>
> I haven't read the series yet (I'm going to try to read them all
> today), but wanted to comment on a couple things in your cover
> letter...
>
> On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > This patch series re-submits the 'git add' integration with sparse-index.
> > The performance gains are the same as before.
> >
> > It is based on ds/commit-and-checkout-with-sparse-index.
> >
> > This series was delayed from its initial submission for a couple reasons.
> >
> > The first was because it was colliding with some changes in
> > mt/add-rm-in-sparse-checkout, so now we are far enough along that that
> > branch is in our history and we can work forwards.
> >
> > The other concern was about how 'git add ' should respond when a path
> > outside of the sparse-checkout cone exists. One recommendation (that I am
> > failing to find a link to the message, sorry) was to disallow adding files
> > that would become index entries with SKIP_WORKTREE on. However, as I worked
>
> I think the recommendation was:
>   * Permitted: running git add on tracked files with the SKIP_WORKTREE
> bit *clear*
>   * Disallowed: running git add on tracked files with the
> SKIP_WORKTREE bit *set*
>   * Disallowed: running git add on untracked files that would become
> index entries with the SKIP_WORKTREE bit set
>
> where the latter two exit with an error message that suggests changing
> the sparsity specification first.  I think this is what has existed
> for some time, other than Matheus adding some error messages to help
> the user when their add command doesn't match anything otherwise.
>
> > towards that goal I found that change would cause problems for a realistic
> > scenario: merge conflicts outside of the sparse-checkout cone.
>
> ...which wouldn't be a problem because these are tracked files whose
> SKIP_WORKTREE bit was cleared by the merge machinery (when it marked
> them as conflicted and wrote them to the working tree).
>
> > The first patch of this series adds tests that create merge conflicts
> > outside of the sparse cone and then presents different ways a user could
> > resolve the situation. We want all of them to be feasible, and this
> > includes:
> >
> >  1. Reverting the file to a known version in history.
> >  2. Adding the file with its contents on disk.
> >  3. Moving the file to a new location in the sparse directory.
> >
> > Without maintaining the behavior of adding files outside of the
> > sparse-checkout cone, we risk confusing users who get into this state. The
> > only workaround they would have is to modify their sparse-checkout
> > definition which might lead to expanding much more data than they need to
> > resolve the conflicts.
> >
> > For that reason, I stopped trying to limit 'git add' to be within the cone.
> > I'm open to suggestions here, but we need an approach that works for
> > out-of-cone conflicts.
>
> I believe my above suggestion works for out-of-cone conflicts.  Some
> important other details to keep in mind in regards to how we make add
> behave:
>
> * We don't want "git add -A [GLOB_OR_DIRECTORY]" to accidentally be
> treated as a directive to remove files from the repository (and
> naively noticing that SKIP_WORKTREE files are missing but attempting
> to operate on them anyway would give this problematic result).
> * We don't want "git rm [GLOB_OR_DIRECTORY]" to nuke SKIP_WORKTREE
> files; it should only operate on files that are present.
> * We need add and rm to be consistent with each other in terms of how
> SKIP_WORKTREE files and the sparsity cone are treated
>
> and more generally about not-SKIP_WORKTREE-despite-not-matching-sparsity-paths:
>
> * These files that aren't SKIP_WORKTREE but normally would be are
> prone to "disappear" at some random later time after they are made to
> match the index.  The disappearing can happen either with an explicit
> "git sparse-checkout reapply" (which is fine since it was explicit) or
> as a side-effect of various other commands that run through
> unpack_trees() since it attempts to heed the sparsity rules.  Users
> tend to get confused by the latter case; they'll understand at some
> point that it was because the file was outside the sparsity paths, but
> the randomness in when it's pulled out as a side-effect of other
> commands can be slightly jarring.  So, I'd like to avoid that where we
> can easily do so, which I think the recommendation above does.  (As a
> side note to these kinds of cases, maybe we want to consider having
> the sparsification logic in unpack_trees() first check whether paths
> being removed from the working tree and having their SKIP_WORKTREE bit
> set not only match the index but also match HEAD?  That'd be a bit
> more expensive to check in the sparsification paths, and I'm not sure
> they all have the relevant information, but it's an idea...)
>
> > The one place I did continue to update is 'git add --refresh ' to match the
> > behavior added by mt/add-rm-in-sparse-checkout which outputs an error
> > message. This happens even when the file exists in the working directory,
> > but that seems appropriate enough.

I've read through the patches now.  They look pretty good, and the
performance improvements are definitely appealing.

My comments on patch 1/5 probably reflect the differences in proposed
paths between your cover letter and my proposal.  My comments on patch
3/5 point out that the current behavior matches neither your
description in your cover letter (or my understanding thereof), nor
mine in my earlier response.  However, it also suggests that the
differences between my proposal and the code isn't due to your series
but a pre-existing issue, and thus wouldn't necessarily need to hold
your series up.

My comments on patch 2/5, asking about why you removed a hunk are thus
the biggest outstanding item for the series to move forward.

It would be nice for us to figure out and agree on the end goal for
add/rm/mv behavior, though.
