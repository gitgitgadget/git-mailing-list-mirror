Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECB248F4B
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248925; cv=none; b=TXBf+Lk/YtmAS8GxxTJxJ7hhj8jgVryb2opeJtNCtxzviITiOdKq4K7iH84f+7Auxmh7zLrH39esCKOVwZlXmZDXz6NPQdbWMfnbtwF59Z7wZfGOp9bcZWyjS//lfQClc0HQsL+f6VY2zZLlwUuWyzNUONh0c+nlY93yn4ufq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248925; c=relaxed/simple;
	bh=axdy4gaWp/yr8HPwp+Gotxi/+z17DZcM0POsAMb20UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsReXuRNt77UZVYwMNpwqAcFS/v4sQF71/LP1t3USgB146kw8dK/eKULQW9pCCzL4RUO79e5sqcxS/FIupl8dEvK4r1mhGvsPToCc0+uSe55XmkLD1U9oKRWVd0hhBM4/lVaNqLf6IM55awtdg6oiUUP0m0lGpLu8NHebrfcmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Va2W/lKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0gGyLuC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Va2W/lKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0gGyLuC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 78AB61D000C3;
	Wed, 23 Jul 2025 01:35:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Jul 2025 01:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753248922; x=1753335322; bh=/zDry4lOf9
	XJAtGYGdAbr+Na0HJoJmumRWkbU+IdOLU=; b=Va2W/lKmzI8dARbYJHMHW9pUhK
	/sCt5Lt7Rs8DvtxjhqP/F1hEgMOZUHM2jFr4SK1cct5Rj8xhUJkaN4GddTcDhLla
	Ocunyvvkexz5aQHt5FRniACV4O/bkOKzCOCweC2dHUnfP/EvjEbWeO9gN1SPQZZy
	VE2V3WBe8zwEIi2CrxMeY2rQ8MOnlQ0WOlojN1y0wxYFVBESnAZ2zhuzdOxMkeyb
	A8eNJny/mCWcC4KTXw9Sz26bRUrgqW+dy8TqZUZxJyEEPxBeWF9aRhE1BRkMlht1
	Eq9YxRwsENYwxTVX45573tyt+Z3QskU2YMm9mmlDgngKs04hvIwByMPMBnHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753248922; x=1753335322; bh=/zDry4lOf9XJAtGYGdAbr+Na0HJoJmumRWk
	bU+IdOLU=; b=I0gGyLuCp0v7RNa3SqCAcHk3AhVSDFoTY4+Vev26QuOfwilDHBZ
	O7vkRsrSe5bQuSJ4UjSaCraCARpH9yH3AlV9b1PwHVLeWdXu83YZd8/SIOVx81eL
	D+9fE74CXU8ab7jKZ5caFCWaxKhW7NIrL+mudi9jcv2YLKaPWyz7qwi5wgJkSPIn
	BISE1v6OLgG0Bh6sE63OqTu6r+M6pGT8U2TYb3i9/csJA/d4XXcPaGCKGPbN7p3V
	o5CjfsE+oyi/98JVlCXWJgdzCgyOmVay9avWafmg0/ZPCoxr7iCMlJgKmYaEAZus
	8sMqMt+tIDKxqFudBj1MOew3G9dtGpvxaRg==
X-ME-Sender: <xms:mnSAaNGFYo6R5XaPPA7nyahqLWfmdJxEYfw5B0v926S_ZRkAdTJlRQ>
    <xme:mnSAaCi2IfNMTcGp2shW1OVJ4BzvaJmr1gbT_gDCKb2RoMbXQgcMsR3B-1h4gFs-1
    bNk8G3ROBU-NXy8Kg>
X-ME-Received: <xmr:mnSAaA_IvJPH2hG6mKMWxIDoJ3e0WphjVOUEGXTlj1R0y5hmn5W3mgR7lpiFQ2453Oft-qRwru58c37Ea_h29UBrhikzfS_LtxYxZBlwL1k3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejieelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mnSAaBomudyVZ6Wvql3Hzg2RoCSdHVCaCYw7taALL9ABTxFm2ClzBw>
    <xmx:mnSAaH-AoJwotadUXAV5wZeWOWipg1qJZ0xZdZLO1Nnl5DaWGcE-FQ>
    <xmx:mnSAaNWCcVbO0A8CBnWBFWLMjrxozj9zyJRb8P1ZQ3jryGR_7YWXwg>
    <xmx:mnSAaFAKDs699ylyaCzcsCti02ACodxWgO1xTDKOxO6PR7SfzRIc8w>
    <xmx:mnSAaPq9R0yjhuRYVowQEY5iJ36c1yhKijNFBxBduoFE-s9NRsGfoBPS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 01:35:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 337c0321 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 05:35:20 +0000 (UTC)
Date: Wed, 23 Jul 2025 07:35:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #06; Tue, 22)
Message-ID: <aIB0lUS8OTq-oPw7@pks.im>
References: <xmqqwm7zpxzc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm7zpxzc.fsf@gitster.g>

On Tue, Jul 22, 2025 at 05:11:35PM -0700, Junio C Hamano wrote:
> * ps/config-wo-the-repository (2025-07-17) 22 commits
>  - config: fix sign comparison warnings
>  - config: move Git config parsing into "environment.c"
>  - config: remove unused `the_repository` wrappers
>  - config: drop `git_config_set_multivar()` wrapper
>  - config: drop `git_config_get_multivar_gently()` wrapper
>  - config: drop `git_config_set_multivar_in_file_gently()` wrapper
>  - config: drop `git_config_set_in_file_gently()` wrapper
>  - config: drop `git_config_set()` wrapper
>  - config: drop `git_config_set_gently()` wrapper
>  - config: drop `git_config_set_in_file()` wrapper
>  - config: drop `git_config_get_bool()` wrapper
>  - config: drop `git_config_get_ulong()` wrapper
>  - config: drop `git_config_get_int()` wrapper
>  - config: drop `git_config_get_string()` wrapper
>  - config: drop `git_config_get_string()` wrapper
>  - config: drop `git_config_get_string_multi()` wrapper
>  - config: drop `git_config_get_value()` wrapper
>  - config: drop `git_config_get_value()` wrapper
>  - config: drop `git_config_get()` wrapper
>  - config: drop `git_config_clear()` wrapper
>  - config: drop `git_config()` wrapper
>  - Merge branch 'bc/use-sha256-by-default-in-3.0' into ps/config-wo-the-repository
> 
>  The config API had a set of convenience wrapper functions that
>  implicitly use the_repository instance; they have been removed and
>  inlined at the calling sites.
> 
>  Will merge to 'next'?
>  source: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>

I think the only commit that really needs review is the last one that
fixes the sign comparison warnings. As long as people are fine with that
commit I'm happy to have it merged.

Patrick
