Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91D2C11F5
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008088; cv=none; b=qpt34Bv6XO3RE5Dda/KYopK41JzZJzU8UcZTzA6b9uR4slWUmCzocqoRp524jZmCczBZo5yoy+EVOzGnrV/wkf4oJzAVeskjTZ1zQMr31sLwyNH4rVbvMFI0VOnUlk4SqKKa31zMPYVhAzI1xnWxY3qpcLQzaO23P9XUKBc6iJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008088; c=relaxed/simple;
	bh=xhpS2vwi5ScPYCQa8MCvKszSHcrYuRGit6ZsmXGC8Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6JGKeVr4pfpjALQJB8Mmc2ba93oqqXxJvLi/MCe1WG0m/0IpYQiZlod4tUoMsq4uTwmJQaSrBO79RgZymCTADBSzajLwVNqfTyCXuBVqNsUOEYY2cdcO/Y8ZnEeNO28UaBPfWV7n+J/9PrDiNvblvG8LAIZwtde8tmHi9T/dXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DTNJ70Aj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paZ3ksJ5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DTNJ70Aj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paZ3ksJ5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D4301400239;
	Mon, 24 Nov 2025 13:14:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 13:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764008085;
	 x=1764094485; bh=Ib3wtuRO/QbJNM97f4M6dHBBcSaZsk1dwbynMl0rbwE=; b=
	DTNJ70Aj0ZJaYG0UU70d+vobjdo7RZbWMbvxwAR2mjWH1N+3QTNsSo53BQSHWWj2
	CWUn1AjMIkOqg7/DIi0/KgZpt8WlDaWrKq0f4lta6h0dDl1hyStNk0wY9pAJqAoI
	NWM7MCxT96GVCzFhEJaEXbyU23f1dRynSHbGzq0q4yvIKtnFZEXzz+5BrapQkdk3
	AiYzb+Lk0oiLO4AYj97ip+54sj2hNeDWKOG+070bV352nPn+enO/+l5vD8V/4V8I
	5ZX84+lu/YfqHJBcxtmded9SySSQiKjWH6sFYQhAprbjF6FLosZ8vpIHAcTi3kgA
	2Yj6PW3NDe/vVWG5JnCbvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764008085; x=
	1764094485; bh=Ib3wtuRO/QbJNM97f4M6dHBBcSaZsk1dwbynMl0rbwE=; b=p
	aZ3ksJ5+Gv4url97MT34mWyGXdYJSxowiRshz5fn3OIsvNdJLlzRZIoDf/2zbdug
	WkjTkUS2QrGAVNIwLaW10jvrkefAgBcCTl58Bn5bMueHbYsPn4uTCf/jV3Obvpai
	hzahue23IhMfcVxJIM3Dh6qRUGjsfMT4fPkJ09XXvXrZQ/KZHlhBKjXAVXis0Vcy
	91+quyrY1LsD9sydrswlNhxRHx4GMrEs1CAeGamIjdhHhnz5hCNzLWml/oBsYz8S
	Z6uD4KjbAyN7m2zyJqWrPAXBIAA2fdUpNmAUslwXMZnmt4DsFGCrBoZfnqgaWfWh
	3+PT7FEfwRPtg3o6e+T5A==
X-ME-Sender: <xms:lKAkaea2ZSSps0POW6CGjVFwGrygJsbx6KQAZDOXqsLEwbudBkGJFA>
    <xme:lKAkaYZE2FSQOMlqwM8npJme7ioqXzredbzYjYrX6pra5Vh6yLh3mNSq2hRwwWS-5
    3SxkWJCfvNd4b5v9N5pqRQBKoiaW9fG7iBzUkdh7wrDWECy6ZUhJNQ>
X-ME-Received: <xmr:lKAkad-eFzv70ulQS3AzPUyVwC2nkk5lONmePu-vIuyzIxqdt41pStWfLJiBAg9GcUTTCmdWd2LVXFNVUOVsqseyxYhHsoKKKZ0K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:lKAkafgMfxLQGCRXPoL8kVY7qSyMU6p2pRuNoB_qCbX1nu-EjnCAMw>
    <xmx:lKAkaVeLoLfXHa6NteHb7Y0Qj3GXFMw75UQ0MLvvztxm63KiOWk3Cw>
    <xmx:lKAkaerLVaGJvxHNljl7OtbNN3OZxBB_cr7I2mBooTrmqmPyUnqUww>
    <xmx:lKAkaSAiXzZ-uaOEB47Ni3IS0tknzlxIND3D5nEr_-4cbv_TMsX4zw>
    <xmx:laAkaS9QH24Y_WDVUSjIjivDn240TB0ckuQolBZXCXRwVY-mf2Bbe2gc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 13:14:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 0/3] doc: convert fetch pull push to synopsis style
In-Reply-To: <pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Mon, 24 Nov 2025 12:48:49
	+0000")
References: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
	<pull.2002.v2.git.1763988532.gitgitgadget@gmail.com>
Date: Mon, 24 Nov 2025 10:14:43 -0800
Message-ID: <xmqqy0nvxppo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Range-diff vs v1:
>
>  1:  397f56d874 ! 1:  994f6ee414 doc: convert git fetch to synopsis style
>      @@ Documentation/pull-fetch-param.adoc: namespace it's being fetched to, the type o
>        +
>        Until Git version 2.20, and unlike when pushing with
>        linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
>      -@@ Documentation/pull-fetch-param.adoc: object.
>      - When the remote branch you want to fetch is known to
>      - be rewound and rebased regularly, it is expected that
>      - its new tip will not be a descendant of its previous tip
>      --(as stored in your remote-tracking branch the last time
>      -+(as stored in your remote-tracking branch the last time_
>      - you fetched).  You would want
>      - to use the `+` sign to indicate non-fast-forward updates
>      - will be needed for such branches.  There is no way to
>       @@ Documentation/pull-fetch-param.adoc: must know this is the expected usage pattern for a branch.
>        ifdef::git-pull[]

Ah, this was a spurious change that did not need to exist there, and
this round removes the whole thing.  Looks good.

>  2:  5b1e64bdf8 = 2:  6e9ea10311 doc: convert git pull to synopsis style
>  3:  e5526eaf58 = 3:  9c70b341bb doc: convert git push to synopsis style
