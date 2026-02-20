Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EE30F539
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627117; cv=none; b=CDO+qF6vN1jGB0mh0EcGiXOWs3nW5IHb9YufQBHq0eDSkFtL9Sm2BF1CogTGbXfy3MnW1kHSlYxJf0twPuu7ezi6biWGhUl4HFT6UATg8/2T03Nmt407ayHtqZUoboWgNy7rBtpmnsLkfLN5r5LhGz2PJf+9UgmxgU20SN4YlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627117; c=relaxed/simple;
	bh=fXtifu23aEiKI6FaSxfCHTa2PuzCGW73uDaPscBZ8so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JTyKpPf3bXGFD0PxxMiWKeJ/2nDKpUoa0yQ/WO9D4ZDKf3ObgiCNRzzAbceKBc5v7AfFDmX9azZZrzs8qEf223EUhm3C8xs0iCcslHdRkIVqAm+OuUeUAXsxoYxafIhZ21vyPhbSflOuLx6r2PVREkZ6BS2wnmSXY010kQgTgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IXJ0y+fg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TB672+4w; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IXJ0y+fg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TB672+4w"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCD547A00CC;
	Fri, 20 Feb 2026 17:38:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 17:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771627115;
	 x=1771713515; bh=b7TfpaZgAUt75UQKaSF4g/0KfnXVIUjJP4g8lL1hhZg=; b=
	IXJ0y+fgKczH4gSSn3NAi3PqCRPcPTTyWNoigjxIbNThGyPTG3cUxhdvehwnN5Ne
	YzD74rZgf/LdmEwkGO+yQGk4jlfCBYOJKrwOPRbKA5Vvx5hfcAggwR9xV5bZ7zr0
	/kyOF7n2DMHzHqhKdZgKbzyd2pwItyUkGg4IOlQcosIZzv/HieVJuNKLnALvmMdB
	xyaGL5cDDNipXaYwX/xxAwnEjRVnFLV7wfxn6JTujnWYYBAmNnOl2k0I3WQtDrxO
	bLYxC9dzfpxSb2JXS4PJfj0Ob1TI2zqxCFBzmWFaWDJGkSYLPkIO1Z0kMEKhJd1h
	0ehVt78l3ruxT6/m7/YWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771627115; x=
	1771713515; bh=b7TfpaZgAUt75UQKaSF4g/0KfnXVIUjJP4g8lL1hhZg=; b=T
	B672+4w4AicJBsbn5gClQC+2GfNuvIXFRlB2VlZlGi1msNmD/qMyFqKA7LYNR07q
	8cuP/rb1lEeyLn0yvlqG1RPrhrG9Xm0POj7cGvD4OMECIf+F+poj+aqRnBwVQnMY
	gZcsquVo8YrSgRZcN0n4WUAMZlMZoH/i6r8QxUxoWBWVPaymS8dxTI3IZ5YUTg4j
	G24Cu7wB1CFqTF1bY5HWn8gzZx7tAU7iVeiDDa2ctaRVa9kiGCczOq94NsjYbMZq
	srBf5/XxI4pTTU0DTsf4rgpye47L9sZ4mwXqOuFArFeintVaLfdtfCUHepcml/Uw
	IVIst3rlRHa4qkPxBzQtA==
X-ME-Sender: <xms:a-KYaVTUloLY-JGXYJlN8GvEBlIjMAn40Oezl8cJg7DClCNy7HG_Cw>
    <xme:a-KYaVrGmM24U1Zi2EiDBeyKLvV6CGbKXfz83uVLv87U87IzVq5mb17pCP38KbStB
    iNuVzRf4TGku07SBxPYdLhRIzNFuRmPT6Gr2erSjH63ua2QutNrDNc>
X-ME-Received: <xmr:a-KYaTLjS1YY18ndYT31ON02FAh4y29cTOSIabzhpLaF2BtsT11nSYsT8HDSDbKFQDwrJiyOFhMFWyNBU0U8dD1ycn76_cRVQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehrih
    htohesrhhithhovhhishhiohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:a-KYaYrSJ0D1_pcMJq7_RhF4MSyJCW-hOTPJRKMq90Fco9yMMhJwOw>
    <xmx:a-KYabxdahBkWRbsYxs17W0of7jb62XhH6G4hzYEfBO2wiLpjHyhEA>
    <xmx:a-KYacMqzQJjC6zVgOsoJXLXgNs9e2QckvjubTxOxmSY_z23ka9WgA>
    <xmx:a-KYaQ6vw2EPNx7_dxLT_8fqNi7-9MhCFBr24t5WsVmhNaWJ6HQUig>
    <xmx:a-KYaYG9GmwjC2B1Dk81nW2cEWY4zt3JJVX8PxoOWUM_bF1x7AdlNeUq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:38:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Rito via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Rito
 <rito@ritovision.com>
Subject: Re: [PATCH v2 0/5] gitweb: fix broken mobile layouts across views
In-Reply-To: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com> (Rito via
	GitGitGadget's message of "Mon, 16 Feb 2026 15:53:26 +0000")
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
	<pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 14:38:34 -0800
Message-ID: <xmqqo6ljujkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Rito via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Summary
> =======
>
> This patch series fixes mobile responsiveness bugs that currently break page
> layouts in gitweb. The approach is adaptive rather than transformative:
> preserve legacy desktop layout, add targeted mobile constraints at ≤768, and
> prevent content from escaping its containers and breaking the layout.

The latest round of these patches have seen no reactions; is
everybody happy with them, or do we have too small number of people
who care about gitweb or feel competent enough in the area to review?

I am inclined to say that we should just merge it down and see who
screams.  Maybe we hear nothing, or complaints, or praises.

