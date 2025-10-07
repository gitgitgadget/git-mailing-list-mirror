Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B72E03EF
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844408; cv=none; b=HMKKUl9FbcfxcZzyD+f6ePD1Tfm3TpDyfn8VWdNC4BXkDJB93SXjX5aHwmQ2j/RH1io8tIPGZdkoz9AkIG6hGaokAWlNCp+op8tFvmTE6kSiw36ksoJX5oxqXCjRP91pdh4dK0z1uRiOS4VX2LmR8eGDBc4DEBnJuhAWaJWLuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844408; c=relaxed/simple;
	bh=IrvX/WcJ6dj567vKop2JGcVQFbieDdcx76gDSPaDTnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ5XP7xtmrZ1ndH3Lyn04SmHb4SOhaaOc2uF0jaG7eK4t1+jl2C+GfDCX35pEHAAtESYrs8GwDdcm+iMURYAnFlQoRu+cYXg5hx5QNOHjmDr7Avx4fuBm8mEkqCrcjfOeXe6piUhxuNeVbicfpQ8IXyiWI0ixCdDzfgG13KlXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yQy/A2cJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=21+9K5Zx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yQy/A2cJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=21+9K5Zx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yQy/A2cJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="21+9K5Zx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yQy/A2cJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="21+9K5Zx"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4360A33703;
	Tue,  7 Oct 2025 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759844405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnizUh8+Xq98P+aGA/DMjaiUBGTAPH/iz2GKcoJ7s44=;
	b=yQy/A2cJv3B228RYgvMvq6Hj2vhJePbrUCor8NMLNH6H1+EtHgnwfseTm1uHfOM7NLvkEa
	GIBPOXoUkBmfUsz0Zn3M/uhYonZSLzzl5zbo3E6Ywk0PLhHutYLBIFpXpBxv/YQ/03TcpW
	QTbx9VunPkxA+io5Y8r1ofTgSoIJLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759844405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnizUh8+Xq98P+aGA/DMjaiUBGTAPH/iz2GKcoJ7s44=;
	b=21+9K5Zx3NtDduocsVGlSxaCIrhCF8ddz3SofLK+peHnpALc9qpfJqCIJGDHVcMDmU5duz
	Oug3hQ1RV3B9lkBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759844405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnizUh8+Xq98P+aGA/DMjaiUBGTAPH/iz2GKcoJ7s44=;
	b=yQy/A2cJv3B228RYgvMvq6Hj2vhJePbrUCor8NMLNH6H1+EtHgnwfseTm1uHfOM7NLvkEa
	GIBPOXoUkBmfUsz0Zn3M/uhYonZSLzzl5zbo3E6Ywk0PLhHutYLBIFpXpBxv/YQ/03TcpW
	QTbx9VunPkxA+io5Y8r1ofTgSoIJLos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759844405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnizUh8+Xq98P+aGA/DMjaiUBGTAPH/iz2GKcoJ7s44=;
	b=21+9K5Zx3NtDduocsVGlSxaCIrhCF8ddz3SofLK+peHnpALc9qpfJqCIJGDHVcMDmU5duz
	Oug3hQ1RV3B9lkBw==
Date: Tue, 7 Oct 2025 15:40:04 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOUYNPD1o2_d0xYy@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <xmqqfrc1xqsp.fsf@gitster.g>
 <aN6j7giOosGreKUW@kitsune.suse.cz>
 <aOTrC8CRZm5hERgr@pks.im>
 <aOTtPxsdzJLPCruk@kitsune.suse.cz>
 <aOUT2Phklc_ZDhy9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOUT2Phklc_ZDhy9@pks.im>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[pobox.com,ttaylorr.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Tue, Oct 07, 2025 at 03:21:28PM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 07, 2025 at 12:36:47PM +0200, Michal Suchánek wrote:
> > On Tue, Oct 07, 2025 at 12:27:23PM +0200, Patrick Steinhardt wrote:
> > > The question of course is how to get such roadmaps. The easiest way to
> > > do it is probably to gather a list of known projects that would be
> > > impacted and just shoot maintainers or representatives of those an
> > > email? From the top of my head, that would include:
> > > 
> > >   - Implementations
> > >       - libgit2
> >           - pygit2
> > >       - JGit
> > >       - Gitoxide
> > >       - go-git
> 
> pygit2 is merely a binding for libgit2, so I didn't include it in this
> list. Same for other bindings like git2go or git2-rs.

Unfortunately, bindings do not automatically get the features of the
library they wrap. AFAIK libgit2 has experimental sha256 support and
pygit2 has none whatsoever. Altering the bindings to include sha256
support may involve significant design work. The native API may differ
significantly from the C API.

Both API may get broken as a result. That is pygit2 and libgit2 may
never get support, and we would need libgit3/pygit3 instead, or it may
vary depending on the language.

Thanks

Michal
