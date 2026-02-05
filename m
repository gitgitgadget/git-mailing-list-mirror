Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB23D522A
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297484; cv=none; b=mXVml6y0eeaAhWi0LLbDseyyjnRaZVgpzzCY9Aa2jRGEV4BfGdVwzTDZBH2pNdO1ZBrACcihpPhlOMqolFMIAdoabtw9mqO/EgN/Pv9DokHFw8QhTNt73gx4B+uX2w6O7rYUHjoVV8DeU6fNKcQRu79EnfDREpEhy+xy8P7S5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297484; c=relaxed/simple;
	bh=71eKy7h6dAOrgeTJtGNU0ILTIwa9/H254o1AZ+QAMbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcB1gUGhYDsiUZqEGpIWO+QN5Md4a9M+7en8Z1FSVg4kK8oem99l7d3PJZomUckw3bBEFz/ZlOblx+cQUwIuE6EAs7c9EY92SS8hKJvjXWq5AlAC9qpoKuniXzAeXCr+sRuPxUIc2qz3oRY0+UYlNTPo0mw/osG72tSmQc21NsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+VB0ixU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4pe5xYxv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v+VB0ixU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4pe5xYxv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+VB0ixU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4pe5xYxv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v+VB0ixU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4pe5xYxv"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9512A5BD9A;
	Thu,  5 Feb 2026 13:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770297482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MiXviQ4+D0hXudX02+RaHSD0vsYav4AVMGxYz8KVMQ=;
	b=v+VB0ixUL0EHuw6NWE2kTuuIYTlEFujV+Wv8yiU8vifiFpfXWzk8XXgm0EQOMewysiQTvP
	2IR041OPGYgPCjfwY8og+PaJrEexIgEh+CVRaEgJ8PsG36iGav7aT9JLS8jey8qLqC+qEJ
	W+huRt8TdZsfMj375VwX1Tym8pUg7YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770297482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MiXviQ4+D0hXudX02+RaHSD0vsYav4AVMGxYz8KVMQ=;
	b=4pe5xYxv14hbyS7Mx7B+S7cU0vR11FbH9G9OTcJKQdQgYSu1ZDNl/mGA5eWE2UQO0aoQlr
	ESlpDJxoqJLb0RDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770297482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MiXviQ4+D0hXudX02+RaHSD0vsYav4AVMGxYz8KVMQ=;
	b=v+VB0ixUL0EHuw6NWE2kTuuIYTlEFujV+Wv8yiU8vifiFpfXWzk8XXgm0EQOMewysiQTvP
	2IR041OPGYgPCjfwY8og+PaJrEexIgEh+CVRaEgJ8PsG36iGav7aT9JLS8jey8qLqC+qEJ
	W+huRt8TdZsfMj375VwX1Tym8pUg7YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770297482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MiXviQ4+D0hXudX02+RaHSD0vsYav4AVMGxYz8KVMQ=;
	b=4pe5xYxv14hbyS7Mx7B+S7cU0vR11FbH9G9OTcJKQdQgYSu1ZDNl/mGA5eWE2UQO0aoQlr
	ESlpDJxoqJLb0RDw==
Date: Thu, 5 Feb 2026 14:18:01 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Peter Krefting <peter@softwolves.pp.se>,
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
Message-ID: <aYSYiSEXnahZtpAZ@kitsune.suse.cz>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
 <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
 <CANYiYbF295W88XUXqeiO9SXjDTMbJo9h8=mNk3xNALPHTXwvsQ@mail.gmail.com>
 <aYRVElg21EdWkjxi@kitsune.suse.cz>
 <CANYiYbEJymkh1bqz-iJeSOZ4D344Mx7G6iD6hiCpjzMnQx0SnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANYiYbEJymkh1bqz-iJeSOZ4D344Mx7G6iD6hiCpjzMnQx0SnA@mail.gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,free.fr,mail.ru,me.com];
	FREEMAIL_CC(0.00)[softwolves.pp.se,kambanaria.org,gmail.com,free.fr,mail.ru,me.com,cho.red,softcatala.org,flashtux.org,kgthreads.com,fangyi.io,goodhorse.idv.tw,vger.kernel.org];
	R_RATELIMIT(0.00)[to_ip_from(RL1uo9aieqzxhgb7dnxpsea1ka)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Thu, Feb 05, 2026 at 07:16:44PM +0800, Jiang Xin wrote:
> On Thu, Feb 5, 2026 at 4:30 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Thu, Feb 05, 2026 at 10:06:58AM +0800, Jiang Xin wrote:
> > > On Wed, Feb 4, 2026 at 9:00 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Wed, Feb 04, 2026 at 12:58:05PM +0100, Peter Krefting wrote:
> > > > > 2026-02-04 10:31 skrev Jiang Xin:
> > > > >
> > > > > > Please try using AI coding tools to update translations in po/XX.po or
> > > > > > review historical translations, following the prompts below:
> > > > >
> > > > > No.
> > > > >
> > > > > Please disable this altogether for the Swedish localization. "Translation"
> > > > > using stochastic parrots is not mature and just creates gibberish that takes
> > > > > more time to clean up than to do the translation from scratch manually.
> > > >
> > > > Hello,
> > > >
> > > > a similar attempt was widely reported, eg. here:
> > > > https://linuxiac.com/ai-controversy-forces-end-of-mozilla-japanese-sumo-community/
> > > >
> > > > As pointed out the availiability of the tools is not necessarily a
> > > > problem in itself. The problem in that particular case was that Mozilla
> > > > automatically applied the tools to existing translations, even
> > > > well-maintained ones.
> > >
> > > Thank you for the context—this is a good reminder that automation
> > > should never override community judgment.
> > >
> > > To be clear, using AI as a translation aid is entirely up to each
> > > contributor. In Git 2.53’s l10n cycle, I temporarily handled the
> > > Chinese translation (as the usual lead was unavailable), translated
> > > all new strings, and fixed many issues in older translations—both
> > > speed and quality were surprisingly good.
> > >
> > > As an l10n coordinator, I’ve long struggled with reviewing PRs: while
> > > git-po-helper catches technical errors, it can’t assess translation
> > > quality or detect irrelevant content like ads or political text. Here,
> > > AI can help flag such issues during review.
> >
> > That is really sad.  'ads or political text' sounds like something that
> > would be visible immediately if somebody looked at the change at all.
> > Which implies that you do not want to look at it, and have AI review
> > it. That is put AI in charge. That's not going to go well.
> 
> Git supports 19 languages, 14 of which have received active updates in
> the past year. How am I supposed to perform semantic-level reviews for
> languages I'm not familiar with?
> 
> In principle, I should trust all pull requests provided by team
> leaders, but having an AI-powered semantic-level code review
> available, especially for extreme scenarios or to assist contributors,
> isn't necessarily a bad idea.

Is it not or is it?

When you do not understand the language in question you cannot verify
the AI review. Neither for false positives nor for false negatives. So
far AI has been shown to provide lower quality reviews than actual
humans.

If the team leaders employ AI for typo and grammer review they can rule
out the false positives but you cannot. In the end you need to trust
them or learn all those 19 languages.

Thanks

Michal
