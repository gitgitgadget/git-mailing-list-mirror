Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647A20A5FC
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549467; cv=none; b=gc/OzMPmusNrIEndTERjhlncEGvlPS80W4gNrgCgWy81ml847q4AQQWtUkngHwt0XmWjCoe5xmLtx7942GzrH2WHbtMc7omfdqVh5PiXeE4Lx3e2+h/60JtK+w4l1zV6SFMay9SjPtiOug/+lygIierQ1GokxowYjMl6MiMg/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549467; c=relaxed/simple;
	bh=QEFUPvvcQkApmVumXjMKzjg/cneOfMAtUpHez/0dWtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KtIvH/wUstuZ9a2fFCRCOJSd7GgAXULhtAcaZmXrAzZ0yePCRx3eoifxbSwEXEIxaYOiYrLXM/ubcaG7cqu5dGCilTtPJiezCWLW4QTPyhVMQVxjawaCwNKZCt+4r27NscMoeRNhkEgwpThxq3oXci1FfFFwyCi0IRKRr+HKUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=umEHvCkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sGBbfZe7; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="umEHvCkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGBbfZe7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4601825401C4;
	Fri, 10 Jan 2025 17:51:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jan 2025 17:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736549463; x=1736635863; bh=SVQgeHmJyq
	VC7Xd9YUIN7Xc7+kc0ER3fO7pMFcBQElY=; b=umEHvCkl+ko9N/4lwMzf4r8wXU
	Y0wd8S8SlxFLgPhVg3YmexPQ2Odqp8hYi82hc7jQG0nSHJv19nyk/dPlXXPMviNm
	ykQl0nzys4XWXMJ/d9lUtQNeriQM4p4L6d9F9i5EEoO8tDfbSSaiQ2ou7gYijBFX
	K53IgU/hD/rPRX0TJJ0JK6q4/Ns03w0CtZYWRlEfUuhfhSA51S0iVuExncMyX/vD
	FeEYZRX5PYICI4ce4UWRiWkp1gyaohf5QJYoQalSt9F1sUdTNC5UaXwaIOUj2SSb
	v7O3jLGFAEpx0eloI62icD3Ug6Ek5piZfNbB60yxUrc4p7kuEFz9sfnZrudg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736549463; x=1736635863; bh=SVQgeHmJyqVC7Xd9YUIN7Xc7+kc0ER3fO7p
	MFcBQElY=; b=sGBbfZe7ydIO13hkC21cvzPS/8P6FaAiH+eo1C0KTsN8qLj3GiQ
	4H5BmpnuA4D7/KAgqUp+DTZ4H43S39RHEzQbj0vnRnkWMNtWiWokxokZ8NonP/Py
	FEpS7duBwoHe6gU7IHGGKMVXc6QTc4DJPYH2HCz3AEWNTIdABCoencBIPR6/hPdY
	nPRYziCUBFnEJg58UfF4PzNyHg+Lj7gLY7Afsw0PcGkP0ObtBJms6XNE/DTQwffJ
	NIsnTc3VayyN4AUGFJDtHBu0TCD5+MsmXblax4RDb3YK6Yvh2EJ+85/Ix57PfB+y
	UXjedDgP6hA0RXt4/ysLUWWVJWi8rojRgnA==
X-ME-Sender: <xms:VqSBZ-R5u-BX6XpuW-_YUS6qZ-4rDCf9TWXhMRRgSsrIOeSZkAGKxA>
    <xme:VqSBZzzae33uzwehcYDjhuS3FDirfLzS0cT6U4OtFVUO0C2vkQ4ABD12TtI4EPj1T
    KAhDo6W1L5GhSA1DQ>
X-ME-Received: <xmr:VqSBZ70rfuJ7lPEBFExekpbsaoAPW_i93azau4BFbO9jGbNTymGAq3Uqo-c9IKzSpOZsTndcBdVoIKgYzrjaJkFTQ4mhsy3QSS7R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhirhhthhdrhhhi
    tghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehgihhthhhu
    sgdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VqSBZ6DZI0jN8UWa4UYCAprQu_h1I-AHkamBX_KpXFu9b_QqG2nvLg>
    <xmx:VqSBZ3gtjYjjuX7U7_rdMzBXPlsP7zY_nMMN4FSM_Kg46WPIPB7OlQ>
    <xmx:VqSBZ2rIfHa9-Panqp9oP1vRKW33X_PXuddgL1GoVroApy-KnaLrBw>
    <xmx:VqSBZ6gihq97pg0lEV8wcDbtOZLjmxBxIYDvxJ8dd9IVpYez7tQPSw>
    <xmx:V6SBZyUgS-3fa4YySVo6RSEtKPdaNqIez4UCAyKCxqLNheI9MO9UOxGR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 17:51:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: M Hickford <mirth.hickford@gmail.com>,  git@vger.kernel.org,
  derrickstolee@github.com,  stolee@gmail.com
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
In-Reply-To: <Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 10 Jan 2025 22:06:10 +0000")
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
	<xmqqh6665p8j.fsf@gitster.g>
	<Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>
Date: Fri, 10 Jan 2025 14:51:01 -0800
Message-ID: <xmqqa5by5lm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't think in general we can know whether a credential is just a
> plain username or a token without trying to guess based on the content.
> For instance, before `http.emptyAuth`, it was common if one was using
> Kerberos to put one's username in the URL because that triggered libcurl
> to do authentication, whereas it would not if no credentials were
> specified.  I still have that configured, and I bet a lot of others do
> as well.
>
> It's also common for people with both work and personal accounts on a
> site to put the username in the URL so that the correct credentials are
> looked up in the credential helper.  And all of that is fine and secure
> since there are no actual secrets in the username in those cases.
>
> So there are lots of legitimate reasons to place only a username there,
> and we'd only be able to know if it's actually a token by hard-coding
> patterns.  I would recommend that we not do that, since I can't
> guarantee that the list of patterns won't expand in the future (it
> already has before), and there are still some older hex-only patterns
> which may be in use and which are much less obvious.

Yes, I do strongly object us to keep a hardcoded list that can go
stale (or be stale from the beginning).

What I was wondering is that because we are in control of the Git
end of the credential subsystem (even if the user may be using a
third-party credential helper), we

 - can notice that the URL has embedded single thing (which could be
   username, but which could be a token);

 - can also notice that we asked the credential-helper, or
   keyboard-interactive, and obtained a password (or not).

When the former is true and the latter is false, it is an indication
that for that site with the username-or-token, there wasn't anything
necessary to authenticate and the access was authorized.  Which is
what the original poster wants us to warn against.

And if we can do so, we do not need any list of patterns, right?
