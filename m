Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C88C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 01:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BEC364E6F
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 01:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBXB3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBXBOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 20:14:38 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23123C06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 17:13:47 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id g46so117524ooi.9
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 17:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2vBbio/fwPktiS+HJySgWo3TgX2+1EEBAcbgUkrZ5A=;
        b=crdQEvDTL6+37+FY/kN3eTsrGcRiKFL3XAcK5J95lxz/WQnhe4428eJOK3Xw72+3/t
         KJQIBlabYt7B1vXnD/3NAsTovYOTAtInPR1TMl9P5uRG8z3JZ6V0rxjnuIoNfK1OPbUE
         Xt2RFcxojzcHY1lRTXI6Mo3P4Z0dosoNjGcSr91GEHzzM/ccfOr2/cP9qx8+I9wxUgog
         wPuX7igd9AkrW1BoGzzhrCN5NLlV4MKwRrVOjigSP43LN89c26XGd3O5D24Mjvyfw0RM
         eoklaV3t6Oaf5k7BE7n1YGvqMO+KE+ujEsF8i2i1E8r0kj+dB+XscyWunCVTGz2pzqfu
         D7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2vBbio/fwPktiS+HJySgWo3TgX2+1EEBAcbgUkrZ5A=;
        b=ja2iH3jtfRREW1ayJ5SEY5TztnppjvaLRkveNtC6pnUDxWg0FypT15xE+sRInVi02/
         lP1q7N30zkvMzwKRaEJodcCQudIEEUqyk5SNGhuqiC5gM2tcXIED69RMpRwXVjO3yJZ7
         JFSr4byyfYr+ANL0zUUKSBNA5d8gs8BUYDit4ESkYTEBFS+fiOiM7lDc5VRlrIrfitoO
         CyR7mwC/uPLaQh7XAWUYOwTGAl/zi1kTVWw/eeAC8LPPOkXlvblJMXe6E7gqOuwN1TKL
         pQScCuoSKlGBWlmAj5Ske6DTV9Hz3NngPaIDc+Yv0jhl0xhKAanq2mHQukWMnpf5gGMw
         urpw==
X-Gm-Message-State: AOAM532OHJIjWqLHyv6Q8wYatrD8hiprsyPMz2TZSsgm2ZkLA9KG9wHK
        DJ5rYvKp6u0KqKeefJeVAcuyMDK1IUdseYkJxPE=
X-Google-Smtp-Source: ABdhPJytOnBnSjeBWKogZmjXlcpWKr18W/o33v9FN9JR6ZIPn3CYoTHP6Wjyz6R7gSnL2cCf432fTOlBAMV0pQkTd30=
X-Received: by 2002:a4a:9d0e:: with SMTP id w14mr21683786ooj.7.1614129225528;
 Tue, 23 Feb 2021 17:13:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <daa9a6bcefbce977606484d502f5cfd7fca63ecc.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <daa9a6bcefbce977606484d502f5cfd7fca63ecc.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 17:13:34 -0800
