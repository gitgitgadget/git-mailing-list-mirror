Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265B27A127
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430389; cv=none; b=nSxRr+ybOnZYF1zHuy7Y9PekH7/DAd52MxESLhXVz8MI3rqnEibx6OSTIhjT0309eMqkcEuAQdX5/F/W8Ad2cfMHwNEveqy/2G9Ri5KGJHIZHYN8IS1JiESGNgV0p6nwGdbns83SHnFx+wgeET9EU1ZrDQHF6aEzcz/A3SCPBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430389; c=relaxed/simple;
	bh=XLGrfiBFl1Z4ScU4xfV1EmCJkF4Sng6P5GCJBUcAONU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BliroiTgoMIUzREC5fmSIcHrXXYnUeu00+BTY20BryVwF0Kr+Ol7ewwwzr4DK9ogvG5X/L2Sl691+/anS5CprMfsOTT6GqcV8HVMJnxsiKWA2iiKpjDBNLsZYzSFvFnZhBkaid6aIBoNyUGOa/7JkLhuxAzTgghEzCAplTL1V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IKd2JOtv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E/WSknw0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MwZkHIHZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jfqb1ST1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IKd2JOtv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E/WSknw0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MwZkHIHZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jfqb1ST1"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0817E1F745;
	Thu,  2 Oct 2025 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759430385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=51VAMvY9SeldrwdD63+7dxvVTyVM0FNNUslAclq0mxU=;
	b=IKd2JOtvhNbcLhhQknQLCZj2yrEjIsLYBjhb616Iy5KZbkGMEJP/27F4uVk/NaSPdgEwFc
	UtldRl6ARbv7TTKcKAPLU8LjIE+tT1WGxN8q14nKz3GfKm/jd+s7zLa654Y3+c0h/ZXiZy
	3F6oOaIGsfOP8sqMOjBExB0Uga60Ybw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759430385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=51VAMvY9SeldrwdD63+7dxvVTyVM0FNNUslAclq0mxU=;
	b=E/WSknw00IY3/Elyvf/15HW2aFxAAPylUnJGSzC0H/+cKaCxpIewlkYHM+8Wg5CMZtt+EP
	i1KYI3g3+de8y3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759430384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=51VAMvY9SeldrwdD63+7dxvVTyVM0FNNUslAclq0mxU=;
	b=MwZkHIHZBbg8ExS4hCigVMCgqY78YzgyuuYGJKC3Cb2oHz6h90nnVkqVIAcK2AUW7AC2Dg
	qgPV5+wPZ2vj8NlArV0Tut38vwmH7IAjyQueOEUCsQK6FrNmBAAYwL3iICZc4JWnOQQaiq
	uncVeXfp+lPDL/mpmiuR5dpenQkrY1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759430384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=51VAMvY9SeldrwdD63+7dxvVTyVM0FNNUslAclq0mxU=;
	b=jfqb1ST1DBv5QKndSjn04IrZfDYblb/0pu8+zeB0xz3iEwsBxHUhjMiRWu+mTF3XsCQXTl
	9nLqX7H0VTyuH3Ag==
Date: Thu, 2 Oct 2025 20:39:42 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 2/2] doc: git-worktree: Add side by side branch checkout
 example
Message-ID: <aN7G7p2LNUCSHlaY@kitsune.suse.cz>
References: <xmqqseg1xwc1.fsf@gitster.g>
 <1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
 <xmqqcy75w531.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy75w531.fsf@gitster.g>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sunshineco.com,gmail.com,proton.me,jcubic.pl];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On Thu, Oct 02, 2025 at 11:06:58AM -0700, Junio C Hamano wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
> 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  Documentation/git-worktree.adoc | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> > index ec31863aec..122b191ff9 100644
> > --- a/Documentation/git-worktree.adoc
> > +++ b/Documentation/git-worktree.adoc
> > @@ -525,6 +525,16 @@ $ popd
> >  $ git worktree remove ../temp
> >  ------------
> >  
> > +Side by side branch checkouts for a repository using multiple worktrees
> > +
> > +------------
> > +mkdir some-repository
> > +cd some-repository
> > +git clone --bare gitforge@someforge.example.com:some-org/some-repository .git
> > +git --git-dir=.git worktree add some-branch
> > +git --git-dir=.git worktree add another-branch
> > +------------
> 
> It is a good example to have a bare clone and get worktrees attached
> to it, but I do not think that it is a great idea to call that bare
> clone ".git".  It makes it confusing if that some-repository/
> directory that has a ".git" directory is a non-bare clone with no
> working tree files, or if it is a directory that Git has no
> knowledge about, that happens to have a single bare repository plus
> worktrees.  The answer is the latter, but I suspect that Git itself
> would probably be confused (i.e. "cd some-repository && git status"
> ---if you try it, what does it say?).

git status
fatal: this operation must be run in a work tree

> Naming it after the project may make it more apparent what is going
> on when the user goes into that top-level shell directory, perhaps
> like this, if we were working with a "bunny" project:
> 
>     mkdir bunny
>     cd bunny
>     git clone --bare gitforge@someforge.example.com:some-org/bunny bunny.git
>     git --git-dir=bunny.git worktree add some-branch
>     git --git-dir=bunny.git worktree add another-branch
> 
> Then when you "cd bunny && ls", you'd see the bare repository
> bunny.git with two checkouts.

That also works.

> 
> Having said all that.
> 
> I know some folks like such a layout for some (perhaps ideological)
> reason (i.e. no checkout is more special than others, everybody is
> equal), but I am not absolutely sure if it works better in a larger
> workflow in practice than having a primary worktree that is not a
> bare repository.  If you do the above with a non-bare repository in
> the center, it would look like this:
> 
>     mkdir bunny-project
>     cd bunny-project
>     git clone gitforge@someforge.example.com:some-org/bunny main
>     cd main
>     git worktree add ../my-topic-1
>     git worktree add ../my-topic-2
> 
> and have my interaction with the upstream project only from inside
> the primary worktree, i.e., "main".  Additional worktrees are more
> or less ephemeral, and can go away.

Yes, that's a possible use case. Also git worktree add
/dev/shm/do-some-testing

However, that's not the intended use here. Rather it's one worktree per
branch, no branch switching as a result. I recall some VCSes had this
as default or only way to work with different branches, and not
switching branches all the time certainly has its advantages.

Thanks

Michal

> 
> > +
> >  BUGS
> >  ----
> >  Multiple checkout in general is still experimental, and the support
