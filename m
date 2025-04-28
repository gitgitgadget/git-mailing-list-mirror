Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC5294A1A
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865853; cv=none; b=jih1IrbBjsHQDXB8UCgDhprgusCxyhxy+kNXk4vzLfHBYilbDLIAzh256rotS4aow7P3+JVL13dwQpWCDyAWpODEgS6pCx+D9jgamhKDUcjv8pl7U3MgBojb2ynsZc3tqXxXFfPyCJ+QY2gbjIIVIyo2T4V9v3VJtHr708kFyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865853; c=relaxed/simple;
	bh=eQVljCx4b+Uvr5VB6imjYUVMbUV4k3NOgMDttukuklA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pe0O7aJrIO96qzPHc1NA2nLM5XQURJpU97n0xVo0kA2SQN2KssdEy+kMJNL15izOtECoJecn1ENVr8CRv4WW06sdMaXX5+tky9i87Wh0P8teuUTLQ7a8+eBeIkE24mGAI0F2HPRf7BkJh60zWqVh2EXY8DRiHhQaKZLK4abE5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b50VDA9+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Paxa8v7K; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b50VDA9+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Paxa8v7K"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C5463138096F;
	Mon, 28 Apr 2025 14:44:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 28 Apr 2025 14:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745865850; x=1745952250; bh=/ebzLoE59x
	usbv7xfvkLrIGUgg2+a8o2QuF/J0eue1Q=; b=b50VDA9+DcfJ7Df9MqANV5Z/Zh
	crUgUFLTuSE8a0FgMgWPahBgrPeBJ6VD8ku5hKkgxM8fjlwI1WTSndgUF6gXxxfq
	hKxivYVlvvVQTepq2tA2RwkFhCvFWUREbXb+1FAqbXeBkBjzWiES+hwVfhwtPbSb
	bs9tYu76Y7+QXL2Aw87gX5GFzJuEuX2D7O/B0R4PnHPsF/GcWAWGcNeylGSvTws4
	VedTopXWlwcDNYjXrbFzzbepZg57YGF9xymABfBUxLtAtzrBlPczoPv47LAjgYlf
	giq3BKKWndRJ5pF7cS9YdfZnI6G17ybVBYcP0RGrEN1tlh0fbSdDrA69CjlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745865850; x=1745952250; bh=/ebzLoE59xusbv7xfvkLrIGUgg2+a8o2QuF
	/J0eue1Q=; b=Paxa8v7KIEeAvjvODSnSuh9NEd0HZsENf1GhyREc5IT6cQsWTLK
	LzrOm5h3E2CJ1Bak5Ky3nb5+nOddhctEGPLfLA1Y9Gw8qQQd23wBYZg+4nQaEsXT
	xEuOUqULCeMUvU3F5BKj+Du5LLcjco4SwHej4yW5GuTWDa7ngqMLDEpEoaz5LHZd
	ol4cSJUiR4Yey8pWmQseUMMMgF75X5IZ3Tn6yemAydUv5NaBDN2eXEvfhuLrYiYR
	2NhGRpQ52LTK6HCyK5U8gOMz9RXot7c3wEtDL8eZ0mCvrA0tyCpAdgNiFbTHmnDV
	yim3wEHqOAn9eJU2Oyd556NXtpXX2OhjpvA==
X-ME-Sender: <xms:eswPaMGeCnyIFdb9Fxwi5q1ZtzILHm238wVtoeU4oGUBb6KCKCwezQ>
    <xme:eswPaFUaCVuWpc0j9T3qAnaReL7QkwFLeBxaWtxcprCakgZXWFYdhn0ZkffoJi4wD
    HrJvRCVFk956kf20Q>
X-ME-Received: <xmr:eswPaGLsROTnhpPfueK3UiqR8exaMtH-i-NCr3catD8_B-w6LxG1zdXEG860YzizXy3ZxYUfxEt6JY_quLMMfcqu-izX8Sp4I5sr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eswPaOEd9Ei9GUu-Qje9tC60mHYjijGUeBSHH4DopCF60z9wZ5OYKQ>
    <xmx:eswPaCWjeEhbWIrsJcS_9VBdRfXDH1ZR4OEj6AUyWIeHKH_g2pWLNA>
    <xmx:eswPaBNR8zqG_o5KLYjGJqzFoF0yeProSigxFLSEUepnViNlb7DQfA>
    <xmx:eswPaJ0okl5PG2YHEBo3RO35d83v0aKMvakYq9FwSJSLKCgNuGj_pQ>
    <xmx:eswPaPKTVeLh7wDaTZBOc0E-0ww5nnudO1m40lra4v-qinkJP-8lD-Px>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 14:44:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
In-Reply-To: <56a0f8fd-7568-b579-1ff3-e0b088b53345@gmx.de> (Johannes
	Schindelin's message of "Mon, 28 Apr 2025 12:59:17 +0200 (CEST)")
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
	<56a0f8fd-7568-b579-1ff3-e0b088b53345@gmx.de>
Date: Mon, 28 Apr 2025 11:44:08 -0700
Message-ID: <xmqqv7qoceiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> .... From my
> point of view, Git is spending way more compute than is warranted. The way
> Git's CI builds are set up, in many cases a single regression will cause
> many tests/jobs to fail, and that indicates to me that Git's CI definition
> (and even Git's test suite) contains too many redundant parts.

While I also feel frustrated by watching paint dry after pushing
day's integration results out, and often seeing that multiple CI
jobs fail due to the same breakage in 'seen' I do feel if there are
ways to avoid such waste, I do not think of a good way to do so [*].
Are there some concrete proposals?

Thanks.

[Footnote]

 * For example, if gitlab-ci and github-ci run the same CI jobs on
   the same exact revision of Git using the same exact docker image,
   if there is no reason to expect one to succeed and one to fail,
   perhaps we can drop one and keep the other?  Or perhaps we pick a
   single representative job and only after it passes start other
   jobs?  None of the tweaks along these lines I can think of feel
   satisfying to me.


