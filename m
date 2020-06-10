Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3AC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B9820656
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8q38rSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgFJT60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgFJT60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 15:58:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC08AC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 12:58:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so2697377otr.12
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkai1b+vTko07GDtpciYBAewPBOaqrAyZoTs642VgKI=;
        b=I8q38rSKNd7a60EmzRiQP1fwSDsqUvZvY8L+5pmj8/IhWD9xsyKEmYSj6r1VrIkp49
         +fk/7tvrs2Es/Kxny4he34L/l7Afy6dz3JL3D8qntR5spfLXd1EP/LRSkqNa1qoXgT1T
         jbghhOLEgyEeUIwjprtTfRUdgX886HrksztOhcW83JCBllp5KjfF3weDQNX8BCO7cfif
         oJ2ayaqN5l0BbPwX8IrUnM+8JinikyfcEsflhPGmr/XTbf1POBn63mMjcClAwFrlNSWl
         nf8QQOoyxGdT+xwSTmz+pUBDHdAM6fBgWDuoys9hjB4H5nNN6BFe0H5NekiUrBfTHT23
         Fp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkai1b+vTko07GDtpciYBAewPBOaqrAyZoTs642VgKI=;
        b=DEIdbMo/8JICT/a2jN34DpMqOctfj/2iN3ftjyU4NLlZoSM0IvHYz1Dg255pAi6HHy
         DXhAdI+ngNb48Yr4BDlr2NPOaP9E/gtd9JpE9Y+UfR2O2d6A3pfLw8QoN/EjzJADV8UN
         8mfs7f3+b4Ss6z5yqHGUvdhZ4OOSvSrSW0dBx7cVJBqasp447f+5F3ZKQ3vRVxg27QbD
         c+Ebe7ot12ebCQpukey/2wj13r/V0YK4vkIrz6Ywa2CpomMpV2c/Ifaf9iarM3fvmE0k
         VUkTCEGl3fcTujgmFppCFzp3g8NMhxP5ae4mUvplSU95DIZrYeCyjzqmVQ2pj/FV29eS
         1LCg==
X-Gm-Message-State: AOAM530Q9QAw3DdG+BF6NTGpFPLZu6Toxnhk8MelJQE5UBj+BFBssw/b
        /YvMCZR6eWfelwCl8dAGMPKpO77bOofiblJN6tE=
X-Google-Smtp-Source: ABdhPJxUAfOlf143Zy0+65UxXAFDlkXDp8YNRWHHk0Gp1OajM+pOIUJHSv4MNhE79sNPMZlpt0nS/BLOlz3aRM4EP6E=
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr4109039otq.345.1591819104882;
 Wed, 10 Jun 2020 12:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com> <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