Message-ID: <CABPp-BHwRHhYE3BPxCG+fRFWf2dCZ60rnO=ykztquKoOp_x_QQ@mail.gmail.com>
Subject: Re: [PATCH 01/20] sparse-index: design doc and format update
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> This begins a long effort to update the index format to allow sparse
> directory entries. This should result in a significant improvement to
> Git commands when HEAD contains millions of files, but the user has
> selected many fewer files to keep in their sparse-checkout definition.
>
> Currently, the index format is only updated in the presence of
> extensions.sparseIndex instead of increasing a file format version
> number. This is temporary, and index v5 is part of the plan for future
> work in this area.
>
> The design document details many of the reasons for embarking on this
> work, and also the plan for completing it safely.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/index-format.txt |   7 +
>  Documentation/technical/sparse-index.txt | 167 +++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/technical/sparse-index.txt
>
> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
> index b633482b1bdf..387126582556 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -44,6 +44,13 @@ Git index format
>    localization, no special casing of directory separator '/'). Entries
>    with the same name are sorted by their stage field.
>
> +  An index entry typically represents a file. However, if sparse-checkout
> +  is enabled in cone mode (`core.sparseCheckoutCone` is enabled) and the
> +  `extensions.sparseIndex` extension is enabled, then the index may
> +  contain entries for directories outside of the sparse-checkout definition.
> +  These entries have mode `0040000`, include the `SKIP_WORKTREE` bit, and
> +  the path ends in a directory separator.
> +
>    32-bit ctime seconds, the last time a file's metadata changed
>      this is stat(2) data
>
> diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
> new file mode 100644
> index 000000000000..9070836f0655
> --- /dev/null
> +++ b/Documentation/technical/sparse-index.txt
> @@ -0,0 +1,167 @@
> +Git Sparse-Index Design Document
> +================================
> +
> +The sparse-checkout feature allows users to focus a working directory on
> +a subset of the files at HEAD. The cone mode patterns, enabled by
> +`core.sparseCheckoutCone`, allow for very fast pattern matching to
> +discover which files at HEAD belong in the sparse-checkout cone.
> +
> +Three important scale dimensions for a Git worktree are:
> +
> +* `HEAD`: How many files are present at `HEAD`?
> +
> +* Populated: How many files are within the sparse-checkout cone.
> +
> +* Modified: How many files has the user modified in the working directory?
> +
> +We will use big-O notation -- O(X) -- to denote how expensive certain
> +operations are in terms of these dimensions.
> +
> +These dimensions are ordered by their magnitude: users (typically) modify
> +fewer files than are populated, and we can only populate files at `HEAD`.
> +These dimensions are also ordered by how expensive they are per item: it
> +is expensive to detect a modified file than it is to write one that we
> +know must be populated; changing `HEAD` only really requires updating the
> +index.
> +
> +Problems occur if there is an extreme imbalance in these dimensions. For
> +example, if `HEAD` contains millions of paths but the populated set has
> +only tens of thousands, then commands like `git status` and `git add` can
> +be dominated by operations that require O(`HEAD`) operations instead of
> +O(Populated). Primarily, the cost is in parsing and rewriting the index,
> +which is filled primarily with files at `HEAD` that are marked with the
> +`SKIP_WORKTREE` bit.
> +
> +The sparse-index intends to take these commands that read and modify the
> +index from O(`HEAD`) to O(Populated). To do this, we need to modify the
> +index format in a significant way: add "sparse directory" entries.
> +
> +With cone mode patterns, it is possible to detect when an entire
> +directory will have its contents outside of the sparse-checkout definition.
> +Instead of listing all of the files it contains as individual entries, a
> +sparse-index contains an entry with the directory name, referencing the
> +object ID of the tree at `HEAD` and marked with the `SKIP_WORKTREE` bit.
> +If we need to discover the details for paths within that directory, we
> +can parse trees to find that list.
> +
> +This addition of sparse-directory entries violates expectations about the

Violates current expectations, yes.  Documentation tends to live a
long time, and I suspect that 2-3 years from now reading this sentence
might be jarring since we'll have modified the code to have an updated
set of expectations.  Maybe a simple "As of time of writing, ..." at
the beginning of the sentence here?  Or maybe I'm just being overly
worried...

> +index format and its in-memory data structure. There are many consumers in
> +the codebase that expect to iterate through all of the index entries and
> +see only files. In addition, they expect to see all files at `HEAD`. One
> +way to handle this is to parse trees to replace a sparse-directory entry
> +with all of the files within that tree as the index is loaded. However,
> +parsing trees is slower than parsing the index format, so that is a slower
> +operation than if we left the index alone.
> +
> +The implementation plan below follows four phases to slowly integrate with
> +the sparse-index. The intention is to incrementally update Git commands to
> +interact safely with the sparse-index without significant slowdowns. This
> +may not always be possible, but the hope is that the primary commands that
> +users need in their daily work are dramatically improved.
> +
> +Phase I: Format and initial speedups
> +------------------------------------
> +
> +During this phase, Git learns to enable the sparse-index and safely parse
> +one. Protections are put in place so that every consumer of the in-memory
> +data structure can operate with its current assumption of every file at
> +`HEAD`.
> +
> +At first, every index parse will expand the sparse-directory entries into
> +the full list of paths at `HEAD`. This will be slower in all cases. The
> +only noticable change in behavior will be that the serialized index file

noticeable

