Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E0EC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 03:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745F864DD5
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 03:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBNDJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 22:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBNDJX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 22:09:23 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD26FC061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 19:08:43 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so262387oig.12
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 19:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTkpOwfHXj2oWEBxORh6O5UqIYDbqj7tylxy9kZcErI=;
        b=NMhW9E3KPdKZ+ExYDur2WQBYyutHizKYTlHV32NUxH5xfuliXRpxCtw9k49qciZJW2
         IDxlzGU9IcwCQny+QRnoP0kXq8x34P2wfIW9bnwN3CZiDXL5grsrt0gcoDfYxqQdlGuR
         FCcXfcD3J3N86zwowapqifJGJs9ObH6fj8SiV0W3TNnUR/LkKOlr+GqXMOhaS7ugXLd2
         mAjAp/ZEIwE07BzjqM6XPG6Zq5DVwQjDPpNu/LYu9MqgyEKWR8WPqVJKxzsK9Gj7UyZk
         sAPXMq+vwRdF18FklukxqSY2NGabHR8NwOlJfyJ2A4zJeWb98v61NZ6eeYq8G4RLKwIv
         5Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTkpOwfHXj2oWEBxORh6O5UqIYDbqj7tylxy9kZcErI=;
        b=hleo1Vsz18askTj7zmsBTRF7aJaSnMLGP9EWeYRaDuY+lBU7lt5slykfcG0FMPTEWA
         HZlfPHbKaURWQUL5CARhcO/mCAart3ai7o4ca2UyCCgLwTUod0JW3WVdi4HJ73bQUBU0
         fBZGzP1e3LTw9/ye1F52YZpOoOxR3O6Mz6Iv9NLvCWSSElE0iwV49vszR3RqKnqvUlNN
         rg3yhMpQnkEPgkILqqh59lGntIHwwofdOlzCcOG913zKiP+u8hQ/ai6Nl1S7a5+EuXSJ
         jOqiLPkaplzDuR+KAWxAM9WyqfYIoIt06qMDQNTkAP+//A4MgekmBO+KyYRg9ojlVQP2
         3qmA==
X-Gm-Message-State: AOAM530mWWSTlo9tukEh9Nh03sMJHFCruoedMy8WGL8hl6oS7YXZLa/m
        ynu4ujOZuFKA5IxFHb16biSluGGony2Ah+ZOEeE=
X-Google-Smtp-Source: ABdhPJzvP8jZ8nupH1Zauh4sEMOmdpuM7GuO9uBzG132kh4X5xXYHq1bbH47815IaHr9lbWN18FDBegXRSL+X2l8wYI=
X-Received: by 2002:aca:550e:: with SMTP id j14mr4416055oib.31.1613272122812;
 Sat, 13 Feb 2021 19:08:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <dc26881e4ed3447c6efdcd492463be294f99b8c4.1612970140.git.gitgitgadget@gmail.com>
 <xmqqsg60u49i.fsf@gitster.c.googlers.com> <CABPp-BF_cj1GEYT75aj9funUk1mYvtM2OvKiNb1JAZzA6E5mgQ@mail.gmail.com>
 <xmqqft1zttev.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft1zttev.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 13 Feb 2021 19:08:31 -0800
