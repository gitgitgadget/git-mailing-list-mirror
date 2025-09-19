Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D72AD24
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313135; cv=none; b=hRjVBAd1k0jFenTFnD7KE0Q1g7204zPZAcIM3QgwPVEV4YDuVh7uOYDemz3Qc4Kx3+gNd/YXWd/7TkYqRbJyVP5lfr+tvJ2P+N9o/7E/pXwXeFmWqzjWdEnYWdBbTrt86IyuOgiAqrZJqBta9X1wNeurDt9jybwrL2h+Yp3TY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313135; c=relaxed/simple;
	bh=LbUNHKyDmVmRL9SVy4vw1Bz6Beo6BjYy+ZJPhhDMhjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ddv/VtgEWm+BA3wY41KAMhcqqW5Lbf74Dchnba28hwevO9leLfSvWac3y2JhmHEWEaotMaeQa7d6VLq6EBUllyqHlCts0K7iNeyCx4deYD9WAcEQa3d8mnwJhDIUATaFclg5c6EZK9vOgshN77lGQ/U0Sart698q/Pj56c3/Y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mwT3qyFZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKHAshTX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mwT3qyFZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKHAshTX"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E40C91D00128;
	Fri, 19 Sep 2025 16:18:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 19 Sep 2025 16:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758313132; x=1758399532; bh=TNgZs3n13o
	1ugl0gNefZOZfH42NKbL0PxDGQM/Fx3QM=; b=mwT3qyFZ18EGgeKTtKlgUSLrka
	l2NR5/Axmyj2zzv9ShcqHn/YfMyRhPotJrF15Feg5SLNCeSkxPgNv9wNm6Ujv5AM
	NuhBZstlbKxbn2X6mhsHxq+wwOjv5hOzVekwO96sFtzt7JDnbaBp7XXGTQGS+kax
	x4G1kK2kYGxNu4rbnbx2CIdnPcR/5tKcwvQdMLiGZ//WemahxfVnXamvBkjyXsAq
	k1IN0LNEkkPz833d0X0WgKBWwaiE7cZbYd05dGY86XCCXJV3uEIFqkiKq5u4rbcX
	JJthXyPTCRsjqDB/yoHeBVFGcw9hL4PjFyM5bz+i0mT5/aSuXAiD7B6GE+UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758313132; x=1758399532; bh=TNgZs3n13o1ugl0gNefZOZfH42NKbL0PxDG
	QM/Fx3QM=; b=OKHAshTX4C4s1xOQ9W6wFAlKgZ3v3bAEU6qqdumLzYqsZGH6H2P
	tSm23ZNwoGHwL0Xthc9R5yxaZ+TZMAWpPd6GU8noMaURooM1VlJjHLqvVtqi39hw
	nq6TScz46zHR57HqTPegVzUwhg1jPH1s5o9rgvkP32udDEI5qjOgrgjGkrLYKBns
	C8vJxuH424likvnDMtGtjYUyLGVqtvqzmFCG01rnNSci0oDn90159KY+g7Rb99Sh
	zQLdqEdTb0iqZJYTVzxIKfZH30EKK81iGt0FyNlsrGFvg54pZoXKWCix0Dt4p8rX
	JYhJIxdUsBcldoOTgaR6adXpiJD7WRHPsVA==
X-ME-Sender: <xms:rLrNaNi5dhPB830GQL1pSra3dqtF2mJW3Oeucb8Kpk3Kk6icdewmEQ>
    <xme:rLrNaNjDtzrMGuADnB7ygqS6G6_dOwBL52xa-g2X0PaCcVYGccWBRs5Ott3Vk_ZQ7
    a7I4YKI8fbMtgae6g>
X-ME-Received: <xmr:rLrNaDid83qWG5oHlH9Y-_Sn7AEKJNK1VCfdsfB8EG3iLY2CDQR7cnaRjPmdXNhtbRBT7q0rsf5XmCbly2QyOmycNBopRGYY3vGDapw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rLrNaNL9r-1QF2XMOhi9Psdo8GkgdGDuVtSbqgA4IO72hEoyI46wLA>
    <xmx:rLrNaCEYjm-hSXp2OcL1TZihMJPPD_GJWN8gaiFOSKnn08zj3Rx66g>
    <xmx:rLrNaBQ001utMBoAQOGmQB0w_vKiTLKpyDRUnrPyqtAUFb2IfnDGDQ>
    <xmx:rLrNaOdlmCuuVu8oKizCpOZsBSDiTZPHLnnW6l8Q7KIJF7YBBC5TIA>
    <xmx:rLrNaK3jDFcPp8osdp33DMEvEG_K9ylkgkUkk9--_6wQRoyQlzMfAq4x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 16:18:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
In-Reply-To: <xmqqms6q45nl.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Sep 2025 12:13:34 -0700")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-6-sandals@crustytoothpaste.net>
	<xmqqv7le45t3.fsf@gitster.g> <xmqqms6q45nl.fsf@gitster.g>
Date: Fri, 19 Sep 2025 13:18:50 -0700
Message-ID: <xmqqwm5u2o2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Probably this should be sufficient?  Not tested (yet).

I did test and my local build of 'seen' no longer barfs with this.

> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 4404c623f0..93fa3dee8b 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -171,6 +171,7 @@ manpages = {
>    'gitformat-chunk.adoc' : 5,
>    'gitformat-commit-graph.adoc' : 5,
>    'gitformat-index.adoc' : 5,
> +  'gitformat-loose.adoc' : 5,
>    'gitformat-pack.adoc' : 5,
>    'gitformat-signature.adoc' : 5,
>    'githooks.adoc' : 5,
