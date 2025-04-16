Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829EE238158
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794372; cv=none; b=nR28/EWXgSmOjStW2Yl3m8VeEihcm83YOr4qpeBkYy8MWiDDnDfFUO+I4WdNNdjHKW+R7HvwW5y1ZZBE4cow7k+r5hcKf2ns/GESojLlYWWK6dG5swrE32M5iTpynuSHQ8gkqoMSuIiereoZwLM5zae2r5nlIccZgC+Gs+hLnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794372; c=relaxed/simple;
	bh=hZGCEOfOqKNQSlD7y/ZBEqC8J8SbiK0EhPGoUN3Hev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb7DA+rlFNV43TY4CVGRokcLEjVk1LQPDkRZ8voXVUse2xEK3Ukxu9pWbKRiNo8KigixiMurzLDv5r8Ti9PClrGDWkXJgYo5H+70RndTs1W4fsDKwfxagsxB70hy+ktcH/1sHC9/w5HNsoI8wL/7zL7JL0gAXrQc47tlZK4iqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cMXMZ5LK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBmbQdHd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cMXMZ5LK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBmbQdHd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A0661140271;
	Wed, 16 Apr 2025 04:56:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 04:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744793790; x=1744880190; bh=qfDL7r7M1P
	HkZ1tvxhErhFoEH+2RJxQuO2JXFjdkip0=; b=cMXMZ5LKQ+0wp6bNWTmNaN9txS
	vArRfqqfIjJkrgn30jN0ded4dA1yVl2PtnJJfMAGFsBswQ3ona59NZYRZhrszZ8g
	nuRn2GJgsJ4Ee4QgAcFopl+jt1uZzefp56yLgfwWscytZ0ExKzl+pnQ45ethg3ma
	mUkE7to9bAhnX3XO2Iu79Atbv9vDTJh4ZGZacV4ipO9xyJCEQeHVJz1AkDBunCD3
	VOJfQtUFLJhS/mCt+4ZRIUtDhozSNNv8sKWwJxDuNHjXSeaYzPSYSpNvV+JSWZBt
	WDmQTd5WglrsFKZAUrOkafriYLz717viHzsrtKyOSz9b/JU+57N3Ht6ltyNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744793790; x=1744880190; bh=qfDL7r7M1PHkZ1tvxhErhFoEH+2RJxQuO2J
	XFjdkip0=; b=fBmbQdHdO0FoBMgDJaYunYJHGZIGu4l7AEgJl1E7cxpI/xFpmtQ
	18qrhL9ytz/GribAhM+14YAFguMT87scDexOHRQpaW436HqLRfbzDe0NYGUNSv7l
	b2FZdqP9Ah7HJcoNpmyPdzVstXPoGo5yf4XY+DEObjNbJFcD3D/VPNDoz14YgKJq
	0L7HfZl/hSg6RRF7dG6mBd/ItC7U/A2JYA88xYnyj78YLeMLoTq1Kk2zZs6WFzDB
	SiT/XG2QR0HCPHvWQAwORiKhAogP9UrrbdCg42gfyD2XhjqwDAyHjT6hEk/e0L/F
	W2O86ook0se0OLOx3IDqV57bUz17jrxHIBw==
X-ME-Sender: <xms:vXD_Zx9hiC6vzwZW_mals--174doWP_21Gym-ZSnmHY8G5rY_zRSKg>
    <xme:vXD_Z1tQ3QmHBcJIlsmU3hXYLsrgTaezxAoxRKaLdp_hFR8S_FvsxnXoo9yipVjBY
    GhzxyUIVTYP03SgPg>
X-ME-Received: <xmr:vXD_Z_BQsf7fRhGOvshCf2E4yEgTZLaJB7Y9AsCPRGrZyLneHgw-5Lx2uye2P5akJ4I2hRgMDppGDdrYV-_FFX60A6I5US--l_BovF6HA7ONhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:vXD_Z1eCWsIOQGrKnoidnpSlpJg5D-7vIw40UqBm7B-WZgp4vT4Zow>
    <xmx:vXD_Z2NtG-incGNfPTxXaciULaYSbDTr3W1_JZmOZYb2-AuwMDZQnQ>
    <xmx:vXD_Z3khH6oyVTx7aDkhZX7TgNpOwKCn8kCR_ROGrIzIk1wl2Mt_FA>
    <xmx:vXD_ZwuIfaPsiliY2CQ5bBlOmvtnv9sSl7R3ikSZxa6rhIHw7WoJLA>
    <xmx:vnD_ZyKLs0K26EzybFcetYHTnWMi1vH8yl4wtGQK4M_humM9pa0p2c2U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 04:56:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ad377fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 08:56:27 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:56:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: meson build failure on 'seen'
Message-ID: <Z_9wukFkVqAykm0L@pks.im>
References: <c358c9b7-bd83-407f-8abc-17ce9363618e@ramsayjones.plus.com>
 <xmqqy0w1kzob.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0w1kzob.fsf@gitster.g>

On Tue, Apr 15, 2025 at 12:11:32PM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > It appears that the tip commit 916e0fb7c0 (Merge branch 'ps/meson-build-perf-bench'
> > into seen, 2025-04-14) drops the call to 'find_program()' which sets/defines the
> > 'target_shell' variable.
> 
> Ahh, indeed.  This was the mismerge I was looking for.
> 
> Will adjust the broken merge.  Thanks!

Thanks to both of you!

Patrick
