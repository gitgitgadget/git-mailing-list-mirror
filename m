Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D5C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 20:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213BB205ED
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekAGd5sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgCPUYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:24:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42535 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbgCPUYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 16:24:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id 66so19268868otd.9
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FviaSPK7u2RFTN/HuwW4FoCra1QSX0+VxG6QXglWJM=;
        b=ekAGd5sCyVYnHIFqBC6kPmRdQDMArMhULi/BITeG+HZF/raVookP6/8T3spAFLbr34
         C8KzvLopn+brkrW39g0/eWMJTzDHQCqLyNskZu/hGNt+7Z52Hme9niXEryg7dk7zBCZ9
         E7EZDS5m14ADaByAEHtBCEorN5eDUFumENS541xjn/ucaJP+U7IrNKjgvxWqI1jqZHaS
         gkElDKMoWEx4h/yrMjG9UX96UBvGiiM9bgoPp4ARjDkCSdjrfGZaGOiW1JMrpiW+uNOG
         upRUHyomRsVWdS8af7Mc6L6aGoWwX2A9EsypJ3+92pfP4kuBYWPACO6rYylDUwObMo3a
         YZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FviaSPK7u2RFTN/HuwW4FoCra1QSX0+VxG6QXglWJM=;
        b=chEM6AJL5BzSuPThAUo+TIt/xfyDgNn092iIuYPUvdbjpcUDuHXWEVyuL7MTWSpyh5
         wZ+fx6bgGGJvQmmm18MhDlaanFM5SrL4vyDVkk45svqdnOdmxaJb8DKv24J/qpu3vH9+
         /Ds5io8eyCPS87cxnUeNpeBSoEhmEkD+hllwG/XZQqYO8tZm7LqMr+vmJbXQVHdYLZ3G
         gTkeJkvqgNdoQcCmqqYATXhbe1i2GX8vZ2NlyxssfGCQP8+P2ezVF2evIa4EyqUFCUWH
         /c3hSVaN1WrbVdIxndnwjE98d5eoV0ho+eGMowFXbuOFm+nTc1OAY+HtNe/fPe2kw530
         wB4A==
X-Gm-Message-State: ANhLgQ0++Hb2Ybu013Drr1Td4e89mrBx7i4mE/Wt7VPTXD4QQmub7WlD
        4J77IVPtJrMg3TgusmWkQgQRmk4Lit+xluR3eDXexA==
X-Google-Smtp-Source: ADFU+vsqbCOiAJg6srsDuSrBOJKSLfkYBhTS0tsRU9+nQ5oR7LGeQ+k3Y+WNTQbn/5Qp2AADP9IcbVqnWMAyD30pe+A=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr917348otl.162.1584390263612;
 Mon, 16 Mar 2020 13:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <9f13a2e8c64d47a5b3a4a2a96451decaf548ca4e.1584169893.git.gitgitgadget@gmail.com>
 <a2189235-d16a-cccc-a529-08cb854616b3@gmail.com>
In-Reply-To: <a2189235-d16a-cccc-a529-08cb854616b3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Mar 2020 13:24:12 -0700
Message-ID: <CABPp-BEOw6HXY8nwaKs8t5Zmp5nk-HL6+FOG1dgtx2Lc9qXUbQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] unpack-trees: add a new update_sparsity() function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 11:17 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Previously, the only way to update the SKIP_WORKTREE bits for various
> > paths was invoking `git read-tree -mu HEAD` or calling the same code
> > that this codepath invoked.  This however had a number of problems.
> > Let's look at all the various cases:
> >
> >   Flipping SKIP_WORKTREE -> !SKIP_WORKTREE (materializing files):
> >     A) There is no file in the way
> >     B) There is an untracked file in the way
> >   Flipping !SKIP_WORKTREE -> SKIP_WORKTREE (removing files):
> >     C) The path is clean
> >     D) The path is unmerged
> >     E) The path has unstaged changes
> >     F) The path has staged changes (differs from HEAD)
>
> Please also note that cases D, E, and F can appear in any combination.
> The lack of any of D, E, and F is case "C".
>
> Perhaps instead we should think of the following independent
> states that can toggle orthogonally on a path:
>
>   i. Current SKIP_WORKTREE value
>  ii. Intended SKIP_WORKTREE value
> iii. Path has staged changes.
>  iv. Path has unstaged changes.
>   v. Path is unmerged.

I like this way of thinking of it.

> with the additional conditional case of:
>
>  vi. There is a collision when changing from SKIP_WORKTREE to
>      !SKIP_WORKTREE. This could be file content difference or
>      a file/directory type conflict.

