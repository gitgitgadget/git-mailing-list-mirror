Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27661FEB
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733973393; cv=none; b=CW7PpgP2orkST4TRcD5FDoE8Devovn7Gd0KXMaQNExheOdmJf0+gMHm2xmHSskQFNzkwL4Ig86ZPX5FfO4Mp41TN1YbgVoqb/dBBs6mmLWUMACu1AQeOquoEfyKb35vzdLWjLhjG6D6zHEZ+JDnmiUblfyjgQqS8ktf5I06/q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733973393; c=relaxed/simple;
	bh=5v9aU0KaoYzlQsI+KCMrvLhGQ9Xg+vngElJtyBFu5+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXgdrdJX0OeqLC00yoMuIRVfu9FbcWu4jmsItc67roabSnT4j/V7qnMzPRIgZeOomfusFhVAelZg+SrXAkIobCT0HS7mJC0jkfTnjA/dxF447C4sOgEKv7xVXxJ5MRL8zsYygNKpWpFCVtNCw7VjioxAbwio2PugP5ZdMX5FmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uUXJPNZX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQLzk5uy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uUXJPNZX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQLzk5uy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EE9F254018E;
	Wed, 11 Dec 2024 22:16:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Dec 2024 22:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733973389; x=1734059789; bh=5v9aU0KaoY
	zlQsI+KCMrvLhGQ9Xg+vngElJtyBFu5+k=; b=uUXJPNZXZR0nvAR3TFAHiNNXZ3
	QGfpCxtJdPSvOi84bIOJro5MdQwJHcEWwGClrNXvR8riZm2VkAfyRC3lHl7ftTCt
	2pSBcoI/e2d79KBo2Tf6024g3fVEf4GFyoHv212VaI4+X3gCKC2yvTS33y18GV+z
	sNUOrYC3tNqCTfK+cK9spHp16wiNQBaRq5HD9oTvNB+3PewzDOrWbdULh+rXnE50
	c60MDGLPbD3CpMP7ohxoondMkwZxt280tHrKX5fNWu5tx6CoBzYi2Q3LN/mP0lgn
	FyVZl90Hp/0uZN0RHihXbhvTP/4MFnrWgXU90G/kOoceg8kOFW0fAcDrvBLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733973389; x=1734059789; bh=5v9aU0KaoYzlQsI+KCMrvLhGQ9Xg+vngElJ
	tyBFu5+k=; b=VQLzk5uySzfFw4uWCGRc7Ikvolwjv8lurDjB/2l6mYzttrp8Sea
	aV2G/pthwCuqTIW7X8/K4HP7JVCwH8X9IBy38IpxBNqr1wgEMyLXw1lruZgoYUhU
	IL35JmcI9iH1h98q0jgsKRvPCKIlJCwLF7rSxfaR3mKNFIqCbULYH6LAmMcKh0sG
	3qpeOvMTbJGCnFjtmEK1qSUpO+vLgdkWsNM3IrLKQnQVmyglXcpbBduAW5rGdTTI
	yABE6EWutF66q8QCtJq77MvxjRzipk22i6bo9Hv8orTY+0FNL4EPNY1PTV+jdu0d
	m/ygYJvsr/zn2JomPcDT/uE+ySmHPB0REVA==
X-ME-Sender: <xms:jVVaZyTK-TZbEIrCk1Ni2QNLdXgUanNzExOOZnt4OnjZ7BGlGqAyDg>
    <xme:jVVaZ3yFHa2FU1qHubUTmTEM9zWSpmPNhpDaO6zzx2JBeMzHe7cUkxK_tsGdFv25g
    07iGl8o9rpoNS2fIw>
X-ME-Received: <xmr:jVVaZ_2VL8mzQAljlwY5tFZTy7WrlROfaDd66PA3xYXaFTDz-RK0SvKxnbwjo0Utn-S56FIsKPDEPe87GYxkpGr-WlyqLlQS60U7PrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeefucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhho
    mheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomh
    eqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffet
    iefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhitgdrrghlmhgvihgurgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jVVaZ-CWI1oEfg4WYttX17JnTlWor45odcyNlabvf4v3otuOzysuoA>
    <xmx:jVVaZ7hBeO3gUkg1mt22Jxa7XpRn5fVCd2Kg9KLFVTPbZ3fLDhHm9g>
    <xmx:jVVaZ6rnxc1ZNPBx3O2eahJZC1if28oAQ5Taj1M6XLjk72pGxXYQHA>
    <xmx:jVVaZ-jwu9q3ZU9OK4_J9k6L1RuDo6d_nNZzcThpfKgpBJQ1X1-aew>
    <xmx:jVVaZ4vYn2h7tzYtV9YAQZtthJbyX-WCBT8NDaEzpxcRMMbE1jU7edRX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 22:16:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ricardo Almeida <ric.almeida@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git pull --rebase and --reset-author-date
In-Reply-To: <CAMKQPDZWgq_qCdaL_S8cYYn=wtZSJiq6nP5aqFjvUZcFSnrTzQ@mail.gmail.com>
	(Ricardo Almeida's message of "Wed, 11 Dec 2024 20:55:38 +0000")
References: <CAMKQPDZWgq_qCdaL_S8cYYn=wtZSJiq6nP5aqFjvUZcFSnrTzQ@mail.gmail.com>
Date: Thu, 12 Dec 2024 12:16:27 +0900
Message-ID: <xmqqv7vpfv5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ricardo Almeida <ric.almeida@gmail.com> writes:

>
> error: unknown option `reset-author-date'
>
> So, I was wondering if there's a similar option that can be used with
> git pull --rebase or if I can request this feature to be added? :)

Can't you just use "git fetch && git rebase --..." instead of "pull"
short-hand?

