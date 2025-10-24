Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F72586E8
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300955; cv=none; b=ooF6rBBiVswXVTPHC2b1ksyi9T6mtc7S9voEjiqFZz1pzXmnu2d5OI7CpEMJ3rfdhzBhryGMfypcn4fLsA9Sps6hxMnaK+JWJo5uGBhxKjdxQoCHTiWB8AGtrkVIbad6RsPl/yMFFZYiwVI3WZN4vwayuVQ0y+k3yCLtBVBhPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300955; c=relaxed/simple;
	bh=6jqq+KjVpXazfrIAGyYC8VXBbaL7vMSmJ42NxLZ1pKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTq39b55ogoTTtD7HRxLUg3QSxhZ2kT5Zayt6JjDr3i5HeQhctgLlmceWnykurbZDs6JGyKkw1WcSDX0h/xGyrVuKIWe3NmjPS5aBjFSC/JGN2P0jeYsDLwAu9Cusmt6N777Ab+rASC/WiO35MLIaYH/rmNclwNdr0lQJxHhbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fsnqx/tC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E42mYHfY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mNQao9Hv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fE8Bdk7x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fsnqx/tC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E42mYHfY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mNQao9Hv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fE8Bdk7x"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F102E1F454;
	Fri, 24 Oct 2025 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761300947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE/6LyA/WulcZ/U9fXfsvEyoBbhTzrH4tcJ36h07D3g=;
	b=Fsnqx/tCSDgySMsuPO2FfSnhp3wL1LcQezRW46uz1SQBf1WefF1tKSLa4Fdh8gfah/sKNV
	Cpy9FQNlMaH2akP4v53YmqlB9Byooi++YUOevBJW4v0thXGksk2mP83s8M325SYFfFmujP
	ZF2J6XZFzE8jMfQu2RZjOr1LoWYU/B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761300947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE/6LyA/WulcZ/U9fXfsvEyoBbhTzrH4tcJ36h07D3g=;
	b=E42mYHfYYtIc0BD/u+7ygOXquD1Gl2yZxRM8h5AG2zuynz5yoVlbvhLk5qyEsMzQVDA8QP
	mNUlzOxKHrMfdrDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761300943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE/6LyA/WulcZ/U9fXfsvEyoBbhTzrH4tcJ36h07D3g=;
	b=mNQao9Hvt0ToNlbgATR8o6BFzSSdxdwW9wTAQL+Ww74uoC5was/DvOA4YeKRGZgDpU3caB
	cruEb4jHfJFd0aKn+4oy0Auv7ihoV+OZNQGdX9TZvayOZyR8cLX/OU4uT1B/XiWmdlNMPs
	289LBuGSxb8wSq55i9B3zo5bDzFYPz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761300943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bE/6LyA/WulcZ/U9fXfsvEyoBbhTzrH4tcJ36h07D3g=;
	b=fE8Bdk7x0RYTWos7DBNvcgwo2U9xLNadD9LJf5T5eiG47ltvuwS5bX4UkADV7XUTyKMr4H
	renD9V7EIKyhi5BA==
Date: Fri, 24 Oct 2025 12:15:41 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
Message-ID: <aPtRzTwVgVfqjaZT@kitsune.suse.cz>
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
 <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.979];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,pobox.com,proton.me,jcubic.pl];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Sat, Oct 11, 2025 at 01:17:47AM -0400, Eric Sunshine wrote:
> On Fri, Oct 10, 2025 at 1:05 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > doc: git-worktree: Add side by side branch checkout example
> 
> Thanks for taking my suggestion[*] regarding a possible git-worktree
> documentation update and turning it into an actual patch. This is a
> reasonable beginning, but I think it needs more work.
> 
> To begin, the idea was to document that worktrees can be used with
> bare repositories, but neither the subject of this patch nor the prose
> added to the documentation itself mentions bare worktrees. Instead,

So it's not documented to start with. I did not read the whole text,
only focused on the problem with adding worktrees in problematic places.

That sounds like more general update of the file is needed, also for
the prevoius patch.

> they mention only "side by side branch checkouts", but I'm not even
> sure what that means. I certainly wouldn't think of "bare repository"
> when given the phrase "side by side branch checkouts", and I'm pretty
> sure that phrase is not part of the existing Git lexicon, whereas
> "bare repository" is, and is well known and well understood. So, I
> think both the commit message and the prose added to the documentation
> ought to mention "bare repository" instead.
> 
> Next, I think it is quite important that we spell out concretely in
> prose that worktrees can be used with a bare repository. It is not
> sufficient to merely infer it by giving an example, especially if the
> reader is primarily reading the git-worktree.txt introductory material
> which explains what worktrees are all about. So, for instance, we
> could expand the "The new worktree is called..." introductory
> paragraph to instead say something like this:
> 
>     This new worktree is called a "linked worktree" as opposed to the
>     "main worktree" prepared by git-init(1) or git-clone(1). A
>     repository has one main worktree (if it’s not a bare repository)
>     and zero or more linked worktrees. Linked worktrees can also be
>     used with a bare repository, in which case there is no main
>     worktree but *only* linked worktrees (see EXAMPLES).
> 
> and also move the "When you are done with..." sentence from that
> paragraph down to the "If a working tree is deleted..." paragraph,
> which would become:
> 
>     When you are done with a linked worktree, remove it with `git
>     worktree remove`. If a working tree is deleted without using `git
>     worktree remove`, then its associated administrative files, which
>     reside in the repository (see "DETAILS" below)...
> 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> > @@ -526,6 +526,16 @@ $ popd
> >  $ git worktree remove ../temp
> >  ------------
> >
> > +Side by side branch checkouts for a repository using multiple worktrees
> > +
> > +------------
> > +mkdir some-repository
> > +cd some-repository
> > +git clone --bare gitforge@someforge.example.com:some-org/some-repository some-repository.git
> > +git --git-dir=some-repository.git worktree add some-branch
> > +git --git-dir=some-repository.git worktree add another-branch
> > +------------
> 
> Several comments...
> 
> First, as mentioned above, rather than using the phrasing "side by
> side branch checkouts", let's talk about this as being an example of
> using worktrees with a bare repository.
> 
> Second, for consistency, let's follow the lead of the existing example
> in git-worktree.txt and show the "$" shell prompt preceding the
> commands. For instance:
> 
>     $ mkdir ...
>     $ git clone ...
> 
> Third, the example seems overly complicated, especially with its use
> of `--git-dir`, which feels less discoverable (at least to me) than,
> say `-C`. What I have in mind is an example more like this:
> 
>     $ git clone --bare <repository-url> myproj.git
>     $ git -C myproj.git worktree add feature-a
>     $ git -C myproj.git worktree add feature-b
> 
> That should be more than sufficient to get people up and running with
> associating worktrees to a bare repository.

That creates a mess. First part is not creating the directory to contain
the worktrees related to the repository. Second is creating the
worktrees inside the bare repository, contrary to any reasonabe usage
advice.

Thanks

Michal

> 
> [*] https://lore.kernel.org/git/CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com/
