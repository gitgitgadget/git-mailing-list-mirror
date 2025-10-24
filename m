Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1727280E
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333071; cv=none; b=qOjadDoKeassXeUSWIvq9r37gihvB0FqEh7/O9iYQlkRtg/43mIDHd7+WDVq9k6NI7bV0Ujw3jmlgQdCxQ8Oxa/16P03H+LqOXwDAXCVgnJCKs2Ln9kCS2i2TFY6WminBcuASOBoDcNXlV1vHAGLpcYoH5jGS0YrGdyIxWX//fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333071; c=relaxed/simple;
	bh=Uubod9X+1vErPzzLnAkQsR3o2iQclYwOU8se8XMnOAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5jZZhCRyhPvjwbqQgR3B22zQQWwf1NNXaB9Ed4faOw/5pP/3vUY3zYUbI1es/p5Hxum3h7UCoOmufx6kyKLuMZWs+T1nnUXP09xLnwhFqcwceMFIvfWv1jx/NGOZtAB8t+ZPttzEmVvbw7SI6PnuVqMH8kVfZLY8p+htqV+6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f8Aa1fta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aagjojYK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8Aa1fta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aagjojYK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A4D881D0021B;
	Fri, 24 Oct 2025 15:11:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 15:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761333063; x=1761419463; bh=haRUGpVbX2
	xIonONnSjccrGTKc5IdoWBGBa/uzraBd0=; b=f8Aa1ftablI8Yl1V/nHdZANodS
	ihi6N1wx4FGAqTvSQ5nuyfsIxidvhEMrliT3SoZH6cTcRYo/sTksDaeH8h2PBM5E
	7s1iHcdKM0NqVBO0UZBvTmy/WXlB02DsA6LK/O+nUoH3EIIYXNAryAnIzhpU2sGk
	/wbI3/E2P3wEltH7w84ugJdvOpfvYBx5QCWWE+lr11iV4QAdSB3yrv16LuGqVjhb
	IT706Zfy1wIqAgg/LFRmerBLsC4Z1koCsanRi8EN2wn1hbPF3osB0XhOv6h9Vbzl
	yvh4wkhobJMIOMOBmKOmhUMFdEuISTXRlPgvzn2RMiE2CoWDj8j16b9HOZ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761333063; x=1761419463; bh=haRUGpVbX2xIonONnSjccrGTKc5IdoWBGBa
	/uzraBd0=; b=aagjojYKBTXF+pDdaVH3VJn9A0Ca7yzC1dougDE+df2DkBju4WI
	q/uwOe4GTJnaulfa3WhYOeoTYHwoysAehe4HWZVywhp6+VRRJ6V1HX36dDJXQZof
	Ka1gHynAYyuJZiVpaUPTJCGsNNbAjO158frxKJlm10IIli4A1IrXI05TlWWXgKWc
	3t/RT8AnMXlqz/6tIHHGTsRGq7j/4lAqxRqdbwbjKXxrO6rw7WJckp8VNmQyC22E
	x3Beg7E6pN2E3YpkWAq6oGr7M39DSExZp6OJOEdFKw4FbB2pCPy16KQgOewxDWLY
	nguh6UZN/WSV+PTM/adMV+JbiTiF9xOIsDQ==
X-ME-Sender: <xms:R8_7aHJ90VssYHJobYXNf9pGhwQquesguCdLl_Q9E5OaBIopZzc1og>
    <xme:R8_7aO0WcMeQQgLgbJi8BH5sURJ3G3Wa7keHcNKjmOi0O9o-lyD0aR4fF6S2oI0Bt
    3STmZAoxtL6iHDbsyAWVI0-3gW8A7RnONShgqgR72uHFzrvPZEDDg>
X-ME-Received: <xmr:R8_7aJgLkpDlT0rcFHxP0i8GFQy08SRJVKAkYOl0-kfJQPt0v-DGM8YfENpRpfEQu7fYqNMsJFvW66GodR6zNPHmHpYfSjLQn3bp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:R8_7aHXvpijRYZ1FSybGFTbUL55MrvsSHOx7me4kyM9nNHzhpMAoGg>
    <xmx:R8_7aAXiiOZYNBaEhu_fmxhL39GHu4TCSAYY9upXHsCZEHG5on__og>
    <xmx:R8_7aPjYJGXbbJNcb7UWxMRWmc7JUPE_YMWRkEZljHmvkE11q7mpjg>
    <xmx:R8_7aDaoR04N1pHSy_kyQ-U6N3754vPpIe0_X8T6EX4iDaLYNbMUyg>
    <xmx:R8_7aIHNO4gUFfA8VdEndinHOg4DBx7372u_3qvbqEwlP2i6xmvx3Y7b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 15:11:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/10] builtin/maintenance: introduce "geometric"
 strategy
In-Reply-To: <aPvNfU0B8J9sRy//@nand.local> (Taylor Blau's message of "Fri, 24
	Oct 2025 15:03:25 -0400")
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
	<20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
	<aPvNfU0B8J9sRy//@nand.local>
Date: Fri, 24 Oct 2025 12:11:01 -0700
Message-ID: <xmqq4irop12y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Oct 24, 2025 at 08:57:13AM +0200, Patrick Steinhardt wrote:
>> Range-diff versus v2:
>
> The range-diff all looks good to me, so this has my:
>
>     Acked-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks for working on this! I'm excited to have an easier way for more
> uses to interact with geometric repacking without having to juggle in
> their head when they should use that versus doing an all-into-one
> repack.

Thanks, both.  Queued.

Let's mark the topic for 'next'.
