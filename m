Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7820DD51
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768690594; cv=pass; b=uy6oEQaQcvPlKZDWXoxOirovhZAG869+thaI6mm79QMzcVxn3dKqK/JdLtCwKob9TyjAV0G29GpIARGjH/5QhnVXP92erz0xJYzteXFLmAdzoxLaVla2E4LtIVHtvBMBQyYaI05Hb/r442tYe4uOX+YeZ9cjDCidR8t4PI7m2QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768690594; c=relaxed/simple;
	bh=Waf9yiChnAAA7uxIoDdhzWByE3p3N5BK/LvxcToreMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrehXOO382+RbrKvQdToSgT66X4Jj8xuvOawyK00PKyrZ32pffVNffqvaOfLh3yjwKLZAAnKmTmybUaF2/d12Cs+sbGeGLaYTwW+/TQq6bRvidvnMzfIaqU3rw0ml4/gOdmqnpxDQ1NQB2evjgWavJyya2pi7HfbwRSMhp97230=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjzksVLj; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjzksVLj"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4044d3ff57bso822982fac.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 14:56:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768690591; cv=none;
        d=google.com; s=arc-20240605;
        b=G57EMqzBHH5s5yUEgnZDWSNfHNaX0a3GLxnil/uX/OM2Eso8fhyjeKZGlDCTfwXEHE
         mPuqgDnrsBQ/u/7h3B146P2DfcMFCz+XCGLfrFj7JScuIWx2ld9t4rmkmo478jouEsd+
         pUUKTK9qmW/2eQhcI6IhsKRVUJwNsx+pxaS21SxZRzEUxytfxScflbvNtkFd1+UdvvyJ
         NNC0MJTQzwawLZeRbtkIAkvgso32er5Y+PGDudewjV/VRdDAt/DhrOdb5/ySoES4w55L
         dIgxIWSHxrs4k6vQXZfgCy+cBk9USARD9onVUJU9thcIH64cu05NxLAUdc7R0M5HSQ6K
         6aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1O8VcBV5tWGTpt1M2TXQ0Q8189WX4AEzLYgjSnZ5e8=;
        fh=S0o5QnkKNTj1hJ7JQ9uIE0ow8RFguSj28SD14Eg6a1I=;
        b=VOE4OMiTHbz1n+6WBhHWbMhwVivrmmf3CttHE65ppDJmqqjjDb8zt676W8lVfUh16U
         2vUQHTbM0txGhRmq0/BqWsvMqOcKiznFkJ4M3nNZjdFb3pCIN7UEC1nwxfibjNGzUfjZ
         +8pc465f571yYz63XTNfQOCBkQgIOioQ7wpx2/bWs/RVUvE5LbxaSynlZ2rd358qJGsS
         ij+XXQC8mYov3o1st0H+Dbce+g9gLemuRB8h2ln0Y7MqP+FXEs8VH84KgGZcwYt8Br4E
         lrxk52OIpot4zq5Jpr44iM88t4ocWQJYuNWk2NTsZoOniE+GvvxMjw31MYwmNu+qNeGZ
         8b3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768690591; x=1769295391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1O8VcBV5tWGTpt1M2TXQ0Q8189WX4AEzLYgjSnZ5e8=;
        b=KjzksVLjZEpi/t/QcgyfHFs8m1kjBvHT484Xrb5jk3KbJ23Jx/6VA8sSG6cRNeC/bo
         mlMBSRR3s8+AImUBnjnKSDtioKi5sziXGvW6Mb1KYiG0FwkET9S6P32unmiDEQccDxsm
         m29ZtVa0QIjX/oX1voqfpTna+aiUHu90fwOHN5tkQD5NuqqVW0UwePN2P0ThLzN7NnQs
         UV2EcBwvrm8jSHgOYx04uqtfKDqbYzCkM0ECsg5YYR/93QB2TojizfWOpqWv1oQlJxrW
         lRt24QuUTCBOVsAyBS/p4n/PM4A3k8BtiHbSMEcEPTebZLGdEnOEKtOQH0koWH3kT0CA
         bzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768690591; x=1769295391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1O8VcBV5tWGTpt1M2TXQ0Q8189WX4AEzLYgjSnZ5e8=;
        b=AYvwhY2ymfAlNRDH8sDFTRZtlO4KP7lumM7HBpJ9e6rARM0slvycP0+HXkiJ1PiRPs
         e076N7A06fK+8VjA0ApIVGnacXrK8cCSHGRHIbQUQQ9WOEchP0nbXF4reGZRRQ1pSC2s
         RCSdJmd4DcqnV8TxUhUSIEO9fQ0GDyqMhfGkLWcPMQY1eMSACdAoDkfBdpmyW5CuxXGv
         CGC7v9j2V2Ea1Pp55jz37s7geJUJMgUyGYZ6rpifvYdgMxo20it/0VByP8k7D6Eg/A2l
         xT8NQbImDwaiN8ZtNvshal2V+DeTlQ4UsAkPJL+xqphJoKrgD9M1kdiirp2acMYXXJCL
         BsUA==
