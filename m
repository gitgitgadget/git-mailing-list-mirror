Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F6304BB3
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035632; cv=none; b=po5I2sB1mwL5/V5i2H8suvSZ0TkfGsLRA8gjS7WNN7kv6hTFgpgKPkbQAsUQOBgobMfdCdiRLQ5e5z7bLhhY9400n8h6tGnrVL8g2LNUbNLn1EeT6OjQIedUeM5civyEdDxSlG/kFj6oFZ+B+OFenFTfzpagDWzkJHGXuRoAFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035632; c=relaxed/simple;
	bh=yxnc2OZoFus4oPoer5ZX1lE6KBJg8bwz075ywcem2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDXiEdOYgsb/k/n/HcfhVEqIqlcuaVukEYTJQXWalJVbTook2tDC8gKogY2niUCQc8fNDsq8NedsUCFMkc/3PXXVXw5gHdTK7KcqrorKr/RDemItnOFFIEKXH7zDplYQcGPrGxT26OkpigXYoZpJYjMKlWgAiNQ0DPrb0SfTc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VRzZ/sU3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAcb8rCM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VRzZ/sU3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAcb8rCM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DE383EC011B;
	Tue, 21 Oct 2025 04:33:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 04:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761035627; x=1761122027; bh=PX7Ge6w7Xg
	U4MnYjnO2ueqBOkBBHY5qNs53hcOlBee0=; b=VRzZ/sU3fAcE/lph9IwrmdTlcd
	XV6OozLUFGW+U2SIOGN9fao+JnKIbqO6OuYQ2zZMLgSCHdaIKZc6tg8wzO66dC+c
	URUTfG1XntLAoclIJlJgelgTBzYiNS4pWXLJWwQwSLCruzPAiWHdUH+2SR6CKtqR
	BBfIe/24R77UDHaVJhFo/sRk7eMjleAJtrQ7jiSkQACcLUa0wzqQgV9in9KBGcEx
	RfWHUvuZCzOj/VqlHgJatmmadP6bpt8A3ytcY9T2HGisdPgr97ItdLzY9aEyaJQq
	hZxHwtwb44DOZjWikleSdHdnNT9Uu5kxvbYpmsDmoiynXVNGWhKzTRG/j19g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761035627; x=1761122027; bh=PX7Ge6w7XgU4MnYjnO2ueqBOkBBHY5qNs53
	hcOlBee0=; b=rAcb8rCMLoczI2lxNXKRl6U3ecvfcGOqPG28NFUlaoiuZOwEacx
	QvRe+zoBnN3vaKakBd6gMTn6R4EXh6Cx+Hz6GB5bZbwGpbUFtOr+4WSa6kjKYpqD
	sGSROVwjRuYENX2LhAHPid0iB2/kF7iSfknUc3Ce94Ns3vP3gc0o+N6OODYFDH3d
	xAM1xw66aoh/7yvFLQ6AYy1wsrQvyNxyx0fh4izIV0pwGcvEh3KnwC0uvvSzzS08
	gH8kqhLOJ/kc1OISSvchSqUKql0PuaxEe++prGBcc7cl985DykG+0GxmhuC62iRG
	PJVk9kKVzF/+GbE1WlNmFEyQsHT1qZq/L0Q==
X-ME-Sender: <xms:a0X3aMDmSsWGOLBwQGVZ6z0cE8Pn5k-1pxRjBhh8VSjY3fOUos5IXg>
    <xme:a0X3aF-3BjeqvF4e0XXV2BM6ynQqKDgHmeP8EIVMyhgc_UZmLMr-lN4pc6pNpIJBK
    a2Z_oIMt6aCBmUujl9PdIHyapLmFZUD_MsTnCGZEn4u4HPu9Q-F0Q>
X-ME-Received: <xmr:a0X3aM91rRjxjXuKe_5Ey0CK5YSNlWxu065rKX_qNFvXA1oJqqNNJ2pElx5W7uBaFwYkwOSQfiacI4DXtD7LafPOWx6Hw0DDFhP5-QDQCqPrkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihr
    vghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:a0X3aMemUV9Cl2JHodcD9ewtYvPOpC5QxMgBEE1UABX6n-mV59kU7A>
    <xmx:a0X3aFFIcK0R-jrbT4oKmSz2IabBQMSQrNIWGwIiBEfCfx8WzU_osg>
    <xmx:a0X3aKcRBa1SsBvVVsM1U7I0pJ6u1SHMDPp37_8tOtbe7os5i6ARhw>
    <xmx:a0X3aPGXy745dfbtnA1TvqiMFNN7aDLDrn2jT6e9-GAfyIRUXbNWZg>
    <xmx:a0X3aJatAggFYUiSnv3HfALkEsFo4oZ_NwbjkqKQouAT5abQMh1mnJg8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:33:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f316549 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:33:45 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:33:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
Message-ID: <aPdFZp8GokGoshol@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>

On Wed, Oct 15, 2025 at 09:18:14PM +0000, Ezekiel Newren via GitGitGadget wrote:
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 6f3998ee54..411a8aa69f 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -993,11 +993,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>  
>  		rec = &xe->xdf1.recs[xch->i1];
>  		for (i = 0; i < xch->chg1 && ignore; i++)
> -			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
> +			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
>  
>  		rec = &xe->xdf2.recs[xch->i2];
>  		for (i = 0; i < xch->chg2 && ignore; i++)
> -			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
> +			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
>  
>  		xch->ignore = ignore;
>  	}

Okay. Seemingly, we convert the structure itself, but we don't convert
any of the functions to accept an `uint8_t`. I guess you drew the line
here so that we don't have to also touch up dozens of function
signatures?

And how did you end up verifying that you added all casts? Does the
compiler flag those as warnings?

In any case, it might be nice to explain both of these details in the
commit message.

Patrick
