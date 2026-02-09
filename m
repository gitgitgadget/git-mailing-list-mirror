Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF9DDAB
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770595886; cv=none; b=VaxeDtgqui+nWWwqaFk/4obBGFa9y+vHVE46ZqwpCpNNvaXq6MrWywtMb26A2XdwYUhnTISyarbYFmhswpaI3Cw+nD01bxeLdTlzFXiMxk0WEyoc3Vmx5vYFMvH3N7sfuDj2XMGaKuU9ktCBpDDMk+8JI22W0jG1/nNAINiwGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770595886; c=relaxed/simple;
	bh=PQqzUE5/strye965UuDNEaoYQCca1BMRRFQ71cafpAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PkQsn6uVpjkHK5D0jvGzKkNeH7EMjvpK3aui257e8SiU9/vv/Hkp17biv0OgkiSXglx9XEnKBM48OBv5rM7Who8u+50iSf+k5ZrjGHeuVpNa+K5FDxjIFd0h29Gqj4NRJw/xzKgQAgaQipGdPjdbtlmi/5YlDFsbS19uQmRkD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GMwhJzbm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwqgLcaf; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMwhJzbm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwqgLcaf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5311B7A00D8;
	Sun,  8 Feb 2026 19:11:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 08 Feb 2026 19:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770595885; x=1770682285; bh=hWhnPCT2LU
	fA4MM2S5a29zGUsI/sE4+01owmUAEccdU=; b=GMwhJzbmNXcMZUyT5s/2fVBexV
	Uw2eq7uk2zxsDfg3UayLcyRitYX4O1C0Qb0YtNKGEJyCxX/ZBXqizZ3flITES8Tu
	77CERS1OS9hhzNdn2z1RRBvQRCBvB4QTnquQXJrg6bXv4IWhUcuiFrOiBD/aJxyh
	jLFjvyhHejpz6hnbF+FSvOtF9If5SE5rLegXtQBpfMjXnm4cquWBj3vFA6ZRYM2Y
	Hq+HD/MBLsIrKBzAhQPIzc8hSrrK6Js8ntA7dVjNjidWG5uznvaksB6XcQj2VhYS
	r1eKBQGOeIhXKn8QTxvh+yS6W/4WG7wwYOeOZkrbw6D6xs5gTbMDA7oZKDcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770595885; x=1770682285; bh=hWhnPCT2LUfA4MM2S5a29zGUsI/sE4+01ow
	mUAEccdU=; b=UwqgLcafNLREK0BAQEcHF9QfxijcA69uYj0OJiv8fHlX6o5Y7Lk
	7AT91MNvaIpHI15guqXllqkz0xh+vCeQAls9sZMpIJdUW11RVsvWXhQxyX+xtMut
	mhUvbNN7IsIzGWkc8JstE+LSrmofvXokXz8pkEudz142Y8tYZRsDtPUVwjRHP5Rv
	U16wMV0P/GrXe1uRHOGBM0+cTCsLn8/4kL7rvMOHRj7wwC4cbs+evBYYCmaLCkKv
	CdA67lRPDZVr/X7oNcfgpeqqR5Oxodm9gNIB6RLS9GbmwLE4ZZ1/2iMWr8frO/qP
	iM08VkUpY+/2WMdfrrMKOYBYDDzNpvfJxjA==
X-ME-Sender: <xms:LCaJacbjxz4gJx3WB8pqlAYPn3NTLd52_mTUma9J_r-yskcTZn9nIQ>
    <xme:LCaJaZ-_-zLCSCeXCQt3rKWzrdq4UQScLnQX5Kz32oT8cpm2t3GaguBaw_QAUTdmy
    1oLMELstCA5PxQlpfMTehXKxV4cS1Zv4tWT-Ymuk_K4DaprBIuXcw>
X-ME-Received: <xmr:LCaJaalFC_MR92-j5hX-2xGoqLAwpqp4YmdgEZegfu4YoF_tZyXwfUINY-ZFYmJaisdtsDeUo6XlG447bAQjVFR2yPbRihlLOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegsfihilhhlihgrmhhsrd
    gvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopegtlhgruhhsrdhstghhnhgvihguvghrse
    gvfhhitghouggvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LSaJaWw0u2_kQgly6tsBacMNu2V-v9y29A7Yn1bQ1TH8ecCli5L14w>
    <xmx:LSaJac6J3kB67jeNmrnOjOkKaXn_JHc35xlT5WpcCciGP-bAwxFCyg>
    <xmx:LSaJaeV2GU5_zDD2HggV5eKvC65NCLGyXgZByAi1sGvpkTL2a4lZjw>
    <xmx:LSaJacJZzBvDe7M-hsy9SbF7uYHe4jWcmuHg3XyY-RN9i3MQF8wcyg>
    <xmx:LSaJaZiFBvF7rWSfm6Ua7c1yS2h5ntvYVe1gn8rRddWVsqC6NPHv8am3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 19:11:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Brandon Williams <bwilliams.eng@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Claus Schneider
 <claus.schneider@eficode.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 1/5] read-cache: update add_files_to_cache take param
 ignored_too
In-Reply-To: <69e0065b1bfe469c25f023592a5a6600d49348dc.1770384180.git.gitgitgadget@gmail.com>
	(Claus Schneider via GitGitGadget's message of "Fri, 06 Feb 2026
	13:22:56 +0000")
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
	<69e0065b1bfe469c25f023592a5a6600d49348dc.1770384180.git.gitgitgadget@gmail.com>
Date: Sun, 08 Feb 2026 16:11:23 -0800
Message-ID: <xmqq7bsm93o4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
>
> The ignored_too parameter is added to the function
> add_files_to_cache for usage of explicit updating the index for the updated
> submodule using the explicit patchspec to the submodule.
>
> Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>

Not about the patch at all, and not a complaint at all, but an
observation.

Your sign-off is given without a space before "(EFicode)" here,
while the previous iteration has a space there.  It seems that your
author identity has been without the space, so this change makes it
consistent between the two.
