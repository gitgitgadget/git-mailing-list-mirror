Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F10BC433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0624C64F81
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCLHDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhCLHCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 02:02:39 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A260C061761
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:02:36 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so1299854oor.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 23:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUlLHUlST9FHzk3xDv5Xfcm8YATIQJKZ2uQXopMrFiY=;
        b=S4cc45OlW2VrSv/ZwGY0Z9dUxlMYJ6gc+m7G/BMkMq671jakeAfc34T2oMHBDU+ty/
         yrlS9GNi2gUmDOaWpXGUzOJEGW/rA7mQ68/6BSOOYq6igTmCrGIX7xEckEyHEX/4pTKK
         vL49Y4iwi3iOTD+QRnKE4Oz6q2JpIUzcshATPxwg6xdPlJ0NZ9maQjnXrM67zfGEr23u
         gSFGR6iLYmCpjAoY5GoPh0Zt6rPnD0vk2k+1JV6Nzyui282dsDYKha02tDyzDhEwFTVa
         gqQHkuoR5D+vBckXeIry5wz9d7N/+7XxhgynYhBhRH7Ve1big86GMK4J6WcNHvUOf/5/
         hTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUlLHUlST9FHzk3xDv5Xfcm8YATIQJKZ2uQXopMrFiY=;
        b=quFoR6gplo3a8rn9hZMomz0g0Pb9VejvnnmV5wCns3sdWm6W/ufiIaPzRPCwe/Jn9n
         K253i6tefDbbJtOs3d2AFAxIUcurSH5lWYUA+opdQ9xIURmCpNBFTtUvMrntxxYePpPm
         MM+gvHnsJSCImN0CsYU05TXO99IKFbky5E+OTm4MYrBd8T6YmexcXdE6SR3yWHpZ6cZy
         qlYlRwII0QsBDWVEkKkdjbXVMCN602IJ//LeqcmlYFPREZX9SI7gGDUlgfiu3/mfDHXg
         WtiBY2N7QBEJYVNJLoKB07KS4T6qnmx1zUZF4I9XxWadAmLIQ8eMH6YpQqyH+Z4gdjDy
         G17w==
X-Gm-Message-State: AOAM532ZVez2cEYOBNhqTB0jXjCiQ1xxjnjYBZffZkH2es5EYAh/XGFo
        eO2M32uu6jq+tNQwTGpMNSyEOxaUD9m9J8jK2NMDZd/WLZSMMA==
X-Google-Smtp-Source: ABdhPJxWduG6HvPGWwm76AAf2AGtLzpooTBs7SNilr8lx1nw8DFbb5Ock0cS6oJfyHDxARViaU4VVy7jxCXxK6H+11s=
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr2228013oop.45.1615532555673;
 Thu, 11 Mar 2021 23:02:35 -0800 (PST)
MIME-Version: 1.0
References: <875z1xwznd.fsf@gnu.org> <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
 <87a6r9o1yo.fsf@gnu.org> <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
In-Reply-To: <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Mar 2021 23:02:24 -0800
Message-ID: <CABPp-BF9sfqDfj=4885n_xwMr=2=jtOZOACtnPi=QYdC3G-pgQ@mail.gmail.com>
Subject: Re: [Bug] Stashing during merge loses MERGING state
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Tassilo Horn <tsdh@gnu.org>, Jeff King <peff@peff.net>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 9:21 PM Phil Hord <phil.hord@gmail.com> wrote:
>
> On Thu, Mar 11, 2021 at 12:45 PM Tassilo Horn <tsdh@gnu.org> wrote:
> > >> Or that popping the stash again would also restore the MERGING state.
> > >
> > > This would make more sense: the stash records that part of the state,
> > > and then we make it available again later when the stash is applied.
> > > However, that feature doesn't exist yet.
> >
> > Too bad.
>
> Consider also what happens when `git stash apply` results in a merge
> conflict because of differences between your current index and the one
> you had when you originally saved the stash.  This results in the
> usual merge conflict markers that then need to be cleaned up.
>
> Could we sanely deal with this in a world where we also tried to
> restore .git/MERGE_HEAD when the stash was applied. Something like
> `git stash apply --continue`, possibly after resolving the stash
> conflicts?  But what if we stashed the merge conflict that resulted
> from the stash apply?  I guess it would still work, but the stash
> history would be, um, interesting.
>
> I wonder if a fix could be as simple as recording the MERGE_HEAD as
> the third parent commit of the stash ref. I think that would provide
> all the information needed to put things back, except possibly for
> things like the rerere state, which is also set up during a conflict,
> and other incidentals like .git/MERGE_MSG.  (And it feels like it
> might break compatibility with older versions that don't expect a
> third parent.)

