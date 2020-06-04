Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A84C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D2C2074B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8LhVDgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFDH12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgFDH12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:27:28 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E622C05BD1E
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:27:28 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so3994839otr.12
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdtDyJ8MOsk0Cjt16zDQ4OOlJPdI1QvGkHRyqAn8ptg=;
        b=i8LhVDgd8ajUxVOypdF7flZmxj93N3LKlEtZiYEtFMJZ4elUdJCYzKD3IJwOboIr4n
         t+jMnPo2halZnvNNx8ovhS7wxv6IYngeEiE9pKdR0VwU6wH1949HCNtFvEnz3Cuy3iEw
         oP7OQLNqY9HCcaMSbBDTJ1tdDqDPUUilkGQ3AjPxu56XKEZen1Twt2lnYM2CaTDyo3A6
         uFUYldfQHF6RNBKWkRUZvQirlB6fVA/+wedthuqTnKBztru9eJ3h7Oz5nJagGwggIBJh
         Uzw7DJ43Fx8vh/purLZZlTQ1zt2cVYfw1k3SAapMarTybBoIHUoRy0+d6gGSJTXZ/ohY
         0Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdtDyJ8MOsk0Cjt16zDQ4OOlJPdI1QvGkHRyqAn8ptg=;
        b=RczQNUYpCGfHB6wdMF/Yyi8hdvhxIfY7oUB7JDlx5nMbqbboFs/+8DxVByeM1CPbyx
         sfwPsM2EcZXkDCwwElAPfXwKNVZyOWm9tD6dQ3WSIxB7MY6LO0Z/o6QOvImD9oPSfBxn
         BAMS8m5tmnYPSvVA4uSx6axNCxBBAZfwpFQCTVCsQZxkdmfHToEX5xQi1WPD9/ez2hKp
         i6DcNncBeZJQ/dm6Yu3Q14Tp5Aq1T2C9JJx5MH+PktSBvs9S/TVFH1awH5OcLmzA4u3I
         N1/VP0E1Xqd5xJSe9JJuL9+Tfwdzr0AO4Hwopkn6eKSasAA5Kh7FGLT65srwA4TRBKlx
         +eVQ==
X-Gm-Message-State: AOAM531Rc/nfWwfMfd3+G6IJnlkKCUGDJw1R0yoxNXbU1QoPuvUNwHaC
        1hxfftwsMRZG2LhJ17xZohaafm4tw9zC8KOA2WA=
X-Google-Smtp-Source: ABdhPJxOWCMDuBiIwUWearg2dIEDr3zlleoQkuBB+am6825gNTNd2+GW2PSmiXzmDlQPBp8/2tc0J7/SODo4useJ1Vk=
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr2796985otq.345.1591255647222;
 Thu, 04 Jun 2020 00:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
 <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com> <c1f9d76a-bf39-8508-1f4f-b34be77450a0@gmail.com>
