Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBE36E472
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302904; cv=none; b=ns3996DbqGSFfSeTSWF5WC1FiXjrGSEHtSZjpJnAgp7VM8dxc/VcxYS/PxKXChjBf/HRlieffnPCMfHaL+Qsp/sQk+k4BmHupzyP1IZf6uYjPTAASVjZDxFb6KxOLBgSgPrxo1lRiwwJlEojgdLgo4+myYMzcvcxsQz3upTqljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302904; c=relaxed/simple;
	bh=pwAKYtZ03TLiNO2xzGjcido0t0sjvNyB7ftcuVqISu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rl3hQ95TAnvbdau/taBr1R8eTVqHiKUH6zcvJhXuL+03IefjRisiF2iX4b+Kc8xJNuCxCjdiJAMsd28F/jOFy5+WTHgxASflt8yBsh6YbYqYwJX4eZxho6xFDLCvWc3FIDr5ATfXjkC/jflXzBA8ehLTY3eLCmsUM0LvNIdIt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pge1DQ2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vxOQirEV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pge1DQ2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxOQirEV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BFD411D000AF;
	Thu,  5 Feb 2026 09:48:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Feb 2026 09:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770302901; x=1770389301; bh=sip4MplC3i
	/ObA9cKGB+UAmSEh8nkdYVfLpNoUnR+10=; b=Pge1DQ2QZHdM13uAZIU07puUOO
	YCst79+seXyTaBBgf08lLQQ2mY7EuD4SsioB5tMPZgvsd7mNF6uxmMjQ18nzyaP3
	qx8yMAvBwO/COiCDUujT3c3UOXzSknCDGmKXUA//k3+phseN1nDsL3eyfM8Zaswx
	smtuUcFl2gai9Cj03XAUWzOsmNmlWGo8EWIxndjiHhJp5zDLG3GF4Leo4un3M1O2
	emNHZPKInPpja3Uoz6k56H0sqttz0xwH+ste9vhfoO8/0oehYmfHRZXgNzYwH6Zm
	qw2ZweKNuBpea8MEGq/1qh9s8PcBeEOWVjZjBccmmb8v+L1ebI/zMGNCoVig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770302901; x=1770389301; bh=sip4MplC3i/ObA9cKGB+UAmSEh8nkdYVfLp
	NoUnR+10=; b=vxOQirEVjDNZti006Iwtq7YfeSVn5Uhn84jmbPlVzZxnHDHLLyP
	KXmqfBxV1WzF20WLgio8oIyIjyovd+fW0gvXvNhP/0CLHDyYuMGeTdn5HB98XFC3
	Yh/WgvBT5Fef5kN54ISD/f3YrioCi8ODJYXNLiGwXgjH1TlzKJRSwCOgoUriibJo
	3qx5qCmyjujQAZwiMASRjTjg1AiVELoYR931+gsG52HxesciQh97ZUwuj+n8iWNN
	oROStybvJMzQrFgn3UFZuC3JrMqLl+Qjjk6cj0Md4tFQvSZ/M2KX2/CVdgVzc7/U
	xAF2DwjBGRLCm76dmO0Nu0TsZBmKAnGhQow==
X-ME-Sender: <xms:ta2EaSCI5i-Kja5JRB0D7XDoqa5NKfjRAX74X9MQxWxN2ttsONk1Ww>
    <xme:ta2EaUvGZoPq2yivBsRkRGIrg3xYMcbuOu65oROXsNiHmXY4YkUO0Sw9uMuJaP4eJ
    GRVaF6hp6QOnwko4Pwbtk0w9GJAr_q93tJd2hPLRuXAEIsnW22yEw>
X-ME-Received: <xmr:ta2EaRKSiKmgsKxtOe_Nzy8QD2DkyGNum_MSByQlkeQMZddSGxW85lDjHHGNNdJwUqC-XHt43vhN7PK2KtxB_dRJIiojmlNqcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohhpohhhoh
    hrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ta2Eabbjcom1r4Wz6ns6TgrFy9ALbmhLlm2KicnNDcWC_LH-G0UnvQ>
    <xmx:ta2EaTC8lnWOXNgtEJkjvs4Scm4Gr3X-veYcCg74u7n1Qdh4w5cOZw>
    <xmx:ta2EaVYTZpGt0oiWz4NgM5-dRQq8SpiA8Whj-EhMDybQ_dS6ry8uXw>
    <xmx:ta2Eabma6NSL464RmOykyf2nx9d72xEDLriYJbzZA0SJCJXX6DCUEg>
    <xmx:ta2EaQ2DtDiZ2w1Z5fCBaQez1C1R92KLu0vmr-6ZO00nyrgqa507YtI0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 09:48:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Andreas Schwab
 <schwab@linux-m68k.org>,  Ondrej Pohorelsky <opohorel@redhat.com>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/6] Sanitize sideband channel messages
In-Reply-To: <xmqqv7gcnwd4.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	04 Feb 2026 11:26:31 -0800")
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
	<xmqqv7gcnwd4.fsf@gitster.g>
Date: Thu, 05 Feb 2026 06:48:19 -0800
Message-ID: <xmqqqzqzmeks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>  * I would have preferred to see the early parts of the series all
>    being opt-in, and that subset of the series be able to graduate
>    earlier.  Way earlier than the default flip to prove that they do
>    not hurt when unconfigured (they are theoretically no-op while
>    being opt-in, but we want to make sure), and that they do help
>    when configured.  And then once we are satisfied, the default
>    flip can be discussed and applied.

Thinking about this a bit more, I see a strong reason to prefer the
way the series in this iteration is constructed.  We could merge the
early parts down to 'next' well before the last piece, and hopefully
we will know how much what they are already using breaks (and we
know colors are use in the field, and we know by default we pass
colors, so this is to catch other uses of control sequences) by
filtering among those who are running 'next' for their every-day
work, before the main part of the series leaves 'master'.

If we did it the other way around, even if we mergee everything to
'next', the guinea-pig population will be limited to those who build
'next' with WITH_BREAKING_CHANGES, which would be a lot smaller
minority (I suspect that nobody uses a build with
WITH_BREAKING_CHANGES for their every-day work, actually).

So I no longer think the "no-op by default first and then tighten at
the end with WITH_BREAKING_CHANGES" is my preference.

Thanks.
