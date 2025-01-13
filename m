Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13F240221
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783193; cv=none; b=H2a6oTgELr+yCV20BwW5yzaoF0IRLMkUSCJFZDcfHs49TTZm0ROiCg13D912afDYE67wNx4ZqIJZcKN9ZSrnE/8rWFBISSHvYC9kakdL66hXRkj3lTs2jfQgwtQ0fcVv8W8uQz3gQXTGL5EVypEkcbYIoWiHE6VZzBpSB3Nk92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783193; c=relaxed/simple;
	bh=DacvW5ZDnHHQTpy+d7L5x+ksBM8tXJfQzGGpwV0oy3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AAz7lwf4WtNmuQAUgiJTXj0geRUAPwVLjnKyWQyXI1ziOI7rSt0CP9b/yiwEuVZmlvjY9l06n0afq9uXi0f5hzuib6se1QhmH4C+IeiA6+Q/K6GIQUx4B0xSskESWukD0KnCHn6reHWt7hT+bvDwW0EGxaF0IQO4Tb8VorYVmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1PEsGjJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pPn6Tn8L; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1PEsGjJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPn6Tn8L"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B013111400E8;
	Mon, 13 Jan 2025 10:46:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 10:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736783190; x=1736869590; bh=u3tfZ7ox0s
	DNQSeXDDCaIhkeCvmFj1JUDU6ljHV9hRk=; b=1PEsGjJVqvpSJRtLCTLqh92HN2
	it8twdD4HYwqUaEuQX0f5JE4GjBGqsChmQM2yYJoKL0bZypr6+XPn54kdIMawpew
	gSERBUG/JpOILpJCFpFYBvYWF759rvow0KCFqTwzxGhcNPqGVJmMbLoiIx4DFf1H
	w3gbJNB9BK06lHn9+HYDS5nnr+RXIsoorCgK6G/DS9JW0vvZKBaEH2xeXsXRKrq8
	ujxtIcq0O5TizJgwmN+ZWgP0JSd8WFYzwjDqMipDbjWsYR9hC83x1rd8xx9djdA8
	MS+x9bDozYqWJ6nK2tv1jYcbgpoc0frW+CgRpyPGWhcAs62kXYLBrv6RhzTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736783190; x=1736869590; bh=u3tfZ7ox0sDNQSeXDDCaIhkeCvmFj1JUDU6
	ljHV9hRk=; b=pPn6Tn8L3h08z7ZcDdJGeGgPx/gWT8Y00ePz9QGPFCw7FmMrRH/
	VUeKnldTasuQ10Snt8zQ/1mVO5fGgvIetDGJd/u3FFC7mgGNFMkt5K5VlPitIV2V
	leChRtfZ2T3NPYk2toYO6a8D2gTNfWOUjv6qL3HLtEOIqGQDdHc/+2lubmOeOsYm
	N6ixhs090Qn0jjRdYRBJUE9o86Le6GJ8UkodqsLITKWWiOyw3Zp9ETID/R9yOUVF
	AXiEbHdZz9LueD+si4UmN6djwaLhiQnuw4Zp0FSY11D/nTvgOgJNNAfLKT8yApbp
	80LbhLr7qVMX1np/cXSHXPSlJcyLxadVH+A==
X-ME-Sender: <xms:VTWFZ3neqhYh0x9Lpk5Z0hlixdMngI7lw7ptQ3mRyKU58PfiUNv_3Q>
    <xme:VTWFZ62LI3i-K_jrStxsSpRNaplWBmZ80H-Kd8Ki3RNzJSeB9ooiFxGKE4Btm50RK
    Fc4OUt6vghEacdvBg>
X-ME-Received: <xmr:VTWFZ9o-fNc2U-D8qNBTN8l10-r9ufbkvmlliWOFCPrBTSw7tHqPpHox5VjOCZauGGnY8bUo19XOACkgQHBSuJMmt0SFkF82YmYp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:VTWFZ_kKOqJVp_B7MumnX_2gV_Phdie76Jg_TK1WrefYXfVBSRz6lw>
    <xmx:VTWFZ10mYoCBmFTTR-gU8fr3VMqJYgiPX9faSNIRawmjb6AcBHmy2A>
    <xmx:VTWFZ-t_5FxzT_jjD7H4HWG44iWfbPe2SfJuHhylw7a8YSOvEVGa0Q>
    <xmx:VTWFZ5UqeQFF2UmWfX44IhOclsDCcifCbUYLhhtB_0Q5puWbgTKosQ>
    <xmx:VjWFZ-sJwy-ysXFX-uJaf9Ckc-4WW-PryiqXR3vVUtySR7ws5ymTaya3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:46:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] connect: advertise OS version
In-Reply-To: <CAPSxiM8kWoAXEvAVtp0C9NUQaas3KN=TMBA-p9o6+8KDQbmBUA@mail.gmail.com>
	(Usman Akinyemi's message of "Sat, 11 Jan 2025 16:37:09 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>
	<xmqqfrlvzzcd.fsf@gitster.g>
	<CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
	<xmqq1pxdnuxo.fsf@gitster.g>
	<CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
	<xmqq5xmokn0z.fsf@gitster.g>
	<CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
	<xmqqldvi5v5v.fsf@gitster.g>
	<CAPSxiM8kWoAXEvAVtp0C9NUQaas3KN=TMBA-p9o6+8KDQbmBUA@mail.gmail.com>
Date: Mon, 13 Jan 2025 07:46:27 -0800
Message-ID: <xmqqmsfubtt8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Actually, in this patch series, there is a config option called
> `osVersion.command`
> The specified command will be run and the output will be used as the
> value for `os-version`
> capability.

That is essentially a "you can throw at us any arbitrary string".
So my recommendation would not change.  .format would not give us
much _additional_ value in such a case.
