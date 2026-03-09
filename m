Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73004346784
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099107; cv=none; b=V+DZidQp65g6f+iURzyBMVPDxYJyBGefannkL6+PZ6RrYeIT0WmiS4NoTKcHm6RZTnnVzkuLhMCPHUcTEL2rdH/McaMto8x4xMRBMgscO5h4Nasp8e/fwagk7SEEREGelj5XmUsdSkZvFRP2LFIUmvHkQE5qVquUmfOoiQCD5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099107; c=relaxed/simple;
	bh=GUo6NvjaY4DNpB0v/xtnt+B9Wp4MvbAeWM5KJwnVjMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eb9GCyep87gXuYEXjbMGVj2NZxrEkrrvAND1An1JpYvViCrlGUvlh53oP05FepU4wzmccxz+z4msujS6Ch2J3Nb+hOZwN+toHRZvJ2mG+F0lXPR0VZUoEMFIaYIoVxKv/c4esgKmr2fh0NA/ZZK5owObz16uZtx7PLilO9RdlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZAwkzimP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBFAPPjn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZAwkzimP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBFAPPjn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A479EEC0076;
	Mon,  9 Mar 2026 19:31:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 09 Mar 2026 19:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773099105; x=1773185505; bh=GUo6NvjaY4
	DNpB0v/xtnt+B9Wp4MvbAeWM5KJwnVjMk=; b=ZAwkzimPU9oPggdLnrOBnYrito
	l66ZPkbO+GdCleCS04NU1jsH8i+1vzMmhykhGbici8ByscNIzD35UZQV0Oq2ydCT
	AHLIoa1VIganekULJSFQkT/qV32uhO9XOpf6pGexRgK+nkzgA6NZDnK2hAZI7ULW
	amiDiNRV+7J5mCxBkAPt+llnNtkfkvCrMuD7DUMmgYVwKCFVtEjRtf2Cp3ey5zpm
	HqLHBH06cmT1up7X6fKO4leuFmGeCf6x7xi8fLu2Semn1mUzZilLvC7fQl0yLaYB
	o4ARDknIba2MvOD0g/h4dj/jZdxbk7kGSJXT+jlCqsxTcC8XPdqk3CNlmNWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773099105; x=1773185505; bh=GUo6NvjaY4DNpB0v/xtnt+B9Wp4MvbAeWM5
	KJwnVjMk=; b=tBFAPPjn9G+0ZaFx5ZNFuWw7pS/r13KOHVKSKZRI6X6zojZCsYL
	hrq+E95fSu5SmZqacKIsJOG/+5Hj2Pba0SSEOs8e44IJ3XzaBFeqLqc2DwQ0QNYy
	tYFjzfbEJMw0uy+f/jVfii+2VtK56w78lqYmt3SLgTlEp7XjEdZZUCN1weuRg8Yq
	LejNdlBR6FxRaYVC9crPq0J4wBzUZp5O7Amgoj1/NSok0GzBDTQ4FO3+daeix0CO
	/hMkcYQ1YVa2GpSqfLqJF+axdOQeQZjwbZUuRBMgpG0rVnrtVouz2s6CYuVWisUu
	5Tm+Eoc+THw5WrMiyiRC731OZKBCTPqymBg==
X-ME-Sender: <xms:YVivabYBWFW1-zHJJvRu5X5w2cUTAIIo2yHdg8iBtas52PXCLTQM0Q>
    <xme:YVivaRb_-DK0SpuMIGPcF7HPfGfIG40Y8Va_x73xi-dJc-GQsN25SSX8VQettQYHC
    GroO8NGFjnOFZ_JB4IfI1Q9_dGRAM5OBuAeB0qOIWS6GRxxILfAxg>
X-ME-Received: <xmr:YVivaS9uZBMcVW-m8D2e8kVxupclVwlz11U8sd_32iDgkWNT27gfj9iJ5uWzm71YPmyHLOIg9ZZqFJY0dHdHn5lLD6gU8Cfq9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YVivaQgyNaslcGGHxaYG6VAvsfwyP_mgb9Kp0KP9wuxrCTMAI42wtA>
    <xmx:YVivaSezOm1A7-oFKaTcNqV2aBFi80WxjC5KJVydoSMmRrIvW-YDlQ>
    <xmx:YVivaXqffYdMqq59BFMBHLHpz_ALow9DJm1G0Nqh6-Nm8-HuMdOMPA>
    <xmx:YVivaXCWJ-YRjy1VJJCBL79ImobzdRcWI-YSumXLf7fVwZgqber7lQ>
    <xmx:YVivaSeF_qRq8o_wpoyTYXbZTt8WObAWs6f_flMJuMSu6kDoLorN250S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:31:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 00/10] Xdiff cleanup part 3
In-Reply-To: <CAH=ZcbBVSqUG89n65MBpN+HMCmmjzmADGaVnuEJn_cYN0SYknw@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 9 Mar 2026 13:06:26 -0600")
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
	<xmqqy0k4wogg.fsf@gitster.g>
	<CAH=ZcbBVSqUG89n65MBpN+HMCmmjzmADGaVnuEJn_cYN0SYknw@mail.gmail.com>
Date: Mon, 09 Mar 2026 16:31:44 -0700
Message-ID: <xmqq8qc01swv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I plan on rebasing on top of master with lots of changes. v2 will be
> quite different from v1.

Thanks.
