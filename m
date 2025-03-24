Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2AC25DCE7
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809439; cv=none; b=uF6UIuGgPUbOW5cIjnFMu0ipyes36YoCnL4WCYCGbEz4rsDl24lF5ralA7tx9+h53iHlbgfOCuNZSM8uBoOa0opc6wy26yQ9tYMtOzxAi9KmT/h8DtDpdklH8Nqhltze87K+tGQmQCH+X8rjvFxv+vxyQ02nYdwxtzi6WfUR57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809439; c=relaxed/simple;
	bh=IfqZzQWBB8o2KsSTy1B0R62OfyZUPa/ynn6j+4J2Yrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ad6FLgtA2c+juugf97c6HRuCPc2NhwiFntAVJWXbAuC6+XbpBmMzwjhY1+ziRRVofXFNsqt0B9jII4IqMPMY/W7eKXHh3wK8bLrKzKhTqIVm0oSTdwOW+L9JcSGrvVKjYNQZAkMHc4mUipRV1YTnKGaLKATkATJCqKQDFqTSlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AetV+Yrq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sAMaED+f; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AetV+Yrq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sAMaED+f"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73667254018D;
	Mon, 24 Mar 2025 05:43:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 05:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742809435; x=1742895835; bh=/c6/X+44KM
	p13GmIMKukvFoBKbmw+gtkPSDlPkwnbWs=; b=AetV+Yrq8wKNJeg7xOvovIO5WS
	fbDx1rscpcyb8ClVxOjxOOVUenASX4jJk/T+eN0DmttcjP0j2k1JHVANqpGUoEp6
	MjMxvP+hAr4lMYBqj9pQmIPtTZEoKCRcrvTBvQ1S3QbpJbyDxOf9qxhL/r9TZqMS
	EMqZJ+gA0RZK7d0lfaZSartWrXBrX8z+k/Ap7p2ldK/01TIUCvlJngNhjG6A/Ero
	1Helo52LkN9q3l3oPqex7QI4LJlWnDGzco+/lYfxN5I8P9Nwscqomuz8HSH9tKeg
	LGK6LtEeOn5i1TGr8lRFMFK0xmQ/7t8IBwt4GAMN7jibu+jXzUy8C9DJU/uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742809435; x=1742895835; bh=/c6/X+44KMp13GmIMKukvFoBKbmw+gtkPSD
	lPkwnbWs=; b=sAMaED+fX8YFziIfK9r2eQw49Mgp4KTMNTdiiDjwrDkdE5PZd6k
	IAbn6unCBlwXHl8dFsL3A3IofMoYTFhiey29XPlt8pv4CWc56HeipoJocTXOK7dN
	2be6/JsaS/ETEF12NTPF1UV1SIbgToEBubvWLj3CoohbgFfR4rDL1jJHFHyrf0dh
	xjXA39Cu377zukYuRe+r97eQrRRqmD/poErRfKlcF+Uhu7Ix2ZIzvpf7SkzZnJxW
	av3LuhiF4fvE7ArlNr95ZinBSBSBzS/3H0sDFCwOx5XTgbpfye6hjsMutgwaUtee
	uFztlQ9YiQ3VyO5lNdNtu4/TlXp5ubD5afw==
X-ME-Sender: <xms:WynhZ2mbVlSuEqgCSxpilQiisxkTr9WUiEsLa_Awp-TjfjxZiRFwJQ>
    <xme:WynhZ92dQlOUdX4jRUvrj5XWjtzR0O3UKr8WaDBg2SyWTfDobNy5ppO7yw9Sm1ol-
    fVGUraaIRunmgh6PQ>
X-ME-Received: <xmr:WynhZ0odTnJQ8-yLbN8baMWWq9lPSiFLnI67PGFqlwp8etT56R9GLHbGSDi-aTPdx1MfWnoa2gkbaAsr9jt7rjnapQpWZLbQCq_q64w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WynhZ6lgrkqXguYhtgjvS4gGYS3r2wbgg_0RXvGs9LaCOSyxAFW2oA>
    <xmx:WynhZ03CJl0zcPFjzi9WqI0kr2Ki1sVs413m6_hvFg8IB1c50kUJKg>
    <xmx:WynhZxuF9OHg2pdry4PEeJaEcZH2_xvY69Nqr_b3wPF3S1chG6Earg>
    <xmx:WynhZwWANHarKMMEFVy9mTvp2SFRaNtzahRwxnoLeB7lcYbqI2rR3g>
    <xmx:WynhZ49BeRCLE20JEH-PgOQm4dYXqWc8S-mfu2DhzeWgJDXf-9tCejhw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 05:43:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [GSoC PATCH v2] userdiff: add builtin driver for gitconfig syntax
In-Reply-To: <20250324021101.7483-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Sun, 23 Mar 2025 23:11:01 -0300")
References: <20250324021101.7483-1-lucasseikioshiro@gmail.com>
Date: Mon, 24 Mar 2025 02:43:52 -0700
Message-ID: <xmqqtt7iojaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This v2 removes the quoted text from the commit message, using a reference to
> the documentation file and the commit that last changed the lines where it was
> copied before.
>
> I'm also adding the missing newlines at the end of the test files.
>
>  t/t4018/gitconfig-section             | 6 ++++++
>  t/t4018/gitconfig-section-noindent    | 6 ++++++
>  t/t4018/gitconfig-subsection          | 8 ++++++++
>  t/t4018/gitconfig-subsection-noindent | 8 ++++++++
>  userdiff.c                            | 4 ++++
>  5 files changed, 32 insertions(+)
>  create mode 100644 t/t4018/gitconfig-section
>  create mode 100644 t/t4018/gitconfig-section-noindent
>  create mode 100644 t/t4018/gitconfig-subsection
>  create mode 100644 t/t4018/gitconfig-subsection-noindent

.git/rebase-apply/patch:83: indent with spaces.
         "^\\[[a-zA-Z0-9]+\\]|\\[[a-zA-Z0-9]+[ \t]+\".+\"\\]$",
.git/rebase-apply/patch:84: indent with spaces.
         /* -- */
.git/rebase-apply/patch:85: indent with spaces.
         "[^ \t]+"),
warning: 3 lines applied after fixing whitespace errors.
Applying: userdiff: add builtin driver for gitconfig syntax

