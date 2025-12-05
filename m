Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D42F7AB4
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924568; cv=none; b=Ww/U9jiCy25BUWw4A51AmJlz7hKNqDNPq0G1s96Z18UdekSbjgaWUDQjx5/QgKjEPhPByssXxl7jRe1Rf5aqfeOjoqixHma+5IL0nK/fRwTVh2IzsQJGSyP6zVbI+PLbnUgBV16J8ao6KsyncBnsrVp1inGR2MLPtYwd9JGECxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924568; c=relaxed/simple;
	bh=rucvAGlY1UAU2zKWVzacVhFC7EOtkUDYuM8pnlcm82U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ql/C0iCskveZNn4eBLE8kunJ1g7Gxy/LWGifJ5iOgmeOhs0Lsu7dEaFLfJesNy0nI+hGeJnMiMtrZ/Idc7loB9l29HzwCr3aZplLqq51rQDhfrxxUSY3rXgTQ3SbMUrTAVm9o3h559+1mLUssXtmfAqynNu2xbofu7GWVWhd8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Z4AQRg; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Z4AQRg"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-44ffed84cccso414659b6e.0
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764924556; x=1765529356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hZe33Lti6vHfaBJiELrascEOWt4o+ZAf9tdnSi7sOA=;
        b=Q4Z4AQRg7J6xwdCW+JcWC9ZVHufJ0KdbENIdT4oNgWcEsYwwLf4uyCHAgkyYeyU8qk
         YSrOD4lE/RgX0ZpYhrmA4RxNfk68BPbC2Hpnm3wc9IIbrEpfDLePbomAFNdLmH9/0oJI
         oBrHEzkvKjbOA9Vu5p8MkqJj0/MhV/0n7zQIYCULmwsqWcNikAFBtRkKALU+751e29bm
         g/M7w4UQ8fun236FqyUcwf70OD/nzMEVCwK3Au+GJkTgBMAU+/LwWjkNbxXD/vuXtVRa
         OL3tmRirGHZQfMH70yv8K8WbKxztF2H5Bl/0A4Ct0wv2RDybonL9/jv4QPTWU8mhLmM0
         xMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764924556; x=1765529356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hZe33Lti6vHfaBJiELrascEOWt4o+ZAf9tdnSi7sOA=;
        b=Kldp1BGFIOV6lKqJd7nCpc+9+6zyLXBkA/2FwZ0bwnR7RoZwbxAr8ju+do+hVsUQab
         Eb5q1f6cTLvDyBySf3uHvFj5+L5bPZcmrA8uLG4b7yBz4KlCYomsUPVnXl3g/2ZhnTy2
         ITq9NhFHXR8HTCZminAq6+Nr1KXJF6+w3++1EXrs3t/uo/tnde7uKk3LM2fN1ULWKxfh
         o4D2yuJAOIN0+3Fe9gJNdsvZYd/qVkX0MVDwcqYwcKpJmJxPRah6jSzsvvEfSXQFAgyg
         FzqSrJx1g7rzK/RTXDzlgHIaYTIse426mxU3gNFqssmR61a0kG9nct+An9dVOd6ejqm6
         XbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ80xzNuBDP9nW1QCj7X9W/GsR086y9H+3nGO2nJ19O1f3c4wYkuxMQKzzgR9qd+rmXjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBIrzdoL9FrWKFPoMO8WB4U4gtXWoonYijQj2s3nk1I+PZ5Uo
	HwPLQAQ8uPrwqvxC1xfTWd+pRs1yr9Zpqn2s4DEN9aHx8sxpWQH/YGbjk6pmRmsbeMflq+E34hl
	oSs8gCSndGGscEAf69wmgmpdFXp+Y7hY=
X-Gm-Gg: ASbGnctPlJm/2LHX2FzVc8VjAAUiMJw8k4F+2urELzXBAWpUi8cGPdrjQdIYNl8JLvO
	P0CHQgCTX5QjpVmRIBY3PurEV0DYM7j/9bpbcTavqovLTBtFs+b+hTISbCzsf6uhun2WZVwviKV
	t3jEDmz+f4ulrD3owe96OWjert/wz9yeuWh57WWi6yaP3JF1yt96WrqBz9M3zearyYLf79mEZ0R
	0sjJgxZESv9PhqClb9cafLRyGPTvbMjTt4Yvhyw9o4QiUNZlgDY0wM7IvaNWgwM5Z+oWp4CapjG
	hnPcCpFKBlxKaJE6u+Xrri38U5gy
