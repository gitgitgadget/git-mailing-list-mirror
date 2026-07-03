Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CA3D090E
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081069; cv=none; b=Brvi8gwQDITeMCr9CjC+5HxoHT21/y56nmPuArVocw2aUDMOYavEcvUTfbEt3sNNaaJmIOHHdX1WlLsBZAGDa5ONFz0OcS1L4uVWxUvySVoyF5mmMIm44Uh/ZbMOV6WGcRCeNN02ED4PgaCZPmi3zkXDr0JzCpBN/OZ6AuRQnDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081069; c=relaxed/simple;
	bh=0I9TMe9gFJLvqSC4TAy8YtPxvlAASzBkgt9W5AhoYXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bau7+t8M1rdPuFRAodMjSkZlRO9F9/QBzZYEqMSme7zvUaR2GnW/4t3zU+rreiHPwXVvGIo91Snqkc/nqHstuHsEi1eHf0/VzTCyh+bxr5L1EuVDaaLP3oIP6nG73z0mWvxNTXZXOOpaRfv8P/OJQNxN1wEoMtirKV3Zvmk9sdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pt/g1TPJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cl3qH1TT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pt/g1TPJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cl3qH1TT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pt/g1TPJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cl3qH1TT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pt/g1TPJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cl3qH1TT"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9971A7489D;
	Fri,  3 Jul 2026 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783081066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emQQTb2Hoo4nC3GOuTHn5p2g87fFT5+eBzweyz3w4fk=;
	b=Pt/g1TPJGo9WksdhjRa1WnT3LlhZztkx/WdWdpdK1fRRJHb1gha/0Tueu0DSKrZsSYXoF5
	eKuyD9+GEs/SOIPTYydV/w5Dvu945abuLNbfDL7oLvG3RvsW+oYOgRKOEOhzeYpUXv67GI
	3SubRhZTGSLUNZd1XmzSF0UW5KK2Syk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783081066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emQQTb2Hoo4nC3GOuTHn5p2g87fFT5+eBzweyz3w4fk=;
	b=cl3qH1TTUiRP2zutV2Nq2id9Wg5C3pl5dtY49nkQiK05jlyjYPa3baODsLWPGMfgrwb5QE
	M7GXi0vshGy8N7AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Pt/g1TPJ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cl3qH1TT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783081066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emQQTb2Hoo4nC3GOuTHn5p2g87fFT5+eBzweyz3w4fk=;
	b=Pt/g1TPJGo9WksdhjRa1WnT3LlhZztkx/WdWdpdK1fRRJHb1gha/0Tueu0DSKrZsSYXoF5
	eKuyD9+GEs/SOIPTYydV/w5Dvu945abuLNbfDL7oLvG3RvsW+oYOgRKOEOhzeYpUXv67GI
	3SubRhZTGSLUNZd1XmzSF0UW5KK2Syk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783081066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emQQTb2Hoo4nC3GOuTHn5p2g87fFT5+eBzweyz3w4fk=;
	b=cl3qH1TTUiRP2zutV2Nq2id9Wg5C3pl5dtY49nkQiK05jlyjYPa3baODsLWPGMfgrwb5QE
	M7GXi0vshGy8N7AA==
Date: Fri, 3 Jul 2026 14:17:45 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Matthias Beyer <mail@beyermatthias.de>
Cc: git@vger.kernel.org, neikos@neikos.email
Subject: Re: Programmatically edit the git rebase sequence?
Message-ID: <akeoaWAkrENbpi1G@kunlun.suse.cz>
References: <akei64goQf3nFhX4@hikari>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akei64goQf3nFhX4@hikari>
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 9971A7489D
X-Spam-Flag: YES
X-Spam-Score: 16.14
X-Spam-Level: ****************
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.14 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_SPAM_SHORT(2.95)[0.984];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	SUBJECT_ENDS_QUESTION(1.00)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam: Yes

On Fri, Jul 03, 2026 at 02:02:33PM +0200, Matthias Beyer wrote:
> Hi git people,
> 
> in a recent conversation at work, the question of how to
> programmatically edit the git-rebase sequence came up.
> 
> Example use case:
> 
> I have a branch that touches a number of files, adds some files and
> removes some files.
> When rebasing, I want to split all commits that touched a certain subset
> of files, for the clearity of the history.
> 
> I look at the output of
> 
>     git log master..mybranch --oneline --diff-filter=M -- "./subdir/*.rs"
> 
> to find all commits in that subdir that only touched the files. All of
> these commits are to be "edit"ed.
> 
> Now I fire up `git rebase -i master` and manually(!) match the list from
> above `git-log` call and find the respective commits to edit them.
> 
> Is there a way I am not aware of to do that manual step programatically?
> Something like
> 
>     git rebase -i master --edit-commits="$(git log master..mybranch --diff-filter=M --format="%H" -- "./subdir/*.rs")"
> 
> would be convenient here, although I would understand if that is too
> much clutter for the already very heavy git CLI interface :-)
> 
> Maybe I am just not aware of the obvious solution - I would be happy to
> learn that there is already one!

Hello,

you could probably set a script as EDITOR (environment variable). Not
great for one-off scripts I guess.

Thanks

Michal
