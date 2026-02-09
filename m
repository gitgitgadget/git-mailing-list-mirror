Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EB3EBF0E
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770595891; cv=none; b=UJ0ufYEMrPLV9JW35XvWC2osVT2NZagVq5y08GTushirk8m+IFTTxnN+0ye5CtFXOeTGFo0zJtSjnIl7i4MtFbPezNENtyel9Jxdn/hbiFhLkI06tc3o89UkUTaX4ts4BdVIGiBNPydSZOgkmhXl3bcqmk4ojYnXnwNIVvwQS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770595891; c=relaxed/simple;
	bh=PQqzUE5/strye965UuDNEaoYQCca1BMRRFQ71cafpAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gu5XuYh4EE/avY2y/NWIWp6nrxBbI5sMV/DwlRC+DP0leh1Ezg/+9suYchzwg6GZJWOmxC8I+wM4kICjCHz4WqpITQukYZMFC5ZXsU0eXipKLBCDHANq0E+3LcxaQ1JG0sFoNq7Q2vkAhDJpNyLsp6nmGW6DYavMNEsW3J2vgxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i12tIIdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wq/f651+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i12tIIdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wq/f651+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 900CE1D00066;
	Sun,  8 Feb 2026 19:11:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 08 Feb 2026 19:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770595890; x=1770682290; bh=hWhnPCT2LU
	fA4MM2S5a29zGUsI/sE4+01owmUAEccdU=; b=i12tIIdQCexkUKIJNycnOzjm7F
	6P3qcsISFQEqtsLev89UyjSZTZPhNLeBPIdeqWjTtHL05ZFf6GmCpvui2gYAcsda
	8yL1+OEtwoozDcHz1QK4pZ+B2t7ULeosuF6uBwAryX+DHJ5h9v1hFZKZxnXT9/fY
	f4WoKuGOVbWvNicUdT98ZedS4wPGbo9dCph1lN1dtlH1tsxSflj5Bl5Xha1vbUky
	KFUROnqBSv+wBtjOQHrCA0UBGNRBjTcj4Bv/XIWKuVwXhnt8RrGJk5t62B9GsynH
	cEsHdp812XlQzX1pTFY0zmTxldmPnOJ4+IDsIvd2JYGp5CPjydh7Vx4dCAbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770595890; x=1770682290; bh=hWhnPCT2LUfA4MM2S5a29zGUsI/sE4+01ow
	mUAEccdU=; b=wq/f651+xYHW65jyDcxxwUdFpStS37EIUFYC6VEgOOjLGecJRsF
	aZ70DXr0rkmDREW4xMG5jHaItPjQXnrfJGK8zGgZyyAGSQKE96ayyfO3latvGktr
	6BTjvCDvYCM5uep7q3nFWAbx3o/969OiYHD6ANJyWa80HRezrrdD95A+bQKT5Bxi
	/XHjwvTIHlfj19Xc1RCBLCNg4wZS70xaCN+oobyL81ydC5kJIp8axq4ue/PkJYQF
	W7kdumBVvkLK2QbcNfNwfkyuqSVA6XY6L5GncAY6lwPMvz/8bUdg0iiWuZ1bnzmL
	LfHa2OQjUq5IY6w2js07Dh36lQsCBzxpOGQ==
X-ME-Sender: <xms:MiaJadLWInsIjTVCukYKhqgxLDcOn98wsWmrjIBnNAMYFB1HFEhI3A>
    <xme:MiaJabsDIhOhjzeNLhrSQ6F6II7sEFUbaor9AgvxoUBAf9qRN-7EoK3hrZv8jP35o
    LhJY3DWiRVVVN5ZyuCVDpGDHA7J7e2UcO5lbFs-z1I4xXBvmfj4zQ>
X-ME-Received: <xmr:MiaJaZVtV9Z8j92oXft2OWr8O32c_SDprDQWsHk2UFP4fiyvEfeag-JR5fw9HQP230ghUDMche7id_owNv5GsKYat2Hug_AiOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefg
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegsfihilhhlihgrmhhsrd
    gvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopegtlhgruhhsrdhstghhnhgvihguvghrse
    gvfhhitghouggvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MiaJaeg7lhgjAoDnCISql2_fwzNWydCn1ChLWmI37QxxxkqmA-A21A>
    <xmx:MiaJaZohKl0AfhVgiyPlUN1xWfRWNJi2yUYG0JV-Ms62R7DrBsYxwg>
    <xmx:MiaJacFguhw0J29Rwj3gtSEe8L-0ZGlsTvhDYxjnaTpOlS_1EIaLUg>
    <xmx:MiaJaW6UOwc5c6SEKiZwhdn_mP0VMRRjji3Z3OYTKcEqxO1N0L4MOQ>
    <xmx:MiaJafgJRzJMlOu-8rfSWa8p-y7FeRh3V5y2UTHTAL4XE2khOFnK3mnr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 19:11:29 -0500 (EST)
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
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 08 Feb 2026 16:11:28 -0800
Message-ID: <xmqq5x8693nz.fsf@gitster.g>
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
