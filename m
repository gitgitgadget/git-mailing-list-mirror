Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC032ED164
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737735; cv=none; b=iozuAoHeveCn0JJ6+Kze5T2ZvxRmhgYXSLKPPJGKsKuDFqTY2nLRkynprrtn9vLcyDw2pZ0vPKXqG4/TX+ztQ3dPEXYuvXc4Jb7ITW0kgw/3Leg3/SrHF2C6A3PTM9nWW1MWQl/TdrGM43x0JtoCAVb3FY1uJ+0Mj3j4M/V3k74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737735; c=relaxed/simple;
	bh=ykxvRLIrSR7OKwAvujGn0aj2nq0bS3cesRLYAC1ng3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DRQOfZPAWKQnoQtkIhNTBJv5ea+ZrJQYTv5cwDSSW8J+iNGCaH3LzB4fcbLU32JWXq9rNeNHVeES9sSGxmQxAwrKpJciiKg+Nm1ai98bexuLkemlUiP3DvyoMjJNaX7ybdPoM/KlsvgYwqD06wPA3Rkuc5wPKF5v+8D7YJ+sVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UsIImZY+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NfGpGEMP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsIImZY+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfGpGEMP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 39B9FEC04DC;
	Tue, 10 Feb 2026 10:35:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 10:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770737733; x=1770824133; bh=Z5F87lLdPn
	Ejp7foc9zIfSVw1tVBsvYhsIeQhicsPHw=; b=UsIImZY+NjJef9Se8cp+ZDnuPC
	Po5eQbnBvg9M8G2wEg7p5ZnwIZzAZ+fiZ8Ec5Rq3u4+ri2dzXgoGr7gRbqB9OGBU
	aGEOFIAsxOvWZFfFeQ8X7LoppFDBs+9pX/BlDBoKDyyBDRrZBowFTfhOXSpDxB7W
	m8THdQo+0RHGkW1IvQJEtzatZcAuOup0+hqg4dn21ZbSpidcrmZwZ1Mx0zst/Iy7
	yU9MBIKHDw+CDIgW1MGNMDRANOf4dyyKU1yQRfcIwknPc7heWc3p2iHlVj0Dd6Kh
	o0YC3UsG5+l0dxKtxjZ7zIbTUVExHzZMAk3y+kwrcOB4rtZHkkfBhceJaitg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770737733; x=1770824133; bh=Z5F87lLdPnEjp7foc9zIfSVw1tVBsvYhsIe
	QhicsPHw=; b=NfGpGEMPb9kk0wXtt0/OFXpv6DD+RskAtN3OCcX/D3g8z2fMvmr
	6xy7piiNFwaANukrKFFQ11RJE4oNMuuVN3V0jNkORxujK85AOPaslHdtQypy4+JJ
	VX2PM6Wp2u5+V0n9KxUqO8JM3dWbnnzFlskVSMN/Brygy84u//BuHcGkNKSGErqk
	Rjb3/JN3E0REoXOdUqrCGLdXTCTf0YRiTh7hE69NuUCuUjTE/bVtQ2641FIOdlVt
	pPfBICuZrOyyX4K3gLYoTfe9AbVqiQyiDVGwfOTfw7vf/l/deZjH/TN5e5sErnbX
	wObEaVdon+j4upd+etLM6AgabB4zLUJoDhQ==
X-ME-Sender: <xms:RVCLaVaIqzIDxv6oGExfk2BTKARVpqaStoYjxYjW61dCNRNoHMuI5A>
    <xme:RVCLaTQ3-w2GFKVsu3fjFrkAIUizDdgnP25loH6BwsZsCPG2UmcvGiwFciEBIWdyI
    Cegz4KcDsNr8wJsDzyDTtOyqaSVE_a__ztzzDQnX8Oie9r2IBx7HCQ>
X-ME-Received: <xmr:RVCLaQTMkUY4QOfwOZ_2Epy3Ysp8HiVZhx5mWOAnmCIUOMIx9mTGjGCF22W77tRYh49aWVnxwfJehMd2O3zUP0VcCI8lIC6hDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RVCLafSfsBo-KYV3d0Vb4Bbk8hjyQ8OUSxCH5tIe9M1QNoiHrbojhA>
    <xmx:RVCLad4P704TkHz_GknpPV-fOEcvQLPajQkrh9nJW_zcViDyqzXKsA>
    <xmx:RVCLaT2Pr4zPFmjsPHdN8LXdSa60Z7_EuMz9Feeg2esWJBV55LRhnw>
    <xmx:RVCLaQAT5un26JuITan7XktHXfSrUvucAbbM-NYolKQ9HxuqD93gKA>
    <xmx:RVCLaatir37cVtaRsBjpUwu33PYP4l10USFnZavScjVrnVfNWHnnaQ3q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 10:35:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/4] refs: allow setting the reference directory
In-Reply-To: <CAOLa=ZRPLB-jLJ=4cdtO0DuDD=+tPp7t-Kei5pMsF0en6i2jJg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 10 Feb 2026 05:02:49 -0800")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
	<xmqqtsvp4wxv.fsf@gitster.g>
	<CAOLa=ZRPLB-jLJ=4cdtO0DuDD=+tPp7t-Kei5pMsF0en6i2jJg@mail.gmail.com>
Date: Tue, 10 Feb 2026 07:35:31 -0800
Message-ID: <xmqqbjhw1uik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
...
>> Replaced.  Hopefully this is now ready for 'next'?
>>
>> Thanks.
>
> Hello Junio, I don't think so, I think we still need to address few
> things as per the latest review. So let's hold off on it.

Thnaks, will do.
