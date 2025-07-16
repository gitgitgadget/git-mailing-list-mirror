Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730512882D8
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650650; cv=none; b=UxbEAE/u6FACDnistYC8UtsyHq696s1L5YJPSWh4lfRdTEmWxqMxa4pprr73zrW9qJtqw2xnewUCsRPbLtD6rszjM83FjcHKvdB6rVHwbRtROrFS6IaGNDOqAJtDplXWVuzhAOZKVpiI+kJOWTqZO+Eua1TthCB9j4N97h0kxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650650; c=relaxed/simple;
	bh=9pJio6SQlwwxXIJsIstR5ByuXsCHIiTonlQMNrHeXag=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NliVwCa/TwTDM0/ZYscS0/on6gKdw3JdAMG4jtz10x5oP5vHDMk5Du+B0rHNSm6JupuLialGMjpVWBQ3kSIiEoF7RdlCrStZjmfxYQiMnXu5qxnK9z3qZJeKnn7vlYLNfXDAmbSkggAoiD5paAErKCSdef9fyzTG7LA10PoC214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dT27SVmp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LkdIwO/U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nzu83UOk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7tp6TSO7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dT27SVmp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LkdIwO/U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nzu83UOk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7tp6TSO7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05FE81F38F;
	Wed, 16 Jul 2025 07:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752650642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjr0D3vt/zgulHWLhQw9eFrs9ObLMHujo9Gt+OsY0Co=;
	b=dT27SVmpGiGGUg12Iag1PYJfLWy3wD3zJ5TA5B32m05BNb+/DGacVQ/FXPHY6ReY8vd7Bx
	cRfFbq12/RMA81dychZXfRL1QVM+HzMkDoaAoXNSa+Gw5KiUxO4eAozRzwKmrptlGE/xlf
	LZhulzG84z1IWamHT/dtKjWpTw/gJQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752650642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjr0D3vt/zgulHWLhQw9eFrs9ObLMHujo9Gt+OsY0Co=;
	b=LkdIwO/UV7NtjQ1bGbX7vCoB2jDPwc6Razb+Z1+SunQr75DwvRNRzWrk+NTPVufuuqecrT
	8ksATaw2CK0yE/AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nzu83UOk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7tp6TSO7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752650641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjr0D3vt/zgulHWLhQw9eFrs9ObLMHujo9Gt+OsY0Co=;
	b=Nzu83UOkjFaAwL3OdWAvMEBfH8SdUCsyyl7ps5sXfYH2dy8JHHAaXTT5N3gYjSFOh9vbXC
	sA3G2fSBlcgxzcs6PDHF3KNbO3BZ8y+oXmju1cardxoE6tx/hOB5I8C0CdvgEzd2BjUaPX
	lqFOVHQBXIwDa7Y1pe7fSskLSdFv7/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752650641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjr0D3vt/zgulHWLhQw9eFrs9ObLMHujo9Gt+OsY0Co=;
	b=7tp6TSO7rTg0l1VrOE9s9Mgdz+pe9CPrhP5uKaj6hKlzgv/a/KetQ3DrdPJGy7zuKdJa1E
	i7U8hnzu0jnCRiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC6313306;
	Wed, 16 Jul 2025 07:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M9l+LpBTd2jCfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 16 Jul 2025 07:24:00 +0000
Date: Wed, 16 Jul 2025 09:24:00 +0200
Message-ID: <87ple08upb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui: Add support of SHA256 repo
In-Reply-To: <c543a644-8e58-4601-8a79-247cd5e124c5@kdbg.org>
References: <20250703120430.17240-1-tiwai@suse.de>
	<b78bad36-d4ae-4d91-a72a-c3446e10d34b@kdbg.org>
	<87ecuha66p.wl-tiwai@suse.de>
	<c543a644-8e58-4601-8a79-247cd5e124c5@kdbg.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 05FE81F38F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Tue, 15 Jul 2025 21:19:38 +0200,
Johannes Sixt wrote:
> 
> Am 15.07.25 um 16:18 schrieb Takashi Iwai:
> > On Mon, 14 Jul 2025 18:28:13 +0200,
> >> BTW, there is a case
> >>
> >>       if {[regexp {^[0-9a-f]{1,39}$} $head]}
> >>
> >> around line 3217 in git-gui.sh.
> > 
> > Obviously I didn't look for numbers less than 40 :)
> > I'll replace it, too.
> > 
> > But I don't understand why it matches up to only 39, not 40 in the
> > code above.
> > It seems trying to get the proper hash id if it's no full length id?
> > If so, the check should be rather like
> > 	if {![regexp {^[0-9a-f]{40}$} $head]}
> > ??  It makes the conversion a bit simpler.
> 
> Obviously, the code wants to turn abbreviated hashes to full hashes.
> That can be skipped if it is already the full length. I haven't analyzed
> why this is needed or desirable.

Maybe it wants only the abbreviated hashes and no other refs?
I'll keep the logic in v3 patch.  If any, we can clean up later.


thanks,

Takashi
