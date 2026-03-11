Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052621B9F6
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202987; cv=none; b=NydPUt3RzJqqJjuMSYa5URpNXtWAVp4scfjN6sGSpgXECSAHoofpETZHLBs/DjgxKwJtEujKJEhbWMnst9bGYBVLFj0au/848auMf9MgSwxt1l7m0d24p92LzIwEDlWHcpV9EHlHgnkgiatIrHfx7FLO8H/V06/Zph9YFo8x+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202987; c=relaxed/simple;
	bh=MJZWIe6LO32sKB115k2j3nQDaKKPpk/lts7uggVQavg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjT48duWMlXzl1Wj3GDI07W5R0r2XOJvkCi6PJAhHw3xDZ/z56jNUZ8ZQ4pX59ncd5I+VqlO/JJBusgPCE6zAz9A/KPUIERvdDf4Sph5A0Vzi+Q/SCuXI7/UtoICn9zyGp7/GRoboc/tT/O7UTfirOss8Irl+qspJp1TTt7GRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K8dDFjCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3N5zyay6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8dDFjCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3N5zyay6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C7AD7A013C;
	Wed, 11 Mar 2026 00:23:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 00:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773202985; x=1773289385; bh=vm8yEDxgSD
	OsTmLteUs1GxrQzGrXhPMm1kRxS+5wDxI=; b=K8dDFjCFUIBZoo8R1WMjwEEZPp
	bZKJ0U0Ti/SZJQJzJ8ou1I4pRqYUVWJUxu+s9CqGMDLPap9VbOqILtHJSKv/Ev38
	tPk+zcuJUn/Lu6fi5CACSoGRHtjWvmMKkiUKZ85iL7wm4IFuGOPTMkvn6NwWPAtJ
	nU0y0RZvBqKFmGJPrKJZw3j8LRSxmTnsxYYPoXDJDBUYw3qsdCJ4FzsUStX/G8c1
	N09ljeTTjML4EnIykmuocgSCs/WlpqTbu2GLevtZXU8CdzzwWAqs9bGZomXE+Q6T
	KZWxhnc8ObDxt1PraxAK6wTZ7L08fl4m1w4Kuwz5ukRwmbYnRTJyir5WKNhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773202985; x=1773289385; bh=vm8yEDxgSDOsTmLteUs1GxrQzGrXhPMm1kR
	xS+5wDxI=; b=3N5zyay6Lt5kBJOTbVkXMPJgqWBBO4TehcGrPdUN4I5AuG7rrMr
	CB7zeRaQRojnw7b0nF6S/sp1wy4qx9k1KX+KkKrg1UNoSu5NDTscxuxgfnqwbis6
	0lck3q3uzDLtbK4qrB7VSL9K169pUBvTFzlmPkJPzUVIYeIH7yyvkk7SWNQXwv14
	FktaBdS7gax/svAIPhz1Zvcyn+fzerGWTq+1oO4R4O50qIbVNLV5fl3S31ipm9l7
	FrWMXH+8BNSt3IUQVY+MXkzXNkbv7Zxp4C1zBkOxAdNoSuZIL7YrZ6MQ3A37+dM1
	fD/xC1mVNpKt9xB9W4wAzEHiUhI+f1Gp62g==
X-ME-Sender: <xms:Ke6wadJl-ySjKKk4TBUHTMgd3bJR3fckKoEYAEh7WX5EVK0C97KHrA>
    <xme:Ke6waQn-7kdlu7h_0h46SYpGSuqtdrMiHbhiMHa94ma2Mhd_vdgzCHvRhEXb8ZXTj
    ZX-olNx8I07YTdBGTD-8GB_MNxivIAyev1ROFDeRVGha2A3HSIVsg>
X-ME-Received: <xmr:Ke6waTFIyItpijX74JoXkV2iWQKKycDgQCl0SMB-iGnEESH158JkpYOvUjY3KpqK54ttQherxJp7I86r7xht_qVkQioiADDB2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfeelsegsrghrrhhoihhtrdhshhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:Ke6waYFGGWnZsKmrGZeZfciUWkMIQ58EoLMWKWpsSurl3_NjcDDEww>
    <xmx:Ke6waYNmaLwvkn7RErGQ0Hdie3XpwOcCDdafDdaMaV73CL2kHbIO3A>
    <xmx:Ke6wafHY4imduJqa4rDWBGOc1uSjWsmtXErXbcHpBZjo2IKz9338JA>
    <xmx:Ke6waXPufQ72YFnifGFtIsbcM3yyFeoS3Wvmd-yvLByj9QGhVVEkOw>
    <xmx:Ke6wadjh_L1o6VHUaLxiORxO1iiekB5FkQJzinZOOZK6duRDrxOzPUw2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 00:23:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 8/8] help: add tests for subcommand autocorrection
In-Reply-To: <SY0P300MB080107A9E22F2C0959290BB0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Tue, 10 Mar 2026 20:41:07 +0900")
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB080107A9E22F2C0959290BB0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Tue, 10 Mar 2026 21:23:03 -0700
Message-ID: <xmqqy0jzq9js.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> These tests cover default behavior (help.autocorrect is unset), no
> correction, immediate correction, delayed correction, and rejection
> when the typo is too dissimilar.
>
> Signed-off-by: Jiamu Sun <39@barroit.sh>
> ---
> Changes in v3:
>   - Fix coding style issue
>
>  t/t9004-autocorrect-subcommand.sh | 51 +++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100755 t/t9004-autocorrect-subcommand.sh

t/meson.build needs to be told about this file, or you'll break CI,
like this:

    https://github.com/git/git/actions/runs/22929006339/job/66546202060