In-Reply-To: <562542d2-2a90-8683-a7fa-cbffb2e26bff@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Jun 2020 12:58:13 -0700
Message-ID: <CABPp-BE+BL3Nq=Co=-kNB_wr=6gqX8zcGwa0ega_pGBpk6xYsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 4:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/22/2020 10:26 AM, Elijah Newren wrote:
>
> Sorry I missed this patch. I was searching all over for patches with
> "sparse" or "submodule" in the _subject_. Thanks for calling out the
> need for review, Junio!
>
> > Subject: [PATCH] git-sparse-checkout: clarify interactions with submodules
> >
> > Ignoring the sparse-checkout feature momentarily, if one has a submodule and
> > creates local branches within it with unpushed changes and maybe adds some
> > untracked files to it, then we would want to avoid accidentally removing such
> > a submodule.  So, for example with git.git, if you run
> >    git checkout v2.13.0
> > then the sha1collisiondetection/ submodule is NOT removed even though it
> > did not exist as a submodule until v2.14.0.  Similarly, if you only had
> > v2.13.0 checked out previously and ran
> >    git checkout v2.14.0
> > the sha1collisiondetection/ submodule would NOT be automatically
> > initialized despite being part of v2.14.0.  In both cases, git requires
> > submodules to be initialized or deinitialized separately.  Further, we
> > also have special handling for submodules in other commands such as
> > clean, which requires two --force flags to delete untracked submodules,
> > and some commands have a --recurse-submodules flag.
> >
> > sparse-checkout is very similar to checkout, as evidenced by the similar
> > name -- it adds and removes files from the working copy.  However, for
> > the same avoid-data-loss reasons we do not want to remove a submodule
> > from the working copy with checkout, we do not want to do it with
> > sparse-checkout either.  So submodules need to be separately initialized
> > or deinitialized; changing sparse-checkout rules should not
> > automatically trigger the removal or vivification of submodules.
>
> This is a good summary of how submodules decide to be present or not.
>
> > I believe the previous wording in git-sparse-checkout.txt about
> > submodules was only about this particular issue.  Unfortunately, the
> > previous wording could be interpreted to imply that submodules should be
> > considered active regardless of sparsity patterns.  Update the wording
> > to avoid making such an implication.  It may be helpful to consider two
> > example situations where the differences in wording become important:
>
> You are correct, the wording was unclear. Worth fixing.
>
> > In the future, we want users to be able to run commands like
> >    git clone --sparse=moduleA --recurse-submodules $REPO_URL
> > and have sparsity paths automatically set up and have submodules *within
> > the sparsity paths* be automatically initialized.  We do not want all
> > submodules in any path to be automatically initialized with that
> > command.
>
> INTERESTING. You are correct that it would be nice to have one
> feature that describes "what should be present or not". The in-tree
> sparse-checkout feature (still in infancy) would benefit from a
> redesign with that in mind.
>
> I am interested as well in the idea that combining "--sparse[=X]"
> with "--recurse-submodules" might want to imply that the submodules
> themselves are initialized with sparse-checkout patterns.
>
> These ramblings are of course off-topic for the current patch.

Yeah, it might get complicated too; we'd almost certainly want to
limit to cone mode (globs could get super hairy).  It's also the case
we might want some submodules to have sparse-checkouts and others have
full checkouts, depending on whether the --sparse=X specification
listed some path that traversed from the toplevel outer repo down into
a submodule.  (But if --sparse is given with no specification, do all
submodules become sparse or do all remain full?)  Anyway, lots of
complications there and we should start a different thread to discuss
that when we feel it's time to tackle it.

> > Similarly, we want to be able to do things like
> >    git -c sparse.restrictCmds grep --recurse-submodules $REV $PATTERN
> > and search through $REV for $PATTERN within the recorded sparsity
> > patterns.  We want it to recurse into submodules within those sparsity
> > patterns, but do not want to recurse into directories that do not match
> > the sparsity patterns in search of a possible submodule.
>
> (snipping way the old paragraph and focusing on the new text)
>
> > +If your repository contains one or more submodules, then those submodules
> > +will appear based on which you initialized with the `git submodule`
> > +command.
>
> This sentence is awkward. Here is a potential replacement:
>
>   If your repository contains one or more submodules, then submodules are
>   populated based on interactions with the `git submodule` command.
>   Specifically, `git submodule init -- <path>` will ensure the submodule at
>   `<path>` is present while `git submodule deinit -- <path>` will remove the
>   files for the submodule at `<path>`. Similar to sparse-checkout, the
>   deinitialized submodules still exist in the index, but are not present in
>   the working directory.
>
> That got a lot longer as I was working on it. Perhaps add a paragraph break
> before the next bit.

Sounds good, thanks.

