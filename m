Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DD37C902
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770705; cv=none; b=A7TGewQIcunlNZpN/sN2EUFfjYlcAsXfPLeYgC5Mt0RAsXQkT9o++hpdOMn/5vqypAd3B84LxRwyEiAO0Uu2qOrgbNMu0gu6HnU17/YV48tKXSnGSk7aFixxrNe0PvAgpmk7sZONqTCs6uACidFEj5JlpZX/Qh6aXa4hxefQk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770705; c=relaxed/simple;
	bh=9DXggtdyizi45RZkXJcr+7tWhg6sE2P9nBmbkyWpK0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSyTHhjQ2vZAFT51M5Ffxg4gU0MEs3kGZeM/tOKaYZahbVZAeOWvgqT8nDgcXkSnNSAxLmtTaboENWPL0B/PEV/L+/PEPBAgI0z76IzpN+AAKyDa4/qp7lItYTvoh1JrfhlDZGFXscnxYlrHu+FdXpvyK963/Cvg0KdY/fAVvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LzjmcLBd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phVdWZ0z; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LzjmcLBd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phVdWZ0z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68D1E7A00CC;
	Tue, 17 Mar 2026 14:05:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 17 Mar 2026 14:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773770700; x=1773857100; bh=hy4mfq1y4g
	6I0dIrcjubCMyiW5zQ6W+ywF2cBO+wsB4=; b=LzjmcLBdv3ALC96stgrwbaMOIA
	cfHybTsIUS7n0ioorVUfDASiiGqf7kdOXRZAdoYRKFQ9PQvI9xER1SX/dXGKIcDM
	POZjqyrZIQD4lcMHYih2WIN3sAHEggPfA8Rek2dDkxpNXOFILcHbQOTbGFbLR5on
	C87ZVaaQgAuhSwfsfXndKU/mbYD+3efUn0x35ek+RIBTDl29ykgWKQnnz0trVVWG
	zx27+f+MEal9doMe5ZtpBG3NHbaDFqAH2odn8MXr1yT5FDCeiqTLHzSpY/TSmw/0
	NfBdW+L5LRZN+lqG7rG/ZlYrbcz+nUnTzMJeii4kEE+11f8GOR7IASysKBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773770700; x=1773857100; bh=hy4mfq1y4g6I0dIrcjubCMyiW5zQ6W+ywF2
	cBO+wsB4=; b=phVdWZ0z+oqVTgg14SS+T3D7pRLHsQjuBRl3Q2AwoU4mNmaSmeu
	Zk7kc5+EWpZ+Qr9qVD9qirWoey70y7/B5uOLtrjy1gOzC1JPgfROfzGEviIHIakv
	e3xiAXLMhQzQ6jL68zlIhBurl7CiPiqMibqCKrbg6vWuV5PRVQaeHlUaypE/tgUN
	I9Bgl2QbdW1bBwc9ptjwxi3/pFxZXrSdT626DLyMixzFFpmiQ9wGBGmafPrOXtlB
	M6XY7wLvT8IwQ8Owl156DMLql7ElQC1Dk/G5kAERhjk+U2k2upChIpKLqLOy2onf
	fsXUMOW3hViLH4lJ60eGudq8kK+nBBHwyqg==
X-ME-Sender: <xms:zJe5afeFHH7rFoNvQ7BrsbILIgg8JEx8g2sMug0JS3kicky6fPqVSg>
    <xme:zJe5acrrBrY_QfKt1LCx0HeuqvV_cRYUO3aFyKVm_EFUYEbDoHaDrzmjUs9SRa3Sd
    ni_YOsNPvWXdWNz_EmV11FgqiFxP8ljQG9TEiVD6Jc2eRvB2yaRBQ>
X-ME-Received: <xmr:zJe5aV7pf3ecVU6fEKg2VhCLxJPTzigeNx78Cl6_XxdrWqUhMad-N1Ai_5SrsVAegblET7BuM1dOIFO39zJ-6-QvLHuhK3Ctfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:zJe5aapUk1xrXAyrh_AzlWa04SXhslaf2U0K5MGR-B1tCWzd__OGsQ>
    <xmx:zJe5afhD5atTzYLaVwUNQZN9iMz4CcYeipQRYq5g5lee6wytlilWMA>
    <xmx:zJe5acJB4O6UACflekKvF_z1pRtmzZKPFLmAuH2B4R2i0NgYwJDPFw>
    <xmx:zJe5aXBVO3lDCbp9-EQmh8sCPacETX9TxMu-h-7ihkyigHjnXWhYoA>
    <xmx:zJe5ackORQROUGbVJmhQM_J_f885apqFgVjZC_g4hajgzeTFqynkW2wg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 14:04:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] add-patch: use repository instance from add_i_state
 instead of the_repository
In-Reply-To: <20260317165230.628705-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Tue, 17 Mar 2026 22:21:38 +0530")
References: <xmqqzf46l7x1.fsf@gitster.g>
	<20260317165230.628705-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 17 Mar 2026 11:04:58 -0700
Message-ID: <xmqqh5qel4c5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> > Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
>> > the_repository even though a repository instance is already available via
>> > struct add_i_state s which is defined in struct add_p_state *s.
>> >
>> > Use 's->s.r' instead of the_repository to avoid relying on global state. All
>> > callers pass a valid add_p_state and this does not change any behavior.
>> >
>> > This aligns with the ongoing effort to reduce usage of the_repository global
>> > state.
>>
>> So we can call this "reduce" but cannot say "eliminate" yet, as the
>> files uses comment_line_str?
>>
>> The <environment.h> header lists some global variables inside
>> "#ifndef USE_THE_REPOSITORY_VARIABLE/#endif" block, and the
>> comment-line stuff is among them.
>>
>
> Yes that's right, there is an instance of comment_line_str, should I add this
> in the commit message and send a reroll ?

No need to.  I was just wondering if there are something I missed.
