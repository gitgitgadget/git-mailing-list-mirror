Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8EF9D6
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631929; cv=none; b=EI5Gdz0K5JuudTwoPHuOvR03WSpoAKUYRLxHH7vIJc7oZpLp76+5/gMxAytbxlFJcmWuJ0CkKMp+XO5igPe1LpxYC0EfZA35eaSFMzKgjpyEGTIebXP97LP//3e3T33xj9xr8M2ib55SKPHViIAM3WgeBMBQltj3ZWc2dzY+DWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631929; c=relaxed/simple;
	bh=U7g3DOVwTtHelFxjMzK6zCJhTm50QcI6DcvXE1CW7q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDYSfN0B+USESC9j7nvlTjc1aOe8oMNkEyz61AsW9twDxPJRuerHETSj0kyTx68AY9j5cSsG6b/hfG8pMtPrREqy98i1Y2xblsxidef/2ZYBzPGu6hu1moEuYQFVAGQafwA8RWZh6HDs/e8GP9WgD7oKv/K9Y7zbGBFGEXuqwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FYy7VQSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WyczIDzW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FYy7VQSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WyczIDzW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4ECE11D00132;
	Fri,  8 Aug 2025 01:45:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 08 Aug 2025 01:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754631926; x=1754718326; bh=ZRLA8waes2
	Ebp1Ufk3sKiK3OASqqQVPJzJAIqtwZLdQ=; b=FYy7VQSyJVzbnGqyjbkP9FZuOF
	kjY08gQocRjYEV0fGnB0q3i5crffDN5yxJ4YFLEnTR5KBV+Pbb2WWsIaorXbKF8u
	O1T7Ll5SvqWb7HtGas3rbkYZ/pypX2TgUAB8Ogn+qpj9F0LxY6lW3rMbmFVS3wfA
	uiD/yLDxRSwnErSG9EuzeHVJml+CvwlSHUTvqMvg/JSmDa1QqeovMs8tHJDkvWOM
	Mw55JZNX/iDpuHmv9stihqyHbrEPSQc0CGnelIMNNXNd3XUDqayU4vKsekCtirdU
	aNoZlY2bKkKazmGSwzfcs8LmdR2CfBjhpowWZ9M0qkmNe6I+IPKPIIRyLinw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754631926; x=1754718326; bh=ZRLA8waes2Ebp1Ufk3sKiK3OASqqQVPJzJA
	IqtwZLdQ=; b=WyczIDzWpAC0fF7NFdFYCBUAYHOwTMmZE8lV+ILq8BhOSyjx9JP
	QE8H1sj8kwpFoteU2f05I09qiEPRpkVWxs0LtwUl1arXcSmy3mkXeAoOo47Hd4KG
	aR6495YMgn3Y+I6jGLVDiDP85r39+1IFvO/MUw3wWUxKeG9wzKCxJI2YvqrtNnbk
	ATXt4vycEUvz4fTUo2jQ8puA/Z5rQqkDJA30Jo+4X0vBFUAjLkbDYY2f6ZATiH2+
	uWlpypWRPcSSftoz9Jgw3F8jSDlVBYnWdZBCuh3+WDoINZ2drGV9DCKvs7z4ym+C
	WTEla3o/8u5eWxzHyQVrzSmr35wiPxXAUog==
X-ME-Sender: <xms:9Y6VaEc2PoRjqkW9ShzQh3FSfwy9em_2CpxCQKMJHcToW6E_OIGX8g>
    <xme:9Y6VaDm-0iqsj-V705eZyQL6zIDiljwl1ij-TKS1plPNkIFUnXW98D1fzvjFmqntw
    wPopgaXd_NOsU5_FQ>
X-ME-Received: <xmr:9Y6VaM2rMDaCKEKUX26x0rIMslBvRGQSjYImPf4GJZqPhACHY_FuZ8LHuO8uiZ88MTpBP-gDzrWswh3OOEaXPsOaC83QdKSreWkDkY6GuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeftdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:9Y6VaEe9z4fgk6RAIvgA-HM13s_pRDr7XJowXeCqVbYZE_HYnr6bfw>
    <xmx:9Y6VaOZxZ0meWKFGuK6JXaYjUUC4qYv7zobQhlEFcAMG8FenN6bp8g>
    <xmx:9Y6VaBHl4i7IPz0OaQvYrHg6UlzgbuLBjCofhXwiEC45Wqv1EuNFqw>
    <xmx:9Y6VaElUjRztzVyQWjw7Kb7JJZANfuR4BPs9aXzsf6sX5yfOHysHqA>
    <xmx:9o6VaMspv0ilwrWtEQ264_YpuCZbnWKb8M19Nc82oxNW0D6zIKDynagw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 01:45:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5e3db01 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 8 Aug 2025 05:45:22 +0000 (UTC)
Date: Fri, 8 Aug 2025 07:45:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v9 0/5] repo: add new command for retrieving
 repository info
Message-ID: <aJWO78GrsUc7iBFt@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>

On Thu, Aug 07, 2025 at 12:02:34PM -0300, Lucas Seiki Oshiro wrote:
> Hi!
> 
> Thank you all for your time reviewing and helping me with this patchset!
> 
> This v9 only solve tiny nitpicks pointed by Karthik and Patrick in v8,
> just to make clear that everything is ok!
> 
> Junio, would you mind to replace v8 by this v9 as lo/repo-info in seen?

Thanks, this version looks good to me!

Patrick
