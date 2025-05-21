Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E7F1F12FC
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839343; cv=none; b=B0BJ+w/xSAF7FSlDwrSHrZSoiA05b5Aq6qXtaE8bqdqba1JcYW+f+ytcNjrIC6AwdSTww2i4l3OeuIPmW8OLSTmmzbM38019aXRwHrawB2Be+WmQhcCBoF9a2PFpiUDbpn1B806H/37DkUjBYodHIfh+hyhD6bUFAX5eq7G8HMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839343; c=relaxed/simple;
	bh=71NTUpM9xUkiT56Fo4q6JRemsDrrY7LcXOrxcJOUayg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXTFmB1DKueHRa7jNY5C9pG7CwX2ItOGyA6S8X6tfw+oIlkwfo4K8+Eux5LjWG5qBFC5g26pZ1dnP2kSmkH7Bm8KXi3doumfsOZAwnmGADSuoQXAKpmYsn0ABGMBGd5nt//xod4cVuR/uVaCzpuTuH/fvbkXKoUkV35MsOlbqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J3YJbgkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJPEhdZM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J3YJbgkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJPEhdZM"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C18F1140158;
	Wed, 21 May 2025 10:55:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 10:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747839338; x=1747925738; bh=sbz2sJH9M0
	aqGf+47fT7XAaFsOPBtKwU5SWRWBdDvw8=; b=J3YJbgkIvnwOxY3F/UTxV5+otX
	8cX3HENFdV6S4NelJ9KO6NaZU6Y4lD7I3fQH52ZIIqzWL1HFBTuOQqIiYQzGsGh/
	+SdU+CA4MsFANj7F47xYm7USzvMsxybRRVvCONe3oS/eVW7LfDhtpnEuEWSSG1iP
	higtFHntyuIm5Rp7UIkiLzYuJ1u6UAN/mymNzeigvoWzlbajM0y3+QzCHsLOF2e3
	KCTHBCmeXDfg7cIxXn++oukeJ0GfdWKul2cJco6EBlKdpzhOL6Gaw/wzoydnGzTH
	wASxexChSo8RulBK2gl5G5gJ1rFYslSz8Pu4lSnLyjz++qjevS1UxxorMNtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747839338; x=1747925738; bh=sbz2sJH9M0aqGf+47fT7XAaFsOPBtKwU5SW
	RWBdDvw8=; b=SJPEhdZMm2iPoKE9144BSpQmNarGt4vTHR5c0Tws9DWPmnIAuef
	CDHh42EXpRXI2Mg02aZq0i79CKGgXBtXOIwdCHZWMo80eQ16ppKJkqRL8ScEM2RO
	y8Iyyu5oA4oEf0arkExfOXIIdAFjY+tKGRmXbKFJQVH6p3K9ufELol/vW1U+BeyR
	38r/D54NQa7X2bqGGIMv22GDOLuhzELkcggcFvPKTj5AKPL308sFPBNuJs1UH4Ut
	kFz6ZmM9paFxatgb8a8plpYa9nsmeHJt89w6Vk8kkfU5KjAlg+HsMjYAiY2KWYYN
	ZFS5EB9X4HB1Kf911As+PUS97eh2RJOXnzg==
X-ME-Sender: <xms:auktaD3muKJfS618pdZLAxqB0wITcHWqDdi3QDlRgwBVlCI39lVHOw>
    <xme:auktaCHyxtVbI2-4vMzsbRg-gcrfpXd7cJFNCWvjLH8qNlVKJeNsgC_Pp3BYK-ivQ
    0eZt5bDlbIfIvU0fQ>
X-ME-Received: <xmr:auktaD4WC4-7MI54jZl5U0QzfeYnrPIZIbN__5oO6zQRLWZkn65uhBck4gkMt26t7zOEQXMfJF1KjqR16hN67B3YuMRz-fbusoINnDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:auktaI2Yv2f9mLlyI26a2YH-QOcWqSobopAGCV0WdYzxFbb4ZEY8hg>
    <xmx:auktaGFm4nOogo2lwKPrFu2yX-rcqhtGIWYAANt8MJxFiAnFBf09yQ>
    <xmx:auktaJ9Zs78UruTuc9Mk5xyamb3NhLv6lw8j9wFuPOwHxAWMlPD4Mw>
    <xmx:auktaDmUE7UiUWAh31WgIF2jn0nCVsK3hGTM-FSGz_hzTBkU4va7aA>
    <xmx:auktaBzxKM60x1Gld9-rvthuVGuzbGwmZH7dotU0raha60Zyl-AY7VCb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 10:55:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2025, #06; Tue, 20)
In-Reply-To: <CAOLa=ZR-OaLPueyRcXYrN0rKPnVXPPmJ6drsmM4eRs-6yKEgQQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 21 May 2025 05:10:24 -0500")
References: <xmqqy0uqg4w6.fsf@gitster.g>
	<CAOLa=ZR-OaLPueyRcXYrN0rKPnVXPPmJ6drsmM4eRs-6yKEgQQ@mail.gmail.com>
Date: Wed, 21 May 2025 07:55:37 -0700
Message-ID: <xmqqtt5ec8t2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>  Will merge to 'next'?
>>  source: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
>
> Incase you missed the cover letter: I would say that while this can be
> merged to 'next', we should delay the merge to 'master' for after the
> 2.50 release since it can be disruptive. Mostly letting it bake for a
> longer time before hitting a major release.

What are the things you are so unsure about and guinea pigs who use
'next' as their daily driver should watch out for?