I think it'd be better to shorten this to:
  vi. There is a path in the way when trying to change from
SKIP_WORKTREE to !SKIP_WORKTREE.

The path in the way could be a file, a symlink, a directory, a
submodule, or whatever future types might be possible.  We don't
really care what kind of path is in the way, just that there is one.

> I believe the intention when refreshing or changing the sparse-
> checkout definition is to:
>
>  0. If a merge conflict happens outside the sparse cone, then
>     the conflicting files are created with the conflict markers.
>     This puts those paths in the state of having unstaged changes.

You seem to be thinking only of content conflicts that are
representable with conflict markers.  There are content conflicts that
are not representable with conflict markers, and non-content conflicts
of various types.[1]  So, we need to keep unmerged as distinct from
having unstaged changes.

>  1. If the path exists and we intend to set SKIP_WORKTREE, then
>     delete the file only if there are no unstaged changes.

As above, we need to fix this to:

1. If the path exists and we intend to set SKIP_WORKTREE, then delete
the file only if the file is not unmerged and there are no unstaged
changes.

>  2. If the path does not exist and we intend to remove SKIP_WORKTREE,
>     then check for case (vi). Fail with a helpful error if any such
>     case exists, and do not update any other paths.

Why an error and why not update any other paths?

> (This is all before I read the rest, so I'm sorry if I repeat what
> you have already described.)
>
> > For `git read-tree -mu HEAD`, the behavior is as follows:
> >     A) Materialize the file, as expected
> >     B) Refuse to make *any* changes (to this path or any others)
> >     C) Remove the file, as expected
> >     D) Refuse to make *any* changes (to this path or any others)
> >     E) Refuse to make *any* changes (to this path or any others)
> >     F) Removes the file from the working copy AND resets the index
> >        to match HEAD
>
> This case F is particularly bad, as we lose a staged change and
> its copy on disk. I believe that was the case that convinced me

by "on disk", I think you mean "from the working tree", yes?  It does
still exist on disk in the git object directory, if people are willing
to look through all the loose/dangling objects to find one that "looks
right".  I helped a user or two do so precisely because of case F
hitting them.

> to put in the requirement of a clean status before changing the
> sparse-checkout definition.
>
> > Refusing to modify files that could result in data loss as in cases B,
> > D, and E is good, but refusing to work on any other paths is very
> > problematic for users.  If they are in the middle of a rebase or have
> > made modifications to files that bring in more dependencies, then for
> > their build to work they need to update the sparse paths -- which they
> > are prevented from doing.  Sometimes they stage the files and re-try,
> > at which point they run into case F and believe that their changes are
> > lost.  (Even if they come ask an expert, they have to trawl through
> > their loose objects looking for which ones match which files.)
> >
> > Add a new update_sparsity() function which behaves as follows in these
> > cases:
> >     A) Materialize the file, as expected
> >     B) Leave the file in the working copy alone, clear the SKIP_WORKTREE
> >        bit, and print a warning (thus leaving them in a state where
> >        status will report the file as modified, which seems logical).
> >     C) Remove the file, as expected
> >     D) Do NOT mark this path as SKIP_WORKTREE, but allow others paths
> >        to be updated.
> >     E) Do NOT mark this path as SKIP_WORKTREE and print a warning about
> >        the dirty path, but allow other paths to be updated.
> >     F) Mark the path as SKIP_WORKTREE, but do not revert the version
> >        stored in the index to match HEAD; leave the contents alone.
> >
> > I tried a different behavior for B (leave the SKIP_WORKTREE bit set),
> > but found it very surprising and counter-intuitive (e.g. the user sees
> > it is present along with all the other files in that directory, tries to
> > stage it, but git add ignores it since the SKIP_WORKTREE bit is set).
>
> That sounds bad! I think you picked the right approach here.

Ok, I'll ignore your earlier comments about erroring out and not
updating any other paths then.

> > A, B, C, and E all seem like optimal behavior to me.  D may be as well,
> > though I wonder if printing a warning would be an improvement.  Some
> > might be slightly surprised by F at first, but given that it does the
> > right thing with `git commit` and even `git commit -a` (add ignores
> > entries that are marked SKIP_WORKTREE and thus doesn't delete them, and
> > commit -a is similar), it seems logical to me.
>
> The established usage pattern is that a user can create "colliding"
> directories and files outside of the sparse cone and Git is expected
> to ignore them. The problem happens when the user adds those paths
> to the sparse cone. I think you handle the situations quite well with
> this plan.

Cool.

