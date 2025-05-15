Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D331E5B68
	for <git@vger.kernel.org>; Thu, 15 May 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345253; cv=none; b=cdkFdcE4Z7YsVYKssweL2NbQ/PjqDBwZiAB8mze6OxQf5zz4XmJncAau/HxjnCwtrS0+KoFvq/Snj4HEH741HJGTjPfvOUP4rj7sydbA8Ol5Gj2Plj7nKhbFkmD6mvOGLNkaro6o265GW0l8xc/B2cwhgnXH5jqD6INcitVPsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345253; c=relaxed/simple;
	bh=tXJ4/keI6OJzASF/jH6EN0GAVvmxnrRghZDKawf5+pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hW5yy+DSAv/9DTqxxwSmXw6i3TWotQwSs/85CLDBmGkLTHKreOCIUlW4sglWkynDUG7mlCcnU+ohIqtxzg7go1EmKWncashlpvJjLeXnJWu2m75t1jHhDQoFoaalkvFvokNsyWnU3c9tSXWTroyiY4THEegQHiIXceLSuz9H9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QkJWpYAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GD5cdnx9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QkJWpYAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GD5cdnx9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFD3B114014C;
	Thu, 15 May 2025 17:40:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 May 2025 17:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747345248; x=1747431648; bh=citark67r0
	FfOMC6zP/o+Dqi33WaIdptLotzwZW4j0E=; b=QkJWpYAMapT9656BbQ9iWpZOqb
	wg0UabggkZ/n/U7NdkU9L5tzA9tz8u68vcRAkluapupJzLm1Vaa3XZMRgpojQ3BH
	Smn7seNCKUTxXzesWc2fBMC32S1vTga7T+WO9ZG4//9k34ifLSR5T7MusV0UeC4s
	q8JDjF68Dx6BayHOkhRSUleNPZNH1nSrbGQNqPhkBGTlkSyzxpdWIpUt1/7/5JiL
	TExyGWpf8WQ9PcIodfVjLiQafTIstHvXiLblQFFpTkPaiq3PYHj5lv8IqFu8kMuW
	0e7d+qZEpapuyLoP46yIfr9M+m0QRBkfPcifCkhsXI4o7oUkHrQXmDjlyzgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747345248; x=1747431648; bh=citark67r0FfOMC6zP/o+Dqi33WaIdptLot
	zwZW4j0E=; b=GD5cdnx98uGNxpynpu3+mdVRVEFf87RnTJWVd9nYhijkWQkVO9L
	n0bbtlwAyhZbx3dlN+YTmWKpNkFox8uPZSmEZub1SrMGgJxP0K8eefn2R5NcNWsQ
	IbgZlg3k+Fy31b0w6EfNmTY5eXkVxi9seKnSlHZwZS53VyBByBlAEeCi0WdMDlyQ
	zOaIRXWccNzapcea8SRVYnPiqEEOFqEhonVfKqLPRP6fAOEWWyEKMoFbXERUJeqo
	nTv3QT95PZS6yQ2Dr9pC44nicdf2Kbrf/ZcNsUoDcfEPeOwK9th/JBjPH6Z3a8HN
	9GkRX1jzOLUCe52ocBOYCmnx8tj9HRJSp7w==
X-ME-Sender: <xms:YF8maIJNRiEo3OQsGsU7anw_qzKt9D8sNbK5yVDDMXEGNjZws0Y5Kg>
    <xme:YF8maILoX8xLqvT50WrCMSX8FLo9J6dL_aJDr3kw6WWCmGPd6izzD_bUJoQ92sVJh
    _bXVou9y9LB2LI_uQ>
X-ME-Received: <xmr:YF8maIsj8zq3TkXXOs_8EBO05vjlZqCsfwcEXAXyQCT2PM5E2zMZL31lN9urDDLxgc3Cbmypsyxmyg1qSI6ybVcpL52yThzlqWY0K4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YF8maFZwfB4tD9bRpoawoShrALhUwL913hS7b4_PIkHhBolvbq6wAg>
    <xmx:YF8maPbcdCf7Y54nJAINnGXZ0lpVdk_DnDT9O3VX2Vw3d56NeeXj8Q>
    <xmx:YF8maBC19VLL5JmDvNxYeVDIa1MtVZDqVzvr5R58DtGBGX0p5pJ5Nw>
    <xmx:YF8maFYJqFAASKhpXfN59McPCm3TadZVS_51LNGW_qjen3tVjrs-Fg>
    <xmx:YF8maFMOse741JIbmW3soiFZ-9ohnBUzvnMaXXgNz4plLrU8g450eIkm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 17:40:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/11] commit-graph: avoid malloc'ing a local variable
In-Reply-To: <20250515195428.GD3320240@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 May 2025 15:54:28 -0400")
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
	<5a3a8880a68f8c69c2af39d2e32ebb56eb5fa483.1747314709.git.gitgitgadget@gmail.com>
	<20250515195428.GD3320240@coredump.intra.peff.net>
Date: Thu, 15 May 2025 14:40:46 -0700
Message-ID: <xmqqv7q1y2ld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So maybe OK, but the smaller change would be to just replace the calloc
> with a memset(), and s/->/./ on the subsequent lines.

True, and it would be a bit easier to merge with other topics in
flight.  The .oid member and parameter are both renamed IIUC.