Message-ID: <CABPp-BHSsiU_BN-egJBjzCV2wyE4ABXkzhfnz-QRaUx5cbTDKQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] diffcore-rename: complete find_basename_matches()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 13, 2021 at 3:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I can change that.  I can also simplify it further to
> >
> >         if (0 <= (dst_index = (strintmap_get(&dests, base)))) {
> >
> > since dests uses a default value of -1.  That will decrease the number
> > of strmap lookups here from 2 to 1.
>
> Which would be a real win, unlike what I said in the message you are
> responding to.

Sadly, while it's a real win, it's very temporary.  The next series
I'll submit needs to separate the two checks back out for other
reasons.

> >> It feels incompatible with the spirit of these two steps aim for
> >> (i.e. only use this optimization on a pair of src/dst with UNIQUE
> >> basenames).  For the purpose of "we only handle unique ones", the
> >> paths that already have matched should participate in deciding if
> >> the files that survived "exact" phase have unique basename among
> >> the original inpu?
> >
> > Yeah, I should have been more careful with my wording.  Stated a
> > different way, what confidence can we associate with an exact rename?
>
> Suppose you start with a/Makefile, b/Makefile and c/Makefile and
> then they all disappeared while a1/Makefile, b1/Makefile and
> c1/Makefile now are in the tree.  The contents a/Makefile used to
> have appears without any difference in a1/Makefile, the same for b
> and b1, but c/Makefile and c1/Makefile are different.  The c vs c1
> pair may worth investigating, so it goes through the "same basename"
> phase.
>
> Now, in a slightly different situation, a vs a1 are still identical,
> but b vs b1 have only one blank line removal but without any other
> change.  It looks odd that such a change has to pessimize c vs c1
> optimization opportunity, but an interesting part of the story is
> that we can only say "such a change", not "such a miniscule change",
> because we have just finished the "exact" phase, and we do not know
> how big a difference b vs b1 pair actually had.
>
> That makes me feel that this whole "we must treat unique one that
> remains specially" is being incoherent.

It's really not that special; the pessimization is not in my mind due
to correctness reasons, but performance reasons.

I need to only compare any given file to at most one other file in the
preliminary steps.  When there are multiple remaining possibilities to
compare, I need a method for selecting which ones to compare.  I have
such a method, but it's a lot more code.  It was easier to submit a
series that was only 3 patches long and only considered the pairs that
just happened to uniquely match up so we could talk about the general
idea of basename matching.  The next series finds ways to match up
more files with similar basenames.

>  If "because we have only
> small number of removed and added Makefiles spread across the trees,
> first full-matrix matching among them without anything else with
> higher bar may be worth an optimization" were the optimization, then

This optimization was indeed considered...and fully implemented.
Let's give it a name, so I can refer to it more below.  How about the
"preliminary-matrix-of-basenames" optimization?

> I would understand and support the design to omit those that have
> already been matched in the "exact" phase.
>
> But IIRC, limiting this "same basename" phase to unique add/del pair
> was sold as a way to make it less likely for the heuristics to make
> mistakes, yet the definition of "unique", as shown above, is not all
> that solid.  That I find it rather unsatisfactory.

No, I never sold it as a way to make it less likely for the heuristics
to make mistakes.  If I implied that anywhere, it was on accident.

I certainly emphasized only doing one comparison per file, but not for
that reason.  I had three reasons for mentioning
one-comparison-per-file: (1) I was trying to contrast with Stolee's
original assumption about what this series was doing, to try to avoid
a repeat of the misunderstandings about the current optimization being
suggested.  (2) The preliminary-matrix-of-basenames optimization has
worst-case performance nearly twice as bad as without such an
optimization.  (For example, with preliminary-matrix-of-basenames, if
nearly all unmatched files have the same basename, we end up basically
doing inexact rename detection on all files twice).  I believe
Stolee's original assumption of what was being proposed also has such
twice-as-slow-as-normal worst-case performance behavior.  Even though
the worst case performance would be fairly rare, making an algorithm
twice as slow by introducing an optimization felt like something I
should avoid.  (3) Despite the theoretical problems with worst-case
performance, I implemented the preliminary-matrix-of-basenames
optimization anyway.  I threw the code away, because even in cases
with a wide variety of basenames, it slowed things down when other
optimizations were also involved.  The one clear way to work well with
other optimizations I was working with was to only allow the
preliminary step to compare any given file to at most one other file.

> In other words, it is not "what confidence do we have in exact
> phase?"  "exact" matching may have found perfect matching pair.  But
> the found pair should be happy just between themselves, and should
> not have undue effect on how _other_ pairs are compared.  Stopping
> the "exact" pair from participating in the "uniqueness" definition
> is placing "exact" phase too much weight to affect how other filepairs
> are found.

I guess I look at this quite a bit differently.  Here's my view:

  * If we have a reasonable and cheap way to determine that two
particular files are likely potential rename pairs,
  * AND checking their similarity confirms they are sufficiently
similar (perhaps with a higher bar)
  * then we've found a way to avoid quadratic comparisons.

We will give up "optimal" matches, but as long as what we provide are
"reasonable" matches I think that should suffice.  I personally
believe "reasonable" at O(N) cost trumps "optimal" at O(N^2).

There are several different ways to find "likely potential rename pairs":
  * The preliminary-matrix-of-basenames is one that I tried (but
interacts badly performance-wise with other optimizations).
  * https://github.com/gitgitgadget/git/issues/519 has multiple ideas.
  * Stolee's misunderstanding of my series is another
  * unique basenames among remaining pairs after exact renames is a
really simple one that lets me introduce "reasonable" matches so we
can discuss
  * my next series adds another

That leaves us with a big question.  Are we happy with higher
sufficient similarity bar being enough of a constraint for
"reasonable" matches?  If so, each of the above ideas might be able to
help us.  If not, we may be able to rule some of them out apriori and
avoid working on them (well, working on them any more; I've already
implemented three, and we have an intern who picked a project to look
at one)

> > By the exact same argument, you
> > could take this a step further and say that we should calculate the
> > basenames of *all* files in the tree, not just add/delete pairs, and
> > only match up the ones via basename that are *truly* unique.  After
> > all, break detection exists, so perhaps we don't have full confidence
> > that files with an unchanged fullname are actually related.
>
> Sorry, but you are not making sense.  These optimizations are done
> only when we are not using copies and breaks, no?  What _other_
> changes that kept the paths the same, or modified in place, have any
> effect on matching added and deleted pairs?

If the optimization is presented to users as "only compare basenames
in a preliminary step when they are unique", which is what I was
understanding you to say, and if the user has a/Makefile and
d/Makefile in the source tree, and a1/Makefile and d/Makefile in the
destination tree, then a/Makefile is not the unique "Makefile" in the
source tree.

I think you're trying to make an argument about uniqueness and why it
matters for correctness, but I'm not following it.

The only reason uniqueness is important to me is because I was using
it with future optimizations in mind, and knew it to be related to an
important performance criteria.  I tried to avoid mentioning
uniqueness at all in the user-facing documentation, though I did try
to explain why some files with the same basename might not be matched
up by that step (and my next series modifies those docs a bit.)
