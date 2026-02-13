Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8E318BAE
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026655; cv=none; b=Hz9iEUqeHl+TUoKJRZtsSQAyOIxIAflZQMzOjugv/zMKCkUYr5eIOIhmiYBdaYaJwZkmZNgwunLSgOnJnJu/P/M0PaEByQPeiTbcw+l1NmsxIpolddbZgK0uhrl4YoABT328UozbZgpi7Uc5zu8qSlpFVDQvIkmwS1LhRx1uKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026655; c=relaxed/simple;
	bh=0kpCHet1w6xwDh42WMnS/9FiyWJtLgKurV2fWccEVJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jcWTkzZeRxVJywPLeoWfjZEfk6Sg5xZ3G9Z2y09mqErqdpohxZ3IyPfOh8YeTKNy6cN6Rgx2fpnUpkBt74tlIIZH4cotNxFBO2BNNgs4/1MOkxRsoY7dnAE0DJNk/Dm4TIRlhJmrcqv9zLC3efDTDS1l1WtXnGSzbW+HIy+Q6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8wHHmcW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kg3vKXT+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8wHHmcW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kg3vKXT+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C38B1D00177;
	Fri, 13 Feb 2026 18:50:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 18:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771026653; x=1771113053; bh=uJLHErmBya
	6trqvqCDAgnw762VcU9cEiRXU3VV7XY5E=; b=M8wHHmcWTnKFURG2R/C+rMBwbE
	4THyX9tqr57BpM/HeeuaGY0wYiC1N3He7s3yuDjJNMHD3hB2WsyeIf05QX/IcMJR
	7DFHsX710WC2x2xv2AK4jgjVjQJrKX4TY57mbJ0ipQrvq2YPa5Jjjt8/eZ8mLoTE
	LLsbIZ084e6WRv4KJoy0n57jEmkIDRu4Ji24eOzED04evpcyplNvHLfNAhfHzvZ7
	63R21jIKH84g/cVaCgCog8ciQukntpvO5ZL/JebdqPlHbzW71Igk0B4JsWAnKrQ7
	y1tfFWCA5kEojqhEiilQwTQ8d8XuFVq2Wb8QyMRYCOOMnkW08gfvpxo3tIuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771026653; x=1771113053; bh=uJLHErmBya6trqvqCDAgnw762VcU9cEiRXU
	3VV7XY5E=; b=Kg3vKXT+HU6q97RWnZ0Qurwf7srujlZ22ddvrvMwdDO8DJmYsiK
	WX8UxtXS0BatKC1ccoLptOthZMZ89mHPSKT4QSZdcPHQj1AecVXgiFVsPwTL6Fuu
	oyaM9HlSaK7WaI8j0YgdD8iOpScM9xb8NoneGAKOn3gW9JH3zboGzSgdmsPg8Tka
	QN7hn0o1K+raV+FhXEJLxfDi47gstVAdzsMYJqq8a9RSCDAAIDCfCHWhTS0S5bRW
	eoSIzkhKqelSURD1pKArhMnu5TwEHRfd24ozOdd2qovyEiAEdMK1Qn0YkY5SF9oa
	eJvISNqcr5x22iNWBuIbvPo6S+/WpXD+MYw==
X-ME-Sender: <xms:3LiPaV6TINErqIBFA8j_M5FmTw4p3fSiWGuz0qA99Sgdap_mb-ckOg>
    <xme:3LiPabFDX3BXuxXzdz1acFC2bRehMq6KotmhgYmyXdqnT4iFvS276qhgUn79x7E3L
    ykB_2_fNBD57LJ7vD-qOIpW2KyILHLiVMs42ZWm_qq_uSgua2szNJg>
X-ME-Received: <xmr:3LiPaYCaB97rsV5Em3cqp_cGXBE4lqO9x_-F1PR7-NuqekR33n_d86FkjLh50T4TpZN3C_SO3LE2myMCKkfA1NgU9MClaJRNrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohhpohhhoh
    hrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3LiPaYxOhC71mHrFdC2QFXkXFelTcWxJeEN4XRYNK-zH9vNud_Otfg>
    <xmx:3LiPaU59RXULcZ63OnCGiWktLXojVC63BPRRTuSOFDniL5eNyJo5_w>
    <xmx:3LiPaRxB93tE2HJuFMsuxd-vA6-WQ2UX9nQdyXrAUTYXyhdixvXhGA>
    <xmx:3LiPaQf8YArue43CM2v7cIlpIdBTGKlC6vqefrCzMA3-bCIPhePAfw>
    <xmx:3biPaWPb6nepObLZXdZqVTZXhKCd7BNToo08rhfV6r4xdJIWE5QTl-uH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 18:50:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Andreas Schwab
 <schwab@linux-m68k.org>,  Ondrej Pohorelsky <opohorel@redhat.com>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/6] Sanitize sideband channel messages
In-Reply-To: <xmqqqzqzmeks.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	05 Feb 2026 06:48:19 -0800")
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
	<xmqqv7gcnwd4.fsf@gitster.g> <xmqqqzqzmeks.fsf@gitster.g>
Date: Fri, 13 Feb 2026 15:50:50 -0800
Message-ID: <xmqqikc0i4o5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * I would have preferred to see the early parts of the series all
>>    being opt-in, and that subset of the series be able to graduate
>>    earlier.  Way earlier than the default flip to prove that they do
>>    not hurt when unconfigured (they are theoretically no-op while
>>    being opt-in, but we want to make sure), and that they do help
>>    when configured.  And then once we are satisfied, the default
>>    flip can be discussed and applied.
>
> Thinking about this a bit more, I see a strong reason to prefer the
> way the series in this iteration is constructed.  We could merge the
> early parts down to 'next' well before the last piece, and hopefully
> we will know how much what they are already using breaks (and we
> know colors are use in the field, and we know by default we pass
> colors, so this is to catch other uses of control sequences) by
> filtering among those who are running 'next' for their every-day
> work, before the main part of the series leaves 'master'.
>
> If we did it the other way around, even if we mergee everything to
> 'next', the guinea-pig population will be limited to those who build
> 'next' with WITH_BREAKING_CHANGES, which would be a lot smaller
> minority (I suspect that nobody uses a build with
> WITH_BREAKING_CHANGES for their every-day work, actually).
>
> So I no longer think the "no-op by default first and then tighten at
> the end with WITH_BREAKING_CHANGES" is my preference.

The other two points I still care about.

Others have any opinion on the topic?