In-Reply-To: <c1f9d76a-bf39-8508-1f4f-b34be77450a0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Jun 2020 00:27:15 -0700
Message-ID: <CABPp-BHyDUrOLg6-VONewbmXNFHUvKoDXfRTLgg8aEhJFtJLuQ@mail.gmail.com>
Subject: Re: Possible regression for sparse-checkout in git 2.27.0
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Shaun Case <warmsocks@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jun 3, 2020 at 8:36 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/3/2020 12:37 AM, Elijah Newren wrote:
> > I think it'd be more natural to run
>
> >   git clone --filter=blob:none --sparse
> > https://github.com/r-spacex/launch-timeline.git
>
> > in place of the combination of
>
> >   git clone --filter=blob:none --no-checkout
> > https://github.com/r-spacex/launch-timeline.git
> >   git sparse-checkout init --cone
>
> > since the --sparse flag was added just for this kind of case -- to do
> > a clone but start with only a few things checked out.  It's easier, is
> > the route we're moving towards, and as a bonus also happens to work.
>
> Just one warning: the --sparse option in "git clone" does not currently
> enable core.sparseCheckoutCone, so running "git sparse-checkout init --cone"
> afterwards is a good idea, or else your "git sparse-checkout (set|add)"
> commands will not behave the way you expect.
>
> (I think that I will propose a change in behavior to make it do so during
> this release cycle.)
>
> > A bit of a side note, or a few of them, but this command of yours is broken:
> >   git sparse-checkout set README.md
> > because --cone mode means you are specifying *directories* that should
> > be checked out.  Currently, this gives no error, it instead silently
> > drops you back to non-cone mode, which seems bad to me.
> > sparse-checkout should provide some kind of error -- or at very least
> > a warning -- when you make that mistake.
>
> > Now let's talk about the commit in question that changed behavior
> > here.  The point of sparse-checkout is never to switch branches or
> > checkout new commits; all it does is update which paths are in the
> > current working directory.  A related point to this is it should never
> > add or remove entries from the index and shouldn't change any hashes
> > of files in the index.  It used to violate this, at first via an
> > implementation that was literally invoking `git read-tree -mu HEAD` in
> > a subprocess, and then later using internal code equivalent to
> > invoking that command in a subprocess.  But by violating the
> > leave-index-entries-alone mandate, it left folks who were in the
> > middle of a rebase and wanted to update their sparse-checkout to
> > include some more directories in their working tree in a precarious
> > spot -- if they didn't update, then they didn't have the files
> > necessary to build, and if they did forcibly update via `git read-tree
> > -mu HEAD` then their staged changes would all get wiped out.  I spent
> > some quality time helping users recover their files and teaching them
> > about the git storage model.
> >
> > So that brings us back to your original question.  When you said
> > --no-checkout, it means that there is no commit checked out and the
> > index is empty.  update_sparsity() is correctly toggling the
> > SKIP_WORKTREE bits for the existing index entries that don't match the
> > sparsity patterns, and it is correctly calling check_updates().
> > check_updates() is correctly checking for files currently in the index
> > which have toggled to being needed in the current worktree so that it
> > can issue downloads related to promisor packs.  The problem is just
> > that there aren't any index entries to begin with, so there are no
> > SKIP_WORKTREE bits to update, and thus no files that need to be
> > downloaded.
> >
> > It seems a bit risky to make sparse-checkout start doing
> > checkout/switch behavior and adding entries to the index.  There's a
> > couple ways forward.  One, we could decide this is a special edge or
> > corner case where we allow it: if the index is completely empty, then
> > there's no data to lose and thus we could make `git sparse-checkout
> > init [--cone]` in that one case use the old 'read-tree -mu HEAD'
> > logic.  Alternatively, we could just require users to run 'git reset
> > --hard' at the end of your script.
> >
> > Stolee: Thoughts?
>
> I agree that using "--sparse" instead of "--no-checkout" is the
> best way forward for now, but I'll classify that as a workaround
> and not necessarily the end of the conversation.

Agreed.

> In general, the commit in question is doing something extremely
> valuable for common situations, like rebase that you mention.
> I also think that this change in behavior is warranted by the
> clear warning placed at the top of the docs [1]:
>
>         THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE
>         BEHAVIOR OF OTHER COMMANDS IN THE PRESENCE OF SPARSE-
>         CHECKOUTS, WILL LIKELY CHANGE IN THE FUTURE.
>
> [1] https://git-scm.com/docs/git-sparse-checkout#_description
>
> Of course, that's just us covering our butts as we push the
> feature forward. It doesn't stop users (especially those that
> are bravely using the feature) from feeling pain that might
> be avoidable.
>
> To wrap up, it's unfortunate that the behavior changed. If it
> is easy to detect and handle this special case, then it _may_
> be worth doing to avoid disrupting users. Elijah: could you
> spend at most an hour trying to see how difficult this would be?

I actually spent...um...I don't know, but quite a bit longer than an
hour on this today (er, um, yesterday now).  I kept feeling that we
would be painting ourselves into a bad corner, or violating some
important invariant, and was also worried for a bit that this was just
a canary pointing out other important bugs that were ready to spring
on us once partial clones and sparse-checkouts were used more heavily
together.  So I dug around a fair amount.  jrnieder's post today[1]
was very timely; it gave me a good way to frame what bothered me so
much.  It seems to explain why I tend to hate working in dir.c, but
don't mind merge-recursive.c quite as bad: merge-recursive.c is a bit
of a mess but it has intended invariants that can be discovered if you
dig far enough (which means, it should be fixable or at least
replaceable); dir.c by contrast is mostly just a pile of empirical
behavior bolted on as we went and attempting to modify or replace or
duplicate it is going to always be a big uphill battle.  I'm worried
about moving sparse-checkout in the direction of a pile of bolted on
behaviors and losing sight of high-level design principles.  In
particular, I think that restoring the old behavior would move us in
that direction, and make us more inconsistent with other aspects of
git.  However, that said, the new behavior is not good either; it's
just buggy in a new way (though it's limited to this unborn index
special case).

I've got a patch that I'll post soon; it's a simple two-line change,
accompanied by an 87-line commit message -- because it took a while to
explain the history, the intended invariants, how those invariants
were messed up in different ways historically, how we can restore the
desired properties that'll make it easier to reason about the code,
and how the new behavior after the patch also makes us more consistent
with other behavior already found in git.  I'll submit it as soon as
it passes testsuites on the relevant machines.


[1] https://lore.kernel.org/git/20200603212336.GD253041@google.com/
