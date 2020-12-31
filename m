Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD0BC433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 20:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE43420855
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLaUEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 15:04:23 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBD3C061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 12:03:42 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a109so18785069otc.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkXXLfHwigHqX3lF0qX5CS6V0JSY5VeqxRzqvN0VWRs=;
        b=FDHVCSM6umm/dx3FT7H32XfYc3pwAyhmjHC7lJVPu2/0NDl5A85cdn5rPTmsV7vZVO
         FdQrJhppTfRQSqSIQQ8jzuBok84PCkm+iJHrJEWuQ/FtHDGSvD5vVLawSxlg5SqupeZ1
         NjncnWerTVSdXiIbyCI3IaVEq1muMYL0D7tvgzs5w859zTcUdqpGJWBeL79Y6Zv9JtGj
         OjtcOG5RsrwOLa2Gs4tsTal2cy2YuZ3vFtj9YzF6RgwluiZxjdD1dtyGgSaceZ3Te4tP
         6RfOp8FgKGMZ/aYsqHqOxv4+3jwpcoIHaGamO8k9uauXBnKStNfATyqZOp+w32zHuvIO
         5aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkXXLfHwigHqX3lF0qX5CS6V0JSY5VeqxRzqvN0VWRs=;
        b=EJ8/3Iv2s01GYWLusU9epHwdC8F7O4/bQIAjA1j3zAUAgObm8BeyGnQ5Sr1OUyKv2h
         338cIzlf+VMGr7wnoKBuZoCg05WYpuZAhWbibmPqhYczhXknqd32KvCluEwiGqD1brkj
         oI/RPvpePBKH9yKnRgKj9L1dX/OWx1aNkJNjBg4eh+rtzwIVQH5rV/0R261RqIUYZkmV
         KDKt9zzwW3l/V8hjZnY6S4pc4p0N2e07lFMDka/xpE24kh7jOXdMDhmPC5UD29V4Uz8T
         7pEeRMp1YKzteyqgD9Z6AcxASL7NCm3hUB/SWLg0GlVYIND8qJib9VlORNT7q6aDvdcN
         fapQ==
X-Gm-Message-State: AOAM532dzY069ISJe47bKXN+a1MSznbvW5SRcYyrJ60fA5+BqEwYCPJY
        biJrCsM1ZQq7SHecnGnmJ6yxRqPX5VvDTEcwe6g=
X-Google-Smtp-Source: ABdhPJzYl+GIOTfgwBAXTD0gHSAmgr/fQCJj3L2YzvKI2kHEbzknWGYfE9ewEDVnDibNiECuDNcVjI7QY69Y0zDY1JU=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr43004070otr.345.1609445021435;
 Thu, 31 Dec 2020 12:03:41 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <xmqqeekt83fl.fsf@gitster.c.googlers.com> <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
 <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
In-Reply-To: <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 31 Dec 2020 12:03:30 -0800
Message-ID: <CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com>
Subject: sparse-checkout questions and proposals [Was: Re: [PATCH] rm: honor
 sparse checkout patterns]
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the long delay...

On Fri, Nov 20, 2020 at 9:06 AM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Nov 16, 2020 at 9:20 PM Elijah Newren <newren@gmail.com> wrote:
> > On Mon, Nov 16, 2020 at 12:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > Matheus Tavares <matheus.bernardino@usp.br> writes:
> > >
> > > > Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
> > > > operation to the paths that match both the command line pathspecs and
> > > > the repository's sparsity patterns.
> > >
> > > > This better matches the expectations
> > > > of users with sparse-checkout definitions, while still allowing them
> > > > to optionally enable the old behavior with 'sparse.restrictCmds=false'
> > > > or the global '--no-restrict-to-sparse-paths' option.
> > >
> > > Hmph.  Is "rm" the only oddball that ignores the sparse setting?

