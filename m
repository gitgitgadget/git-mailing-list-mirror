Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947181537C6
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939489; cv=none; b=tAYj204sPoVGk4HYVAwllJcHz0mpRAfIopo/l/6Lvo5fO/kMYj9XxW7HsMdCqO06IlE6w8xL8dV5IBoM+W5eYEZLbwjB68MP3mfzK46M8rKvTDiua9i9A0t2XkAK+Q6eardBdLL5fbFO24iU4xSVx7/qPKoZmqOq8Tcj1rEX4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939489; c=relaxed/simple;
	bh=3jYS1qZQi72/WRGrLueyhisDMbR98RA0jQC7e0SnWvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKnyXZCcj5KXiReT88qoTxUDKGjDn/A+SxDbBbCkmxSyqvY8u07+UfuLr0Ndu1xxh479RLyKm5dUT9T/bhKh9dhPOWkMKq5bLi9fTbd5usQe05JR1Esh6Dx62VC9yNFlFKIeRuNsGpZlBV9IE562N5BsrzYNMdSXnnqo5UkOudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dnK4AZ2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5kjVmd7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dnK4AZ2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5kjVmd7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AC3F2540141;
	Thu, 22 May 2025 14:44:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 22 May 2025 14:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747939486; x=1748025886; bh=LXXyc4pgWH
	T58x3vFunpJgARlCedABEhHFAgdBQTVUc=; b=dnK4AZ2p6QEJ7RssYvh5iRgchE
	/n1KMa2kGTgcEzPQI+tkjd/awUOov8hZo+v5YJypOrkIUL/nYm/ItABMNScfauwf
	Sxu0flRQJIe07tCneov4s8wON7D+UcSwC4Iv3ndw+YJEMrc0AM/Gh4Ie+pB1BNEQ
	y4MYxh4MzFrb6ogFZ88IEWjlMZGfJjLB7GipvTP6wSGs57Qn6ExucUdQMmGfZ0L1
	F7cExDlgdHDG8bv7AZxbXetbTTziNr1HKK6U/sBirbW5t4NhISeVfmRkJ286BEL6
	25VBxhBYOX9mtpnSpJPJZLSD/XEvoNBMSFntpREuXqyqlwpLL52NmsQGxzSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747939486; x=1748025886; bh=LXXyc4pgWHT58x3vFunpJgARlCedABEhHFA
	gdBQTVUc=; b=K5kjVmd7k892EzQc8W92ibDj+/vtaIo75Fi0lHn9fwAVlyPSe+L
	+C1Buo1v4CPIlUoT2BB2jiEFWT9kV7jc+Dnphyggg1QkWNh3AVfCYw3260/nqKRE
	i6HNRmNsYdoSlw6ZogTPlRaKupbducFpwJWHk28oNukREFHKv/XY0WyUrHYUq2ZN
	l4HK+xyCpFXtQBt9lhZ776tdFz9GzgNcp4kLgjKXCs8UWx4qexAiy17YeJGyfXrj
	6kgLFvQhSOAOP0rZo1xOQxIOBqrHJjRqBe11voh0b2IxZ5lBZsJYuI4ufrqsILwS
	RUr1m3E2Jmb1/4XM0AYZ1EBwdnjo06YKiuQ==
X-ME-Sender: <xms:nnAvaEHzdSddNUfec0yhuHCIET9puE0xrtaIPdKU29x1zvIa_Vz1qQ>
    <xme:nnAvaNUUp6vlVZI5qf-aS4mplLE6e6FLx2N7qrMQKv9HMh8bPhalPnyTp3rD0APNt
    mn6pOl6a2u85x9GGA>
X-ME-Received: <xmr:nnAvaOKUlxQJSdTKNR4ifTkQKJgon82m-urRI8PpF8jjBiHTJxbk1grh5Hu7WaRuFtpya9FimZmc1fVaxQEro7ESF2NAAXRSHKkHa88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeijedvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:nnAvaGHciHWPxZF4sNetSq8KqqBKSxGq-0HnDL4rKhN-2bT8fBJVdg>
    <xmx:nnAvaKW_9ISU7qdTqTXIhJLvzom9h7NxA-vjsoFZ9voqdoh4BKGxdA>
    <xmx:nnAvaJNzZsOw5FqJTKkHFB1CtuhweZL6RK3GemB2Ig7ahy2w0hcYig>
    <xmx:nnAvaB3ZlrYhFXm3kKTMCSeM2PIflrhYU85BgdDThluMTaw8oFnJtA>
    <xmx:nnAvaGksqV0ZLIwGxKbaomOLiKszURHQEpvU9rTs_axhnMWwxSC5s2h9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 14:44:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
In-Reply-To: <20250522165924.GA1613@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 22 May 2025 12:59:24 -0400")
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
	<20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
	<20250522053235.GB1134267@coredump.intra.peff.net>
	<xmqqbjrk7ikx.fsf@gitster.g>
	<20250522165924.GA1613@coredump.intra.peff.net>
Date: Thu, 22 May 2025 11:44:43 -0700
Message-ID: <xmqqy0uo5vtw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But back in the caller...
>
>> 	p = m->packs[pack_int_id - m->num_packs_in_base];
>> ...
>
> Our pack_int_id is the global one, so it needs to be adjusted. But this
> pack pointer we access is the same one that was filled (or not) by
> prepare_midx_pack(). So it cannot be NULL or the magic "fails" value,
> because prepare_midx_pack() returned 0.
>
> So I think this code is fine.

Ahh, I missed that call to midx_for_pack() in prepare_midx_pack()
that modifies pack_int_id variable.  Of course, it did not help that
the implementation detail of adjusting by m->num_packs_in_base which
is done in midx_for_pack() is not abstracted out and the caller needs
to do the same as above.  That confused me.

Thanks for an explanation.


