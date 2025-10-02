Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963B248F47
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407195; cv=none; b=FQmuNaE+fPCraKFvTCyAt+LCp3+VCHPq8ziZinozXc0fbssPhdn5wNLErIC7vXLcvXM9ZqaLmCVu+LjH61gPCy1rJmujx7UT7lW69ZRWWgoj/PEchUZAq25TFkvWG9OAkd06gn9nAQYBfYIoTa0PA++E25+FjwD4atjVEwbEZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407195; c=relaxed/simple;
	bh=k+CR8oRao9fN5FSNnRspq+w4QfRKDfxDkthpoJxcKs4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0ApMy6cKy1JOFhRWNOiPBNWjpnPLhZl8NrVzgT7lM7uEhuQsyJlNLrkpbhnRt5UNzIY7XiDbZSXfJNxYQnSofiX5H1wV6kr0H1aKRsV+eLCCCQxHdpJVGzTlM2gkTMzvYePNk9fmq9oFItaum6XKZ1SlC9qgZ5MXTbNVqFkCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a44haCql; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3HCGuEsK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a44haCql; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3HCGuEsK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a44haCql";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3HCGuEsK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a44haCql";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3HCGuEsK"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C10C11F853;
	Thu,  2 Oct 2025 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759407190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGyh4h2Etc7PqdgOJVlmAyEVzH4bdd5AjXMpMQLk0k0=;
	b=a44haCqlsx0ssWlnzvTSVgELYI0NGTaKmqP+xyGgqpY8tS/BwHwM4EibQYURlnKN9Ghhz2
	PhVzzx0HWOfDlk85azXL/3r3KDPE9O/YBLBStZEGmHG+WNXnJtOO9KanvV9S/VHiUyLZpZ
	KXEGf8nopX/ouD5vmdob4z7g4pCkJjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759407190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGyh4h2Etc7PqdgOJVlmAyEVzH4bdd5AjXMpMQLk0k0=;
	b=3HCGuEsKICLwovM1D2hgdcumDzXIvUet/gN8gg9Wt5IzTupscggDOAFNdA2bu6IbwBmbaT
	g28V20lc1t6VHhCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759407190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGyh4h2Etc7PqdgOJVlmAyEVzH4bdd5AjXMpMQLk0k0=;
	b=a44haCqlsx0ssWlnzvTSVgELYI0NGTaKmqP+xyGgqpY8tS/BwHwM4EibQYURlnKN9Ghhz2
	PhVzzx0HWOfDlk85azXL/3r3KDPE9O/YBLBStZEGmHG+WNXnJtOO9KanvV9S/VHiUyLZpZ
	KXEGf8nopX/ouD5vmdob4z7g4pCkJjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759407190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGyh4h2Etc7PqdgOJVlmAyEVzH4bdd5AjXMpMQLk0k0=;
	b=3HCGuEsKICLwovM1D2hgdcumDzXIvUet/gN8gg9Wt5IzTupscggDOAFNdA2bu6IbwBmbaT
	g28V20lc1t6VHhCQ==
Date: Thu, 2 Oct 2025 14:13:09 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN5sVXNdW8-GSMAE@kitsune.suse.cz>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <aN1QUDzYli0GsGy9@nand.local>
 <aN1UtbJRIhgvMmaF@kitsune.suse.cz>
 <aN2oSBz8s_hSBMPq@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN2oSBz8s_hSBMPq@fruit.crustytoothpaste.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, Oct 01, 2025 at 10:16:40PM +0000, brian m. carlson wrote:
> On 2025-10-01 at 16:20:05, Michal Suchánek wrote:
> > From my very limited point of view as a user the interop is the major
> > planned feature currently missing in git, and I do not see much point
> > without it. Then again I do not know how useful it will be in practice.
> 
> It is the major planned feature which was missing.
> 
> The primary use cases are converting repositories and working with
> repositories using a different algorithm.  The latter might be useful if
> you're using a SHA-256 repository that someone else has created but your
> tooling cannot handle longer object IDs or otherwise has some limitation
> of that sort.

It cannot, and the compat will not help with that because it's using
pygit which will not get that compat code. Presumably some baroque
scheme that re-exports the repository as sha1 might be possible but it's
not clear if that would be practical.

Another problem people are comlaining about is that with a mix of sha1
and sha256 repositories submodules and subtrees don't work. For that the
compat might actually help but the repository will then be
unintelligible to tooling that does not have compat code, which probably
includes all forges at this point.  Again, some baroque scheme that
re-exports the repository in the other hash using the compat code might
help but it's not clear if that would be practical.

Thanks

Michal
