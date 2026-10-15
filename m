Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF04AB3C8
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103969; cv=none; b=W4nN9rbeT+9bVFr1v/WgRONTHtKs4WYpNMKg0aE3gAeG3V+hjg8VDvdi3TSglxRW+37jWTjfFaVRhjqVExpGMlu+SPM9ooH82s/Os8QVAb/KJNbFtIf6aHzxwvECLDjopHhhJ30lfu22AGZxmvIsk6lmFN3JvqfjpIXjtILlchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103969; c=relaxed/simple;
	bh=rKQEjRcIJxK6+oZPCnmq3nuWZURERQrdP5aa+s6zEMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCQWkeGWBV0Lcxgmrt5UfkJa3q/mpvQktg22FrtDDNGNc3P0jMcKMadg9AH6dIlplnwv/26WoLl77KuH4lLHEr/g9CAAdxB0h1JSYFnFZAS/rovtkwCR7CQwDIiBIWVOESrpP71FHD7IgYrD3t/pv5kb4lxy5Y88E35B+J6icIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Njx4Hpri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0XYbhj3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Njx4Hpri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0XYbhj3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E6C91D00163
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 18:39:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 18:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792103965; x=1792190365; bh=H7CepotfLV
	DCurLuoTMPoi82WcAecdz8YlMQ84z5+eg=; b=Njx4Hpri+IAI4D731A2ciD1Jva
	H9DS3MCsvu/SVFb6hmXDha9HplQFqMBuqhxiqQLEKYIwW48SV4YEuNaqDYqJqpan
	JWw+a1Y2nuRQ4qotoIVmxGD9XX+6BWE30d034tfZeosh5/ioTboDXauAUd0jdXRy
	QKmbKXay/fa9bcij9qZ4Pwb3XzkO5LqaXn+POlFPekxzIEGbU6d4DUAAAV2pzk2e
	as2RPNfJpOyACpCQ/5dgJBJIGboebzMDGNH9tUleyfzf1iy+C+nb35WmjZ1UeLbZ
	wChxdQuY/Z3ks7XtOQ7CqNdgc/RFQcJuSq+allqsOpDHA/28JH7ornropq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792103965; x=1792190365; bh=H7CepotfLVDCurLuoTMPoi82WcAecdz8YlM
	Q84z5+eg=; b=t0XYbhj3KF21X7rSp3RloksSg/5amYaDsii0WWDpKvRhGelZ6n/
	aANc1qZjziCtRrkh843bZ1ODavr9YZuKF8KE7XjtOYgMMSzGh4/VAKg/I/ZTTLfh
	Gdg/ZgffKNG3ryfsVR78KFai38RJYtxEbGutvVfoBinpssy+Mk0w78yWmDrZgWbC
	palY38WCy+BeaNYF+4kogdlS2X5ZKHMVk8E3QFVdTLxOWwQRUtKyOngWnFtKq2Y0
	ZpshsTyPpdsepTQVbQCm8oxK3WOsZ2mphSL3M1NiFbdbDhXzGPb8eL4jJei4kE5K
	8/fKgdq6JSYbDi3PILrDrpwfXMOAIFEeXNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792103965; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FYDGeRqaFH++NCkyyt4MFzUWKQsGXsryIbXtDsIxxpBnBNB
	dj4+5z9UoiMDdAlo5RP6EBCFssnT+oWRE/PB82gNmRic8WFe52wL+b3LScNP+WYy
	IUIiEJcDVo4ZHRPpAKng6xYizKrYMncMoSx7wu3aBvVmmCxixKkftyQl1AU+odlB
	QKtM9w5+4gzzEoXzoV+bZJO5OL6TTJcCCC+gY5k7Uw3Ayiki6OIAqDXUivgSgqqt
	XOa8Rv3P6XbNRaNONR1NMHN5OhzSe2jtvJaPLLAN5/Y+D0Wzv/k4GojE3xBfQjtg
	THMg3wfYuiqPxDw0IfznMLn98IA2l27oVsdSxkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:i5QcYgQ4BSEo7O+7okAkLXZsVoASfy8Ykk1s7p2wHFM=:rKQEjRcIJxK6+oZPCnmq3nuWZURERQrdP5aa+s6zEMg=;
