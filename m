Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBC320A0C
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038974; cv=none; b=hlswHzLnXOuGJeZQ69R55ugJpGho45DFso+EaMmgATrHsjtHVA9zIpG/kAStN5m+ynfH/fA8gPU9Q6GBNHHwsYo1uYIg0Yg1XX8GdI+oPXQfNnbQZRGMSbIE/aSmHmICGb1m5XAoJQEHLs23US/ibqbvTxo9m4f9ka5iHGrXtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038974; c=relaxed/simple;
	bh=uzOhh2oW4WksDxDWraU/k2utkDf2G4LySfhKx/1AnGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUTiZS7PZfkKJPZTD6tDH7mfuXuk+GY3QuTYdq+DobdHzYYoqEwDovGGISac9RWxZyVGMgBkPoBK5M2bcKC3wlehAcX9gLG+HKKnUcbkgOaEe1WyNeCOWehbLCmorRhjtenUB/nNMEenKbwWCN4p/+VJdQaYcvJDKYGq5FXrUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NX69Y1Qu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndPwtoeM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NX69Y1Qu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndPwtoeM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 201401D00066;
	Thu, 18 Dec 2025 01:22:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 01:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766038969; x=1766125369; bh=X9Q53G1O51
	FRQeBdXcaDh7MTkYAfFuqkEwJs1d+ljms=; b=NX69Y1QuOSxngZDkXF9+vi91hv
	XqWpwbPgeJ7gWyWU38mP+ps7ttU4YIy9vKDfx4BhjrhKuNa5+xLAL6w5CWU/CFp8
	In3c6XD3bZOryJYq3nLPlkRtpkMVnx7pbwNv70mdNr6CeqrJg8I9TCHPStQj0zXr
	LdEfaA0wy9Siaak4dgDSkxtwCwmssxeJ4e3nachFmP7rQ8gqJawa1zRbdOBR1bZs
	Fmo5nqaQmHaZ7Z53gLOkEwWpRIqF7GoBpYewcJghHiQbR6C37pfGc8OWs9acTCF8
	WqeMAeFlgdeGtIMJZ5NAXOwTUlrxKbHra+5BNMl35agf0HohIP4BowiUduzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766038969; x=1766125369; bh=X9Q53G1O51FRQeBdXcaDh7MTkYAfFuqkEwJ
	s1d+ljms=; b=ndPwtoeM9308ao809w81Hos1TV1DsCE4fRGhXHGLsYHDqdu1CDm
	XCqw/p/4QuvCNKdudtVEKjsXl88qhfAbjvzCGgyoY/GIn9PkPkrlBNVdtnPG/RDh
	wQGLqhPkyeB+H/chehHAVC4buXZXWxXN507/IBSnhht7jYp2qsJHuEiNW+Avn/DN
	Xcs4cqLZje0n4cl7KkYqvWqKB6uDC0micgBFAL3+KKgg5I5pGyzovzRK9cDEaXdV
	E6K5dB30M2FtyYTjWcdxlFH3Ip2lfihr27dx3kBEhkvR5+OwgVUDMoDf7aLdG1kg
	im5dpDfzZmOobxl5QQ1sXbedqzltso9/LOA==
X-ME-Sender: <xms:uZ1DaSXTfZMruWfL1U8iRNyA5bYsxnFn1S6tBsC-rOmiCa8hleB1xg>
    <xme:uZ1DaWAcNEY7IbobyV0HAKMt-YQLoGw3qMICGYI0yr2p_qRVMYyMmXJrb-tD90lr5
    0UiJKtDmkLnWJi8N-iWujsG_e6ItY3s1AAKoCmSbjDCkegCUHpIJA>
X-ME-Received: <xmr:uZ1DaTxdrFKvVzgPAJ9AfLoOnMkv41uV9NnZPFe39L3GPYR74NSJ_5u-HHTQZLLZY5518f59XXGsJ9EMkohtcXwr2ArhZra1D-_xMnruNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdr
    tghomh
X-ME-Proxy: <xmx:uZ1DaTAeQvMlkiSjKpVZhsxcMHEn3RYS0-yHNATXmqpO5_k8ciqnKw>
    <xmx:uZ1DaQZ259goW_mfv1ybaPWqGhF4ry0JgMJGPaZOXI2U_Nn0Qu-FYw>
    <xmx:uZ1DabglsFoBD-6SBOlHb26ZfYy9b2W4OOlI9qY90BRX4qpf3-ocQg>
    <xmx:uZ1DaS5pVqIRtOrIUfnA8UbpjCMNg1peH1jlPit79giSTD9fu2S2RA>
    <xmx:uZ1DaSor1xhIPlBFEGur2ZAWu4DCOKh-mup_AQF2uIjar7YP_OzvjKGx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:22:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa2a279b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:22:47 +0000 (UTC)
Date: Thu, 18 Dec 2025 07:22:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2025, #03)
Message-ID: <aUOdtDrmtGtQg596@pks.im>
References: <xmqq4ipwc7y2.fsf@gitster.g>
 <f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com>
 <xmqqtsxoxzs5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsxoxzs5.fsf@gitster.g>

On Thu, Dec 18, 2025 at 11:57:30AM +0900, Junio C Hamano wrote:
> Aaron Plattner <aplattner@nvidia.com> writes:
> 
> > I'm pretty sure the problem is when do_oid_object_info_extended() 
> > substitutes the blank oi here:
> >
> > 	if (!oi)
> > 		oi = &blank_oi;
> >
> > and then packfile_store_read_object_info() compares it to its own local 
> > blank oi:
> >
> > 	static struct object_info blank_oi = OBJECT_INFO_INIT;
> 
> Ahh, that's an unusual mistake.
> 
> The following was done on top of 'seen', but would it help?  We
> shouldn't have to use the stand-in "blank" thing to begin with.
> 
> Besides, explicitly handling the NULL case would reduce the
> potential chance of errors that somebody accidentally writes into
> blank_oi, making its contents dirty.

Yeah, indeed I've already found that regression myself and got it
cooking in a local patch series. I was holding off from sending that
series because there was a minor conflict with an in-flight one. But
I'll take this opportunity and send it out now.

Thanks for the report and your initial triaging, Junio!

Patrick