Third parent is already reserved by --untracked to store a "parent"
commit that has all the untracked files added.  So, it'd be a fourth
parent.  Except when --untracked isn't passed we don't need the third
parent, and if it wasn't a merge commit we don't need the fourth...fun
times.

> I would be a bit concerned about the possibility of silently creating
> an "evil merge".  Suppose you stash this conflict on some branch and
> then pop it onto a different one.  I expect we would then be prepared
> to store all those changes from a different branch including existing
> resolved merge conflicts into the new one.  That could be surprising
> and subtle.
>
> But maybe I'm overthinking it.  Wouldn't the stash apply result in
> merge conflicts that would catch out all the troubling parts?

I don't think you're overthinking it; I think this is highly
problematic.  Let's consider the following history (from the
git-rebase manpage):

               o---o---o---o---o  master
                    \
                     o---o---o---o---o  next
                                      \
                                       o---o---o  topic

First, let's consider the case where you don't record MERGE_HEAD when
stashing.  So, you start out on next and run:

   $ git merge topic

but you hit some conflicts and stash it:

   $ git stash push -m "in middle of merging topic"

Note that this would record applying the changes new to "topic" since
"next", with whatever conflicts still exist.  Then sometime later you
check out master, and decide to apply the stash:

   $ git stash apply

What would you get?  Just the changes in topic new relative to next,
but nothing in next that preceded it.  If you record that as a merge
commit with topic as the second parent, you've created an evil merge.


Of course, that was saying if you didn't store MERGE_HEAD somewhere.
But now let's say you did store MERGE_HEAD (== topic) when you
stashed.  What then happens when you go to apply the stash?  If you
really want a merge with MERGE_HEAD, then you need to redo the merge.
So you invoke the merge machinery.  That gives you conflicts anew.
How do you use your stash at this point to resolve the set of
conflicts, even if they were the same as what you got in your original
merge?

Personally, I think we should make stash check for
$GIT_DIR/MERGE_HEAD, and error out if it exists.  I don't see an easy
way to make this behave reasonably.  (Which isn't to say I don't see
ways, but it'd probably involve being able to do a diff since the
point when the merge stopped and recording it, then attempting to
reapply _that_ patch, one that removes conflict markers and such, on
top of a redone merge, possibly complete with nested conflict markers.
But I'm not sure this is sounding like a reasonable level of
difficulty for users to deal with.)

> I think being able to stash during a merge conflict could be very
> useful.  I do sometimes need to get back to a working state
> momentarily and a merge conflict represents a long pole to doing so.
> Similarly, it could be useful to stash a conflicted `git rebase` so I
> could return to it later and pick up where I left off.  Now we really
> would need to store some extra metadata, though, like the todo-list
> and ORIG_HEAD.  And we would definitely need some extra command line
> switch to tell stash (or rebase) that I want to include all the rebase
> state and also "pause" the rebase by restoring to my starting point.
>
> Thanks for raising the issue, Tassilo.  This has obviously given me
> more ideas for things I forgot were missing.
>
> > > I can't offhand think of a reason it couldn't be implemented. It's
> > > possible that it would mess with somebody else's workflow (e.g., they
> > > think it's useful to stash some changes independent of the merging
> > > state, and then apply it later, perhaps while replaying the same or a
> > > similar merge). So it might need to be tied to a command-line option
> > > or similar.
> >
> > Everything breakes someones workflow [1], so an option would be fine.
> >
> > However, I'd suggest to protect users shooting in their foot with a
> > warning and confirmation query for the time being.  I consider myself a
> > quite experienced git user but this stash trouble today came totally
> > unexpected.  And I've asked on #git@irc.freenode.net and got no answer
> > which is totally uncommon.  So I guess that this stash during merge
> > thing is pretty much a gray area.
>
> I don't think we could easily add the warning when the stash is
> applied since we have forgotten the merge existed in the first place.
> So we would have to do it during stash save.
>
> "Warning: You are stashing during a merge conflict and your merge
> state will not be restored by stash apply."
>
> Seems reasonable.

I think it should be an error and abort the stash operation; this is
way too much of a footgun.
