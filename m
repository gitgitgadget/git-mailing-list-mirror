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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2215C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C492405B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 19:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395517AbgLKRj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 12:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395451AbgLKRj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 12:39:28 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C546C0613D3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 09:38:48 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l200so10651001oig.9
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 09:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StBzJSgbr7irCnJHDDQsDU0oImZvPkNOIFHpoCpKbss=;
        b=YJE++THtlQhQ5a8ElNS35c5n0O6REYGLcmA00OWuRFt9Gev5nmMUWeKtcN6vmfW/+D
         HWS2wjETCsxsR1c0zqRxxDwlPLrRFsvaME02Vopgnqaw5fuoJkjFEMEif4zANxKiqqyF
         QfErsOT93RiGGRprBrOiz+U9GmjIGwFYAoYwzpoI/y98X0uwoCz65BYnR+I8ukB/ShJt
         JpofulBSPLuE/6A6Q1a6gOZNtNsmZV1obCo0z2027IUr4fDCKh0A7UpNMn2NtrXG8nWP
         S1nL7vNKLo/Ot4ikt55KTgA9q9UWZYE4vicvMmPSj7wXK/sOFaOZhhMrM1Uw4BscgSgl
         ztPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StBzJSgbr7irCnJHDDQsDU0oImZvPkNOIFHpoCpKbss=;
        b=qn4c/tsV4egIZhqRvrT/V3x15kbreDDDm0d/J5FV+pi1Hk8yVydX/whzV2bTPFI0GE
         hmHFG0O1n3AJ6QKtrrHVpE2phSnFdbnH7qZOBST5FaPdBd6kFx6e/OLBO5e8ScunmjxG
         jDXaPiB3NCQLyNskjtF8REcdoKHi6kocacs8fjcqhIU/1pxPoeJuY2Mk1kGBrR9rJsNB
         O6u2xAWD0eUB+6HGxtfoRfTY0KKv5pRy6obj+WPAEeN/qQgB4oYmcPPkoZHgJqcuBLC6
         Zu8ZZKgAAnTmN4PiBkUn0Ekt+/GCdD9iX4yachGXfQELgqUQB2sP4L7EDuGI+7te2b0Y
         MJFw==
X-Gm-Message-State: AOAM531DuPGIj+QkZS4+4LTzj0aVAPFPMezWr8afqCi8HZC2pXU1La/s
        wabaHFmDC2sO8rv9ODtb6J0RcTRAJAWLUuswI5O1wr0h9ZSjGQ==
X-Google-Smtp-Source: ABdhPJzPU7+6hpwyHgrz9U6gqkuV/s6PrJzRouwdu4ui0PMXof2Y3KZ+IJXW5ITJTj6DprauTU5T/b9TNomeSFjGVW0=
X-Received: by 2002:aca:e083:: with SMTP id x125mr10164605oig.31.1607708327605;
 Fri, 11 Dec 2020 09:38:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <ba30bc8686ef11115b369d351b4447c75a7bb9b5.1607542887.git.gitgitgadget@gmail.com>
 <59863009-1a11-ba74-fdd3-6271977b6ec9@gmail.com>
In-Reply-To: <59863009-1a11-ba74-fdd3-6271977b6ec9@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Dec 2020 09:38:35 -0800
Message-ID: <CABPp-BGwPOgBFGtptUTAF=yVczTeW+dvQCNKVeZS4Hej0r5=kg@mail.gmail.com>
Subject: Re: [PATCH 03/11] merge-ort: implement detect_regular_renames()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 6:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Based heavily on merge-recursive's get_diffpairs() function.
>
> (You're not kidding, and I should have looked here before making
> some comments below.)

