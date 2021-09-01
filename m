Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF89EC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D8361008
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 06:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhIAGtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbhIAGtb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 02:49:31 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D8C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 23:48:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso2302898otv.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 23:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WG8HIjrxA2QLAJomh5pwGgF/MPUeyUw4uKMdrISdTyc=;
        b=PHpiFFjc1MEoXZoUeV04UQvscwKfDHcBPDS+/Mi5RYbOLagV9po80czKcTJmSRV0kx
         vCj+9BhYbwGmbO6NE65xgNXOSoj8u8Voc7oACM8mHGPPW+8/zRBhfAswRvhnjIL2dcy4
         GUT/iKz20BUM55TbXGHdCKPJrlR6N8WsE1Wk1Eh4xJm40A9ms3AGj+Rl3ujISM5XtDvt
         TlFHvCJWTLPGjs/OQm4ZgIjYM9hQQCbEahMsTimNIb8Rcx0HEvQK36y2NczisAXitoHi
         ByDDll5iU5Fyc6hHvkuHdg7fBl7g4c2XX3YJAWiTtna6XobP5sWBonAuxOF1g4RgHzQe
         z5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WG8HIjrxA2QLAJomh5pwGgF/MPUeyUw4uKMdrISdTyc=;
        b=U+UoSpBYkkIjlZwtwmaCXRHLG61hbtyfCEYyvqjZj5eqqbhmdfTRryDUMZ0KnxB5Tr
         l4ihQv0Qtw1WmnNkCk9/ZpecpNsJJMtSrAkYnKvuMZDLXp6ZFGFGjnquvq0UWEfSY6tF
         fidZtzkm/F4bjdTolye1Eup2U2n0cOfqtYSqx5F3znSTlEdUYeVZg6IAOog+hrhlDpmJ
         UGoJHZS9Euk8MSdJRbokST89vJre4H4GluZwCYFKYV9mgRc9ZF0wXdVQXy4fqfO1WLGI
         p4/Q6xuzI5nq9elOT7t1PB9hxT6utRjiXq9hYzSsE7fsnoEalQLZSvSGBfDaLm/5iOt8
         O/kA==
X-Gm-Message-State: AOAM530Mvxnpzg7nfeX0ms+Xl87KLLaiNSebbs7G2xzHo+DarkAad79p
        aqR9vn6p6w96PvUkTIlFysKi2ZU2nhwBSnMZm3w=
X-Google-Smtp-Source: ABdhPJyXVHPuVkNCH0pzu476doEADrYd+tC1BVfRRnvzvvgdSjSC2JE3kwaRB2JN46DiGnWSSPCdddg76R8QovHaUOo=
X-Received: by 2002:a9d:7cc3:: with SMTP id r3mr27743070otn.345.1630478914872;
 Tue, 31 Aug 2021 23:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
 <YS3Tv7UfNkF+adry@coredump.intra.peff.net> <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
 <YS7rl8ynKD0fAerG@nand.local> <CABPp-BGkQTBBR_D-3EJPY-ONVYY4jjbEE4zA40n_oiz2DCrHgA@mail.gmail.com>
 <YS8IucBBDX61QdFB@nand.local>