X-Google-Smtp-Source: AGHT+IHgPOQUPasjj3TG4M/FrEFXqtU9LfhRnrlZKi2bqbXUQ+vIdHue7JpkAXIHde6lgljdOd/klL3H8ivnwsDXQNo=
X-Received: by 2002:a05:6808:21a4:b0:450:c417:3a99 with SMTP id
 5614622812f47-4536e52b887mr5083912b6e.39.1764924556080; Fri, 05 Dec 2025
 00:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com> <aS80z0DxAEBLba-M@pks.im>
In-Reply-To: <aS80z0DxAEBLba-M@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 5 Dec 2025 00:49:04 -0800
X-Gm-Features: AWmQ_bnDpL3pQvABDyb2bjz59ulLAI6TLSvAndM7rzqsWnofhHEYxaz3rpRo4SM
Message-ID: <CABPp-BFtx7-vLFbVqbHar=UZb1CGX5=ufMA4hrJRkSYuB14_Tw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sat, Nov 22, 2025 at 06:54:00PM -0800, Elijah Newren wrote:
> > On Fri, Nov 21, 2025 at 8:01=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
> > >
> > > Phillip Wood <phillip.wood123@gmail.com> writes:
> > >
> > > >> Granted, I think good progress is being made and perhaps the chang=
es
> > > >> needed for the rest aren't that huge (and maybe there's more piece=
s
> > > >> I'm not quite understanding yet similar to the
> > > >> two-split-patches-always-summing-to-the-original), I was just a li=
ttle
> > > >> surprised that my comments are summarized by "expecting a small an=
d
> > > >> final reroll".  :-)
> > >
> > > It was because I didn't think (and I still do not think) your
> > > comments are something for the immediate future, for a tool that
> > > wants to present its minimum-serviceable experimental version to
> > > users so that the users can experiment, extend it more and fix its
> > > behaviour incrementally.  I may have been probably wrong, but I was
> > > getting an impression from the reviews that it is getting to there,
> > > not the feature-perfect version that needs only maintenance from now
> > > on, but a minimum-serviceable one.
> > >
> > > We could instead of collect all the I want moon and I want cheeze
> > > comments and iterate until the tool has all of them before it hits
> > > 'next', but I do not think it is often what we do to a new feature.
> >
> > You're reading my feedback as feature requests rather than as bugs
> > and/or possible paint-ourselves-in-a-corner situations in the
> > presented implementation?  I must have described things rather poorly;
> > if they were just feature requests, I'd agree we could just implement
> > them later.
>
> The command is explicitly marked as experimental so that we can iterate
> on its behaviour as needed. So I don't think we're painting us into a
> corner yet.

I'm aware it's marked as experimental and even commented on that at
least once in this series.  I'm not sure that's sufficient _in this
kind of case_ for the following reasons:

* Users tend to not have multiple branches sharing commits and then
try to operate on those, it will only come up rarely.  (I still think
it's a very important usecase, just that it's not common, in part
because git has trained people away from this kind of usecase.)
* Since the command is marked as experimental, it might extend the
timeline until we see such uses.
* The implemented behavior is not always a bug, some users will want
it (it's the kind of thing that makes sense as an option).

Combining the above, it might be a long time before folks really hit
this behavior and start pointing out its problems, rather than hitting
them early on.  By then, we don't know how many users we have, just
that it's been a long time, and we are further faced with the fact
that some subset of users have begun to depend upon the existing
behavior.  The combination may make it hard to change at that point.

To me, it feels very much like risking painting ourselves into a
corner.  If it were an issue I felt people would likely hit right away
OR it was an issue which users would always view as a bug, then I'd
agree with you that there's no (or very little) risk with just
proceeding as-is.

> > But maybe I see where the confusion arises, since you were focusing
> > solely on the single branch thing; that's the one issue where it's
> > perhaps not as clear whether I was discussing a bug or a new feature.
> > Let me try to explain that case another way:
> >
> >
> > The early cover letters said they focused on a case where just a
> > single branch was involved, yet they don't check whether there really
> > is only one branch involved for safe operation.
>
> I think this depends on the definition. We _do_ verify that the commit
> that is to be edited is part of the current branch. What we _don't_
> check is that the commit is _only_ part of that current branch.
>
> I'm not sure whether that is something we want. I myself have the same
> commit on multiple branches quite regularly, as I tend to queue up
> multiple dependent patch series. But I wouldn't ever want a history edit
> to affect all of these branches myself, I really only want it to modify
> the branch I'm currently on.

To me at least, that feels crazy.  Rebase was broken for multiple
interconnected or dependent branches precisely because you could only
update one branch, then needed to find the subset of the next branch
not contained in the first as well as finding where to graft that next
set onto in order to manually rebase it, then repeat for the third
branch, and so on.  That's precisely the design mistake that made me
give up on rebase and write something else...and you want to
explicitly copy it?

(--update-refs did come along later to help in the common case that
each new branch fully contained the previous ones, but it didn't help
when you had multiple branches that built on some common base, or had
other interesting topologies, and thus didn't really fix the
underlying problem.)

> > If a user tries to reword or split a commit that is in the history of
> > multiple branches, the current implementation does not check and makes
> > the branches diverge.  Some users may want that, though I suspect most
> > would be negatively surprised.  The commit messages and code do not
> > even discuss this case.  If we merge the code as-is and then later
> > notice and fix this problem soon enough, maybe we'd be fine, but I
> > always worry a bit about a git-switch/git-restore kind of case where
> > it sits long enough and people depend on side-effects in a way that
> > prevents us from fixing it.  Besides, since the bug has been
> > identified and there are multiple not-too-hard ways to fix, I think we
> > should do something.  Some possibilities:
> >
> >   * Document this case and warn users to check on their own (not that
> > friendly, but might be good enough for the first cut).
> >   * Check if the user-specified commit is part of multiple branches
> > and error out, unless the user provides a flag verifying that they
> > want histories to diverge.
> >   * Just rewrite all relevant branches
> >
[...]
> So with the above clarification I wouldn't call any of this a bug, but
> rather working as designed. We could of course still print a warning in
> that case to protect the user, but one problem I see is that generating
> this warning could be quite expensive as we'd now have to walk all
> references. That might be cheap in case the user only has short-lived
> feature branchs. But it may very well not be cheap in case they for
> example have old release branches checked out, as we'd now have to
> potentially walk a significant portiion of history.

Munging user's histories in unexpected ways and depending on them to
figure out on their own that such has happened may well be much more
expensive.  Granted, that's human time rather than cpu time, so it's
not directly comparable, but this feels like a big foot-gun, and I
think big foot-guns deserve good checks and warnings.  I agree there's
a cost here, but I think the cost is warranted, especially since such
an error message would be the thing that frees us to iterate and
define the multi-branch behavior later.

> Consequently I'm leaning more into the direction of doing nothing. It's
> not really clear to me that this is a bug, and we still can introduce a
> flag in the future that opts into the behaviour of rewriting relevant
> branches. That behaviour certainly can be useful, but I'd claim that
> it would be rather surprising to the user if that was the default.

Well, as I stated above, this is basically copying what I view as the
fundamental design mistake of git-rebase.  The many other points of
feedback I had on this series (e.g. extended headers, reusing replay's
walking, etc.) are things I could easily negotiate on; this one
bothers me much, much more.  To me, it ruins the command and makes me
feel it is unsuitable for inclusion in git; this is, after all, the
kind of thing that made me decide to write yet another command to
workaround such a flaw.  If the series is merged with this behavior,
I'm going to be in the awkward position of feeling I need to actively
recommend against its usage unless _and until_ we either

(a) check that a commit is only part of one branch before proceeding,
(b) always require the user to specify with a flag how to handle
commits that happen to be part of multiple branches (even when a
commit only happens to be part of one branch, in order to allow us to
not bother checking whether it's part of more),
or
(c) rewrite all branches that contain the given commit by default
(with an option to only rewrite the current one).

That said, obviously the choice of whether the series is merged isn't
up to me.  And maybe I'm in the minority, and others don't care about
this issue at all.  But it's how I feel about it.