> > > >  to the paths specified by the sparsity patterns, or to the intersection of
> > > >  those paths and any (like `*.c`) that the user might also specify on the
> > > >  command line. When false, the affected commands will work on full trees,
> > > > -ignoring the sparsity patterns. For now, only git-grep honors this setting.
> > > > +ignoring the sparsity patterns. For now, only git-grep and git-rm honor this
> > > > +setting.
> > >
> > > I am not sure if this is a good direction to go---can we make an
> > > inventory of all commands that affect working tree files and see
> > > which ones need the same treatment before going forward with just
> > > "grep" and "rm"?  Documenting the decision on the ones that will not
> > > get the same treatment may also be a good idea.  What I am aiming
> > > for is to prevent users from having to know in which versions of Git
> > > they can rely on the sparsity patterns with what commands, and doing
> > > things piecemeal like these two topics would be a road to confusion.
> >
> > It's not just commands which affect the working tree that need to be
> > inventoried and adjusted.  We've made lists of commands in the past:
> >
> > [3] https://lore.kernel.org/git/CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com/
> > [4] https://lore.kernel.org/git/xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com/
>
> So, I think there are a few other commands that need to be modified
> the same way rm is here by Matheus, a longer list of commands than
> what I previously linked to for other modifications, some warnings and
> error messages that need to be cleaned up, and a fair amount of
> additional testing needed.  I also think we need to revisit the flag
> names for --restrict-to-sparse-paths and
> --no-restrict-to-sparse-paths; some feedback I'm getting suggest they
> might be more frequently used than I originally suspected and thus we
> might want shorter names.  (--sparse and --dense?)  So we probably
> want to wait off on both mt/grep-sparse-checkout and
> mt/rm-sparse-checkout (sorry Matheus) and maybe my recently submitted
> stash changes (though those don't have an exposed
> --[no]-restrict-to-sparse-paths flag and are modelled on existing
> merge behavior) until we have a bigger plan in place.
>
> But I only dug into it a bit while working on the stash apply bug; I'm
> going to dig more (probably just after Thanksgiving) and perhaps make
> a Documentation/technical/ file of some sort to propose more plans
> here.

I apologize, this email is *very* lengthy but I have a summary up-front.
This email includes:

  * questions
  * short term proposals for unsticking sparse-related topics
    (en/stash-apply-sparse-checkout, mt/rm-sparse-checkout, and
    mt/grep-sparse-checkout)
  * longer term proposals for continued sparse-checkout work.

However, the core thing to get across is my main question, contained in
the next four lines:

  sparse-checkout's purpose is not fully defined.  Does it exist to:
    A) allow working on a subset of the repository?
    B) allow working with a subset of the repository checked out?
    C) something else?


You can think of (A) as marrying partial clones and sparse checkouts,
and trying to make the result feel like a smaller repository.  That
means that grep, diff, log, etc. cull output unrelated to your sparsity
paths.  (B) is treating the repo as dense history (so grep, diff, log do
not cull output), but the working directory sparse.  In my view, git
still doesn't (yet) provide either of these.

=== Why it matters ==

There are unfortunately *many* gray areas when you try to define how git
subcommands should behave in sparse-checkouts.  (The
implementation-level definition from a decade ago of "files are assumed
to be unchanged from HEAD when SKIP_WORKTREE is set, and we remove files
with that bit set from the working directory" definition from the past
provides no clear vision about how to resolve gray areas, and also leads
to various inconsistencies and surprises for users.)  I believe a
definition based around a usecase (or usecases) for the purpose of
sparse-checkouts would remove most of the gray areas.

