Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7C16A395
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575771; cv=none; b=d620OpShx0ScLPhQ6WX70gjJw7UjJC7EPv7SBy6WXT8rYRL6fMvjCqR4r4FLuaPaIdZAEAZRKX9kd2XYKiUIf+gRTFCt7XV9+AYpKH7YXMCWPsoSokEM8dzKmBTiYm54Wy1rAghoPh7j8Bnr8yoG7osZRQruJj41lZ8bYFYDbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575771; c=relaxed/simple;
	bh=NYpOko1taDyMC7+uXAerk4uEkAoO1OM0E234XbXBHP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YuLXm5oZojFd4EfI43QxiUpKmwWEoXyf+mCRQVVgCVjjzujPmWlK35Qr7gBpitsmUhFSWPWsb+Tm55SnG3PWfcdoF0h8NYvje8W3kEv4Myn5KcJy5qbEtAj8i8ZR4pW7Y6joA7UUh4weRwhy1XAKxwe63WDtqsQ4b6CqMjCQ6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WObsLbMG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlZN68ur; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WObsLbMG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlZN68ur"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1CFA11400AB;
	Wed, 26 Feb 2025 08:16:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 08:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740575766; x=1740662166; bh=xfdbIBtoNc
	Jl6G8oICALhYDVJ5XGlolsMyFYRrLOGbo=; b=WObsLbMGLSXL7HdvvKj/CbG14S
	kjz51iL1seVjRHfph7hrS4i7AnlltDEufjSs6dBRr9fGVQZFKJdIcEhJ8iIUfI2D
	FbeuA09Y+/uScy+6+3hF0TPDmvE0YJYen2fAGxVp3KFEAR3nZy76xbjsPgIDuhzd
	FaWqN6tk128VX/rC8hkOPl0qmOtT7K7Pmwe11FnsPcpgWtWZhqZ2+eZ5wUba11tY
	M6p74FbWsfXyrWzhZHaaXRaNY78DKpxDx5ItE4YohCPh6qC2xj1VnIVC7uzti1Oh
	UPNDQ87RhvAzRZjRw3sFU8zrwqVFceaWWPnSXjf6wGQRH5LZOKCDZZSSicDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740575766; x=1740662166; bh=xfdbIBtoNcJl6G8oICALhYDVJ5XGlolsMyF
	YRrLOGbo=; b=nlZN68ur5auEmQ4RaRUKJr9cGFDO9OKXzyZvQKl08x8v3SoQea5
	/KxIFYB6chkTlA/z7U/oZizjlEl2vD9D1DGnZPL5enK83tHYwy/d03wue3DcLv4x
	mHo8SjYpkatLBtpsDx0LXRWaaoKGZCdpnhYku+rPCPK549pfqRtIR7hzknLtIdeb
	xZ5cWqG3r6tR8G0MEvEpRbwq8XQ84zy02n5xzC9b07SmbqbC/2Nwr205fPX2WaDw
	mUVFumVL4QlvtMMWY4tXWd/NL8NtOmZfLMv36KNzBFOa4hUVHLmKql+wCzRGEN+W
	Dvn469szFCUqfdAhHgJaKSoBTQjKJoFdFJQ==
X-ME-Sender: <xms:FhS_Z0ru2s5LmembxJNekgOPmStGdgQoUIz7uyk-KlqhMbQyfKoVSg>
    <xme:FhS_Z6oNfOWZiWPw7hxtb8pCgVGjpF2Ev7UUJBu9RP3TTbOjJOm9Rl9K1vImAy2cS
    cbOs_UDWgQk93pZ-g>
X-ME-Received: <xmr:FhS_Z5PlMCYoDv_J9sCgg-fVBSno7-MsazH-osbYUH0vuINDP0bu6fSMm9vKFVTGwfuKjfcdnMQBSCcLGZN9-iSHmnFoTdyB7Wq5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FhS_Z749e5Nr0u9oojNX3ax9yt8We5RzZPMpBYSGM5BSE6B1jSnIaQ>
    <xmx:FhS_Zz7CXXBM0mWBDyKm-vPitLEW_xioGNij37n3IQg7X9xMANkaXA>
    <xmx:FhS_Z7gEfmpkgAZIczZmtLrR0QWe4r252VoQlV9CPdBHSP_NlgP-ag>
    <xmx:FhS_Z97jIuxqhqFL0UyZjlPoGOTlsjwbw4CFBL-SYjHJztdpPk9-YQ>
    <xmx:FhS_Z23QDUINE4NTHF9ByCnf2UG62twlV2u5nsYwxG8B2Nl3TX-qZqg9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 08:16:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 08/10] unpack_loose_rest(): never clean up zstream
In-Reply-To: <20250225063312.GH1293961@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 25 Feb 2025 01:33:12 -0500")
References: <20250225062518.GA1293854@coredump.intra.peff.net>
	<20250225063312.GH1293961@coredump.intra.peff.net>
Date: Wed, 26 Feb 2025 05:16:04 -0800
Message-ID: <xmqqwmdcg82z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This patch and the two after are pure cleanups which should have no
> behavior effect. I think they make things better, but one could argue
> they are churn.
>
> I didn't reproduce it, but I think this is also fixing a leak when
> check_stream_oid() returned an error.

Looking good.  Thanks for paying down our technical debt.

