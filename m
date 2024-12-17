Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889D18B46E
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418811; cv=none; b=L3MIrRNlbjFZbpOsazeGACFnjrszlReFw3+PuA7ydpfHN9YhcLLDWcG+ZnbayJVO71BXdrMfxV0f3Y7E3hOSPmsagb47hLL3jby9a4e4lCo8xlZO0Ub07JPIbmFTljDNwXtAxxUoJ2OzdI7pNQnP0miwgaQb3TcGjONvbYEhoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418811; c=relaxed/simple;
	bh=BRYIEgHjSjtr6lkCordsuPLJm7g529P1Ja2QBgeRrVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr+282zaHRaSbGGLR06fkEBUmR9Vd6jIlPIxzxcpQyWPRQ9neq/vr+2jzF0mfv2j+zCFsBNbW8jNeo74IJJlm5L/DTliMxMmxVFCmNL5B7LjbgI95kkowIuigK0dy/5da3yDBrgQZYp+6ox8b4SnEvon6gvqIbsBLxWAqNqzqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aPB4X7lt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbR5Vq2q; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aPB4X7lt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbR5Vq2q"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9070F1140269;
	Tue, 17 Dec 2024 02:00:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 17 Dec 2024 02:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734418808; x=1734505208; bh=AMV3/AtiDn
	M9pu39QjhjRCsu+on4rGjAN7hwuXDB8Zc=; b=aPB4X7ltlfR6vNyBFArXzjWQVK
	jOcILPiUAxp2i4OrfUzpL969Xrl2knXLLrCjhuDpe6cOFc29y3but6lJ0+mqg8ia
	R4UYqdbkFwgdqir8DV3NjAIY2hS5oLOpf4ynKylGftMWUdKJ6tgVHDAa0glkTY7Y
	aYRXSdUzisZtKWH6KHairTs4pXRIGnIBaZub/EpViVU+vSM+p+30pwK8zuX3g/wo
	V7FnonllFhv3pj8Tdte5WVUE2pfelwx449w4tz5fyuilWrjPhTbeVqTxMPq1DZZI
	CFQ72r8FTTYCWK2iiz/ujh/zXDaK/+OtGOiFM4JDYhSgxZhiqi5F2Tvza+iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734418808; x=1734505208; bh=AMV3/AtiDnM9pu39QjhjRCsu+on4rGjAN7h
	wuXDB8Zc=; b=nbR5Vq2qqeeUwdtH4eY83DlZ+wh5KZMR/B5+wOb8nzs5pQxPhJB
	ZXG+oOqc9W62H1QoHZ1J6f/GtDFyyKvYlEquuCqzwF7L7jTfAOr+Tzana56AVPDD
	imNhzKWP6mf7mB3UU8K9pTLfZ/Ly1toTOq7Z374xJZVrewZPUhA1mnu5DPZ/+b5r
	4+ns6OM39SWD7do23DJUnqLWfNN2RLXSvD8mMTHcj495h+uzUUgoZfSDgUpHHjuv
	p5DKfHg3n+zOQrUkOOYoBkrKmHJJYXtgfNpaC9XZ2B4XTsbGfLaI3RfH2SlqmD01
	zGPUw4zxa041xpvoEkLBK/yF0GAbBS5GpVA==
X-ME-Sender: <xms:dyFhZxXU4SSRnK3hdb0Nyo3ICKgj4GTl2HaACeHkSGHXg_uCR-VXrg>
    <xme:dyFhZxlHBJqdWdpeX664SgK8c76aFgpDwR0mOXD76d1OxP6NfLkPorHx5oiFveoAQ
    ZruTKKKwNPGlBJ5Mw>
X-ME-Received: <xmr:dyFhZ9YTH5xwjTfIQ1GYQCPC2KWA2fovzI_HefJBwC4_10bCaAsYPQYlR0McMoem5hRzZMA5nlgiFbrh3B0wG9bC8nwZyclHzdkEjtZbGwDrjDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhes
    thhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:eCFhZ0UiOYfalYKRvb691ArR5sNX9QupEqtIf-X1zMG_-WMmfHU6xA>
    <xmx:eCFhZ7lZ_ZFUvRsGaZzacFflQ1nWWMLwBfCUlZ2mMsK_LPdpauuy1A>
    <xmx:eCFhZxcG7mzuvVGePbFd1TFNWWQED4I5vLxINOGuT4csRMMGd_Hwnw>
    <xmx:eCFhZ1HTojzTuX_ZA0VjpyjrPIvKXtAuIvPH2xprTO7oOzJt8xaaSg>
    <xmx:eCFhZ5h3cvDBSQfusGwIAKJZqz06R_E0GDyqX874N3qo9fQExh6AZ3uy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 02:00:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17bc566e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Dec 2024 06:58:21 +0000 (UTC)
Date: Tue, 17 Dec 2024 07:59:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/8] refs: add reflog support to `git refs migrate`
Message-ID: <Z2EhZpL5V0LlhEvj@pks.im>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>

On Mon, Dec 16, 2024 at 05:44:25PM +0100, Karthik Nayak wrote:
> Changes in v4:
> - Fix broken tests, due to two reasons in patch 8/8:
>   - The `index` field in `reflog_migration_data` wasn't initialized to
>     0. This specifically doesn't break the test, but causes undefined
>     behavior. Fix this by using designated initializers.
>   - The strbuf within `migration_data` wasn't initialized when the flow
>     exited early, causing memory leaks. Fix this too by using designated
>     initializers.
> - Thanks to Junio for reporting and Patrick for helping shed some light
>   on these broken tests.
> - Link to v3: https://lore.kernel.org/r/20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com

The range-diff looks as expected, so this version of the series looks
good to me. Thanks!

Patrick