> > +/*
> > + * display all the "error" messages as warnings
> > + */
> > +static void display_warning_msgs(struct unpack_trees_options *o)
> > +{
> > +     int e, i;
> > +     for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
> > +             struct string_list *rejects = &o->unpack_rejects[e];
> > +             if (rejects->nr > 0) {
> > +                     struct strbuf path = STRBUF_INIT;
>
> nit: Define 'i' within the inner-most scope that it matters.

Ah, yeah.  I also wondered if I should have done something to share
more code with display_error_msgs(), which this function was mostly a
copy of (and which has the same problem).

> > +                     for (i = 0; i < rejects->nr; i++)
> > +                             strbuf_addstr(&path, rejects->items[i].string);
> > +                     warning(ERRORMSG(o, e), super_prefixed(path.buf));
> > +                     strbuf_release(&path);
> > +             }
> > +             string_list_clear(rejects, 0);
> > +     }
> > +}
> > +/*
> > + * Update SKIP_WORKTREE bits according to sparsity patterns, and update
> > + * working directory to match.
> > + *
> > + * Returns
> > + *   0: success with no warnings
> > + *   1: success with warnings (warnings come either from (a) dirty changes
> > + *           present in which case we avoid marking those paths as
> > + *           SKIP_WORKTREE, or (b) from untracked files being in the way us
> > + *           checking a file out of the index, in which case we leave the file
> > + *           in the working tree alone while clearing SKIP_WORKTREE)
> > + *   -1: failure to manipulate the resulting index
> > + *   -2: failure to reflect the changes to the work tree.
> > + *
> > + * CE_NEW_SKIP_WORKTREE is used internally.
> > + */
>
> I think I mentioned using an enum for this function in another patch, and
> reading the documentation here makes that even more clear. Anything other
> than {-1,0,1} return types really could use stronger typing. Even using
> {-1,0,1} instead of just {0,1} is debatable if it should use an enum instead.
>
> I wonder if this patch could benefit a split where we first return
> {-2, -1, 0} and don't include any warnings, followed by a patch where
> the warnings are added (and tested).

An enum would definitely make it better.  I'll take a look, and see if
it makes sense to split it up.

> > +int update_sparsity(struct unpack_trees_options *o)
> > +{
> > +     struct pattern_list pl;
> > +     int i, empty_worktree, ret = 0;
> > +     unsigned old_show_all_errors;
> > +
> > +     old_show_all_errors = o->show_all_errors;
> > +     o->show_all_errors = 1;
> > +
> > +     /* Sanity checks */
> > +     if (!o->update || o->index_only || o->skip_sparse_checkout)
> > +             BUG("update_sparsity() is for reflecting sparsity patterns in working directory");
> > +     if (o->src_index != o->dst_index || o->fn)
> > +             BUG("update_sparsity() called wrong");
>
> I was going to add something about split indexes at the end,
> but I think this precondition has it covered.

I'm not sure how this condition covers split
indices/indexes/however-it-should-be-spelled, but I think split
indexes don't actually matter to this function because I don't create
or delete any index entries -- I merely toggle a single bit
(SKIP_WORKTREE) for an existing index.

> > +
> > +     trace_performance_enter();
> > +
> > +     if (!o->pl) {
> > +             char *sparse = git_pathdup("info/sparse-checkout");
> > +             memset(&pl, 0, sizeof(pl));
> > +             pl.use_cone_patterns = core_sparse_checkout_cone;
> > +             if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0) {
> > +                     /* FIXME: Skip to check_updates()?? */
> > +                     o->skip_sparse_checkout = 1;
> > +                     goto skip_sparse_checkout;
> > +             } else
> > +                     o->pl = &pl;
> > +             free(sparse);
> > +     }
>
> Outside of the goto, this part looks identical to other parts
> of the same file where we "fallback" to the sparse-checkout file.
> Perhaps that could be extracted to a helper method? It could
> return failure when there is no in-memory pattern and the
> sparse-checkout file fails to load, and in response we can do
> the goto.

Makes sense.

