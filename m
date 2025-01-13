Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938ED1C5D4F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783142; cv=none; b=Aqb1D5LIQQV54lEmVRLQwPl6ORGfbNRSNx4Wi7IJ8GVLyNNvpFn5oBXFMQnWA0PXMt/Ph/sb1c+mhw86Z2lR62AyIbuQQ4eZneFm7zhqAflWVS6NVuc10BpLgP1AjBdM+od+EWivC7vz5g0hPAhoRInuk10xq1xsVkzetKFxyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783142; c=relaxed/simple;
	bh=InHDxHpsFq7sE0N2HLGHO7P2PwYKPpzCdmoZBaKLgYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eceDeohqg6LIoPxe1tdngTsgcLjd/n5Lj/JiF9gtYp/8C6om7CU3q9swFH7C9G5K+iqwWxkoj3jKtYAZNuDtkRlXDXmkny83di7opZPsQprTYpXZx0QwS/GDYTv3gTDp0RHFBFUQWKUh7JCkBrZBAA2DYk5eT5vL8NlbuvBkEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Aecww/rZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i003pnCJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aecww/rZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i003pnCJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AB1B613801D4;
	Mon, 13 Jan 2025 10:45:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 10:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736783139; x=1736869539; bh=HkosegdZ4j
	tuZDw38lHPIxk6YykTzoH17/3TSGZ16wI=; b=Aecww/rZPWSBh7jz97hIRpj4K1
	bwLBtLdEkxcMXiuypL5m8VcooObga8c7Mpix6s5KP3PrA407mVWxLOSmSWgHcI3H
	3385uDQHRMstu3yd0aoAPu6T0muDrEzqFwaiTxl/Ha4kiZD4lBR29oSLug0dBKiF
	LNxag2xJeAu2psV6TdxkLGPUGCuTSc0lp+g1HnuKfVsTN0J5aErW2d6sB7NlRbyj
	n//5T7kULx/UvmiJkm9JfC4qhLpEgW/FaH1GwzKSQ8jQi45Dz7B7HCTrH01ut086
	3F90OUmcJ5xvftqvrApbszpNskf1YQGRpXy1jYggtHRub1jvONaG5FMYdFUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736783139; x=1736869539; bh=HkosegdZ4jtuZDw38lHPIxk6YykTzoH17/3
	TSGZ16wI=; b=i003pnCJautg7P2c3KHkqwhz1wuYaMAO/9qxF0b7Q4GYyRfSN4x
	c7ACpJZ88EViWuYgF6WhhuSWe93yGFWb4b2SIZ2Gsk1+2qFqei4wqAfyvVTlO87e
	4kCviJWeVdQw+PBJ8edTG6FLX58gDNwC0sKBNW5Tjq99gJUJla2S5aVutxknZ8Vy
	QIQAKPoNkXcXHBlE/UzFyvM2PVYA2jW0DGhkwkJQl1oCV7qa2m1yKAAno2vSciGx
	v5q2zNqlkwJp22XzFWQvleOg0OK+PaaD2YqksI4Fef3drJZXF/jDCRO7+49zKfDz
	9cmcxgUaL1jHzMLkTmDrbTBFRzljy9+Zayg==
X-ME-Sender: <xms:IzWFZ40UpiNHy-YtFimPUfVScmrbFJlnX6HFUYMIvDZtwS7W2B5U_A>
    <xme:IzWFZzGKH-ROWVFdI_StD-q0aRv8rPLk5FJpY31rOfLNxBJ04DqzFJz4lgmy0RKTO
    anJas4oPoWOg6ApSg>
X-ME-Received: <xmr:IzWFZw41IlJfKNcDMUC4QW1KuQ_bUTJcy0xfjTjdLOUHh2hpPzkS5n5NZkOV6e9IWjCPoBPAaNDaoq8B4lURcTTntSUi-OAMvbj5UBnmGSBisZVp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IzWFZx2XBgamjO0T-x4wu314tGrnk5CoHgW8nHY_K43HsjlWH6RI3w>
    <xmx:IzWFZ7Epki2iyUC5xZabc1PUv9mZJzrRjhMNbNWM_GCqECCDcWEl9Q>
    <xmx:IzWFZ69iwyY81_hVviDh-marFagbMpj8-2TaEDd7546LxV6ki4eIRQ>
    <xmx:IzWFZwnQyzkBdkGEuhvn-jqQdA-U6lh7yIgLbtJu25WjUNpF0bM0Pw>
    <xmx:IzWFZzDPbTO-C8G-_b6X0FMXW5ItNjzCWEkBWtzoIU6lQum4v_4TtU3n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:45:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c92ca11d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 15:45:36 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:45:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Bug in 2.48 with `git refs migrate`
Message-ID: <Z4U1H6pe0NL0cOBh@pks.im>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>

On Mon, Jan 13, 2025 at 01:56:33PM +0000, brian m. carlson wrote:
> If you remove the second block, it does not appear to reproduce.  Some
> investigation led me to the conclusion that the difference is when
> max_update_index is not 1, the header has the value 1 for it but the
> trailer has the correct value, and so we flag the header and trailer as
> mismatching and therefore it gets marked as corrupt.  I believe the
> reason things work when removing the second block is because that value
> remains 1, and so it works.

Hm. Makes me wonder whether this is caused by the newly added code to
also migrate reflog entries, as we'd play around with the update index
only when migrating those. Cc'ing Karthik so he can have a look.

> I haven't done anything else to investigate here, for which I apologize,
> but I just wanted to mention it while it was fresh on my mind.
> 
> In case this is helpful, I did see this when attempting to migrate two
> work repositories with lots of reflogs and many refs (the smaller has
> 2983 and the larger, 44832).  I obviously cannot send you these
> repositories or things in them, but I'm happy to test patches against
> them.
> 
> Please let me know if I can provide more useful information.

Thanks for your report!

Patrick
