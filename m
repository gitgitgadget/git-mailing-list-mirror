Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187F277813
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431347; cv=none; b=ZVOhOWfitsrg+YP3GbWw2vtkQRsfCuRT5ZP71zbBFl8gBvBlvNYCHTSmlz/mp+5eDG5a9WsUVA6tkeAoa93ENcE6MZc0eN2MDHPjaNK8qPKjmUAz0hjYLdMiFxw2xar3gSizEShT4l04g4abug+uUMbdR3DD6Vthoysj5lfbnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431347; c=relaxed/simple;
	bh=mCBSFDcgLmJ/VnbRSmc+doceyty0g72GnPJxV96BmJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/CMofiZVItZ6fbdXUShdTazlCrl2RYVehvbc/1HuqmzeQEwQLw7cPnBtj34TtVGY5e9PQXxvTxZSm7vsEbfyThgf16cSZh2fnXxXyf6HBtSwnugihOShv2wMLWFqax4FsTX3Tb+wTNPYKqQ9WgwPpqhfeoqlhHk/WDGkXAhq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EJXJBq6s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fGrT7dYr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EJXJBq6s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fGrT7dYr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EJXJBq6s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fGrT7dYr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EJXJBq6s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fGrT7dYr"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 659131F745;
	Thu,  2 Oct 2025 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759431343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36diM4DJMVndPf20+9VKqOU/Eu5Wl7Ggydgn34OD9FY=;
	b=EJXJBq6sIlbRasagth5ItXmOuYzaLncZlep2SgkHgu7mw9Cwq7gCgPPUu95dA7kh7nyt0p
	TJLRs6kz9jM2/v7dpmQv6cGdID09GSJTGm2rHUlrhBHe7PEHi66R6wF8nByAnc6CZYiLsZ
	3zwUu28ClJjPbr16qlEYm3PjNJClbkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759431343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36diM4DJMVndPf20+9VKqOU/Eu5Wl7Ggydgn34OD9FY=;
	b=fGrT7dYrk/5iZHuKAojIzBGrlji/h138yi2F09GMEgik3Wxl5EyuFoaFhjwRRwDVhjw3Ur
	IdcZAWoTdxU4beCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759431343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36diM4DJMVndPf20+9VKqOU/Eu5Wl7Ggydgn34OD9FY=;
	b=EJXJBq6sIlbRasagth5ItXmOuYzaLncZlep2SgkHgu7mw9Cwq7gCgPPUu95dA7kh7nyt0p
	TJLRs6kz9jM2/v7dpmQv6cGdID09GSJTGm2rHUlrhBHe7PEHi66R6wF8nByAnc6CZYiLsZ
	3zwUu28ClJjPbr16qlEYm3PjNJClbkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759431343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36diM4DJMVndPf20+9VKqOU/Eu5Wl7Ggydgn34OD9FY=;
	b=fGrT7dYrk/5iZHuKAojIzBGrlji/h138yi2F09GMEgik3Wxl5EyuFoaFhjwRRwDVhjw3Ur
	IdcZAWoTdxU4beCA==
Date: Thu, 2 Oct 2025 20:55:42 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 1/2] doc: git-worktree: Link to examples
Message-ID: <aN7KrnF0KohlKtuN@kitsune.suse.cz>
References: <xmqqseg1xwc1.fsf@gitster.g>
 <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <xmqqo6qpw655.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6qpw655.fsf@gitster.g>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sunshineco.com,gmail.com,proton.me,jcubic.pl];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On Thu, Oct 02, 2025 at 10:44:06AM -0700, Junio C Hamano wrote:
> Michal Suchanek <msuchanek@suse.de> writes:
> 
> > Also add advice to put new worktrees outside of existing ones.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  Documentation/git-worktree.adoc | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> > index 389e669ac0..ec31863aec 100644
> > --- a/Documentation/git-worktree.adoc
> > +++ b/Documentation/git-worktree.adoc
> > @@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
> >  $ git worktree add --track -b <branch> <path> <remote>/<branch>
> >  ------------
> >  +
> > +For best results it is advised to specify <path> outside of the repository and
> > +existing worktrees - see <<EXAMPLES>>
> > ++
> 
> I am wondering if we cram more information in "For best results", by
> adding the "otherwise...".  Here is my (failed) attempt.
> 
>     Use <path> outside of your working tree and existing worktrees
>     (see <<EXAMPLES>>); otherwise your new worktree will appear as
>     an untracked directory.
> 
> I say "failed" as the above phrasing makes it sound as if that
> untracked-ness is the only downside, and also by omitting "advised",
> it makes it sound as if there is no upside (other than inertia) in
> doing so.
> 
> So, I'll (atleast tentatively) queue yours as-is.

Yes, I did not want to make this explanation too long. Spelling out all
the details would take multiple paragraphs but it's probably not worth
being that verbose.

> >  If the branch exists in multiple remotes and one of them is named by
> >  the `checkout.defaultRemote` configuration variable, we'll use that
> >  one for the purposes of disambiguation, even if the `<branch>` isn't
> > @@ -502,8 +505,8 @@ locked "reason\nwhy is locked"
> >  ...
> >  ------------
> >  
> > -EXAMPLES
> > ---------
> > +[[EXAMPLES]]EXAMPLES
> > +--------------------
> 
> cf. https://lore.kernel.org/git/5044672.31r3eYUQgx@cayenne/
> 
> IOW, we probably should write this more like ...
> 
>         +[[EXAMPLES]]
>          EXAMPLES
>          --------

That could use correcting in the the asciidoc documentation. The
examples there put the anchor on the same line.

That's probably where the repeated problem of this formatting is coming
from.

The other thing is that if you used sections you would get anchors
automatically for free avoiding this problem altogether.

Thanks

Michal
