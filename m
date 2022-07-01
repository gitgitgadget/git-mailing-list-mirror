Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E296BC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 03:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiGADoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiGADoT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 23:44:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB936EEB4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 20:42:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z41so1381879ede.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGOjrMbggFTkXehhEwwW/Zu3Gnn8KUzMqwIgf+nxEbs=;
        b=QhchbNbMZZZfOTSj0shYZU4w+1o7Ee1KRSSePw15nwC9jTaJgK6NbrL1vWCne7xNzl
         VmKhex9nlt5e+wdGIyJEntXfJ8gkkbDVIFfrA5XSkCvo8VfBwRonZa/GGEXZa7Eaci85
         mMpzenfmnlvNIqZ2QZDxmpXBBpk6Fokh20cljJDty9Om/XtGUgdKYy7N+XgUsFlL23V/
         nW9XAG0HzwWqfaXPOYvksUx61zPaX2rnIOvc7kohEAWfVXPsG6Amcy62kh7QzSKoKhXA
         Vr/PWWrf3CmZrnWiG0UmedkRwYTPolqbY2hNegKBsDW5D7DX80VEv+/J32CY6+h12eAO
         g/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGOjrMbggFTkXehhEwwW/Zu3Gnn8KUzMqwIgf+nxEbs=;
        b=HdmOhiXaQpy/dMBTgR73ACIsRfgl1K5cE2U29CMqE5EA6c/dcposc4Bg0bapZW2w/S
         93aH6YWEfYDEXcnKTKYUr4BlJ8vpWDvu8QtNXv8dREOevhW4r4Pi7RQ1JINZiwLfOEmm
         FPRuUYNjxPjA3EZh3Yed/KDudZewSjxo0qMmmu/Tlb2WHpWUDbJTtdvQzUW76Xi8qn/F
         AOdS9EWXgFxWDnYJoL+n82i5+0Kv6oN/5a/E6en2FHLPuhRodinhklNbpCPUyLel5t9F
         e1OAIIKUz1kWmVFbwPhGwI7qpzaYKv46SQh/GsAEgTDxOSUIbqvdWUkfJVuoXanSwFIJ
         D3jg==
X-Gm-Message-State: AJIora81DIv9RNVHxNRPuWpjewdANUmF934yAVvdD1uMUHojEapjR4xH
        0wTxr0w/kZLzCDouKWIEchLSS9YT8fXTCs0e2cnMIIVdJLc=
X-Google-Smtp-Source: AGRyM1vmIPqgOuE3l8UjgoWR4QlXg6BUnvxApgewCmZ/3OVfrdRXDhVi8atELx/2mVLO6mwjj29ii3RDCTVgCTwWv/c=
X-Received: by 2002:a05:6402:2999:b0:434:edcc:f12c with SMTP id
 eq25-20020a056402299900b00434edccf12cmr15725117edb.96.1656646967286; Thu, 30
 Jun 2022 20:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com>