> +contains sparse-directory entries.
> +
> +To start, we use a new repository extension, `extensions.sparseIndex`, to
> +allow inserting sparse-directory entries into indexes with file format
> +versions 2, 3, and 4. This prevents Git versions that do not understand
> +the sparse-index from operating on one, but it also prevents other
> +operations that do not use the index at all. A new format, index v5, will
> +be introduced that includes sparse-directory entries by default. It might
> +also introduce other features that have been considered for improving the
> +index, as well.
> +
> +Next, consumers of the index will be guarded against operating on a
> +sparse-index by inserting calls to `ensure_full_index()` or
> +`expand_index_to_path()`. After these guards are in place, we can begin
> +leaving sparse-directory entries in the in-memory index structure.
> +
> +Even after inserting these guards, we will keep expanding sparse-indexes
> +for most Git commands using the `command_requires_full_index` repository
> +setting. This setting will be on by default and disabled one builtin at a
> +time until we have sufficient confidence that all of the index operations
> +are properly guarded.
> +
> +To complete this phase, the commands `git status` and `git add` will be
> +integrated with the sparse-index so that they operate with O(Populated)
> +performance. They will be carefully tested for operations within and
> +outside the sparse-checkout definition.

Good plan so far, but there's something else bugging me a little here.
One thing we noticed with our usage of `sparse-checkout` is that
although unimportant _tracked_ files go away, leftover build files and
other untracked files stick around.  So, although 'git status'
shouldn't have to check the tracked files anymore, it is still going
to have to look at each of the *untracked* files and compare to
.gitignore files in order to correctly classify each file as ignored
or just plain untracked.  Our `sparsify` tool has for a long time
tried to warn about such files when changing the sparsity
patterns/modules and had an --remove-old-ignores option for clearing
out ignored files that are found within directories that are sparse
(Meaning the directories where all files under them are marked
SKIP_WORKTREE.). I was never sure whether a warning was enough, or if
pushing that option more made sense, but about a month ago my
colleagues made the tool just auto-invoke that option from other
sparsify invocations.  To my knowledge, there have been no complaints
about that being automatically turned on; but there were
complaints/confusion before about the directories being left around.
(Of course, non-ignored files are still left around by that option.)

I'm worried that since sparse-checkout doesn't do anything to help
with all these untracked/ignored files, we might not get all the
performance improvements we want from a `git status` with sparse
directories.  We'll be dropping from walking O(2*HEAD) files (1 source
+ 1 object file) down to O(HEAD) files (just the object files) rather
than actually getting down to O(Populated).

> +
> +Phase II: Careful integrations
> +------------------------------
> +
> +This phase focuses on ensuring that all index extensions and APIs work
> +well with a sparse-index. This requires significant increases to our test
> +coverage, especially for operations that interact with the working
> +directory outside of the sparse-checkout definition. Some of these
> +behaviors may not be the desirable ones, such as some tests already
> +marked for failure in `t1092-sparse-checkout-compatibility.sh`.
> +
> +The index extensions that may require special integrations are:
> +
> +* FS Monitor
> +* Untracked cache
> +
> +While integrating with these features, we should look for patterns that
> +might lead to better APIs for interacting with the index. Coalescing
> +common usage patterns into an API call can reduce the number of places
> +where sparse-directories need to be handled carefully.

Makes sense.

> +Phase III: Important command speedups
> +-------------------------------------
> +
> +At this point, the patterns for testing and implementing sparse-directory
> +logic should be relatively stable. This phase focuses on updating some of
> +the most common builtins that use the index to operate as O(Populated).
> +Here is a potential list of commands that could be valuable to integrate
> +at this point:
> +
> +* `git commit`
> +* `git checkout`
> +* `git merge`
> +* `git rebase`
> +
> +Along with `git status` and `git add`, these commands cover the majority
> +of users' interactions with the working directory.

Sounds like a good plan as well.

I hope we get to make this specific to the merge-ort backend.  It
localizes the index-related code to (a) a call to unpack_trees()
called from checkout-like code (which would probably automatically be
handled by your updates to git checkout), and (b) a single function
named record_conflicted_index_entries().  I feel it should be pretty
easy to update.

In contrast, the idea of attempting to update merge-recursive with
this kind of change sounds overwhelming.

>  In addition, we can
> +integrate with these commands:
> +
> +* `git grep`
> +* `git rm`
> +
> +These have been proposed as some whose behavior could change when in a
> +repo with a sparse-checkout definition. It would be good to include this
> +behavior automatically when using a sparse-index. Some clarity is needed
> +to make the behavior switch clear to the user.

