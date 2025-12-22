Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCE2D97BB
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409562; cv=none; b=ixKbC2Jv9tjfObvAKotn/gnmIEQvBDSqp13/nA7qLajx8xZ51R7ktbxLwp8Fub1Z/y6BgodfieX1Y3P363k1xhrI+wk1j2Z5PXoMwrZ4PdPdHCcqZh5zu4PPdNhtlpcrPzRoKM/PqzdFEwlVw0O/4VYD/COzhpbhWg0Kw3XRAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409562; c=relaxed/simple;
	bh=1W3OG+1N7RXVIpjLhxFqGA+efNtKT569lYB5Y9flQP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZVT3F2MlAreHTprRE7FCE3uA+/N0/Wz4zIDGON5HceHjNHPNmyMUS58D2C8qGsWyLFgVt1mAIh50F1jm6paOmpNFNf46x1/52TYOz4iD/zRIFubmCudBtSY62hZQOw0Jrd96kdhjxFubqCwwEciYDlpuORE/ifEAeBB3H9dPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hucyZXSC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCDXE7S+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hucyZXSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCDXE7S+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B5E91D000E9;
	Mon, 22 Dec 2025 08:19:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 22 Dec 2025 08:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766409559; x=1766495959; bh=vhbPqngp8+
	6NKRTFuV4TPTLM8/vQrhbwjOh4t6MfGbg=; b=hucyZXSCVfa1T8zhA5yISBdPIK
	U+H7VkhxLGoki4qR39zbRZPeiU35iI1PT0lLObyCtLgcxEPeHMwD+WAhME09tp6R
	cNmyVDLp3Wvby1cFcgH9XiqExPLJ/qXcCKo3Z3ct0eFkwr+Eu3sLuEHGf/60nUAO
	1UDC/8uzZGlwIPvrwFIx3mjHbbNiseFoI6WhOuMf7rjdw9Dg+8r4RD3LrXl+TSPU
	lm4+hXiGGdgFRW3T1CMzLEA1TE9X15ktrQXFAmaQ8jl6Iwze8RJvw+OhqvPa37D1
	BaJsokBJFaPm5oYsKyn8PTDVTKi2R7AYQ1/1Ra13qy882P+hsGayf0zVX71A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766409559; x=1766495959; bh=vhbPqngp8+6NKRTFuV4TPTLM8/vQrhbwjOh
	4t6MfGbg=; b=HCDXE7S+fZCyjTkowh1+wQMZROfAInM7DM38EgsohJ0NOWlQGp2
	tMkfp7xnX1OUmlhOym4aU//i/rP1UxR8u8Sk0vx6hKyAh6IfaLFV3BEDeBFUCotc
	qbDWj2EB50zyQMfTOml7cgW4i+i4YGEpS+dIMpDLagFnCBFbChwjtG30iJaWMuHx
	hBpQEtQdecSfJCcJtKQGwkULpOitML7jRFYBSn2+M+AgzxrIJxSEOmtrXGteT2CU
	PRHBB/Sz0B2r9wcZZKVRpvcTyD/YYgPmkW7Sh9J4l4a/CNW5Uf2VPKcPMOtJAqAi
	TTBSKbUGHd6mD45IDLCJ/1Nmc2IRdYR8O4A==
X-ME-Sender: <xms:VkVJaTyhgCPRUnVQsY7a5WQ8zcMPtudkkgiB6QugRm33O9RmJuB7jQ>
    <xme:VkVJaSRPH71f8Q7qj4OVX03J_bnantfwuVbspfzOE-6wJVsoTPVQXkW8mxNhht5vA
    vWz0bIL4iRR0xdfK7C64zpB4lOe489A6Bhvg5BsJ_CeJaQfhm2FeA>
X-ME-Received: <xmr:VkVJaSUYiUJaSEcumFZY3cAH9XoWtiZWckTVc07Ke_MYCcNtUblxPvurlhuW-3Ctu5Of4AZt3PY3X5is0UywXo8D45oxCp6DbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopeiihhgvlhihohesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VkVJacaTTLFZwYqmKg7lm_9dBc7En_FCB0LO9h1-Doy0opvqne6XRg>
    <xmx:VkVJaQ0FKOYOchVVJvAFiXp85s7GdOyhiW75AHCOWOQ4gNQmiGrY1A>
    <xmx:VkVJaWgiJjDqTJ-eAq8U2iBT4m6_HwJ6kmfgUEcDw5Sv1otfXnpBBw>
    <xmx:VkVJacYp8TJvDT4J1GMZ0MUf9L5DSffEKdSMxQEj6j0VWsuf3sGMTg>
    <xmx:V0VJaXl9W4WFFiJZxSsz7uJDw-AFyRoFYQSIGIPKXIdHgezxz9JgpDKk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 08:19:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Zhelyo Zhelev <zhelyo@gmail.com>,  git@vger.kernel.org
Subject: Re: [BUG] git restore: typo in error message "could not resolve ource"
In-Reply-To: <aUkx2XYCP75GrCsS@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 22 Dec 2025 11:56:09 +0000")
References: <CAMxgZ8KqU9BUJ6T7DLct3CaEh9EYdcMO=dBAMPyQsb=knekSuQ@mail.gmail.com>
	<aUkx2XYCP75GrCsS@fruit.crustytoothpaste.net>
Date: Mon, 22 Dec 2025 22:19:17 +0900
Message-ID: <xmqqbjjqslgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So I think this is functioning as designed and isn't actually a typo in
> Git.  The code appears to be in `builtin/checkout.c`:
>
>     builtin/checkout.c:                     die(_("could not resolve %s"), opts->from_treeish);
>
> That shows that it prints "could not resolve" and then the thing it
> tried to resolve as a branch.

Hilarious.

We probably should give a pair of quotes around '%s' like other
messages, and that is what CodingGuidelines asks us to do.  In the
section of "Error Messages", we find this.

 - Enclose the subject of an error inside a pair of single quotes,
   e.g. `die(_("unable to open '%s'"), path)`.

Thanks.
