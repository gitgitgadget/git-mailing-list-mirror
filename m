Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65563CF
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735834; cv=none; b=KEu8Xaqq17iuzt01AXZXFqfHJTB0mWYrGsmGO5dnEYRtyrE+hhtXUHtYJBkXtrSHsFIWkF6ksndfyVPJv7FAQcRSFoIxWK14ZPmewM7QkRC4YF8MEp7Yr5TSRkg9V3TjlybFcNahHv5Wu9hQO7DIWL0nD4kHvuM7CoPpzypeA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735834; c=relaxed/simple;
	bh=GZCiQM+QCdc0FEm/7VAoEaSq6jELH7vkBxb2Xqiz09c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdRr+IMODJQxUFpHj3W38S4optLjjTjXEvDzh7vbnjB3yji8rQZ4NheArO44HgqsDonQIeKoOjAlrt5F7+efyxBRwMm9UGXEzqfytNXMYFJO9yU6ljw1CWrVwVTagfgLiLz9oF36HVAhZp2MHv08o44d2hfpbABLMQQLhPc2XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o+tXNQ1A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9tX1zB3g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cxIMIfjt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3MaA/3xs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o+tXNQ1A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9tX1zB3g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cxIMIfjt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3MaA/3xs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA32621246;
	Thu, 17 Jul 2025 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752735831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMXalaITc09Wbwaqw+AChBQHunuxME4jX70Vm13XFps=;
	b=o+tXNQ1AFeWbQzxDk0hTQD8Cedl3n6geXEhqGsURUXWfjnK139rrm/29CX2b+Jc0r0uBxy
	uu3EUjiAi7PCWwH4MjERu+bH5UUtI80ZAZPVMSlpOU1AWA/uNL5/fGn6X95tm7nq8sC6Xp
	HKDVXJOUuc48u5kVA43wyIXWnhiI+K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752735831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMXalaITc09Wbwaqw+AChBQHunuxME4jX70Vm13XFps=;
	b=9tX1zB3gUbmoNB2fM9F7eXF0cbzC+ZVmQ/H4aIu6EzboACYQhVOZ9/CWM7iF8LzYjoAQF3
	HOGrlyNiAAaFEDBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cxIMIfjt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3MaA/3xs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752735830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMXalaITc09Wbwaqw+AChBQHunuxME4jX70Vm13XFps=;
	b=cxIMIfjtzA5Y/72S3EO+l3zhM0nTS18RnqYKi6QNY6MQ4S8rQ0Zr0CuUtXanGWKF2hLcME
	R4gTyTyIuB7QyzsdldgNzEF/T/KxzIzImEGSlu0ZbegkUWrF76IIvVId88ju7MBw/JiMRy
	3Jjzn0LL7gQ1kSXMmDbp76rGPH5zegk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752735830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMXalaITc09Wbwaqw+AChBQHunuxME4jX70Vm13XFps=;
	b=3MaA/3xsVNHdNi2vglkyfbfCWZQEwMnE4xFzTyckhZeV77oSp7H2wPegIEckfrCSb2ZYYZ
	VZvIFScLAqRLWJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D2C1392A;
	Thu, 17 Jul 2025 07:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zR8BL1ageGisKAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Jul 2025 07:03:50 +0000
Date: Thu, 17 Jul 2025 09:03:50 +0200
Message-ID: <87v7nr9u3t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] git-gui: Add support of SHA256 repo
In-Reply-To: <2a7f20ef-ad7b-47b5-9c3a-71fbdd11e756@kdbg.org>
References: <20250716073227.11486-1-tiwai@suse.de>
	<2a7f20ef-ad7b-47b5-9c3a-71fbdd11e756@kdbg.org>
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
X-Rspamd-Queue-Id: EA32621246
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Wed, 16 Jul 2025 19:38:34 +0200,
Johannes Sixt wrote:
> 
> Am 16.07.25 um 09:32 schrieb Takashi Iwai:
> > Here is the v3 patch for git-gui to support SHA256 repos.
> > I put a preliminary patch to clean up $null_sha1 in addition to the
> > correction / update of v2 patch.
> 
> Thanks, queued.
> 
> I applied the following fixups: an obvious typo-fix in a comment and use
> of our wrapper function `git` instead of plain Tcl `exec git`.
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index c437980927fd..523e4df8069a 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1298,8 +1298,8 @@ if {[catch {
>  	set picked 1
>  }
>  
> -# Use object format as hash algorightm (either "sha1" or "sha256")
> -set hashalgorithm [exec git rev-parse --show-object-format]
> +# Use object format as hash algorithm (either "sha1" or "sha256")
> +set hashalgorithm [git rev-parse --show-object-format]
>  if {$hashalgorithm eq "sha1"} {
>  	set hashlength 40
>  } elseif {$hashalgorithm eq "sha256"} {

Thanks!


Takashi
