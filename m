Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF835A954
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425202; cv=none; b=TqZHeTfRtG5yq2I+2+vYs5QT6zXz6A2TIYfKp21TuhScbhQ6HEKZwxFHjtad7qKW70pC5K3ScXDP9mm6wsEWtEIHn4lqRrutDosNpDdX7ssiw2hydARB4852nmI8srjZlYamjzo1fqYjOhzWsTqYDHu6u7gjhCI04MqVGM9atx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425202; c=relaxed/simple;
	bh=4dLieLLw5kKNJlMH94F8ogT89FcqLKOkzgpPvlPVg3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ie5aMyspnlQimMe/nXixjRvfahPkBJF9oo9br9XLZ6cSxqNWlr3EpYcK7nwxKBLS0uoDnDnTPeFkSi88/J4+2wx6EaLWaVddQueP8NU9AY/yqjtqtnk7vksnj1YFqu4Cb6hamqB6c7jevuP7CC72JtDjzunVvzHcMJGTedC8XUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eiPLEffX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFeILwbN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eiPLEffX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFeILwbN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EE9FC1D000A4;
	Wed, 14 Jan 2026 16:13:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 Jan 2026 16:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768425199; x=1768511599; bh=WKtFLaS5YH
	vwnpfmrl9jhC+LhlqwTO3lh5XRBrCiDE0=; b=eiPLEffX+svYQf16Dn+Zf7gBFQ
	KRZY735MFwcB6vy2pdDiMFjUh/FZjwcljuLUljI8IG7idiqsZlGsU6mcDaW/uqIl
	/vxc0DW0P/g4cY//vz9ElrOweabs2lqJN82HeYBnh2QG6+Wuj8GCPvmnbIDdwsYi
	c5kiXDBsA5BssEN1MPYzbMmgk8KKwxaqHsuOrUa3MgxVmczfzp8MPi60gEyIC2mn
	LgFKj0+rBr73wQTnuJCiDFSsrnyKEQrnHKg821mTzcp1sXCW4bIahLdVzLUV5aBq
	m1jt4H9Zm/7hr5UQmwmiv+NOXmFgnWboJ1YbDOqsCNyJTJ6gFhAf8gGAV1uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768425199; x=1768511599; bh=WKtFLaS5YHvwnpfmrl9jhC+LhlqwTO3lh5X
	RBrCiDE0=; b=CFeILwbNoVKwsV8UMOW5GI94qFQrPfA9Rl1RSctgMGyizZok3Vz
	j1JCc3DTtXfKdZ2yX3nH9LVrYFN9V1gKKgp5maxy/6RiSTct9COLOGEKIAgssKXY
	B63lvVfl06BmGZQtXE8iyoEeZoH7m9vGtS3O87pBqpRDmmbQNvxJgOI+yoS0ArmZ
	Otys2VDRiV9UJ+lzdhb24RDK5Xg1R/nBVqq+r4gWTweb/YegCzdI5hMltrXM1cLJ
	61THbEudyuH51AOvXZSmiFPXqtS38SG12iQcLSm5yx4EteuDlsx/Hf/zoeX523SH
	L7wESQiHLfK/iGLNTW+ddJ7pnxsf1mnCiCA==
X-ME-Sender: <xms:7wZoaXW2GaZZmQjXn55nTPkHSskkQOB68XxROWNeQC_n5_y6egsnyQ>
    <xme:7wZoaTQPLXTF0bZeqrZEU-_vPawhpBU1_8tcJ4sp0bhWpjlscTDRwPVB47fiGtd_x
    wORsZPOzvjOEbD9_qAGVj4FPRkrSH_zB2DYxk34p0L1LDBuTlU1ug>
X-ME-Received: <xmr:7wZoadOLi1cSq2bzc0nADhS0Da8fTjkCBAzkOyGPy_ic2ckqx5hL1RnXMe5zpdMhyNDW4qJw7nKal8cfw1nRUiwmALDhpCWDb5oNikM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:7wZoaZSKe2ofdcKRlJu0U9TPPk6wUF29Ba4z--nVIFWZiPsekFbO4Q>
    <xmx:7wZoaTjIANRUY9apJkhnIwWSqf3KpvPH-9nNK_7sX-prvLxP8Tq9OA>
    <xmx:7wZoaa-uB6v9BxaXjSjylExslaGd1YFNiY9v97TfZC08Do9D8RMSdA>
    <xmx:7wZoaSERk5Ithab_1YSJwdx1PLPJZS9toowQ3NzBWT-c2HrNOOkSuA>
    <xmx:7wZoaRyCd6eaG1g-xz1U13P9t-hCFm-fL5tEwOwC_bA3mNqiD-utbv1m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 16:13:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 08/18] midx-write.c: don't use `pack_perm` when
 assigning `bitmap_pos`
In-Reply-To: <315a0ea2985894f5ae5f166bdd1685ce0981fb23.1768420450.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 14 Jan 2026 14:54:39 -0500")
References: <cover.1765053054.git.me@ttaylorr.com>
	<cover.1768420450.git.me@ttaylorr.com>
	<315a0ea2985894f5ae5f166bdd1685ce0981fb23.1768420450.git.me@ttaylorr.com>
Date: Wed, 14 Jan 2026 13:13:17 -0800
Message-ID: <xmqq4iongaoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> But the process is completely unnecessary in the first place: we are
> enumerating all values of `ctx->info`, and there is no reason to process
> them in a different order than they appear in memory. Index `ctx->info`
> directly to reflect that.

As long as pack_perm[] is permutations of [0..ctx->nr-1], it does
not matter, as we are clearing all the [0..ctx->nr-1] range anyway,
in other words?

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx-write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/midx-write.c b/midx-write.c
> index 13171d7e9c4..da9c5a7c295 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -637,7 +637,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
>  		pack_order[i] = data[i].nr;
>  	}
>  	for (i = 0; i < ctx->nr; i++) {
> -		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
> +		struct pack_info *pack = &ctx->info[i];
>  		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
>  			pack->bitmap_pos = 0;
>  	}
