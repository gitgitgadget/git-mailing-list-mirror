Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67CC281372
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756165222; cv=none; b=EODgALq6xjQ3BdgnnhlXHviT5kvtRo19vFULL3BbxQpnlzfFILS1jrgTjTtbynVolfgEWFEwaHomUsGCGQtbVC0BHQ7v9Hy7LQTRuVH8U3oWjgn8NVS1S6azgBU6QWlkFGu8jwjBtAflNoIx5oyIEY6yLGSdpiiDo3W66M05L+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756165222; c=relaxed/simple;
	bh=xlr0DCFxF5d7dpn9iDuvog2DJqlnifizkd6Rz0ongDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HToCkHF+lKUEkGqbKIdPVAp2S7YylA1nelOGAGubKGzGWh2dhvwOQrYXpLHBfGV6b/94qpAHS7Gp3zU87rcLZnrZBGsHuTIUwF4jbKtoAw8HBI2z+igdEt3sme3/sac+wvnrAOqiPfSGV3G1iMVA5NX8DGiQV/TTbY+zTzMTMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AHSWjxGU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MvkZykXX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AHSWjxGU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MvkZykXX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E033014001C9;
	Mon, 25 Aug 2025 19:40:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 25 Aug 2025 19:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756165219; x=1756251619; bh=wf+BRkRPoM
	7/NnYKrk50n8ALAU7I2gBz3JGhFptNPDQ=; b=AHSWjxGUGvkoz9BXLIWXBJ2adt
	kbXIhYUo//NQGxW3bDdk8wJuaV6C2Tcl9J4XEpni/hp8DHp6qRh5SGuFuBIeFsJA
	Qg+klSPjq7OcsAbEgeZMeOwbYAVUhPA500wnxASe3vwGNrRHfqHji85WEan3BymP
	orNgxKmb79PKOnarDX8ngJGue/gRwNKLyOoaSRVu21Wfz8k79DCtxYaRC7to2NPh
	OdQ8HKzeh7iEZhfiM6l0qwP2ZMOKVhklq6n7/k5X286RoRYRDM5pW6WNPtiWbKPJ
	Ov+0Dgpyx3chAgJ3JCU9VtSaIuiBK4MVMThjhGAKoyi9n2VwVzmTuzh/LzOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756165219; x=1756251619; bh=wf+BRkRPoM7/NnYKrk50n8ALAU7I2gBz3JG
	hFptNPDQ=; b=MvkZykXXEz0waiZS7pS9EQkcZp6V5OcRBnJ2YCilOQxpO8U8s9h
	lRY4fUG+hCVUE0vhqqXd4W5zSjeTLsQiqwppBgi/nsVZ2T0pGyPqv6akD0k27Hw9
	/6xNDA0iYOU3DtrYfaoeMLr4V507KODk3A0AfYqZ7CqkbKW6FwjuRomki2Zce4CH
	fcwi7wb3hgQYse7vy/XlpR1uAS/RkpuWYh5R/+2DHxIdQM66X2qyEPcI2K+xuSdA
	ZhZHY6/xAgLNQOxrNQxGpobFwvG8i61kUkiRoR4coS5It6DhDHPaiavPcm2J3jp5
	0+dvAd3zio5JRvjgbQbp/nVys+gUSG7Xp+Q==
X-ME-Sender: <xms:Y_SsaD8igyA6huAAH9DfkHsOmhUeeycz2wEeSm4qh3a75KGwDKiJEg>
    <xme:Y_SsaC83LBHn6r-f0khSWlgrgRfoyLSK7dHZwWiYa1wKHUbjZuy2eahZsmLcmjosg
    iDsnBhlhXLniuWRnQ>
X-ME-Received: <xmr:Y_SsaKc8hpNkcmpYA1iJRt7dz4UhbIRq-6msAS-niFm5iCcTFcyQD6__SHT_bo7aLUQGRe3YOgv8yF4s7ZRLoRgp4GvEhyU-WCY__FU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhithgthhgvlhhlrdhhrghrughinhhgsehhphgvrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Y_SsaLFY-5D5kkjSD89hDsEfecWQrMYtW5DNpdVBFc0_4YPaMZ_Pyw>
    <xmx:Y_SsaIdKcdgzeums8dP2pbNLFTlVzkO6Ve5efnwfbcY5UOwot6ONWw>
    <xmx:Y_SsaFEPeSUeon6qLTJDu7umyXZV-PaxNEYe6sARiDBJBAe3qh97_g>
    <xmx:Y_SsaBUMKXhAgymBja8Pgy1olyX7XH1faBRuz0Yypb7Uq1It_VDZmQ>
    <xmx:Y_SsaCx1X1K_6Ptit0v4DrDL91yo7mvi52vaMgV6qpyAxRrPtHCiFAod>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 19:40:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harding, Mitch Perry (The weird one)" <mitchell.harding@hpe.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: I still use "git whatchanged"
In-Reply-To: <IA1PR84MB3012CE550D803A3C3CC5572D873EA@IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM>
	(Mitch Perry Harding's message of "Mon, 25 Aug 2025 19:12:11 +0000")
References: <IA1PR84MB3012CE550D803A3C3CC5572D873EA@IA1PR84MB3012.NAMPRD84.PROD.OUTLOOK.COM>
Date: Mon, 25 Aug 2025 16:40:17 -0700
Message-ID: <xmqqwm6rm0m6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harding, Mitch Perry (The weird one)" <mitchell.harding@hpe.com>
writes:

> Sending this email as requested by my friendly git binary.

Thanks.  As your friendly git binary should have (but did not)
suggested, please switch to a more modern variants like "git log
--raw" (or --stat that may give even more useful information).