X-ME-Sender: <xms:HVbRahewka0hTApHmqbcETOomNNHuYB_ehOtUGnXNdMpU3o-lZVt5w>
    <xme:HVbRamGKnS2z5silWvjLCXXr_lQT_uQDUE0vnpSWdxIQEAqjS-Ov1z-qhluAA4zIk
    ry7GfuKe4Aop87oY8Jz7xWOB1LIj8HaF3SmuSmgtgXcbAPP1342rX8>
X-ME-Received: <xmr:HVbRai2k5UhWtJ53wfMqIwoPI46xB3ol8PeCgFHsx5e_-93fvpqyh3FHRUJekdIa17H8yM4OkjFWgNTe6jMEmNkQJQNKW4xrzN8f>
X-ME-Proxy-Cause: dmFkZTGDiViIXr7ewpxqmLwggDZaIYldpgRSx6/qfeyuT/K2Ntba/r94yTC55gdmKuRt91
    PqfqB6q/3ItV1mcuYq8BU81Q0MkmWs1mAx8kXwONjpuj4apHoGktWoi7VM0cMcG4sm+qdJ
    j/dJTR5xLUOGf+sLJLkbkzZ7K2d3r91UYiJSQfaBRN712G3KJC39ptgtf9FF/xq459OQfk
    5nb+uwMzqaChHzGt6wHKOPQVAq/q7iwaQErYUWKakfxflMR0aA8Iz5+04MxrAfzU57TZ87
    ilGP+uXcHRzSF7cnm9LAcqrzo0Tn+3fuIqRD2xaq0aVDPlPikLGuNTdsvpluEOsL8iSFZq
    2NVwyQ69X0lSyEDiPy8RP3rf80BEkzBG+0L0Iug0W9l5drjUQa28edXK1Xp+Jbk6e65PLu
    wrNh0g7w4AMFnkZbx+5R3LfFIxwa03rQGo89xFyXP6xdOGThURAZOAHR9ZzOvX68VpRUdy
    SkNZq2tvF3B10+5XZC/Q/DDrge0qFI4E7Sjl2YMxw02Zg16CFRkmgM5qhtgsfeaWaNcvfs
    mdq3OBkVyWxFjDoH0gayZfBbF71kjlxh+Fokb+1PpZTeEwwYvW4lHoE0N33K6tBZbOYu7j
    hnVcKt/MT/HhUTQv+NwGGJ5sUHGdC5aCWieHVZHABWvx4qi9C+S/Psf7yuzA
X-ME-Proxy: <xmx:HVbRaml_ZEDBVoArZb_Q06wSN8aYQOsjaY3Lj9sPcN_1jmIvl66rYw>
    <xmx:HVbRaq9SJG3ZW-ly0W9D9_OxlJGBc1sIEbxQJoSphl-ibqFJglo-Ew>
    <xmx:HVbRajrIEBqto-pzbWTOmm6kayaCOl8srntssuIgCnWf6fpZGbwolA>
    <xmx:HVbRarmkumRXsDRisTtUbSUPjT-mNk7omKtW4KUh8zFI-XqWcmdbAg>
    <xmx:HVbRauUkBJiUZiJG3fS_srUMGHKGu8OdrJNGZf7XccLlqJWNfVDuqSlp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 18:39:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Thu, 15 Oct 2026 20:58:02 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 15:39:24 -0700
Message-ID: <xmqqecdqk2qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     non-changes: Left these phrases alone because I don't think the proposed
>     changes would make it more clear.

Those who contributed their time to review this document did so
believing they were suggesting improvements.  Simply dismissing
their feedback as "style" in 'v2' without explaining what you
disliked about their suggestions is unhelpful.  It is hard to know
what to make of a dismissal that lacks any supporting reasoning,
other than "I don't think".

