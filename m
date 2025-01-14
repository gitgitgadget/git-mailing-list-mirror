Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3020898D
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894612; cv=none; b=dJKP4XIlDyfyoxH0bAxq0x6O7awDOcvj3Ea2A1PbB20eM8nBzT6rwM7VtobYQ7TCh01HHCNbKKZSXGGb1eSwQeeYyWP6EMZiKkrajPtSP3J5u9FX/U5HFU7h0k6tPsxm9QTZ8BHoPdkjCUsx158qql66ZjUiiGee7thydl09SXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894612; c=relaxed/simple;
	bh=XOMUyq5nAT1pf6juXDSLCKnHWfwj1gw2/Id4FPeZOac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIZ+heh48RGJ9l0BWYc9wdGBClWkswl0kWW0h/aWfQ02TUKuCkIw2CFnVvxN/vzY9Ve4itzHWXI3eac4/UrfJOhN20V44UPXEAUIBhQprmn6m28RBqtUI9xTA4K/wr7SLCcXXmg36YR9YXTXRglqMqW7OFLFm6ML/DA0M2NgEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y2rfujCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpuFKT4m; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y2rfujCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpuFKT4m"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6624A1140244;
	Tue, 14 Jan 2025 17:43:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jan 2025 17:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736894609; x=1736981009; bh=R2umyC6MZh
	6Cs9RR92mKSUGOu6zhktELtSMlOPco5sc=; b=y2rfujCRpyPS8gm2ubPgxjOIZo
	L/C3VsXgODAFwQtSUH+1DseLMiCSNt6pjSVU+msFb/wliVCt8kiF6kSqijqEOdi/
	I+i8kntYgvk3NnE1+nbZcWABgtNWxDhpXNo20yYoNeHrFRpvNLQZPVIIummlL5hD
	RJVS4TmTSNODePGt8RROtzWNUrS3K51x42KPkI6Aly1w7W2oSc99Do4f+12uaEbd
	niyMBr8mKUTiwVUmjVKtOriaZEHYLriX+069bWXXB5PBGidcEWH4uiA1lvYLxN8X
	gOzja3Svbn+pA4ICt0yy2H3R5vAzBVWH+juu++zz6wQUx+e7npBcC5/I8TSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736894609; x=1736981009; bh=R2umyC6MZh6Cs9RR92mKSUGOu6zhktELtSM
	lOPco5sc=; b=GpuFKT4mlWt6kZo/unPJhqrYq4yqH/1HtKhV/j6Mtjy9sg3UazX
	k5s1CiDFHc+yQFrYlCSC/K/eaM/WRzZi/rMTcZ7ZBZxgGSVLNvl5D4KwnO3ZyrW8
	qHyuPksocVvty0voaOmGssRhLO1citEmwhPhhY+gVTxy94LX7bK7IUUpzqbklnLZ
	oAYnax2MuC9A3LzTTipyT8udKHvLoBVljwFOW065LoSh9uT2x7gdn2SgiJ5OAsg0
	2wWswlLgGgGq9vs406+hP/BMf1VOEVGGdzsfcOGjweIjKo74V5P+V/LWwzKIta9s
	s91NpvYfWWrW9KLcZgwNr9REenmAh013KsA==
X-ME-Sender: <xms:keiGZ8kB2q768P3278hC-uqppGl18GHUPUb4AQ_KYb_YhmVVIbA6uA>
    <xme:keiGZ710r4uynIAJIpVfzQZYcf6g8BlDxN_9aW2N2ofEVotaEeNjvIoHZ0RZiDyBJ
    9XiS4F1zFwhfiRtYw>
X-ME-Received: <xmr:keiGZ6raMphIbGCxOMxom0Zn4y9vJlwd0RwXhYJs-ZIPvHDJ0p0_6pPAnAF0R4ejlyXRG3B4l44dZp2JXhGMkeGUKBfe-3rUyWr1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprghrrghmohhsuggvtggrshhtrhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:keiGZ4lCt8N5k1Wh58EHU5CtcSdl62LqOZ9zZKjDFO6d9DrorTJ98Q>
    <xmx:keiGZ60uXlshRhDtf9aov4mXJaW4k880LmeUsHp1iI9UEF8UdpGA8g>
    <xmx:keiGZ_vpaxOcHm-sVF8rU4Ma0UtaBRn2uSk-EvLaECL5K5u3vExgVA>
    <xmx:keiGZ2WzKwldIBWHz2AIPrakxtXrLalo9zn1dI4C1Ux74JgoHt2pAA>
    <xmx:keiGZ0pr3_OVZfc7rSNTkpRQDJmzxE05PAe8JcAPfLFl3VCEmecqu0jf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 17:43:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Jiang Xin <worldhello.net@gmail.com>
Cc: =?utf-8?Q?Andr=C3=A9?= de Castro <aramosdecastro@gmail.com>,
  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: Bug report - Apple git
In-Reply-To: <CALnO6CD35K9O=Wgotij1SiY=N50WiCODY5i-_gBBcGgD73CPjw@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 14 Jan 2025 16:57:16 -0500")
References: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
	<CALnO6CD35K9O=Wgotij1SiY=N50WiCODY5i-_gBBcGgD73CPjw@mail.gmail.com>
Date: Tue, 14 Jan 2025 14:43:27 -0800
Message-ID: <xmqqv7uh10fk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> What happened instead? (Actual behavior)
>> Didn't get a diff output. Got the following error instead:
>> "fatal: --merge-base only works with commits"
>> ...
> A shorter workaround is probably "git diff --merge-base
> <your-tag>^{commit} HEAD" (this is the "peeling" that Kristoffer
> references)

Thanks.  

    $ git log -S'only works with commits' ':!po/'

finds 4adceb5a (diff: fix --merge-base with annotated tags,
2023-10-01), which is v2.43.0-rc0~36^2 and v2.43 is from Nov 2023,
so this seems to be a rather ancient bug that has been already fixed
in our codebase.

The reason why I started writing this message is a bit offtopic (and
that is why Jiang is CC'ed).  We do still have that string in our
"codebase" but in po/

    $ git grep -c 'only works with commits' po/
    po/es.po:1
    po/pl.po:1
    po/pt_PT.po:1
    po/ru.po:1

I suspect there may be other strings and translations that are no
longer in use.  

Are they something we can easily remove mechanically, and if so
should we?

Thanks.