> >  Submodules may have additional untracked files or code stored on
>
> To emphasize the importance of the following "to avoid data loss" statement,
> you could mention that when a submodule is removed from the working directory,
> then so is all of its Git data such as objects and branches. If that data was
> not pushed to another repository, then deinitializing a submodule can result
> in loss of important data. (Also: maybe I'm wrong about that?)
>
> > +other branches, so to avoid data loss, changing sparse inclusion/exclusion

I thought that was what I covered with the "code stored on other
branches" but I guess that wasn't clear enough.  So yeah, I can try
extending it a bit.

> Edit: other branches. To avoid data loss, ...

Sounds good.

> > +rules will not cause an already checked out submodule to be removed from
> > +the working copy.  Said another way, just as `checkout` will not cause
> > +submodules to be automatically removed or initialized even when switching
> > +between branches that remove or add submodules, using `sparse-checkout` to
> > +reduce or expand the scope of "interesting" files will not cause submodules
> > +to be automatically deinitialized or initialized either.  Adding or
> > +removing them must be done as a separate step with `git submodule init` or
> > +`git submodule deinit`.
>
> This final sentence may be redundant if you include reference to init/deinit
> earlier in the section.

Yep, I'll strike it.

> > +This may mean that even if your sparsity patterns include or exclude
> > +submodules, until you manually initialize or deinitialize them, commands
> > +like grep that work on tracked files in the working copy will ignore "not
> > +yet initialized" submodules and pay attention to "left behind" ones.
>
> I don't think that "left behind" is a good phrase here. It feels like
> they've been _dropped_ instead of _persisted despite sparse-checkout
> changes_.

I think in addition to the "left behind" wording being bad, my
paragraph left another funny gray area and might be inconsistent with
what Matheus and I wrote elsewhere:

If sparsity patterns would exclude a submodule that is initialized,
sparse-checkout clearly can't remove the submodule.  However, should
it set the SKIP_WORKTREE bit for that submodule if it's not going to
remove it?

I'm not sure of the answer, yet.  I think Matheus had the right idea
for how to make grep handle an initialized submodule in the different
sparse.restrictCmds settings, and if we do go ahead and clear the
SKIP_WORKTREE bit, then I think the wording of this paragraph needs to
change.  So, let's discuss your alternative:

> Perhaps:
>
>   commands like `git grep` that work on tracked files in the working copy
>   will pay attention only to initialized submodules, regardless of the
>   sparse-checkout definition.

I think this is easy to misconstrue in an entirely new way: if there
are initialized submodules (and maybe a sparse checkout), then your
wording implies normal files would be ignored by grep (even files that
aren't removed by the sparse checkout)!  While that sounds like crazy
behavior, this whole thread started because of suggested behaviors
being proposed to carefully follow what was already written in this
document even though the end user result seemed somewhat crazy to me.
So, we might want to avoid a repeat.  :-)

Also, your suggested wording is different than the behavior we came up
with before, and is also inconsistent with how we'd work with normal
files.  For example, what if a user:

* uses sparse-checkout to remove a bunch of files/directories they
don't care about
* creates a new file that happens to have the same name as an
(unfortunately) generically worded filename that exists in the index
(but is marked SKIP_WORKTREE and had previously been removed)

Is this new file related to the tracked file?  Is the new file
considered tracked?  Should the new file be considered part of the
sparse cone (i.e. should it be considered part of the set of tracked
working tree files relevant to the user for commands that operate on
that subset)?  It's a bit of a thorny case.


Here's the behavior Matheus and I came to previously:

git -c sparse.restrictCmds=true grep --recurse-submodules <pattern>:
This goes through all the files in the index (i.e. all tracked files)
which do NOT have the SKIP_WORKTREE bit set.  For each of these: If
the file is a symlink, ignore it (like git-grep currently does).  If
the file is a regular file and is present in the working copy, search
it.  If the file is a submodule and it is initialized, recurse into
it.

git -c sparse.restrictCmds=false grep --recurse-submodules <pattern>:
This goes through all the files in the index (i.e. all tracked files)
regardless of SKIP_WORKTREE bit setting.  For each of these: If the
file is a symlink, ignore it (like git-grep currently does).  If the
file is a regular file and is present in the working copy, search it.
If the file is a submodule and it is initialized, recurse into it.

The only difference between these two sparse.restrictCmds settings is
the handling of the SKIP_WORKTREE bit.  I think that makes them nice
and orthogonal.  They also generalize nicely to the cases of searching
--cached or $REVISION with a few obvious changes (check if data is
available in git object store rather than if file is present in
working tree, and for $REVISION check sparsity patterns rather than
SKIP_WORKTREE bit).

If we start ignoring the SKIP_WORKTREE bit for some types of files
even when sparse.restrictCmds=true, I think we start getting a number
of inconsistencies and user surprises.  So, these formal definitions
seem like a good high-level design.  I think our attempts to summarize
behavior in short sentences for users sometimes ignores some cases due
to the desire to summarize.  However, taking the summary literally can
suggest behaviors that'd be inconsistent if not downright crazy for
some of the ignored cases.  I'll see if I can clean it up somehow.

> Thanks for pointing out how complicated this scenario is! It certainly
> demands a careful update like this one.

Thanks for the thoughtful review!
