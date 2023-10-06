Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD239E81E03
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 14:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjJFOmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjJFOm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 10:42:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC910EC
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 07:42:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so2795534e87.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696603324; x=1697208124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoJSqMkBsc7NtLUYYptQRbF/Z6F4xYyFdB6iyQF0kzY=;
        b=QFdxoV5GzkN7A+GL4Q717/T8QyHNNRDdIs+l1vSJ4KSIovVu8GQOqLO+dio4cRI4Ok
         bhe6UhI60tc9aWklOLxnt7QkwSo3O1ijHX1lEvcFnpnJGSYPy9aRDkXrzH4qM2QyTfye
         5dDaFwvcT4yOxp0iQqUOmHHREywz2dKdGyKCBYVNLT3CGqMjOiRKDkmrXzz23uMBEDSZ
         dmGDqTneS11cQRUv1Au0ybPK5SNCf/6Gg4PIfhNrP/76AIL5XfGz5+XKfwiC+pYnxDXP
         Ih0GE+r4+H42mCk7axsZxJn24Fb1zTTof1NttEMT0FZtalGwgmxwiE4pMCQCoO7cwMht
         T5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603324; x=1697208124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoJSqMkBsc7NtLUYYptQRbF/Z6F4xYyFdB6iyQF0kzY=;
        b=MYwZlN7P9w54Qv1vpPEjwTTgnlIl1PTtYFGH+Zri/9Agh1NxkM/OdkUlPHe90WbAbB
         ZKg6Dcj+TvdeANYnmQ5CG7jEf67Q4aEOyDeVVuTJFHVJoE+KMTBKvY5lMrkPaK+uGN5j
         XF3cFt4bq6Y74GEeYM8o9r0GqV+OHSCCZq5P4fSiiz3gMgHhT0Q5W1Hi6cGLThd+t2Ta
         n8mjmxhjpzhw+z5rACCaQ3e9GBJrI1HHKpW6Rqd9xf0Nkyw1Obffp7ytc6+PPIF4MWDR
         fIHQh44DM9inohiAU1O68h4LYz+v+A2ite9XzosofugdKBaL98rY3ZnHvBlJa3diXzmg
         7otQ==
X-Gm-Message-State: AOJu0YwbxRDAtuCOjqATh/TADNXdkEyooqUjKmjgBrhEv2gea5H0cotT
        jmz5JUA8QSHy7OAQ1t8O0VNBOIZPuXMKBd9X9ac=
X-Google-Smtp-Source: AGHT+IF/PcZLchDK0GtYy+Kq1iWuWXCjBX5uKCpegEKEsNif87SKDu/ZupbAp2Ifwf4C8jHl1ap6nj9iXdWl9+h7pCo=
X-Received: by 2002:a05:6512:3f27:b0:504:7e90:e05b with SMTP id
 y39-20020a0565123f2700b005047e90e05bmr7217425lfa.14.1696603323609; Fri, 06
 Oct 2023 07:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230909125446.142715-1-sorganov@gmail.com> <20231004214558.210339-1-sorganov@gmail.com>
 <20231004214558.210339-2-sorganov@gmail.com> <xmqq34yog3ux.fsf@gitster.g>
In-Reply-To: <xmqq34yog3ux.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Oct 2023 07:41:51 -0700
Message-ID: <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 5, 2023 at 2:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Sergey Organov <sorganov@gmail.com> writes:
>
> > ---diff-merges=3D(off|none|on|first-parent|1|separate|m|combined|c|dens=
e-combined|cc|remerge|r)::
> > +-m::
> > +     Show diffs for merge commits in the default format. This is
> > +     similar to '--diff-merges=3Don' (which see) except `-m` will
> > +     produce no output unless `-p` is given as well.
>
> I think the sentence reads better without the translated (q.v.) that
> confused Eric.

Agreed; confused me too.

> > +-c::
> > +     Produce combined diff output for merge commits.
> > +     Shortcut for '--diff-merges=3Dcombined -p'.
> > +
> > +--cc::
> > +     Produce dense combined diff output for merge commits.
> > +     Shortcut for '--diff-merges=3Ddense-combined -p'.
>
> Good.
>
> > +--remerge-diff::
> > +     Produce diff against re-merge.
> > +     Shortcut for '--diff-merges=3Dremerge -p'.
>
> I suspect that many people do not get what "re-merge" in "against
> re-merge" really is.  As "combined diff" and "dense combined diff"
> are not explained in the previous two entries either, and expect the
> readers to read the real description (which more or less matches
> what the original description for "-c" and "--cc" had, which is
> good), it would be better to say "Produce remerge-diff output for
> merge commits."  here, too.  It makes it consistent, and "for merge
> commits" makes it clear the "magic" does not apply to regular
> commits (which the above entries for "-c" and "--cc" do, which is
> very good).

Perhaps:

Produce remerge-diff output for merge commits, in order to show how
conflicts were resolved.

> > +separate::
> > +     Show full diff with respect to each of parents.
> > +     Separate log entry and diff is generated for each parent.
>
> In the early days of Git before -c/--cc were invented, we explained
> this mode as "pairwise comparison", and the phrase "pairwise" still
> may be the best one to describe the behaviour here.  In fact, we see
> in the updated description of combined below the exact phrase is used
> to refer to this oldest output format.
>
>     Show the `--patch` output pairwise, together with the commit
>     header, repeated for each parent for a merge commit.

I like this.

