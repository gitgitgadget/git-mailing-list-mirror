Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B9296BBB
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318187; cv=none; b=PhR5JT+kk6Do2oT4eZfDc2h9pL4f4LcmFNV9wgoJtMbBlVw+on/3AefYTYl1yI3n17ISu2Z05JSQyaEMh0TaBKh+jHQCvea4caElfgb4WRJRfaKkfv5R4F0UVu6+lgLrRyqSHD/meQJfyn+Wj7DwctdIjmiCopdHIoyi1MQgwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318187; c=relaxed/simple;
	bh=5mN8PJ8WfebtO2vtV2xMYhaNG7ESlX86iGEH6pWwPuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1T+aBgYZ/vNRxgegGJOO7/zpmyUTZwxrzJAiKngXU/iUTRlND52GZ28gek9+6cr+ewmfAZ5jJb3Juifvteq1IhUvBwH7E2/xr9wkqn/4CPXL+13hpSLGDNhjd0owrCPwbYRsW7wsbzpQFC/M1/C5LLc1C6DrT1CeQPJyKsZK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bxfUQDQb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jh2EYGFm; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bxfUQDQb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jh2EYGFm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66F217A0100;
	Fri, 24 Oct 2025 11:03:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 11:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761318184; x=1761404584; bh=XLiclouksD
	T1Mu2lzyEHolv2w3ZqbwBg+Oz7sdyaDmg=; b=bxfUQDQbRFrBztHDRy1neAu+t+
	b2rKmLqDHiVNJbFYbno+pOlhMzPiqZGhB/zyHZdaOEUBbb1Ad9GO7xogBDLa49VQ
	1QSCuBsszdzJTtTmZxLSZhxj14y3gB8YhNSZXndk1p+TqZLNLcVKESwe3afClaT7
	6vEG4PNMfz3viCkaHuPQt+RKN/pdSQZP92HQEwOxXTtuDaWnXOP8/BCkeHEQ6ql6
	NQR+9BN1BNxI+0hOZo5rkCdceXDqgs/thW8XjcEqQ6OPrbOH2Rbd+QNVJOn5VCvH
	2bxcSa5ESVqhF+I5K5YznB+9+U+IVOh8IDx6e/tUzq/RMdTPdm45b3MTLpFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761318184; x=1761404584; bh=XLiclouksDT1Mu2lzyEHolv2w3ZqbwBg+Oz
	7sdyaDmg=; b=jh2EYGFmW/k8ntyVfj4p3rVgAWdtr4CcDGsAijyec1pPPvgSRgS
	1DyOQT+fEG9xjxioVvHaS/9Af5fhb6eDr6s+aWR6sPBjrGq1lSCYGJJ0ixLw6TMg
	U5NN7f7VmRNjgNjbrpVoAQiE4OrTrAb1+wI9SkR62EugC0CFj5NL018IyrUZLZpY
	LY46Z5jYWiTC7IPBuubPKuAkF2WyOZ2pSNn+eMrlv3mnfMenmUbu+diGQKATNq9P
	9IqnMtqtG6WdNfNizPiumfDFKXt4bO/EctiZ6ELODhfQdhAq4bVomoq5v04w+gUo
	I7kyKpdt3OMOk48B+5x+b80bkFV4j4JXfAw==
X-ME-Sender: <xms:J5X7aMZSLdhfXHUvQC-qP9TFDLS_VXk8fB7uN1dajASe3VvIZ5JMng>
    <xme:J5X7aPkypIigdYWD4SSnHk-rUrBS731cZDHOYQJEUbVdO_GYoAgxyb6b2PI-c0k-l
    IGnZsz3gemRbOJeT1-WiLrLsc0j9kMEB-QxeeZtogtIF3aAnOof0g>
X-ME-Received: <xmr:J5X7aCgsvCi6IAN77TwLrROAR_YKIGPFUJO-3-HrNbuK445sbq5SzAFlO81kdmSFt8yeukUONaEIWYPWawR9xF5tTbKvUlEa6mTd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepthhm
    iiesphhosghogidrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:J5X7aBRDIy_4GvbzPN7lcD_o9Usv0unNXhBnesW6t13R5ILwVEEkbQ>
    <xmx:J5X7aDbLBeY0KmZlC-30w7BjnW_Dy9Ni0GWM_Mh7G-FK5-mbesXAnw>
    <xmx:J5X7aOTctkXoxhAAS2s9XnQlV0orR81vrf959KfZEMjd3LaMRd-t7A>
    <xmx:J5X7aC8ATCM7HXXX_2AwuOnMLvWQk12VXOAGmJrR2xVR2dfVDT27cQ>
    <xmx:KJX7aCM66xntsQnBnYEvxZ1hdD6qe3vM50Cv7ShuYzrZjtTbioW2vgMP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 11:03:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Todd Zullinger <tmz@pobox.com>,  Collin
 Funk <collin.funk1@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/5] fast-import: add '--signed-tags=<mode>' option
In-Reply-To: <CABPp-BGQ=3Tuik-PCerkaK4R0b1roSVLXLKs2-+E11vDrH6WaQ@mail.gmail.com>
	(Elijah Newren's message of "Thu, 23 Oct 2025 22:03:48 -0400")
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251013084857.1646783-1-christian.couder@gmail.com>
	<20251013084857.1646783-6-christian.couder@gmail.com>
	<CABPp-BGQ=3Tuik-PCerkaK4R0b1roSVLXLKs2-+E11vDrH6WaQ@mail.gmail.com>
Date: Fri, 24 Oct 2025 08:03:01 -0700
Message-ID: <xmqqplacqr4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> +--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
>> +       Specify how to handle signed tags.  Behaves in the same way
>> +       as the same option in linkgit:git-fast-export[1], except that
>> +       default is 'verbatim' (instead of 'abort').
>
> Sorry for not catching this earlier with the --signed-commits series
> (was otherwise occupied), but this worries me.  If we ship with this
> as the default, people will come to depend upon it, and I think it's a
> bad long term default.  Long term, we'd want to check if the
> signatures are valid and keep if so and do something else if not (e.g.
> re-sign or abort or strip).  Maybe verbatim is better than abort out
> of the options you've implemented so far, but I think setting the
> default now to verbatim means people start depending on it and we
> cannot change it later.  Could we change to 'abort', for both this and
> --signed-commits, before the 2.52 release, and then re-discuss once
> you have the other options implemented?

Isn't this series a response to the "we only copy verbatim and there
is no other choice", which we had from the beginning of fast import
& export?  If we knew better, we may have made it abort when we did
the fast import & export, but we cannot go back and change it, and
we cannot change the default with this series without disrupting the
users, so the next best thing is to make it configurable, which is
the point of this series (and the other one), no?
