Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A69C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A12410A
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 21:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391593AbgLKUFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 15:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgLKUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 15:04:32 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493AFC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 12:03:52 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id l207so11210054oib.4
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47Bpk/M41yXT7qgDEUq0CP3pKNjiSPn+M3NAXRStxFk=;
        b=htBuv/8K9p3eTr4G87o/CzTvkUu9oqGbdcLs2lm4K+pn1J+HJVWkVBL0vz9eVCWO8F
         8IxtGHPdgQgD50vBW44sGEQ06yn8UuPg7ONGDeUdjmzkX4OC2hD2wDj5zMTd0SGD74iQ
         wUvvLBs/ElCfY8TgJVf/fYcwuXzdu4mGuQuanpwpmav+NcglX/6rVBBAxMDF0uspWGh+
         tCgDr1AOzG9YjXKOxdP2EI/xy49DJ9UQyDspFow3ML6EG3bis4QGYUZWC9pT8VCIeIrN
         5T1npu5a0R6CcW+T9OQDaqDTCR9War6vW2XdedNiYNrpEXWrOxit5RGKpWMBkuTyavUI
         q0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47Bpk/M41yXT7qgDEUq0CP3pKNjiSPn+M3NAXRStxFk=;
        b=LIOfiHdyUdi8g+IMFgGiz0PmdACIStqMN0O6/0YQR4yVwnwSNxE6pYm4rgul2DjwLt
         nRvVQ8plMLNASXojE9uUGt/HS4Y4BYzuKHInfO4t4fU3p/Fd1uxdeb1kjtrdSri+yeTo
         CqaEk7MZDqsHEdzEVwVsF0P/Ftlnoe4YQ17eT7IsPue4NucZuRQ/z5Q0IWGUMg2hQhrd
         GyVVm9uz1Qo7MpsF2/iFL3iS7IgLafcPml8SbmAukfL6KdfjiR8CUihhamluRLpexiWw
         4/dtz+bwcqUtgiy3rUJxl1zJ9DWJKwp2rJrHzBfgJvF7Q3LVveWKHSXakSVMQu3oEnMW
         ua2g==
X-Gm-Message-State: AOAM532QOy6Hf9ydoId2aQLDR6pEp9emFWLc0OJQjhzuolwImTeyVRwl
        YJd8s9255amJ0p1qFgr7A2SLIiS5WD4oMRHJJWU=
X-Google-Smtp-Source: ABdhPJymMQRzt499Pmb+VdPbbBtuvXOsfnzpYBz5vqorwEOC0xRmH4S4tCU4IhMjSPcLossVNrN2V5kmVFV/Dhsrzc8=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr10366908oic.167.1607717031350;
 Fri, 11 Dec 2020 12:03:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <35b070b9b7c495caed758362dcdaa61b724c1644.1607542887.git.gitgitgadget@gmail.com>
 <3691e3f1-8840-9b19-5fff-02fcb846de70@gmail.com>
