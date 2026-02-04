Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87340758A
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210028; cv=none; b=A8eO1MxsIPtOqCwbQvHep06Z8s+O1rjp7xjM+oCvDQxkTuqd2ywwqp/KAEtB/Rs5WMAznF1U0DtVEJnli27MNgJHxCD0IKeNAN02x5B8AfSoCHfjDGP158jcfFrIpqgT5gy+uAMFkeW1Grn+FTJ4/SWpvA2nniFJioN0X92Hb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210028; c=relaxed/simple;
	bh=gEJcHOZHuiimbMQA6CqSv+vn9RUUSCXPbVdlKKu1/nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwIZjOjSTdQxJ+fCuaaFtjAKzdhgW1LNcWQH7m9WLbplZ2CqyMxKwSM/1zbGaNngh7bod6Hgup8B7ttY5AAXxtCuvUiLdxgyUn7ZqyoZJRxe8he826F807qFdbvalTPVd3etJhqdFd0SKyq68EeUfwa1e0qlrUFzGUjgunby/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cMbLSPLN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=57LrK9lN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y0o3hg87; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Op+a4Kc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cMbLSPLN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="57LrK9lN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y0o3hg87";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Op+a4Kc"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 631D23E733;
	Wed,  4 Feb 2026 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770210026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSMkiC7Mox8PYwrakypS5SjFzX75AREiGfonR1x7fGo=;
	b=cMbLSPLNtT6DD0FSGfxjf9814iigP+YhAHUCUpq3J3ceyaR0l5PEfZjVT4rXTEyKpf43Qo
	VKJjbBTlG/unxnj20hoxUdvw+eaePJIckY3Up2vYUx4M3R4EXMGTQxdNb/NvQq/CI7iNqT
	K8Yo04W1jYgaVPQx2aW2mdcuLWMmBLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770210026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSMkiC7Mox8PYwrakypS5SjFzX75AREiGfonR1x7fGo=;
	b=57LrK9lNHHiHvFXMbjrlDnDUZ86rFmSfG7qRFAkaw/9nVDvgD6FXhWbzYL2Hn7OoGGIgbB
	NwpeJegPbNZxI9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770210023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSMkiC7Mox8PYwrakypS5SjFzX75AREiGfonR1x7fGo=;
	b=y0o3hg87K/2PIKXhu3p72miKCzTOmuCoZfKmeu4NI4fsL8yA1IbpE9kn0epEqT56zV8duo
	FNL2QGGeswWAeqpriDANneo7kH0+zF8/6GFTx7nPEzuVLW+tW0v9+mdrImL0whdPl0YGBj
	Z4PmrXmlt82BtvaSowsmBKyGkmIJ8OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770210023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pSMkiC7Mox8PYwrakypS5SjFzX75AREiGfonR1x7fGo=;
	b=6Op+a4KciwcEmwhlAnq1XC1lZgiSadUSN8vm4L3WxBeEw3u5UzTgPYdj4OfeY2gg5Y8Bx3
	OgovFcnC31cB2ADA==
Date: Wed, 4 Feb 2026 14:00:21 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
	Jordi Mas <jmas@softcatala.org>,
	Matthias =?iso-8859-1?Q?R=FCster?= <matthias.ruester@gmail.com>,
	Phillip Szelat <phillip.szelat@gmail.com>,
	=?iso-8859-1?Q?S=E9bastien?= Helleu <flashcode@flashtux.org>,
	insolor <insolor@gmail.com>,
	Kateryna Golovanova <kate@kgthreads.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ray Chen <oldsharp@gmail.com>,
	=?utf-8?B?5L6d5LqR?= <lilydjwg@gmail.com>,
	Fangyi Zhou <me@fangyi.io>,
	Franklin Weng <franklin@goodhorse.idv.tw>,
	Git List <git@vger.kernel.org>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
Message-ID: <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,free.fr,mail.ru,me.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kambanaria.org,free.fr,mail.ru,me.com,cho.red,softcatala.org,flashtux.org,kgthreads.com,fangyi.io,goodhorse.idv.tw,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Wed, Feb 04, 2026 at 12:58:05PM +0100, Peter Krefting wrote:
> 2026-02-04 10:31 skrev Jiang Xin:
> 
> > Please try using AI coding tools to update translations in po/XX.po or
> > review historical translations, following the prompts below:
> 
> No.
> 
> Please disable this altogether for the Swedish localization. "Translation"
> using stochastic parrots is not mature and just creates gibberish that takes
> more time to clean up than to do the translation from scratch manually.

Hello,

a similar attempt was widely reported, eg. here:
https://linuxiac.com/ai-controversy-forces-end-of-mozilla-japanese-sumo-community/

As pointed out the availiability of the tools is not necessarily a
problem in itself. The problem in that particular case was that Mozilla
automatically applied the tools to existing translations, even
well-maintained ones.

Abandoned or completely missing translations may benefit from AI
translation when the topic is general enough that there is likely a lot
of training data available. Unfortunately, git with its specific jargon
may not be the most optimal project for automated translation.

When the generated change needs to be sent to a maintainer for review
having gibberish translation would be theoretically avoided. There is
the caveat that maintainers might receive more gibberish submissions
when the tools are available.

Thanks

Michal
