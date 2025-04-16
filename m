Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3D2459FD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799292; cv=none; b=mQUclP/OYhcuupX7SRerlCbPJMMqkq6GKtN3p/obLYmd3svhVV8rxjFyvQGtwYXz2Wi7u11IyfNZTD26CB3ORgqu8yuYtv0RFZkbvczrPahymU6HykOm3/vNwXOUKcLc4qf18jAeg+Ons9bU1ptsuIZ21gATS0ucnkFmtByDkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799292; c=relaxed/simple;
	bh=hR0O8lcJczxcSTZiLU1Wl0Ggm06dAO2ZRPMdAIaUJM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhcy6pvppeQ5JFImU+NeVMB/0av3JoVAOYYm9+oPKhQ/3Tg5KNoyNMuqKhufVt0LLRxX9LhDPTs5T5YqUMjge6PFfdIh+wZNX08YYO8ATPwSKK7GBW04t5aYmrYlC8PF1rYrFwSaTi8TM8PaXC1r/eoOIQaJrKezjibYe+U51HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FzONCqEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZotBGx1e; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FzONCqEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZotBGx1e"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5BDD11401D9;
	Wed, 16 Apr 2025 06:28:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 16 Apr 2025 06:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744799289; x=1744885689; bh=YIGDgCVDmQ
	LqphEcLld7i7nmZAHqpTCjN4Prwyxjm5I=; b=FzONCqEtxqDoUiruQV9RS5COJx
	3b+PGv/MZiMEwHxb9RD1PSZcYMLa1dW6ycE4JzucvSQLRpbVr4Gbzr33B21W5J3n
	tLuVhTXkREpD83FUStU+fcBUXv8khE6R64IYD9OjQ+YDK2SpXFaeuGw/wd+SsVZB
	mg/2By/5Jddt4eXfZGav7MwRaDYRVYPdVYPPsFAzPnvBtAuwevTI19sdlaUOwV3B
	632M7on9ghrPpPkfElUSDzOzrpIlch9QK71AUlFwPmzHSA1oPZHQj3eTV62shirl
	WcbQkdOBK7FOqPQSeFpG6811t4Ls5y9O2narfKQsBkz8s79WZauG7dwHbYIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744799289; x=1744885689; bh=YIGDgCVDmQLqphEcLld7i7nmZAHqpTCjN4P
	rwyxjm5I=; b=ZotBGx1eq/Xt4CK7ojt1MbZOddsWDEcbjnRVWNeXcCMB5t+Y1HQ
	/mLWOne3L0bx3gqCN5zpfOCsCCyhVHLUNlroz8IIdjqSvOYFPFn06IGLOGn4stQC
	KvInXFGSNuGxFuZh7/7u3JDAG1COaKV94kWsoi6rGGPNqA6LbN0ttTxCjliPdVmg
	nMbuSry/g0s4bJkZV8Lhpdqm7S2yDEoJaAG/GyBFbMo2lSEDNblYv42TUSbzk94R
	+55DG6YXkRPcdwr6N4YK+DIw+q0yuUuBPvgoT9h2mzebZuuf96YkSNaCZGIA0KEv
	Uq6Hc8QOfAnUbbD5WGN0pfN28LK2jDe7kiw==
X-ME-Sender: <xms:OYb_Z1up5rGACNoyjbI0oHM9Sc5wZhLTtmhEU9r80E2bLRNSknBFyA>
    <xme:OYb_Z-f5N02nEQbEoGJlZjHHdFexIz6x5nO5zxoBGWMny7zZmOjJ2Ish8yWQZ-jTR
    ZyAe_GJBNwpQ4nlZQ>
X-ME-Received: <xmr:OYb_Z4xJr9V_GB7yUjsEg55TCpaaPSK18mbGVZiHvvW-iuXudXeYYi1PBnLoQCgLNxgEWsEWLtTglrL8JxUbM_3CglYZYerJIr21HFmJKE1ZdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehglhgruhgsihhtiies
    phhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsiigvuggvrhdruggvvhes
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OYb_Z8OEqfHsXHocTYjxFF1-fu7rcdR9UBJzyTEhqC6ewvWmmaa91g>
    <xmx:OYb_Z199fOzSP8AodP_yPwkI4JZp22WhjeuaXs8KW1FeYcxR7RbRCA>
    <xmx:OYb_Z8VXHwAd71uVZg27p_8YbyccVYPWoY1BVyiuT2WobayfefSsyg>
    <xmx:OYb_Z2fubGjYHVEkQYuP0TeoIyekYi7gwSRH89Y32DCUfDjMnOgfGw>
    <xmx:OYb_ZxxDLwLHAFuugnFh2pmoCT7FkdLpezLHh5BAIxVEJlpklfufG_Pk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:28:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84519b88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:28:07 +0000 (UTC)
Date: Wed, 16 Apr 2025 12:28:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/5] parse-options: introduce precision handling for
 `OPTION_INTEGER`
Message-ID: <Z_-GNqY9gZM6fEsg@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-2-ce07441a1f01@pks.im>
 <8e566ea1-5ff4-4854-a1dc-38626510c080@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e566ea1-5ff4-4854-a1dc-38626510c080@gmail.com>

On Tue, Apr 15, 2025 at 04:51:59PM +0100, Phillip Wood wrote:
> On 15/04/2025 13:14, Patrick Steinhardt wrote:
> > Note that we do not yet assert signedness of the passed variable, which
> > is another source of bugs. This will be handled in a subsequent commit.
> > 
> > +		} else {
> > +			value = strtoimax(arg, (char **)&s, 10);
> > +			if (*s)
> > +				return error(_("%s expects a numerical value"),
> > +					     optname(opt, flags));
> 
> To catch overflow errors for arguments of intimax_t we need to do
> 
> 	errno = 0
> 	value = strtoimax(arg, (Char **)&s, 10);
> 	if (errno || *s)
> 		return error(...)
> 
> to catch the error when we parse the string as the checks below only work
> for narrower types.

Fair. This issue isn't new -- it already existed before my patch series.
But that's not a good enough reason to not fix it while we're at it.

Patrick
