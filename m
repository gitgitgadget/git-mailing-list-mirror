Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D71DFF0
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346124; cv=none; b=c+yYUMWhQ6mAkcc+ZdATo8kPCmfqFRFSGHQ+jbkBEoYhclLeUyPj43YP3sD99qCTNQYLr/XOJuO+H7nCTKXj2eBb5C5yeIrPEhHyM/c5p3cQ58XY1uQ8OuKLtRH9EPnJOetr0kIWyJOeH3auRqkEtOdr+aN0TEi1EAfWVf4hoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346124; c=relaxed/simple;
	bh=wAJCDbUtL6AIWXObv0LUcUCOYucdwRfhZlDumbKnYwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIAFkNL8F68iuzZkUGORLhBJWYHk1I15pwA82efqq24gZaWwbzCkHRTdEa8gmS3RcdQZGqytnZjCd3Xuj+b7KvCc+DfhBQ3BLnyz6k21oBSgrBubQMFM1Ch7cCClrX633fVGMRuEA2p6tB9PSdBoQGNx7XUc2NwOpMmfJV5iVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aEIstCUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SzMuyeRP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aEIstCUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SzMuyeRP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DEECF11400FC;
	Fri, 31 Jan 2025 12:55:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jan 2025 12:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738346120; x=1738432520; bh=wAJCDbUtL6
	AIWXObv0LUcUCOYucdwRfhZlDumbKnYwA=; b=aEIstCUfpjY2cFKzYfcrg7BZHG
	/Ck8gdYjicAjk0TXEO/ERMkgrfuJ1CgjDrUuI5EqcbiadTx2AzyxkaXgncuYIDLI
	I6PP9R3BcZ6tt8csVZ02tzLGzggzm2RRS3404DnuwbF9/eJ2eUowBK2Q/gvB8U4d
	oqutFB4Gxf/SYhjlVoQC5GPFC173EOK/FX8hgqdoAUVB0CgHPIIlvz53lKhmhJiq
	dwOydpR6rTZdypTxO2AjOlXF5uIjnMX5us9ty4AvjcufhyFglcHLB3kpzsX0xVfm
	bTGDupr6o03SgfEaxggUZ9rH7Aqdhp0AF8BcqS1QJeVAz67to0IDVw+M8aYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738346120; x=1738432520; bh=wAJCDbUtL6AIWXObv0LUcUCOYucdwRfhZlD
	umbKnYwA=; b=SzMuyeRPf0k9va2clgQC7h84UBY5s+dVmRUagu6Agxo/jBvXN3v
	KKsRtJ1DWje+PatG9LyKk3FFtK/tbFzFolSRqIu47aqUBEAJ6wqwiWbPtqamWtwd
	A6JkIeN7kIs7a5WP6KvZX1CugIzmsAveaj4zR/o8T1YsZWrhMB6evnbQlQN7OAbs
	eMnznES9VNhaAFrRrWpBXTNXbOAyIoJNESSjpHG3wnK0FI2cmZotxp5LWdEpFMFz
	RnXMZ8bLqVHqb78t3Xfethcy20iihmmgvnJnOJCeldvAi7Ktif9JC2MxOzWDo1g4
	GBlRlhbJ2cZy+1upRElCwNnYFNqtqFUUaDA==
X-ME-Sender: <xms:iA6dZ--9OMbIla5wDBXP8boZwFZUrAOeIk3JEAaNxQiRz1Mhjc33LA>
    <xme:iA6dZ-u0FwP8N58M2NBLX88xUKsdDjnyLUfaiv1BE6l5FD2sKqtbNdunj0Hp6JU9H
    rFM9nB_72EGqgkAtA>
X-ME-Received: <xmr:iA6dZ0CCpyfaeRVbVNQ7---WwemoSXvMOgQ9Ksqk1MOsssWWf5V15EHYhT9Nlar_4j0hMZ5UpXgqfL1OPD75t-LbflgeBlPXp8Zz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhpohhhohhrvghlse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iA6dZ2dhOzmJ2UmkEr144KLVFFdf-0Kn7CpxtD7IcCReswp28A-A0w>
    <xmx:iA6dZzPHAhG_tWXAORHQQFNgSSFL2FGizkyREI2Q4GwpxypZJIPOig>
    <xmx:iA6dZwk_ERskf0fgvWFBHK_LEpB59RcnqH-1Bfd6EzUmBPsCqRl9qQ>
    <xmx:iA6dZ1t-42FmnwlwCXpq0BAAcwC52i8wOOBkl3Wgt__7LNOsX3OVYg>
    <xmx:iA6dZ_B8nSEEZKFj9TehtUJg48tcB-Bb4mWK7AMH37sB9VK7BvwRh11E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 12:55:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ondrej Pohorelsky <opohorel@redhat.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
In-Reply-To: <CA+B51BHQe_X=b9ncuwhBDi873OAZst=PAULiARs0NARy58VfnA@mail.gmail.com>
	(Ondrej Pohorelsky's message of "Tue, 28 Jan 2025 17:03:03 +0100")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net>
	<xmqqwmevtfye.fsf@gitster.g>
	<CA+B51BHQe_X=b9ncuwhBDi873OAZst=PAULiARs0NARy58VfnA@mail.gmail.com>
Date: Fri, 31 Jan 2025 09:55:18 -0800
Message-ID: <xmqqlduq98c9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ondrej Pohorelsky <opohorel@redhat.com> writes:

> From
> the discussion, it seems the fix may not be shipped in the near
> future, if at all.

A patchset was sent, one person assessed that it is not solving the
right problem and introduces regressions, another person agreed.

It is not quite a discussion (yet) and I think there could be more
convincing argument for accepting regressions made, so I personally
feel that it is too early to call it settled yet, but without seeing
any further counter-arguments, I agree with you that things seem
that way.

Thanks.