> diff --git a/Documentation/detached-head.adoc b/Documentation/detached-head.adoc
> new file mode 100644
> index 0000000000..d8e59e10c6
> --- /dev/null
> +++ b/Documentation/detached-head.adoc
> @@ -0,0 +1,57 @@
> +`HEAD` is where Git stores your current branch or commit. `HEAD` can either be:
> +
> +1. A branch, which is your current branch.
> +2. A commit ID, when you don't have a current branch.
> +   This is called "detached HEAD state".

Differences between v1 and v3 did not make much improvement in this
area, though.  The phrase "branch or commit" highlights the
distinction, but it fails to clarify what is common to both, which
is equally important.

Perhaps restarting from something along this line

    HEAD records the state from which your current changes started.
    This can be a branch (the "current branch"), or it be a commit,
    (in which case HEAD is "detached").

and polishing further may take us to a better end state.  An
important distinction that is not captured in the above (or your
version) that we may want to cover is that when you are on a branch,
your changes will grow that branch, and when you are not on a
branch, your changes will not affect any branch and stay temporary.

> +It can sometimes be useful for `HEAD` to be a commit ID.
> +For example, it lets you easily look at an old version of your code
> +(with `git checkout COMMIT_ID` or `git switch --detach COMMIT_ID`).

We should use a verb stronger than "look at" to emphasize the
primary advantage of having the entire state visible in the working
tree.  If a user merely wants to read or inspect a single historical
file, they can do so easily without moving their HEAD by running
'git show COMMIT_ID:path/to/file'.  Checking out a commit allows
something much more powerful.  It restores your entire working
directory to that exact state.

    In the detached HEAD state, you can safely build, run, and
    experiment with any historical version of your codebase, without
    having to worry about clobbering your branches, and you do not
    have to clutter your repository with temporary branches.

I said "safely build, run" because you had "old version of your
CODE" in the paragraph, but if you can give examples outside the
programming area, that would be even better.  E.g.,

- Writers may able to rebuild and locally preview a complete
  historical version of a book or documentation site to see how
  cross-references and formatting rendered at that time.

- Game Designers may open an entire historical scene in an editor
  (like Unity or Blender) where assets, textures, and coordinates
  must all exist in a precise, interconnected state to load
  correctly.

- Data Scientists may execute and reproduce a specific historical
  data pipeline or model run using the exact combination of scripts
  and datasets that existed on that day.


> +There are 3 main ways you can end up in detached HEAD state:
> +
> +1. `git checkout COMMIT_ID`, where `COMMIT_ID` is a commit ID
> +2. `git checkout v1.3`, where v1.3 is a tag name
> +3. `git checkout origin/main`, where `origin/main` is
> +   a remote-tracking branch
> +
> +Checking out a tag puts you in detached HEAD state because `HEAD` can
> +only be a branch or a commit, not a tag or any other reference.
> +So `git checkout TAG` will set HEAD to the commit for that tag.

A more standard phrase for "the commit for that tag" is "the tagged
commit".

Because we will recommend "switch" to be a way to require to be more
explicit when users mean to go into the detached HEAD state soon
below, I think we would want to move the "checkout <COMMIT>" and
"switch --detach <COMMIT>" description to here from the earlier
"sometimes useful" paragraph, to complement the above list of ways
to detach your HEAD.

> +If you switch branches after making commits in detached HEAD state, Git
> +will warn you that you might be about to "lose" those commits and print
> +out the commit ID. You can also always find those commits later using
> +linkgit:git-reflog[1].
> +
> +Here's what that warning looks like:
> +
> +-------------------------
> +Warning: you are leaving 1 commit behind, not connected to
> +any of your branches:
> +
> +  48c09f6 3
> +-------------------------

Your readers can guess that the 7 digit hex may probably be the
commit object name you are about to lose, but you should use a bit
more realistic descriptive title, not "3", to avoid confusion.  I
know many users do not write a good log message, but even a single
word "bugfix" is better than "3" ;-)

