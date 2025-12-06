Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B031FF7C7
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764998880; cv=none; b=CdxrOshPk7IylpuDq0bgfF8r8eXvNG/jxxSHdilzcxR2QV9d1yWGoNPPAOUoxr8hR64orTcDN4CCpinw+faoI/nIsenpvHfLHZgL1vP6ig1haTmGhmL+0Js1IgIqLLgVNa05Shh6PtEJkP6bzrRNwFi8C9/waO76rkjHWG2x70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764998880; c=relaxed/simple;
	bh=uBL+KyR00CNzftsM0ZkWO9cWmoaFPSgZRu2YAyZ5ID0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HurdcTEwZ2SxCmdI8BTwQ9vCWashfM5IHZkkZrs9jXl206VYJ+QBhDQLFD+ACbuCTVtcmSiq2u0wxwUmLUJZ12TLdXjCWj7q6XEt0jJvQBuukzcbiz984N1fgWuIY9c6Q/hi4HHypxVZkt+7FSwjX7gm5F/poRYH5bDTmBC/znc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VQDdxzqd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nwp6/9CY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VQDdxzqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nwp6/9CY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C771A14001F1;
	Sat,  6 Dec 2025 00:27:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 00:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764998876; x=1765085276; bh=NnpLAte93T
	1ilz85vIexEG68vO1rJuOWh4E5EllWTGk=; b=VQDdxzqdgvkYOKvQIeRxp0dR5/
	z/k+PhpelrbWKMWPTkx2o4v40wrESUNjxPjty/ka16d4Co3pgI4/Ks7FCuS15cdp
	dW3b8sPxEmfBJEq+01OkII6+1Wjex27alHhqW3Y8eJTlD0H2hqaJWG6dkPNNAoim
	ZyYcp+4BuZHm6MagVMvp/sQltV8xGFDPOOluRD48DuIZsMp/itx0m+ssdYM1PFoq
	/tjuiu5T4SvJhHkCgtfLYp1JUYmnEIP0e45sd2Dci+bbyDFuBsmKV8EH7Mo4ierK
	GDH49iH5hIu4c0p9DKn2VvzsIOR9E3EU9hE54x/FQCRkMvCNUB6y3uhY7Odg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764998876; x=1765085276; bh=NnpLAte93T1ilz85vIexEG68vO1rJuOWh4E
	5EllWTGk=; b=Nwp6/9CYZ1dpXJAvJxDmE0dx44MkROa/wWnXsYfghpN0No3ePk6
	JqR5L4ZCkA/MuYrd16GxiVjq9vlbwdAAeyNOioljBdNoAGcpfVxBYRBzF1Y/zI8b
	UEgbcXSL+k7aVyVBIOVHkD3mZ2KQGOCDwl149MfyK3L6+IuqOSbOzbbS8zGpsdbx
	CTLo1XUvAHaxy7wukXQmJz5P3atahJx6H+cFEx/56yK//UEtzeFYW+L+PVM9cLpt
	wcZ/IRgCnj5mCUdoRMIgMzSMeay0W0RxjRIBlQDcaw5wUsbWx8kYy2JObBylzmYa
	VvY4k3XEM3tcRfnf5HCfkcabMdRlceZWDtA==
X-ME-Sender: <xms:3L4zaftMs6255gL8Uqmzbt1ldvf_EhxRGtAp_fl1MQOBcBXYLP8GOQ>
    <xme:3L4zaXUvEslO6i33G4lHO0f1ISTYEw0xP3cdU5riFeEMgs0c-tkPDdcEfgEZc4iQT
    VwQXEjHFcpudlExMclpfJq9u_g5VMm3Jq6wbuou1BK3pyjY8LwijA>
X-ME-Received: <xmr:3L4zabHlT8wUIlz0_VQhdDOlBdbmsTUqsx7g2Frbg3acCBD3Ba7Tz8gFlhxTDEUNnRNrUgXFUeLZpo68ok3xN0_AGiOYdQmLAU51>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3L4zaZ38LolX4gryr_3lVA9PNbmIuGSAF2zCBtTYrYANAhDD8lW5rg>
    <xmx:3L4zadNZyNtWsrgpd5KuISKt1mazpsi0-0bey2sVvb4SERczSQgjRA>
    <xmx:3L4zaY4qgmEIN5pjC0LQlCoLASG_YL5pLGkLdHJtqL7h_bDoneVy7Q>
    <xmx:3L4zaX36yCv9EWFFfwQhcS5GrzXdEvZgzkhXi06H9x5yRjH4Oo7E8g>
    <xmx:3L4zaYXbcaeA6cVzosjg0AXQL08bXr40iN0XX849nSR0q72fK8spQOxY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 00:27:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: update clar to 39f11fe
In-Reply-To: <20251205-b4-pks-clar-update-v1-1-fd70aac2ab90@pks.im> (Patrick
	Steinhardt's message of "Fri, 05 Dec 2025 13:57:52 +0100")
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
	<20251205-b4-pks-clar-update-v1-1-fd70aac2ab90@pks.im>
Date: Sat, 06 Dec 2025 14:27:55 +0900
Message-ID: <xmqq7bv05gdg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/unit-tests/clar/test/expected/quiet b/t/unit-tests/clar/test/expected/quiet
> index 280c99d8ad..a93273b5a2 100644
> --- a/t/unit-tests/clar/test/expected/quiet
> +++ b/t/unit-tests/clar/test/expected/quiet
> @@ -18,27 +18,57 @@ combined::strings_with_length [file:42]
> ...
> +  15) Failure:
> +combined::compare_u_with_format [file:42]
> +  Expected comparison to hold: two < 1
> +  foo: bar
> +
> diff ...

If these files in t/unit-tests/clar/test/expected/ directory are
expected to end in a blank line, can we teach our .gitattributes
file that these are OK?

Thanks.
