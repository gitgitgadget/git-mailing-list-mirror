Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D3324B32
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281080; cv=none; b=BLGdTSpX8awetsvvFs+fwN3oMGarOa69vhw1yCscEVoKow+RyUt1scJrl44hXBC/8x9KOpAdcWyx1ozaXocJV3cPfedbRIbYSY/WkpFfG/GYr6+LEY6cIa5bkJijomDI2Gx5rOF65tTap8g4JepLy7X07vsrT4PK2J2a2hdFClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281080; c=relaxed/simple;
	bh=tems1277u6tRcxxcX9Iho9os+VgYbSzvX0TyimE/q0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FA2JJXskAcm376g5WdDo8mIjHoBk6O2SfC+WzxYbJ9paf0x2x5SQVphisaspgsLGov+dT1u6mJHbYoQ0vBXKFL+Mu+XVO21UewMdXrBeD3UC3knaRkmIhYzWVvtjwCxhG0uJI116wYxTK+4F9wb6PgytGmBKR66OU9Ed+1XpeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VyA3QNIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLi1vyX+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VyA3QNIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLi1vyX+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5237C14000C0;
	Tue,  4 Nov 2025 13:31:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 04 Nov 2025 13:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762281076; x=1762367476; bh=UzGBX5pVGi
	zE5T1+5xORsB4wwniAvrsxFX+7Q60gdRA=; b=VyA3QNIPn9dJwo7ESdQn80kcsb
	C/AGGU+8X4PJFD/mO/zJh5uW64dznNKz4iIJZd6G4HcUM62vh6l5nP/MsQ0vXRJf
	/8jdnLhrfSgi7BsMvUKQJoD3t8QJnr4tpzoddqrIBth5M3lH1SWUlOmMfa55jnEY
	8Vw8O5vVYQ2+vI3ewBlNg8haNZtAlzeZ70nC29i2N6LJNtOajS3w+iLFexcG7QCf
	2FTLSh0oSGZcJV0cDpiUfH/VeRAFzrlEcgGWc50APj/9eTnBbcyrC+io49TL4iEd
	Tk2i1pnX69mdjHTrYBqp6mnphvW64M8RuHfi1EIFS1qwcvfQIKPLyw0Mh0+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762281076; x=1762367476; bh=UzGBX5pVGizE5T1+5xORsB4wwniAvrsxFX+
	7Q60gdRA=; b=HLi1vyX+oULaqdRRLrzOfMtZhJNaT9Yz3Ui3eoHZUunwl75vuvY
	AKH5vJ3W/llaBRmyjK5iWBHSqPhj073K2EQAQgoNpj7mhKGT9wNBjxszFUur4MbC
	om22hoOM9mmkN6dpKpah9p6yshkOcm4Dre7WHwRgF70sG91Uu0ab2IMiVJb7fGZp
	orCXwhEgAWhReM2V8MaWsHP8aDC/g1Wo/9mYQ43Ea49eF3u4uyD3wtBTlGolzh3m
	IrkB+AKQmpYsx80e9Ycth/lgQ/ZIyEneyUVIitzDgMJ1WH5YXfkL78GJNyMFX4EG
	5oWjX8aeyhy0cfAPEMuxZGB1NfhTEdsbp1w==
X-ME-Sender: <xms:c0YKaX0iKEEj5Eu9xCv5WaSwzgsdDa0SDc906WO21RKDoKiyL5PPiw>
    <xme:c0YKadG9fWEOzbylwA18qfuX48G9VJQnCpQ-ctNrU5Nx2skUEt9wJ2feJ_CFTXXyM
    AmqpFeiu_zxcoO51QPuiyOPA47h0O3amEvVVaB6F1l-s9vBpK6e>
X-ME-Received: <xmr:c0YKac6lqSO644Pce8PF3jJPzvnCAbxHL8Yp1-xaVShc8gBwFptPQ0TvGvKrFqBjaYggtMMepmwVc_oXomhmcD3TuM40gRmAuByR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:c0YKabu6OvF4O_0Kayt1214T_L8DThX8T2w6RLmr6SrJ24IY_bscxw>
    <xmx:dEYKaV65anXiGsPx9Aatd40DEnY-JEm6_ePiRpZn3QF8fltiD9We4A>
    <xmx:dEYKaeWuOZZjYg-EI27jsvblB8YlThmb7SlhkZabglsiGfIDCMrR2w>
    <xmx:dEYKaf9IuCKNqFcgrX-mhHDpReMBVAyFDsih0G9TC2fS8TWDSnmO2g>
    <xmx:dEYKad0S-N5E-16HPy2ITQZaA3odnM5Bg8_J-xQjgzTUAFq6QSSiIlX3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 13:31:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] ref-filter: fix stale parsed objects
In-Reply-To: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
	(Patrick Steinhardt's message of "Tue, 04 Nov 2025 15:36:13 +0100")
References: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
Date: Tue, 04 Nov 2025 10:31:14 -0800
Message-ID: <xmqqpl9xps3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In 054f5f457e (ref-filter: parse objects on demand, 2025-10-23) we have
> started to skip parsing some objects in case we don't need to access
> their values in the first place. This was done by introducing a new
> member `struct expand_data::maybe_object` that gets populated on demand
> via `get_or_parse_object()`.
>
> This has led to a regression though where the object now gets reused
> because we don't reset it properly. The `oi` structure is declared in
> global scope, and there is no single place where we reset it before
> invoking `get_object()`. The consequence is that the `maybe_object`
> member doesn't get reset across calls, so subsequent calls will end up
> reusing the same object.
>
> This is only an issue for a subset of retrieved values, as not all of
> the infrastructure ends up calling `get_or_parse_object()`. So the
> effect is limited, which is probably why the issue wasn't detected
> earlier.
>
> Fix the issue by resetting `maybe_object` in `get_object()`.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> As reported by Junio in <xmqqo6pjt2wn.fsf@gitster.g>. This applies
> directly on top of ps/ref-peeled-tags at 054f5f457e (ref-filter: parse
> objects on demand, 2025-10-23)
>
> Thanks!

Thanks.  As we stop reusing a stale maybe_object and instead start
parsing the right object when we need to, I wondered if the "on
demand" commit needs a new benchmark, but the example cited in the
message used %(raw) so it would not be affected, I guess.

Queued.  Thanks.
