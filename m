Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E62046B3
	for <git@vger.kernel.org>; Wed,  7 May 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746658267; cv=none; b=fYugJZoF/gor3VGnYMgQRWtp20jCvCdEQQYexWW8UxTqRkK3goIdqSbCKl4mKbUyl+Htf5eBeq9ty/PuAAS9tM5mfIg3sGmzw1xS7wGAvYzEn+z5uZbgoqFkMKIp3CnUUZqa12lXvdZeVhjmYi2fW6oyujqgHXALGLFF/T+mXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746658267; c=relaxed/simple;
	bh=HNA3xyLgquto6XcOO3nDZZjWpZMdpQq/kzlT6Li/xFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqpUYjwCBG/yVgl2tVoxMUIhFx7sM0i3ajd0kgPsN0d/NLVWoh/4T/iGGvQp2AkzSogx1GpMNrwZ4cgwfc7k8nML4mx9bfBT9HwiWDNqEcw1b5UGtS5qerODiUmd7UGGVnAUkH7j8vZdcL1E513JbGC2WNynkFjnwFa0GV0iTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CMYFJ42B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y63Z0E1t; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CMYFJ42B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y63Z0E1t"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4269813801E0;
	Wed,  7 May 2025 18:51:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 07 May 2025 18:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746658264; x=1746744664; bh=nbf4q862hb
	2E9fINdO7iDd1cTUkJ+HhmxdyW41Mwa9A=; b=CMYFJ42BgpYe4fHEqoK6qVMmJK
	VxwppwA9y8gVLfu5tbG8Y5vmGMG9EHuEZcLd2Stls8vmcgOj2fP8jhR/+rmsBdHl
	HaTc3yugOlfkCcEr5WzoVrkuM5/qEHcoFP9RVqtVxoynr8W3Mbare74qmbTzuAhg
	lceZexWY6TWELv3Ed5xeFvTklIhSQS+X+olUKBgflUeNWlCwAU5YgCxyipfDZr7V
	qu+RorYT69PFuz1hs7D1WTJ1lwgByxXgKpUoGDMZ1vK6/usQZ1heacM2czWQ/zR0
	wLVS93l2sXTNSmW7Zr9YO8UM567LBDfqwL/YJLxUKXM5Z76ZMEFqE09VfZaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746658264; x=1746744664; bh=nbf4q862hb2E9fINdO7iDd1cTUkJ+Hhmxdy
	W41Mwa9A=; b=Y63Z0E1txvHwJ9NGZeiWUmSSE7b0vEiFyFF+X0AgLU9HTkJTR0o
	s9T5CpDNlpckYC9g95PBVwRRUU5ap7eF8TI+CfPeS38mdMy4YksX0ROgt8sUpM+F
	CW8rJA934zO3kv0nIojdTjvSdeIw7P3vNwRazG3ilFK4tvgZ1LC4OPj4SiOUTidc
	sbc9BgTfv3CMb5+vBq9RhXEX+WfSqaXr3pMaQW5TDhoiSQsRRDBrXuN7rjNGQt3U
	r6QOdht0ZrSrPu1waQvwQI3zWqPWNIQZ4yX1Kw8jIqmFL/K6ytEVL0Q7lBwGZ0GE
	//Wtwj2irBnYlRQSDMq5uG1fbINwIu8OMcw==
X-ME-Sender: <xms:2OMbaGQtw9Lu8ScajYeS1SXIyJYZWJWDKoCL7YHBJi9A6ufboqsUfQ>
    <xme:2OMbaLxHCPDCXmQSWKGTYcWplLgKs_VHqwflftC3s-Dew2-rPDKTnmdoukophb6cR
    FHof2TfEE2HDHsY-g>
X-ME-Received: <xmr:2OMbaD3LqcT3K0dwTEw2OSkZ7evJr5iqTC42MkbssCUasCYOt6_pUjU0aehwU59qLy2AEg_Ni_j9M43qcd-Q3ABrCo0CxvGkPb_X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2OMbaCDDA9CZYGLgb4tlTf2f5Zp5Djk_WgG0CJwvJ7Smc2o8cueDsw>
    <xmx:2OMbaPiYrNBMdYLAKqpoCLSRGvlysSPEuGAAwkfQOg8ozjNtkHMmoA>
    <xmx:2OMbaOqNcoDyWqQk8_17NePb5pmqCWke_WuVbJ634y79egrDxrHDYg>
    <xmx:2OMbaCg6nM6GgFEVk5et97EuKuJ7ATX7YjHSWbMba--5CGfB-No4dw>
    <xmx:2OMbaJ89VX1FUIYJP42qFAqNLGZM0l9Ezx6Si1PyZIWDMggc2Nj1bnMK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 18:51:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 0/4] align the behavior when opening "packed-refs"
In-Reply-To: <aBtzn4nwLsI9p5Cp@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 7 May 2025 22:52:15 +0800")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBtzn4nwLsI9p5Cp@ArchLinux>
Date: Wed, 07 May 2025 15:51:02 -0700
Message-ID: <xmqqv7qc9grt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Hi All:
>
> As discussed in [1], we need to use mmap mechanism to open large
> "packed_refs" file to save the memory usage. This patch mainly does the
> following things:
>
> 1: Fix an issue that we would report an error when the "packed-refs"
> file is empty, which does not align with the runtime behavior.
> 2-4: Extract some logic from the existing code and then use these
> created helper functions to let fsck code to use mmap necessarily
>
> [1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net
>
> Really thank Peff and Patrick to suggest me to do above change.

This round looks good to me.  Others?

Thanks.
