Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD12B2D7
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467983; cv=none; b=N8rZbJTpVhae4cnkZebUOdPm8ZjUl36Sb0nr4z78OiGegPTl6Gc4ZJlm9smqRwGkx8Ut9zGrpVbWuXpZe2GTJL/eZqeUfvUtzg4PgTU1eZGYeUcs1Q15SJUhxHrG9QqEKY5nQMufLnRyZ4d1zecAheb+KdwiT8z0VZ01k+UW4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467983; c=relaxed/simple;
	bh=oDC8Tk3h2zFFOGG5YIh1m0TrljMyT6KaI6NvNlxMQAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWwl3uRZGHQ6apB25oB7cWvGxbjjJbT9G9NlCMoGtutDXFQ/k2oz1QNgl4bJx4wvdakpGEgZkVFOXYuaKinlOkf9ljPJWMkQbE6KztfIyFVwLyuwYBB70cRpqEWmachux5Fnt8rQIFEESvazPNjTryAEnbg+/rH1YWWro9dA+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PwHosCrP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xoPPVqDx; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PwHosCrP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xoPPVqDx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1DAF7A00CB;
	Tue, 23 Dec 2025 00:32:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 23 Dec 2025 00:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766467979; x=1766554379; bh=qO3Tg03io2
	r3Wmn1DtexcopKQgUibrsjK2Ejz0pVobQ=; b=PwHosCrPdLqFNpQlNK1zrwFgEf
	GsJ0+zJE7uDbtURx1HloM3CiTrmbIY0y/eh35MLD66ss+or2BddjXuadurzejHup
	YClZUTTb9Yi/7h7UVOOVWdoQ0UCNdjUvfc65fr1tZn2JwHwjh+TnrelVYMyN8lcy
	OjAsnA4icmFwfi93qEFxffgGeQWuiioUPhwOaE1ZUaaDmolAGLPaRZgdysm0MOPY
	9UQOu4Ab8MFers0y5fSQiPqLtEFtlnaJ1TCY1OqG4izyiuZJH2vd62JEaXNSpoy7
	J81XmlU0yEDPUF7Vl6LVMT6WFEnQzpv5MdW6SDR8VSQ6VNCFDI71Z+Q9g7vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766467979; x=1766554379; bh=qO3Tg03io2r3Wmn1DtexcopKQgUibrsjK2E
	jz0pVobQ=; b=xoPPVqDx/Tk42R9c81cGzdV1nKKnsK7SIadZBMWd9KzgedBx64Y
	zg8SjxEzz7x1HKTDXk4MjMgIZA0Kt3HzgBtPrc3/Kqay4WeyJbWmba/oTR4hmOXm
	dyPGa44uJJb8Z7BVlySXHDZRYd02F+yNSAhsTaX07AHg31ZzbdXw1rRDbYnoKbAi
	vD8yP3fdTotyJC/DI8E0x0RXsqLXNwYCUmMfwJFOQ6gyyTTkidoF7fOM5/5CTppm
	ezhf+Xt8Eex/KSMYUr5jEL5MOq7ladoClC+UUyZrPU8vbzOj97p7xMqIdEcKt4yg
	x580P7/mOrG11l5BVjsLLtOBqGhHn7qZKmQ==
X-ME-Sender: <xms:iylKaV2o0XExq7-f4sfBGixqfzwFUQOzhnm5srfRoAn4mXsfSqdMzw>
    <xme:iylKaTH-chIZPd0RnR3ZTbH1ZEJ5CFHzEWxR-1IC8pG7a8Q-O8GaomZyulNE8z3Ne
    LWEZvXTjmuLKntfyEWkT5yQMOLOY47sflRItoOsavNTR6-CGUId>
