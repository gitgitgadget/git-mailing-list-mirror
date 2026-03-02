Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE63112AD
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477873; cv=none; b=EjqS2ssv8qvuR39ub5e7DmLfgJXAn/MPOzFB7y5EWRcI6IGe4wP9h/KT3TvpEW1PV7iEVB8xoQQMJP+irSyskPIdtzbB1QBxIQ78JDJEOErQeTPBwVRxw4yf4khlsPbgOwbcA6GN9woQuNxzjI8GYQJLgVxVuHWS6WTYIdCCLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477873; c=relaxed/simple;
	bh=aTIJA+FM8N2rmP6z4XIi212OoaI88kydP1onSI1kRtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLd+1GTeYc9toDQERLYVU2mByOUVb6wizulzRDBD2/LHZffSeRwAdHqfOu2RIca9NP+6/czTDmruqNVilFbjyDT6zkcOC4B2N7uUxV9+R4tCDt6jlUGqbHFIs17CW0oF1E089ZILXTy7OJ5Xjsx9OO5fbbubUG5PMceIv8H3nQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JVxL+BWf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPXWej3/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JVxL+BWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPXWej3/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A1FDEEC0636;
	Mon,  2 Mar 2026 13:57:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Mar 2026 13:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772477871; x=1772564271; bh=aTIJA+FM8N
	2rmP6z4XIi212OoaI88kydP1onSI1kRtQ=; b=JVxL+BWf958CDWqYU97MqcKjcm
	qlpVB5uvkGEPTvJrh92o5qPOpNWCG/RORK7AoO/0L+Hu0k4b5euzDZeA9E44eDoK
	5dHxfCfEYFur6pD1lNjTXJvummRQv6KqNhXWrQKFofK1HWwTNKmmBvkPJz58tTPS
	kRF4s1cc2aj/2cnKnvPaQlXphMhuePBTJX1s7YhawdhhY2/NJ7p34qhs9Q0ee8hv
	fI/cfoRBsoLquN8lqggOVm5oo5v+cgiHj7L6vAJGoxFoa9yAKyyzErx7wGQ3sv6M
	Sn80RgKhmCX8BZZdxukxc0J816gKINxHVEnNw2uD2RhuNy9XlEBYloCk1LYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772477871; x=1772564271; bh=aTIJA+FM8N2rmP6z4XIi212OoaI88kydP1o
	nSI1kRtQ=; b=JPXWej3/5auEyOrc1FvKnT1ZJYaP7HQ7QYFutE/4cn8P3BDNjaY
	MjfAPDaIvh/owlfFibL++GgqZZvS0o3C9s4aI7JJbF4OEs3zJYAqv1TThlRfx7Gj
	M42YOM4FZmHw7reTCyu3SlJ216+xWk6PBjkiAQyw1YQEEq1xwac5AZyTpBql7FIW
	sO6w/nZ6Dm8ObiVU5qqHEy67iVimYHOOxOhZGOoS95Eng0Y/jbh4QmK68Vo6gMNR
	OIxYC1x85JRkOqLQO7eddV8op2kvG3LF8jpSXd1HpEvjRSuB5n77l56UTxcxgNOR
	kzeQOFTzjFcVClG1NBj7KRFuv/xaz3sx9gw==
X-ME-Sender: <xms:r92laRXSWteWTgHv50YMCUBVgj-v4n3NyPLTM3NduWISb-a_Y_d2Bg>
    <xme:r92laQpML7qS2MjVcGJa7QRliqK1bqWyAO_cHQrGyKsmV51NHj38BUDehs54sQ-0o
    7ym6onXmH1jHAWNeKNZSN5jUMhV2Cj3Be41M-FtUa-WxpY0COi8>
X-ME-Received: <xmr:r92laTkaOR2PW7CZTLOhRa1Qp0_6oevVxULHcRJvgIxrXOz-5Tp7Y6cxiV7g0qYU0uv9P_muW5i7JPO7M5hs8fuWwWNoivwo-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegrlhgrnhessghrrghithhhfigrihhtvgdruggvvhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r92laQ1-VM68cZB4NB5DcDUO2p0UZkHoEe6UgzvfYrZrFByXwAkYlg>
    <xmx:r92laQToc2XYOasM2zikPUfpi39RVapRUrCas4upjI6nkEVwJVeVlA>
    <xmx:r92laZxfNZHZ88GKHakcA2gUiPKo0u9WKSiqlnFW_emV_VbfyXO3BA>
    <xmx:r92laQAuM7b9JfdV0uI2jZUU6zk7iIagDKfAnnbHWS6EidJYtucLBg>
    <xmx:r92laZ50-u-CTN2XpDa1ZZsDUKN4fYMTg_h_2ADs0gf8JVcvX2U8gIJq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:57:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  christian.couder@gmail.com,
  jonathantanmy@google.com,  me@ttaylorr.com,  Alan Braithwaite
 <alan@braithwaite.dev>
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
In-Reply-To: <aaV6PLJCrpb2mQnq@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Mar 2026 12:53:32 +0100")
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
	<aaV6PLJCrpb2mQnq@pks.im>
Date: Mon, 02 Mar 2026 10:57:49 -0800
Message-ID: <xmqq342i12ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'm not sure that we should make blob size limiting the default. The
> problem with specifying a limit is that this is comparatively expensive
> to compute on the server side: we have to look up each blob so that we
> can determine its size. Unfortunately, such requests cannot (currently)
> be optimized via for example bitmaps, or any other cache that we have.
> ...
> Another question to consider: is it really sensible to set this setting
> globally? It is very much dependent on the forge that you're connecting
> to, as forges may not even allow object filters at all, or only a subset
> of them.

Both are good questions, but to affect "clone" you'd need either
"git -c that.variable=setting clone" or have it in ~/.gitconfig no?

As to this extra variable, it can already be done with existing
remote.*.partialCloneFilter, it seems, so I do not know why we want
to add it.


