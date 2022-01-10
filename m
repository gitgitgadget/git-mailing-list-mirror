Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53710C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiAJR7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbiAJR7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:59:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE04C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:59:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c71so45298874edf.6
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5FQ8kTIXbDVGh936OC7/ndnHFMbkcaq2+77Q2Oq5DA=;
        b=oWOBHx9ZRVj+Enw86y7JIjffB2rHEhV9IYiTfbpj61DfCxk+G1oIcnqAM7qX8ZpRyp
         BWbAS/Wtcw+NgEWwXsh957jYoVuYnNNPy76cbUee0CfEBkTutSqLQtgZNU9onJPDvRRn
         AU3v58cNbXnCCRVk0N/pj5eccBuWSc77JGULvzXGc6QCF7q7+IcTks576ZmvZhwzKXTk
         Z8Kelmg74J2+Ls66LEKzSUW/yMjnBqE6duIBrnjOBfVcCyMiNXDtJoLwsL+gXlxYiD62
         b6D/pjXzoA1Da3DoYv+sYekTuPqFOyMCcCkL89E01NI9hgN4VKApNxJpTWlLbraaySTe
         zKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5FQ8kTIXbDVGh936OC7/ndnHFMbkcaq2+77Q2Oq5DA=;
        b=8AlJ93geISacAHu51GB7WW9QzpkY0ICBzjO5htTyCtgcueEVJzKNfQoD8GsqJWJAWX
         kWn3FHyUaO66fHVu5n3w3FlywuNgNzjWPJnJlZZ5hnKPpBoAeTDteu3rUciWqIqR848e
         gtL4XIqPVKsTroDqRTo61ON5WxOWofkayYWQXrE6YCuS9b1EhakbePGD+jjduvCiLKJj
         YnE4b/oznh85QLID2L6nPF6JWUiW6I8zwdsQFVvdXO0lxdrSSBAV2ItZahEZlTgviYCl
         sxc1MOfFSIwYko/qU0eHOQVWNEWcKQhFMlff5Q/YPv5wcbiYaDcrsMhVkZ6KwYCUrmfT
         dtUA==
X-Gm-Message-State: AOAM533DZktOnZopFoJVlWs46e0X1PgYBjch5r3guA8V/SJdB51xwkf0
        hyTqnJUz/XDKfCX97nVExK9raLhmCza889ToVrM=
X-Google-Smtp-Source: ABdhPJyguxKQvEUVlLjlNQ6sDnei+6VTmxW0lriqyQbImZOIdnuejStplfSr+oMenq58X1MSIa3PkWOjGj9yGYyMWVY=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr698832ejc.192.1641837582290;
 Mon, 10 Jan 2022 09:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com> <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Jan 2022 09:59:30 -0800
Message-ID: <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 5:49 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 7 Jan 2022, Elijah Newren wrote:
>
> > On Fri, Jan 7, 2022 at 9:58 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> > > >
> > > > On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> > > > <christian.couder@gmail.com> wrote:
> > >
...
>
> I _bet_ it needs first and foremost the information "is this mergeable?".
>
> That is by far the most common question the code I saw had to answer,
> without any follow-up questions asked.
>
> An add-on question is then "which files/directories conflicted?". And
> there, it really only wanted the file names, along with the OIDs of the
> respective item in the base, the HEAD and the merge branch.

This might be difficult to provide for some cases, e.g.
rename/rename(1to2), especially if that conflict gets entangled with
any others.  Users would also have difficulty gaining these even using
the command line `git merge` (with either recursive or ort) for these
cases.

Also, does this presume three OIDs?  What about the cases where there
are 4 or 6 for a given path?

I'm a bit worried about the assumptions underlying this request, and
that it might not be satisfiable in general depending on what those
assumptions are.

> In my work in December, I also had to implement another thing that I think
> we will have to implement in `merge-tree` in one form or another: when
> users provided merge conflict resolutions via the web UI, we want the
> merge to succeed. What I implemented was this (in a nutshell, a way to
> provide file names with associated blob OIDs that resolve the content
> conflicts):

Interesting.  I'm curious, though -- if they are providing conflict
resolutions, then would they not have had a previous merge to find out
what the conflicts were?  If so, wouldn't they be able to provide the
tree to avoid the need for a second merge?

