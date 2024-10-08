Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB34212644
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412047; cv=none; b=Sm3jXlLwCTEONldgPMXzN0kGFz26fJ3UgYD7VgVbVtGQUTUfYnsNAMro5Aow0LVrmarkZbYbvyc42ZeFfmwrDxu+t2mxwVyhr3xY9xOzSDJO8bjyBltnDcJxqun+CuPhQJ3TBzOQb/7L9EgWdaLco5UYL5Ki1sVYSedl1LF+PeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412047; c=relaxed/simple;
	bh=7eA/kWtPzjOMtyeX5xPiAomffU+esJ2/fjH0KhT9q7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqUo0jaFO7WCmSvEuFF6k4UJ6KT9a1Tquk/QrBrqwhass1vsFhiGafuR2eM5tu+GKrCc00iIsr6VCCcAvDVNOsBN7SFzxbzlXFyg8OwVJf16X5x94igdq/ZNN6y5OxgOlZCeLBzaIOU5Q4H47rh6zOp5t48wsOS3R2RVHxZzvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMQXt7/z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q6BEEor6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMQXt7/z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q6BEEor6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMQXt7/z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q6BEEor6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMQXt7/z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q6BEEor6"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC22021D12;
	Tue,  8 Oct 2024 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728412043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mh67xLTZ4BlnQXfF2W9Y3OifTCqt2+5h4tXY2av1yas=;
	b=oMQXt7/zx+BifI1jsavWLCLV8YHi4wk5vA0Wa4lv8XrvNtbS55WDY4OBOW9BDo+CTdXp5l
	8rqkOnfstbHXmGuICWvo7g5MwThpVKtBoI0lqRi6ZTGWP4vHJto4cj7Frvrtijbz17XbHB
	8/yMAAfy1/mTJt41uPocG52sozm8zu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728412043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mh67xLTZ4BlnQXfF2W9Y3OifTCqt2+5h4tXY2av1yas=;
	b=q6BEEor6z4YznlENj1vDcpe3XJcej+xVTqZUDmahtwPbsKeEbvNX/kYYxu++V5FBIdkiyk
	a69JOXtbj3XDEjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728412043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mh67xLTZ4BlnQXfF2W9Y3OifTCqt2+5h4tXY2av1yas=;
	b=oMQXt7/zx+BifI1jsavWLCLV8YHi4wk5vA0Wa4lv8XrvNtbS55WDY4OBOW9BDo+CTdXp5l
	8rqkOnfstbHXmGuICWvo7g5MwThpVKtBoI0lqRi6ZTGWP4vHJto4cj7Frvrtijbz17XbHB
	8/yMAAfy1/mTJt41uPocG52sozm8zu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728412043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mh67xLTZ4BlnQXfF2W9Y3OifTCqt2+5h4tXY2av1yas=;
	b=q6BEEor6z4YznlENj1vDcpe3XJcej+xVTqZUDmahtwPbsKeEbvNX/kYYxu++V5FBIdkiyk
	a69JOXtbj3XDEjCQ==
Date: Tue, 8 Oct 2024 20:27:22 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Alessio De Marchi (GMail)" <alessio.demarchi@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Remote git server dubious ownership
Message-ID: <ZwV5iiX7ssf4yk53@kitsune.suse.cz>
References: <447ddc34-ab3a-4607-908f-64b9cc0268fd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447ddc34-ab3a-4607-908f-64b9cc0268fd@gmail.com>
X-Spam-Score: -3.74
X-Spamd-Result: default: False [-3.74 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	R_MIXED_CHARSET(0.56)[subject];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

On Tue, Oct 08, 2024 at 05:14:49PM +0200, Alessio De Marchi (GMail) wrote:
> Hello
> 
> I'm using git v2.46.2 on windows, and I have a server linux (git v2.45.2)
> where me and other developer push our repositories.
> 
> If i push my changes on a repository that is owned by another user the
> server git respond:
> 
> fatal: detected dubious ownership in repository...
> 
> 
> So I can push changes only in repository owned by myself.
> 
> It is possible to share a repository to more that one user? (I remember that
> it was possible untill some years ago)

look for the git safe.directory option. That makes it possible to
specify which repositories are shared.

HTH

Michal
