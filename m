Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EDC2F84F
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329608; cv=none; b=qKi/X9Z4YC7RxpxXwTG3ZIDTbUVuMdJefkcZVozdVemDQtg5bLIoK5l9inhGsRHTOyKTSky1FqWDmDfeMbeokjIah+AfJICEJlt219T05WxKMBrylv6df8vOhKM7xER+y2YZmTrfSNrvnvwEg/oXw8xlyB2TLA2TTRx9EMF7FuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329608; c=relaxed/simple;
	bh=sqej8k8Br+X7b4MTVclsDONpo/WAHoMuC2KEdr/SO+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RWELnwZzrKxW2kQnz7aKP8LnifbyYZhcMHk66mv8zAZb9702A+wJ00jRFPvO9xs0sj+JOQZ7TWKNBeb7FYMfwkFKn9tSZw5PO6V3SvNfr6+AQiDBZ156kDqs6ZsdDZ6Pcym3FGoOWtSbPJO0AHk0mcie2V/dDidMC6CEIFem3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vMfmYySP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXfZ9BlQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMfmYySP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXfZ9BlQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F25C1D000E5;
	Wed, 27 Aug 2025 17:20:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 27 Aug 2025 17:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756329605; x=1756416005; bh=flznyJRJsy
	Ly/F63OOvb9DHJ8+B4VLQb3Jg4SUM6sUQ=; b=vMfmYySPH53l86XHrYC6pSV4u2
	V6jkLjm9EPrvtamMlgMuzwX76MmDJ/Lo6o3Xw+qgBetfoIp7m3c/m3GuMrhsBcH5
	DZIfZcEC2C/FCofvh9AwLd5vjja/+A5Mvr8VbPzTHkho+qxIBFZznkUEWOc6vSPm
	bFRozAmwBasW/KHQEWwTmStNCNVBcZLioiOaHiXYR0oosPfyd1A/kxnbuTlR3Wb0
	6MVBGUOYIQNEYDaBXsX8ln3VR/xMLj6XyqtsutllsuQJWKPhimRsVFFkO1zFlfTB
	tGTTwTv6pjffnuG56xgqKSTBm+na2KD9mXk57Y6v0ANvtQAMkxvDnWfrrGeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756329605; x=1756416005; bh=flznyJRJsyLy/F63OOvb9DHJ8+B4VLQb3Jg
	4SUM6sUQ=; b=dXfZ9BlQwH/vAN64xD61eU9yxAncJCztyUSuQdZ+BpxuQUjYb/z
	44/DV6aCcpcVa03O6kDIlU8MG+5P0w52axrSrSNhCSh3tAeEqWRL0FA4W35fXsi4
	iKyIe1TCykUC74GogNFuybDOiVrMxYdNGTRkrqPefKNcnrxa4+HaRaDJYvCX66RU
	V/i89q/ZRkyctfMOkSGBbXxfHX1WCQiQ08n4RYMtIBThqZw9+AszueWEqnpYxl/B
	6snIwwhZs+K4ghKdHtW9rSxgve4lbt0RrR8MqO9J+xcBgmW1nbjeB1oU1Y+66Na/
	/b5vCbVCM39djMkLEuisN1iQn7kMLjo+kUA==
X-ME-Sender: <xms:hXavaLYLFDVRN1BvTmXpIHfriLyD6Jvz9yrcEwGDuJ3WPncv-1UrSA>
    <xme:hXavaF4T6d7gOTT4ESev-nLz_0uVUNqK9EdQR_ET916Y3QkF8ImKB_9qiJZ64lj-B
    E4L02r-lw3m-aeHig>
X-ME-Received: <xmr:hXavaEbd7DRm7aOCCu_GDDQFfp-tw-ZPJKCWbq4IL6jLPNB1T1IbSOgnBC-ZEXDqb44K9YpnItj-bUbGoqY6pxMkp_hqv8e76n7sepo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeelvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hXavaMjXRD2nrgTq67Rbi74Z0e3yclRw1t2i6Ck6bZtneTBRkWq5Dg>
    <xmx:hXavaN_piVBPISzOI4WB1kL720p8Ruc-XNvJ_a6fxCunKORSQueDdA>
    <xmx:hXavaPo1pISu9OT_317VbUIrbbGeBklKcNyQEUyJu8xl5s3hkRyPAw>
    <xmx:hXavaNXYUoi9-6iVTHDJECvxE21nC6gySJdaKDvIz1V7Ma7w1yLAOw>
    <xmx:hXavaAQu0fqJ_Kgm0gesD6h8kAzLmDUHEBLdX9oZmihirCpnNAPMIoA1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 17:20:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] usage: help the user help themselves
In-Reply-To: <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 27 Aug 2025 17:02:28 -0400")
References: <cover.1756311355.git.code@khaugsbakk.name>
	<e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
	<9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
	<CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
Date: Wed, 27 Aug 2025 14:20:03 -0700
Message-ID: <xmqq349czcl8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> That's still inviting unnecessary emails, isn't it? It would probably
> be better add the qualification that people should send the email only
> if they were unable to find any workable replacement. Perhaps:
>
>     - send an email to <git@...> to let us know
>       that you still use this command and were unable
>       to determine a suitable replacement

In practice, people will respond to such an instruction by always
sending an e-mail.  Asking others who sound as if they are promising
to give answers when asked is cheaper than investigating themselves
;-).