X-Forwarded-Encrypted: i=1; AJvYcCWdpjIfp40c85FMADJkArM5+d++iD42z87LhHlRUfKP0o+vKeDvMZBbGV4KzpWXSIIVBvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6tT+PM16+shqOrRU5cDEq16Eu5BBA5iwbVe8QLSZ2uXJucyC
	K+9uf8URsLIaaYODxRwRkcAtJcVyXEDS56vcC//XMST0SYWIaUNyveCMPLQss7vLYw/eZQCO8vi
	xUt9lgYQguql6g4q0X+iuiUbzuQEkhAE=
X-Gm-Gg: AY/fxX4/osxkm5YoFpvF8tBx7Al/7iI4di6zt/zMdWw7BpfiunNXqDICun/N9qWE7oa
	SZW3efxUIwT8B3wAEQK+PBUNQnPgBwpqxv2uKlAZuw7sBLgpRbynMTvXKwbE9NSGWedDLqVimqk
	425MMWM3DR6p6snDg0y1tjlwgINbK2BJRQrfRq8ZGkAjU3xnQD8cipFOrYO4VCh8GjtcW/04prL
	vr1y51oi++SOwJMKnoi/nlD7yqtM74+fVns3uveM92YB17fjwBTWW+wBzI1pJ0msMtSnKnYtBFy
	RX0ThrEhLQNYeiDEYwzRjNN8Aq4r
X-Received: by 2002:a05:6820:2283:b0:65f:7470:38be with SMTP id
 006d021491bc7-661189b1bedmr2570954eaf.61.1768690590829; Sat, 17 Jan 2026
 14:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
 <20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im> <aWpnFqTmWB9XIWUW@szeder.dev>
In-Reply-To: <aWpnFqTmWB9XIWUW@szeder.dev>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 17 Jan 2026 14:56:19 -0800
X-Gm-Features: AZwV_Qjf2ec6iULFHjxoQx7B1EaKNz8Jq6-5NiUndNj4X3-1o6h749B33edQjXk
Message-ID: <CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] builtin/history: implement "reword" subcommand
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git Mailing List <git@vger.kernel.org>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 8:28=E2=80=AFAM SZEDER G=C3=A1bor <szeder.dev@gmail=
.com> wrote:
>
> On Tue, Jan 13, 2026 at 10:54:39AM +0100, Patrick Steinhardt wrote:
> > Implement a new "reword" subcommand for git-history(1). This subcommand
> > is similar to the user performing an interactive rebase with a single
> > commit changed to use the "reword" instruction.
> >
> > The "reword" subcommand is built on top of the replay subsystem
> > instead of the sequencer. This leads to some major differences compared
> > to git-rebase(1):
> >
> >   - We do not check out the commit that is to be reworded and instead
> >     perform the operation in-memory. This has the obvious benefit of
> >     being significantly faster compared to git-rebase(1), but even more
> >     importantly it allows the user to rewrite history even if there are
> >     local changes in the working tree or in the index.
>
> In an earlier round I pointed out some of the differences between the
> 'reword' instruction of 'git rebase' and 'git history rebase',
> including some drawbacks of the latter.  It's disheartening to see
> that you only picked those differences that are in favor of your 'git
> history' command, but neglected its drawbacks.

That'd be https://lore.kernel.org/git/aSVpXPtrqa0cBsEm@szeder.dev/ ,
right?  I see two things you commented on there.  Although I'm not
Patrick, let me respond to each, in reverse order:

Personally, I'm having difficulty understanding your second stated
advantage of picking the commit from the rebase instruction sheet.
That instruction sheet is obtained by rebasing on top of something,
and it seems as easy to me to see the commits since that point in a
git log command and pick your desired commit from log output as it is
to invoke an interactive rebase on top of that base commit to get the
rebase instruction sheet and then pick out your desired commit from
there.  Same number of operations and work either way, so I don't see
how either is more or less work than the other.

