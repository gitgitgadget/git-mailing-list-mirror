Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FEC10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9F0222D9
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 22:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2yBBj10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgCJW4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:56:46 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40705 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJW4p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 18:56:45 -0400
Received: by mail-pf1-f202.google.com with SMTP id d127so27889pfa.7
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hq33Vfp9HXdOt063ladOLTWRwzfGOhilT/DFhZGr7x8=;
        b=l2yBBj10wsG8hV+DJrOkzmmZvW5WNq6mjWqCPF6k5F5REzyHiG2V5qzSLZFh2Oua4T
         WASyToc1KCXYd0ABm+hpZZI2lJ1GCK0PMU1I5QziJ3Q/FZ1hmgxHnDtqd1mEiYmgYhzJ
         yPiQFGNeOQCnSwBaYyBzox7SBkGf/bUemO9eHy6qwIh13a7sAYMVkMwGlG+daZXaU9Sl
         qMWfiuuYmNnB9T1j9Wz9xsdbjxK30B9s/udWfIKJNHj0kMKH6Lpo+hj421hajhcZ3joE
         8ZmpPug4EbQ89oe+Gf2gnNNJe/zUzXIuPp7ufGmMPBcrU5AUR8LT2q7wVeFNey32Dna8
         vtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hq33Vfp9HXdOt063ladOLTWRwzfGOhilT/DFhZGr7x8=;
        b=W74FlGvepcFBvBv07oj+3ixgOkVLVnQm52gCp5AZNjq4eRzznG8Gfl6WxR/ySQu54Y
         BRvFAd8DrBMiyq2FLYcaxfsCqoq7WjmVrtdNGA+sxM8F8S9BXlc8uzkkJwzzX3ef4eOe
         4DgteymzhB1EftjJu5Q3LUWfVqWXok3xg5YFYwwDjkJOE/019Pz63eUhq7GTsghFx7i7
         JtB89NA+L5U8o+DopS8X1RKVOh0ArFw87wM5VOvDIpuvlRwJkytAWEMUXJU2lFyM5bUE
         HLjZfG9S6ok7yc5z04fHQmJtYaTpXOufMKOLky7G9zNl4k+XnAoJU5KEJ6ZvkytlNrHH
         BDQg==
X-Gm-Message-State: ANhLgQ1tfm/7xdyXsz/lKMRLMNsp7jIxlDnZo42ZCCR5VcTl1zCRCcnf
        jE/V0aMjt8jCTF2XPHHnBgC8NamzW6lrVmFlCKEf
X-Google-Smtp-Source: ADFU+vtEeYxP1hg7MO6C8V/LH6343J7Jv5faYkuvhpxlrOJGz2JXYe7yA3IvOLXjUzkF5mtTJwYarj3vCLa5rDOtDpJG
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr255851pji.23.1583881004456;
 Tue, 10 Mar 2020 15:56:44 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:56:41 -0700
In-Reply-To: <CABPp-BF17qYVZE6BWEh56QYKGojDG6yNz8QawX14XD8zeR=jig@mail.gmail.com>
Message-Id: <20200310225641.96556-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BF17qYVZE6BWEh56QYKGojDG6yNz8QawX14XD8zeR=jig@mail.gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Mar 9, 2020 at 1:58 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > When rebasing against an upstream that has had many commits since the
> > original branch was created:
> >
> >  O -- O -- ... -- O -- O (upstream)
> >   \
> >    -- O (my-dev-branch)
> >
> > because "git rebase" attempts to exclude commits that are duplicates of
> > upstream ones, it must read the contents of every novel upstream commit,
> > in addition to the tip of the upstream and the merge base. This can be a
> > significant performance hit, especially in a partial clone, wherein a
> > read of an object may end up being a fetch.
> 
> Does this suggest that the cherry-pick detection is suboptimal and
> needs to be improved?  When rebasing, it is typical that you are just
> rebasing a small number of patches compared to how many exist
> upstream.  As such, any upstream patch modifying files outside the set
> of files modified on the rebased side is known to not be PATCHSAME
> without looking at those new files.

That's true - and this would drastically reduce the fetches necessary in
partial clone, perhaps enough that we no longer need this check.

In the absence of partial clone, this also might improve performance
sufficiently, such that we no longer need my new option. (Or it might
not.)