>
> -- snip --
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Thu Dec 16 20:46:35 2021 +0100
> Subject: merge-ort: allow pre-resolving merge conflicts
>
> One of merge-ort's particular strengths is that it works well even in a
> worktree-less setting, e.g. in a backend for a server-side merge.
>
> In such a scenario, it is conceivable that the merge in question not
> only results in a conflict, but that the caller figures out some sort of
> resolution before calling the merge again. The second call, of course,
> is meant to apply the merge conflict resolution.
>
> With this commit, we allow just that. The new, optional
> `pre_resolved_conflicts` field of `struct merge_options` maps paths to
> the blob OID of the resolution.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> diff --git a/merge-ort.c b/merge-ort.c
> index a74d4251c3..fa59ce2f97 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3961,6 +3961,7 @@ static void process_entries(struct merge_options *opt,
>         prefetch_for_content_merges(opt, &plist);
>         for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
>                 char *path = entry->string;
> +               struct object_id *resolved_oid;
>                 /*
>                  * NOTE: mi may actually be a pointer to a conflict_info, but
>                  * we have to check mi->clean first to see if it's safe to
> @@ -3972,7 +3973,17 @@ static void process_entries(struct merge_options *opt,
>                                           &dir_metadata);
>                 if (mi->clean)
>                         record_entry_for_tree(&dir_metadata, path, mi);
> -               else {
> +               else if (opt->pre_resolved_conflicts &&
> +                        (resolved_oid =
> +                         strmap_get(opt->pre_resolved_conflicts, path))) {

You have a couple problematic assumptions here:

  * What if the user's resolution required fixing a semantic conflict,
meaning they needed to modify a file that had no conflicts?  Your code
here would ignore those, because the clean case is handled above.

  * What if the user's resolution required adding a totally new file
(either because a rename is handled as a separate add/delete, or they
just needed a new file)?  The loop above isn't over items in
pre_resolved_conflicts, it just assumes that items in
pre_resolved_conflicts are also in the plist.items being looped over.


> +                       mi->clean = 1;
> +                       mi->is_null = 0;
> +                       memcpy(&mi->result.oid, resolved_oid,
> +                              sizeof(*resolved_oid));

And here's another:

  * What if the provided resolution was a deletion of the file in
question (especially after e.g. a modify/delete or rename/delete
conflict)?  Don't you need to have a special check for the zero_oid
here?

And if I combine the things above:

  * What if the user wants to remove a file and add a directory of
files in its place at some location in order to resolve things?
Granted, you didn't handle either deletes or new files above, but if
you did add both, then you might have this issue.  The code at this
point used some very carefully constructed logic and order of walking
items specifically to handle file/delete conflicts correctly.  I'm
worried that your conflict resolution stuff here might interact badly
with that.

> +                       if (!mi->result.mode)
> +                               mi->result.mode = 0100644;

How do you know it's not supposed to be 0100755?

> +                       record_entry_for_tree(&dir_metadata, path, mi);
> +               } else {
>                         struct conflict_info *ci = (struct conflict_info *)mi;
>                         process_entry(opt, path, ci, &dir_metadata);
>                 }
> diff --git a/merge-recursive.h b/merge-recursive.h
> index 0795a1d3ec..1f45effdd0 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -47,6 +47,13 @@ struct merge_options {
>         const char *subtree_shift;
>         unsigned renormalize : 1;
>
> +       /*
> +        * (merge-ORT only) If non-NULL, contains a map from `path` to OID. If
> +        * the given `path would be marked as conflict, it is instead resolved
> +        * to the specified blob.
> +        */
> +       struct strmap *pre_resolved_conflicts;
> +
>         /* internal fields used by the implementation */
>         struct merge_options_internal *priv;
>  };
> -- snap --
>
> It is a proof-of-concept

Fair enough.

>, therefore it expects the resolved conflicts to
> be in _files_. I don't think that there is a way to reasonably handle
> symlink target conflicts or directory/file/symlink conflicts, but there
> might be.

You really need (mode,oid) pairs to be provided by the user.  That
fixes the executable issue I mentioned above, and makes it clear how
to handle symlinks and file/symlink conflicts.

directory/file are still handled by providing individual files, but
ordering traversal becomes really tricky.  The directory/file case
might even require the pre_resolved_conflicts to be pulled out of that
loop somehow.  It'd take some investigative work, or some deep
thought, or both.

> A subsequent commit changed my hacky `merge-tree` hack to optionally
> accept NUL-terminated merge conflict resolutions in <path>/<OID> pairs via
> stdin (again, avoiding files to be written where we do not _need_ spend
> I/O unnecessarily).
>
> The biggest problem we faced at the Contributor Summit was that our
> discussion was not informed by the actual server-side needs. So I would
> like to reiterate my challenge to make that the driver. Let's not use any
> hypothetical scenario as the basis for the design of `git merge-tree`, but
> let's use the concrete requirements of actual server-side merges that are
> currently implemented using libgit2, when trying to figure out what
> functionality we need from `merge-tree`, and in what shape.
>
> Here is an initial list:
>
> - need to determine whether a merge will succeed, quickly
>
> - need the tree OID for a successful merge
>
> - need the list of items that conflict...

I think my version is good up to here.

>  , along with OIDs and modes, if the merge failed

Could you clarify what you mean here by OIDs and modes?  For a given
path, are you just looking for a (pathname, OID, mode) tuple?  (In
which case, you'd get the OID of a file that potentially has embedded
conflict markers)

Or are you looking for multiple OIDs and modes for each file?

If you are looking for multiple OIDs and modes for each file
(representing where the content came from on the different sides of
the merge), are you looking for:
  * the OID and mode of each file that played a part in the merge resolution
OR
  * just the OIDs and modes that would have been recorded in the index
had the merge been done by `git merge`?

(Those last two possibilities are usually the same answer, but no they
are not always the same.  The index cannot hold all the OIDs and modes
in various cases and we have to squash them down to three, possibly
tossing some information that might have been of interest to the user.
This can even occur when you have a unique merge base.)

>
> - need a way to provide merge conflict resolutions
>
> And now that I wrote all this, I realize I should have sent it to the
> `merge-tree` thread, not the `merge-tree-ort` thread...

My submission was RFC and you're providing C, so it's all good in my
book.  I'm reading both threads.  :-)
