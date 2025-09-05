Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1828488F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052718; cv=none; b=BxvWax+27t3to+BcknVq1WjIOPpRsJ88orWWIpDRnO8DvgbWTdIuc0rt9MeP7D2I//suj98ZPyB3t4fRL1b48qfyZ2v7YhtAdKDS650G4ibtl9pexjCwl2Mz3ijjWgz4jLwBo7NK27xMHGkaY1EIz7tI9s7/WxwtBVb8l6KzUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052718; c=relaxed/simple;
	bh=Yd0Jmxnykp2Pbr4PrYdeZBaCyx3Iad8cVZkujzGBv50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eM8V9ZIZP44C7MfhDNl7yrJR5ymbQAjS+QREcXbfYPL5qe14IwH6Gp6xmqfm012gyu56DqSAQZsc4sxP866Bt/6keHtT9Uv0JHdC/MIc4TKgzcAjXmL8on+SUQhWkvGSuidTC/7mI1x7DMS+DPHB0yTA0UZLIe1RH3min7sLsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j+ezCQaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrZYvZBR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j+ezCQaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrZYvZBR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 193E81D0030D;
	Fri,  5 Sep 2025 02:11:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 05 Sep 2025 02:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757052714; x=1757139114; bh=fddVyUxDH4
	8etVFbB/zt8pLWy8EKZuvOBmymrcc7PsA=; b=j+ezCQaT4D159KRlWxT5kHTgxr
	Gp/ivu4oG8xYq80vhHEuq5fHwsxYHRU2cLYvcNjaTICSzmenEtDxWZJJkZWcg0EK
	RiwW3XrCq3NX3VTlpKDI96FDl9I4I1eMBDa0AUPMQrSTHs/NQEPeFL+UN/gguVpB
	Hd8so9xzeSMgve09aGRamhjYdYTCpFcZr2Gyk6Lg/GtJNMf0X4pzHwFWYMEwyfSD
	A+/ar3EA2gOjf1pVevrs4Vz4K/jOXslmGsgxs+mjCIVvZyQ0T79lj2tjUVl2Ji9I
	1uF1s0P8HMQmg4V+k3JDAH+XAw/rwAE2CXXRhW2fJkpMI+e3exgCeEjn2rmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757052714; x=1757139114; bh=fddVyUxDH48etVFbB/zt8pLWy8EKZuvOBmy
	mrcc7PsA=; b=XrZYvZBRXY77V56BAZ+NrFg46d4SE6FpiwHfQYCNXvq4ONP2JnT
	W6CLPgPTeQtZW4wKun4H673dXkpKGtJso9xjFOpNP8hfS2dqRsNe97e9Lk772lOx
	catw/5ojMAUVNq+7Bgbw6ZEEbscn8/AQkYANmgz7jQTDhW4EE1uKKmgWmL75fFUk
	patnE6DYJHPc3SfJK2vS1PrJzgzwlF/j4PoNR5hwc0sRpm6jzx4A4gWL/06hidB1
	2fH0p45QmpFumcNrrJd3GULLWjb73rHhELAd3jBnelOolYiyM+b9XrQksBRbcuK6
	DHHQG6aeQ9ewRPY51NQf3PP9/RCO8p3tXag==
X-ME-Sender: <xms:Kn-6aCM8DD0hTXbW5PUrlIwS20t1dAfScsKcx-n-RKka-ZnVCsveng>
    <xme:Kn-6aLgaazR8Nbq4qB1KYfmXgSU_ARn0Zr54-02cmaZFqV0pVn72ME0iyatnlXdXG
    n39kfQozgToJonZbg>
X-ME-Received: <xmr:Kn-6aF2-W5Yrd7ZRSiTTD3TPv88c-SGCaiuNrS7BJ7f4daegHF6WIRPLJ5xUo1zjbPcCJCURpyRaWxyiyvqP8Q1fNEK8gfXvDV-qyD_mSK9F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvd
    egieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Kn-6aFjRFEMt9rrikDJlLirT1UZKeraahhqFYVEw7bZwzFxpvEcTbA>
    <xmx:Kn-6aFeAqN-iEdQpOcr5RGJqf6nv9VrrsKeDxzNb8u1Op88Vt7Bkqw>
    <xmx:Kn-6aIniK-i6wVf4O0Mc64jtsPaQF60G5bBmG7XlwslzhaMhlUd9Rg>
    <xmx:Kn-6aOtwrwdTIcF0DioSh-3cNPjwbtYN7NmoSUhPrnZLF01i8S-Fjg>
    <xmx:Kn-6aGei6NYNd4xQKkyToM8inz3AKZIo2Xy030lbD0bIvnweAXC_vSmV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:11:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75e92773 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:11:52 +0000 (UTC)
Date: Fri, 5 Sep 2025 08:11:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
Message-ID: <aLp_JdWjpxF3sz17@pks.im>
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
 <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-2-4e019af4dddc@pks.im>
 <xmqqtt1ic0ci.fsf@gitster.g>
 <aLmJOdxUYiyHpiLA@pks.im>
 <xmqqqzwm9nrt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzwm9nrt.fsf@gitster.g>

On Thu, Sep 04, 2025 at 09:37:58AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > ... when the
> > server ACKs an object there is no reason for the client to go deeper, so
> > they stop advertising any of its parents.
> 
> Very true.  I did point out the difference in behaviour, but I
> couldn't actually figure out what goodness we are deriving in this
> code by marking grandparents (and possibly their ancestors) as
> something they have.  Your change in behaviour could be seen as
> stopping us from making unnecessary operations ;-)
> 
> If the other side is mischievous, they are not limited to feed us a
> commit and then its parent in the naturally expected order.  They
> could feed us A and then skip B and give us C that is a child of B.
> Pre-painting B when we got A from them, in order to prepare for
> seeing B (which we can return without doing anything) in the next
> round, would not help us all that much, if they give us C after
> giving us A, as we haven't even heard of C yet at that point.

Yeah, it _feels_ like the change should be fine overall. But honestly, I
feel more comfortable with keeping the status quo for now so that the
change is only doing what it's advertised to do, namely cull the memory
growth.

So I'll apply the patch I had and send a v2, but we may think about the
other angle as a #leftoverbit.

> But in the normal case against sane clients that do not skip the
> probes, marking immediate parents (like B) when processing A might
> be helping?  I dunno.  I also somehow thought that even normal case
> we have an option to skip the probes in order to converge faster,
> but I am misremembering.
> 
> cf. https://lore.kernel.org/git/?q=upload-pack%20fibonacci

You probably mean `fetch.negotiationAlgorithm=skipping`?

Patrick