In-Reply-To: <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 20:42:35 -0700
Message-ID: <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Victoria Dye <vdye@github.com>
Cc:     Dian Xu <dianxudev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 10:06 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Wed, Jun 29, 2022 at 3:04 PM Victoria Dye <vdye@github.com> wrote:
> >>
> >> Dian Xu wrote:
> >>> Dear Git developers,
> >>>
> >>> Reporting Issue:
> >>>               'git add' hangs in a large repo which has
> >>> sparse-checkout file with large number of patterns in it
> >>>
> >>> Found in:
> >>>               Git 2.34.3. Issue occurs after 'audit for interaction
> >>> with sparse-index' was introduced in add.c
> >>>
> >>> Reproduction steps:
> >>>               1. Clone a repo which has e.g. 2 million plus files
> >>>               2. Enable sparse checkout by: git config core.sparsecheckout true
> >>>               3. Create a .git/info/sparse-checkout file with a large
> >>> number of patterns, e.g. 16k plus lines
> >>>               4. Run 'git add', which will hang>
> >>> Investigations:
> >>>               1. Stack trace:
> >>>                        add.c: cmd_add
> >>>                   -> add.c: prune_directory
> >>>                   -> pathspec.c: add_pathspec_matches_against_index
> >>>                   -> dir.c: path_in_sparse_checkout_1
> >>>               2. In Git 2.33.3, the loop at pathspec.c line 42 runs
> >>> fast, even when istate->cache_nr is at 2 million
> >>>               3. Since Git 2.34.3, the newly introduced 'audit for
> >>> interaction with sparse-index' (dir.c line 1459:
> >>> path_in_sparse_checkout_1) decides to loop through 2 million files and
> >>> match each one of them against the sparse-checkout patterns
> >>>               4. This hits the O(n^2) problem thus causes 'git add' to
> >>> hang (or ~1.5 hours to finish)
> >>
> >> Thanks for the explanation, it helped me narrow down the source to an exact
> >> commit (49fdd51a23 (add: skip tracked paths outside sparse-checkout cone,
> >> 2021-09-24)).
> >>
> >> You're correct that the `path_in_sparse_checkout()` check is slow [1].
> >> However, it only runs on files that are not "hidden" with the
> >> `SKIP_WORKTREE` flag. Ideally, if you're using sparse-checkout, this will
> >> only be a small subset of your 2 million files.
> >>
> >> In your repro steps, you're adding patterns to a file then immediately
> >> running `git add`. If that reflects how you're usually working with
> >> sparse-checkout, `SKIP_WORKTREE` likely isn't being applied properly before
> >> the `add`. You can check to see whether file(s) have the flag properly
> >> applied with `git ls-files -t <file or dir names>` - each `SKIP_WORKTREE`
> >> file should have an "S" next to it. "H" indicates that the flag is *not*
> >> applied.
> >>
> >> If you see that most of the files that *should* be sparse don't have
> >> `SKIP_WORKTREE` applied, you can run `git sparse-checkout reapply` (make
> >> sure you don't have any modified files outside the patterns you're
> >> applying!). The downside is that it'll be as slow as what you're reporting
> >> for `git add`, but any subsequent `add` (or reset, status, etc.) should be
> >> much faster.
> >>
> >> If you do all of that but things are still slow, then the way we check
> >> pathspecs in `git add` would need to change (not trivial, but probably not
> >> impossible either). At a cursory glance, I can think of a few options for
> >> that:
> >>
> >> 1. Remove the `path_in_sparse_checkout()` check. It's the simplest solution,
> >>    but it means you'd be able to stage files for commit outside the
> >>    sparse-checkout patterns without using the '--sparse' option. I don't
> >>    personally think that's a huge issue, but given that the implementation
> >>    was intentionally changed *away* from this approach, I'd defer to other
> >>    contributors to see if that's an okay change to make.
> >
> > I'm strongly against this.  This just restores the original bug we
> > were trying to fix, attempts to paper over the fact that non-cone mode
> > is fundamentally O(N*M) in one small instance, and sets the precedent
> > that we can't fix further sparse-checkout-based usability bugs because
> > it might add performance bottlenecks in additional places given
> > non-cone-mode's fundamental performance design problem.  We should
> > instead (in rough priority order)
>
> I'm not sure what the bug was - although I can (and should) read through the
> list archive to find out - but the rest of your point is convincing enough
> on its own. Even if we sacrificed correctness for performance in this one
> case, there are countless other places in the code like it, and changing all
> of them could seriously hurt user experience in other ways.
>
> Thanks for your perspective!

:-)

> >
> > * encourage people to adopt cone mode
> > * discourage people still using non-cone mode from having lots of patterns
>
> While I know these are the recommended best practice, I do want to
> acknowledge that switching to cone mode in some repositories is a huge lift
> or otherwise infeasible [1]. While people make that transition (if they even
> can), I don't think it's unreasonable to look for ways to improve
> performance in non-cone sparse checkout, especially if those performance
> gains can also be realized in cone mode.
>
> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205212347060.352@tvgsbejvaqbjf.bet/

Yep, very good point.  These dovetail with why I used "encourage" and
"discourage", and with why I had several more things that should be
done in my list, including performance work.  I know that non-cone
mode is important to still support.

But I would also like to point out that folks sometimes aren't
adopting cone mode out of inertia or bad assumptions about how cone
mode operates, rather than having sound reasons.  In fact, I've even
seen them describe conditions that sound like a perfect fit for cone
mode and yet use their described usecase as rationale to _not_ use
cone mode simply because they assume cone mode does something other
than what it really does.  (See
https://lore.kernel.org/git/CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKuLbArXQ@mail.gmail.com/
and the previous email in that thread for an example).  If even other
Git developers do that, that suggests we do need to probe a bit and
see if people can switch instead of just accepting they are one of the
cases that can't.  We still have some education work to do.

