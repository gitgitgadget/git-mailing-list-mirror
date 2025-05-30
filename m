Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14B22DFB5
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613931; cv=none; b=n2oHZMUd9isz1vIuxfjADtsGEoarDDyGmjAYTVML28N25GhGIHtruDaBjZhMnXU2YpaBGGwieagEpZjE00X+Z1UnkWvGMNiWIeJKnXvzHWbSkBHgTDC7qYA8FaXZevcqHo1UTlgRGxkI6aUXdK7Jg2RuuYgLZHrnhvFwSRhwshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613931; c=relaxed/simple;
	bh=PJXpLxMl7KEalbPMt4CNVS6sQy4Vd8CsX6zTkZCu7ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muiqKR6uRTgiY0UuZOOq6wjLJ3HRbo5XthScJMB3bQYAYEkyk9UCettrOrmUp+tuWtN8A9i7uoLoBID+qKrjnOi9KzDTHqHEVuqNm4vtHhCGGGWnso0vl72EBxe5CDsbVM5KkE1gYnauhBzenXwVBritR7ludOpcMQFsBhENaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oyp6ZI31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYJ+pevV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oyp6ZI31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYJ+pevV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AB49C1380373;
	Fri, 30 May 2025 10:05:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 10:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748613928;
	 x=1748700328; bh=JxJFSo7WdZFZc8rm+mVsIUZSynyl2YIWD0vdybeTWpU=; b=
	Oyp6ZI31Inr22wUUTrsgl4tio2nPSjF74UPZatKekLY+GI3na/wT7u92C5CbvjOd
	dKEVeuw5KpnkzKGPnuBEsoMvmII20twP5MmzN0hnZXA897MvYmghxMLM/PO64z8W
	lzML1LB6QERrdFBBsGTL88WJIsvrXhTyTaM9pHbKr6nSn7QMHmLkSBQlMIfba802
	7eGP6KJFJJhGrm/T6TfMf/SBhg/FKTjwSdYvGqYgTr1NBf9kn0zWtjqWPSn24vTs
	EcTuMvxPwOzciMs3Xeyf5ngchpDna6qK762lVOcgAUMjSCh4lh20V4vDDwcUH0FC
	KpnWasuTmkkNuy1Fn15kZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748613928; x=
	1748700328; bh=JxJFSo7WdZFZc8rm+mVsIUZSynyl2YIWD0vdybeTWpU=; b=M
	YJ+pevVUZ8rL2SPRfdjZJIePMSwL1cQGR2RJ2PNvof85poEeSRsPcx0khFaqm/bO
	P32QQ/U8oQ0iRabVDYNbYE/fx1cyKdEdXLFm7Hclh1YF7/AkErQZpHJ4YwvuKoRO
	ADBvtbFzzT6rzSDdzZTd+lAz2+f/DxkpYt0Gu9l91yxPt5Ydfk+l5GqmayPb1vAB
	Nu88lshL6+vACLJ/QimNm8e54NSSPgsx8cpBBXGEqKjESQIbVtOgTQADAIK+7IRa
	DCbJKeCRfyAjMgTII/b0FJ+q/WsAt9nDm2Qm4hMcyUQ/hkDzsNKEYhZg6tHE8Onc
	sRoHSum3V7mhTPnUQb12w==
X-ME-Sender: <xms:KLs5aFGi1d3lzq539BnMJ7eITrsThtUqsOnsnBBSlYUmzcCkx6qNfA>
    <xme:KLs5aKX-bIwyNbm9fqDNGPIX_9TmzhxF8hy6fQOkx-JHcGFQx2QgxhTLlmQVdN_pL
    GPJ6LpmsL3rjYmNdQ>
X-ME-Received: <xmr:KLs5aHICrYTgc7QCGjFVXORF5jO51_Jl3ScjbphzjzYZiqewDnvtIySe0Ud8jwf8Y6OezbOPcBSpf1ra-RgQGA4iRE-QsPsoL-4RShBnpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KLs5aLHi10-oLLnnnrHX2576FrU7zSkTbIG_em0winsR-NrbtQpREA>
    <xmx:KLs5aLVPBqo-11Ip9pIM4i-6i-1BLWhNwpgTjsQvkVlqmww7gYtBDg>
    <xmx:KLs5aGMqDwIboJmgDCFzjybUa9WJAjInvxfpV27avwL9BY7oyzMhtQ>
    <xmx:KLs5aK2Pa-APsXDgG76p-73o-D9RA7fIpeoPOK9-Ubc-V3IhFqcD9A>
    <xmx:KLs5aNuTfSweaCZugwKe73jJfJu_3bZU0LHSI-5oitangZk6_ZAshE6y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 10:05:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b86aa4ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 14:05:27 +0000 (UTC)
Date: Fri, 30 May 2025 16:05:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>
Subject: Re: [PATCH 08/11] builtin/maintenance: let tasks do maintenance
 before and after detach
Message-ID: <aDm7JeVg9vqsq-09@pks.im>
References: <6E33013D-8336-4BE1-9DBB-CAFF835A49C3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E33013D-8336-4BE1-9DBB-CAFF835A49C3@gmail.com>

On Fri, May 30, 2025 at 08:56:38AM -0400, Ben Knoble wrote:
> > @@ -1599,20 +1600,25 @@ static const struct maintenance_task tasks[] = {
> > static int maybe_run_task(const struct maintenance_task *task,
> >             struct repository *repo,
> >             struct maintenance_run_opts *opts,
> > -              struct gc_config *cfg)
> > +              struct gc_config *cfg,
> > +              int before)
> 
> Perhaps we can use a small enum…

> > @@ -1641,6 +1647,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
> >   }
> >   free(lock_path);
> > 
> > +    for (size_t i = 0; i < opts->tasks_nr; i++)
> > +        if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 1))
> 
> So that is clear what « 1 » (« BEFORE ») does here…
> 
> > +            result = 1;
> > +
> >   /* Failure to daemonize is ok, we'll continue in foreground. */
> >   if (opts->detach > 0) {
> >       trace2_region_enter("maintenance", "detach", the_repository);
> > @@ -1649,7 +1659,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
> >   }
> > 
> >   for (size_t i = 0; i < opts->tasks_nr; i++)
> > -        if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
> > +        if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 0))
> 
> And « 0 » (« AFTER ») does here?

Yeah, I was very close to adding one, but then decided against it to not
produce additional churn. But agreed, it would be way easier to read
this way, so let me add one.

Patrick
