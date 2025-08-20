Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B542264B0
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671095; cv=none; b=guTQKfAPJS4AJa8Ki4jzKopVjjApW5uqXBP8pfJXa2PJBypUOEcGvHlTyNsIeNfRxiVHsopH0a44CI1KoQc3JLNPWx186ejI+Znvv/lkDVmieLgES3XHk8z1a7yL3S9ubC9jOAYVtRiODpFZOil2Und+5Pr59dhYYraDEmjhXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671095; c=relaxed/simple;
	bh=8Z9jzcjj7zzXzu1VW6wtuVoAZdljXd/TCTnB8jkw/+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDV77qltiBbSj/KgqII0x5UjLP4g5nLmiNSFug0Psm+6rwIF/X8FmrsRldyneEH6UjaCHwLCA2L4aogFoGcvp9SRETGLEBwNwEs5KwUM63gt1l/i6/9J8sT1J4RtHfsu3M28Y9cXEXi0KWLn7Q5b9P5fkI7ufb7ydvSGnmsOXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YU4+yZBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVj223F6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YU4+yZBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVj223F6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2709D140039C;
	Wed, 20 Aug 2025 02:24:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 20 Aug 2025 02:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755671092; x=1755757492; bh=8Z9jzcjj7z
	zXzu1VW6wtuVoAZdljXd/TCTnB8jkw/+c=; b=YU4+yZBWXe1ZfLcY+FXEu6wq1E
	MAEJDufnvp43M9Giz1PytuD+/zXblI/B+b7Pzn7V7zWs5Gc7Nc5emVeMgcpFesXK
	ujqLghYnlKSzYfDjBBrlySAFDh+bVHghdTSirN/uS7nReZobvg7uoDUn9NLAmnL2
	/1oMPOtXcPJtKxbOAmNS5hwsezRn7oo9p7lfFJ+HyynG145s8vB2hSirskVaEpa1
	ERljNpR5vRGdWFtA4BTOwMsPUdrSJ3Fj7B6pV2CKZtKw+lUjxucLI6kHTTur+ngM
	Gaz6QIY460Ue/XuuoMnQ4Jx8ZHUaT9nD+zCExwsZJAmv2lvUl1+3lgImDjBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755671092; x=1755757492; bh=8Z9jzcjj7zzXzu1VW6wtuVoAZdljXd/TCTn
	B8jkw/+c=; b=bVj223F6U9pFEzWMlDpyQDhGlOES4mYk2j4ONz6m1E+1Ik8c2g9
	dmQKcV9wIQdE22S2kQ/orB1drerP2IdASVlX1rqTQr5ApXAdAjR3apcNd/y9oGOt
	2dKEldIaZVqrQFP6ElUSW64BjIKpnKroXIcEHTovC/NJSUEHZnF1MpSlBItzLRfx
	IAGN0oiLKcukWAb//Wlz/P2/RH9xaMYEkSTB4RXNV+DbWPOpnWx0p24CCLlZVWin
	eXXNWgZSxL0fpZ/XGULl0sK69W52syDs5tJOFHg70khO+0VDpGGgEQicMZ9TYcPV
	pzM25Sp7EdXHEMsgUkeVgfYNbmC3F9eOyjw==
X-ME-Sender: <xms:M2qlaADnlE8bZuzIEtE8rpHav24oi_sEzQzN34ph4VrPtJqodLaG4Q>
    <xme:M2qlaNFo2gsxOCha7IHzOIU1bqqAep4reJIW3U6IqgIIDIxwxlf5KJBYjhWbolOHJ
    nXNckg2sn_IgI0r4A>
X-ME-Received: <xmr:M2qlaAJ19v22IUr15ifwHRWyv0Ekdj3Yh2elbx28IgIc3jkF8ReGuvK4-HU66QSoK1x8Xw79pUeGrPNeFN-1V_1IEgRoUw6cmxPy3bc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NGqlaJnTKNbNaR85i-J7FUkBiWttbH5EPCWhNhROhPDoZwPhTIFrJQ>
    <xmx:NGqlaATcH-sCkxxDrVnkE7JX0Qd3IjydpTjxfOqz5K8Eqprej8tSdg>
    <xmx:NGqlaDJZ14-gU637bnxJyAIVITcMTR5ov-pvyVCiX0ecfQHfzSTQhQ>
    <xmx:NGqlaODMGGrgh_M1-Nx8aFhZoIt5H2ktxL37V7WSJP0CjqwJ7SC3aw>
    <xmx:NGqlaEw5x77Sgt4tqw91sxs8TeL_-4e1up3tsiZn67lx1pPSCxMB9jah>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 02:24:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 03/16] odb: move initialization bit into `struct
 packfile_store`
In-Reply-To: <aKVV-pycfcXgwMit@pks.im> (Patrick Steinhardt's message of "Wed,
	20 Aug 2025 06:58:34 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250819-b4-pks-packfiles-store-v1-3-1660842e125a@pks.im>
	<CAOLa=ZS4vBPp=2=X98DwEk48qgFMHvM4BecUPayGAK1Wasd3=A@mail.gmail.com>
	<aKVV-pycfcXgwMit@pks.im>
Date: Tue, 19 Aug 2025 23:24:50 -0700
Message-ID: <xmqqzfbubjd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Well, now that booleans are allowed I think we should just stop using
> width specifiers like this altogether and instead use bool. There's
> probably still going to be cases where we use those, but I assume that
> the majority of users of this syntax is for flags.

Yeah, unless the structure with these members are designed to exist
in the millions in core (like "struct object" and its descendants),
bool is fine.