Is this leftover from before recent events?  I think this portion of
the document should just be stricken.

I argued about how these were buggy as-is due SKIP_WORKTREE always
having been an incomplete implementation of an idea at [1], but didn't
hear a further response from you.  I'm curious if you disagreed with
my reasoning, or it just slipped through the cracks in a busy schedule
and this portion of the document was leftover from before.  In my
opinion, both commands are just buggy and should be fixed for general
sparse-checkout usage cases, not just for sparse-index.

As for git grep, it has options for searching the working tree
(default) OR searching the index (--cached) OR searching an old commit
(passing a REVISION).  But never some combination or more than one of
these.  The fact that it combined some in the cases of SKIP_WORKTREE
entries looks entirely like a bug to me.  For the same reasons I
argued that --untracked and --cached are incompatible[2], we shouldn't
be combining results from searching the working tree and searching the
index.  Luckily, this fix has already been submitted[3] and picked up
in mt/grep-sparse-checkout and is marked in the cooking emails as
"Will merge to next".

As for git rm, I'll quote from my email to Matheus:

"""As far as the longer term discussion about making git rm configurable...
_If_ it comes up again in the future, I will argue that if git rm
should have configuration to delete paths outside the sparsity
specification, then git add should have configuration to add paths
outside the sparsity specification that happen to be present despite
being SKIP_WORKTREE, that git diff with no revision arguments (nor
--cached) should have configuration to diff against paths that are
SKIP_WORKTREE but happen to be present, that git status should have
configuration to report on changes to paths that are SKIP_WORKTREE but
happen to be present, that git checkout should have configuration to
write files to the working tree despite matching sparsity paths, etc.
And I'll argue that you do ALL of those or you're being inconsistent.
I hope that people see these are actually all the same request and
that it is horribly inconsistent to do some of these and not others,
and that at least by the time I get to mentioning checkout that they
realize it's a crazy request.  We should just tell users to extend
their sparsity if they want the working copy (and commands that
interact with the working copy) to handle the additional paths.  Maybe
I'm just really biased, but I don't see how this makes sense.  I would
argue more about it, but no one has responded.  My plan was to just
fix the default behavior, and then see if anyone ever actually cared
enough to come back and ask for more configurability."""

Also, for rm, Matheus has already submitted the fix[4], though at
Junio's request he separated out some fixes for git-add as a separate
preliminary series[5] and then will resubmit the other `add` and `rm`
fixes.

[1] https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqqtuql0yfp.fsf@gitster.c.googlers.com/
[3] https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/
[4] https://lore.kernel.org/git/61a77cd5f45ba02c7dff4b7932abdebb17c1667f.1613593946.git.matheus.bernardino@usp.br/
[5] https://lore.kernel.org/git/cover.1614037664.git.matheus.bernardino@usp.br/

Anyway, that's a long way of saying I think this section of your
document is already obsolete.  (Which is a good thing -- less work to
do to get sparse-index working.  Thanks, Matheus!).

> +This phase is the first where parallel work might be possible without too
> +much conflicts between topics.
> +
> +Phase IV: The long tail
> +-----------------------
> +
> +This last phase is less a "phase" and more "the new normal" after all of
> +the previous work.
> +
> +To start, the `command_requires_full_index` option could be removed in
> +favor of expanding only when hitting an API guard.
> +
> +There are many Git commands that could use special attention to operate as
> +O(Populated), while some might be so rare that it is acceptable to leave
> +them with additional overhead when a sparse-index is present.
> +
> +Here are some commands that might be useful to update:
> +
> +* `git sparse-checkout set`
> +* `git am`
> +* `git clean`
> +* `git stash`

Oh, man, git stash is definitely in need of work.  It's still a
minimalistic transliteration of shell to C, complete with lots of
process forking and piping output between various low-level commands.
It might be interesting to rewrite this in terms of the merge
machinery, though its separate stashing of staged stuff, unstaged
stuff, and possibly untracked stuff means that there is a sequence of
two or three merges needed and interesting failure handling to do if
those merges fail, especially if the user uses --index.  But I
digress...


Anyway, overall, very nicely written and planned out.  Thanks for
taking the time to write this all up.
