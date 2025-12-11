Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635FF23C8CD
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423124; cv=none; b=FwBEgn9XhOVgki4GZ4gov7OrFi3nbbRF+vSQBkHu2c96+kttNYEypbDONnUlTUj+OSmvJDL2gV4hlt+DzEOCjweRsdYJIrIpUAaGJ03XNF1HsKuVBRhdnGEmyi+LUouI4vux16l8BIeE08mbCNn2Vbz4hwC9YAUmLyGtGCXF4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423124; c=relaxed/simple;
	bh=IMYsSzmB3eGrRX+3pBA92rB/T9c9iFcgPg56O25MYpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpKS26iJ7Ffnt8sI68kM3xZ9bGkY5RnemQxTPOAXDBwQXGOs329Z+rTWA8Ili4ak57KYmCAMZy12/UIP/pYv5t/2o28zCDHFBoNfyEirMBc861u04yFkNRiQrmVsEqFZ809CQlUSE4BGrf+oDHYu23p3w+8htZdk+DChQQvdhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jgmI/hr1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNrD3Hz6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgmI/hr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNrD3Hz6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 646181D0009F;
	Wed, 10 Dec 2025 22:18:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 22:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765423121; x=1765509521; bh=lRciw0DhaT
	RGrtZYV9C/jbEBhlavgDJKKvxNQI1UwUQ=; b=jgmI/hr1K4WMeUfmaxj4RXdE8i
	9xgCj2aeDatTx0Y/xrPvqPCgdpLztDOam/Q0xZ99CV5tz/clEqtq+QkTtHsWLD41
	9fVuoXZA+33j2+S2yvVh8yb8RoDflGFNFmsWrp1kvunlMimbym3xxhijkcfAw++y
	K1T3IaGUB3BF6iPhCslYvix/a7bbCzGoBr1u9DQiu3nHiojV+74tCqcaoi+z9Mw/
	nQ6mu75oOHwUwWjLF0HAnldHjE25Vf5tTk0bALIF8kMXlDrdMiptl+cD//l24GFv
	EP1HHm/dSBuN4aHONexGiIv9RDy++OLKl3RKDyGflVa4pbQcT1Q6T8/diI+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765423121; x=1765509521; bh=lRciw0DhaTRGrtZYV9C/jbEBhlavgDJKKvx
	NQI1UwUQ=; b=QNrD3Hz6UyfbwMrfiCr8SUJ+rBH8mXFiGMx0q3F58bTDmEhskcF
	61VjZu52bcgi/JRNnN+Ds6Fv6VqZKtXh+sGaONKWCbZo/W1u/o73bXYuOj7yz40T
	yUps5t6Ft0jAttXc8t4r3IkHQkiPzdA3PJAyjBHiFKc35wKs4EUH8KIgsFi64bx4
	sGS6QSMnq53NOEit7zQwIrrM11UWDeZ3c5sQ2dJOzNTP7jwu7hojkVTBnR6u7hWM
	Lv+iKUMGlJoZNv44irxndyMeR0Q97KyJwZzkgNdYLgqEjxJP5Fp327pLp3sOohUb
	8EGsy5i7AQ9auZxMu/GwzaoxR2VhxaK3lLA==
X-ME-Sender: <xms:EDg6aZPZSM3zwkFxOKB98bY3iHAgcTYC1ISFPkBcQnZOk-I62dmLEQ>
    <xme:EDg6aS92MUzb-LmjxfIzd1GQlXjqJEEWZYuaJPnthVokPFai-hWAo3fK0meS1BLR8
    MxgOmeLEVDkNxe-AfZo-dY7Mf54_PRZkGlFAlV3MZ9BikFN6VSh>
X-ME-Received: <xmr:EDg6adSZewRYwksTBEl8dJILctsV-i0NAnXUwFxbNityknnoOtXZMJGlehL1XJ-Y4vG8k1s2he6dTgm8K45l4b6-dP6JTVHPKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EDg6aUkFZXWlZYh8H66VcnddPpfo_5TJvbGfxiPHn9ikIQp4Dd4Xqg>
    <xmx:EDg6adQLUJlOfTCqoSACgjNKV0KPDNC9Y7fZRjxSRJQDqaYgQ0qXEg>
    <xmx:EDg6aSPPuz-2aKpxeqGUOx9dDQ0eTpBdAxINflZ8xklH-W4-xhk1RQ>
    <xmx:EDg6aWW3P7VFQJHqZbdqln5DqQc6bykuq5nhFSgl7gZoulclCHVwww>
    <xmx:ETg6aYnBDY_d2lcCqyLV4pp2gLUhlWugtlO-dobWKUcX1KnsLrtUUlEW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 22:18:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-compat-util: introduce MEMZERO_ARRAY() macro
In-Reply-To: <20251210-toon-cocci-memzero-v1-1-ae916a79065b@iotcl.com> (Toon
	Claes's message of "Wed, 10 Dec 2025 14:13:01 +0100")
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
	<20251210-toon-cocci-memzero-v1-1-ae916a79065b@iotcl.com>
Date: Thu, 11 Dec 2025 12:18:39 +0900
Message-ID: <xmqqtsxxg0z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> +@@
> +- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
> +-                                 \| sizeof(*ptr)
> +-                                 \) )
> ++ MEMZERO_ARRAY(ptr, n)

Shouldn't we be also catching

	memset(array, '\0', sizeof(array[0]) * ARRAY_SIZE(array));

in addition to "0" and "0x0"?
