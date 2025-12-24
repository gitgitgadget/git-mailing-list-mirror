Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600661F0994
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766542456; cv=none; b=blwXC6cSk3KSbipxwwXwDDed4KyrvgMg9RsK4X12+o7pIMFKNuHq7A6KYBypC/7cXaDz4fzrcC4xhGa6oXNTpFLY9Ai6qflNSt3RDLsVoSAzV4X5063wu9S98noz+pFunAdJehF6sMHa5gocdm8l2zDdz3Bl2aZNA9jbhT3IQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766542456; c=relaxed/simple;
	bh=y/lUvPn/FeDnZldhicyZg75A8hcoqsb+1aKAZ2v9C7U=;
	h=Date:Message-ID:From:To:Subject; b=TxVWJsjehO2oIIkHGnHN6VHkWlqVN0Vx4b+Mbztae+jMr4bPGpgzAoTpOH9rnceyJ09WXbF/M7bJwIukRzSG3fmZIO5+DspjPlkJlllfIFTkKv9gPIoPfkhn5wD45A6lV0RYjRPpRh62n0LtwESWL4E3s7C1xTGZxjL1G/Fzpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DmH1NmII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJdTT/ru; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DmH1NmII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJdTT/ru"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 85D9B13000CC
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 21:14:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 23 Dec 2025 21:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-type:date:date:from:from:in-reply-to:message-id
	:reply-to:subject:subject:to:to; s=fm1; t=1766542453; x=
	1766546053; bh=y/lUvPn/FeDnZldhicyZg75A8hcoqsb+1aKAZ2v9C7U=; b=D
	mH1NmIITdEhBxZb0hQVXu/dzcHq5KBNtCWDOh6Wr0uVs8fEj54+ZsyYUnX21hubt
	eEbf9kseW8NUfEpu/CSuNtR0H+XuV3nezK5+a3fy2wX/7av1xz/WgC6apF0RnTaU
	77DakY4tuWnxKsE2YsVQmcQeCAgMclCA4l0WnjtinoF1sIP5ToG6G20h3j2pWv+Z
	6lNM9LbrnvwGJKDiA/JW5ji4SlAbmjaYgorXTRYencKhkMq86HKCFFUECr61URGM
	atjiFtsF0e3/JtSrRH7l52PrFz4af2ySDnqPX88F14wZ65uTlc8/u0cn57NA91lu
	2uDUfECOygpujnwQHQSeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1766542453; x=1766546053; bh=y/lUvPn/FeDnZldhicyZg75A8hco
	qsb+1aKAZ2v9C7U=; b=XJdTT/ru48LFGl5hEpzUgzqtUjyGS7VqghOsoBz142lD
	Ygjos6upWuNptpyesHECNXyw0po0pGCJHUr9FrkuTKlaR78dxHFkfeAqGO2tAMnV
	GBP9tkA5ffi4BgB1xaQcN4EapM5H2s0OS9JDTjkl3dHfWY2Fx8nFSw33ZsfaonTt
	j9VNeFnpq+p16KRkTLEFbNB9SHgVtf2BT7c89rOOZ9nVtCJEi1XPjBYui8eOgJLv
	fPegln/Y9aQeZx4Dz9mG9lVUVAehIrsnjcfJ3b4hvzV2Sz3M8M5F0l7djipzi0VT
	SW7H0py9izhlqaYxyk+fI1csbWA+m8iQ8sB3wf6Nvw==
X-ME-Sender: <xms:dUxLadRaV6dp2FTTgB5GgrFA669QItXhniQhQDGzLZDijutXsB6Acg>
    <xme:dUxLads43PXQzz56qKY-wdKde_PxGXEshTenN1RJGizDdzkjWLFrzwvUVZ4XcpeMO
    tOZcamISqpN5liIcih_QN4b5exQ4Gxj19iXWjtZ5x4LrmO35dY3lRU>
X-ME-Received: <xmr:dUxLaYdi31km1SX1Zx1f0yg67iSQq61CN8nu6WjqnPU3onLR3skCi-6a4Php004INAL2w19dGLhN7cKWFoT2GlQwko_13RgC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjug
    hrpeffkffhvffusedttdhjtddttddtnecuhfhrohhmpeetnhgurhgvficuvehhihhtvghs
    thgvrhcuoegrnhgutghhihesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfevgefgieeuheevudevieelfffhjeevteevhefhhfeghfefiefhtdfgheffleen
    ucffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrnhgutghhihesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dUxLaaK-i0VSlhw_9fka3Jm1_9C0fXplfIdGvIfdQphN0TZ-jTCv9Q>
    <xmx:dUxLaWasQgTcGEoAslY6A6NxDxF7q2Pdqx0gm3uNiW3qIgMLuniJfw>
    <xmx:dUxLaVv4-dprewl4B36ZJK8aqNfim35QBQjUguuKqZ6UrlC8UiEchQ>
    <xmx:dUxLaTuKc765L9HZEy8V0MXZOH-1jSa1ApYER_b0glsaY5psH4iYDQ>
    <xmx:dUxLaZQTYK7FRXVWQege-ohZQdgMgHAi_V5LX8Y6R8T4I3Fr4f0M7D4N>
Feedback-ID: i4e2e486a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 23 Dec 2025 21:14:12 -0500 (EST)
Date: Tue, 23 Dec 2025 21:14:08 -0500
Message-ID: <be87d487f73e6c68ac3064adc192a747@fastmail.com>
From: Andrew Chitester <andchi@fastmail.com>
To:git@vger.kernel.org
Subject: [GSoC] Introduction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Hello Everyone,

My name is Andrew Chitester, and I'm a student at Cape Cod Community
College working towards a bachelors in Computer Science.

My interest in Git flourished after discovering Magit in Emacs. I've
kept some notes on my progress towards contributing to Git on a github
page[1] and my overall goal is to improve my ability to communicate and
contribute.

With that said, I think it is in our best interest to learn from each
other and collaborate. I am determined to learn about Git and am looking
forward to becoming part of this community.

[1]: https://thenightmail.github.io/mysite/git.html
