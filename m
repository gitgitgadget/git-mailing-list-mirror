Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0530F92E
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540043; cv=none; b=oJMHl6o6pvjFcV4inLyoBojlMoLNuYQdv0RBeJpmjikzJ+Y7ynpj2Q6waudX3hUjJB1p5KTcrW+Rt2O5WUyNhmOTsHX+nBOjtI960SekR3wh31roYdlUyD2bUgXPdSq7Uv7UAXxQi7/8VxlC0PlBioNT2a6Bja7lVofNXzY3Ck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540043; c=relaxed/simple;
	bh=UvfPs/J6x5cBQj+pu2ajd8gWi0QW8zudwTCxGwxUmIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzKfVEyzIug1yCVz9RAOxs6i5lhoCKz15iMBes1/DUAfL/JMXScPXDSTf36H25jut5ik1PoUnY7BOkTkOwzgsyu9ezad5tBNwOJ2EuEFH+Nqm7XkF45UqNwJiGbBygmtsMPipDIIS0OmQtOm8a9t/UY9JRAJWaLoGw490M9nn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cfbKPIeN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=thLroBkP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cfbKPIeN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=thLroBkP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cfbKPIeN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="thLroBkP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cfbKPIeN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="thLroBkP"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58720211D3;
	Wed, 19 Nov 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763540034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZcy1ZkLvWXc5KCv/XBWaav57jyoxYWe2//E8puS1WM=;
	b=cfbKPIeNnZIs9NN+pJ1ngJatU0hNF2GssbAKPbf7PmTOZa0Z4pI4aTc4LFTOMfBrpbaWKc
	Od52PAnQOFkKcGHbxzIxmF9iNTufC6/dFK5HRXDhaNpC+4UfVE1lJ0/BYdcJnppJGfm/eM
	fHmSqqLCdHLJYuGL6w77LeShGauGyzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763540034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZcy1ZkLvWXc5KCv/XBWaav57jyoxYWe2//E8puS1WM=;
	b=thLroBkP9hF+UOZGYiLY5MJ+3gonSVS2M5EGDXvKDk6dsklvsHbhKiaj/OlDyyNroev+O/
	afnludTT7HzSHcCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763540034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZcy1ZkLvWXc5KCv/XBWaav57jyoxYWe2//E8puS1WM=;
	b=cfbKPIeNnZIs9NN+pJ1ngJatU0hNF2GssbAKPbf7PmTOZa0Z4pI4aTc4LFTOMfBrpbaWKc
	Od52PAnQOFkKcGHbxzIxmF9iNTufC6/dFK5HRXDhaNpC+4UfVE1lJ0/BYdcJnppJGfm/eM
	fHmSqqLCdHLJYuGL6w77LeShGauGyzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763540034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZcy1ZkLvWXc5KCv/XBWaav57jyoxYWe2//E8puS1WM=;
	b=thLroBkP9hF+UOZGYiLY5MJ+3gonSVS2M5EGDXvKDk6dsklvsHbhKiaj/OlDyyNroev+O/
	afnludTT7HzSHcCQ==
Date: Wed, 19 Nov 2025 09:13:53 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <aR18QQ03-Wg26oNJ@kitsune.suse.cz>
References: <20250927152824.3132af88@jcubic>
 <xmqq4isn96s7.fsf@gitster.g>
 <aNglDzeOT5_4ZbdV@kitsune.suse.cz>
 <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
 <GY1ni5SFkgBgVIHm9HoO9dtLuLWbUPCv5mjcsy5VGi09PyRLV_gv3MMw2zsinKpi5Aon9J-LESzTUuwMOUNLRRLqyXM7ON-98WTzhH7RIYY=@proton.me>
 <aNuxUqDMNcZZs68n@kitsune.suse.cz>
 <xmqqzfac3pts.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzfac3pts.fsf@gitster.g>
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.909];
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
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -3.28
X-Spam-Level: 

On Tue, Sep 30, 2025 at 08:47:11AM -0700, Junio C Hamano wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> > On Sat, Sep 27, 2025 at 09:26:54PM +0000, Jason Cho wrote:
> >> I think the best practice is to not add a work tre within the master work tree.
> >
> > And is that best practice documented somewhere?
> 
> I do not think it is documented anywhere.
> 
> In fact, I do not think the inventors of the worktree feature ever
> expected this end-user expectation that checking out multiple
> worktrees of the repository *INSIDE* a repository's checkout would
> be any useful without confusing users.
> 
> IOW, omission of the documentation is by an assumptionk that nobody
> would imagine doing in any other way.  
> 
> We can and should fix it retroactively, if the lack of documentation
> is not guiding our users in the right direction.  Any takers?
> 
> > IIRC there are some VCSs for which it is common practice to keep
> > checkouts of multiple branches side by side in the repository directory.
> 
> I can understand "side-by-side" but not "in".  Next to the primary
> workree (aka "initial clone") would be more common.
> 
> > IIRC the repository directory itself is not a checkout in this case.
> > Anyway, there is no obvious reason for anyone not familiar with git
> > internals to not do this.
> 
> Meaning anybody not familiar with the tool would do any random thing
> outside of the usage pattern that the users of the tool have been
> establishing over the years?  I can certainly understand that.  But
> then, creating a set of worktrees, one per branch, next to the
> primary worktree that checks out the 'main' branch, would also equally
> be a likely layout, I would imagine.

And that's what the existing example shows.

Thanks

Michal