> or something, perhaps.  I added "repeated" here to make the contrast
> with "simultaneously" stand out.
>
> > +combined, c::
> > +     Show differences from each of the parents to the merge
> > +     result simultaneously instead of showing pairwise diff between
> > +     a parent and the result one at a time. Furthermore, it lists
> > +     only files which were modified from all parents.
> > ++
> > +dense-combined, cc::
> > +     Further compress output produced by `--diff-merges=3Dcombined`
> > +     by omitting uninteresting hunks whose contents in the parents
> > +     have only two variants and the merge result picks one of them
> > +     without modification.
> > ++
> > +remerge, r::
> > +     Remerge two-parent merge commits to create a temporary tree
> > +     object--potentially containing files with conflict markers
> > +     and such.  A diff is then shown between that temporary tree
> > +     and the actual merge commit.
>
> The original says "two-parent merge comimts are remerged" so it is
> not a failure of this patch, but the first verb "Remerge" sounds
> unnecessarily unfriendly to the readers.
>
>         For a two-parent merge commit, a merge of these two commits
>         is retried to create a temporary tree object, potentially
>         containing files with conflict markers.  A `--patch` output
>         then is shown between ...
>
> would be easier to follow and more faithful to the original
> description added by db757e8b (show, log: provide a --remerge-diff
> capability, 2022-02-02).

I like it.  Perhaps it may also benefit from explaining why this mode
is useful as well:

    For a two-parent merge commit, a merge of these two commits is
    retried to create a temporary tree object, potentially containing
    files with conflict markers.  A diff is then shown between that
    temporary tree and the actual merge commit.  This has the effect
    of showing whether and how both semantic and textual conflicts
    were resolved by the user (i.e. what changes the user made after
    running 'git merge' and before finally committing).

> Either way, it makes readers wonder what happens to merges with more
> than 2 parents (octopus merges).  It is not a new problem and this
> topic should not attempt to fix it.

We could add:

    For octopus merges (merges with more than two parents), currently
only shows a warning about skipping such commits.

if wanted.

But perhaps I've distracted too much from Sergey's topic, and I should
submit these wording tweaks as a patch on top?  I'm fine either way.

> [Footnote]
>
> * When a project allows fast-forward merges, something like this can
>   happen (and Git was _designed_ to allow and even encourage it)
>
>   - Linus pulls from Sergey and sees merge conflicts that are very
>     messy.  Sergey is asked to resolve the conflict, as Linus knows
>     Sergey understands the changes he is asking Linus to pull much
>     better than Linus does.
>
>   - Sergey does "git pull origin" that would give the same set of
>     conflicts Linus saw, perhaps ours/theirs sides swapped, resolves
>     the conflicts, and comits the merge result.  He may even add a
>     few other improvements on top (or may not).  He tells Linus that
>     his tree is ready to be pulled again.
>
>   - Linus pulls from Sergey again.  This time it is fast-forward,
>     without an extra merge commit that records the Linus's previous
>     tip as the first parent and Sergey's work as the second parent.
>
>   - Linus continues working from here.
>
>   In such a workflow, merges are nothing more than "combining
>   multiple histories together" and the first parenthood is NOT
>   inherently special among parents at all.  The original "-m -p"
>   (aka "pairwise diff") output reflects this world view and ensures
>   that all parents are shown more or less as equals (yes, the first
>   parent diff is shown first before the other parents, but you
>   cannot avoid it when outputting to a single dimension medium).
>
>   This world view was the only world view Git supported, until I
>   added the "--first-parent" traversal in 0053e902 (git-log
>   --first-parent: show only the first parent log, 2007-03-13).
>
>   With the "--first-parent", with "--no-ff" option to "git merge", a
>   different world view becomes possible.  A merge is not merely
>   combining multiple histories, which are equals.  It is bringing
>   work done on a side branch into the trunk.  To see the overview of
>   the history, "git log --first-parent" would give the outline,
>   which would be full of merges from side branches, each of which
>   can be seen as summarizing the work done on the side branch that
>   was merged, and it may occasionally have single-parent commits
>   that are hotfixes or trivial clean-ups or project administrivia
>   commits.  With "-p", "git log" would show the changes the work
>   done on a side branch as a single unit for a merge, and individual
>   commits if they are single-parent.  The life is good.
>
>   It all breaks down if the "diff against the first parent" is done
>   on a merge that is not bringing the work on a side branch in to
>   the trunk.  The merge done in the second step Sergey did for Linus
>   in the above example will have his work on the history leading to
>   its first parent, and from the overall project's point of view,
>   the second parent is the tip of the history of the trunk.  Showing
>   first-parent diff for a merge that was *not* discovered via the
>   first-parent traversal would show such a meaningless patch.  This
>   is an illustration of the fallout from mixing two incompatible
>   world views together, "--diff-merges=3Dfirst-parent" wants to work
>   in a world where the first-parent is special among parents, but
>   traversal without "--first-parent" wants to treat all the branches
>   equally.
>
>   All the other <format>s accepted by the "--diff-merges=3D<format>"
>   option are symmetrical and they work equally well when in a
>   history of a project that considers the first-parenthood special
>   (i.e. work on a side branch is brought into the trunk history) or
>   in a history with merges whose parent order should not matter, so
>   unlike "--diff-merges=3Dfirst-parent", it makes sense to apply them
>   with or without first-parent traversal.  It however is not true
>   for the "--diff-merges=3Dfirst-parent" variant, which is asymmetric.
>
>   And that is why I think use of "--diff-merges=3Dfirst-parent"
>   without "--first-parent" traversal is a bad thing to teach users
>   to use.

Thanks for writing this up.  In the past, I didn't know how to put
into words why I didn't particularly care for this mode.  You explain
it rather well.
