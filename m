Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002A27A904
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430775; cv=none; b=SYk6jbE33VGGoUkcId+TCwBkWFhoTWWfaltpZ+lfjnZEXS4bp0I0SOXo7w2fi8iHzNMyV66YrCjzwDNzrOn2ehq4F+oIwksxURxD8xAHwvq+uxXuJTfs7pfvHkl/MQNevs4Qcsh6eyrIlWjxDTM0sDoimI8X6LzHoGMYE6+HORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430775; c=relaxed/simple;
	bh=YU3nQilcLS3XKeZqMCFkeAP3dT/rKdiYipSlJprRlh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXFYJFlUnEIcos0nQTlVM7UQHzZyGQ8hX05K/pCuIKW9I01XXDJIoThkxwbRiQ/CtH05BO7UE0huXITLLDiikygt4Hho/Ika7bh8Dbj/8zpRg29m26ARfYZn+Odf0c6avcHm7ImEmH8+yce9yMZzOzQt5JtX/nXAMqA0ehRQf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HNMLe5FK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YxSYbsbU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HNMLe5FK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YxSYbsbU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HNMLe5FK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YxSYbsbU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HNMLe5FK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YxSYbsbU"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 405B93376A;
	Thu,  2 Oct 2025 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759430770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE7B06Nsng6TIz4AiV5SRtQ/bhN85iOfDAOLYs4xuUM=;
	b=HNMLe5FK6OOs3fQDJNHsNxoHzMgbXtxQgx8gI0ooq0D+bd3DTNzFbyVqJIk2HScUqA+fSK
	PJK/8jr7RXBnMKcoyo0F9TmnwSX4lRWEvvANm/yxprc4zmf+peRvftPu3kED2qLJcwmVju
	hiCgmk+WsdORRdW4+HZyfBNEUj7aypE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759430770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE7B06Nsng6TIz4AiV5SRtQ/bhN85iOfDAOLYs4xuUM=;
	b=YxSYbsbUJUfDIfkQRS+QnuXOXOBLOqB345+tit5wnP5QYTJQe4FbH7xEJpVBO0txYayfNL
	eo/yL8a82k8J+VBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759430770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE7B06Nsng6TIz4AiV5SRtQ/bhN85iOfDAOLYs4xuUM=;
	b=HNMLe5FK6OOs3fQDJNHsNxoHzMgbXtxQgx8gI0ooq0D+bd3DTNzFbyVqJIk2HScUqA+fSK
	PJK/8jr7RXBnMKcoyo0F9TmnwSX4lRWEvvANm/yxprc4zmf+peRvftPu3kED2qLJcwmVju
	hiCgmk+WsdORRdW4+HZyfBNEUj7aypE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759430770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZE7B06Nsng6TIz4AiV5SRtQ/bhN85iOfDAOLYs4xuUM=;
	b=YxSYbsbUJUfDIfkQRS+QnuXOXOBLOqB345+tit5wnP5QYTJQe4FbH7xEJpVBO0txYayfNL
	eo/yL8a82k8J+VBg==
Date: Thu, 2 Oct 2025 20:46:09 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 2/2] doc: git-worktree: Add side by side branch checkout
 example
Message-ID: <aN7IcSmHCM-BBLjH@kitsune.suse.cz>
References: <xmqqseg1xwc1.fsf@gitster.g>
 <1d5b41562937d83be261d054989b04db6cb94a86.1759420102.git.msuchanek@suse.de>
 <dd4027d1-4148-4171-bf17-b5c33881a446@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd4027d1-4148-4171-bf17-b5c33881a446@app.fastmail.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[fastmail.com,gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,pobox.com,sunshineco.com,gmail.com,proton.me,jcubic.pl];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,kitsune.suse.cz:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On Thu, Oct 02, 2025 at 07:51:20PM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Oct 2, 2025, at 17:51, Michal Suchanek wrote:
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> I think this could do with more setup and motivation.
> 
> I’ve seen a lot of questions on worktrees where they introduce the
> problem with “I use a bare repository with worktrees”.  And I was
> puzzled that they kept using bare repositories all the time.  I’ve
> forgotten some of those details but I do seem to remember that they were
> motivated to go all-in on making a ton of worktrees, and using the the
> “project root” to do it.
> 
> Is that what the bare-setup is getting at? ;)

It shows one way how to make a ton of worktrees without having them step
on each other, hopefully avoiding this pitfall at least in some cases.

> > ---
> >  Documentation/git-worktree.adoc | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> > index ec31863aec..122b191ff9 100644
> > --- a/Documentation/git-worktree.adoc
> > +++ b/Documentation/git-worktree.adoc
> > @@ -525,6 +525,16 @@ $ popd
> >  $ git worktree remove ../temp
> >  ------------
> >
> > +Side by side branch checkouts for a repository using multiple worktrees
> > +
> > +------------
> > +mkdir some-repository
> > +cd some-repository
> > +git clone --bare gitforge@someforge.example.com:some-org/some-repository .git
> > +git --git-dir=.git worktree add some-branch
> > +git --git-dir=.git worktree add another-branch
> > +------------
> 
> This works for me.  But why not this?
> 
>     git clone --bare <repo> some-repository
>     cd some-repository
>     git worktree add some-branch
>     git worktree add another-branch

I would certainly not recommend that. There is great potential for
conflicting with git internal structures of the bare repository.

Thanks

Michal
