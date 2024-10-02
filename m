Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FD12B63
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908993; cv=none; b=k1Ct1uzp/4iAP0EoRZGa7M1uFc37wx06/CqHcXU5t1kWE0eYHTIiAF3FkO3D8ia3iEGa5KLnBGIiyFKGRAcZXn+GjYv0XROPy4O06xnbh2zGllpV8DRJo1T5Tu3IJH/GxFs2W26UvDgsPdMh0fYMagFz5Dhp+pbiAT3EcLYDGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908993; c=relaxed/simple;
	bh=cC9t+nIqSl0E101qBM14DllVDasdiuFBmqEEIylR2ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMkiPMotubc21zj/f6xz502IroB1o8Idq5PcByu3kcVd/jivl8ao7Tk937SOxobvawXu1X1dxhXMN2ZwbTKX9AP82YPvXVf72Zw7PyYy+I7Hl8MufEyRc0GRUoF5U44iwA4fWzgiqWFvBD1Bp5A7eqVlw+8hm5nuLfe/xWTOFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E3BkJ85i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UM8zfb0t; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E3BkJ85i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UM8zfb0t"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 190B41140159;
	Wed,  2 Oct 2024 18:43:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 02 Oct 2024 18:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727908987; x=1727995387; bh=cC9t+nIqSl
	0E101qBM14DllVDasdiuFBmqEEIylR2ls=; b=E3BkJ85iCl0+72ImqGaBec8wrG
	NoqAMxbYdCp2ToV07pES0TdL+04ZiINgb+3oywshXxuxNA8rBW7W01482aYkJv1p
	noHUKxiAqpe/SvwX865pewhFHfHiY6SWWOX8px6eUlTdvrJBOoehuGflxJA/tb0+
	RwwnG0FZpuHyJzRZhCb/Nriyg9pkAPpLg4cDVszaSXIJacBMUgiDZTYoKtxDIHN5
	nsLFbew2ZG3oBCzkVz4xYY16W9UsTjisYSrzmkEsprzsDt9WOaNz4+R/NmQCM0G/
	qnKBcq4wtcMB2dEGikC0a74BTavFHeU1eIiGqXPOOcXQ6aNT7irNul5fqtQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727908987; x=1727995387; bh=cC9t+nIqSl0E101qBM14DllVDasd
	iuFBmqEEIylR2ls=; b=UM8zfb0tasQN/xDp1wiae+X3a7hdfYQoLERNnw3xQbAw
	BgmJlEoD9fxTr0rH5sf9coNKv0l5nHkvOoqD4cxZlCAsMzRvbE9hJj5/CbwUsTh0
	tObQlFzxF/87FxE3JviTELyCY+3+Qei49TgRJiEmi1BdCHormLqlGmtoGNf/MNMz
	FXGrwS/g7yMcVRh2jeetJN6cI8Jl0h12JhATwsqpVR8if9hiIuo7ah3nYdhuZkRT
	7RXJevmdfkTCE6tOzjQtCRc7DHsWKCl/g47e/dH37C6ceQTSmYIjaZd4ens/TztA
	/C+ZLIaKX/FZeuCQRgDhGnUtBlYVBXdQ9COUG3Wo7A==
X-ME-Sender: <xms:esz9ZoXDkIfXL7wS2QaPZ0oRiGs9cpxk041Hn1qnzd9VUfnTRAdpoA>
    <xme:esz9ZsnZ3qRy6ehe0kJQTXznu4MZiqCifmkip3bj7P09cae-VAq9RSvgGUuSvOvx1
    gr00BpB_duvGpGlow>
X-ME-Received: <xmr:esz9ZsaoOXUIJsasjwqJ5V8YnQ_S_w7OXw1ecXX5laJjsA9EHibvuqTN9Hokwx5LxpAZguvhM85UXfCDXodBUnfBVIGpMu0sOvUKBos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:esz9ZnUsmkY62RoywS4yxK9n-Bpeqx1fGULhjva1P0iPn1W6WPiBRw>
    <xmx:esz9ZinQtUHDmwfNOrIollV4MA5xIWk0ewJ1Bk7BSBR_hoTyiu2ong>
    <xmx:esz9ZscTIUjP79HdA9_zykI1p6tlwiS1kZJd44JLhnGfr_7AcZLOqQ>
    <xmx:esz9ZkHH663yhjeEYmCVAQgiX5YEbqbyiwXFMbtVe26U9Sls8FTkuQ>
    <xmx:e8z9Zs5OXCjs4d9nw7BSRCrzSTthEOazLs9V4rHoSQ_l8EBzwfGYguXg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 18:43:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  =?utf-8?Q?Jean?=
 =?utf-8?Q?-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Chris Torek <chris.torek@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/3] doc: introducing synopsis para
In-Reply-To: <wuxy3oit7bculbpct3xnmpzxrfnsgaeoh2gvp5fsaaszchktoy@5ygjwbkdvozh>
	(Josh Steadmon's message of "Wed, 2 Oct 2024 14:41:58 -0700")
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
	<xmqq5xqlug4l.fsf@gitster.g> <20240924193004.GA20138@tb-raspi4>
	<xmqqbk0cssel.fsf@gitster.g>
	<wuxy3oit7bculbpct3xnmpzxrfnsgaeoh2gvp5fsaaszchktoy@5ygjwbkdvozh>
Date: Wed, 02 Oct 2024 15:43:05 -0700
Message-ID: <xmqqzfnmjfd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> I finally got the chance to test this version on $DAYJOB's build
> infrastructure, and I verified that it works (I also got a much more
> recent version of sed installed).

Thanks for a follow-up.

