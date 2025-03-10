Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8801CB332
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588958; cv=none; b=cH9maRFrMlbC2uLAk3EFTQx/sswJ8p1mmMAiY/KXOUXgZzf/djvORrDmAY/UnKQWIRaJ3LONTwydgaax58oBE/pW/BHPScb6+1K2Uw+IqgFM9ZpuDB9AobvKE2lZxIVG9WJiOei1mh31RCoLkOlc5HP+MlGpPTgaev+i5iaiqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588958; c=relaxed/simple;
	bh=6l5s+TPEILnvc+IF3ncQZ7CMolqs5AQnQ+qrYa9wsRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taXgDFJMsAVAQrEvsmqDBhugNHZ8mpVIrhMQhsjX6ftPZRFFfsGJv6u0VolmzGwcCSZ5cnuzYkrzq/3zG5NuiNljFuFeoiW2IM3o8kOtwmlidnR5YCsIJPYP2351Ax3KNvXrevqkdtX4kYvJ04TQjz677fPa52o3kIV2d8c6Ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dohfo91z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2ONAb8Uh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dohfo91z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2ONAb8Uh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 79FA0114015D;
	Mon, 10 Mar 2025 02:42:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 10 Mar 2025 02:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741588954;
	 x=1741675354; bh=dpliExcXv38OF+zYP5fb4vEM2JoDiNjTcHNw57Cu+Qs=; b=
	dohfo91zMrGTrK3K4BmbGS8LRSMxzGp8o6BK9hT8NWP+lwhE+UB3ZRaLOFJWmVy7
	sZ3XLSPj5+loQpsDVC1wz3eLitKn3gazmaZYWZPxg7S2R/ANhaJP/Wu4jt2697PG
	0c/1KLseKzKSqWi5wOtjCq7vmN0StQBS3A1/ycdaIhVFWJxKdgqvTXf4NmreHJL4
	teIvBKIuyzuu5E+VMbAyrGxrIHl7vv/oF2tmHOFWcCNlSToJ0VAkXVJqfUtSwICM
	uySBRCyjcPc2fxxn99YoEsrAvSgjtCvOomMfRhNf4pdR9MgMFiDMYM9LbyB57qSX
	RlsQypBBxbiik46lPlWdbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741588954; x=
	1741675354; bh=dpliExcXv38OF+zYP5fb4vEM2JoDiNjTcHNw57Cu+Qs=; b=2
	ONAb8Uh3lyYPwFc3M/B33h7nWFuYfgu1da2K/i91Eja9mdo3c8rkDNenFuUJ/b+F
	MopyMDb6HpwfQfHJJwDc61IAS+yDnIyuivZ0kCQfEkiA5tGhJfBxEmUqHo65WuOO
	jnA5FfgaiNev2pwmAXaKKmc7Q0h7iVSCKE8aL1je5+TBaimqzSjzYH4zC7xvmKhH
	1a/SDYzuW4D1vPztGw17pk+S4/aSKnW/f0vgFi6VboSkzZKwcXQHXTuih/kClsyB
	CYY4X2b96i5L6XzosrjEEtpQLhEfupChiAyBZi5DrhMhT8tAX5YSA4R4WEglFWKd
	uT8Xk7QEqjodFE3Vj6VTA==
X-ME-Sender: <xms:2YnOZ9FxaXeJu1ITqhgZ42uOdl9Mnks8WwYoheXmFCkXktfnRN-xTA>
    <xme:2YnOZyVYyQYKtAeAV9oGiQPK6pMyBnzkAGuDt2rgCcxutoM3dupYgZS0yu35RiZm_
    Bib1mYMd1SbIqZoZg>
X-ME-Received: <xmr:2YnOZ_IdaBhfNO-IsQL9I4Wmd4i2KJ9tjLvkKRnotJeutfBW3AdX0bCJa-e7bna_4_UE_gV_ymv2DuIvHIYgO5scTzBdiQw6pm9iS-Nwz5bnWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:2YnOZzGYN6sTfNuzJKqDTBcmwvehH6uAtp2JYN1_bkVj0SBeIFO4aA>
    <xmx:2YnOZzWX1-A_jwKd72LlnPyt2FybkjB4Ou1y17GXjLQZJ3UZmb8nWA>
    <xmx:2YnOZ-ObZ0ksx1hnm8BvXOpqKqsHc1t4zm0Zd-6U9bl4-xv3M5Ke8Q>
    <xmx:2YnOZy3jDFm7dChzPkjCeIRNE_9cDDSUzIZpKAf861AA57OAuxqM7g>
    <xmx:2onOZ-R6pDoC4ZhCue_LOCsK3wMhK99j1DNgyvjlhAfilE7jRc4JOCYv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 02:42:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7b37366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 06:42:29 +0000 (UTC)
Date: Mon, 10 Mar 2025 07:42:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
Message-ID: <Z86Jze2qZ5s5OyOB@pks.im>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
 <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
 <b5fb3292-216a-4456-b456-e9ed38affc22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5fb3292-216a-4456-b456-e9ed38affc22@gmail.com>

On Sun, Mar 09, 2025 at 10:52:44AM +0000, Phillip Wood wrote:
> On 07/03/2025 15:07, Phillip Wood wrote:
> > On 07/03/2025 10:32, Phillip Wood wrote:
> > 
> > The diff below stops us from building pack-redundant with
> > -Dbreaking_changes=true but still builds the documentation. I don't intend
> > spending any more time one this
> > 
> > [...]
> >
> >   if get_option('breaking_changes')
> >     build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
> > +  add_project_arguments('-DWITH_BREAKING_CHANGES=YesPlease', language :
> > 'c')
> 
> Looking again at this I think it should probably be
> 
>     libgit_c_args += '-DWITH_BREAKING_CHANGES=YesPlease'
> 
> to match the rest of our meson.build. As a newcomer to meson I find it
> confusing that the CFLAGS for the build targets are set implicitly by their
> libgit dependency.

Yup, that would be preferable indeed, thanks!

Patrick
