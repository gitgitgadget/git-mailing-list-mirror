Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F72951A6
	for <git@vger.kernel.org>; Wed, 14 May 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253142; cv=none; b=nj4rAzMjdlX5fsDuQ6bttVHcI/IM6MsMc/PBnr9oYmykFDn+DaYkXmUF/GDnMncSAaDQZJgpH2Y8WDYs1nLgJQeaOiU6eS9AfueOa/zRHPDBznHwBVRHEti1q2rmc4TlJG5kdaxpJk10gu3LTRE2hlBTRizy8HovO+sDtEUzSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253142; c=relaxed/simple;
	bh=ugNb+HEOL/JVaPcw6BOLJNBbGuRnD5ILZDKUVsS4nFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZKhIFTFlqubi2foLQLDnFR/A4XS5ZIwKB8DS1KaTO491W5+Chi7xg0JVTRA40HQQEWZ95lXTIuThqugLn0aGNC5PunAzb89DApOpeovOqmgIPfZIk0B9mkQXgxDQW6EFCAEEbq8GXDuk1Gm+chT0gCQYCdhVC7vpUynEzgTSOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R5PYr8iG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQn0tqvu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R5PYr8iG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQn0tqvu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BDA911400B7;
	Wed, 14 May 2025 16:05:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 14 May 2025 16:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747253138; x=1747339538; bh=ugNb+HEOL/
	JVaPcw6BOLJNBbGuRnD5ILZDKUVsS4nFY=; b=R5PYr8iGTb6JkUqmT1XAJddBuw
	WRD04XgpBUqRgXk08M617s/o1O1QVuebu6+g2yQb5vz9QpfjvcQvej7ImyEhx88t
	j9c2wv7cwPKUq9QI9OB31TbhBy60uSAJpKI2tCNevsVyT7a4OAWtVfPHI1Lnp8nL
	Pae7zFImBzZkbM2F5AuwEk3CjrLA1clKZNHHqTQUuaFsLyX5v27BMr9qu1d7/nik
	Rglzd5OcvVqdhJbGZPmCnWcZzP7bp6pGP0ZxtKgv2GHSGeKCsk7qoNIiO4aVkb7U
	x9kVnRkidu08swT/nX5jELPMx/r0KHXDJiGg5Tm+OmKfc5IJGoMBvdRyKamQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747253138; x=1747339538; bh=ugNb+HEOL/JVaPcw6BOLJNBbGuRnD5ILZDK
	UVsS4nFY=; b=HQn0tqvu09X0h4hqpBc19ybC2jIg4y1cTJxLY9Vqu9Rf2RQrXkn
	29IOdpYKgvbprGfRfjZKAus54httZdGel2ljdqZdOelB+iJD3eo0mzk4R8cH7oHL
	+55itbAqdfsdLzjvNllTBco4sCol2vdmrUSrzbMJoIyVlnOUOlGv+qaCOE/nECOD
	VHzmvOJYD16IYDbggDdQPJUPhhz6OkfNtMkyU4WUeU2/j1QXIsDQUS9eAJSGqBS6
	Q4cqhh0KILwC1VTaQ7sAGpJNchBfd9T6NgKmJBA9uCxUjFWF6WFWBFTc0mAGfYRB
	oOo/ENh0apbwFiab6/EZHis0beSkSYZ928g==
X-ME-Sender: <xms:kfckaGHuNybf955W85cYXqbi0WdYZ9_WUCFqzTnC0IlXLMgpWk1z-Q>
    <xme:kfckaHXBXa33DmreQE_kkNa1IhxyxxFa9TuFJaS1PmNWrfntg5yF5cNOlw1jSAqQz
    3HOQBHGLajMCWeuMA>
X-ME-Received: <xmr:kfckaALV9tEScSeF5yXxGkubUTPWBF4Uq6bERKZsQno5kobErM_Smp4oXQ5390dODA6kOfb8UC333c5DCHoO2ZQ-qCzhtr9xK0IxCq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprghrnhho
    uhgurdgsvghrvghnughsvghnsehsohhprhgrshhtvghrihgrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kfckaAHqM4hgHmP7kLZm5aCFawbTbFFE0qUaKgiU8rTuSlVk6W6doQ>
    <xmx:kvckaMVMh3VWE-sWQ7u7omC9hXK7kp3g0i76QF6h1H6HCvWvnwdrWw>
    <xmx:kvckaDNKF7Yhjihd6joYMtovrjuj8KvyEkAc4WzYMuabweV2HvHXYw>
    <xmx:kvckaD37NYgTm4ERGVyQqUNsdcyjJ4N5RQmRukuZdwnnoOeiz0xeiQ>
    <xmx:kvckaLrC2DreEgb9uy7Shx9Iqa5WJ9IzK7iE-Z8wia2cPa2cmllFsrGX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 16:05:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  BERENDSEN
 Arnoud <arnoud.berendsen@soprasteria.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
In-Reply-To: <20250514181938.GC2196784@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 14 May 2025 14:19:38 -0400")
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
	<3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
	<aBhZHA7av8bWH9Ac@pks.im> <xmqq5xieq3fs.fsf@gitster.g>
	<aBmg1_wlF2fuk96M@pks.im>
	<20250512135017.GC1191957@coredump.intra.peff.net>
	<aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>
	<20250514181938.GC2196784@coredump.intra.peff.net>
Date: Wed, 14 May 2025 13:05:36 -0700
Message-ID: <xmqqo6vv7yb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Right, I know people use them. What I meant was that if we wanted to
> spin them to out-of-tree projects, we'd need somebody to volunteer to be
> the maintainer of those projects. If they stay in-tree we can be a bit
> looser (your "I don't want to be _the_ maintainer, but I can
> contribute").
>
> It does put more load on Junio, though. E.g., if there is a security
> problem the project has to deal with embargoed release engineering,
> whereas a separate project would do its own releases.

Well, but it certainly is not more than what I currently need to do;
it does not make any difference whether it is housed in the contrib/
directory or in the tools/ directory.

> Last time wincred had a security hole (in 2020), the phrase "unsafe and
> unmaintained" was thrown about on the security list, but we ultimately
> fixed at least the immediate issue. But I find its general matching
> strategy to be not very confidence-inspiring.
>
> Dscho (or anybody else familiar with Windows) may want to comment
> further.

Thanks for a redirect.
