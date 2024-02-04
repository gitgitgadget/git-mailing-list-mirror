Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C688225AC
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061638; cv=none; b=C7K59Mr4o6Htv5ud5Mk6S99Exh3xXDTFHNieuLJkKNoTf/ezzHG7AufDBtJbVZOte/MEcDQtLPrVBRFe4OlnjUb5yMxD3xvZmr3kFilT2gLwca4EXqSvYl4KuzJoVq3kV1eRIvYaED12nn7tcCgq+kyHdJHIC5ErlfWCO59N0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061638; c=relaxed/simple;
	bh=Nr5SmWiWk1SWemhvZx7Yi6mTpjx00cLaCYMpKB5IwUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0l0yQ9LdennMvvommYT/+s73CUUzeKgECFYgtpD8pICONoGn3oq4Pefa5OZVmjKR1v5iD5izNv+Zn3ZO/qXzpaFXGgVsfYOcN0SOPnicbQ7a/jOXz8W6hud8y1SdIB68SPldGXhYF/NS/buK2G46F9AQd80YToN1cfBiPatLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+p3r975; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EuCj3HdF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+p3r975; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EuCj3HdF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+p3r975";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EuCj3HdF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+p3r975";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EuCj3HdF"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E191F821;
	Sun,  4 Feb 2024 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707061635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOvMpXWNYGU7/Rit05LHSIcH8Eaq2jbgsTtv/dFUwsw=;
	b=d+p3r975lOnyvyHCP7wKZuxraweiPLo7smaKGp3pB9TQQtwNS2DEjyCI2NSl5zZ9ZFdtHJ
	u/9isM9a9muFnzFjfHWhMZwnUXiF+zMhPWGHUm0pB/m6INLCE5VTdGLljOlUEetkJnRbGH
	KP/fkcNdAHPJzqash47fi2pW6PfOdmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707061635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOvMpXWNYGU7/Rit05LHSIcH8Eaq2jbgsTtv/dFUwsw=;
	b=EuCj3HdFPXLLwHZQf8uFtFbonOmHi9WC7jKFjY9ScL+1EbBAUAy6Qgt48znaRRf5oSS7+l
	jguhTPQ6ODxDT/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707061635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOvMpXWNYGU7/Rit05LHSIcH8Eaq2jbgsTtv/dFUwsw=;
	b=d+p3r975lOnyvyHCP7wKZuxraweiPLo7smaKGp3pB9TQQtwNS2DEjyCI2NSl5zZ9ZFdtHJ
	u/9isM9a9muFnzFjfHWhMZwnUXiF+zMhPWGHUm0pB/m6INLCE5VTdGLljOlUEetkJnRbGH
	KP/fkcNdAHPJzqash47fi2pW6PfOdmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707061635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOvMpXWNYGU7/Rit05LHSIcH8Eaq2jbgsTtv/dFUwsw=;
	b=EuCj3HdFPXLLwHZQf8uFtFbonOmHi9WC7jKFjY9ScL+1EbBAUAy6Qgt48znaRRf5oSS7+l
	jguhTPQ6ODxDT/Cw==
Date: Sun, 4 Feb 2024 16:47:14 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240204154714.GZ9696@kitsune.suse.cz>
References: <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
 <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz>
 <Zb+pQk9R3AOouFxF@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb+pQk9R3AOouFxF@ugly>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de,hotmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FREEMAIL_TO(0.00)[gmx.de];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 FREEMAIL_CC(0.00)[dunelm.org.uk,pks.im,crustytoothpaste.net,hotmail.com,manjaro.org,linuxfoundation.org,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sun, Feb 04, 2024 at 04:12:02PM +0100, Oswald Buddenhagen wrote:
> On Fri, Feb 02, 2024 at 12:50:04PM +0100, Michal Suchánek wrote:
> > Given the open nature of lore it should be feasible to provide
> > additional interfaces on top of it that cater to people used to PRs
> > on popular forge web UIs without hijacking the whole project and the
> > existing tools and interfaces. For some reason people are set on
> > replacing it as a whole, and removing the interfaces they personally
> > don't use,
> 
> > calling them obosolete.
> > 
> because they positively *are*.
> 
> when i started, patch-based code reviews were the norm, and i'm still using
> them for my small project with almost no external contributions.
> 
> but after working with gerrit code review for over a decade, i find it
> mind-boggling that people are still voluntarily subjecting themselves to
> mail-based reviews for serious high-volume work.

I have yet to see gerrit in action. Very few projects use it so it's
difficult to gauge what tradeoffs compared to e-mail based workflow it
does provide.

> it doesn't matter just how super-proficient you got with your old tools.
> there is just no way you'll get anywhere near as efficient as you would with
> the new ones, if you just were interested enough to learn them.  migrating
> the workflows that are worth keeping isn't such a bit deal.

Have you migrated them to gerrit already, and tought all the git
contributors how to use them from gerrit?

Somobody has to do it.

Also can you migrate away from gerrit once it becomes defunct or new,
better alternative emerges?

Recently it seems that forges offer a 'download your project data'
option, probably as a result of GDPR. What use is such data blob though?

An e-mail archive is that: an archive. It's a medium that you can read
with a wealth of software today, and 100 years from now. An achivable
data format.

Compare that with the 'download your data' blob from a forge. Can it be
uploaded even to a diffferent instance of the same forge to restore your
project elsewhere? Interpreted by any tool othar than the correct
vintage of that same forge? Deos even more than one instance of the
forge exist?

I have seen what hoops Gitea is jumping through to import data from
other forges, and it's not pretty.  Understandably, people who have seen
rise and fall of bitkeeper are wary of any tool that keeps your data
locked to itself.

And even if you do convert to gerrit it's unlikely to satisfy the "Why
are you not using github or gitlab" crowd. It's not one of the big,
popular forges they are familiar with, the UX is significantly
different.

Thanks

Michal
