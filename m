Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9038DF9
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854818; cv=none; b=l3DjDKtrEdnLCromT0RYQut9uOrzSbAbmu69CIPY7vNyXl+JHzNhKkVK7hdafFnlQYWCs29gLHT//cxQtND/7BM2BoPkuwNntwzJum97k4wDGTnBqKq/UjJw+TZmYtOzUeU7lfzANPrJQ6cb8++8jfX9emAnxoMyPIrRNUNK3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854818; c=relaxed/simple;
	bh=dwUbigKz8rZoz6wjbuVylLxfWn4gdLl3sESqrbrlOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FURNNchKbuNlP6zjYe0QEb2p7c/9f4mW60NObDjDkVAktPE5PIuUx7scZDghHgOuiK+wYwEkUEHdS0bGYYMHtVwTRz2ybsbZpsprgerRpJOpT1Ug3KlWG6ijsh9TZojG4MO3CDY3zA83g9cOyfd/0AoSF3hryDzhpj43ko5Ow28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WYbq2xbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sv+eWJI+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WYbq2xbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sv+eWJI+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 733681D000DC;
	Thu,  8 Jan 2026 01:46:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 01:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767854815; x=1767941215; bh=iypDswbBzw
	X2cFaFBrYtgFYoA6QHcMw9HLH3bBau1r8=; b=WYbq2xbRzs9pD/VVwOCjACxAaT
	zDEHmVOG20MGUJnGVkayXCtLzeBCvyg9FG1Pp7pZMHEP7bI2oier/HBjIubnKm2Z
	zBIMmd4738sSy/mZB9OG+z/9IVAS5gUxZjWvG+f9r4aTQFwCS2PUORBS3EzTPfC6
	Ea+U+kNuoMaCBEg+WUJFtZf04fjaiOV3UE58Nk5vRpvXK5R4MweeqtCvatLRPTth
	3gcB9y2a/e/k8mzJJ9gPYaU1CD64RoMKXGFgLCIRcG6Fcv2oIEnWFTJ/T88/lb6n
	V4V/mNhINYtfcGnxPjjjzpDAdDViuF5Y5Jx6KCs+6PmTRmMhzH2I42TIUDLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767854815; x=1767941215; bh=iypDswbBzwX2cFaFBrYtgFYoA6QHcMw9HLH
	3bBau1r8=; b=sv+eWJI+LKxdtGgAwbb/k7WUWiK73NBOdfBD4ZA1sI/Jqxm3xYV
	/q09778Cpv2sG5jF+Ui8cFTcQfILjgd1g/daKVNNhF8YXl/sdptGwzOVUEe3z3St
	W45M1dS7fA6th9455Gd62turHGTwmlyfzsiPJatGYSPFE9l4ru/Y3l3fbUdsTl0C
	5xehHqrZgW5D0zFDR2MgdZqmhv1CssQASTu9GWhn9EWpe2kgPXXBeeH0PTSen8zC
	pTm3qZ5g+pfRqt8a6O7ILWUiQijeEj8kQVZeY9eopNzxrPoyeMTOJZzDznOF9fFI
	KQVoVyjFmx4szEq7dHdz8w7K46drmPt7hpA==
X-ME-Sender: <xms:31JfaQ1OSZo_fPhwcWh_PAL2ME6_ajTtp3UhMMvNfS31S_tGeRARgA>
    <xme:31JfaayrzFD7GR7yvmn6J3WD-k4JLAaMp_8znZYYZ6-9bhSEUjEsa1UOpqVKRe5l3
    f_B4fg9qqS66S8MQrorsHMgmyB_InwdS5lIomK12DdpcnxCwf3dBg>
X-ME-Received: <xmr:31JfaUgmahZwEioKSt30qv-srD-O71rmBZjOljlulGCQQWnJ3JrEJom8YjVCJHG_Ieh1wKlqlyqSDG_D2LqQksbGNnO60nWU3JdGm-YJVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgho
    lhhlrggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:31JfaVpARZsMcRwmrToxeCl-KVVXbSutCCGs6-b720jlOFALnaWuRw>
    <xmx:31JfaTgVKqrHGU-u1mqfonKoCa_BQnVHZqRqIaVPwQ-iZZOEo5BYbw>
    <xmx:31JfafNzZjKSUPpGOiDEawk6saJ1S3ItANAeg3NlAUkmwpDdoW3RJw>
    <xmx:31JfaVwbAd0Fm_7EGyhpr4tjup1bnAWuGHKa8c380Efuec9IrHJJ0Q>
    <xmx:31JfaYTrCy6fyN0AtM7X_GVehpjb4qjykxafmRWUap3TcEcMUVPjVIf6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:46:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e3f2510 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Jan 2026 06:46:52 +0000 (UTC)
Date: Thu, 8 Jan 2026 07:46:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v8 05/11] submodule: allow runtime enabling
 extensions.submodulePathConfig
Message-ID: <aV9S2d_gRgfGNpJh@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107230145.517562-6-adrian.ratiu@collabora.com>

On Thu, Jan 08, 2026 at 01:01:39AM +0200, Adrian Ratiu wrote:
> diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
> index 453183e27c..6cb844e809 100755
> --- a/t/t7425-submodule-gitdir-path-extension.sh
> +++ b/t/t7425-submodule-gitdir-path-extension.sh
> @@ -157,4 +157,129 @@ test_expect_success 'fetch mixed submodule changes and verify updates' '
>  	)
>  '
>  
> +test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
> +	git config --global init.defaultSubmodulePathConfig true &&
> +	git init repo-init &&
> +	git -C repo-init config extensions.submodulePathConfig > actual &&
> +	echo true > expect &&
> +	test_cmp expect actual &&
> +	# create a submodule and check gitdir
> +	(
> +		cd repo-init &&
> +		git init -b main sub &&
> +		test_commit -C sub sub-initial &&
> +		git submodule add ./sub sub &&
> +		git config submodule.sub.gitdir > actual &&
> +		echo ".git/modules/sub" > expect &&
> +		test_cmp expect actual
> +	) &&
> +	git config --global --unset init.defaultSubmodulePathConfig

We have `test_config ()` to handle setting and unsetting for you. Also,
this function uses `test_when_finished ()` so that we unset the config
even if the test fails.

You have the same pattern in a test further down and in patch 6.

Patrick
