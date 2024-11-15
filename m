Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817D187848
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654086; cv=none; b=nZPe3eAUEh7oIODYMKyMhY3+RfySAjXJrlhZWLheF0dl9yZ2ZIMSupQHmsbH5HqSQ0wzSOtCoBXIN2QJwbhKACoLZk9XfqHtdIehdJ34zGvP5/Sk/s7su1meecGiAnzEI5yFC+jT4k9pXsvnoA4cH4zNP9abTUgRH6s7HZitCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654086; c=relaxed/simple;
	bh=cXv4JCFGi8lAvv8werbOe711iUzrJ3hze0pNFF7XHlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uodzsl4xfdVuFzpnU2Wf10tvwx/xhLDb3B3ENrmCEqXDfBFSRem5cpdz7haX160rY5UkB8lp6vDoMR6u9EuaM1Vfx0mg7xtaDClUB6/mCwqsnNm+tncolNIKhEqtz5LoinfepCjBn9NM9cmX2UVA7ls+T4O2cxsUJdkN3QTtOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bjkxop0H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvFmX4Fv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bjkxop0H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvFmX4Fv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E6851140146;
	Fri, 15 Nov 2024 02:01:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 15 Nov 2024 02:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731654082; x=1731740482; bh=1M08D0e+iD
	KBnFFpSFFjW/07wl6l3qKl8ou1fMu0uIA=; b=Bjkxop0Hllf9soBPlQF7krGqxl
	IT4ySgXl5xHBL8sETe/DdDJ876onWoZLisjEs1LnPxAIK7rUgRz36s7eEK2YuDWV
	N8Y2oF4DsgBq5zjub63CuJAocMbNQgDV3bfqzUeChr+fjXyKlzAwxUJ/kcSR93CO
	G/9CKK3AjbN8ZI0GlAIkGFOLU8chsWEAxNqbzWLceRLNBMZNPkcBfsGZlJXUFAXQ
	LWhmW11vknDYfq0c2nrp7F1wSDkoN4BkRt0K6sKSRB9vPNGngv+iEp/FutvuSqYL
	L2Gt0w2aB8wGgedbAy/6/lhK4vQDYvY8ikvKa7smEewl3Lro5Ngu0YThej/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731654082; x=1731740482; bh=1M08D0e+iDKBnFFpSFFjW/07wl6l3qKl8ou
	1fMu0uIA=; b=ZvFmX4FvCRiAedc1FoFN6sYPuNhxNHtECPjYsNG3AqDfTBlAvz0
	WJ4xrKiHRus51XEBK7qVJVyjPm3C+IKKfXIunjYppI2tnQwAX2RvOPr6t3mZZl21
	QBBWxBpkhDBL7qo4vIrS+RrbEppku8fKrzkWHI1VvBvGo1DB8OnmU7bDx6d3tivH
	lry9B1W5q1dFidSHO8T4YgpQUFNLPx6oUyiQfJp/cM3zo49kYtLp5ZHKFdYpiZ25
	vMnbWsEBPOpJeDn3bbabUCepU+Tk8LDKhudT6SRWKb9mSkoTIQ+lwXs7BfNlUz3W
	Fo3pnKaYrDHQe0i+kxRY0eiDU/3WjcnhaIw==
X-ME-Sender: <xms:wvE2Z6rXfAl-srgVnF9LnNVonqWu9pUVcfUChpF8m65NtwvluqZ8Ew>
    <xme:wvE2Z4qrmLj4dF1Po-IWcJPawehtlSHSykuT-eYZRRhW_CGQlr336rFKVJaobA9Vu
    0lFosdhxxezILUlgQ>
X-ME-Received: <xmr:wvE2Z_Ndt4nDSfEhJ7UQ7R_GvAPLenCJMOkaZVzag8f24_VEY674HJtnmszTcYEY20uqtmZebFmcyqhniM4qn1VuGQPz9viNx_bKcW63WUK1Z-smMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wvE2Z56-YvwRdc_b5u3TzKod0L3oi6vQRrO7jYuaylkEpV70mOZqcQ>
    <xmx:wvE2Z57hOCeDMYm7fBDVfJxw6VKHR28sdjVGNOtJCjf5rUqobkUBEw>
    <xmx:wvE2Z5igelAMc-_M_BS6klwjmmZ0vU-m2CxmHOZKa1Sd1oM9G0bEiQ>
    <xmx:wvE2Zz6CPL_4NNkgGSjiiC7si1pfuSTqvT5yi15p44-gWD0jSgoTBQ>
    <xmx:wvE2ZzmBLQ2P0AbtzxE4wqThuwfYtwcopu4wBpEp2-iZ3_VWGEhQ9Bgg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:01:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5bcc46c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:00:37 +0000 (UTC)
Date: Fri, 15 Nov 2024 08:01:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: don't invoke reference-transaction hook for reflogs
Message-ID: <ZzbxrU2SdUDqPJiF@pks.im>
References: <20241114-348-do-not-call-the-reference-transaction-hooks-for-reflogs-v1-1-ece7260ee3c1@gmail.com>
 <xmqqldxl5qdf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldxl5qdf.fsf@gitster.g>

On Fri, Nov 15, 2024 at 08:48:12AM +0900, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > The reference-transaction hook is invoked whenever there is a reference
> > update being performed. For each state of the transaction, we iterate
> > over the updates present and pass this information to the hook.
> >
> > The `ref_update` structure is used to hold these updates within a
> > `transaction`. We use the same structure for holding reflog updates too.
> > Which means that the reference transaction hook is also obtaining
> > information about a reflog update. This is a bug, since:
> 
> Yeah, the transaction hook is deciding how the values of refs should
> (or should not) change, and its decisions should be sufficient to
> determine what should happen to corresponding reflog updates.  If an
> update to the 'main' branch is let through, that update should result
> in a new reflog record for that branch.  If such an update is blocked,
> there is no update to the branch, and a reflog record would not be
> created for such an update that did not happen.
> 
> One thing that the above argument does not capture is "stash",
> especially "stash drop".  The way the subsystem abuses reflog
> disconnects ref updates from reflog updates, so there _is_ a use
> case for hooks to interfere with reflog updates.
> 
> However, the existing ref update transaction hook does not have to
> be the mechanism to vet "git stash" operation.  If we really needed
> to, we could add reflog transaction hook for that later, outside the
> scope of this fix.

Indeed, I'm also happy to declare this a bug and change the behaviour
retroactively to skip over reflogs. I highly doubt that anybody uses
this in a sensible way to handle reflog updates: they have no way to
distinguish a ref update from a reflog update, so they would have to
essentially guess what is what.

So this patch looks good to me, thanks!

Patrick
