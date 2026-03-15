Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15202366059
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608209; cv=none; b=QLTE6N+Jy4YhaP0SLIYF8JhIxsoUVqRD7z5kJ0YBQ9V7NyrBx+HD7H9hdLvW4KyFlHuL/rxa3FfR3/8UIuQV68S9obaDq6/hBDpMxL5A3U3p9mULOygIn75fbJ8RX4D91p23eaNYTLdfUyIG6ANLAImW5D5V81gmljXuKXFjdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608209; c=relaxed/simple;
	bh=BwmSm9aGmYA4CrB+xWuPA6SIkY24XcLBrEOHH3+vxp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9LrX/KkOyOAlYzsFi9WHO61MRu/aJj8ct4rsNlAMV2nbaJ2ATJlaUbl6s76qs8E5oOT6u4WM/0VgrxzwAfyt4WHIDxLQnjRhy9h3fgSCJURMfSpOkWxZJpmZDn5embYxHeUQaZdEkyEq41NDgvh8o5Xh7AxqTVwThzj8kR9gv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CnwMgZNM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BS7aDetw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CnwMgZNM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BS7aDetw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B26614001D5;
	Sun, 15 Mar 2026 16:56:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 15 Mar 2026 16:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773608206; x=1773694606; bh=wfrssLOYm9
	TkXxBxp7HkdHCoPBlZmwlAq38FirWutmQ=; b=CnwMgZNMFyPQhCuibRa9sQGyH/
	qVDncahtWlaf7SC27+Mc3tAcFZLu7IXYtPmOjv7heT+wJO7Lp10YACiFcpAxwoYw
	k48RntLp7+OrFL95gRasmpXH5jpiI2ue1fGijonYp35pqGTI10wp08ghKmG58eXn
	5scncYubSU8DIXhAq+7sdMR0xs84hbEepSNT1Szvv8y8jMWg+cpS2A6FJnOPFsXu
	dhSeu+RmH4eL5wgg6SbAZHrQ5QmHCQGRKsgCltMlYSwWhcmtV7brdRizz54TACNF
	Fpd8wHxWg7KpsIEX7POg3qELaI3uMMJK7x7Z1nge0d/uFb8yxIgCly1C1usw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773608206; x=1773694606; bh=wfrssLOYm9TkXxBxp7HkdHCoPBlZmwlAq38
	FirWutmQ=; b=BS7aDetw3HRcWv86S8vxCcZ9SNOTtVQDSpsHwhibc6wRbR8i/x6
	ZxrWjGev86L8/y4R283l8DlLiztlBFnuY1fU5mLLdwlj8QrtOMYGjNsWPzeZsvrL
	xdQ5TRdCE5Wj+2M6B8+kaTvoW0hKCzCcax0aeSGwXSdJ69k2kJ8ULqj95VppXtd2
	VLIqW6ACz6UEV4+XBDDMvLhY7/eh3m4EO8zSWtIC4kGcwx9RPD/s2MsBrWw1IE1T
	VRirRmfkZqbAoRwDPTnzvLZ4oDNr847RLyTAlKRRfAYqUABwibRALU6kEg0n/Gt6
	e/pyVZu6oYT8yG2uAa0gKKeTkIsHg/3+CAw==
X-ME-Sender: <xms:Dh23aQ5teX5cVjeTd_QrwA5ovaF4m7zmO7tuUDTF5IAKg83LWGrjlQ>
    <xme:Dh23aUfjSdH3fKLfIXoIp7h7t6LbSQzJr56zfHv4MLeyDCSbaEUKdg2SGTKLQPjD3
    aH83xKvAkP0UtWnVzY2tHE9X-cdleay4Vhjc1zSxISwFiy12Enf8A>
X-ME-Received: <xmr:Dh23aTFkOR0dipNdyqe_BZjRT0Zl7L2aqV1XbtBR-IYaqipoQNYLs9MPRf5cHoKejufFQmzaNogGHdwYiFMx1SZ91h0SXzjXmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Dh23aVRkLOrAafYesHtSY9Foutqoh0m4OSDiOmpScoMxylG1GGQJdw>
    <xmx:Dh23aZZf-m2ZZRfdN56feYM4cPGrzF1df93AKVwxR97ajpwvyyzDUA>
    <xmx:Dh23aQ0tZQkf27UG4qjsqNDv3lZAWuedPU5GAzr5rrjS2KSM9Ka2oA>
    <xmx:Dh23acrYkH06fwYEV9yuMFh-nFqLIglWKFL4DMO-Z27azJdD8qVoDA>
    <xmx:Dh23aVU2MsxUvWhyRqJje0FWcNIpDf2WZXPGf_frj8Ie-UHVwhJEpkco>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 16:56:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 5/9] hook: mark non-parallelizable hooks
In-Reply-To: <20260309133739.294555-6-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:35 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-6-adrian.ratiu@collabora.com>
Date: Sun, 15 Mar 2026 13:56:44 -0700
Message-ID: <xmqqcy14stf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

>  hook.jobs::
>  	Specifies how many hooks can be run simultaneously during parallelized
>  	hook execution. If unspecified, defaults to 1 (serial execution).
> +	Some hooks always run sequentially regardless of this setting because
> +	git knows they cannot safely be parallelized: `applypatch-msg`,
> +	`pre-commit`, `prepare-commit-msg`, `commit-msg`, `post-commit`,
> +	`post-checkout`, and `push-to-checkout`.

If there is a simple rule that can be used to decide hooks with what
characteristics can and cannot be run in parallel, near the "because
git knows" sentence is where we want to write it down.  It would
help new developers decide if their newly invented hook should be
forced serial execution.

For example, applypatch-msg is given a file and is allowed to modify
the file (perhaps reformat or typofix), so two of them competing to
edit that single file would be a nonsense.  Letting them edit the
file one after the other would make much more sense.  So one of the
rules may be "a hook that is given a file and expected to edit it".
other two hooks with -msg suffix may fall into the same category.
What are the rules behind the decision for others?  Are they also
explained with simple rules?

