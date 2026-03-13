Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E423182D
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773376028; cv=none; b=eEXaSt2bQvug7QXvNK7JbFmxQyXY5MVdciIjP4+/lzQCPJVk6O91nPR5TwaUR+8WaSKS+Ose2Rst6FGh6gDfMRA4AsX2K2gKWh+pffjeRmBkZh6YZ9GWRQuh0fibm6HNEEEatl5VS2islzFOEBxYh/0LEwrSp4E1mJ+ttfT0JH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773376028; c=relaxed/simple;
	bh=ZY8vDYVljYUJkz3fcppPGJTKvNYkX/FZ+ymrGF27B2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErFkH9D0JW4iU6jzRclNm8Sn7je3BO399vW/pfxTKhr1mfxEgBgmA//0gVY6mBZYG8Zx7TiGzkMzNxzsT4QfjUl+Qryfe3YOpZp4rny8Y/Z6OYYdV9cGQnkoiMOe+RRf0cHgflVR4nZctrIAutHL+IRf81icw5U9GgbBLMZ/oLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dyb1gZiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2kzXkOo; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dyb1gZiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2kzXkOo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 924F41D000F9;
	Fri, 13 Mar 2026 00:27:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 13 Mar 2026 00:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773376026; x=1773462426; bh=e77yM1LStT
	EwZw3qAXU8b/DyrY0tyKU71r+GRRKXKgA=; b=Dyb1gZiz5+ckt8QJgPE7WW0mAy
	JIzsxjM2au7c7xnpaKMjDdF7dGJiHINsY4RXffPQaXy5o7ptXmsoEXXjx1T45ZKH
	TLy9AyNR1hbIhvwU40xT15FSSCOq+J5nDgR67RqH4DSLBEbN3Q7ZuUEl5O6qoLXH
	kQTdE7IFogcLsRvpaIMTSJiEehYqHO20894QXtnwpOlWQXjT3632zSCv31KGtlrU
	Aecej9L/HiXV9vDumAslHJet/A1zhwm6ryQCYIkPnPAhWJFN3hY8QRE3WNPW57Gv
	zBBCMzBMp7cm1tiy+ItYfRhMxoEpDDqeG4QNL9ybQ79x+SKVrk7/LpxIyANA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773376026; x=1773462426; bh=e77yM1LStTEwZw3qAXU8b/DyrY0tyKU71r+
	GRRKXKgA=; b=H2kzXkOoJ/kP/PlD5FcfohFVqO7g/xsYz+G7csG/TS5WPmlKriA
	hXyQT1KjcV6X8ZyRlNdbwWOGv0y8W+RsGL1bfeLvtUpGT2xVPQ2Ahbvs9khzfC8E
	FpxXGaCQwEVJn0j1N5TmikL9F8C8WKkwfh28dngODZGnogo0F8k2fay9DXln6bAk
	TLFTxtEcWd3TBXrrchDYFeJxQurZmfq+0D70aA66jWL5m05vCS9V1zvRYpZpDTD4
	VnZdZArWaxE4NT0SMiPbtGKWdOBG7jFkBLiQBtyY/9/KBCg0HFuThfWLH8XOR6my
	AKF18GKgTc+1tWW7YZHs7p8X8Q5xmyj0fvw==
X-ME-Sender: <xms:GpKzadmFg0vP_XZ9GEPKoMsYQ_DV6gO34lMLbwGmzr94DlFXn8vUfg>
    <xme:GpKzaf2ze0acnFk8zPczwdIJEUpqOsQmXOVS3aKyK5UF92k9SbflaptgRZA__atL8
    Nfoa5Zwrk25t2sbt1qnmJLgfn201MhGvQEHcOob3Hmn1RumH0DRcg>
X-ME-Received: <xmr:GpKzaYr-hueJ3N1vyNT30VAvPFJqjrEenSvbNdF98r2xkiCZVaI41fQ1H0v7IlfG4px0bfyBB85nOlUvKOkHPXH5L1eT7gWguw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GpKzacdqggmQuejRIbpugaKxdzB7Hv9Jb_xmrdI3bxHaiFzagC41pA>
    <xmx:GpKzaXp2K-f-aBoRLuJMVRvI9wvCeTz7CoQ5Cbwey4KaKuIpCBJ17g>
    <xmx:GpKzadFbAc0gq6jbft47poN-W0RBBx4sjooYA-SUO_ztgkX60UVmPw>
    <xmx:GpKzaXvxqOzO4DzRpb5GVlRFQ8umA185udsjjpX9z_G13W6H5Q5WsA>
    <xmx:GpKzaeonnr6TEiOkCdbkXaK5ghQqAhAZdwcHlybzHNFsDsMKP_wbtSh0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 00:27:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org
Subject: Re: [PATCH v3] apply.c: fix -p argument parsing
In-Reply-To: <20260313011259.GA3204960@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Mar 2026 21:12:59 -0400")
References: <20260310005408.2022216-1-mroik@delayed.space>
	<20260310050621.3849719-1-mroik@delayed.space>
	<20260313001629.GA3193660@coredump.intra.peff.net>
	<20260313011259.GA3204960@coredump.intra.peff.net>
Date: Thu, 12 Mar 2026 21:27:04 -0700
Message-ID: <xmqq34249wx3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Getting back to your patch: why is there a CRLF here in the first place?
> Because on Windows, we check out the whole repo with CRLF conversion,
> except for a few known file types listed in .gitattributes. And that
> includes your t/t4120/patch file.

Yuck.

> Coincidentally the style suggestion I made earlier, to just inline it in
> the t4120 script itself, makes the problem go away.

Of course.  Joy of stumbling on ^W^Wworking with Windows.  Sigh...

> So I would suggest doing that as a workaround. It might be worth
> addressing the CRLF header parsing problem above, too, but I think that
> should be a separate topic.

