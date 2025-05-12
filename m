Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AB22AE6D
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061122; cv=none; b=PZECyg/IGnYdqG5hT01dwI0ynEpPe4FWbz/XsqRvOZ6my1mnjp6O4FwLnx06eJe5gSH2ZBPzEcHD6S+8/AynLgRwhmhfQ+ogpWlbLu2R5DdyjOP0jqYi8Zs7jweoHqHnEib26sL/g6J5Iaoru5iMSedwp+Ys+ibQqRNZQJTORbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061122; c=relaxed/simple;
	bh=Cxlq7rDbuuBY7RLgIdvl1GpTqKWGYckbq+qMvbZMe2s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKTNJV7l8m1onRatqqpcLeH8yHdn7/dvL9hqQ4N8mJ0uv8XSQBqViC/Mlj/eG9fKLXj+JRLT2su/jYjt5L6jeEplOnbede6cSGxwbE/faZb6tXa8snCRaIid8DgwyeLQBCdkgPE2ka844wtIrKN2pCx4ibUgPrh65Ck7BYgLFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QZe06vLX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ioa+DAW1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QZe06vLX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ioa+DAW1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QZe06vLX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ioa+DAW1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QZe06vLX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ioa+DAW1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E7F11F387;
	Mon, 12 May 2025 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747061119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVvffyPrwDIkUWZXENP1EP26SVmwGS48SwWezubeSis=;
	b=QZe06vLXgEZuryud/NOVLUcjKTTNsa5rDzjGFi5czMlaEtdEbrvvejpyfGt4BPEyyI59bg
	TqGOXMYMklV7yPiUy69zSFiRiXkHairUTIyJuLxjwXqnMEqgZ/hOhax0axG82n9LRhoPIt
	zTHY4Ts3liVPdP6rup+GZYtLYLi4eqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747061119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVvffyPrwDIkUWZXENP1EP26SVmwGS48SwWezubeSis=;
	b=ioa+DAW1wxxosXZz9UQF2grBM6LPxN5Cslcp4pa/UOc6qfQSGp8WjLVUXWgig1zBOaUfe+
	/qhP7yY3MMfSRKDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747061119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVvffyPrwDIkUWZXENP1EP26SVmwGS48SwWezubeSis=;
	b=QZe06vLXgEZuryud/NOVLUcjKTTNsa5rDzjGFi5czMlaEtdEbrvvejpyfGt4BPEyyI59bg
	TqGOXMYMklV7yPiUy69zSFiRiXkHairUTIyJuLxjwXqnMEqgZ/hOhax0axG82n9LRhoPIt
	zTHY4Ts3liVPdP6rup+GZYtLYLi4eqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747061119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVvffyPrwDIkUWZXENP1EP26SVmwGS48SwWezubeSis=;
	b=ioa+DAW1wxxosXZz9UQF2grBM6LPxN5Cslcp4pa/UOc6qfQSGp8WjLVUXWgig1zBOaUfe+
	/qhP7yY3MMfSRKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0ED21397F;
	Mon, 12 May 2025 14:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tiirMX4JImjxQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 May 2025 14:45:18 +0000
Date: Mon, 12 May 2025 16:45:18 +0200
Message-ID: <87sel9ubup.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	git@vger.kernel.org,
	Denton Liu <liu.denton@gmail.com>,
	Eric Huber <echuber2@illinois.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avi Halachmi <avihpit@yahoo.com>,
	Christoph Sommer <sommer@cms-labs.org>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 0/2] gitk: Support of SHA256 repos
In-Reply-To: <4ef123de-a338-4c06-8983-aa6c5380ad13@kdbg.org>
References: <20250320154136.23262-1-tiwai@suse.de>
	<4ef123de-a338-4c06-8983-aa6c5380ad13@kdbg.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,yahoo.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,gmail.com,illinois.edu,gmx.de,yahoo.com,cms-labs.org,ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80

On Thu, 08 May 2025 08:21:10 +0200,
Johannes Sixt wrote:
> 
> Am 20.03.25 um 16:41 schrieb Takashi Iwai:
> > Hi,
> > 
> > I recently stumbled on the problem of gitk with sha256 repo (while
> > testing the new openSUSE package git workflow that enforces SHA256);
> > gitk aborts immediately with a message "Can't parse git log output:
> > {commit xxx..}".
> > 
> > After skimming over the net, I found the patch [*] posted in 4 years
> > ago to add the support for sha256, but nothing happened since then,
> > unfortunately.
> > 
> > So here is the revived patch for gitk to add sha256 support, with
> > cleanups and corrections, in addition to the enhancement patch for the
> > missing auto-select length config for sha256.
> > 
> > Only lightly tested on a few sha256 repos.
> > 
> > 
> > Takashi
> > 
> > [*] https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com
> > 
> > ===
> > 
> > Rostislav Krasny (1):
> >   gitk: Add a basic support of SHA256 repositories into Gitk
> > 
> > Takashi Iwai (1):
> >   gitk: Add auto-select length preference for SHA256
> > 
> >  gitk-git/gitk | 96 +++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 71 insertions(+), 25 deletions(-)
> > 
> 
> Thank you.
> 
> After these patches, I still see a  few mentions of "40" that refer to
> object id lengths and are not converted.
> 
> - a comment above proc longid
> - a regexp in proc shortids
> - in proc setlink
> - in proc mkpatch
> - in proc mktag
> 
> They should be converted, too, I think.

OK, let me try those, too.  I guess it shouldn't be too difficult.
(I didn't know of those features :)


thanks,

Takashi