You did make a good point that one of the differences is that you
don't have the commit checked out.  That's a useful distinction to be
aware of.  To me, that seems to be somewhat implied already both by
"in-memory" and "even if there are local changes in the working tree
or index", though it wouldn't hurt to explicitly call it out.

> Please strive for less biased and more objective commit messages.

He rewrote the commit message from v6 to v7
(https://lore.kernel.org/git/20251027-b4-pks-history-builtin-v6-5-407dd3f57=
ad3@pks.im/
-> https://lore.kernel.org/git/20251203-b4-pks-history-builtin-v7-5-9e9f849=
bfd0e@pks.im/),
as far as I can tell precisely to respond to your feedback.  Perhaps
he didn't achieve what you wanted, but why jump to the conclusion of
"bias" rather than that he missed conveying an important distinction
as clearly as you wanted?

> >   - We do not execute any hooks, even though we leave some room for
> >     changing this in the future.
> >
> >   - By default, all local branches that contain the commit will be
> >     rewritten. This especially helps with workflows that use stacked
> >     branches.
>
> Please don't just state that all local branches containing the
> modified commit are rewritten, but justify why it behaves that way.

It feels like each of your complaints with the new proposed commands
(given commit not checked out, rebase instruction sheet vs listing
commit, and HEAD-only) can be boiled down to the fact that they don't
behave like `git rebase`.  Is that accurate?  If you like rebase, is
there a reason you are worried you can't just keep using it?  I don't
see why others should be required to implement another exact copy of
rebase, though.  Further, if we only wanted minor modifications, we
could have just done those to git rebase.

If you aren't just arguing to match git rebase's behavior exactly, let
me try to explain the all-descendant-branches thing from my angle.

One of the issues that I've long hated about git rebase is that if you
have multiple inter-dependent branches, it's a royal pain to rebase
them all.  You cannot rebase them independently, because that
disconnects the history by duplicating the shared portions so that you
have N copies of each of those.  And I couldn't see a way to fix that
inside git rebase; its design basically ties you to a single branch.

Further, maybe it'd be useful to explore the different proposed
defaults a bit with the 'history reword' example.  Let's assume we
used your preferred default (rewrite only a single branch) for a user
who didn't like that default.  If a user does a history reword, and
later realizes that their other branches didn't get updated, how do
they fix the others?  They might be inclined to loop over the other
branches and do a 'git history reword CommitZ' on each of them, but
then they'd get the nasty surprise of having N different reworded
CommitZ's (even if they reworded identically), one per branch.
Alternatively, if they are aware that they can't simply reuse the same
command to replay the other branches, they'll then start asking
questions about how exactly to fix up all the other branches...and the
command(s) they need to run is going to be a lot more complicated,
especially if they have since added additional commits on top of the
active branch that they don't want to undo and lose.  It feels like a
hard recovery story.  In contrast, we can consider the case of the
default being to update all branches for a user who doesn't want it.
If that user finds that other local branches were also rebased and
they didn't want them to be, they just go reset that branch or
branches from the reflog, which is pretty easy.

> Git's porcelain commands operate on the current branch, unless the
> user specifies a different branch or an option like '--all' or
> '--branches'.  The default chosen here is inconsistent with the rest
> of Git.

That's a good point that there are existing commands that default to
the current branch.  By my accounting, commands that operate on a
range of commits are:
   "view a range of commits": log, and derivatives like rev-list
   "edit a range of commits": fast-import, filter-branch, filter-repo,
rebase, replay
   "copy a range of commits (or copy their inverse)": cherry-pick, revert

Hopefully I didn't miss any from skimming over 'git help --all'; my
apologies if so.  Anyway, let's consider these commands, in reverse
order:

I'm not sure the "copy a range of commits" provide much of a precedent
for editing a range, since the replay equivalent was always envisioned
to only update a single branch for those despite otherwise being
envisioned as a rewrite-all-branches-by-default thing.  But there's
actually a unifying piece of logic that can lead you to the different
branch handling: we want to avoid having duplicates of commits
simultaneously in use and thus default to as few copies as possible.
That logic means that for "copy a range", we apply them to just one
branch.  The same logic for "edit a range", means to rebase all
descendants on any local branch.