X-ME-Received: <xmr:iylKaa5ObGxcKG9pzH1-fjsZnniSDvlfbXoJ5HI9yeSOZkWRjA_4M87yR3I0RPDzxj3SilBCcj2Ts1s0kRhc5QapMRD1UbqGBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iylKaRviVb5Po3cLg4SKLVMNX29soGZH126AE65ViJ4a-QkjPwaR5w>
    <xmx:iylKaT692ruo4hZ3UjRB1NFjpa_m8NCoeXyZbYGBJ8y7IA2QfT9nHg>
    <xmx:iylKaUWV5gkx8JR6-pbb6VzahOyPexJD-sH0iwOdYT2FDFx00WBF6g>
    <xmx:iylKad-f0Fq0JOpKN1fACKUXm5YVM1rdaHZKJ7Hw2HJeEIUPyJ4QOQ>
    <xmx:iylKaWZaldQgt23vAlwGB4hhEMmMgnmxP8kCktOOqUqQB1U4gonoH7kI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 00:32:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
In-Reply-To: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 23 Dec 2025 00:53:37
	+0000")
References: <pull.2138.git.git.1766451217075.gitgitgadget@gmail.com>
Date: Tue, 23 Dec 2025 14:32:57 +0900
Message-ID: <xmqqy0mtpxti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When a branch tracks a non-default remote branch (e.g.,
> origin/feature), git status now also displays how the branch
> compares to the default branch (origin/main or upstream/main).

"now" meaning what"?

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

So if you are following the convention, "now also displays" ought to
be about what the current code without this patch does, but I am
sensing that it probably is not the case.

Start your explanation by decribing what the users see in "git
status" output without this patch.  Perhaps like

    "git status" on a branch that follows a remote branch compares
    commits on the current branch and the remote-tracking branch it
    builds upon, to show "ahead" (i.e. you have built new history,
    while others are not touching it), "behind" (i.e. you haven't
    added any work since you were in-sync, while others have added
    their work on the branch), "diverged" (i.e. you have commits
    that you haven't pushed out, while others have added commits).

That is the "giving an observation" part.  And then describe why
that comparison with a single remote branch may be insufficient to
learn the current status.  Your reasoning might be something like

    When you fork a branch 'feature' from the 'main' branch of the
    remote, but then create 'feature' branch at the remote and push
    there, while you still occasionally pull from or rebase onto
    their 'main', you'd _also_ want to know how much you have
    diverged from 'main', in addition to how your 'feature' and
    their 'feature' compares.  Currently the comparison with 'main'
    is not given.

That's the "discuss your problem with the status quo" part.

Only after that, propose to show two sets of comparison.

> This helps users understand if their branch has drifted from the
> main development line even when it's in sync with its tracking
> branch.

Describe what does it help to know that after that sentence, like
"... to get the feel of when to start thinking about rebasing", or
something.

> The comparison is shown as a separate line after the tracking
> branch status:
> - "Ahead of 'origin/main' by N commits" when purely ahead
> - "Behind 'origin/main' by N commits" when purely behind
> - "Diverged from 'origin/main' by N commits" when diverged

In other words, exactly the same way as what we show with the
tracking branch?

The triangular workflow involves two remote things.  One is where
you pull from to catch up.  After building on top, you push to
somewhere else to publish your work.  This may be a different branch
in the same repository you pull from, or a branch in a completely
different repository.  What you pushed out may be processed by
others and may come back in the branch you pull from eventually to
complete the triangle.

In such a triangular workflow, comparison with these two remote
things may be needed. One with the branch you forked your work from
to know how much work _other_ people added to the branch to learn
when to start thinking about catching up, and with the branch you
are pushing your work to to know how much work you are holding
locally without pushing out.

I am not sure what you mean by the word "default" here, though.

You seem to be using the "what would a new user get when they clone
the remote (by virtue of their HEAD pointing at that branch)", but
I am not sure if that is a good way to determine the other remote
thing to compare with.

Even if one remote branch you pull from (but not push to) has a name
that is not one of those usual ones like 'main', 'master', 'trunk',
'default', you would want to compare with it in addition to where
you are pushing to.  So branch.<name>.merge + branch.<name>.remote
that defines where you pull from is one thing to compare with.  To
learn the other, the destination of a push of this branch, would
involve poking at remote.pushdefault, branch.<name>.pushRemote,
branch.<name>.remote to find out which remote repository it goes,
and then remote.<remote>.push to find out where this branch goes,
but the helper functions to learn all that are already available.

So, I think the topic addresses a good problem, its presentation
needs a bit more work, and its design (not the implementation) of
how to figure out the other thing to compare I am not sure about.

Thanks.
