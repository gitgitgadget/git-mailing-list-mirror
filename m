Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79318D625
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667414; cv=none; b=Jpk+rIgggB+oQbKCd+078QlEWihnn/2N/MagOJxJAJ1gdaZueY8vgWx2iCi+4LensKBbkB6S/CfnHBVY51hBPfk4tyXR+T7HMgqcL5nXuEg8YoWkAu5jtvTy3rYI7m6Qd0YV2nBDEV+CvGuZyWrKDS69tgdJk5fbZ65qMMWNm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667414; c=relaxed/simple;
	bh=ZB4KBJ0HRavF2SrPNoRfj+gI+3tMvxzw/2cLe9gDaR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjRz4U9WI3TolZ71+hbsfLE0TAGRyd37t2YMmKRVWtXVtqtawrWj6Km5kRqpVaCtjZIYfXjdnAeJW7LDI26P+WRg8O34hEmJqJpIsiUa0sO6wD4daD2s0FY89YOBlTioBhLKX2YIMjxbiPuw7f4BJkigbN5gsWlf5WYSwFqKD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s+uh8P3j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MpxQf/03; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s+uh8P3j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MpxQf/03; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s+uh8P3j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MpxQf/03";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s+uh8P3j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MpxQf/03"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FC1B21295;
	Fri, 15 Nov 2024 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731667410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed6O0o4afUjbRf/4kDqM3Rl9oQ+UN4pPdKTAWkcWozc=;
	b=s+uh8P3jfdhLkLWokmFbCVInEtX3D0D/lX1MQ3ixXksoe7h80oH6yBg53oJRabtFGTx9WT
	m7UHsemG0BLAEPq6BX6hELgOCsOm/9VkWGIJlRYjG9BMg3+9eVDtNFo/4MfOe3OaaWReQf
	/RMYcmqj5Xd7sfGgk9lC2ZENkhkhZXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731667410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed6O0o4afUjbRf/4kDqM3Rl9oQ+UN4pPdKTAWkcWozc=;
	b=MpxQf/03+78hYwA/UskC4ZWMu6ZBoiv0I1x77I6fpR7HGWuqcVguzQnnGh268BByyGBR0v
	nSNGit02wyQQlWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731667410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed6O0o4afUjbRf/4kDqM3Rl9oQ+UN4pPdKTAWkcWozc=;
	b=s+uh8P3jfdhLkLWokmFbCVInEtX3D0D/lX1MQ3ixXksoe7h80oH6yBg53oJRabtFGTx9WT
	m7UHsemG0BLAEPq6BX6hELgOCsOm/9VkWGIJlRYjG9BMg3+9eVDtNFo/4MfOe3OaaWReQf
	/RMYcmqj5Xd7sfGgk9lC2ZENkhkhZXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731667410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed6O0o4afUjbRf/4kDqM3Rl9oQ+UN4pPdKTAWkcWozc=;
	b=MpxQf/03+78hYwA/UskC4ZWMu6ZBoiv0I1x77I6fpR7HGWuqcVguzQnnGh268BByyGBR0v
	nSNGit02wyQQlWAw==
Date: Fri, 15 Nov 2024 11:43:29 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: David Aguilar <davvid@gmail.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: Shallow clone of a specific git revision?
Message-ID: <Zzcl0Ql0S386G4FO@kitsune.suse.cz>
References: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
 <87wmh7ig98.fsf@iotcl.com>
 <ZzR_nOqQxfGNPyYV@kitsune.suse.cz>
 <ZzbVe79p_Zbnb6rs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzbVe79p_Zbnb6rs@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.17)[-0.858];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -3.27
X-Spam-Flag: NO

Hello,

On Thu, Nov 14, 2024 at 09:00:43PM -0800, David Aguilar wrote:
> On Wed, Nov 13, 2024 at 11:29:48AM +0100, Michal Suchánek wrote:
> > On Wed, Nov 13, 2024 at 11:23:47AM +0100, Toon Claes wrote:
> > > Michal Suchánek <msuchanek@suse.de> writes:
> > > 
> > > > Hello,
> > > >
> > > > Looking through clone man page it supports shallow clones of branches
> > > > and tags only.
> > > >
> > > > Would it be possible to do shallow clone of a specific revision,
> > > > and checkout specific revision on clone?
> > > 
> > > Hi Michal,
> > > 
> > > I'm working on a patch, and I've submitted a first version [1] a little
> > > while ago to allow users to pass a reference on git-clone(1). Would this
> > > change fit your needs, or what else would you like to support?
> > 
> > > [1]: https://lore.kernel.org/git/20240927085438.1010431-1-toon@iotcl.com/
> > 
> > Hello,
> > 
> > that slightly expands the available options but it does not make it
> > possible to clone an arbitrary revision, ie. specified by a SHA
> > 
> > Thanks
> > 
> > Michal
> 
> In case it helps, here's a short recipe demonstrating how to do a

Yes, that's helpful, thanks.

> shallow "clone" of a specific commit ID:
> 
>     git init the-repo
>     cd ./the-repo
>     git remote add origin <url>
>     git fetch --depth=1 origin <commit-id>
>     git checkout <commit-id>
> 
> It'd be nice to add this feature to "git clone" for convenience.

This is how many git reatures start, after all. They are provided as a
script on top of core git functionality.

> This recipe depends on the server's configuration. You must have one of
> the following configuration variables set "true" server-side in order
> for the server to accept requests for arbitrary commit IDs:
> 
>     uploadpack.allowReachableSHA1InWant
>         Allow upload-pack to accept a fetch request that asks for an
>         object that is reachable from any ref tip. However, note that
>         calculating object reachability is computationally expensive.
>         Defaults to false. Even if this is false, a client may be able
>         to steal objects via the techniques described in the "SECURITY"
>         section of the gitnamespaces(7) man page; it’s best to keep
>         private data in a separate repository.
> 
>     uploadpack.allowAnySHA1InWant
>         Allow upload-pack to accept a fetch request that asks for any
>         object at all. Defaults to false.

I would be fetching from a forge most of the time which would use its own
implementation of git server most of the time but it's good to know what
the options are on the canonical implementation at least.

Thanks

Michal
