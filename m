Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEF2848B0
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632991; cv=none; b=AES2bbTj333YVLKmN7VRQlYmDRHl+q3YqsNmkjd5LjJW4+Nx4XurXmfeMfzBzA0YZulbnTn3L14fiA2NFU/eXBVVom0DKJQZKqwPhofHOlzKqhL3i2bbPjzYJiEFtIydVLnhqx66UxG8PyNRM+5eHhBQDo2KieSFa/4NTHc169U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632991; c=relaxed/simple;
	bh=mOQgt3ma5YMaHzwWbUNztrfuP3CszJBPo9+7aSn5wms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8GNkgoobAeDjvPKsr4e3n7qblgB6Py0X5GtrglIEknkF1EEgafhBPsbNOhVzJ9TTz56qQUo2BvEsjkWGifGbE4ILR0dhxXkmkyEn38GBLBQgVkkkFx/2hA4vCZruRiCbQNSy5AqnpHuUoJe2valQr5YbGMKZ/+C05iDlmzx7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FqbadPUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RjtQ2qCK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FqbadPUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RjtQ2qCK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BF4AAEC03A0;
	Tue, 19 Aug 2025 15:49:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 15:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755632988; x=1755719388; bh=Kc1pdApwy3
	oCFoMCf4pHWKaKG6aoJYM9rq0Qo+87LmY=; b=FqbadPUWMaaqAU3IESJUbK8sIG
	FdZ038aDvsJOGqbDuL2B/ktpKCS6Optu4mboARz6paqvOdy8kOJ1s5tgT4ShztCx
	NL8CQ8+5c5PF2GH2WlxeyagyLAVF9C5D/c38kUd76/wuQLhEgG72OlLSd7hsQIhU
	M70VbbaZWyvyDZ9K92dbvYTeKJbFAzmTs15ctv/Tm4/+v+9eIgxfgIF26X4FBbjQ
	At8QSdAYSp3BPM0MLvKde3BbdP3E30e5HEEn0BLuZqokm4DIcchDzsfYXZ/uX+WE
	bAh6dcg/1gpRNOUX7jjgFyMAkzsBsYeZbEbivDaN3YGC+YBjVikGhdGhAX6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755632988; x=1755719388; bh=Kc1pdApwy3oCFoMCf4pHWKaKG6aoJYM9rq0
	Qo+87LmY=; b=RjtQ2qCK7royiStxHrdJIDAdKBXNeIg4EQ83lIEXltCjubxu5k1
	PvuB1p0V+mwe+iXs49Upu45JYlhT/9ytFVye0RAz/PaHuMqvM6kkx/7JhnInXuCO
	xb5FuSctXzEYVezhKqT8e8Kcs98pHHW28SufOzJDnCwNZ6ealf8P3PRcltIWRtUr
	zsTdgDk+7BMGzkG7bsap4+LIgnByFKqpJQbbHXfeyhHMmVdpYPwY4f9QIpjMXvUk
	Yt7fTjhVYf+gQMppkc//xW1lYTDM2Dp+EHutx1cdu6lucMg7hXuUp84eVlcl2IJ8
	tuN1XnirX1cXn46zH3MY5QXlNGZyW8DwUsg==
X-ME-Sender: <xms:XNWkaFHxzzI-dUhM2wifwBYj6K30tcPa9hNMYzxmu-2fYyljEMXgAQ>
    <xme:XNWkaE6T7pcapnEyXtIhXCQb0yC_2ncncJtAFohiL2zxic1hZ0MKGyQHFVzMnLyPM
    ycMcDZVimOrELO4mw>
X-ME-Received: <xmr:XNWkaDva9FEEmrhDoeeflX9UBX_d962BxTcU9ieaB3rp32FvS3e79WveZOzi6UvqaD7BZJkk1RhkWf8zNc6lQTO4vwAvGy2OmFkpLCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeuffdtieegfedvjeejteehffehhefgteelteehvedtueffieeludefkeeh
    ieffnecuffhomhgrihhnpeguihhstghorhgurdhgghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlvghsrghsshholhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XNWkaN4i9-b6wdgl5zkIPDKz0eaVmmGGRA2bSIjYzMGDzV9MPnoGZA>
    <xmx:XNWkaGWay1eZiBaaCuvdG_ZWMMP_iqQ1SR5IFxgEC3GWkZu4Oz8i9g>
    <xmx:XNWkaH-ObsHLHjAbtTy7GzYfUjLnYGqlUmb_opEhXwgKqIIhfpvhYQ>
    <xmx:XNWkaKmsWUpvI1Vju7c2IaDMbOy0Zqs2m-URf2MsAQFbIFIWdUzGOQ>
    <xmx:XNWkaMX_6R9lm4rlEhHBV82bP05PRUFSnCcCfl6wrhkzqP8Vn92mLYrj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 15:49:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Daniele Sassoli <danielesassoli@gmail.com>
Subject: Re: [PATCH] doc: add discord to ways of getting help
In-Reply-To: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com> (Daniele
	Sassoli via GitGitGadget's message of "Tue, 19 Aug 2025 19:02:07
	+0000")
References: <pull.2033.git.git.1755630128134.gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 12:49:47 -0700
Message-ID: <xmqqsehnccro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> Discord is a great way of receiving help for members of the community
> that are not on the mailing list or not familiar with Libera.
>
> Adding it to the official documentation will aid discoverability of it.

Good addition.

> The joining link was generated with a never expire policy.

Now we cannot take it back as the link is already in the list
archive, even if we wanted to retract it?  Then there is no extra
harm done if I applied this patch to my tree and the documentation
update becomes part of a release in the future ;-)

> +==== https://discord.gg/dxGanGcBSP[#discord] on Discord
> +This is the unofficial Git Discord server for everyone, from people just
> +starting out with Git to those who develop it. It's a great place to ask
> +questions, share tips, and connect with the broader Git community in real time.
> +
> +The server has channels for general discussions and specific channels for those
> +who use Git and those who develop it. The server's search functionality also
> +allows you to find previous conversations and answers to common questions.
> +

"the unofficial" -> "an unofficial", perhaps, as by definition an
unofficial thing is not something the project _endorsed_ to be the
one and only one?

Thanks.

>  [[getting-started]]
>  == Getting Started
>  
>
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
