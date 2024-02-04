Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9622F13
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707061872; cv=none; b=sUuuClOhGJJKkie8Zzo5q0p27G7mNbqeZITx0xAGQWIjSjxMQYlJyKxmiVxQHZD5jTmyZol01960eonLiegXtN7al1YKFdfhmi2bTltVglfo5dLLWjpwYRyGlri4SDySdatu2/p33Lv19eG2qvifX5VNlxQ1X4cn2wlbfvpnPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707061872; c=relaxed/simple;
	bh=3qJbzagWuN2TCMAqtX1FkKxsEgeitAM+dUZZNkIsU4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG+6q8co2Fyu3Qv3QTbvUXXi2xXgwsdNcotrr2yYoxMBGHkJ+wXaJUdo67V5dmp6Do+wWW+0RYnL5mM2RCTY0DPuJsRaTyB95Qz9a/slDyUl1hu7GP0/c4qrjKM2I5QWBKpdrLbqD+9pUlJ0gLdfDOPFo9jjjbL7C3p2L2bSg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fx6RWbdb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7048Lznx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fx6RWbdb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7048Lznx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fx6RWbdb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7048Lznx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fx6RWbdb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7048Lznx"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B44DF21F60;
	Sun,  4 Feb 2024 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707061868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//kHhh/ukv6dXpWUH7sUSQxyKGePDHs+8HpqQKgR0ME=;
	b=Fx6RWbdbXqZXZFc0tlsJWvydQawAzzuA381XRryQvSWCd0T45i5b2IbhwlQZIEH82kPo7b
	czAnNMZQFm5m+PcA4BcSswf4pXZL9TK4PosNOyw+S6AO5aP9Tz6F42BV5ZXJ2tWFmUkibp
	hhOUFMYeXJW68QKVy3zPkGDyVas0N1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707061868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//kHhh/ukv6dXpWUH7sUSQxyKGePDHs+8HpqQKgR0ME=;
	b=7048LznxgSdRbMS5SREDa3B1eTpzgXJQjQLqLa7guQrnivgEIdFJ5YbEdWefIRNRtNmOkw
	srs2cgZ7Z9893ZAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707061868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//kHhh/ukv6dXpWUH7sUSQxyKGePDHs+8HpqQKgR0ME=;
	b=Fx6RWbdbXqZXZFc0tlsJWvydQawAzzuA381XRryQvSWCd0T45i5b2IbhwlQZIEH82kPo7b
	czAnNMZQFm5m+PcA4BcSswf4pXZL9TK4PosNOyw+S6AO5aP9Tz6F42BV5ZXJ2tWFmUkibp
	hhOUFMYeXJW68QKVy3zPkGDyVas0N1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707061868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//kHhh/ukv6dXpWUH7sUSQxyKGePDHs+8HpqQKgR0ME=;
	b=7048LznxgSdRbMS5SREDa3B1eTpzgXJQjQLqLa7guQrnivgEIdFJ5YbEdWefIRNRtNmOkw
	srs2cgZ7Z9893ZAw==
Date: Sun, 4 Feb 2024 16:51:07 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240204155107.GA9696@kitsune.suse.cz>
References: <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
 <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz>
 <Zb+pQk9R3AOouFxF@ugly>
 <6dc25a1ab1531b508e844cee1c970438@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dc25a1ab1531b508e844cee1c970438@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de,hotmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 FREEMAIL_CC(0.00)[gmx.de,dunelm.org.uk,pks.im,crustytoothpaste.net,hotmail.com,linuxfoundation.org,vger.kernel.org];
	 BAYES_HAM(-0.00)[31.45%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

On Sun, Feb 04, 2024 at 04:28:58PM +0100, Dragan Simic wrote:
> On 2024-02-04 16:12, Oswald Buddenhagen wrote:
> > On Fri, Feb 02, 2024 at 12:50:04PM +0100, Michal Suchánek wrote:
> > > Given the open nature of lore it should be feasible to provide
> > > additional interfaces on top of it that cater to people used to PRs
> > > on popular forge web UIs without hijacking the whole project and the
> > > existing tools and interfaces. For some reason people are set on
> > > replacing it as a whole, and removing the interfaces they personally
> > > don't use,
> > 
> > > calling them obosolete.
> > > 
> > because they positively *are*.
> > 
> > when i started, patch-based code reviews were the norm, and i'm still
> > using them for my small project with almost no external contributions.
> > 
> > 
> > but after working with gerrit code review for over a decade, i find it
> > mind-boggling that people are still voluntarily subjecting themselves
> > to mail-based reviews for serious high-volume work.
> > 
> > it doesn't matter just how super-proficient you got with your old
> > tools.  there is just no way you'll get anywhere near as efficient as
> > you would with the new ones, if you just were interested enough to
> > learn them.  migrating the workflows that are worth keeping isn't such
> > a bit deal.
> 
> Please, keep in mind that not everyone lives in a web browser and
> loves to click around.  Some people simply prefer to use the CLI
> utilities and to press the keys on their keyboards, and are very
> efficient while doing that.

The forge vendors found out, and started to provide CLI tools. That's
not really a general argument against forge software. Just as people
living on web is not general argument against e-mail - it's been brought
to the web a long time ago.

Thanks

Micchal
