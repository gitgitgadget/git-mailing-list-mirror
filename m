Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0212D9EF0
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858088; cv=none; b=YkE6Nbc736MfCCx+E5n8/nkjKu7aHUaFuGVy8AO6pxiCQzSbRemtzHeYg2NmnwXGgyPIXpSt6jg0KDLMaCO9oxiKgWYXu5XLG8OsU4guUTTM7Y3+B0QQ+nhsntrC/aZOVZLYR6u3eH4WrMqc4iqwnd7xs4K4cuX+p307NftwBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858088; c=relaxed/simple;
	bh=tHP5uvfYYWBOhOs+prLQSX9BDBT57hpwjouLHcP77a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBvJ/1CkryG+0WCuAy5FK2kd5FCLe0Veb2RHO82CKbGgrZmrU/GulC0XAbT0L4iLDYmlU8luAk9X0d332l+ZnTYyTxNF22yJc9HH1tZ0cEPJAtEE9B4GFgqijE8duK9Vq0AT5fK63oOD2yMD1amZNLF9vGfoJL+I7m3Ply5w7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n0+BgOEA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s7hi9XTk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n0+BgOEA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s7hi9XTk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n0+BgOEA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s7hi9XTk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n0+BgOEA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s7hi9XTk"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3380A341EB;
	Tue,  7 Oct 2025 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759858084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r+6kLYMD0B5uwHfSIaYjC5iuUAztQ8HBBRgfbJ6+Fc=;
	b=n0+BgOEArLgHFqZdcC+dTIFZYdxyre3wVB2oeqISL5iXRVWID1IBFqXrLs3ooAu+rUlzzA
	pt8BOleELk1EaJayeeQPe7eu4E3Bv0Lzj0J2dL8m8k0bzh1xLKH7dARaqLrncgFJCuI37X
	TjmAsePDCZwQ0S3g6plz0QkdW0EO7EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759858084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r+6kLYMD0B5uwHfSIaYjC5iuUAztQ8HBBRgfbJ6+Fc=;
	b=s7hi9XTk87+7ntBCm4CCFjKRqx0wZd6BqTvZNuSgdCFIPz+ipgTAm26pf2N+ChoDdpX5Cb
	Vy6SHcjycu5A/HAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759858084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r+6kLYMD0B5uwHfSIaYjC5iuUAztQ8HBBRgfbJ6+Fc=;
	b=n0+BgOEArLgHFqZdcC+dTIFZYdxyre3wVB2oeqISL5iXRVWID1IBFqXrLs3ooAu+rUlzzA
	pt8BOleELk1EaJayeeQPe7eu4E3Bv0Lzj0J2dL8m8k0bzh1xLKH7dARaqLrncgFJCuI37X
	TjmAsePDCZwQ0S3g6plz0QkdW0EO7EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759858084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r+6kLYMD0B5uwHfSIaYjC5iuUAztQ8HBBRgfbJ6+Fc=;
	b=s7hi9XTk87+7ntBCm4CCFjKRqx0wZd6BqTvZNuSgdCFIPz+ipgTAm26pf2N+ChoDdpX5Cb
	Vy6SHcjycu5A/HAQ==
Date: Tue, 7 Oct 2025 19:28:03 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOVNozn-ycPoLf2p@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
 <aOTrC8CRZm5hERgr@pks.im>
 <aOTtPxsdzJLPCruk@kitsune.suse.cz>
 <aOUT2Phklc_ZDhy9@pks.im>
 <xmqqv7kqk56r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv7kqk56r.fsf@gitster.g>
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[pks.im:email,kitsune.suse.cz:helo,kitsune.suse.cz:mid];
	FREEMAIL_CC(0.00)[pks.im,ttaylorr.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Tue, Oct 07, 2025 at 10:11:24AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Oct 07, 2025 at 12:36:47PM +0200, Michal Suchánek wrote:
> >> On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
> >> > The question of course is how to get such roadmaps. The easiest way to
> >> > do it is probably to gather a list of known projects that would be
> >> > impacted and just shoot maintainers or representatives of those an
> >> > email? From the top of my head, that would include:
> >> > 
> >> >   - Implementations
> >> >       - libgit2
> >>           - pygit2
> >> >       - JGit
> >> >       - Gitoxide
> >> >       - go-git
> >
> > pygit2 is merely a binding for libgit2, so I didn't include it in this
> > list. Same for other bindings like git2go or git2-rs.
> 
> Is dulwich still alive?

Interesting, did not know it exists (also abysmal SEO, not surprising).

Its web page seems unmaintained but the git repository looks alive.

Thanks

Michal

> 
> >
> >> >   - Forges
> >> >       - GitHub
> >> >       - GitLab
> >> >       - Bitbucket
> >> >       - Forgejo
> >>         - Gitea
> >> >       - SourceHut
> >
> > Yup, this one should be included here indeed.
> >
> > Thanks!
> >
> > Patrick
