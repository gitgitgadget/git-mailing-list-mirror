Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32133137775
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264068; cv=none; b=fo+PesTTfRXwVorhQyARc2wLhxJ7yMs/ubahkgGKzyadOtm0yvDNXJueEhuq3p8o/BsJ5t4VvN+biJxABnYcot5oMSbEcMrNpnLQhTsrCNYLQfdidxArsWYtj0HLCKWUfdU6UiFF6jYj+p2Muj3LYtxLvwyFjL8CEARTbcujljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264068; c=relaxed/simple;
	bh=15OQIIH56U9tlY7ZWccXOiUrsYxB0hpkvMDTRj1/FMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5YbRcxbBjII8Lvl2exr2JJX+jwEO2nJglm+kZT3LRNICJCQeQLQsZLNJT8ELzMlIIz3sVKjqybz42hSQu53WIicHgQxr2zBCqfR1p0bDFWF7WV/wrHAdPjynA/KFiGLExYSvtbwLmNbi7cg63i+ub3OXT07iiuUGToan3+JV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c1N0m6Il; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1roIVYAX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c1N0m6Il; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1roIVYAX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c1N0m6Il";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1roIVYAX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c1N0m6Il";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1roIVYAX"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 444DE1F450;
	Wed, 25 Sep 2024 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727264064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlX/V8GOvI3Er5DCutITbuuJNqhfOGnnvBnRUGb9ynM=;
	b=c1N0m6Ili+JXvhv7yTirIZNHMOU1BVWzv1XZjtS/vMBzvvQ71dQdaCV4+0pcZaL5mKIE4H
	mRI1Jp9RZWTmGJUnJfuCVVY71Jb1uIOmPapfIb3uM4dAEHdH2CwT+gFXQ19qbG+dALlbHS
	6Wf8upMcmRqRNVzLxnrZ3c80HJ70gGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727264064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlX/V8GOvI3Er5DCutITbuuJNqhfOGnnvBnRUGb9ynM=;
	b=1roIVYAXwPtX9vGghNXrxu5oDAwL3oKwpPuJ5NQ6iqsibxl9txSKO3NmWnYrSbZ1RbxW8B
	FdzaIyV6X1cWqUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727264064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlX/V8GOvI3Er5DCutITbuuJNqhfOGnnvBnRUGb9ynM=;
	b=c1N0m6Ili+JXvhv7yTirIZNHMOU1BVWzv1XZjtS/vMBzvvQ71dQdaCV4+0pcZaL5mKIE4H
	mRI1Jp9RZWTmGJUnJfuCVVY71Jb1uIOmPapfIb3uM4dAEHdH2CwT+gFXQ19qbG+dALlbHS
	6Wf8upMcmRqRNVzLxnrZ3c80HJ70gGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727264064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlX/V8GOvI3Er5DCutITbuuJNqhfOGnnvBnRUGb9ynM=;
	b=1roIVYAXwPtX9vGghNXrxu5oDAwL3oKwpPuJ5NQ6iqsibxl9txSKO3NmWnYrSbZ1RbxW8B
	FdzaIyV6X1cWqUCA==
Date: Wed, 25 Sep 2024 13:34:23 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
Message-ID: <ZvP1P31xSvKaAhjN@kitsune.suse.cz>
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g>
 <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz>
 <xmqqr0cl6lxl.fsf@gitster.g>
 <20240625183411.GW19642@kitsune.suse.cz>
 <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>
 <xmqq34oz1shc.fsf@gitster.g>
 <aa94be27-60a5-42d9-adcc-f25f9a8d6ae5@gmail.com>
 <xmqq4j9fzge5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j9fzge5.fsf@gitster.g>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Wed, Jun 26, 2024 at 11:51:46AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Sorry if I wasn't clear. "." is considered safe with "safe.directory =
> > *" but I was looking at why it was not considered safe when using
> > repository paths in safe.directory.
> 
> Ahh, OK.  We tell them /home/wood/repo/git is a good repository to
> visit, but daemon's call to ensure_valid_ownership() asks "I am in
> the '.' directory; does that match /home/wood/repo/git?"  
> 
> That sucks.  I agree with your idea that we'd need to canonicalize
> both before comparing.

And it's addressed with 0ed3dde067a5dc5141e3a31d950972f00a08b35d at
least since 2.46.1

Thanks

Michal
