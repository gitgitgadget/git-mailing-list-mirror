Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7C1537C8
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317382; cv=none; b=cWKA2GjR8knzZEiLSWV4wOfzzoCCrXVNCd29SNZMrmRlFhSXiDMElwli8K9UBJJXiMymFPXrqLyQ0Vv6xAacxNUyrrcPfckwpDGICOCfUjCN7xeTTmBtd4zzZqo+0QNybi6SISSejdJc581/7d/a+hDLa3tlXfj93TVTT53RJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317382; c=relaxed/simple;
	bh=m/EKGg/TIycuCuU/hI31tug4p0Zi5ZKx4WZYvujThsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG4reT/PzGY/I3AUBzYOGSvy90NR8es7MYRXkd5kXF13MmZ8gGUMutibeSRPNES74f2/fmyw1WJlieU/gYdCykc2rtwddBG7sIRrDVMNV8qnDFfjb3pQDQnbgxkSweMD2FWTOMhw7SKhvCHilmaBHe6Eg8McYmf2QsKg7Yl9RlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RkHxtwaB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJHMfWt5; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RkHxtwaB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJHMfWt5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A53F4114019C;
	Wed,  8 Jan 2025 01:22:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jan 2025 01:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736317379; x=1736403779; bh=m/EKGg/TIy
	cuCuU/hI31tug4p0Zi5ZKx4WZYvujThsI=; b=RkHxtwaBSChU/WIRgKL94gzfUI
	QgZrC+UVtybLXSf28WJ6JEqDu6IaJ9J7084IG7Wknj2dEUYezOXN0RJTLNZzVgjp
	k3eY085szKWc0LJrf/oQpMaBU1vwp5eYGXTCVAM+fxfKGIsPDg7C9isFSPTdioe3
	Q/7kEc4OL5ALZjDjfM6/9xr/NqMeHZitQKV/bPDQim1gWEAygEmBetcwNdXjFgJa
	6cRZRIpFV6Ps6+IrnAZd8o/oUZx5r0U8Uzij2pZX32JNxo2vHcucYbfOHnxlp+U4
	4ZH1xjCed1HTaCEy1FA7WhFdqaGBv51n4f0r/6uhSUSCKJLNjqIObt3dyxRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736317379; x=1736403779; bh=m/EKGg/TIycuCuU/hI31tug4p0Zi5ZKx4WZ
	YvujThsI=; b=CJHMfWt5Q1/J1MO8r4yAQBW19SM0PGHx721+J6TJvvBJjH4XAHv
	THP81eThHQVR0pFLBSpzRte2pkmmug94yGlaJwVIfraIQQp/C4DaNQKTazaR3e85
	PPsvN+LLRCKhYBADzwVEWIE3Rh5d2iBAXCft8aLELpd3TLEO8RAESwoGuvUfv7Rd
	SB5W0VCwo412hY6ifFjqllXYExa7BwpKXejvBTRdB5x7pgrql3BPuRj4wVgRbtub
	63NbdH0fLQOG5YRN9x2WyECDeJJTl2/zoFpypjMrq36ItEkQT6lnVbj2Yrjm0F2p
	1SzeGU04xsqGdnOFvOXIAtvXWPAzgqM061w==
X-ME-Sender: <xms:wxl-Z9GfKcQirWgXF4BliEjP-QxzcTMjGAO24TMaglnkz5kUiTycaw>
    <xme:wxl-ZyXu8MWM2pPBvJoGWjoz3DC8R7IGWz6a3Ycjwl3Tj-ArRToj8rzipcP65KyBM
    uDXuvOXGr4eFEmMTQ>
X-ME-Received: <xmr:wxl-Z_L7BlWOQ2cGb0Nx3TE4Fys8nvgwR8QDijWnxpnK2LrilwZQkTeGBHtADTgyCdVq4uuAESJr8Ms7t02XxqmKXKB_ygF54laVyo2lvD6CXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    rghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:wxl-ZzEeUN6jAkKYCVNQljFCmecfkb_l-axcYSSdD2GhTEpVF1rGrA>
    <xmx:wxl-ZzWlrDLE859_D2IgG-gUySMGy1rOZ3D_X2wA1xsIIoUcPDrOBQ>
    <xmx:wxl-Z-ORsnNdfVy9onF54sOoIzTFJCE678gy1bfpUxSFguk1OzQW5Q>
    <xmx:wxl-Zy2h-3tVroSl4hfB7AsEk-bsgsv5NDNkB7ygBYAy5XabOvjk2w>
    <xmx:wxl-Z-QwGMujli8Y_Hqz3yh1H0oAqwR1eCCOy7EiKrCJgmYO4N8ICYBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 01:22:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 429738a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 06:22:56 +0000 (UTC)
Date: Wed, 8 Jan 2025 07:22:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] meson: fix perl dependencies
Message-ID: <Z34Zv55SSDexBxHQ@pks.im>
References: <371571630df201b0b0c680f6437decc6c60ecd3b.1736307757.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371571630df201b0b0c680f6437decc6c60ecd3b.1736307757.git.sam@gentoo.org>

On Wed, Jan 08, 2025 at 03:42:37AM +0000, Sam James wrote:
> `generate_perl_command` needs `depends: [git_version_file]` and the uses
> in top-level meson.build were fine, but the ones in perl/ weren't, causing
> parallel build failures in some cases as GIT-BUILD-OPTIONS wasn't yet
> available.

Thanks for your patch! The change looks obviously correct to me.

Patrick
