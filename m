Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A187145B14
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734803018; cv=none; b=ZNfCbMOr+siJmy69kC4LIxGy5ytePmF118VaP2QhwO5/ZxteNjSo+3nVr3DKfr1aj5xuOYF49TG3EqVHFLEB8Zv05n++UJz2Y/Q3pbwGZz6V0203sw3I3cDGhJ9EoTGh+AoQCDv1zVjylvew7V93z90MjVyoZpGQpk5QRKGNWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734803018; c=relaxed/simple;
	bh=YuVAHbzoaQRbHHYuwA8jOxXrE74DAj+TY8ELvKCPlDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKXzQ30epg7OfRdupaqZpr/vhzSermDXfc7rKwLAq0RIjOfbrAstPOw+xuGY7r+qNdEVMIZimk3N2XummksmZ82j4pBA4fWdnhB373ST5gVVDd3qHYzmKPMe0ZSghY5Cj8vYxaYVH04/mcLEU2aa7UCY7i3vO6MQ4dbVuj9iBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dgBjwfhW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klLDcabQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgBjwfhW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klLDcabQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8520C1380111;
	Sat, 21 Dec 2024 12:43:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 21 Dec 2024 12:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734803015; x=1734889415; bh=dHRTrlk77b
	pKhMPU7nqo1vwqGssq4c5cDwhUyfnIS94=; b=dgBjwfhWh26TfNlzHx2UEleLuJ
	+TBr22NFZ/piNVlK5eK5X26W/2iYTGiW6Zr0a83gKSXQohq8YDRvcQA3E6eHm3ss
	WvFfyLTgOvGnfbD1qkbdmzNZQOXoAX7S/OALLYKEduJn3MgQFvK55n1TnvyDzuHv
	/weMvrtJF6YYA8IY5zBILJfKLn3Rb6mVKwoWgG6IYhU3R3Wj/4jZwlKTQkwOk8Mz
	Knw5rJRWI2GO9ULYgQXkj/LvH72sSdVJDS4PnTKOISKT3NluMg7RqW+sYVaC4jsG
	pzwFmcD07Ym2YIWYyBiK75VM6merig0jeaqj1RF1bva5HoqKCaLFIfTJMyGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734803015; x=1734889415; bh=dHRTrlk77bpKhMPU7nqo1vwqGssq4c5cDwh
	UyfnIS94=; b=klLDcabQ0yM6ysrxq2mTHWNDtCJe8abxgmfQUemH+g/ys76ZdxA
	DR3eQnBIc5bYGALQJe4bdc6a/xb+Sa0+N3EJ4yQPF8VrAAo17xznKIUnX75klNn2
	QlsFmUYVrHRK7s8FXV3d8lxn0NoIm32yFruV1knbiT0D6h9IvExb1FxkICrK0Uph
	JXdmFrxDLEicYzab4i0V1R60v34xzD1Fr1UZAdDNISrpAazJlSJ0d/ja+nsiv8ii
	8Gh8CnAH4WAuC6sXASJLP8mifVNqDIod1vST4LfwR3B8Md44HZBO4o+igETjdeqr
	vtTCaEHoFuHAJ5D1AASUmMoK4Ox477dFDvg==
X-ME-Sender: <xms:R_5mZxLVpoYMaqAXEO3h_Gru7qqapVowKMW1_SV4d5i9y27Y0equGw>
    <xme:R_5mZ9IABYmvxpt9qB2cUfe1mZ20BhoqpMRRH9EdtZyTwYdXKrhunaacz2iH3ynut
    bILG8lQNPpHEw5cYA>
X-ME-Received: <xmr:R_5mZ5td1qoYXt_y_wqOBj-NjRsxPLnhGhHLPaOt5QyDmEJxxqIGU-ZoGErtc68PmTM4kU20vAtz4iCuNecqdToxXLzQz6cW5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrnhgurghllhdrsg
    gvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R_5mZyaJJk9_NXMuqHsY9G3KMoCCBUp7rzhyuHoGne4OLjDSP3WhLg>
    <xmx:R_5mZ4ZN7PF9WLTxutUx9_OE_NIw0HeUrddjk5gL10MReB7sZj0F_g>
    <xmx:R_5mZ2ACsntBMEjOSA2uHfJDUTzi-rD4HyiUA1WUyM1ZmNmnlXnC-Q>
    <xmx:R_5mZ2bUCnwbBMjRLWAc_u4nMmvH85limxKe5xYu3LqsVYlovw6sJQ>
    <xmx:R_5mZ_VJABnomkz-JrU-JxidfELoFcg_7hNpmWW-aiVC7fSp9TmTOEmP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:43:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Randall Becker <randall.becker@nexbridge.ca>
Cc: Patrick Steinhardt <ps@pks.im>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] reftable: fix out-of-memory errors on NonStop
In-Reply-To: <BL3PR17MB6020D6CB8712F2C6F36FC8CFF4002@BL3PR17MB6020.namprd17.prod.outlook.com>
	(Randall Becker's message of "Sat, 21 Dec 2024 15:05:44 +0000")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<BL3PR17MB6020D6CB8712F2C6F36FC8CFF4002@BL3PR17MB6020.namprd17.prod.outlook.com>
Date: Sat, 21 Dec 2024 09:43:33 -0800
Message-ID: <xmqqy109aq4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randall Becker <randall.becker@nexbridge.ca> writes:

> Thank you for this series. I think the problem may not be limited
> only to NonStop based on the documented ambiguous behaviour of
> malloc.

Yes, an implementation is allowed to return NULL when asked to
allocate 0 bytes.  On the Git side, we sidestep the problem in
exactly the opposite way---our malloc() wrapper makes another
request to allocate 1-byte block after seeing NULL from a request
for 0-byte allocation.  The reftable code takes an approach to
eliminate the need to requiest 0-sized allocation in the first
place, which is an arguably more valid solution.

Thanks, both, for finding and fixing the issue.
