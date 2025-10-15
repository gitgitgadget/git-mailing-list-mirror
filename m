Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63628EA72
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559437; cv=none; b=LnAroi94Yix9GqcfE3MnJIZztESrEiSFsAcNNcM/IYnteSI/X0SQOhXTQbGB5m8fksy9j/NEl+yPASqCjlffsZRv77EhZQtsCR7A+VO7Sf8jCNJNWImY4bNNRCK2TNiHlol4mdfBlfnpoFNGauSihetxNDJuDe8A65ZYXXnsJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559437; c=relaxed/simple;
	bh=ddLH4Id7viT5X8kGA6mIwUTwx3W7EDTEVLYX8dlftto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G4WJloyV/5OqmnpLSmGOoGgb2qkujSPbmO5cEMNWNLK/3pi31SEmNw1mrK3JPby4Mf8bQYYFAR9DZoZBgIZQKuCiNBa6i62bqa50puQZzd6HCkzbiaC1JOS8vRWys85+xytIm5SPoZqXQATY9mdxDo70tPn+Olgy01Ym1vVl/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cZJhdIzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xiEjYqi8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cZJhdIzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xiEjYqi8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDCEC14001DE;
	Wed, 15 Oct 2025 16:17:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 16:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760559433; x=1760645833; bh=Zko5lGTZAn
	OFD24700MkbsS7skHUv6x03GFI/Hjj+/g=; b=cZJhdIzPgK/QnlECD+pEJ+IKb7
	F9ZR/S4SXekMK/zZRf5DxmbDB3Wpx4iz8b9jJpVRhfTSbyPW+bn8Ap+an+XszdMW
	7XKehQ/QFmvRlec05MT9BMbvUaCda0TqVqROwxv4zmoC4q0hIbj4EaEDoiBoLZLG
	RNeFJurITq7QSv2cf55wcHZHS4cYOWbaD2HsxQNrDoRI9qNRMfGWZV0tb3GTv7v7
	LlNsgm2FHKcfme2kCByKe3CM1DwLzRHJdC+FHNj3WpOK0M90Wg0mEGFk6MvLEV1C
	2HJASSaAISosCdk2BnOqBEHR2DLNWpciCaL6AKUJhUG5G6TduzUNUtsZ69wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760559433; x=1760645833; bh=Zko5lGTZAnOFD24700MkbsS7skHUv6x03GF
	I/Hjj+/g=; b=xiEjYqi8UJ/nExCGfdejaHMmrzJcwB55+QqfYL2oRtkiHwKb6rm
	sf8ezQShkfptyI9eXt5eCDqwjk/Ec1hgSsIt6UcyYpIOdaK0cUkodCv/vh5c5LX4
	157kejE/M8n3SiMp6DkA23YTGVV3Jal27/DLE/KlLPEELHpfUmAsz+1bHD3+LPbB
	QICqeouQaGYFX3sI2p2DBKHBQsW/kYMf0Spl3XjO4nLIHhHAybSGCk+ZvATmpnVO
	8OUOPV76ZTUkrUpE3dOSH02o2UuFT/ZwEtMvwsVHmIa9cvZXFGQpAOlQTjVat7NF
	FvR2lJYlx8QC8ZXDf+fceA8WCEwiLIS6YYw==
X-ME-Sender: <xms:SQHwaIlIfHg3OgkCA2LWzuoxq4ql8sMtPBPl6r5GodB-i6UtpkiJcw>
    <xme:SQHwaO24kAWyqyNYAcigDhy65Lk7-qJz5JkT3ZcqbH3Udp70mBqQKdeOu72OusW6Z
    2SFWXX5cc6NaKJkFMt_lnMHTY52KrAuV5SzgJVtyfIZs0PSDkng>
X-ME-Received: <xmr:SQHwaLq4KdN3Ijqm75FfrjjQUIYQMDvd1ZphI_QEFcEruq1K5XTOMUeVRI8sqZvnAvWS_qToZKdjxUvX4oNHtUh9pHIwUc4X4QBb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SQHwaDfRUtVmlV5F-2OwxoYs3w1lQ8GNARYMRP7juC_vuSZupi86Rw>
    <xmx:SQHwaCq0L3qJbL9qPVOMXd76izoHO-1VeaqStMzVfI-CBU8iNDT_Gg>
    <xmx:SQHwaMG_e7Msx-0aM7SDpNZgYmEKzqQLW2boGaVS9pgC2gnsXBXO7w>
    <xmx:SQHwaKsez0XJD3Kekk0stMnV04ByStRgO8U9IptB9CHrmqcHcPDE1Q>
    <xmx:SQHwaHJL67yyyvb29ju7U87I1v49PHe4qvCJ2dhI4MqGggla0-DQN9C7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 16:17:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
In-Reply-To: <aO-QIn7KAVlBmfRq@pks.im> (Patrick Steinhardt's message of "Wed,
	15 Oct 2025 14:14:26 +0200")
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
	<20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
	<aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g>
	<xmqqh5w250lw.fsf@gitster.g>
	<CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
	<xmqqldldxtoc.fsf@gitster.g>
	<CAOLa=ZQj20e_p99dzWjmrQ2i-RnLjsnEN9ihuDirV4iPN0QqPg@mail.gmail.com>
	<CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com>
	<aO-QIn7KAVlBmfRq@pks.im>
Date: Wed, 15 Oct 2025 13:17:11 -0700
Message-ID: <xmqqqzv3udh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So if we build on top of that mechanism we can easily broaden the scope
> of this patch series to:
>
>   - Check whether maintenance is needed for any of the enabled tasks.
>
>   - Check whether maintenance is needed for a single task.
>
>   - Check whether maintenance is needed given a specific maintenance
>     strategy.
>
> Another benefit is that it's a bit easier to put a verb into a proper
> subcommand of git-maintenance(1) instead of having to add a verb-ish
> flag to git-pack-refs(1). `git maintenance is-needed` feels way more
> natural to me at least compared to `git refs optimize --check`.

Very nice.
