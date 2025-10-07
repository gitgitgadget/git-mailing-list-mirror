Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B426057A
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833413; cv=none; b=Tg3Q8nkZBGLNo/d28tVoQnZfdafjefnXR7Sv+EwImgND7OwKY9Xhg7WvQpVs+tEnU7q5ONAj/4hl6ezDYWF/bkT20j8d/UYTmYqm+rl+dpwej3SxwZbN2wemBpdKVWEaxIM8ezCNsl4cjq68GWqoSJaYmyuexbQtH3XySg0Yg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833413; c=relaxed/simple;
	bh=8NeLgg6eCG7zfV1mZtfLUTm4AKI5gBLB1hqiJanaLqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFSv1cg+EkcSbhampSSwuQchWqp2fRd5mGp1Mu6lg8FIE1zLmtI/4A8/NMZiYYw6+sm9ckXEmJgqnS3dgGQoVzV0H53R7oso7VIyYVMdpJSeFQ5//Xnpmsyh9jc7TupWu9e/USZrSwi9Et4pDVSTJUvipBgpPRhc82IDkdZUvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ieSS2TdS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=caE9tsch; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=07j7Q1lo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eNbAD9QL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ieSS2TdS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="caE9tsch";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="07j7Q1lo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eNbAD9QL"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C980A336F3;
	Tue,  7 Oct 2025 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759833410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8puuELBZCRZAcEb+tnuWRK3tRQ4eRufCWinzea5oxM=;
	b=ieSS2TdStysjLOl9JZpgEtyU2qFwqhPtY4mYekvcot/MKoTMQdec4urIvCUX5KoBUbt+7T
	dLOaFVWSh7ZB7EiyKpEiIJYdwQPVG2usIIbUaXMPzgYhYzVmttT9/QvKG2dUGkFHwe2OnB
	kXIrV8Cpd9GR2ZdZWEBA3QyLIMIzt24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759833410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8puuELBZCRZAcEb+tnuWRK3tRQ4eRufCWinzea5oxM=;
	b=caE9tschzST1wP9AQQJ8wghOJAu5FlAUmM0KCfKdXnIvqQ0OH4wV4k1QX5wKC1aR3E8PkV
	UVuGG5aiq678uiAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759833408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8puuELBZCRZAcEb+tnuWRK3tRQ4eRufCWinzea5oxM=;
	b=07j7Q1loblu9U7THaHJZwdUxqVgZtnbM5l8QfkC4MSqnCwfdXnk5gh3iswzNyn68v1IsWx
	GpJGp0t9pk3L9wEYvV3l0+pywTcF54CWC6Hvx0d6VI/0bj/B5mvXAqqfvSJzyFQVoU/EXJ
	CBReFUegoUEi/IJeMPs2qVFTuXYvOOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759833408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8puuELBZCRZAcEb+tnuWRK3tRQ4eRufCWinzea5oxM=;
	b=eNbAD9QLGx52wKX1hSJ3GaIddGzPsPWoP0vlBCMOu8QfimPqsyWnDL4/84Uy5jpNULpWtk
	QiOSDiuICNinmECA==
Date: Tue, 7 Oct 2025 12:36:47 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOTtPxsdzJLPCruk@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
 <aOTrC8CRZm5hERgr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOTrC8CRZm5hERgr@pks.im>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[pobox.com,ttaylorr.com,gmail.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:mid,kitsune.suse.cz:helo,pks.im:email]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
> On Thu, Oct 02, 2025 at 06:10:22PM +0200, Michal Suchánek wrote:
> > On Thu, Oct 02, 2025 at 08:32:38AM -0700, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > 
> > > > Once we have roadmaps, we should set a strict deadline that takes them
> > > > into account. Any hosting provider or implementation of Git that doesn't
> > > > provide a roadmap will not be taken into account in our planning.
> > > 
> > > Works fine as long as we assume everybody that matters will
> > > eventually want to move away from SHA-1.
> > > 
> > >  - If a stakeholder gives a roadmap that has no SHA-256 in their
> > >    future, in other words, if they are content to serve only the
> > >    SHA-1 projects, what's the impact to them?  We are not dropping
> > >    the support for SHA-1 in the sense that if you clone from an
> > >    existing SHA-1 repository you'll get an SHA-1 repository and you
> > >    can push and fetch between them just fine, so presumably that is
> > >    fine as well.
> > > 
> > >  - If a stakeholder gives a roadmap with SHA-256 so far into the
> > >    future that we cannot wait, what's the impact to them?  Their
> > >    customers that want SHA-256 earlier than they can supply could
> > >    move to other hosting or implementation, but not really.  Both
> > 
> > I suppose that's already the case to some extent. git does support
> > sha256, some forges do as well, and some people want it to the point
> > that they install such forge, and create the sha256 repositories
> > although it is not the default.
> > 
> > There is some tradeoff here. When it's nice to have but not required
> > people will use it when convenient. When it's really required people
> > will use even an obscure implementation to get the requested feature.
> 
> True. In any case, I think that for now we should just wait how such
> roadmaps would look like and then discuss based on the findings.
> 
> The question of course is how to get such roadmaps. The easiest way to
> do it is probably to gather a list of known projects that would be
> impacted and just shoot maintainers or representatives of those an
> email? From the top of my head, that would include:
> 
>   - Implementations
>       - libgit2
          - pygit2
>       - JGit
>       - Gitoxide
>       - go-git
>   - Forges
>       - GitHub
>       - GitLab
>       - Bitbucket
>       - Forgejo
        - Gitea
>       - SourceHut

Thanks

Michal
