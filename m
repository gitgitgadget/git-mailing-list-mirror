Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160A21A425
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116223; cv=none; b=CgSvpL2rp8VMUX2QGAn7HUdasjjt8ZDRW0hjzoRTeQkvwiarxSpDBrwRfHomxREcN189daOXKxIzZOAqwasCv0r+Pc9LmgulepEHhLpmsFVo2MSzstKo4REm1CB9QnY5GSKe8IVCF5WF6FCnKtB2rPEDsI9eoxMZN9bvaNYyMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116223; c=relaxed/simple;
	bh=+Jien/+nlcUvQ1zoSaXZsr+q4Wuq1u1FNHqxrTfuqUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk6U1spDxHzBK5zlwUwt0D5MgpqjDYdv5uVe59235qjrKQMKXKK60zYRboeV62NBO0ef9IxL6+ARK5LWfodzbdfam1iDcDag9VMlzztSL8EQD7qeombhkmZIbb1gWlnVdM5BUWyLyvYqmoq2OwHrD09kGkvHvSpQmWIKdPpXmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vdFr30bE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eT3jOCG4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vdFr30bE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eT3jOCG4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vdFr30bE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eT3jOCG4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vdFr30bE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eT3jOCG4"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76F021F445;
	Fri, 10 Oct 2025 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760116219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wABIbv85z6BdfAjRZ9m/Wuil2PwMXNSYVs4pgOy3Gzk=;
	b=vdFr30bEfYSYqsvZZx9OPbuaNUVoPMZLl1sD80GGYHG1dPHX2w94sw4wgF19vi6pLf7uvs
	YtymzbOwodOz1OQHYIQ/dpgh1+NuT4bWjd0fJL2eRR0rlmdTHAYMD4eCv56ItkzVHRxVaw
	BfbFc03j+klDL17ba9yDL6HDD3Thloc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760116219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wABIbv85z6BdfAjRZ9m/Wuil2PwMXNSYVs4pgOy3Gzk=;
	b=eT3jOCG4W8d4kDiTphgWdZNEwiB/2lSYV7jdq7ncvwolR8NznbsGleYpixYJ4yUkm0Cxea
	HLC6B+NTtivawcBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760116219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wABIbv85z6BdfAjRZ9m/Wuil2PwMXNSYVs4pgOy3Gzk=;
	b=vdFr30bEfYSYqsvZZx9OPbuaNUVoPMZLl1sD80GGYHG1dPHX2w94sw4wgF19vi6pLf7uvs
	YtymzbOwodOz1OQHYIQ/dpgh1+NuT4bWjd0fJL2eRR0rlmdTHAYMD4eCv56ItkzVHRxVaw
	BfbFc03j+klDL17ba9yDL6HDD3Thloc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760116219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wABIbv85z6BdfAjRZ9m/Wuil2PwMXNSYVs4pgOy3Gzk=;
	b=eT3jOCG4W8d4kDiTphgWdZNEwiB/2lSYV7jdq7ncvwolR8NznbsGleYpixYJ4yUkm0Cxea
	HLC6B+NTtivawcBQ==
Date: Fri, 10 Oct 2025 19:10:18 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sergey Organov <sorganov@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 1/2] doc: git-worktree: Link to examples
Message-ID: <aOk9-k7doFkQbgy8@kitsune.suse.cz>
References: <xmqqseg1xwc1.fsf@gitster.g>
 <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
 <6043158.DvuYhMxLoT@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6043158.DvuYhMxLoT@cayenne>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,pobox.com,sunshineco.com,gmail.com,proton.me,jcubic.pl];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hello,

On Sun, Oct 05, 2025 at 10:52:51PM +0200, Jean-Noël AVILA wrote:
> On Thursday, 2 October 2025 17:51:34 CEST Michal Suchanek wrote:
> > Also add advice to put new worktrees outside of existing ones.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  Documentation/git-worktree.adoc | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/git-worktree.adoc b/Documentation/git-
> worktree.adoc
> > index 389e669ac0..ec31863aec 100644
> > --- a/Documentation/git-worktree.adoc
> > +++ b/Documentation/git-worktree.adoc
> > @@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
> >  $ git worktree add --track -b <branch> <path> <remote>/<branch>
> >  ------------
> >  +
> > +For best results it is advised to specify <path> outside of the repository 
> and
> > +existing worktrees - see <<EXAMPLES>>
> 
> Please use the form <<EXAMPLES,EXAMPLES>> in order to let the translators also 
> change the cross-link text in their language.
> 
> Also, the <path> placeholder should be formatted as _<path>_. For your 
> information, I'm right in the middle of pushing the conversion of git-
> worktree.adoc to the new synopsis style. 

Seems it would not conflict too badly, at least if your series is
applied first.

Thanks

Michal

> 
> > ++
> >  If the branch exists in multiple remotes and one of them is named by
> >  the `checkout.defaultRemote` configuration variable, we'll use that
> >  one for the purposes of disambiguation, even if the `<branch>` isn't
> > @@ -502,8 +505,8 @@ locked "reason\nwhy is locked"
> >  ...
> >  ------------
> > 
> > -EXAMPLES
> > ---------
> > +[[EXAMPLES]]EXAMPLES
> > +--------------------
> 
> As noted by others, please put the block anchors on a dedicated line, out of 
> the translation scope.
> 
> Thank you.
> 
> 
