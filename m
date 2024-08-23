Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD734DA00
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724390586; cv=none; b=KBUw5QHeni2S5h8laMfqbpVddxVCiwK89+xk97XopRLDxOibTodrmm/swBeQ1bsrODv02EP5t3dI2YMaD8MTQq3/r6ojGXdFIMsQA/YBMpAtVOZmbfwHXLbIE8KQp7DuPtIotayvlTNxfblGcRVGVt5sQiOGhx3yUcOVyGswIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724390586; c=relaxed/simple;
	bh=PnzbmsmVzMNqf5nlRMZQJxZ52UmN6UWAyQANUfRpEQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3WNjDHNghU+C8BJdidfAeBep0giH0MeHe10BdG1FRnXxdK+i/2jdhWqoE0EsxKAAMm4V+f8FKgXcvOWPDYuFWP8UCQAKksUuF+u9kudN2rz81i269RXUkXPuAOK9qMC5GsmX4efp0YNknpTIkm090egbimM3RnQkp1v+S6/ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CcM1Pehf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gh+AeGGo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CcM1Pehf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gh+AeGGo"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 125A41151AC7;
	Fri, 23 Aug 2024 01:23:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 23 Aug 2024 01:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724390583; x=1724476983; bh=w2UvdPV4xz
	5xqQ6u7wXQzQJKFTXFDvNi+NB0Bw1qgLY=; b=CcM1Pehfw/jUDua6w12Ggzg30w
	hcXslDE407FPhkVGXPusThhEyLT46iZyMZG7PwrIozh/AYP3kSwfItyJ6UY1XRpO
	5FKi6V+5OoTEMcLbsTJe5A/mud3SyxsmeBi4/N8UmmnrcAQ8XuqkuX9DDCw6TPn0
	NRKaBGNzGaRmuc1lQ7CP5m6r1GEqunshx52RakdNfr1a/yMWIDApVCAUadkw4zqs
	SIv0y/RaMfWUaXPr+GUQWATWkjDM71TiTSIVn1szS5VeOfYKhrTTD5ovcUE+oA69
	kGLAuZW3DggvcrCXKU5XtkzwX3WXPexvVFWo+MQNpOLCDcTZiEd9cni8sZdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724390583; x=1724476983; bh=w2UvdPV4xz5xqQ6u7wXQzQJKFTXF
	DvNi+NB0Bw1qgLY=; b=Gh+AeGGoSpv9zAwXnrp9b8VfVqMHuN9T/t3TAzM2fDuI
	xCy0UXId0xvVzQwQXfnGFJQd2POL3wtuep/lqfRbHlH3AiakCDNHkfHKVMh1YRlW
	PVy9c5vRe1br5bQeAREFAtnHMXLNM+EVCS0ImH7QRc4SYCk2LO3V7K6ANg7N5STq
	prt+Uvf2253YQwXdM5NC+oOuJN5i25GJyMdrxtvKK+uPoZg5+CMrnB/j74kB9glF
	mCl3dV/nhkRs09ZGlOVktxer2eopOT5/HsOhK2d4XNO8daC71KLVVFLCn3q6giUZ
	OeztxYoy5LYYy1iKJ+kBsUbfPWp2WPKT2I80sCwCPw==
X-ME-Sender: <xms:thzIZsM3M_aL8nLHrSOXGA5iE3M7Gy2v5ncpyBQWURfZEqUE2AtwtA>
    <xme:thzIZi8MoqGphvjXyP4xVdOy3Ed-ZljB1y7gAbChwAGog4innTHI287azHhrvy60l
    p2_qeSmRW1jqdnbTA>
X-ME-Received: <xmr:thzIZjTCpV0zQZEqpNFxuIB2f80qalXaHHwSvdlNPwJw85f8_JFgf6Ktdl_RygF9diHQ5iy1bYvxuDh5iWhbeBRWNq2hj3MHTKIEqhTv0zpIFiA1-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:thzIZkvU4TDPcn2dQ-E5_y5WvEj1gy2WE05emrVHY-JDE5lKc_CboA>
    <xmx:thzIZkeKSrDAYidwazaioU6vs7SidvqZpUZMPjP3WDu16v9D2aCMyQ>
    <xmx:thzIZo1GU5Q6H85z8YlfOdBJcdzi8zPk5Jf7wSw09y88sEN86pPHIw>
    <xmx:thzIZo9JcbtJXrC-jO5eHtuSTJvbYkjHQLlHAOHlGRmTjlF4QDwxEQ>
    <xmx:txzIZs4Ql4KuKwzY_MDUYPvJNS4YVF-NkXFZ1w71nMFxYjyOxgUbYClx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 01:23:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 443619ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 05:22:25 +0000 (UTC)
Date: Fri, 23 Aug 2024 07:23:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] reftable: fix reload with active iterators
Message-ID: <ZsgctL0HGnQtAwQf@tanuki>
References: <cover.1724080006.git.ps@pks.im>
 <20240822124100.GA1070988@coredump.intra.peff.net>
 <Zsc03CSJ3Ece5L6s@tanuki>
 <xmqqmsl4vb9w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsl4vb9w.fsf@gitster.g>

On Thu, Aug 22, 2024 at 08:15:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I can certainly do that. I know that there are conflicts both with the
> > patch series dropping the generic tables and with the patch series that
> > move the reftable unit tests into our own codebase. I did address the
> > former by basing it on top of that series, but didn't yet address the
> > latter.
> >
> > I'm okay with waiting a bit until most of the conflicting topics land. I
> > guess most of them should be close to landing anyway. Alternatively, I
> > can also pull all of them in as dependencies.
> 
> As long as the resolution you see in 'seen' looks acceptable, I'd
> rather prefer you do nothing, than a rebase that _reduces_ the
> number of conflicts (but does not completely eliminate them), when I
> already have a working resolution recorded in my rerere database.
> 
> Of course, updates to polish the substance of the topic are very
> much appreciated, and I'll redo the resolution in such a case if
> needed.  That's one of the things the maintainers do.

Yup, the merge in `seen` looks good to me. Thanks!

Patrick
