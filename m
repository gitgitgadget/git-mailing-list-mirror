Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98D233D64
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578191; cv=none; b=LVO0YnUrYhoNFenfGiXDZnmOn0t1Vgfi6DWv+gVKcMWJURAinrvshCUzzfCZkI8/q7xnMu50D8s2TGxDW4X7oDNGPep3meSQEKAO5WlUVZrK1bf6Ocf3U9w15apgVylObuHezZRrUBiUUWrdKSE4AxVBvukpOJ5tQQzLjtCFZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578191; c=relaxed/simple;
	bh=Sbw0NzXIII6zO+QbJwKebMMHiMkLwkztHATJ3OnhPTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axLmc06OSpM63gQZ2rwmLbY4VOvu/k15JJ4veCGcAeEBVKvYV2wAUxb3HKGEFc+A44/Ya7mJuRPmgUlzIwxt1Y5r5ZezDOrer6v7oyRgNKgTwauK+dbBCSMimmWUsyxGhCltcgG4QoDFnbEtE5HqkGzU+KO0bWw0LXMVKRyTIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PW2X2hG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umWaRkjN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PW2X2hG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umWaRkjN"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CB97114008E;
	Wed,  2 Apr 2025 03:16:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 03:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578188; x=1743664588; bh=Ro+KGDmVVM
	897IEILfymjnN3QZDXfG55PSqdT1yr4m8=; b=PW2X2hG1VfyZitxNmteH5HSI5S
	+mdGeY4tj/Nj0huQL/OG3jDA0+V35GsjdbuMyjVRlcqr7EQsy8e3tdnjDMR+SPgA
	d+2SO2/NcS55EQKC6DDztqiy/r6UwatSxVJoz6ajmQwNdviYEUXHjFaekcvr5nwY
	THvyxOZ+Qtrga5Bn5YwMr+q+pVjLGunXFEeErGAWBGXDCsv9Cu9pGQpaKKl6SZei
	xoBhwvOvjyNjUv2VD0EH1AbdACIJ2BB4XFzjL9rIrIfCrTAzZiDCW9aGWaG2hdkI
	8wLKhl3SpCBKvttoHd6A+HyHWTDEp2tjGjpI6WiKd15W1pvXWpLLDsbdkupg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578188; x=1743664588; bh=Ro+KGDmVVM897IEILfymjnN3QZDXfG55PSq
	dT1yr4m8=; b=umWaRkjNdKosaWVacPywPSaJ6DCm/yL0y4lxC3jHPulh2khWmzq
	U97P0EbKaoH9lTpXhkPt5/A5d6HKcZO68zKMVhrcFSopAAbPiWfppD2aNrbsFtqI
	fRlh3oj+iWMg/TW/LzSimzBFnDCD2zka2Pnwnv8AO61L6rCqs7ZnEIuw8fzHWGnW
	AfigK0Pl3JQ2VwJ0+5eX5oC49pyHPFlZ21MelrTLZ+4LKqvLF40itnbfQQCHUg5H
	K+mRyZ2gEA4I8XUl4kfJ8Xe4CTgISg7te3j6Lc1FymLGzfrhiddc9Kvg6jbAxAw9
	eXrl9Q4e9tkoDQpFVYfS9EHoFhUN6SqMmyA==
X-ME-Sender: <xms:TOTsZ_Sb4I_6i1eB_N6r0-68sJsNYwD0oTdUl2gLPLYfTpJiw9SngQ>
    <xme:TOTsZwy7pbO3sRv3qKxa3scsVMjnpgsYX94qfA96CUQWiRBQuCnLVnTGwTIwHA3t6
    PMxFpMe1yQMgIB5og>
X-ME-Received: <xmr:TOTsZ03EDTKdeh9E4o7Z2Y6WXMT4WER22qbkQika-gm65oi5sLykemsxQsSP_oxpb3CPtnEi6eXP8HzvtbYicyR7PHdL7liIXUcGZoQkybC_ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:TOTsZ_AuGbDs-p44Ttv6_PfWsMlvak3QF27ezhMTCp5b5jpl99GeTg>
    <xmx:TOTsZ4hgaDwmROGkOEoo3qQjjq0pqnVtfK11rx_3_4FATNFKM_qsew>
    <xmx:TOTsZzrmce0CUMpT1Hlj8V7oHjGyyyBGg3pw6o3XGkb9NVB1FEIEjA>
    <xmx:TOTsZzi0bGpTWgncesVsTxPF9LoQa87pxhbBaCNppuyDM4xTWAmqxg>
    <xmx:TOTsZ6mNRjUwyTCwOBDZnaex8f8ZUomGEZVOtz2bBF6CA46oh4ChWzmk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:16:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fd21ec4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:16:27 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:16:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 14/20] t/lib-gpg: refactor `sanitize_pgp()` to not
 depend on Perl
Message-ID: <Z-zkSpKsvEYWw4Pr@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-14-b436de9da1b8@pks.im>
 <c909b89f-7432-2d35-cfdb-0de9f94a7281@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c909b89f-7432-2d35-cfdb-0de9f94a7281@gmx.de>

On Tue, Apr 01, 2025 at 08:56:41PM +0200, Johannes Schindelin wrote:
> 
> Hi Patrick,
> 
> On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> 
> > The `sanitize_pgp()` test helper uses Perl to strip PGP signatures from
> > stdin. Refactor it to instead use awk(1) so that we drop the
> > PERL_TEST_HELPERS prerequisite in users of this library.
> 
> It's my fault that this commit message is no longer correct because I
> talked you into using `sed` instead...
> 
> Sorry,
> Johannes

No need to be sorry, should've catched that myself :) Thanks for the
suggestion in the first place, it made the new logic quite a bit easier
to read!

Patrick
