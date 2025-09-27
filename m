Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933521A444
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758995733; cv=none; b=EgAe9MbexXPJQpyNkPuKSjymn1LGqM4rlTXUvkRK0swSN2PpJ3/c++j19d0aT/lAhfsd2BGBbTAHO3u+7U1HGAREsRAhOiSercPlLgw+mXVY+UVMqZcqZJ2XRS1MHucnXjgXBujWIzUkvniOLm++32TqDwqsxHV8oghboJvi3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758995733; c=relaxed/simple;
	bh=J1gDr4QhvKE6sCFy7/g7vbydWNRoWC7YU4cg0vUYXfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keQWtEKOVM+bIdQMTOmSLnmdAImY+g+8qYxOoBLIzywc79qeW3uRUCRYOek99OKGWhBVXDnI0xrNo3y4x7/VmBofQFXW45UHxwNATNtp4JjzMWXJoj+bbSot24ng1NlhFIgAYkW6pdxpXaduyLEopZruk94X+DbqDSa6/oA1q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qVVbxgNs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EIvqHky7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qVVbxgNs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EIvqHky7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qVVbxgNs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EIvqHky7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qVVbxgNs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EIvqHky7"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0636B1F7AB;
	Sat, 27 Sep 2025 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758995729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kOsLyVryqiDF5JHRgzigOqURwXbubocmArnKGg+uOHk=;
	b=qVVbxgNsaNXyNOkhSMrukfrRL5GXFGioEMEmi1BAbSOTEmBtcSNlFDL12U1vEQmTy8zML5
	ch03f/XWx7mET95myq8qs7qV/eIPE/Bp5GxjG7JRvCO9y/SZClmTBWD7buVZJxzSdigC+s
	fqbTNX1NggSzzmz4STghVkYSVDZYNxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758995729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kOsLyVryqiDF5JHRgzigOqURwXbubocmArnKGg+uOHk=;
	b=EIvqHky7WxppwU7/g7DhDZg9DV9YU4COWraafjm0DGZhV1sIH7w2o3tGeILOZBp0V7USwu
	1QA/lYNzc1pY4BCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758995729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kOsLyVryqiDF5JHRgzigOqURwXbubocmArnKGg+uOHk=;
	b=qVVbxgNsaNXyNOkhSMrukfrRL5GXFGioEMEmi1BAbSOTEmBtcSNlFDL12U1vEQmTy8zML5
	ch03f/XWx7mET95myq8qs7qV/eIPE/Bp5GxjG7JRvCO9y/SZClmTBWD7buVZJxzSdigC+s
	fqbTNX1NggSzzmz4STghVkYSVDZYNxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758995729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kOsLyVryqiDF5JHRgzigOqURwXbubocmArnKGg+uOHk=;
	b=EIvqHky7WxppwU7/g7DhDZg9DV9YU4COWraafjm0DGZhV1sIH7w2o3tGeILOZBp0V7USwu
	1QA/lYNzc1pY4BCA==
Date: Sat, 27 Sep 2025 19:55:27 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <aNglDzeOT5_4ZbdV@kitsune.suse.cz>
References: <20250927152824.3132af88@jcubic>
 <xmqq4isn96s7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4isn96s7.fsf@gitster.g>
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

On Sat, Sep 27, 2025 at 09:52:56AM -0700, Junio C Hamano wrote:
> "Jakub T. Jankiewicz" <jcubic@jcubic.pl> writes:
> 
> > Why git work trees are are not automatically ignored by git?
> 
> Because there is no reason to ignore them, and ignoring them would
> be annoyingly inconvenient.  Worktrees are not special and treated
> the same way as an ordinary Git working tree with embedded .git
> directory.

Sure, that's another repository.

It does not not show its own .git directory as untracked files although
it is in the main worktree, though.

So why another worktree of the same repository is shown?

That can be seen as inconsistent.

Thanks

Michal
