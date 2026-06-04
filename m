Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312E3D3333
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553324; cv=none; b=ubTgSW7ni+Fr6iaGHPaxHPHij4qgPnn0I1ybTHLbb3FpxXaIlOrzhdhNXHwLcEZLkiuWVQu6HidJa4I4Qp1v3i8ph8Tm5ew2TYsji2pw74NIV9xNB5iQ7rKr0nq/4nZXxqk4FFx//zDtOx2WXGeDC4ibRbkFA+I6HNDBOZooBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553324; c=relaxed/simple;
	bh=51mhESjatpssLqXMtjXA83Naynfc9h1t2qAyi3Qk+s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2PqUXuOoAqwZFDI9i3wEbwD82B/0Rhh2121nTdX6aNGZ6voJ6wZe9Sdqi3myUCYZUtrp0Eh4rO657r0hi5ccM3hFt2+BNUFc+FBb1/PLX2sBhepClEQQmzdsBuTnswEwlUouPIrFzekdHezQ0iIjwSOlg/mOGAvGh0dsLOqbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K6toexqF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVNpdsbm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K6toexqF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVNpdsbm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C8C6EC00BD;
	Thu,  4 Jun 2026 02:08:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 02:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780553322; x=1780639722; bh=wH/EEMakPJ
	6ZnNKp/+HKwayXkxp3qj+p2XMa+ylv2rM=; b=K6toexqF3vB4g/zvROtMg0fkIz
	UUgiVbfHm3TI+GyZFXrBhYMADuFSQAKSNRn72gzrsMiwpBwP58qXeNvOT8TLIpCD
	WqIvYANMWOY0RUrlM/9wA2F6mGEf5989vpSDJsPqu60zn5Gv7WCJZSePiyUcnSwt
	SZAcFDs6F7NTxIqh+cWfCqrgwyMnw+1B9LyKPbVZB9DQCBjEDJpBQBsZJmFBDQPI
	FIGw8FNGWPjsDFokGpvBtYhnWTCxuEttvtFK0eeQKHNfmzEWX3Hd3pakmXeatuWp
	D/TEyoQ70z5texpfFeGBc5bOEaoKL/4ks/+9cbVZUiAaQjCO+mIL3MmzpVGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780553322; x=1780639722; bh=wH/EEMakPJ6ZnNKp/+HKwayXkxp3qj+p2XM
	a+ylv2rM=; b=IVNpdsbmpbZFyeS/xPbtnwkXWSAPFAmn+GJCbtSYANtxosqoIFI
	IUHol1e/JONNKF9L6uW6bmGHtfxNvsSeE98+u6H+wb6wE1M0FadWPolhRQ009OrV
	YATSlsrim7pRMbdZEJbY820a5lwlrCId3ADpyNpH/b/g7sFiVJP3ryizipBFOJQ+
	lC65vMIj8nzWofNga9ACd3oZlfHJrVrItPkQlyzFLzT4kvxT+MDqo8DgfinMn7T7
	mFib6vxqN6I8LXNzxsr7gBzfwSBU+7MIQ6JGK0U6Byg/5N0mpmHAe0wXNSziqbSJ
	UqMgqlFVWoYoyXEAJj62T4jAhK6V1wyZdKw==
X-ME-Sender: <xms:ahYhakQEjEoGxMZ0LZMWtj395YS2Gh65D1JKEcWgAHeQkB-RcumTbQ>
    <xme:ahYhaoypUdPnQ4amwFpjj9HEwbXfcpvmU-wUDl1SG1f6I8tbbr8MhrhCUacU1ryD1
    khmohBP-9bL1Og3RCnXmuQYdJE5C1GeEhZ87pOBK42GC8yyCdk>
