Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8154654
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836398; cv=none; b=Gv9ixgkzpfIybtE7yirEhV/QH7aGvnhHmeu5Pfw2weWgpJ4qevlj2Mv89/NMXVKVVY9CUbGiqw1p+UEP3xJx5NlnQmqje9iZpstdJDNB7VRjsz6SJbo9B2CzTC7EAAEaPNPIrQkVGHHhNl5B1SbR+HyHd45Hm/7UYB8r43Lk/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836398; c=relaxed/simple;
	bh=o4LfwepyG9gtVLjltkr5aDy3pQiR2KjphtuRWUisAag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bb/gtdeobgz8y/w7AYoW4zjkUOTN9safOgl0xXiyt8QM/+pf4FpGg5OL9ojp7+24RTvS2LXZX3oBCtXvkDFEwFtQ9xeWf6uaQheu/WVpxi3234I8uTZsuObwfGhsrPJQ6QrYQEU5IFUucmCMrnv2iNiJgPblMxCqT9eU4p424r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MWZMv50R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4vuca0MD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MWZMv50R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4vuca0MD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 66694EC053B;
	Fri,  6 Mar 2026 17:33:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 06 Mar 2026 17:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772836396; x=1772922796; bh=AZRlCkXolL
	STeq3jJqTG2i/WDezRuemNwCMhNNu22Tg=; b=MWZMv50RDLMqMwk6D4Y39BWXwm
	Mu2QVZiw665G4g48cL5BISlUvvPoxkPBfnRNw91NhWwiPeP4PaFvJh/v7rIVCC+5
	jnCQhZCrnrVhUeKvc2vtG4cihXuHB2yJjAHeFUIS95JhXH07Viwtyp6XnAd8wuWi
	mvA5kU+aUkyT/1cvqYj2tKDKH/iBz2nHYiM2L6m+4KkaA7uQskLWl8x8Z29ErUlS
	sew2WCW+X6ITxZ6BjRoJB9GNOfNZ0hgf5bJ9U/KPE5/ZLwOqqmJ9w/zz8FteCMGO
	203wZZj54OaeX9PyxveFnBtuOS33NzA/Z3P57jYbVBc1BOnXD7mAK2JeLboA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772836396; x=1772922796; bh=AZRlCkXolLSTeq3jJqTG2i/WDezRuemNwCM
	hNNu22Tg=; b=4vuca0MDuzTlnI9iY++7yLKDmoAcE7VJg/fJT9nq++bktuO/oIX
	77ZiUyG+CMTBuYa2jOBh5mysaxDCa4L4YUVnUtUrNwOMubyes7VAFSgZV0GTynAn
	fcwh6j5Hx6O5FI1elA2lQOJuA3VGjuiU932pk10dK3XGyCd1zW4bwdT1LzFulMIs
	LMohR8Ia32I6Z7IIeKKMdknF5haBHBbNW8S3KXKHoY5JZYYMh4Q8zPmarsB/YFg/
	tkU0hSH2hZU0STrzAIvviLaa7fObIGhogUbwIZNTF1RugslQCmtd4fzZhyVpNfAx
	UEK3V7ySwJfE4fc50YAwsAbxnAP4+S4ehyA==
X-ME-Sender: <xms:LFaraVP66-vKINqZ2v3rnh7i1l_f7eciS1chLgc27R64SIYVgHQJcA>
    <xme:LFarae_nEpjcNfdthg8KD2V_1A-Pcgcz5afUo-hgJxHnntUnYUcsaldhDNqzWzly-
    78WrWvN116eS3L5865rGEHKpitADXxI0i5NllZCodujbikg-iBPZQ>
X-ME-Received: <xmr:LFaraZSIqzwrL7M7KqgvxHE7Wdel3zg7eqJRPcS-YoO8pG-INBJyxZDiLNlk198sJcx3qeumjrxX_wHGfyUfnBBMttf7p3dgBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LFaraQktTgsF2fhwOzCihisEHWpv0AV_p-JAGrCluka11iL5ZE34Kw>
    <xmx:LFaraZR4TAxx4puMmwE75My46fw_OtnK2O9E55IPLwahYme__KAi1Q>
    <xmx:LFaraeOc6r_xvKOaK3EFCOmzWtiJjA6QLNpOc4nOWnMB_MpZrTJVMw>
    <xmx:LFaraSXSB4Pjh3U8qR0OYHaz4H3jX4ap2UvaJGiMIpLIzuLZvq1_gQ>
    <xmx:LFaraeSzlagyQVyQ456Jv4991a5MPEBrpWweZVtBQ9yuFTBhi_Y4HxPI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 17:33:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/5] format-patch: add cover-letter-format option
In-Reply-To: <cover.1772232373.git.mroik@delayed.space> (Mirko Faina's message
	of "Fri, 27 Feb 2026 23:48:10 +0100")
References: <cover.1772196510.git.mroik@delayed.space>
	<cover.1772232373.git.mroik@delayed.space>
Date: Fri, 06 Mar 2026 14:33:14 -0800
Message-ID: <xmqq7broy4et.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> I've reconciled the formats between the command line option and the
> configuration variable. Changes are reflected in the documentation and
> the tests.
>
> Thank you for the review
>
> [1/5] pretty.c: add %(count) and %(total) placeholders (Mirko Faina)
> [2/5] format-patch: move cover letter summary generation (Mirko Faina)
> [3/5] format-patch: add ability to use alt cover format (Mirko Faina)
> [4/5] format-patch: add commitListFormat config (Mirko Faina)
> [5/5] docs: add usage for the cover-letter fmt feature (Mirko Faina)

How do people find this latest round, which unfortunately haven't
seen any reactions to?  The earlier rounds have good discussions and
I do not think this round misses anything discovered and discussed
so far.  Shall we declare victory and mark the topic for 'next'?

Thanks.
