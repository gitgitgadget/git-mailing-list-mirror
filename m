Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F952DFA54
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412484; cv=none; b=nyT1HMvrEg6Rhvhf7/gCyZkpxlhWacnNvk6Sa6kSG0kDE/81Bw3jpdsZuNB9z6j+S0xV5knL4ngsOUaCagcEwUaFqOp0F5+V1d1TLTO+sN4l9LVx+wXBqOhRbW/PLOIVtMvLA67LOJdfc6YvSlzRqYyuGWcv7ewovJIdqS1Y4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412484; c=relaxed/simple;
	bh=TgBSYc4E6MjB9LtKDRoAGT2A+fvoVuFYO+eZqMsQUa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ok/FsPreXzjlWia5hgdE7h26a9NoJOrVeXaRHwRb4pxAkSGdLFHEr0w3ornR0r1IUtGZpyaudqNsYYay33KE6pgWH/Yor3oiVCriFOGK8FQUg0O18Eb0qmFm7V0bMl0fz4L/NVC+Ify7vxMknAcukp49R0qzLrQMJnFPtNasTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oOnfKNBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCs/KlEJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oOnfKNBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCs/KlEJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB2E87A0324;
	Wed, 14 Jan 2026 12:41:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 14 Jan 2026 12:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768412482; x=1768498882; bh=ouJ96yghZv
	8pbWBqDz0UHrpOByBNlJImpQc8Jyg58+Q=; b=oOnfKNByFx+nCnBIqS9q+AiGYc
	IzVT0my6ZLfDncSAPjIPPxWxXganMwI8jevtyeKLoohhaFE6aRaIL5CocqduDKds
	Cv4LqxN8JcGRTfg3IaE+6hQLrOBBA1EEpNhuRg1IA6VlVU6xLzVv+6lEPESMaTt3
	SSE9HjdBCMPugA0+IawBIe1cCWdIslVAq2Cy0JIvXnPDfRAnrZA+BFt0V6ofrOv9
	KWQTycq8BCA3+lgal2ZyTMqGiFpp9l/MZxAHeMBrAEi49EcpKHYtzwsPBidhNINA
	hjee5/27iMy2qoxIbvWa6AHyIctnm0xUcyq4iIpkBcxFiHxKppwOZy0Bqzdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768412482; x=1768498882; bh=ouJ96yghZv8pbWBqDz0UHrpOByBNlJImpQc
	8Jyg58+Q=; b=jCs/KlEJFeC/8tBI/Sw/v7zGZSy/kaAbE26RVmUBhR/91pMD2CT
	ewTDJjLdOcm4Q8SFtE7WeC8Cwp5jqKOxTRR0W79cvzykmHm9GwngVdpyrSMlf1lB
	0Ok7kNmYqNPq1IFhABqTvVdXQrztvvgrUK2o9DgsWK2PgItcOKS8WUreY0kROcEJ
	RmiUmZMYwOufrukMf5N7ekEmxwEUdF1NdmLUBDDB4OPxCaPzVQXyaEPAUvF9+ktP
	TYGPOQnH3WoWd10tHU7occyON5UL9uQFV8ng+dNJane5sx+QOs8d+f71HG+Fk2K7
	7bQaUQymRMznFN8wgY9f39QXGjnMhZdiznQ==
X-ME-Sender: <xms:QtVnaR_gMy89sFpx0sC5Fe-pIfwwQHhaJOGW8eVx1CR5rJtL0fHZjw>
    <xme:QtVnaX9L1DGyaZHRDrga0hTrEfavcFrbaUG4vAvlvrSwi2L_OAsHlWfJRJQNgbarR
    53DzxdMZ1b59k6Lnmxp-2JHHwOKMSYLrocXTF12gt9ZXgt1ie65bQ>
X-ME-Received: <xmr:QtVnaRQbkJmSi3UryGeWK1v6jhTS8yoChk9404F94yHnimhRddrzO0tY8yHjGQa5KOzNdFxmxqpBrYD3jFb3REcUv9ai6dMrqubvENs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehrrhgrmhgvshhhsggrsghusehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghm
    rghrtghhiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:QtVnabftzrcyKgOPWHzoesrMKmUt1_4VtezOPOEOlLVU9GJCpwZQPA>
    <xmx:QtVnaVB1Fkt_wcQR7mkFNEq11ZuEvFBjYMc-3XDgj88ZnufM5T1_Sg>
    <xmx:QtVnadkyA_5a1Ic0Bt08xviAB0AS1zl0KRwvkyABjJBmU0U0TDIY7A>
    <xmx:QtVnaQf48Yh_UQitVjcMM9TDGA7XVOJ16YS4YexmftwlMjtXufAQIg>
    <xmx:QtVnaUc8cbYiORHTnh2IbOZO01U7ZwE-n6N14BMdQTVu542tymdRdRUy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 12:41:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>,  Lucas De Marchi
 <demarchi@kernel.org>
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
In-Reply-To: <613b47af-5269-44e3-87f5-d29fba9d73b3@nvidia.com> (Aaron
	Plattner's message of "Wed, 14 Jan 2026 08:33:43 -0800")
References: <20260113031929.3746753-1-aplattner@nvidia.com>
	<xmqqfr89lkve.fsf@gitster.g>
	<a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>
	<20260114022057.GA858110@coredump.intra.peff.net>
	<xmqqikd4gu7r.fsf@gitster.g>
	<613b47af-5269-44e3-87f5-d29fba9d73b3@nvidia.com>
Date: Wed, 14 Jan 2026 09:41:21 -0800
Message-ID: <xmqqcy3cf5xa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> Is it worth changing up the other cases of this pattern, mostly in 
> pack-refs-tests.sh? E.g.,
>
> 	# Create 15 loose references.
> 	printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
> 	git update-ref --stdin <stdin &&
>
> [...]
>
> 	# Create 99 packed refs. This should cause the heuristic
> 	# to require more than the minimum amount of loose refs.
> 	test_seq 99 |
> 	while read i
> 	do
> 		printf "create refs/heads/packed-%d HEAD\n" $i || return 1
> 	done >stdin &&
> 	git update-ref --stdin <stdin &&
>
> I can put together a patch for those.

I am fairly sure that these existing ones were written way before
the feature in test_seq to use the format parameter got popular.  A
separate patch to clean them up would be a good addition but of
course should be outside the current topic ;-)

Thanks.