I can provide some extra background on all the crazy magic numbers and
non-sensical treatment of tiny values, though.  And since you were so
curious about these, I have an excuse to dump more info on you than
you probably were bargaining for...  :-)

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 92b765dd3f0..1ff637e57af 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -634,7 +634,33 @@ static void detect_regular_renames(struct merge_options *opt,
> >                                  struct tree *side,
> >                                  unsigned side_index)
> >  {
> > -     die("Not yet implemented.");
> > +     struct diff_options diff_opts;
> > +     struct rename_info *renames = opt->priv->renames;
> > +
> > +     repo_diff_setup(opt->repo, &diff_opts);
> > +     diff_opts.flags.recursive = 1;
> > +     diff_opts.flags.rename_empty = 0;
> > +     diff_opts.detect_rename = DIFF_DETECT_RENAME;
> > +     diff_opts.rename_limit = opt->rename_limit;
>
> I assume that opt->rename_limit has been initialized properly
> against merge.renameLimit/diff.renameLimit in another location...

Yes, see init_merge_options() and merge_recursive_config() in
merge-recursive.c.  People using merge-ort will nevertheless be using
some functions out of merge-recursive.c...for now.

> > +     if (opt->rename_limit <= 0)
> > +             diff_opts.rename_limit = 1000;
>
> (I made the following comments before thinking to look at
> get_diffpairs() which behaves in an equivalent way with this
> "1000" constant limit. I'm not sure if there is a reason why
> this limit is different from the _other_ limits I discovered,
> but it might still be good to reduce magic literal ints by
> grouping this "1000" into a const or macro.)

I'll discuss the value of 1000 later...

> ...and this just assigns the default again. Why is this done
> here instead of inside the diff machinery? Also, wouldn't a
> diff.renameLimit = 0 imply no renames, not "use default"?

Yes, I totally agree that would make more sense, but backward
compatibility sometimes requires violating common sense.  See commit
89973554b5 ("diffcore-rename: make diff-tree -l0 mean -l<large>",
2017-11-29).  For the same reasons discussed in that commit, I'm
hesitant to change what is used here; it's a backward compatibility
concern now.

One reason opt->rename_limit could be 0 is if some caller does the following:

   merge_options opt;
   memset(&opt, 0, sizeof(opt));
   opt.ancestor = ....;
   /* forget to set opt.rename_limit */
   merge_incore_nonrecursive(&opt, ...);

The most likely reason for a negative value is probably that
init_merge_options() in merge-recursive.c set opt->rename_limit to -1.
Having init_merge_options() set the value to the actual default
probably would have made more sense, but the
assign-it-to-negative-one-and-deal-with-it-later goes back to the
introduction of init_merge_options() in 2008.  Actually, if you ignore
init_merge_options() the same thing was being done before back in 2007
as soon as any limit handling was introduced to the code.

Since init_merge_options() is shared for now between merge-recurisve.c
and merge-ort.c, any updates I make here would necessitate similar
code updates to merge-recursive.c.

Also, it's not just internal code callers.  Someone could set
merge.renameLimit or diff.renameLimit in their repository (or their
global .gitconfig) to a non-positive value and get this behavior of
treat-non-positive-as-whatever-the-default-is.

> I notice that the docs don't make this explicit:
>
> diff.renameLimit::
>         The number of files to consider when performing the copy/rename
>         detection; equivalent to the 'git diff' option `-l`. This setting
>         has no effect if rename detection is turned off.

See also https://lore.kernel.org/git/20180426162339.db6b4855fedb5e5244ba7dd1@google.com/
where we talked about documenting the special value of 0 (in that case
for diff -l, though merge.renameLimit should have one too), but we
obviously never got around to it.  Yet.  (I did at least put it on my
projects list, though things sometimes languish there for years.)

> but also too_many_rename_candidates() has this strange
> default check:
>
>         /*
>          * This basically does a test for the rename matrix not
>          * growing larger than a "rename_limit" square matrix, ie:
>          *
>          *    num_create * num_src > rename_limit * rename_limit
>          */
>         if (rename_limit <= 0)
>                 rename_limit = 32767;
>
> this is... a much larger limit than I would think is reasonable.

The value of 32767 came from backward compatibility and in particular
from the exact same commit referenced above -- 89973554b5
("diffcore-rename: make diff-tree -l0 mean -l<large>", 2017-11-29).

Also, perhaps this value is *smaller* than reasonable -- I've used
values like 48941 before on real world repositories.  (And I'm not
picking a random large value to report; *that* exact value came up
enough times that I remember that particular one.)  If 0 (or negative)
is supposed to mean "large", then shouldn't it handle values people
use on real world repositories?  (Not that I care that much, because I
think the usage of 0 to mean "large" is kind of illogical, so I'll
avoid it and discourage others from using it.)

I do know where the 32767 came from, though.  Once upon a time, 32767
was "the biggest supported value possible" and in fact any other
number was silently capped to 32767.  This of course led to a number
of issues.  See commit 9f7e4bfa3b ("diff: remove silent clamp of
renameLimit", 2017-11-13) and perhaps also commits b520abf1c8
("sequencer: warn when internal merge may be suboptimal due to
renameLimit", 2017-11-13) and d6861d0258 ("progress: fix progress
meters when dealing with lots of work", 2017-11-13).

> Of course, diff_rename_limit_default is set to 400 inside diff.c.
> Should that be extracted as a constant so we can repeat it here?

I think it makes sense to have merge have a higher default rename
limit than diffs.  I can see folks just doing a "git log -p" and not
wanting individual commits to take a long time, especially since it's
not at all clear that most the commits are going to be of interest to
the user.  In contrast, when merging, the commits are definitely of
interest to the user, and spending a little more time on a few commits
provides a nice payoff.

Also, merges provide progress meters on rename detection; I don't
think that log -p does.  I think that the presence of progress meters
makes it easier to deal with larger values as well.

It may also be worth noting that both of these numbers were modified
in the same commit in the past and retained distinct values; see
commit 92c57e5c1d ("bump rename limit defaults (again)", 2011-02-19).

After all my rename optimizations, all those cases that used to
require limits in the 20k ~ 50k range can now all complete with a
limit under 1000, and quite rapidly.  (It was really hard to get one
of them under 1000, though.  It stubbornly required a value of 1002
until I figured out another optimization allowing me to avoid
detecting more renames without any change in behavior.)  It's nice
that it's fast, and it's also nice that rename detection just works
instead of having the merge throw a warning that the limit was too
low, doing the merge all wrong, and expecting the user to undo the
merge, set the limit higher, and redo it.

400 definitely isn't high enough.  I'm actually tempted to double the
1000 to buy more room.  Since the last bump was about a decade ago and
noted that processors had gotten faster, since the bump before it
perhaps it is time to bump it again.

All that said, it could possibly make sense to define 1000 as a
special constant near the top of the file and then use it via whatever
macro/constant/variable name we give it.  Such a change would make it
harder to compare this patch to get_diffpairs() in merge-recursive.c,
though...

> > +     diff_opts.rename_score = opt->rename_score;
> > +     diff_opts.show_rename_progress = opt->show_rename_progress;
> > +     diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> > +     diff_setup_done(&diff_opts);
> > +     diff_tree_oid(&merge_base->object.oid, &side->object.oid, "",
> > +                   &diff_opts);
> > +     diffcore_std(&diff_opts);
> > +
> > +     if (diff_opts.needed_rename_limit > opt->priv->renames->needed_limit)
> > +             opt->priv->renames->needed_limit = diff_opts.needed_rename_limit;
> > +
> > +     renames->pairs[side_index] = diff_queued_diff;
> > +
> > +     diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> > +     diff_queued_diff.nr = 0;
> > +     diff_queued_diff.queue = NULL;
> > +     diff_flush(&diff_opts);
> >  }
> >
> >  /*
> > @@ -1379,6 +1405,10 @@ void merge_switch_to_result(struct merge_options *opt,
> >                       printf("%s", sb->buf);
> >               }
> >               string_list_clear(&olist, 0);
> > +
> > +             /* Also include needed rename limit adjustment now */
> > +             diff_warn_rename_limit("merge.renamelimit",
> > +                                    opti->renames->needed_limit, 0);
>
> I suppose this new call is appropriate in this patch, since you assign
> the value inside detect_regular_renames(), but it might be good to
> describe its presence in the commit message.

Sure, I can add a note.
