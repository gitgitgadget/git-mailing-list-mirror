Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD72BEC52
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915713; cv=none; b=I027prbHaML1IuyrprzkSi48oskgMad2VRND1SF8xNg3LqnX8L/JUfLsy5FtfX0vNiC7b/A3BrX61J4ogjKlF0Vpgsi/vwnFT6NB99ugEwtAbqPd1UQPFrUeuOnL6L1FC9Xye2/RbnxqIBSuaGKbbpt7sr1+YcyN9rYDg95GT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915713; c=relaxed/simple;
	bh=nEsTk6IDNp9as8lSCWiz+/+i6ZwyRrlR7gWnYMnxWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBNsn9HOrIm5g30ZZotzg5Y5D6F9MRDCcWgKGyhULIUua7jn8IjjyVDQX/acDjZvTWyHpysQ+cQuqujc9488wGQfIH423q+htWFEZ4q4A/RRJs5kdJPQb4bw05RxyaovkZ4LhiJfDtuX90J6RDSDW7wi769f2H5yX3CwuhTbCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JCa9u0ZB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JWGcoyZn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JCa9u0ZB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JWGcoyZn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JCa9u0ZB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JWGcoyZn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JCa9u0ZB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JWGcoyZn"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCFFB33682;
	Wed,  8 Oct 2025 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759915709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAuEMimsxA1lXdosiUl8rMmAa05uFaOuJYYekyqd/xc=;
	b=JCa9u0ZBFXqAYcRc4kzPYsYztfThikqe57O/DU0zNwhUN5k3GwMcBARzRbrVZcuONkR5XQ
	pkOnMCSL8oLJuJv5pHmHL6zoc+37TFwxWz2pQcDo00XuTqOGMukr8CzgyxIuMM6C115dwy
	Ub4h+G5Y0dkZo1Z1u/JM3EiR5rxzu+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759915709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAuEMimsxA1lXdosiUl8rMmAa05uFaOuJYYekyqd/xc=;
	b=JWGcoyZnHrFOR7Imn80kd0u14QixzOdAdTbiUhUnwMVrXjufod7Kh0t25+WcwPVjBZkw3D
	Y5PuYXZb7OW6NoAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759915709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAuEMimsxA1lXdosiUl8rMmAa05uFaOuJYYekyqd/xc=;
	b=JCa9u0ZBFXqAYcRc4kzPYsYztfThikqe57O/DU0zNwhUN5k3GwMcBARzRbrVZcuONkR5XQ
	pkOnMCSL8oLJuJv5pHmHL6zoc+37TFwxWz2pQcDo00XuTqOGMukr8CzgyxIuMM6C115dwy
	Ub4h+G5Y0dkZo1Z1u/JM3EiR5rxzu+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759915709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAuEMimsxA1lXdosiUl8rMmAa05uFaOuJYYekyqd/xc=;
	b=JWGcoyZnHrFOR7Imn80kd0u14QixzOdAdTbiUhUnwMVrXjufod7Kh0t25+WcwPVjBZkw3D
	Y5PuYXZb7OW6NoAg==
Date: Wed, 8 Oct 2025 11:28:28 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Christian Couder <christian.couder@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Rick Sanders <rick@sfconservancy.org>,
	Git at SFC <git@sfconservancy.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
Message-ID: <aOYuvGkQglLOEu-V@kitsune.suse.cz>
References: <xmqqcyalm0mh.fsf@gitster.g>
 <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
 <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
 <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
 <CAP8UFD34TrBa-GV1wUpvhO9K+qjHpXF4gr=afY2nsXiNL_-S+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD34TrBa-GV1wUpvhO9K+qjHpXF4gr=afY2nsXiNL_-S+Q@mail.gmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[crustytoothpaste.net,gmail.com,vger.kernel.org,pobox.com,ttaylorr.com,sfconservancy.org,gmx.de,pks.im,tuxfamily.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid,crustytoothpaste.net:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hello,

On Wed, Oct 08, 2025 at 10:37:53AM +0200, Christian Couder wrote:
> On Sat, Oct 4, 2025 at 12:20 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >

> 
> > I remember the SCO situation with Linux and how it really created a lot
> > of uncertainty with Linux because SCO created FUD around Linux licensing
> > and how that led to the DCO being created.  I am aware of the fact that
> > many open source contributors are very unhappy that their code has been
> > used to train LLMs without retaining credits and copyright notices or
> > honouring the license terms[2].
> 
> I don't think it's very relevant for your position on this. On the
> contrary, if LLMs have been trained mostly with open source code, then
> if they produce copyrighted output, that output is more likely to be
> compatible with the GPL. It has even been suggested (and discussed in
> this thread) that some AIs should be trained only with open source
> material (for example MIT licensed material?) so that we could stop
> worrying about including it. If that happens, there would be no reason
> to outright ban AI generated content, right?

even MIT license requires attribution. As most current day LLMs fail to
provide that their output is legally dubious even when trained on fairly
permissively licensed code.

Thanks

Michal
