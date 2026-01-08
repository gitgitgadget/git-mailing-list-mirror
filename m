Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5664D2469
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876380; cv=none; b=PmCgSKb9YhouigBgIFre73tw9/mBUvAPRABp8cHuVBtjtZobBMp547peEtpiIO0kzSpq9XeL0AEFu14lsh+ZBcKkjcL9EKF32nuodazDHHx/MxGqIGnl3Ao+pVruegX6y8fr0pBogHoKhzuaxlGhXRAMqsQE5d8wJUT/cqOs9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876380; c=relaxed/simple;
	bh=qNcNgAO+7nchKJj6NOCwB7ljl85eGlsunhv0polYwco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDBLshiZeGvyKw9+ZdL8GfxuyRtT+jkBSM1iO9Fq+0iGT12lbBzGAwqcknanJp+NrjR/imvTFItRds9ZHOU4+n2fBYNyCyEiqzcIG/qI1cKAtFb2SZzi0IPCsA1y46L/4k5cw90sDPrfwRdOXc1Mb6Ey8MCZz2Z1U8d4TDalzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ni0EgaIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ucobCnY+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ni0EgaIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ucobCnY+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ACE031D000EA;
	Thu,  8 Jan 2026 07:46:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 07:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767876377; x=1767962777; bh=Pz2Ygrgty9
	csUtFjBh0gJP30JI1qvj5c7gPHbHzVMoY=; b=Ni0EgaIsjvBRu6DBVLvrLzSwTa
	9cKHxJvmkjZ/1uSh6EygsBu3r1INIMJ0dsii2trBCYZJHRqLuCZMyHaslumyb73F
	fSHQw/5EvmCeyfXquOlDo+T5EIDdYY43m0qhC+vxDtHN3n7Fn6rVaUM3H+e2RWjX
	SdH6D5wuRsArzwyUwzywU/so53ONYmGaTTvCYIYFNt9Us4+MUHiCzKQwgabvqkBv
	C46VQMxiEDKabQ0MEDylTyJETBeagnWy/2NNoVYulLvS83KxarDMNm2nSG6s6F58
	a8P+IoU5Vgy7UHgfeK8DLBoXZuufwjlqFUUNILkTmBsDa08lo2IG4uOnsMlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767876377; x=1767962777; bh=Pz2Ygrgty9csUtFjBh0gJP30JI1qvj5c7gP
	HbHzVMoY=; b=ucobCnY+hKqL55EYSmLlmTBvOyiOG1DRy144fRJNLoq1Wa/CWkX
	LPRM6ngOb6abj2gnwiKyw27Sm+Qsc3MhpDFvrkgvKvf0EiGn1vz9dD0huCja0s/R
	RXK+4XAeCYqO+KVlr19CYtct17WtPI59hhGNKKWXJ1QpbML1y8AB8mNcpG1OUmdR
	pEW6aptjBvMLhjSGjjY/GKlLNpuvYXHhlcVgzOeEdcE+wtf8s1pyjtr3a3B74TK6
	fDPju70JqYToxDv0uUn44GvR6qXQ8zz9Rz3IB5R7ofKMXFWtIVdmfaUwC+e9yMSB
	+ynOUZLYKU7o2Cto/psQVn01PDK5oNp/vqA==
X-ME-Sender: <xms:GadfaTbAfFU9LlEqbRNAVZp1O0Ne7pmCl8q0xIRvi_rdopL2UbWt8Q>
    <xme:GadfaWGcB3jpbWMXUbjeFSu7VV4ShjNh5L8itiuWDhggNYSGbCB9KOPNojyMk4fcV
    mcw_HLF0DIIPKk7WPhX2xpa86i81Iy-MrL09Lp9my0UwIdTIilpNw>
X-ME-Received: <xmr:GadfafwV7IGLc89NKfK6muuUrP4Jpf3EMXjEjK_av4VY51-zd0q_s74plLB3sKo7Sv79TV40zqntDIf8j5bkZJ5d65VazK679FxbWzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GadfaQk0gx2QCv4An-Qr0VRHZgUhbiadhHHNKU8MY6e0rZp_D9C22Q>
    <xmx:GadfaQkNX55sRfvVDCHkC2YYKwLTdA5OpOdrAA8DaGkVj45HXVp-Uw>
    <xmx:GadfaazBqjVjRxcU-vrRTIqq5dwncdR4depaVGbhxJIamtYCH59OIQ>
    <xmx:Gadfadp0TQT4tcVXquz-xCqe9mssI1A8ngABQFt3kLrUelDwpJoCEQ>
    <xmx:GadfadIG3z9ZvNR6usieSbN3WZr3tZstJHIArp4LWe3ps4_z5RLOMyor>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 07:46:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] t/unit-tests: update clar to 39f11fe
In-Reply-To: <20260107074000.GA102520@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 7 Jan 2026 02:40:00 -0500")
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
	<20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im>
	<CAOLa=ZQZnYVuK8mDi6Yb8_+hqw_TMugn6i7BJCj1gbNHOruNWA@mail.gmail.com>
	<aVzvDGVEI2qVJv2F@pks.im>
	<20260107074000.GA102520@coredump.intra.peff.net>
Date: Thu, 08 Jan 2026 21:46:15 +0900
Message-ID: <xmqqwm1sff1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> The alternative would be to make this `cl_fail(...)` instead, but to the
>> best of my knowledge this isn't even a valid construct.
>
> It is valid; that's how we define BUG(), for example.

Thanks.  I was wondering how that thing was working after seeing
Patrick's message ;-).

> There are other options like GNU's "## __VA_ARGS__", but I think eating
> the format argument with the "..." is the only portable way, at least
> for standard versions we'd support. I think C23 added __VA_OPT__.
>
> -Peff
