Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0001E3DDE
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228248; cv=none; b=HiOB9Z1pMlXs5Tp5VXK7rvo3gRhJbiwz+kBypAqXecJULB8BmwuwK/jTECGKE2Jz9hH6dpD2D/zckkmCDE2Qe6hSJOe0VnANptmxrBKpxqEkD66JatJaoIJ+DzolfsHO6iYPPTMiHchvk3XJck01FtioeOx3nz04FefKd8y/kV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228248; c=relaxed/simple;
	bh=wb0Ll/fAGbpKIz0OL3G+GgNTkifVfoSwgtShH+qxAJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZi3meGFomOOZSbP6a2rBUMZDjAZ7ZpT2z1wFzN/4AmhUAszip5FYwFIr5ldAXbRULWE/j/dGPNNbEaBytTYO6gkRHYYf0ByDcgTyzZsh6bwEVcbvBdCvE50V1GlnzKKWNnF3WttzctgReUNz7Sc4+9LLaZyVI8PHymRewQkP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CgIbYQuX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9P8txQZB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pk+Yz15X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MZokfDED; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CgIbYQuX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9P8txQZB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pk+Yz15X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MZokfDED"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F4701F7F5;
	Tue, 30 Sep 2025 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759228244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9R/eWbHSEAo1UMPZaNRzt4ZGj0FOIjf/1uAl7cYzt8=;
	b=CgIbYQuXgGDOJiLNGQoL9+lpqZHPA3Jgnubm/ko1iD34bcsmDrAHJkPHoMML9BkBhXZoiX
	d0bQP1JSDfNTz5YOrbOD0wo90PRbv23Ofa4uAo0YoZDCa+TGMI0ynYQl0gT98Aj2PvLU6J
	IcW0OpnPuduIr2oEbYltE7vNciBx11E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759228244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9R/eWbHSEAo1UMPZaNRzt4ZGj0FOIjf/1uAl7cYzt8=;
	b=9P8txQZB20xNUFJaJJP2RbvvV8kMKB8FOPhjCUSl+Pc6BBlDgk0UuIenrBMKZD0SZRMM0g
	F1PFRnUolscNHrCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759228243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9R/eWbHSEAo1UMPZaNRzt4ZGj0FOIjf/1uAl7cYzt8=;
	b=Pk+Yz15XFs1i17+KThkgvtlOX0anqQper0WfA0u12CFkXosd+B+9rqCDcV0wVNTJGTmayU
	gBrwkSt/zQHPBkV89BKdN3yvwFOMl6qEWkerlOpO5nS97H308t8CZXBOi+42vCrSWK/fd/
	0XluBlqp4wqMY55yBVyhH3ghnWXGM28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759228243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9R/eWbHSEAo1UMPZaNRzt4ZGj0FOIjf/1uAl7cYzt8=;
	b=MZokfDED6GNclPAv7l/xl/cPqXY76J6OJbvXhIreLU9yOEf3/CSfoL/MfuXtx4AoQnJO5R
	kRaSn2c3KRdM80Cw==
Date: Tue, 30 Sep 2025 12:30:42 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jason Cho <jason11choca@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <aNuxUqDMNcZZs68n@kitsune.suse.cz>
References: <20250927152824.3132af88@jcubic>
 <xmqq4isn96s7.fsf@gitster.g>
 <aNglDzeOT5_4ZbdV@kitsune.suse.cz>
 <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
 <GY1ni5SFkgBgVIHm9HoO9dtLuLWbUPCv5mjcsy5VGi09PyRLV_gv3MMw2zsinKpi5Aon9J-LESzTUuwMOUNLRRLqyXM7ON-98WTzhH7RIYY=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GY1ni5SFkgBgVIHm9HoO9dtLuLWbUPCv5mjcsy5VGi09PyRLV_gv3MMw2zsinKpi5Aon9J-LESzTUuwMOUNLRRLqyXM7ON-98WTzhH7RIYY=@proton.me>
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
X-Spam-Level: 
X-Spam-Score: -3.30

On Sat, Sep 27, 2025 at 09:26:54PM +0000, Jason Cho wrote:
> I think the best practice is to not add a work tre within the master work tree.

And is that best practice documented somewhere?

IIRC there are some VCSs for which it is common practice to keep
checkouts of multiple branches side by side in the repository directory.
IIRC the repository directory itself is not a checkout in this case.
Anyway, there is no obvious reason for anyone not familiar with git
internals to not do this.

> Suppose a repo is at the master branch, and you export a work tree in the directory f.
> 
> Then, you check out the main repo to another branch which so happens to have a file named f. In this case, the check-out will fail due to the name collision.

That would not happen in this work style, each branch has a separate
checkout. If you want to checkout a branch you create a worktree for it.

Thanks

Michal
