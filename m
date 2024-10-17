Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133D433DF
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137822; cv=none; b=uOwfnsAKarrpYdo5itC4mq4CWHIlS39O2NTz8/LuZkmwn5/KhYdEVRXOPxsgcLLzAzXF+DECv2dmQNadC389skkyGONgzdPd195mEpM9gvOrhAxBLXsHzdopOREOzu4w9c10MmdfLcVndDeGbTz6wmyp/EI79VsCRsjVFm6D9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137822; c=relaxed/simple;
	bh=VHkAXt6xU/DV0rav7niV+8U5K/Ng8TjbQRWS1zCMCXg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r33TTzIEVgnJQOMWaOOb2DzI1PKlIipM/j/fqday3K/aHINWfJ5QrEbaZsf7pxJhKzliNIlhIIw9Z1/8Kt4zTP3dACfaQnbFbaYvCYq9rQUOUy8BO9cMdD3SXnqem0vlrgFHPK1eU0QLfP47J5a64CrxdIw1Cla97xsW+edZYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dD4fgDuT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5+twXFt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dD4fgDuT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5+twXFt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 73AE213802BF;
	Thu, 17 Oct 2024 00:03:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 17 Oct 2024 00:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729137818; x=1729224218; bh=/BhFD19NOs
	SCnF4jAWhvZUQgFlEz+12YqYaITgV3MhI=; b=dD4fgDuTSwAeyMu1yF74///sZF
	+yHtb/Dzq/5DjWEOC/sr93DQCcU4BS9oLrFpjYwgTKy8sf77kgsTEXLEFN38cwRw
	XATW1Bd4UqFHJa/izhuwpQ8RTI28PDQObnv0w06Z6BrJAdFb3fMsEha3Mwkra9mw
	zlN+A7tXk4/rF4y+9aseJIvpaSq5Mw4Yc4JD1C8LTy9GbJLodD1BosxkudGDQlrJ
	CWw30FvLoITLjA2MQT8MnZ8SxDuTMYM1/rr3w8jKTHgFm7y8ExtEZdbCnwcuS0Ta
	ucrZJaoEKAk2RCtm+HxtO0O19u4bYh1uoKu5kTDtfh/+pfdQo1z9D/0H293Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729137818; x=1729224218; bh=/BhFD19NOsSCnF4jAWhvZUQgFlEz
	+12YqYaITgV3MhI=; b=Y5+twXFtSDSKLDGKGSU0ICewYrD71JdTmazWZwHc3Ov1
	i3QzCfzMdCV/4BS59xa7uAoKxtTg8D/u5ST74NCkITG6ZFqVbQxWpU8o3pnnhHin
	sejsYil5KRBYmUk5qS/lXgzJKh4FOiOQohZn5cyaV0RiaF0o4/wJEkDXnNHEieSJ
	w8c4GgI8d2hpaGr6tUQ9yjdhE5X4J78dDhFAFDNnsIG3aS/5pJHr5JfOgVXiymnr
	muvJxT5LJnEkjYrQyGPRU7p1Wew9lmANugRfG/7QBNqUY7+YksLojbXXqn9b/A6L
	dlsexmsCR5QSnLOJd1yDwM9ER6GeUELlQ+O/W3hcKg==
X-ME-Sender: <xms:mYwQZ0P6Sg7rURne_sD5QVOq6f_4slEKSEDJ6wsr3OoVafcogPGZMw>
    <xme:mYwQZ6_cforzMUdEH6t-SCU2kDB60A-v89Nf0VNOh0oYfFhi4aZ3PSWgMy39MVuVY
    psMy62KvI_ZdjJQOg>
X-ME-Received: <xmr:mYwQZ7SI_Rzn77pD_HcBhTGRTAsKZpKK8i0l4tkBJvDZpBrfU5-xc_WAq9YVKY_shQa8A8RyfJwIc5atA94eTf5mbCLdUYXww_X-BHMrcSDQGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefggfeh
    feelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:mowQZ8tYmIPwzGxD9IG4st233-ofQ9eSgpk4Hu-3IquOv9K3cj4yTw>
    <xmx:mowQZ8f0Cwm8tH5K9z_ebn_uGGrTJhPuvNp1Fcuy0qJhl0TT10Lcxw>
    <xmx:mowQZw2fXFKXl9BSCa6t4pLMmI1gSIwslUrtbebKYALd4inOIJXPRQ>
    <xmx:mowQZw_47qD3B-O4Slb9o3CGGszt7KIOeyMnL3RsqBGmRCO5hVp_5g>
    <xmx:mowQZ77Z-6pXh6jIw-QrjN6HxpqFgKEwiXnz8FBrCGiOj8Yhxptq0l3m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:03:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af7117ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:02:15 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:03:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <ZxCMj2C0G_zkWuON@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
 <c046e5f03bf9e3eeda803133b88c3ae414fd0c69.1729060405.git.ps@pks.im>
 <ZxBj-VEU6M2TVL2W@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxBj-VEU6M2TVL2W@tapette.crustytoothpaste.net>

On Thu, Oct 17, 2024 at 01:10:17AM +0000, brian m. carlson wrote:
> I think this patch is fine for now, but given what I mentioned above,
> maybe we want to add a weather balloon in a future series to see if
> anyone is compiling with NO_ICONV.  After all, if everybody has easy
> access to iconv(3), then we might be able to drop support for NO_ICONV
> and the work maintaining it entails without negatively impacting anyone.

As you say, for now I'd want this patch to land in our tree to unbreak
our test suite with NO_ICONV. It fixes the status quo, and whether or
not we want to drop NO_ICONV certainly is a bigger discussion.

We do have one platform that doesn't have iconv, namely QNX. I rather
doubt that anybody has access to that platform, or that anybody really
uses it. So having a test balloon out there could help us figure out
whether there are any users of NO_ICONV left. But when it is used I
don't mind that flag staying around.

Patrick