> > +     /* Set NEW_SKIP_WORKTREE on existing entries. */
> > +     mark_all_ce_unused(o->src_index);
> > +     mark_new_skip_worktree(o->pl, o->src_index, 0,
> > +                            CE_NEW_SKIP_WORKTREE, o->verbose_update);
> > +
> > +     /* Then loop over entries and update/remove as needed */
> > +     ret = 0;
> > +     empty_worktree = 1;
> > +     for (i = 0; i < o->src_index->cache_nr; i++) {
> > +             struct cache_entry *ce = o->src_index->cache[i];
> > +
> > +             if (apply_sparse_checkout(o->src_index, ce, o))
> > +                     ret = 1;
>
> So here, we report that at least one path has a warning.
>
> > +             if (!ce_skip_worktree(ce))
> > +                     empty_worktree = 0;
> > +
> > +     }
> > +
> > +     /*
> > +      * Sparse checkout is meant to narrow down checkout area
> > +      * but it does not make sense to narrow down to empty working
> > +      * tree. This is usually a mistake in sparse checkout rules.
> > +      * Do not allow users to do that.
> > +      */
> > +     if (o->src_index->cache_nr && empty_worktree) {
> > +             ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
>
> Interesting that we are using the result of unpack_failed() here.
> I suppose that could be an argument for using an int instead of
> an enum, but perhaps we translate the result of unpack_failed()
> here? What sorts of values could it be, anyway? Is this a case
> where unpack_failed() could return either -1 or -2? Or should
> we simply set 'ret' to the "-1" case ourselves?

I think we can map its return values to the enum we add.

>
> > +             goto done;
> > +     }
> > +
> > +skip_sparse_checkout:
> > +     if (check_updates(o, o->src_index))
> > +             ret = -2;
> > +
> > +done:
> > +     display_warning_msgs(o);
> > +     o->show_all_errors = old_show_all_errors;
> > +     trace_performance_leave("update_sparsity");
> > +     return ret;
> > +}
> > +
> >  /* Here come the merge functions */
> >
> >  static int reject_merge(const struct cache_entry *ce,
> > diff --git a/unpack-trees.h b/unpack-trees.h
> > index ae1557fb804..5d1a77ae249 100644
> > --- a/unpack-trees.h
> > +++ b/unpack-trees.h
> > @@ -90,6 +90,8 @@ struct unpack_trees_options {
> >  int unpack_trees(unsigned n, struct tree_desc *t,
> >                struct unpack_trees_options *options);
> >
> > +int update_sparsity(struct unpack_trees_options *options);
> > +
>
> Would it not be the pattern to include the documentation comment
> here in the header file?

Good point.

> In some ways, your update_sparsity() repeats some of the patterns
> of unpack_trees(), especially with its order of mark_all_ce_unused(),
> mark_new_skip_worktree(), and unpack_failed(). I think there may be
> some benefits to adding some of the performance tracing patterns from
> that method, too. These could be added as follow-up patches.

This also makes sense, though I'd be a bit surprised if performance
tracing for this function shows up anywhere.

> I'm happy that you decided to create a new method instead of adding
> yet another mode to unpack_trees(), especially because your version
> does not involve calling traverse_trees().
>
> After careful inspection of your patch, I cannot find anything wrong.
> I'm pretty happy with your organization and the approach seems clear.
> Hopefully my comments in the commit message could help improve that
> part of the discussion.
>
> At this point, the only thing we really need are tests that demonstrate
> as many of these cases as possible.

Thanks for reviewing it!

> Thanks,
> -Stolee



[1] A whole bunch of examples of conflicts that are not representable
with conflict markers, and non-content conflicts of various types:

If a symlink points at different paths, then attempting to represent
the contents of the symlinks with conflict markers results in a
symlink that is unusable and confusing; instead the version of the
symlink from HEAD is left in the directory and we know it is unmerged
not by having unstaged changes but the higher order index entries.

If a binary path has been modified on both sides of history, then
adding conflict markers is not compatible with the binary nature of
the file.  Instead, the version of the binary file from HEAD is left
in the directory and we know it is unmerged due to the presence of
higher order index entries.

If a simple script did not exist in the merge base but was added on
both sides with identical contents, with one side of history marking
it as executable and the other not marking it executable, then there
is nothing for us to put conflict markers around.  Further, we can't
mark the mode on disk as conflicted in some fashion, we just have to
pick whether to mark the copy in the working directory as executable
or not.  Storing higher order entries in the index is the only way for
us to know it is unmerged.

If a simple non-binary, non-symlink file exists and has never been
marked executable and existed in the merge base and HEAD but was
deleted on the other side of history, there's not much for us to do
with conflict markers that would make sense.  We just leave the file
from HEAD in the working directory, and instead note the conflict via
higher order index entries (and in this case, there will be 2 instead
of the normal 3 higher order entries).

If a simple non-binary, non-symlink file was renamed by both sides of
history but did not have any content change (and wasn't ever marked
executable), then there is again nothing for us to do with conflict
markers.  We'll instead have 3 higher order index entries, but exactly
one for each path.  This case is like the others above in that we can
look at the presence of higher order index entries, but slightly
different because there will only be one higher order (stage > 0)
entry in the index for any affected path.