In-Reply-To: <3691e3f1-8840-9b19-5fff-02fcb846de70@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Dec 2020 12:03:40 -0800
Message-ID: <CABPp-BHoYFnJLNr6g11QBVcdMNBjJYOQoXPz31+gCrYhwnK01g@mail.gmail.com>
Subject: Re: [PATCH 05/11] merge-ort: add basic outline for process_renames()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 7:24 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Add code which determines which kind of special rename case each rename
> > corresponds to, but leave the handling of each type unimplemented for
> > now.  Future commits will implement each one.
> >
> > There is some tenuous resemblance to merge-recursive's
> > process_renames(), but comparing the two is very unlikely to yield any
> > insights.  merge-ort's process_renames() is a bit complex and I would
> > prefer if I could simplify it more, but it is far easier to grok than
> > merge-recursive's function of the same name in my opinion.  Plus,
> > merge-ort handles more rename conflict types than merge-recursive does.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 3cdf8124b85..faec29db955 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -620,7 +620,103 @@ static int handle_content_merge(struct merge_options *opt,
> >  static int process_renames(struct merge_options *opt,
> >                          struct diff_queue_struct *renames)
> >  {
> > -     die("Not yet implemented.");
> > +     int clean_merge = 1, i;
> > +
> > +     for (i = 0; i < renames->nr; ++i) {
> > +             const char *oldpath = NULL, *newpath;
>
> This "= NULL" is not necessary, since you initialize it to
> old_ent->key unconditionally.
>
> > +             struct diff_filepair *pair = renames->queue[i];
> > +             struct conflict_info *oldinfo = NULL, *newinfo = NULL;
>
> These, too.

Oh, man, so many frustrations here.  You are, of course correct.  The
reason it's here, though...

The code I took this from is a bit more complex due to directory
renames, cached renames from previous steps (think of rebases or
cherry-picks, where there was a rename from the old base to the new
base), and trivial directory resolutions.

In the more complex code, the initializations aren't needed either;
the variables are never used uninitialized.

BUT certain versions of gcc don't recognize that they are never used
uninitialized and throw errors saying they might be.  Newer gcc
versions recognize that everything is kosher and compiles fine, but
IIRC, the CentOS 7 version of gcc does not.  I want the code to
compile there under DEVELOPER=1 too, and I couldn't find an easy way
to restructure to make it clearer to the compiler.  So I was forced to
add these useless initializations.

...and I just didn't think to rip them out for this preliminary patch.


I can rip them out if you want, but I'll be forced to add them back
later -- in patches where code flow analysis will also suggest it
isn't needed.

> > +             struct strmap_entry *old_ent, *new_ent;
> > +             unsigned int old_sidemask;
> > +             int target_index, other_source_index;
> > +             int source_deleted, collision, type_changed;
> > +
> > +             old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
> > +             oldpath = old_ent->key;
> > +             oldinfo = old_ent->value;
> > +
> > +             new_ent = strmap_get_entry(&opt->priv->paths, pair->two->path);
> > +             newpath = new_ent->key;
> > +             newinfo = new_ent->value;
>
> This is moving data around. I wonder if there is any possibility that
> old_ent or new_ent could be NULL here, and we should check for that?
> (The "any possibility" is probably "is there a chance of a bug in the
> earlier logic that didn't cause a failure yet, but would cause a SEGFAULT
> here?".)

Good question.  The only chance at this point in the code of this
happening is if someone has introduced a severe bug in the code
elsewhere.  Any paths that show up in rename detection have to come
from the trees, and in collect_merge_info() we walk over the full
trees and store every path from any of the trees in opt->priv->paths.

Once directory rename detection, caching of renames, and trivial
directory resolution are added to the mix, it suddenly becomes
possible for these to be NULL.  So, the version on 'ort' does have
checks.  This just represents me trying to find chunks of the code
that can be submitted upstream in a fashion where each piece makes
sense.

> > +             /*
> > +              * diff_filepairs have copies of pathnames, thus we have to
> > +              * use standard 'strcmp()' (negated) instead of '=='.
> > +              */
> > +             if (i+1 < renames->nr &&
>
> nit: I tend to prefer "i + 1".

You might have to keep reminding me; I think I've got more of these in
various places.  I'll fix it up, though.

> > +                 !strcmp(oldpath, renames->queue[i+1]->one->path)) {
> > +                     /* Handle rename/rename(1to2) or rename/rename(1to1) */
> > +                     const char *pathnames[3];
> > +
> > +                     pathnames[0] = oldpath;
> > +                     pathnames[1] = newpath;
> > +                     pathnames[2] = renames->queue[i+1]->two->path;
> > +
> > +                     if (!strcmp(pathnames[1], pathnames[2])) {
> > +                             /* Both sides renamed the same way. */
> > +                             die("Not yet implemented");
> > +
> > +                             /* We handled both renames, i.e. i+1 handled */
> > +                             i++;
> > +                             /* Move to next rename */
> > +                             continue;
> > +                     }
> > +
> > +                     /* This is a rename/rename(1to2) */
> > +                     die("Not yet implemented");
>
> Interesting that you chose to do some internal logic to split this
> case, but have both die(). Perhaps that is wise, but also this could
> have been a die() at the start, along with the pathnames[] initialization
> in a later patch that implements the 1to1 case (leaving the 1to2 case
> to die()).

Yeah, that'd also be a fair way to split up the patches.  Doing this
the way I did above allowed me to separate the conflict detection and
conflict handling patches -- later patches in the series were allowed
to focus on "this is how rename/delete is handled", "this is how
rename/rename(1to2) conflicts are handled", etc.  Your split would
mean combining the detection and handling logic for at least one of
the conflict types into the same patch.  That'd still work fine, but
it just wasn't what I came up with due to my focus on the
detection/handling split.

> > +                     i++; /* We handled both renames, i.e. i+1 handled */
> > +                     continue;
> > +             }
> > +
> > +             VERIFY_CI(oldinfo);
> > +             VERIFY_CI(newinfo);
> > +             target_index = pair->score; /* from append_rename_pairs() */
>
> Hm. I don't see append_rename_pairs() anywhere else in the codebase.

Oh, whoops, that function doesn't even exist in the 'ort' branch
anymore either.  pair->score was set in collect_renames(), in the
previous patch.  It was set to the side index.  Looks like I at least
documented it once on one side of its usage.

> Do you mean record_rename_pair()? But in that case, I don't understand
> the following assertion:
>
> > +             assert(target_index == 1 || target_index == 2)>

See collect_renames() setting of p->score to side_index.

> > +               other_source_index = 3-target_index;
>
> nit: "3 - target_index"

Yep, like I said, you'll have to keep reminding me.  I will fix this up.

> > +             old_sidemask = (1 << other_source_index); /* 2 or 4 */
> > +             source_deleted = (oldinfo->filemask == 1);
>
> This oldinfo->filemask check made me go to the declaration to find
>
>         /*
>          * For filemask and dirmask, see tree-walk.h's struct traverse_info,
>          * particularly the documentation above the "fn" member.  Note that
>          * filemask = mask & ~dirmask from that documentation.
>          */
>         unsigned filemask:3;
>         unsigned dirmask:3;
>
> Perhaps I've missed my window to complain about this comment pointing to
> a comment in another struct definition instead of something like:

It would be nicer placed in as a comment on patch 1 of
en/merge-ort-impl[1].  But it's definitely not too late -- that series
is still in 'seen', you reviewed an earlier round of it[2] (sadly ALSO
labelled as v2), and it was mostly waiting for you and Jonathan to
give a thumbs up on whether you were happy with the changes I made to
the series[3].  Feel free to say that my changes to that series looks
okay, except that I need to update the description for filemask and
dirmask.  :-)

[1] https://lore.kernel.org/git/2568ec92c6d96dc51aff4a411900eaec8d32ce27.1607114890.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/75170ee7-525e-31fc-f6bd-6dfac12b00c8@gmail.com/
[3] See final portion of
https://lore.kernel.org/git/CABPp-BGcyRURykePOafjcE1z9J8U5awF=PZw1ufx+8Ow+k3j3w@mail.gmail.com/

>         /*
>          * The ith bit corresponds to whether the ith entry is a file
>          * (filemask) or a directory (dirmask). Thus, filemask & dirmask
>          * is always zero and filemask | dirmask == 7 always.
>          */

The first part of this comment looks great.  The last part is false,
though -- the ith entry might not be either a file or a directory.
For example, if the merge base had a file that both sides deleted,
filemask == 1 and dirmask == 0.

I'd be happy to use your wording before the final "and filemask |
dirmask == 7 always" bit, but I think it'd be nice to also keep a "see
also tree-walk.h..." comment,

> And of course, looking at this struct provides the justification for
> using "1" and "2" for the "sides" and wasting the 0th value, because
> it is consistent with the three entries here, using 0 as the base.

Yaay, looks like I didn't need to convince you after all!  At least
not on that point...

> Thus, the comment about not using the 0 position could use a reference
> to these triples. I still think that using an enum would help here.

I'm genuinely curious about your thoughts on the various other
questions I raised about that point in the earlier patches to this
series and your thoughts on my other suggestion there.

> Coming back to the line in question, "filemask == 1" _does_ mean that
> the file exists only in the base. Deleted indeed.

There's going to be a lot more of these later, especially in the basic
conflict handling series...  :-)

> > +             collision = ((newinfo->filemask & old_sidemask) != 0);
> > +             type_changed = !source_deleted &&
> > +                     (S_ISREG(oldinfo->stages[other_source_index].mode) !=
> > +                      S_ISREG(newinfo->stages[target_index].mode));
> > +             if (type_changed && collision) {
> > +                     /* special handling so later blocks can handle this */
> > +                     die("Not yet implemented");
> > +             }
> > +
> > +             assert(source_deleted || oldinfo->filemask & old_sidemask);
> > +
> > +             /* Need to check for special types of rename conflicts... */
> > +             if (collision && !source_deleted) {
> > +                     /* collision: rename/add or rename/rename(2to1) */
> > +                     die("Not yet implemented");
> > +             } else if (collision && source_deleted) {
> > +                     /* rename/add/delete or rename/rename(2to1)/delete */
>
> How did we get to three actions here? I'll probably learn when
> it is implemented.

Multiple actions that appear unrelated on one side suddenly get glued
together after the other side's rename detection.

rename/add/delete comes about like so:

Base version: file A exists
Side 1: deletes A, adds unrelated B
Side 2: renames A -> B

rename/rename(2to1)/delete comes about as follows:

Base version: file A and file B both exist.
Side 1: delete A, rename B->C
Side 2, rename A->C

(You could also have rename/rename(2to1)/delete/delete if side 2 also
deleted B, but it doesn't present any additional complications for the
code.)

You can find all kinds of crazy rename cases in t6422 and t6416.
"mod6" is fun.  Perhaps I should add a comment somewhere referencing
these testcases?


...and if you're really curious...

All of these conflict types were much worse with merge-recursive.c,
because sometimes each code path had to consider the combination of
all possible conflicts.  Thus if you were ever worried about a
rename/rename(1to2)/content conflict/file location/(D/F)/(D/F)/
appearing[4], there might need to be a single specific codepath that
handled all of those simultaneously.  merge-ort makes these more
orthogonal.  For example, one place in merge-ort handles all
directory/file conflicts, regardless of what other conflicts they are
part of, whereas in merge-recursive there was directory/file conflict
handling code shotgun blasted everywhere and probably missing from
several specific conflict types.

[4] You can read this conflict as: both sides modify a file in
conflicting way ("content conflict"), both rename that file but to
different paths ("rename/rename(1to2)"), one side renames the
directory which the other side had renamed that file into causing it
to possibly need a transitive rename ("file location"; for example, if
one side renamed A -> B/C, and the other side renamed B/ -> Beta/),
and each side puts a directory in the way of the other's path (each of
the "D/F", e.g. if the side that renamed B/ -> Beta/ also added a
Beta/C/ directory to be in the way of A getting renamed to end up
there).)

> > +                     die("Not yet implemented");
> > +             } else {
> > +                     /* a few different cases... */
> > +                     if (type_changed) {
> > +                             /* rename vs. typechange */
> > +                             die("Not yet implemented");
> > +                     } else if (source_deleted) {
> > +                             /* rename/delete */
> > +                             die("Not yet implemented");
> > +                     } else {
> > +                             /* normal rename */
> > +                             die("Not yet implemented");
> > +                     }
> > +             }
> > +
> > +             if (!type_changed) {
> > +                     /* Mark the original as resolved by removal */
> > +                     oldinfo->merged.is_null = 1;
> > +                     oldinfo->merged.clean = 1;
> > +             }
> > +
> > +     }
> > +
> > +     return clean_merge;
>
> I'm glad you separated out this case organization from the implementations.
> It's still a big dense, so I'll probably need to revisit as I see you fill
> in the rest.
>
> Thanks,
> -Stolee
