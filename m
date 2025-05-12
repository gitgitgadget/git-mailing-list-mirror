Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2021ADA2
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060154; cv=none; b=Mm8wBfaed7/58pusoXa6wGI2AVj+t3OdsU/LEl15VKsFScD8ykTYcqIO3IrxeNoD8U/hM6/gii4TKL3OvL65m0SQ04TxfeIp9rTDEmRiNbqFdLj9SlybWhvFhq+mPBugsV++0+t6gYI8gaoVtlF3skOL+0CS83Bh8mYXx1Rk27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060154; c=relaxed/simple;
	bh=Vw95G4k/+9RDvrw/1rtLE3U5uu+6gRcTWBXQ3cK+3Ag=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6r+vi4Neo1GJM2oZ+OVkYOsAEg0A+zu4xjdoBg2fYfKk/LlJp5LHcwZf0CtQS47LsGx1l+NUhtS1vSb2u/xVq8e4RyzoRTrsIwOsG9dMnIUi4q5m1XbMdnZOb9d2i/OiHXapIcdXyehNrCDt91wpOubYVgQEoZ6IwFgS6Vr3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zUpUfJEO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T/sXNobx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IcPU0R44; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ivZerfcY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zUpUfJEO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T/sXNobx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IcPU0R44";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ivZerfcY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D49BB21174;
	Mon, 12 May 2025 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747060151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xrCoNLglaDt/jy3fOTOHOqkFtFOq3p8t7taoYkaL3k=;
	b=zUpUfJEORLAvh1BVZlJvRQeSEWGO1jb7N8nMGv+SBkzFNjUDCle19XDBMkCme/ZkLqM1V5
	NF8YeyxBIQCPT3JRbjJz6KI9X7zS5uK2cyPdg958orHNKX2SGbvmA89SPyKfhvRo2avway
	XjWn8S/7YsXrOM1foHdAhAuqYQRquUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747060151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xrCoNLglaDt/jy3fOTOHOqkFtFOq3p8t7taoYkaL3k=;
	b=T/sXNobxNksUwYjRW1CY0Fm2Wt3OamEC/VaIvnrOGtIQWZ9ERaFezwSJTAF46iBwNqarp0
	++FZtU6MwSGle4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747060150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xrCoNLglaDt/jy3fOTOHOqkFtFOq3p8t7taoYkaL3k=;
	b=IcPU0R44knwk7V5LPAK3pFsYV3er1fZKtgLVQIp07QBFuXWoQmE+pcUJi2Fm993O98aFHF
	cuXpSzMHH8OcFy78YhZZa9ucBUIczp5FRPcaBR/PuK4kiY3pItPbFCylDkZIov47jtUn+/
	WP4gKaFuIWjSVjkkCO9Rxx69imGNjVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747060150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xrCoNLglaDt/jy3fOTOHOqkFtFOq3p8t7taoYkaL3k=;
	b=ivZerfcY4J1QBJPHB31Rkr0LB1xd0DM/5gve7IqcwzuY/Gxerav9sejA0cKtKuc2xFfve6
	zGzniAhqdwgOQVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98B4A1397F;
	Mon, 12 May 2025 14:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ik4EJLYFImjMPQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 May 2025 14:29:10 +0000
Date: Mon, 12 May 2025 16:29:10 +0200
Message-ID: <87v7q5ucll.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Denton Liu <liu.denton@gmail.com>,
	Eric Huber <echuber2@illinois.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avi Halachmi <avihpit@yahoo.com>,
	Christoph Sommer <sommer@cms-labs.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] gitk: Add a basic support of SHA256 repositories into Gitk
In-Reply-To: <9bb1699a-ec99-40b3-bd6a-00e809d77d0d@kdbg.org>
References: <20250320154136.23262-1-tiwai@suse.de>
	<20250320154136.23262-2-tiwai@suse.de>
	<9bb1699a-ec99-40b3-bd6a-00e809d77d0d@kdbg.org>
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
	FREEMAIL_CC(0.00)[suse.de,gmail.com,illinois.edu,gmx.de,yahoo.com,cms-labs.org,ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Score: -1.80

On Thu, 08 May 2025 08:20:40 +0200,
Johannes Sixt wrote:
> 
> Am 20.03.25 um 16:41 schrieb Takashi Iwai:
> > From: Rostislav Krasny <rosti.bsd@gmail.com>
> > 
> > This PR makes Gitk working on both SHA256 and SHA1 repositories without
> > errors/crashes. I made it by changing and testing the gitk script of Git
> > for Windows [https://gitforwindows.org/] version 2.32.0.windows.1 that
> > is a little bit different than the mainstream 2.32.0 version.
> > 
> > Still not fixed functionality: [1] There is the "Auto-select SHA1
> > (length)" configuration preference that affects "Copy commit reference"
> > on both SHA1 and SHA256 repositories.
> > 
> > A new "Auto-select SHA256 (length)" configuration preference should be
> > added and used on SHA256 repositories instead of the old one. Since I'm
> > not familiar with Tcl/Tk and this issue isn't critical I didn't
> > implement it.
> > 
> > [ Changes from the original patch:
> >   * Discard the changes for generic words (e.g. "Commit ID"), so that
> >     translations can be still applied after this patch
> >   * Simplify the regexp check in gotocommit as suggested in the
> >     previous review
> >   -- tiwai ]
> 
> The message should be updated to not mention the evolution of the change
> and what is not relevant anymore or not relevant in this patch.
> 
> > 
> > Signed-off-by: Rostislav Krasny <rosti.bsd@gmail.com>
> > Link: https://patchwork.kernel.org/project/git/patch/pull.979.git.1623687519832.gitgitgadget@gmail.com
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> 
> > @@ -8920,11 +8932,11 @@ proc gotocommit {} {
> >          set id $headids($sha1string)
> >      } else {
> >          set id [string tolower $sha1string]
> > -        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
> > +	if {[regexp {^[0-9a-f]{4,63}$} $id]} {
> 
> This doesn't use $hashlength. Should it?

Not needed.  It's a range match, and can work in a shorter string,
too.  And, that's what suggested in previous reviews (years ago!).

> Also watch out space vs. TAB.

OK.

> > @@ -12524,6 +12539,18 @@ if {$tclencoding == {}} {
> >      puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
> >  }
> >  
> > +set objformat [exec git rev-parse --show-object-format]
> > +if {$objformat eq "sha1"} {
> > +    set hashlength 40
> > +} elseif {$objformat eq "sha256"} {
> > +    set hashlength 64
> > +} else {
> > +    error_popup "[mc "Not supported hash algorithm:"] {$objformat}"
> 
> This looks strange. Where is the $objformat substituted?

Sorry, I don't understand your question here.  Isn't it what you see
in your quoted line...?

> > +    exit 1
> > +}
> > +set hashalgorithm [string toupper $objformat]
> > +unset objformat
> 
> Why not set hashalgorithm right away, without using a temporary
> objformat? Why set it at all here? It's unused.

The objformat is what git-rev-parse gives, and it's also referred to
show in the error message.  You shouldn't convert it to the upper
letters blindly there.

The hashalgorithm is with upper letters for SHA1 and SHA256 to be
shown correctly in other places.  It could be "SHA-1" or other
strings, but it's done in that way because of simpleness.


thanks,

Takashi
