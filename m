Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641B84038
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537107; cv=none; b=LbSy6U0JkfIcS9+wwKD0MAKU6M/nujzgY2/vg+CN3Nx7IJKcZ5KsRkuOzV7o+XECtt4eyEzppf+SsZOJsZC6O4aJnQbXerEkM8vHJKySHlgdztkRVapoERNu9ubMXPcW8qxIb7deKHwpR68jfbmz0Kg0OrzkK+xTJd7JJxe+bAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537107; c=relaxed/simple;
	bh=K3lhvHwJxFpZDHP3Vv5c5pA25j/EoqnJxLmRj2xFVco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of5BGHIMAkbDeaEgb5b0Sqd+1i3mFjwFSIKL8ps0IGlOWhBDZKo67GVP1hk9fzvMi1qEThzG+2s0BVqJ1BN9CqYHGbqpRLIgfTEX/wV9qRrL00tAzCFmLJCP1BpI6CqyxdRdds76KhnunUyxkhvchgvlL/PdYrR+nxRNjcSDP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lqZodpyJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JehRM0BE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lqZodpyJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JehRM0BE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lqZodpyJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JehRM0BE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lqZodpyJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JehRM0BE"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A46B21EF0;
	Wed, 21 Feb 2024 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708537103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65FdHMzM6Or8su7kpxCJ3i8tAiTTK7i3El2DWO3AbP4=;
	b=lqZodpyJLuulioUOWZfeLlBhg6wYaJ86OpDNoRvgyKvE8Z41Sjpp7K/vq0naI50HMRK3sN
	ZjK5KDGVNz0Hd9vh9zpETHRd2lYWUYOMRddeKe9d8a7IxaBT2X+QFjzwmQ3Qb4k1xZNMYB
	VFM0wP/xTDM9BqGvE4mopttGdsKNxTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708537103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65FdHMzM6Or8su7kpxCJ3i8tAiTTK7i3El2DWO3AbP4=;
	b=JehRM0BEhTcB44Zfi4P0V4qaWboP1cJlbbQivP9dbsl5Xiq+Y4NWfuj/RBRrreG+H3PZmy
	Iry1qf1kO/zdc5Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708537103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65FdHMzM6Or8su7kpxCJ3i8tAiTTK7i3El2DWO3AbP4=;
	b=lqZodpyJLuulioUOWZfeLlBhg6wYaJ86OpDNoRvgyKvE8Z41Sjpp7K/vq0naI50HMRK3sN
	ZjK5KDGVNz0Hd9vh9zpETHRd2lYWUYOMRddeKe9d8a7IxaBT2X+QFjzwmQ3Qb4k1xZNMYB
	VFM0wP/xTDM9BqGvE4mopttGdsKNxTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708537103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65FdHMzM6Or8su7kpxCJ3i8tAiTTK7i3El2DWO3AbP4=;
	b=JehRM0BEhTcB44Zfi4P0V4qaWboP1cJlbbQivP9dbsl5Xiq+Y4NWfuj/RBRrreG+H3PZmy
	Iry1qf1kO/zdc5Aw==
Date: Wed, 21 Feb 2024 18:38:22 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
Message-ID: <20240221173822.GA9696@kitsune.suse.cz>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <xmqqv86jqc2e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv86jqc2e.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.66
X-Spamd-Result: default: False [-1.66 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.945];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,harmenstoppels.nl];
	 BAYES_HAM(-0.37)[76.98%]
X-Spam-Flag: NO

On Tue, Feb 20, 2024 at 09:29:13AM -0800, Junio C Hamano wrote:
> "Harmen Stoppels via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Harmen Stoppels <me@harmenstoppels.nl>
> >
> > When you run `git rebase --continue` when no rebase is in progress, git
> > outputs `fatal: no rebase in progress?` which is not a question but a
> > statement. This commit makes it appear as a statement.
> 
> "This commit makes it appear" -> "Make it appear" (see
> SubmittingPatches).
> 
> >  builtin/rebase.c | 2 +-
> 
> This change is very good, but a commit that touches code should not
> touch po/ localizations in this project.  They are updated to match
> the code change by respective language teams.

Or if it does touch the po files it could as well update the
translations.

There are changes that can be trivially translated without any knowledge
of the target language.

Thanks

Michal