In-Reply-To: <YS8IucBBDX61QdFB@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 23:48:23 -0700
Message-ID: <CABPp-BEaCCSTrte+s8tr+3zvrgg6LWCi8Z3dTz7CvkXWyJgKFQ@mail.gmail.com>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 9:59 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Aug 31, 2021 at 09:43:15PM -0700, Elijah Newren wrote:
> > On Tue, Aug 31, 2021 at 7:55 PM Taylor Blau <me@ttaylorr.com> wrote:
> > >
> > > On Tue, Aug 31, 2021 at 01:14:55PM -0700, Elijah Newren wrote:
> > > > > Now I have spent zero time looking into actually coding this, so it may
> > > > > turn out to be much trickier than I am suggesting. But this seems like a
> > > > > much more fruitful direction, where we can protect users in cases where
> > > > > they benefit (and give them sensible and actionable error messages),
> > > > > without bothering people in the majority of cases where their cwd
> > > > > doesn't go away.
> > > >
> > > > Ooh, this sounds intriguing to me...but what if we changed that rule
> > > > slightly and just decided to never make the cwd go away?  Currently,
> > > > the checkout code removes directories if they have no tracked or
> > > > untracked or ignored files left, i.e. if they're empty.  What if we
> > > > decide to only have remove_scheduled_dirs() remove directories that
> > > > are empty AND they are not the current working directory?
> > >
> > > Hmm. My first thought after reading this is that it would cause
> > > surprising behavior for anybody who had 'git add --all' in their 'rebase
> > > -x' script. But would it?
> > >
> > > I.e., imagine somebody doing an in-place sed in a rebase and then `git
> > > add --all`-ing the result at each point in history. If the directory
> > > they were in ever went away, then the *next* revision would add that
> > > directory right back.
> > >
> > > That behavior seems somewhat surprising to me, or at least I could
> > > imagine it being surprising to users.
> >
> > I'm not following.  `git add --all` doesn't add empty directories, so
> > I don't see how my proposed change would cause any problems in such a
> > case; nothing would be added back.
>
> Ahh, it was I who wasn't following. You were proposing to leave the
> directories in place but empty. Agreed that there wouldn't be any
> problems with that.
>
> > > Another thought is what should happen when the current directory goes
> > > away and then comes back as a file? We wouldn't be able to checkout that
> > > file, I don't think, so it might be a dead end.
> >
> > I'm not following this either.  Peff's original suggestion was to
> > error out only when we knew it could cause problems, in particular
> > when the working directory would be removed.  Here I've shifted the
> > way the problem is viewed by just not removing the working directory,
> > but the end result is the same -- it errors out when the removal was
> > needed.  Given that erroring out is exactly what we wanted for a case
> > like this, why does that make it a dead end?
>
> The way you shifted the problem makes it possible for us to discover
> that only right before we're about to fail, right? In other words, if
> you're doing a rebase then you're potentially leaving a lot of wasted
> work on the table if you realize halfway through the operation that you
> couldn't complete it.

Sure, it shifts things towards failing later.  However, for
correctness reasons, merge-ort has already fundamentally shifted
everything working-directory related towards failing later.

merge-recursive (the old algorithm), via unpack-trees, tried to do
checks for "locally modified files in the way" and "untracked
files/directories in the way" early on in the process.  However, such
checks were unaware of rename detection logic and thus had both false
positives and false negatives in terms of throwing errors and saying
the merge could not proceed.  Those false positives and negatives were
intrinsic to the design of merge-recursive; they'll never be fixed.
The only correct fix is to fundamentally change the design -- do the
entire merge operation without touching the working tree or index, and
only after you have a new resulting merge tree, then do a checkout
operation to switch from the old tree to the new merge result tree;
only at that final checkout step do you fail if there are locally
modified files or untracked files/directories in the way.  That's what
merge-ort does.

merge-ort is also written to allow a whole rebase to be done
"in-memory" and only update the working tree and index after we have
the final end-tree.  test-tool fast-rebase already works this way.  In
such a case, we'd only notice an untracked directory being in the way
at the point we hit a conflict or when we got to the end of the
rebase.  So again, erroring out when there is a directory with >= 1
untracked files (and at the end of the operation) isn't a new issue at
all.  The only thing that is new is we'd also error out if a directory
had 0 untracked files in it.

However, I disagree with the "a lot of wasted work"; rebase is
hundreds or thousands of times faster than it used to be as you
highlighted in your blog post.  ;-)  Also, as per my --remerge-diff
thread, merge-ort can remerge 33.5 merge commits/second in linux.git.
And that's just merges; rebases are faster than merges because (a) the
intersection (rather than union) of changes on both sides of history
tends to be much smaller for rebases than merges, due to the fact that
individual commits tend to only modify a handful of files (and
merge-ort optimizations work very well when the intersection of files
changed on both sides is small), and (b) we can cache rename detection
results for the upstream side of history in rebases.

> Even though I think that's *not* what you want for rebase, it ironically

I think it's totally what we want for rebase; it's perfectly aligned
with the merge-ort correctness changes to move things to
fail-at-the-end for working-directory-related problems.

> *is* what you might want for bisect, since the path we'll take isn't
> known ahead of time. So even if there are some paths that would result
> in a directory -> file conversion in the cwd, we don't need to fail the
> operation ahead of time if the bisection doesn't actually take that
> path.
>
> On the other hand, it does still leave a lot of work on the table if the
> bisection does eventually want to change the current working directory
> into a file, depending on where that change happens.
>
> Maybe those cases are pretty niche in practice. I have to imagine that
> they are. If my guess is right, then I think your approach makes sense.

:-)
