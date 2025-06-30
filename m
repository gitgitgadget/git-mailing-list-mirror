Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C928D843
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296153; cv=none; b=E1CCQramSQDK0w0hWSnwx6AR/TpyLFDLopNeRlM8LYgusTIKV+7hEAnrMay31nAeyWiyn5L2eS1BoPQ4co1oXE106mU3vx8BrGUZGV9R2TWbowTBimLN2m3Mgs/GbZHn5MDZYFpamf/sNiHMgqsZKPTglvHF8ptGIHSCYjV2Bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296153; c=relaxed/simple;
	bh=+CTXeUq+qnmUq+PEJ2O6iiDa0p47qB4MMWIVhWHa954=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3rkoEcuCtOC3ogCYDDqFcwf/YYJRQ4HViO90ZwjOLYSCDFfrb1AdZ+lEt7qm8Y/Bb07/xv+L5eorifmE3sRbZYosQG72uu0F3Rpm6a/sj2QMe34IH8Hn1lzv4xC17uefFLwvLWSfPrCePtmfYGdHoDGw8vKCUyqyY/+9AiKCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BE2DRERD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=erxVL/DO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=diBIblDS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+T2jFcg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BE2DRERD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="erxVL/DO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="diBIblDS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+T2jFcg"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CD2C1F393;
	Mon, 30 Jun 2025 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751296149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0jULY8PtC0clJykHoIujjU3/BkAHdhMr9+yZVxQcpI=;
	b=BE2DRERD5QRZkbtMxdE8KaoGVZwSGdB8dR0lIV5ul13gDFCbDEdZJ07/BZSr0JAKO8b8Fx
	rBEO5MEDII4rm1ouU8MNb/MKrD/ZDxMZnR98EzvudDuac+DvJLGsvmjH0pOjjL5OYnaSpS
	Tw+OPr+qr7xxPTC1FD2gWFh3nLRhRso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751296149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0jULY8PtC0clJykHoIujjU3/BkAHdhMr9+yZVxQcpI=;
	b=erxVL/DO9eoHgqwrAI35eJxTJrAsu5OWuCNusnLHxBpOVVLgZdPsrBQrptCgpD4oyF1LPQ
	woxqd20amwpeYCAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751296147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0jULY8PtC0clJykHoIujjU3/BkAHdhMr9+yZVxQcpI=;
	b=diBIblDShG50OXei3kGKshoWp/FMv26VAQxf37dDWDbS+nEmmfqVGYxyesqDF+LvqbBBbB
	FcNQZyYXa3ua1jAziP6H+JpBKNG9AyMa6YsB6jrOaCsg4Hde6WAtGOMPIJbpf7r8edCwTW
	sLYmKSpt+RE6HO7jo09vLiox4KnNprs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751296147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0jULY8PtC0clJykHoIujjU3/BkAHdhMr9+yZVxQcpI=;
	b=p+T2jFcg9doUFqTqN1NXL3OGbrTsXHiq4fTlMk94zNql42NggWt8CiMlXv8kochT1be+54
	y9B3CUBl+L6dKeAg==
Date: Mon, 30 Jun 2025 17:09:06 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Failing to push to a repository erases authentication helper
 credentials
Message-ID: <aGKokqPJPh5fQ3fc@kitsune.suse.cz>
References: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
 <aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitea.com:url]
X-Spam-Level: 

On Mon, Jun 30, 2025 at 02:31:15PM +0000, brian m. carlson wrote:
> On 2025-06-30 at 13:45:30, Michal Suchánek wrote:
> > I was trying out AGit https://docs.gitea.com/usage/agit with oauth
> > helper https://github.com/hickford/git-credential-oauth encountering
> > this bug https://github.com/go-gitea/gitea/issues/34583
> > 
> > When doing so the oauth helper asked for new authentication, then for
> > some reason I was asked for authentication by some other helper.
> > 
> > After that pushing to repository to which I have permissions asked for
> > authentication again.
> > 
> > This hints that any failed git operation erases helper credentials.
> 
> This is true and it's by design.
> 
> > That does not sound like a desirable behavior.
> 
> It is in fact desirable because otherwise the user continues to attempt
> to use the bad credentials and then can never again authenticate
> successfully, since they are never again prompted for credentials.

My proglem is that the credentials are actually valid, only the
operation is not. The current behavior erases valid credentials.

> > Could the previous credentials be preserved?
> 
> Git doesn't have a behaviour to do so, but you could of course craft a
> custom credential helper that just rejects the erase command and passes
> everything else through to another helper.  That would achieve your

I do not want to use another helper. I want to preserve the last valid
credentials.

Of course, using credentials that are not maintained by git at all (such
as ssh authentication) does not have this problem. Only git-managed
credentials get erased on invalid operation.

Thanks

Michal
