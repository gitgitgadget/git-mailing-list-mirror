Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69565522A
	for <git@vger.kernel.org>; Thu,  8 May 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728395; cv=none; b=Q8fc3Xr6dIkuviJCz80RZIA8PTK9d2zcPPxr+kYnTIbb/qVa3joIaeKLzk/LoDEJwRlts8hHTNQO8q5lwvx91OrkN32+oMJ+VVf8Pa2ymdTtas9zbpTnQRo7OgdxsPUo0+VHEgRh0ue/9pOrNrxUWWv3ETsK0xf3x2WVHtu1X0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728395; c=relaxed/simple;
	bh=T0MTnRkg3G95UdxBlY3kfqMYeT1Ucmy0N5gMXITbbBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X68yIrslBne5eIqc25TP63+ans5esn5WLu5D1pIVeaj4O7kntye3N72WGYK5t4Zm5RB8umVgwn2RWiPquoa7mjlwiN+Dpr39rYjeSXTEk2w/3LBQuiMW0zSsoF6+0Ieq/yzQnXON7xCVNS4TmJrPTkgZOkiNeHRot1vtyNih0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLM7YznI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IpNx37UY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLM7YznI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IpNx37UY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B73B11400EE;
	Thu,  8 May 2025 14:19:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 08 May 2025 14:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746728392; x=1746814792; bh=T0MTnRkg3G
	95UdxBlY3kfqMYeT1Ucmy0N5gMXITbbBI=; b=SLM7YznIBv/IHN9KRJTuIOW+6T
	Zfe3chGllCSdvn+2AZv/qJ8rqfpkYCpgbkJ5eBzGwE5s07diaw98sqBzccEwuhPm
	sJZRMNk8+AdlDe58OqxknHQt+Gz5D3QAmv8uGT1bXmFAT3MYLVr4Eu3mJ4FxUTct
	bPk1OZiia1/IJ198r8pSUXZn7AVGsTjW5jnAwUatBs7rtmb3EzIRnSRA0rf6uKEG
	u5TFEOygW2wT5jmXSE1oQgYkVEnoWSYHGeiCeTcURkUb8jTVE5bYt4MNujEXYnMe
	NB6MQDoxAkzde2rJ0+q4CdVcvzNyBRkAZsk6tZowK9WsJVLZNtGoVIxrE2Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746728392; x=1746814792; bh=T0MTnRkg3G95UdxBlY3kfqMYeT1Ucmy0N5g
	MXITbbBI=; b=IpNx37UYkNalNZtnxGo91RXRhJKZ+ZZrD8P8ce9aQUFonYSk32Q
	7nWpcPbDO0JMyLUdTAlV/+S6kTQk32e0gWA8SSGNaEdn+jv//2GkQaz4IFdU6ZRr
	spRKWTBoYpWj3whNz2r7ddkFpMKJV3W3PO9kmqSIYZ8qL6BaoQDC7stPeHIoihGw
	+W+oiqI8ybTunQCDEXWiCbc9TO9GRpniOYuPJrG9W5+SlwNCD6D7D+gnwW1kXc+T
	4Rtiq8yeIYLpP1gF1VQlX4dsafVCD2pbWkpfAm4oBvFSGYs95Id3wNOWZPgcei+S
	3uNOzXCZX9yxFnOdkOJxqoN7+uspqbT5FBQ==
X-ME-Sender: <xms:x_UcaL8mK2XNKUGmMWI43Z5J7jDPoLQ_iunXjhlrr2vS6Li1PrtkEw>
    <xme:x_UcaHs1OXoXlwaPnVvjUE0sAt0nb6l-JmGt4NaBggTccUk2ZVDAb9PWZcagNsUuj
    DBTXaaNeAR-6QRPbg>
X-ME-Received: <xmr:x_UcaJCfLF-rjrx22ntOEPVqqzbMXISCRGDZa_JCYWomZFreU0iy2UT69C3d-qKZxBgYarpllKcgSWkF6I42IxMKADYl9PRo4fxK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:x_UcaHe8_tpkIBgNtOvh1eGsekR7KpiYWueSsHUuOo2Sf_bf_GOuBg>
    <xmx:x_UcaAPtwEfK6rxkeHUrEkW-kpqm_Sb_inD5IUQYJCxhbQHq24Vb0g>
    <xmx:x_UcaJk4wHsCxYAFZ-OW6K9qO0KGpUHE1BeADDCKyHcpn86o_VU3jw>
    <xmx:x_UcaKsgW7Eyfeh36azEAcIgj0y95UV1hxcvFgnPPujc6CmJKYzRfQ>
    <xmx:yPUcaJFPg7vCRxwngw6oEcB1lTztZ3vb_AFWukaovkEQqMLItJtre85W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 14:19:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
In-Reply-To: <3952ab1e-dc67-c47b-a86b-88b0e8886755@gmx.de> (Johannes
	Schindelin's message of "Tue, 6 May 2025 10:32:36 +0200 (CEST)")
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
	<pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>
	<aBhVWMabOFYRUjvD@pks.im>
	<5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de>
	<aBiIPe7EVTBxENUp@pks.im> <xmqqmsbroxxs.fsf@gitster.g>
	<aBnA3KNOfAo9EbpS@pks.im>
	<3952ab1e-dc67-c47b-a86b-88b0e8886755@gmx.de>
Date: Thu, 08 May 2025 11:19:49 -0700
Message-ID: <xmqqmsbn55iy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Indeed. If we keep both bugs unfixed in `maint` (the bug that `win+Meson`
> does not build with Visual Studio, plus the bug that `win+Meson` builds in
> Debug mode), the CI will continue to pass... just not for the intended
> reasons.

That's fun ;-)