Are there choices other than A & B that I proposed above that make
sense?  Traditionally, I thought of B as just a partial implementation
of A, and that A was the desired end-goal.  However, others have argued
for B as a preferred choice (some users at $DAYJOB even want both A and
B, meaning they'd like a simple short flag to switch between the two).
There may be others I'm unaware of.

git implements neither A nor B.  It might be nice to think of git's
current behavior as a partial implementation of B (enough to provide
some value, but still feel buggy/incomplete), and that after finishing B
we could add more work to allow A.  I'm not sure if the current
implementation is just a subset of B, though.

Let's dig in...

=== sparse-checkout demonstration -- diff, status, add, clean, rm ===

$ git init testing && cd testing
$ echo tracked >tracked
$ echo tracked-but-maybe-skipped >tracked-but-maybe-skipped
$ git add .
$ git commit -m initial
$ echo tracked-but-maybe-skipped-v2 >tracked-but-maybe-skipped
$ git commit -am second
$ echo tracked-but-maybe-skipped-v3 >tracked-but-maybe-skipped
$ git commit -am third

### In a non-sparse checkout...

$ ls -1
tracked
tracked-but-maybe-skipped
$ echo changed >tracked-but-maybe-skipped    # modify the file
$ git diff --stat                            # diff shows the change
 tracked-but-maybe-skipped | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git status --porcelain                     # status shows the change
 M tracked-but-maybe-skipped
$ git add tracked-but-maybe-skipped          # add stages the change
$ git status --porcelain                     # status shows the staged change
M  tracked-but-maybe-skipped
$ git clean -f tracked-but-maybe-skipped     # clean ignores it, it's tracked
$ git rm -f tracked-but-maybe-skipped        # rm removes the file
rm 'tracked-but-maybe-skipped'
$ git status --porcelain                     # status shows the removal
D  tracked-but-maybe-skipped
$ git reset --hard                           # undo all changes

### Compared to a sparse-checkout...

$ git sparse-checkout set tracked            # sparse-checkout...
$ ls -1                                      # ...removes non-matches
tracked
$ echo changed >tracked-but-maybe-skipped    # put the file back, modified
$ ls -1
tracked
tracked-but-maybe-skipped
$ git diff --stat                            # diff ignores changed file
$ git status --porcelain                     # status ignores changed file
$ git add tracked-but-maybe-skipped          # add...
$ git status --porcelain                     # ...also ignores changed file
$ git clean -f tracked-but-maybe-skipped     # maybe it's untracked?  but...
$ ls -1                                      # ...clean also ignores it
tracked
tracked-but-maybe-skipped
$ git rm -f tracked-but-maybe-skipped        # rm doesn't?!
rm 'tracked-but-maybe-skipped'
$ git status --porcelain
D  tracked-but-maybe-skipped
$ git reset --hard                           # undo changes, re-sparsify


With a direct filename some might question the behavior of add.
However, note here that add & rm could have used a glob such as '*.c',
or a directory like 'builtin/'.  In such a case, the add behavior seems
reasonable (though perhaps a warning would be nice if no paths end up
matching the pathspec, much like it does if you specify `git add
mistyped-filename`) and the rm behavior is quite dangerous.


=== more sparse-checkout discussion -- behavior A vs. B with history ===

Note that other forms of checkout/restore will also ignore paths that do
not match sparsity patterns:

$ git checkout HEAD tracked-but-maybe-skipped
error: pathspec 'tracked-but-maybe-skipped' did not match any file(s)
known to git
$ git restore --source=HEAD tracked-but-maybe-skipped
error: pathspec 'tracked-but-maybe-skipped' did not match any file(s)
known to git

The error message is suboptimal, but seems like this otherwise gives
desirable behavior as we want the checkout to be sparse.  If a user had
specified a glob or a directory, we'd only want to match the portion of
that glob or directory associated with the sparsity patterns.

Unfortunately, this behavior changes once you specify a different
version -- it actively not only ignores the sparse-checkout
specification but clears the SKIP_WORKTREE bit:

$ git checkout HEAD~1 tracked-but-maybe-skipped
Updated 1 path from 58916d9
$ ls -1
tracked
tracked-but-maybe-skipped
$ git ls-files -t
H tracked
H tracked-but-maybe-skipped
$ git reset --hard                         # Undo changes, re-sparsify


And it gets even worse when passing globs like '*.c' or directories like
'src/' to checkout because then sparsity patterns are ignored if and
only if the file in the index differs from the specified file:

$ git checkout -- '*skipped'
error: pathspec '*skipped' did not match any file(s) known to git
$ ls -1
tracked
$ git checkout HEAD~2 -- '*skipped'
$ ls -1
tracked
tracked-but-maybe-skipped

We get similar weirdness with directories:

$ git sparse-checkout set nomatches
$ ls -1
$ git checkout .
error: pathspec '.' did not match any file(s) known to git
$ git checkout HEAD~2 .
Updated 1 path from fb99ded
$ git ls-files -t
S tracked
H tracked-but-maybe-skipped
### Undo the above changes
$ git reset --hard
$ git sparse-checkout set tracked

Note that the above only updated 1 path, despite both files existing in
HEAD~2.  Only one of the files differed between HEAD~2 and the current
index, so it only updated that one.  When it updated that one, it
cleared the SKIP_WORKTREE bit for it, but left the other file, that did
exist in the older commit, with the SKIP_WORKTREE bit.


Since checkout ignores non-matching paths, users might expect other
commands like diff to do the same:

$ git ls-files -t
H tracked
S tracked-but-maybe-skipped
$ echo changed> tracked-but-maybe-skipped
$ git diff --stat tracked-but-maybe-skipped          # Yes, ignored
$ git diff --stat HEAD tracked-but-maybe-skipped     # Yes, ignored
$ git diff --stat HEAD~1 tracked-but-maybe-skipped   # Not ignored?!?
 tracked-but-maybe-skipped | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
$ rm tracked-but-maybe-skipped

Technically this is because SKIP_WORKTREE is treated as "file is assumed
to match HEAD", which might be implementationally well defined, but
yields some weird results for users to attempt to form a mental model.
Diff seems to match behavior B, whereas checkout with revisions and/or
pathspecs doesn't match either A or B.

There is a similar split in whether users would expect a search to
return results for folks who prefer (A) or (B):

$ git grep maybe HEAD~1
HEAD~1:tracked-but-maybe-skipped:tracked-but-maybe-skipped-v2

But, regardless of how history is treated (i.e. regardless of
preferences for behavior A or B), consistent with checkout and diff
above we'd expect a plain grep to not return anything:

$ git grep v3                                        # Should be empty
tracked-but-maybe-skipped:tracked-but-maybe-skipped-v3

Huh?!?  Very confusing.  Let's make it worse, though -- how about we
manually create that file again (despite it being SKIP_WORKTREE) and
give it different contents and see what it does:

$ echo changed >tracked-but-maybe-skipped
$ git grep v3
tracked-but-maybe-skipped:tracked-but-maybe-skipped-v3

WAT?!?  What part of "changed" does "v3" match??  Oh, right, none of it.
The pretend-the-working-directory-matches-HEAD implementation strikes
again.  It's a nice approximation to user-desired behavior, but I don't
see how it actually makes sense in general.


=== sparse-checkout other behaviors -- merges and apply ===

The merge machinery has traditionally done something different than
checkout/diff/status/commit in sparse-checkouts.  Like commit, it has to
include all paths in any created commit object.  Like checkout, it wants
to avoid writing files to the working directory that don't match
sparsity paths -- BUT files might have conflicts.  So, the merge
machinery clears the skip_worktree bit for conflicted files.  Also,
merge-recursive.c also clears the skip_worktree bit for other files
unnecessarily, due to difficulty of implementation of preserving it
(merge-ort should correct this).[1]

[1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/

Since the merge-machinery is used in multiple commands -- merge, rebase,
cherry-pick, revert, checkout -m, etc., this behavior is present in all
of those.

stash is somewhat modelled on a merge, so it should behave the same.  It
doesn't quite do so currently in certain cases.

The am and apply subcommands should also behave like merge; both will
need fixes.


=== sparse-checkout papercuts ===

Some simple examples showing that commands which otherwise work quite
nicely with sparse-checkout can have a few rough edges:

$ touch addme
$ git add addme
$ git ls-files -t
H addme
H tracked
S tracked-but-maybe-skipped
$ git reset --hard                           # usually works great
error: Path 'addme' not uptodate; will not remove from working tree.
HEAD is now at bdbbb6f third
$ git ls-files -t
H tracked
S tracked-but-maybe-skipped
$ ls -1
tracked

So, reset --hard worked correctly, but it made the user think that it
didn't with its error message.

$ git add mistyped-filename
fatal: pathspec 'mistyped-filename' did not match any files
$ echo $?
128
$ echo changed >tracked-but-maybe-skipped
$ git add tracked-but-maybe-skipped
$ echo $?
0
$ git status --procelain
$

So, in the case of a mistyped-filename or a glob that doesn't match any
files, `git add` prints an error and returns a non-zero exit code.  In
the case of SKIP_WORKTREE files, `git add` (correctly) refuses to add
them, but confusingly does so silently and with a clean exit status.


=== behavioral proposals ===

Short term version:

  * en/stash-apply-sparse-checkout: apply as-is.

  * mt/rm-sparse-checkout: modify it to ignore sparse.restrictCmds --
      `git rm` should be like `git add` and _always_ ignore
      SKIP_WORKTREE paths, but it should print a warning (and return
      with non-zero exit code) if only SKIP_WORKTREE'd paths match the
      pathspec.  If folks want to remove (or add) files outside current
      sparsity paths, they can either update their sparsity paths or use
      `git update-index`.

  * mt/grep-sparse-checkout: figure out shorter flag names.  Default to
      --no-restrict-to-sparse, for now.  Then merge it for git-2.31.


Longer term version:

I'll split these into categories...

--> Default behavior
  * Default to behavior B (--no-restrict-to-sparse from
    mt/grep-sparse-checkout) for now.  I think that's the wrong default
    for when we marry sparse-checkouts with partial clones, but we only
    have patches for behavior A for git grep; it may take a while to
    support behavior A in each command.  Slowly changing behavior of
    commands with each release is problematic.  We can discuss again
    after behavior A is fully supported what to make the defaults be.

--> Commands already working with sparse-checkouts; no known bugs:
  * status
  * switch, the "switch" parts of checkout

  * read-tree
  * update-index
  * ls-files

--> Enhancements
  * General
    * shorter flag names than --[no-]restrict-to-sparse.  --dense and
      --sparse?  --[no-]restrict?
  * sparse-checkout (After behavior A is implemented...)
    * Provide warning if sparse.restrictCmds not set (similar to git
      pull's warning with no pull.rebase, or git checkout's warning when
      detaching HEAD)
  * clone
      * Consider having clone set sparse.restrictCmds based on whether
      --partial is provided in addition to --sparse.

--> Commands with minor bugs/annoyances:
  * add
    * print a warning if pathspec only matches SKIP_WORKTREE files (much
      as it already does if the pathspec matches no files)

  * reset --hard
    * spurious and incorrect warning when removing a newly added file
  * merge, rebase, cherry-pick, revert
    * unnecessary unsparsification (merge-ort should fix this)
  * stash
    * similar to merge, but there are extra bugs from the pipeline
      design.  en/stash-apply-sparse-checkout fixes the known issues.

--> Buggy commands
  * am
    * should behave like merge commands -- (1) it needs to be okay for
      the file to not exist in the working directory; vivify it if
      necessary, (2) any conflicted paths must remain vivified, (3)
      paths which merge cleanly can be unvivified.
  * apply
    * See am
  * rm
    * should behave like add, skipping SKIP_WORKTREE entries.  See comments
      on mt/rm-sparse-checkout elsewhere
  * restore
    * with revisions and/or globs, sparsity patterns should be heeded
  * checkout
    * see restore

--> Commands that need no changes because commits are full-tree:
  * archive
  * bundle
  * commit
  * format-patch
  * fast-export
  * fast-import
  * commit-tree

--> Commands that would change for behavior A
  * bisect
    * Only consider commits touching paths matching sparsity patterns
  * diff
    * When given revisions, only show subset of files matching sparsity
      patterns.  If pathspecs are given, intersect them with sparsity
      patterns.
  * log
    * Only consider commits touching at least one path matching sparsity
      patterns.  If pathspecs are given, paths must match both the
      pathspecs and the sparsity patterns in order to be considered
      relevant and be shown.
  * gitk
    * See log
  * shortlog
    * See log
  * grep
    * See mt/grep-sparse-checkout; it's been discussed in detail..and is
      implemented.  (Other than that we don't want behavior A to be the
      default when so many commands do not support it yet.)

  * show-branch
    * See log
  * whatchanged
    * See log
  * show (at least for commits)
    * See diff

  * blame
    * With -C or -C -C, only detect lines moved/copied from files that match
      the sparsity paths.
  * annotate
    * See blame.

--> Commands whose behavior I'm still uncertain of:
  * worktree add
    * for behavior A (marrying sparse-checkout with partial clone), we
      should almost certainly copy sparsity paths from the previous
      worktree (we either have to do that or have some kind of
      specify-at-clone-time default set of sparsity paths)
    * for behavior B, we may also want to copy sparsity paths from the
      previous worktree (much like a new command line shell will copy
      $PWD from the previous one), but it's less clear.  Should it?
  * range-diff
    * is this considered to be log-like for format-patch-like in
      behavior?
  * cherry
    * see range-diff
  * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list
    * should these be tweaked or always operate full-tree?
  * checkout-index
    * should it be like checkout and pay attention to sparsity paths, or
      be considered special like update-index, ls-files, & read-tree and
      write to working tree anyway?
  * mv
    * I don't think mv can take a glob, and I think it currently happens to
      work.  Should we add a comment to the code that if anyone wants to
      support mv using pathspecs they might need to be careful about
      SKIP_WORKTREE?

--> Might need changes, but who cares?
  * merge-file
  * merge-index

--> Commands with no interaction with sparse-checkout:
  * branch
  * clean
  * describe
  * fetch
  * gc
  * init
  * maintenance
  * notes
  * pull (merge & rebase have the necessary changes)
  * push
  * submodule
  * tag

  * config
  * filter-branch (works in separate checkout without sparsity paths)
  * pack-refs
  * prune
  * remote
  * repack
  * replace

  * bugreport
  * count-objects
  * fsck
  * gitweb
  * help
  * instaweb
  * merge-tree
  * rerere
  * verify-commit
  * verify-tag

  * commit-graph
  * hash-object
  * index-pack
  * mktag
  * mktree
  * multi-pack-index
  * pack-objects
  * prune-packed
  * symbolic-ref
  * unpack-objects
  * update-ref
  * write-tree

  * for-each-ref
  * get-tar-commit-id
  * ls-remote
  * merge-base
  * name-rev
  * pack-redundant
  * rev-parse
  * show-index
  * show-ref
  * unpack-file
  * var
  * verify-pack

  * <Everything under 'Interacting with Others' in 'git help --all'>
  * <Everything under 'Low-level...Syncing' in 'git help --all'>
  * <Everything under 'Low-level...Internal Helpers' in 'git help --all'>
  * <Everything under 'External commands' in 'git help --all'>
