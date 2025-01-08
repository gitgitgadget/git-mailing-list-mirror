Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2643FBB3
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736318181; cv=none; b=ZqP0MBydTaxAy6CJwdZvIzaSfKrNnyj7otP3hh8KSeu09nhOFHkNon3aRufqoPSCZ3zL4Pn/6xV622eyGcwCDYO1jfmGgjuXAUaTDPZ4kaL1JW9rJE6WsSe02t0dl+rgMEYNfXxXXd+nv2SpJPv0f0BOvubozkXm5KJGt+rDLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736318181; c=relaxed/simple;
	bh=0deGK6iSTsLERLapgTGNA5YBBhEv9zhh1PxlNNEn2Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrLbLNloFF39fQNzX+udEs8K7sEq/dwmeHfRQ4x6OqePSb0IAlCUfIhnbBEM90VLiuBmr81ybWXlcl2KGS4unrMj1aCIm9602e0KYjPoiQ75XIa1Dj0+9vedwozJKyHxd5x7lZLz9GpPiFsCbDmZZpFockYAZH21EsGJZGKNURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDzoj5vq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzNYdgJi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDzoj5vq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzNYdgJi"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D081E1140162;
	Wed,  8 Jan 2025 01:36:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 01:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736318177; x=1736404577; bh=1WsOJsFOmB
	DLVnK2JElP2bIpw7kmb5/7fZHvnismHqM=; b=NDzoj5vqpsR9MJVr5koBkJej0e
	jr8UKDkYG4H2zw01Ly0r8/WgzEiqDNlbV2GSCuzzTcGvX+X3OSPGIs9bCX+hZUNj
	ifJkO7p7C7oYfb3cHP9yoh+7NQAzG7WkIfiF2J1QSbpYKm4g6Q0NggRCk88v4p7h
	KAQPjSW9o8buWCznRYrzyfLOb20y+KaJ8kainrfMmfOUgaNkPs41nvX/znOs0BDK
	ufEQFXjUuBK2qUtW1d1XaqCIn5KyW6KPtYb2lBUoL11hmDLYrYhYuJero8XB5CLi
	qANwgM4PSM0CmAqUuOdvut0zPMznOHOh7QU6sb4mKAtyc5Ff8JtHqRzs9fmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736318177; x=1736404577; bh=1WsOJsFOmBDLVnK2JElP2bIpw7kmb5/7fZH
	vnismHqM=; b=EzNYdgJiHFUHMQcINut+T1irf18fr0Hkl3LTC63Ekj862ddRkZa
	RmuqIKhAOMDghTwkjApwIQ8ljzqQcLnQ4A3WivacQXe4GYJmh69MtD44AYQRaaVW
	pZwCraB4Xyll86D7Knu2NvdvY/uBI34gYp4OqB3PfdQ47b1z1friJIwiRy5sYCqt
	LdJ8rwYZ2NK6DlQWs48I4rhdjwbQ4JbQ4WNytp0cEFmQtKN3uGjoz35O87E+fZKS
	VKlZz6pqlgGfpQwAhmJuKiALgyiE0Al4RGwiU0odYT3m4G7Ne3f7zhDhQBCeuQE/
	tBd/IBhUevp6SvcOdIf3WWAYLWb0z/7ge5g==
X-ME-Sender: <xms:4Rx-Z--LLwaeSQNCb_5VxUg-gVhSFuh-U3Dgfa0TnV6axSCR-891kA>
    <xme:4Rx-Z-tqQeSLBBsE5qB86cWQubrtQsURrH_aQkp_h_ck3WTmYLGvVpZEJWqK0DKnV
    82LaLxSolVLb-XtVg>
X-ME-Received: <xmr:4Rx-Z0AA7kdnZM91MP28W3Ic2lBFS19pSe47uyY2ahzZawE77mi2dwYj3LBxiCIts3IF_4vQItu1_r9naEYUo4FUt77fuw-HQQ0z-GEi-om9RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhssggvtg
    hkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4Rx-Z2cHc3QMXTeXl_ROOpJhRsOtN8juOcLrrg1f3Nzk8T5nGcWrIw>
    <xmx:4Rx-ZzN12E5_g6FU_bUWdcNkXTJFjAhswCzlmJQG4a3RPDBbpLUqHA>
    <xmx:4Rx-ZwlVYNGt-g-uu7MhHQn2znDt9ip8_QALK8SRJ3XA_rM5sjNd4w>
    <xmx:4Rx-Z1vcU1d4GyVQDSEReNQs4dF5RKC6lwgjTVYcPaT5ZwlH2rfniA>
    <xmx:4Rx-Z-2LJ-CAQkuhImDLv55tqzRMd85d19eB5Z2wCX99Tup9HzT9068B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 01:36:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67ebf5af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 06:36:14 +0000 (UTC)
Date: Wed, 8 Jan 2025 07:36:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Christian Couder' <christian.couder@gmail.com>,
	git@vger.kernel.org, "'D. Ben Knoble'" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z34c3rj0E6hP_kHN@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
 <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
 <xmqq34hw0whh.fsf@gitster.g>
 <Z30hnx43mEwjWqzA@pks.im>
 <xmqq8qrmvap5.fsf@gitster.g>
 <xmqq4j2avaam.fsf@gitster.g>
 <006701db6124$f16f9420$d44ebc60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006701db6124$f16f9420$d44ebc60$@nexbridge.com>

On Tue, Jan 07, 2025 at 11:55:16AM -0500, rsbecker@nexbridge.com wrote:
> On January 7, 2025 11:50 AM, Junio C Hamano wrote:
> >Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>
> >>> Makes sense indeed. We can easily add for something like below diff.
> >>> I'll roll that into the next version, thanks!
> >>
> >> It is a good start, but is probably a bit too noisy.  Can we make them
> >> appear ONLY when the definitions read from these older sources are
> >> actually USED?
> >>
> >> Thanks.

Fair enough, can do.

> I like this but wonder whether there might be some way to inhibit the
> warnings one a user gets it and decides they will act but do not want
> to see the warnings any longer? I have had requests like this on other
> products. Just a thought.

I guess the best idea I have here is to use an environment variable,
e.g. "GIT_ALLOW_DEPRECATED_REMOTES=true", along with a hint for how to
enable it.

Patrick
