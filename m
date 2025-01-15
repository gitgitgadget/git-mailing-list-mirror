Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E614A630
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963274; cv=none; b=igx3GBdRRqrnwHnSFFInCYXHjId4jcpFTv+NmzuA25aiS7RWVitp/BfjimIkge92BP6FgxLvOjW2PSUMzBgsPmwFL/QJoy9pLqYPx9EzPF5WQRjrXtS2ebgo/bOfbX4qPoOmirqzuKh85RveMdUUI202VjrJR3wKYwJ+UP7Vyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963274; c=relaxed/simple;
	bh=imxnw9azdHkW61HaG+wp2HUasqnoUvVNcdUcTAM6hT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ry039uPs5K2w32YvALivCnkACaAt5XF7ENX7emr0TQRLdxM689uH7wSzsvfcWoAxl7cViwqZByVGwRAdDp7//eC1VpxHVU43c4veDXBNiNYOLUZGPFa0Bwzb/IneCMr0FuQt6JXevoKNJz6PG+9LwEre7JzbK2kU3PLVX2VwcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3ivr/mbW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSbAJBnt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3ivr/mbW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSbAJBnt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90C0A25401C6;
	Wed, 15 Jan 2025 12:47:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 12:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736963271; x=1737049671; bh=SMWhW8Uxrb
	hf440oGggEj6SpBDHT2fJErvQ3GJigT0Y=; b=3ivr/mbWDM46lnLAPWj+i7qa7X
	kvjAQrOA2EBe20M27AQ97RfBPEiDmDvIqRiYGvitpQne6cp5To6VIuIeJNircz+y
	9Km1c3VvAXu91af+QZ9i1jKWpc9iwEkVEfIRIMZJQRzuBpNlU7S8zvzOX4qEUxp5
	tURJ/4+7qckt+TYxMw0o1VxHA26gjgnsuV16kSRvlSRbMKKoIGZ9G3W57kDKYxn/
	oZqXwuz0rWZOPPSHIpM1TuQjLQSDLxsT+zuk2dLQvTQytSYpTbFieIbeiVeJkOnZ
	6+F/T+DNGMhEUD9xvsIbEApUrZjGF7pdPg1m14v7tm4V2kZW6cnZNqaQKE5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736963271; x=1737049671; bh=SMWhW8Uxrbhf440oGggEj6SpBDHT2fJErvQ
	3GJigT0Y=; b=gSbAJBnt8kq8ZX0NVq2jhgg+QqAvlTa0nGjRmOtiKhkE1fkF4PK
	y5c9Sk6CT3FEoZkEbKbpfFoTrKuUrCsheKMqstTqLS8zKYHCqTUefMJPb6j8G9c6
	BbqWTqT5+W6MT7wzdfCNJ4lFs/ABkhWuAlq+eU6EqG313c9DWhPRteVztWzOiGoi
	dSxhKxZ3WwztZXXmACELgb3KH3T15IzfWc3P45guK2wP60nsgoJqqZXYdoInnUdu
	WLtY3enEkRzmKGMkoNBtclebKqCgy6PpXRDuOAgcRQ7o2tG2pHfFoYmf64w5Asz4
	8DPRheg2sG4VChUPzA/Qp/5QLNIeaRfmJ3g==
X-ME-Sender: <xms:x_SHZ5PtOGzEXHpk8SzdQ45XPQN_3k79kO1WNb7YsuFOLEadzLh-tQ>
    <xme:x_SHZ79VKf8Ujgz5yqA0x8hUB9T_r1FBMrc4dQ4JaHG6GafRDSPsiwVD33z7B45lw
    wjzuMm_ZXVGdqPauQ>
X-ME-Received: <xmr:x_SHZ4R0F229j-oWhD0Mri0R8reFJnOdK-CvjcE2ZDqe3eOQfPkMpFol53abcueyMhEy3bjBjo1kJtcZ6ML-pbgBzCjnJjgyQl7Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgtvghp
    lhestggvphhlrdgvuhdprhgtphhtthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmh
    huvghnshhtvghrrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x_SHZ1ugPqy12xyubgLuLnJvdldtwRngsVAydYBBnI4vdCy_fAutXw>
    <xmx:x_SHZxfN45TPR2NZ7hUoBzeoMdZPEsIWmQXgdt6Yt-BZU2izqFTQbw>
    <xmx:x_SHZx2ZW5OALKVhG0_yzDTzflWrvILVfSxaZTe6O1JhGQwumRKL_Q>
    <xmx:x_SHZ9_Q6chhvtS92ZHs4A40T0Qe_vcSB2D3VKA56JIz8cSvcCU7tw>
    <xmx:x_SHZ5TdWF5vPtXHqr0m7iY80lbMYM183t-NRFP7LW1RZu4xq6S2TLq->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 12:47:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>,  "Jonas Konrad"
 <jonas.konrad@uni-muenster.de>,  git@vger.kernel.org,  "Jeff King"
 <peff@peff.net>
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <0cf0b268-c691-4fed-a58b-ea9f77eab295@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 15 Jan 2025 18:39:45 +0100")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<xmqq34hkyoys.fsf@gitster.g>
	<0cf0b268-c691-4fed-a58b-ea9f77eab295@app.fastmail.com>
Date: Wed, 15 Jan 2025 09:47:49 -0800
Message-ID: <xmqqy0zcx92y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Trying a random command with usage-on-error:
>
>     $ git-upload-pack >/dev/null
>     usage: [snip]
>
> Does give usage on stderr.

Good; that is what we want to see.  Thanks.
