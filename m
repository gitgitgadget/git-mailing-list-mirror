Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2414A62A
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434023; cv=none; b=LWJ8rA5NGcq7oL+c3GD7G2ybR4cYjwMWxBaojmwtiMG+Qzd55MOC+kMOObWLv0ILLl1txGFoTnwbR5hvmN/C6NzjRqcwLIJ8ci5d4ee67TF3tpA0Xa+PIHMNaso3Kv/g353EPpAC/lKy8RM2lnvAufR7xHuSYlxP8GBvDX9HUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434023; c=relaxed/simple;
	bh=T6rk+U6S2DujtKBoK+oHVjUvHXGH//te1pyHkWm9ybI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thB1U0KE2aB2JyyWcjeBBB1PZuxhz+jiQiw4fC1gbgDkQh8cLAqyi7+s789svjAMkVZBU/Yd78MNW1zhjl6bHBBHOlphwZ/fOzju95EiZ6GoCCp5hKrQ+plTR2PHv6pesKD6IvnU3h2a0025Z8u306bBUCB1g9bOxjznWozi7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B1gvNDjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X+rLvm/F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B1gvNDjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X+rLvm/F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B1gvNDjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X+rLvm/F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B1gvNDjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X+rLvm/F"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 044DC1F79F;
	Wed,  4 Sep 2024 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725434020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAG3II4JZQ1wlQUFU8SyOVRzbIXDoefVPbnhxC0h6qw=;
	b=B1gvNDjfuZo5FlzLFOELPypPuZkWo+D9TWI/eHoOXNdTW+L8BckhTY86NAkvx+uz4xAE7M
	GiLydq284iwwAEN7l7ZvjrsTR0QZR7E6ljsDaTR+H7ONDlclunNiW62pEA5B/puA7aOxZJ
	eF/Kkwx28wPYnUmCiA3uL3wjObiRQrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725434020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAG3II4JZQ1wlQUFU8SyOVRzbIXDoefVPbnhxC0h6qw=;
	b=X+rLvm/FaD1Ub0PkuuLahzHfl0gg0FBDV5gMfO3PrjBOJwLhDJLWAsWtd7C8YC3x3ul/Ot
	VFiB1yQdXKpTz4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725434020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAG3II4JZQ1wlQUFU8SyOVRzbIXDoefVPbnhxC0h6qw=;
	b=B1gvNDjfuZo5FlzLFOELPypPuZkWo+D9TWI/eHoOXNdTW+L8BckhTY86NAkvx+uz4xAE7M
	GiLydq284iwwAEN7l7ZvjrsTR0QZR7E6ljsDaTR+H7ONDlclunNiW62pEA5B/puA7aOxZJ
	eF/Kkwx28wPYnUmCiA3uL3wjObiRQrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725434020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAG3II4JZQ1wlQUFU8SyOVRzbIXDoefVPbnhxC0h6qw=;
	b=X+rLvm/FaD1Ub0PkuuLahzHfl0gg0FBDV5gMfO3PrjBOJwLhDJLWAsWtd7C8YC3x3ul/Ot
	VFiB1yQdXKpTz4Bg==
Date: Wed, 4 Sep 2024 09:13:38 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: sideshowbarker <mike@w3.org>, git@vger.kernel.org
Subject: Re: Problem: git Notes not discoverable (+proposed solutions)
Message-ID: <20240904071338.GW26466@kitsune.suse.cz>
References: <Zp89ntYaeFUumaTO@w3.org>
 <xmqq7cbsh16d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7cbsh16d.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Sep 03, 2024 at 02:34:02PM -0700, Junio C Hamano wrote:
> sideshowbarker <mike@w3.org> writes:
> 
> > ## Problem description
> >
> > When a project has added git Notes for its commits, git by default doesn’t
> > automatically fetch the Notes; so, the Notes aren’t automatically discoverable
> > to contributors who are using “git log” to read the project commit logs — and
> > especially not discoverable to new contributors, or “casual” users of the logs.
> >
> > A user will see the Notes only if they _already_ know what git Notes are, and
> > know that the project uses Notes, and the user knows how to get them.
> >
> > But the reality is: most users do not even know what git Notes are, and don’t
> > know how to get them if they exist. So most people end up never seeing them.
> 
> And even if they did, they wouldn't know how to use them, so not
> much is lost here.
> 
> Quite honestly, a project that uses notes in such a way that it is
> essential to understand/utilize the history should reexamine its use
> of notes and try to see if they can make its commits more useful
> without relying on notes, I would think.

The notes could be also used to annotate existing upstream history
without altering it.

However, the problems with notes worflows make it impractical.

Thanks

Michal
