Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D39298CAB
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228634; cv=none; b=fSNccJhm7UGxt1MlWQsNVDnGvDxIdLm6hj7zWyF5tjPIxdE8lpHyEsxaKd5b5tGWTPxYMy6t60F+uotaPs6zu7ZLYJQvx4IiIzxBvr/3lqt/GZ3Cid+KEqMqVmrw54Hq+8z3IVdFBJTIP9qS8wZ3MydyQzKkkPRerMoyfR1ouPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228634; c=relaxed/simple;
	bh=ctus4t1Z03iBY2FJme9NxpTQtO7LNg7RaryhLtL9IYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo5/0vgwJBNx09PPINyO/qX401NwAv84jl/gf3cOrbXWWdxVsYJjbVSUyskJHJ7t9WeRDIfCgl+CfKdw6buQKklVUBiMm1yrAcb2FYnTcUp0R7mcoQIpweE2XTxWcLuZbUp00lA8J0+X1UnIxVLx7DamL5NabzGxLjmL/NKGvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NEXu8c0v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UD1hpGR+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NEXu8c0v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UD1hpGR+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NEXu8c0v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UD1hpGR+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NEXu8c0v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UD1hpGR+"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B3133372E;
	Tue, 30 Sep 2025 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759228630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpwSpqURuHoO6sW2v0GMJTjmwKcSn6Fj9vQNyDwex9M=;
	b=NEXu8c0vjiARZp9NlJ5EtQ883FR1FT3sToNn885NxwpQGFeP4OjENP5BhdlccZNeBYVObl
	tK2YtSwy++fdH/Phu1q1i1yKBdr7HI4QLUICWAiA+7Kd1q98H4xeCaoxOpgnmAGb4dSr5L
	XW4ak7bssZlwT9hk21sB3gOzsetPK+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759228630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpwSpqURuHoO6sW2v0GMJTjmwKcSn6Fj9vQNyDwex9M=;
	b=UD1hpGR+eN/cwz5/ETBPgRTf3jV6nJctg2YbPmBKbqHpKmgy/6v9y1pxNRzEXV9UEVg0mz
	YoQkPJBDRjDiTJAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759228630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpwSpqURuHoO6sW2v0GMJTjmwKcSn6Fj9vQNyDwex9M=;
	b=NEXu8c0vjiARZp9NlJ5EtQ883FR1FT3sToNn885NxwpQGFeP4OjENP5BhdlccZNeBYVObl
	tK2YtSwy++fdH/Phu1q1i1yKBdr7HI4QLUICWAiA+7Kd1q98H4xeCaoxOpgnmAGb4dSr5L
	XW4ak7bssZlwT9hk21sB3gOzsetPK+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759228630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpwSpqURuHoO6sW2v0GMJTjmwKcSn6Fj9vQNyDwex9M=;
	b=UD1hpGR+eN/cwz5/ETBPgRTf3jV6nJctg2YbPmBKbqHpKmgy/6v9y1pxNRzEXV9UEVg0mz
	YoQkPJBDRjDiTJAw==
Date: Tue, 30 Sep 2025 12:37:09 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jason Cho <jason11choca@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <aNuy1aab954D3rJ1@kitsune.suse.cz>
References: <20250927152824.3132af88@jcubic>
 <xmqq4isn96s7.fsf@gitster.g>
 <aNglDzeOT5_4ZbdV@kitsune.suse.cz>
 <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Sat, Sep 27, 2025 at 09:08:44PM +0000, Jason Cho wrote:
> > It does not not show its own .git directory as untracked files
> > 
> > That can be seen as inconsistent.
> 
> Well, I see your point. Since the .git directory is from a git repo, the directory is ignored by git. Therefore, you want git to also ignore other items derived from the repo, including work trees.
> 
> However, this is a minor improvement and I suspect your proposed feature may have an unknown impact.

The impact is that the list of worktrees would have to be read to get
status. As status is not particularly cheap operation in any case I
would expect the problem to be minor.

> Anyway, what's your real use case? Do you really add hundreds of work trees within the same repo directory so that you hate to see them in git status?

What is the abstraction you are trying to propose here?

Or do you suggest to eschew any intelligible abstraction in favor of
(probably minor) implementation convenience?

Thanks

Michal
