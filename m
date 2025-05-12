Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A32185BD
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060609; cv=none; b=Dw9Dm1hh/u81XzLCHY4+j2ZY9gQO7DRQZHN/Bte7c41gRY84MaxgTFryJqWQ8Fd7IqtQmCgWRZmGHQ9vCQifbT0QciqzQ7qGsmb32Vxp9ForUMme/TBbsekfpTVPbY9QMK0RN0CJi4BbAibdgCN2VCV6iaQd+oolOD9fov5Y8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060609; c=relaxed/simple;
	bh=I+Zar2zfEsLRmZURiDHi42vgY+mnejNHYYmUS5TZQd8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NykWEIPxUGBQFi3tD1qcFPJvjLYzggUzc29f3g142jm8aPIpOXrE40TlPL8VazKiZTxnLCDQHBfmrwTDErDhY/PYGDYONFmHoGpz93Aw3Bl5UhS6aLZUw1rgPhBw5cKwAIVVyFahDz2xGrLu/qLPxa4lInD4rRXzmGYfk6Q/Ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfyKoRPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NtNpIYKT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfyKoRPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NtNpIYKT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfyKoRPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NtNpIYKT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfyKoRPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NtNpIYKT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A6892116A;
	Mon, 12 May 2025 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747060605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ASJ4quFWT3QRdIgzx6lWK+9e6ANvyp4P7CBxMPE0PU=;
	b=OfyKoRPZ5xjibbo4Yq6RYkbggVaBy5NsWjfJ/6Tnbs871WmSH1RTqGa1rHpJfvOJhW9v53
	Vsi2ZI26PM2aH9GElf2WrBlG7r+y7nb7cGJgCpaGxcgjpvUIIKcwBYdqqg5UKUVn2gM4fA
	kWZVlqrV5aw5TZ4x7zgLzWpUTkStzkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747060605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ASJ4quFWT3QRdIgzx6lWK+9e6ANvyp4P7CBxMPE0PU=;
	b=NtNpIYKTg5aQyzcE4rVW4+58w8XssyTSnHgmlI2SFpAgYQiaR0OdERX+FzfCbMNSsCvn0Z
	B9ZTIqJu26xqqhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747060605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ASJ4quFWT3QRdIgzx6lWK+9e6ANvyp4P7CBxMPE0PU=;
	b=OfyKoRPZ5xjibbo4Yq6RYkbggVaBy5NsWjfJ/6Tnbs871WmSH1RTqGa1rHpJfvOJhW9v53
	Vsi2ZI26PM2aH9GElf2WrBlG7r+y7nb7cGJgCpaGxcgjpvUIIKcwBYdqqg5UKUVn2gM4fA
	kWZVlqrV5aw5TZ4x7zgLzWpUTkStzkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747060605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ASJ4quFWT3QRdIgzx6lWK+9e6ANvyp4P7CBxMPE0PU=;
	b=NtNpIYKTg5aQyzcE4rVW4+58w8XssyTSnHgmlI2SFpAgYQiaR0OdERX+FzfCbMNSsCvn0Z
	B9ZTIqJu26xqqhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 290661397F;
	Mon, 12 May 2025 14:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HNx/CH0HImgnQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 May 2025 14:36:45 +0000
Date: Mon, 12 May 2025 16:36:44 +0200
Message-ID: <87tt5puc8z.wl-tiwai@suse.de>
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
Subject: Re: [PATCH 2/2] gitk: Add auto-select length preference for SHA256
In-Reply-To: <d3922b07-d9eb-477c-aa91-35ea709ad626@kdbg.org>
References: <20250320154136.23262-1-tiwai@suse.de>
	<20250320154136.23262-3-tiwai@suse.de>
	<d3922b07-d9eb-477c-aa91-35ea709ad626@kdbg.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -1.80

On Thu, 08 May 2025 08:20:57 +0200,
Johannes Sixt wrote:
> 
> Am 20.03.25 um 16:41 schrieb Takashi Iwai:
> > This implements the missing preference setup of the auto select length
> > for SHA256. The variable set via the preference menu is switched
> > depending on the hash algorithm.
> > 
> > The default auto-select length is set to 64 for SHA256, and
> > saved/restored as "autosellensha256" in the config.
> 
> I think the purpose of this change is to offer different settings for
> the selected length depending on the hash algorithm. If that is the
> case, the commit message could do a better job describing that: it says
> only what happens implementationwise, but not what the user sees.

Sure, I can rephrase.  Could you suggest a better text example?

> I do not think this is necessary. If I had set the option to, say, 12, I
> would not want it to be set to something else when I go to a repository
> that has a different hash algorithm.

The problem is that a value 40 is used always as default even for
SHA256.  So, without this change, the selection looks always shorter
than the full ID unless you explicitly change this option in the
configuration menu.  That sucks.

> (But I do not know for certain,
> because I do not have any SHA256 repositories, yet.)

You can find SHA256 git repos in src.opensuse.org, where we started
hitting the problems with gitk :)
For example, one of my repos below is very small:
  https://src.opensuse.org/kernel-firmware/kernel-firmware-all


thanks,

Takashi