For the "edit a range of commits", filter-branch did default to a
single branch but is deeply deprecated and more or less warns you that
the whole tool was a design mistake.  The replacement (filter-repo) in
its name makes it clear that one of the mistakes was single branch vs.
all branches.  fast-import is also more of an all-branch thing, though
it doesn't so much have a default.  git-rebase does have a
single-branch precedent, but that was called out rather strongly in my
design goals for its newer alternative, git-replay ("Decapitate
HEAD-centric assumptions",
https://lore.kernel.org/git/20230407072415.1360068-1-christian.couder@gmail=
.com/).
If I hadn't viewed the single-branch handling in rebase as a mistake,
I probably would have never created git-replay and instead just
incrementally improved git-rebase.  Since it was that mistake that
lead to new tools in the first place, I'm not sure how much of a
precedent git-rebase should be considered to be setting here.

For "viewing a range of commits", git log does lend towards your
argument; it could be seen as precedent setting in favor of
just-the-current-branch.

So, the precedent seems to not be uniform among git commands, though I
think git log is strongly in your favor.  As a really rough measure of
how much that precedent matters, we can look at how folks have
commented on what they think the default should be so far in this
whole thread:

Rebase-all-descendant branches:
  * Phillip (https://lore.kernel.org/git/91bd9241-96c1-4b34-98a9-af3bad345c=
4d@gmail.com/)
  * Junio (https://lore.kernel.org/git/xmqqms3qh13e.fsf@gitster.g/)
  * Kristoffer (https://lore.kernel.org/git/b3ddfaa4-526b-41e3-b12a-0fec846=
ac7bc@app.fastmail.com/)
  * Ben (https://lore.kernel.org/git/3600D877-4999-4EE3-8C1C-893E12D35B6A@g=
mail.com/)
  * me (this email, among others)
  * Martin (https://lore.kernel.org/git/CANiSa6hxjghKQMhURx8qC2t=3D+1gEE7p8=
YaHbWkg3rYOYa=3DpoVg@mail.gmail.com/)
  * Patrick ("Yup" from
https://lore.kernel.org/git/aKs3tqjE510MF0T-@pks.im/, plus this v11
we're responding to, though he did seem to vacillate over the course
of the series)

Rebase-current-branch-only:
  * You (your email that I'm responding to)

Do not allow editing a commit shared by multiple branches:
  * Matthias (https://lore.kernel.org/git/4m6rmefbv4hftclimitz5rp6yapswjtnj=
sxymrsdkuan4jbg3u@dm5jzdiq5cxz/)

(Sorry if I missed any, I tried to find them all in the threads on
this topic.)

> This is a bad default for any future subcommands implementing common
> history rewriting operations that can cause conflicts.

Totally disagree; we'd want rebase-all-descendant-local-branches for
those commands too.  In fact, that's precisely what I did with "git
replay edit".  (True, "git replay edit" was just a proof-of-concept
because I didn't have conflict handling implemented, but it was very
much an intentional default for a command known to need to deal with
conflicts before being productionized).

Further, we have two semi-independent implementations of
replay-all-descendant-branches-by-default in the form of JJ and
GitButler, with real world use (not just demos) and apparent consensus
that it not only works but was a good decision.

So, I'm a little unsure at how you arrived at this conclusion; do you
care to elucidate?

> Users must remember to specify a non-default '--ref-action' if they
> don't want this behavior.  If they forget to do so and don't notice
> it, the old commits will be gc-ed away.  Therefore, I consider this
> to be a dangerous default that can lead to data loss.

You elided over "for a really long time so that the reflogs expire",
but you bring up a good point.  I think the key here is "don't notice
it".  With "git replay edit", I'd print notices about what was updated
after each operation (particularly important since the operation could
be a `git commit --amend` or `git reset HEAD~1` or whatever, which
causes commits which are the descendants of the one you are operating
on to be replayed).  To avoid the "don't notice it" issue, we could do
the same with Patrick's history command.  We could also prevent a
forgotten --ref-action by allowing a config variable, which I'll cover
more below.

> I firmly believe that operating on all local branches must always be
> the result of an explicit user action.

Over at https://lore.kernel.org/git/aUVaEPGoOkATQGl3@szeder.dev/ , you
alternatively suggested the idea of an "escape hatch".  I think that
may be a good idea.  What if we had a "history.scope" config variable,
with values like "descendant-branches", "current-branch", and
"error-if-multiple-branches", corresponding to each of the requested
defaults we've seen in response to this series?  I can't imagine using
anything other than descendant-branches, and the preponderance of
those who have commented on the default so far seem to be in
agreement, but it would allow you and Matthias and others like you two
to pick an alternative.  Thoughts?
