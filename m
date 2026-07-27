Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E523F7AB7
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164117; cv=none; b=El/bVcR/J1pUVwLiOyXELNEaqiaJwXANWK6nwvMmeBImwu5WLxAVGDGotR6TefMxlolh2mNW6DsN2M4Rz7YjWi2n/WvvY2qNUtU4zqFTxnx/rqHOEFzma/nrDlyOA89mkxx6vMamlUIA11X+8x0OtqROGJpAvvY3lyG2HKxnnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164117; c=relaxed/simple;
	bh=V0VBTTZig/DnkieFxLpaGw5kR+ZKsABrYpp+wz95ijI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcieRVo2uTy/JFqUWC7MAY00g8gXQrdR2NpHBFNCUao0MTZxto/iXNX1Frd1Fm02yp/sLtGwtLdzkRPubpa9/TzIKfiU08epPKktyKYV5j93R0Lvc91GNRqBC4p7iEPNOSgzNp1/Wn0TS8t+gN1B7t+YIbk6mJCldV8TOayeeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mTXWPu5A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iujdTjzT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mTXWPu5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iujdTjzT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E27351400146;
	Mon, 27 Jul 2026 10:55:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jul 2026 10:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785164114; x=1785250514; bh=leq5adVC80
	mp8/pdyqAnvknTDOUBMpXVem5xzz26PiU=; b=mTXWPu5A+J3LeVMjyjavUpXkzh
	aoNkaiPxPFk24msddSwCIij+pqbBVQPrKCCGWbKg7tBWdvqv1hYTBjjBMCQEt1rJ
	S4w0GOTN3arFJn9gAL0d4ifyf3Rlpy3xjQO67hsX5S44193qwi4yhJ6uZbVKppUw
	f1KqlGqqlTbvFwqpMY26dMeDn8/Do16Tf4miTREO7YSegXxJOuHs0q7uG4RtVLIx
	MjqnHNjTCPIGLS8Lci/BGQLV4T5wrxfLPKcKqGpPM1w8wcoW5vdVsg5Uv2U3s5Ce
	d/m2hyuH4N0RKUOxD+0JnRAfWvZhYuQBUI7PTu9/DFWRqubi0N/btg6ADP4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785164114; x=1785250514; bh=leq5adVC80mp8/pdyqAnvknTDOUBMpXVem5
	xzz26PiU=; b=iujdTjzTwQ7LZ5ilmE34Fl9SqSL3S936/v2inV7bA9oICNngwY1
	BVLmwWZpiuV+KvwqfMptjwUrAwB4xTsZUl1Erzj1cRfu1M2b2GjQfca4ZJgxHtdD
	10g2Pkbu0nM39DAL1Z5v9n6YS+kQHpGsU9fgDZpUE1IjWt9f0WD7fKM/WoZv7Qu7
	SuHe6OxU+dtkehYa4Oedo/P4hjO2ehjy06BUvRliGkuTNvYJOxdNORDxyRUOFCrZ
	lG0b31axXHUzYEQGaTUAI7G1BWz613BnKJcmEjXb/90k/Xw52/glbnhFrCDr6v3i
	O1UDi8wGpjJYAcZCmqmLP1JTfqoBJ1wxPiA==
X-ME-Sender: <xms:UnFnaiqBSZT7_rgE0iluaqwMoD_3ih-ZyZ4WocMWCWFYjwjkwl_MXw>
    <xme:UnFnai6_3aoAgxfx26UJhqe0f5qdfz0J6jZb3BscCHmNXZY54B2x40xU6ULU-RVfU
    2mMhFjp9M0A4HbpimOunFY3u8zH1Ii2nGKVUFq31pin2td5_0iuDJE>
X-ME-Received: <xmr:UnFnapeW2QfWYSLrI0Oo157m5KIJyHOJAZVO0PjVVaUFvcanC-h-V3ilDbHJdvgksVMZSLlwE9KK6lAgQZlrCvOGWdUzi-UD6Q>
X-ME-Proxy-Cause: dmFkZTFnp1cTKRNA28lIo7tsjiQfBQh003NNZ9GUcTKpJZUjs9OsVGW4s1zH2iFK796Lwe
    7vWpvQzFop+6IBYsl57yVp2LyZoawwIMXFT/aPH2I1mnwrNBa/n+s4YplcIuzJqeKAEZyt
    b6ecsOR8SvCk0BVkLOPIn24YSQ97Qsf4JuPMkkLv3nGk9C/pajuAITdbG1cDx/dcPAdAaE
    UnzYy8pzJ15EOZY8bk4lrORsjIvJRkiuwO1uzcoqx4T+wzSqhM/QgDvdNgazWRIkO55Z/d
    hwawfRcVwofGrkY/sKK0OcS8SCdsmFyl/KeFhpq9YWEhvtsC039Dx42MVrhLNeQYkHb5Kj
    GiunzckTfMljzP2BcSMx/TngVpBY4mJv1eedLDvCeDmZFrCrpKmBozOBOwj6PM2JHZ5DUW
    RCYCBtPhvJdvE2UlifGGegBP+op510l0SxU40tuGBdkKfiI/Jxn2g5FoaayXZXb5bw6dZz
    f6Rwm6A3GMy9cpI9LM/AUYts8sjIDKDJc2ExUP1aC1NoJ6euRgPif8CbKvICdwDk/1ym9q
    h22RNpRbF8r/gVieyr1VHpod254rmVp6WAVdHhzx9INfCtg0C5tiV3mLEkOkukkNmi8oHc
    pRAp/5fM0G3aZZNeBNvkJtVLzd83iaBVBnJXhV87eAYNCeFbw2HTjcsN0ACg
X-ME-Proxy: <xmx:UnFnan421CjhScQ7PRY0om2_RffoVtNfw_w-cmHdaPq83_ielseWxw>
    <xmx:UnFnags8LdOwlPa2NOFwoWm6U2ZQd4TYJebX7uMz68OPTeZSVhDNjA>
    <xmx:UnFnanjSpcT-ZsGnTBuo0Rdz-hWulCCFlTlkA3ahs0Ar0dWlyopVRQ>
    <xmx:UnFnarrILECw3LStk3siHBa9JPqSIf6u9yRYpMk-jHKcyP_j4d3vCQ>
    <xmx:UnFnagh3_p3bUWe71FjuMuLSEBfx-uAhCk4rFtY3fRxrtA8kVHhDTJfH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 10:55:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Hardik Kumar <hardikxk@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Pablo Sabater
 <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth()
 return size_t
In-Reply-To: <e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com> (Phillip Wood's
	message of "Mon, 27 Jul 2026 13:51:27 +0100")
References: <20260726123427.173877-1-hardikxk@gmail.com>
	<20260727065917.469738-1-hardikxk@gmail.com>
	<e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com>
Date: Mon, 27 Jul 2026 07:55:12 -0700
Message-ID: <xmqq4ihkpjn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think it would be much better to remove the TODO comment as Junio 
> previously suggested and instead add some documentation to the function 
> explaining (a) why it is appropriate for it to return an int; (b) why we 
> must use the cast_size_t_to_int() helper to prevent overflows (see the 
> commit that added that comment).

Thanks, especially for (b) above.  That needs to be stressed if we
are to go in that direction.