> > * make sure people aren't misusing things (the lack of a `git
> > read-tree -mu HEAD` or `git sparse-checkout reapply` seemed very
> > suspicious)
>
> A warning if a particular git operation sees a lot of out-of-cone
> non-`SKIP_WORKTREE` files might help with this (and would be especially
> impactful for someone working with a sparse index). I'm not sure how to
> quantify "a lot", though.

Yeah, this kind of reminds me of the present-despite-skipped check we
added.  Adding something like that which always runs is probably a
no-go, though, since this additional check would be much more
expensive than the present-despite-skipped one.  And, like you, I'm
also a little unsure how to quantify "a lot".

However, perhaps there's a way to tackle this problem from a different
angle.  I just noticed that the only place outside of the "git
sparse-checkout" command that sparse checkouts are documented, in
git-read-tree(1), that it didn't bother to give a list of steps for
employing sparse-checkouts and that people have to figure it out by
trial and error.  (Or read a random mailing list post or commit
message like 94c0956b60 (sparse-checkout: create builtin with 'list'
subcommand, 2019-11-21)).  So perhaps it's not surprising that users
miss one of the crucial steps.  Perhaps if we fix that documentation
to mention the necessary steps ("git config core.sparseCheckout true",
populate $GIT_DIR/info/sparse-checkout, then either run "git read-tree
-mu HEAD" or "git sparse-checkout reapply"), then users can discover
and make sure to do all the steps instead of just a subset?

> > * educate people that non-cone mode is just fundamentally slow, among
> > other problems, and that the slowness might appear in additional
> > places in the future as we fix various usability issues.
> > * provide workarounds users can adopt if they really want to persist
> > with non-cone mode with lots of patterns (e.g. add "--sparse" to their
> > "git add" commands), though warn them about the possible side effects
> > they'll face (the added files can seemingly randomly disappear in the
> > working tree with future checkout/pull/merge/rebase/reset/etc commands
> > if the added files don't match the sparsity patterns).
> > * investigate ways to optimize the code to lower the constant in the
> > O(N*M) behavior on a case-by-case basis
> >
> > We deprecated non-cone mode in v2.37 in part because of this type of
> > issue, and I really don't want the see the deprecated side of things
> > dictating how commands work for the now-default mode.
> >
> >> 2. After every call to `ce_path_match()`, check if all pathspecs are marked
> >>    as `seen` and, if so, return early. This would slow down each individual
> >>    file check and wouldn't help you if a pathspec matches nothing, but
> >>    prevents checking more files once all pathspecs are matched.
> >
> > Might be interesting.  Would need some careful measurements and
> > attempts to validate how often all pathspecs are matched early in some
> > kind of way, because this would definitely slow down some cases and
> > speed others up, but I don't have a good feel for which side happens
> > more frequently in practice.
> >
> >> 3. Do some heuristic checks on the pathspecs before checking index entries.
> >>    For example, exact file or directory matches could be searched in the
> >>    index. This would still require falling back on the per-file checks if
> >>    not all pathspecs are matched, but makes some typical use-cases much
> >>    faster.
> >
> > I'm confused.  "before checking index entries", you're checking things
> > (namely, exact file or directory matches) "in the index"?
>
> Sorry, I definitely wasn't clear. I mean "perform heuristic checks *per
> pathspec item* before iterating *per index entry*." Pathspecs used in `git
> add` are (at least in my experience) pretty small, so there could be
> performance gains if all the items can be marked `seen` without iterating
> over every entry of the index. I was thinking something like
> `pathspec_needs_expanded_index()` in `reset` (4d1cfc1351 (reset: make
> --mixed sparse-aware, 2021-11-29)), but tailored to this particular case.

Ah, okay makes sense now.





>
> >
> >> There are almost certainly other options, and I can dig around `add.c` more
> >> to see if there's anything I'm missing (although I'd love to hear other
> >> ideas too!).
> >>
> >> Hopefully this helps!
> >> - Victoria
> >>
> >> [1] `path_in_sparse_checkout()` is significantly faster in cone mode, but
> >> with 16k patterns I'm assuming you're not using cone patterns ;)
> >>
> >>>
> >>> Please help us take a look at this issue and let us know if you need
> >>> more information.
> >>>
> >>> Thanks,
> >>>
> >>> Dian Xu
> >>> Mathworks, Inc
> >>> 1 Lakeside Campus Drive, Natick, MA 01760
> >>> 508-647-3583
> >>
>
