Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0A3D3481
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038378; cv=none; b=Ut6hA0PI9PfxCvxj/7ER3EiwywvVOnw+QOcaELO36KwKYvXIIyYtbPXt3J4B9Hiad0X5esuzMVibmUcXR6djTDhnGb77gT9iNV44z/8ZhJcNJbwSHTsqSQQ4+p2OxNjKhvms7XRRhRiPXRFOKnGVwZ+IdrDKXpZwwJzwa0Gap38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038378; c=relaxed/simple;
	bh=aXIakfOUbgitP8ZZfG3omu26bZYFD6HJpLFiBBJzz+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jYcq0nmDCwKJCOH53+qv35Q6YHJiuS9f0ZCxLWmqWrAXGLD8bECbTxVz000qptfe833MsRhLKqcCdVVOf/lxiTlK+m0AJJW3rd7nRBzBDy8mnanIeaQ7CxaMdBk7qJq/FEQpvLwnEKJpIGQQ5Sq2MnyT+55QGpW1av5uxbJYl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X3zR4I25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtibYNsa; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3zR4I25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtibYNsa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B7CABEC0579;
	Wed, 25 Feb 2026 11:52:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 11:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772038375; x=1772124775; bh=lJFM3n4F4h
	lg/FMl1Tm9BUAOGxUsAsDpu52NuZbBmE8=; b=X3zR4I25lPChdqcoVAxfNvEQwV
	ODIRJQhBEgDwAfZATMG+NbSXSPIS1EJck/eSarTQqUzK5NsRit0je8bb2gn4GJEj
	/tIREIplmoviyhw/3DOIzya7uztWYMC9Z0ARPnStEeXE42Afcv7SQsqhU0KxOcVY
	5UMgp3yeNmsoaAxICGKWk+6qxA3X7XaGHO6ozZviouMuzRPOfqpko0m9StSRUkLr
	EjD/kRjHdPRsHqOnONtLfMpQYRfBZB5htQZ4iMsZIvOVC8Gr8FrVMoxghAoByOsi
	8qh4RBj34iDTBUNGXfwiB9MT7U5walQ11XGTYB+YraKlYubCkBC/KePHV0Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772038375; x=1772124775; bh=lJFM3n4F4hlg/FMl1Tm9BUAOGxUsAsDpu52
	NuZbBmE8=; b=rtibYNsaoHbXcJs9+ZccWjUGGBiItA3aHXTFt4iI7jqRIP17Vgb
	lDXHJKUTpwOsMT8cXkzsKMbXDcxezOuzT81Dl0p3/OjzWEgx1NXYAGMKz99HHtGf
	Ku5kGX7nLnohsdRDDnCiz4BKyLjeKOa/MJabmHNzg4PlLJY09+MrfYihxcF+1+Pl
	+FF1yjPmOqbAcWKQzUcEbluNmauzlydQbLTX02sdseiGgE617IdM1r7gHl2oQEq2
	1UxrAOyIseQTDAaQ4zonrT8CSIDMWTq2HpniYn5xPhqvyHB3udjV2sKoVTbLp3Fn
	/kJ+JPn4JYPRGiDm9LFgPNiTTwZAFsGR9iw==
X-ME-Sender: <xms:5yifae7yi0SBEF4uDuGWQYYTTfrcQS-J9d4a_Q_oJd4l9LgUmi3_mg>
    <xme:5yifaewpbV466bwlaQaWyvGkZ3p7puPuZSaF5IH4M9aNRHVDL3gVtKUgAB71IQo6i
    r0yM0HWIaHrxu0Ta0nw4UDBqeDVrantk90G52T8gjdFd1zSMQh4HPM>
X-ME-Received: <xmr:5yifaVx0xzi5G-Dq5hdLgOauR5XlQgVVy9GaA573HAO_ZcQ9A0JGzAPYVNcrKKlQYkNFCNchG9_RjVHmLOPa7s3bOOir6BxrdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:5yifaWxd6PHn9LPmviYw5PHdcrvLi0NZOyZ_2I6Zqw6aKh1OTgC4Sg>
    <xmx:5yifafaLhMDM8tuars-0I4wCFJsj5xp2v47ZpFrqDf5QcVIPDRJyiw>
    <xmx:5yifaXX18myNukyelLitJgPVQesCNbOhQ6cylKQ1M8DpM-JwQ9xbtg>
    <xmx:5yifadjoDsB1rm86ayfRV0tLS1K_L8dfg-rK2Cf_HKNi_xgGwH3XhA>
    <xmx:5yifafS3tfVMvgSdZEeN19yp7IS4LjBIcjJ6oDzH-0e8BhYqG-3c5KWD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 11:52:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org,
  gitgitgadget@gmail.com
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260225160842.GA2160019@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Feb 2026 11:08:42 -0500")
References: <xmqqms0xeqaq.fsf@gitster.g>
	<20260225102228.95152-1-haraldnordgren@gmail.com>
	<xmqqzf4wbzev.fsf@gitster.g>
	<20260225160842.GA2160019@coredump.intra.peff.net>
Date: Wed, 25 Feb 2026 08:52:53 -0800
Message-ID: <xmqqo6lcbw9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That was why I tried to lay something out in the last email. I _think_
> it would not be too much work to get there from the last iteration. It
> would mostly be removing code/feature that we're not ready to commit to
> yet.

Sounds fair.  Thanks.
