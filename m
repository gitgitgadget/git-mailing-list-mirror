Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416312DECBF
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109308; cv=none; b=Zl+v0gFpbzHikkOkRapw3xVu9xmuwMslQry5K2euziJXuA/5ybGquujGju8xGphg4293sqdk2dH7IT33hDHrm6x0A7pJKNTEeAMuNogU/71gELsub2hjSgKHJLzwwEkzVVr2cESTfZwmTT8dkuyjR9i+Tb0dcXp4hIHQ6CQR+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109308; c=relaxed/simple;
	bh=tYhSW7VgYGXFfagDDcvDcl3KJKIk6vMu9kft6BTXQUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK4t/CUU0XiSkJQlCtMsoKQ1fG5Wqt4qqTUbJFKHGrOqvPavrhxxgtohNnfCdLICzHEM/XGSsrEbV6VcwyPkv4x+N6bbPJA8oj+Bu7Homzbil7qsM7BqqCVvEpHKAa8FRBE4eGv50lH0rOm6B2eJz2oIkL0cqVdPBxkxU4r4pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cmTo0Bxb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AGwwiYA2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cmTo0Bxb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AGwwiYA2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E28114001D3;
	Wed, 22 Oct 2025 01:01:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 01:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761109305; x=1761195705; bh=/exJKPMu/o
	+7HTEArVLzvQyhYZNXwBc+W5IUkwcYBVs=; b=cmTo0Bxbx3/vjtxKd/C8/2OhmX
	A57FBFvXfhLzt3nB4ed0CiSsAJbqVgYjv8/lzOTC/cHlWQLS/726AQiVa4TXjRGu
	LYMWdq6dX6GSodgH40IUyq/QRO5nl1a+HCFF4Krr2ROu4gAI2FwOJCmmrLO4HnwM
	CdiZa8U1HOZK5O4gtLnsJsAgD85D6dUXvJH3oYncrQhoUMAuSMNqJ3HuP2jpjCGq
	ZeNmaXm2gYSb0w95RagHHLzhGnCEssNAahc1nG37aQyEgiIQmaJmj1M53Otnjkw0
	6Bs0U1N8ENpA9yEsegs3Lz95vRFM2BSLXaSgtuXG4t4vrDaBn4wIAYu8oSYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761109305; x=1761195705; bh=/exJKPMu/o+7HTEArVLzvQyhYZNXwBc+W5I
	UkwcYBVs=; b=AGwwiYA2CAgNj2yJZoO9l5dm23LNEsLRRVaKOVnpnWHxJk/B965
	NvSaq2DnDMNjLejzUMoN8sXFZ7xfuwUHNpbhQHSu2XPKfZzC6d760fVt5x/sBoTy
	MHFEFlclQ8l1gwi//cSvdRgyG/k2vFLTIhhqHxPwYhxQHA5WgRzT0i1zBEPhb760
	AS1TNUEja2OYS2Oqb+2VyJ+86mdvNp6BOa1HVL0urjIxKQtToRuFqKtd0GMLcrHk
	IuOszdWsKlB6iVTD0et8gjsF2nkPeTNLhPhDoge646U3VpBMOKndO21nUFCNMkwn
	Gp/r3FDXgho6oB5tN8mXiD+z9maRF5uCBpQ==
X-ME-Sender: <xms:OGX4aO53bzbDn5PJ_2_oZqcT356wDa2Ncx4cLFRwnqm4gIpv6O3EFg>
    <xme:OGX4aLklDz7yMatXV5JiQUATy08xOC15cHlUFRp48J_rm6x_hu3EF4tJ29OX-T764
    _ZZ0rTYjgls7NzWWggm1LTYFYPxGkLAPjqh-JNw6VTRl7WQZQ-jSwI>
X-ME-Received: <xmr:OGX4aHSgpoWFA8UxTenPgSAvhaoGRYycs0c4kOaGt2ISoZ2jl-ibCpMIO1wgfJhOd5E2jHiXpatfaUV-jdk-f2NNI-M2Px0CPAY6y739Fg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OWX4aCH59wI8wA6PmD54CKnSPyTWet_tDfSPwIKbsq1jAyDhLHeZ7g>
    <xmx:OWX4aEGISrz2eyGLDF6TcOrijm2EuDKu53x30ERujl14vDRko1IgYw>
    <xmx:OWX4aISIQqvDVeyRaWqk53RUyQKaPtV5kgPtFb_BuKpgL2Mvh63aKQ>
    <xmx:OWX4aNIusxEdQ0Nk5zgunkN3aMis-drFoxHJWcN4wKGYlFz2rCSANg>
    <xmx:OWX4aH-4oN7Em2Xqp0CepOP2KrM9Oc-Ks3cNuYTqnYG66Tzj9JIyIdHO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 01:01:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d17f54da (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 05:01:42 +0000 (UTC)
Date: Wed, 22 Oct 2025 07:01:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 4/7] builtin/repo: introduce structure subcommand
Message-ID: <aPhlLbsOFxeOv5KZ@pks.im>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <20251021182601.2687284-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021182601.2687284-5-jltobler@gmail.com>

On Tue, Oct 21, 2025 at 01:25:58PM -0500, Justin Tobler wrote:
[snip]
> +static int count_references(const char *refname,
> +			    const char *referent UNUSED,
> +			    const struct object_id *oid UNUSED,
> +			    int flags UNUSED, void *cb_data)

Tiniest nit, not worth a reroll: we tend to use these callbacks in
singular, as you end up doing the thing for one specific entity.

Other than that this series looks good to me now and is ready to be
merged from my point of view. Thanks!

Patrick