> Or is the issue just the sheer
> number of upstream commits that modify only the files also modified on
> the rebased side is large?
> 
> > Add a flag to "git rebase" to allow suppression of this feature. This
> > flag only works when using the "merge" backend.
> 
> Interesting.  A little over a year ago we discussed not only making
> such a change in behavior, but making it the default; see
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1901211635080.41@tvgsbejvaqbjf.bet/
> (from "Ooh, that's interesting" to "VFS for Git").

Thanks for the pointer! Dscho did propose again to make it the default
[1] and I replied that this can be done later [2].

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2003101315100.46@tvgsbejvaqbjf.bet/
[2] https://lore.kernel.org/git/20200310160035.20252-1-jonathantanmy@google.com/

> Yes, I've wanted to kill that performance overhead too even without
> partial clones, though I was slightly worried about cases of a known
> cherry-pick no longer cleanly applying and thus forcing the user to
> detect that it has become empty.  I guess that's why it's a flag
> instead of the new default, but there's something inside of me that
> asks why this special case is detected for the user when other
> conflict cases aren't...  Not sure if I'm just pigeonholing on
> performance too much.

I haven't dug into this, but the email you linked [3] shows that this
behavior was once-upon-a-time relied upon ("For example, when I did not
use GitGitGadget yet to submit patches..."). So I don't think we should
change it.

[3] https://public-inbox.org/git/nycvar.QRO.7.76.6.1901211635080.41@tvgsbejvaqbjf.bet/


> > I've only implemented this for the "merge" backend since I think that
> > there is an effort to migrate "rebase" to use the "merge" backend by
> > default, and also because "merge" uses diff internally which already has
> > the (per-commit) blob batch prefetching.
> 
> I understand the first half of your reason here, but I don't follow
> the second half.  The apply backend uses diff to generate the patches,
> but diff isn't the relevant operation here; it's the rev-list walking,
> and both call the exact same rev-list walk the last time I checked so
> I'm not sure what the difference is here.  Am I misunderstanding one
> or more things?

Maybe just ignore the second half :-)

I thought and wrote the second half because I noticed that somewhere in
the "am"-related code, blobs were being fetched one by one, but no such
thing was happening when I used the "merge" backend. The rev-list
walking doesn't access blobs, I believe.

> > +--skip-already-present::
> > +--no-skip-already-present::
> > +       Skip commits that are already present in the new upstream.
> > +       This is the default.
> > ++
> > +If the skip-if-already-present feature is unnecessary or undesired,
> > +`--no-skip-already-present` may improve performance since it avoids
> > +the need to read the contents of every commit in the new upstream.
> > +
> 
> I'm afraid the naming might be pretty opaque and confusing to users.
> Even if we do keep the names, it might help to be clearer about the
> ramifications.  And there's a missing reference to the option
> incompatibility.  Perhaps something like:
> 
> --skip-cherry-pick-detection
> --no-skip-cherry-pick-detection
> 
>     Whether rebase tries to determine if commits are already present
> upstream, i.e. if there are commits which are cherry-picks.  If such
> detection is done, any commits being rebased which are cherry-picks
> will be dropped, since those commits are already found upstream.  If
> such detection is not done, those commits will be re-applied, which
> most likely will result in no new changes (as the changes are already
> upstream) and result in the commit being dropped anyway.  cherry-pick
> detection is the default, but can be expensive in repos with a large
> number of upstream commits that need to be read.
> 
> See also INCOMPATIBLE OPTIONS below.

I understand that commits being already present in upstream is usually
due to cherry-picking, but I don't think that's always the case, so
perhaps there is some imprecision here. But this might be better - in
particular, documentation and code will not be so clumsy (the "no", or
0, is the status quo, and the lack of "no", or 1, requires special
handling).

> > +       if (!options.skip_already_present && !is_interactive(&options))
> > +               die(_("--no-skip-already-present does not work with the 'am' backend"));
> > +
> 
> with the *apply* backend, not the 'am' one (the backend was renamed in
> commit 10cdb9f38a ("rebase: rename the two primary rebase backends",
> 2020-02-15))

Thanks. Will do.

> Should there be a config setting to flip the default?  And should
> feature.experimental and/or feature.manyFiles enable it by default?

As above, I think this can be done in a separate patch.