X-ME-Received: <xmr:ahYham0GE3u9tBRoRKgOOGEv2vc5xcByPAI5Fheq70XR_NLmHFq0qugquyx6Be5JGyu87rj2msWCTSZKErqWYDNP_y9a7fZVqVI3RJFcxO4>
X-ME-Proxy-Cause: dmFkZTEWa4bkDooe2fPCI9HdwP6T79yj9fzYT46vmRc/PDlPgyVxd1UkTGYdvnQU6rbNfT
    DoXsufeKSFObrnNvAes453ZwcYFDcLtIqJACThi/3B6xAkAz9VoaCfK3jSg+uAoL9Z7OIo
    6nfPY9VwpMq7Q6YZlgOtx/uZ1JiEt2JthLf9LB2VE6wYfI9FOYLcc+qa552nI8aZlwuT92
    MYBiXtq0oc9TrlqsTX6VQEPfuxAb51FHRww0cgXw5DUElTNtS/YCleMBnFywlvoYyHfJdp
    1YJVFVI8ouHtkrMU7hJ9G3D8mhWb1FjHXBDr/2WPopvnVPz4RtlQfxIbYLoDiFlu84Knct
    CMGyE9lmoj5XPYkMUU+gOIRC/7haY1hJI/pu4aveP/nd3iPRfSNHDoUQDhcEfjcNQNQDzA
    vsVAIL3r1TQYWB9MNxH3VuYFiQPWdviLeRKK1j0gGURw6pgxmGuqOsGIgydHzv0p/sRAQV
    +6KOXVqyq7PBllyCWDP4fwE90VkbWjHtPayoa7KRe6QKrByoUF6dGcdWMf9lbFApR+D/3J
    clL9i9BKScX6YLK+NiW6sAWtWU/0P7UX9Kj8jwxuLkFnsDbjrtU5uo0qDwG2/h/EV1IZll
    /NejCxUcIFhQ/4ioXGKBLVihESI3LLj+6CdIEFrC+EP519OXCs1K643F3cqw
X-ME-Proxy: <xmx:ahYham64e8obfkWFO_wgPsaB8ouVVIt97oY_aVAADQFgjjEnan-yIg>
    <xmx:ahYhapWQCXXGZIzzYyZ4SY9w2i8fafl9IVPbmbZWlhHRb1vyxa7i5g>
    <xmx:ahYhalC76jokLPK2QdhPum4xk0sDdrrQyAL43e145ecDvjeB72o9uw>
    <xmx:ahYhao605o-4b5Tz3Uy9goMcChh1ecmy4WHcgFbwdplyVwlR2tTp5g>
    <xmx:ahYhauWWyIR1uAN-PSYlIxJGL8wTFVqYEnxTV57to99AGnE1aKOMQ1JM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:08:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff71dc8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:08:41 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:08:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] repository: stop initializing the object database
 in `repo_set_gitdir()`
Message-ID: <aiEWZo7Y-UXK4N3x@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-4-2fa5b385c13e@pks.im>
 <CAOLa=ZQ5u+J-f=xS7RDym0cwt+=R2dzMFo5P34cp-CBbza7NRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ5u+J-f=xS7RDym0cwt+=R2dzMFo5P34cp-CBbza7NRg@mail.gmail.com>

On Wed, Jun 03, 2026 at 05:49:50AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/repository.c b/repository.c
> > index 58a13f7c4f..2c2395105f 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -181,12 +181,6 @@ void repo_set_gitdir(struct repository *repo,
> >  	free(old_gitdir);
> >
> >  	repo_set_commondir(repo, o->commondir);
> > -
> > -	if (!repo->objects)
> > -		repo->objects = odb_new(repo, o->object_dir, o->alternate_db);
> > -	else if (!o->skip_initializing_odb)
> > -		BUG("cannot reinitialize an already-initialized object directory");
> > -
> 
> This always confuses me, so we were creating the odb even if
> `o->skip_initializing_odb` was set to true, if `repo->objects` didn't
> exist. Weird.

Agreed, it was weird. It was my first iteration towards centralizing
`odb_new()`: before we had the above logic we were basically recreating
the ODB multiple times, which was even more weird. At least things are
getting somewhat sensible with this patch now.

Patrick
