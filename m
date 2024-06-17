Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4114F128
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658918; cv=none; b=ivuaR8GplLeH18ghuE900ZGjoTSwO9d+OqICladOgp1KSgylpmVST89YTBXFDgrmRcY1ESpaoT/4IaRo8NImQO7F3JeHQ2iOuPl2x3A3VVV79tDHF7HWaQtJSnL0a+osnJ0Z9zXCCc0TUo0GHsD225JLH85gTpNEskViZcFC1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658918; c=relaxed/simple;
	bh=1agVyWKgO9x5qyM4/4ZzNq8Icfce2H/bvSoFOnN6ln0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa7Mc/UPy5f1GIbe1h2pewNVNHkQWxGyzM/g8++mDdsqRj6Qs6CzdITJjpKbRAsI6tiksakHwbRN2xgWADwmv5rTueMlKPjCKyX8yE1NKH1f049A0EmVea0m9yxhiFFw06Uu6M7wzvQOEBBUxIfqLXo3PnETrm28xDIsNYnxue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HiOtnMkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zLdHvyft; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HiOtnMkm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zLdHvyft; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HiOtnMkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zLdHvyft";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HiOtnMkm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zLdHvyft"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 004561F397;
	Mon, 17 Jun 2024 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718658915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z0e1ZlnszfCz6lhZZPfFSi9Jh0JBBc/yWfo1ypbLMU=;
	b=HiOtnMkm4PtiyqF301q8KcwSyyx/AR0GXbHxFrptCkN/JVX0xbdfz4GN0m6x+d0oyKtrCN
	teLmCcn9uTOZPSGVIq3kNTcvSj/l7IIosB1VvBU7wXipi37NnchvbXFPtB5R651IxMdBr7
	uf0oDsusmb9SzoZOCIc7hWqQY1LE3t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718658915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z0e1ZlnszfCz6lhZZPfFSi9Jh0JBBc/yWfo1ypbLMU=;
	b=zLdHvyftmGgn+3OxLP7/F9KOxQpXFMroQd54tBu3NklsEh328AYs1g5ElT461D7qlrrhQ4
	mG1tttAiz1Xt4aBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718658915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z0e1ZlnszfCz6lhZZPfFSi9Jh0JBBc/yWfo1ypbLMU=;
	b=HiOtnMkm4PtiyqF301q8KcwSyyx/AR0GXbHxFrptCkN/JVX0xbdfz4GN0m6x+d0oyKtrCN
	teLmCcn9uTOZPSGVIq3kNTcvSj/l7IIosB1VvBU7wXipi37NnchvbXFPtB5R651IxMdBr7
	uf0oDsusmb9SzoZOCIc7hWqQY1LE3t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718658915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1z0e1ZlnszfCz6lhZZPfFSi9Jh0JBBc/yWfo1ypbLMU=;
	b=zLdHvyftmGgn+3OxLP7/F9KOxQpXFMroQd54tBu3NklsEh328AYs1g5ElT461D7qlrrhQ4
	mG1tttAiz1Xt4aBw==
Date: Mon, 17 Jun 2024 23:15:13 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
Message-ID: <20240617211513.GM19642@kitsune.suse.cz>
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qz376fb.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]

Hello,

On Mon, Jun 17, 2024 at 11:47:20AM -0700, Junio C Hamano wrote:
> "David C. Rankin" <drankinatty@gmail.com> writes:
> 
> >   Security enhancement in 2.45.1 have broken ability to serve git over
> >   https and ssh from local git server running Apache. (web server runs
> >   as http:http on Archlinux)
> >
> >   The fix of adding the following to gitconfig (system-wide and
> >   per-user in ~/.gitconfig) does not solve the problem:
> >
> > [safe]
> > 	directory = *
> 
> It is not clear what you exactly meant "per-user" above, so just to
> make sure.  Is this set in the global configuration file for the
> httpd (or whoever Apache runs as) user?
> 
> The purpose of "dubious ownershop" thing is to protect the user who
> runs Git from random repositories' with potentially malicious hooks
> and configuration files, so the user being protected (in this case,
> whoever Apache runs as) needs to declare "I trust these
> repositories" in its ~/.gitconfig file.  What individual owners of
> /srv/my-repo.git/ project has in their ~/.gitconfig file does not
> matter when deciding if Apache trusts these repositories.


looks like the semantic of 'dubious ownershop' changed recently.

Disro backport of fixes for CVE-2024-32002 CVE-2024-32004 CVE-2024-32020
CVE-2024-32021 CVE-2024-32465 to 2.35.3 broke git-daemon. No amount of
whitelisting makes the 'fixed' git serve the repository.

Of course, this might be bug in the backpotrt as much as but in the
upstream logic, not analyzed yet.

However, serving repositories is a gaping security hole right now. At
least on some 'stable' distributions.

Thanks

Michal
