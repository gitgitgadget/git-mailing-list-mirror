Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08592EFD89
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394333; cv=none; b=N+qMsD2pxy5U2A1GMArXyzAei1fRPfkYGUT9cF0RAhRv4/YMVup7RtkIMa/eQiOpqZMlsulYVSCG2NureVKTpknWcLTCIzTlwMOTMl9FZ+St00UFjo48Kovv5umLYjROefIFrE5F4ky9KeHeHrqRem7g3ULwMnJC42W0JncMpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394333; c=relaxed/simple;
	bh=6kgwX0kmPqxNdXgR2EdnhpebRLtkE9PU7OeKQ4bnlpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6YhBCUxlqiz5rJbK35UjmpSht8EP9aQpwtCtz7p0l/R344eojr4NECyBp5YZmE7g/VGx2BOftzXtcdor+zztY8SWdwPu4iUc1eR0Ldn7LkFU6aIIcGhQ26ZKFxs+HVIg5xZ3wZL1KFCC02VGhzI4m58mRRrmkRyqNhJmj5uLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NXYyrZ4S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CpY4honc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NXYyrZ4S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CpY4honc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NXYyrZ4S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CpY4honc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NXYyrZ4S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CpY4honc"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58DF21FB41;
	Thu,  2 Oct 2025 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759394329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isqxlHGMGzfH1vCk2CzFvu1RU8oCONcWwqCkskxUrFs=;
	b=NXYyrZ4SF4ltJkrD1es7zED/TtI4RpFH8jS5RN6/PwxbPk92HQPbeTGl7f9zeLpdavNbgu
	L4eaz2apPfktAr/4eyYa5QwL23/XiYMUBFL61qIVFmBoBhDBEqTXOFZG/1OB3DnZINW/Ow
	qKQ3/uJVBM50o47Cw2AIhbyusWrnCiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759394329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isqxlHGMGzfH1vCk2CzFvu1RU8oCONcWwqCkskxUrFs=;
	b=CpY4honcF2Fe4cTXRIOE4ZRXRliCjmCXx0o0l4Y3IR04pYo9tLsN7qb5o2fTi69vS3HuLt
	nWTC2ZoPyPm5qmBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759394329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isqxlHGMGzfH1vCk2CzFvu1RU8oCONcWwqCkskxUrFs=;
	b=NXYyrZ4SF4ltJkrD1es7zED/TtI4RpFH8jS5RN6/PwxbPk92HQPbeTGl7f9zeLpdavNbgu
	L4eaz2apPfktAr/4eyYa5QwL23/XiYMUBFL61qIVFmBoBhDBEqTXOFZG/1OB3DnZINW/Ow
	qKQ3/uJVBM50o47Cw2AIhbyusWrnCiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759394329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isqxlHGMGzfH1vCk2CzFvu1RU8oCONcWwqCkskxUrFs=;
	b=CpY4honcF2Fe4cTXRIOE4ZRXRliCjmCXx0o0l4Y3IR04pYo9tLsN7qb5o2fTi69vS3HuLt
	nWTC2ZoPyPm5qmBQ==
Date: Thu, 2 Oct 2025 10:38:48 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <aN46GP7-yUfXB_lL@kitsune.suse.cz>
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
 <E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
 <xmqq3482312r.fsf@gitster.g>
 <875xcyfk3k.fsf@osv.gnss.ru>
 <xmqqa52a1h6x.fsf@gitster.g>
 <CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
 <xmqqms6az2a0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms6az2a0.fsf@gitster.g>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sunshineco.com,gmail.com,proton.me,jcubic.pl,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Wed, Oct 01, 2025 at 03:27:03PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > skip over them when scanning the output. Moreover, I think this is the
> > first time that we have (on the list, at least) heard a complaint
> > about the "noise", which may suggest that this is a non-issue for most
> > people, and that a warning telling people to avoid the practice would
> > be unwelcome.
> 
> Ah, different people guess different reasons out of the same
> observation.  My interpretation of this is the first time about the
> complaint on "noise" was because everybody else would not even have
> additional worktree in-tree.

I suppose a suggestion about not adding worktree in-tree in the add
command description would be helpful to avoid the problem.

That's the part I would read if I wanted to learn about adding
worktrees, and it has none of those examples you mention.

> > Aside: It might be valuable to extend the documentation to add a
> > discussion about hanging worktrees off of a bare repository. People do
> > use such a workflow, and git-worktree officially supports it, but I
> > don't think there is any in-project documentation which mentions it.
> 
> Oh, that is an obvious thing to do, too, to attach "additional"
> worktrees to a bare repository (which does not have the primary
> worktree).  I do not think anybody sane would add these worktrees
> in-tree if the repository is bare, though.

That's exactly the part that is obvious only to people familiar with git
internals, not people reading the documentation. And it's what is needed
to create the side-by-side layout for people that want to use that.

Thanks

Michal
