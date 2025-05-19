Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344421D58C
	for <git@vger.kernel.org>; Mon, 19 May 2025 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698546; cv=none; b=NNNlk22dsTUIduMpJULBrTy1g467Qi1eAe0sY8OPZP/mF5Q6RlX4xCl9Hr5EwkQFGP7/UChRwRaJi0bOek4LLyyu7Jgcx+qaonBpiSeiK5vV4ZKBb53EXNy83HNWeYWgJMuGDluz3ZUivsyEUlHePajm1Jf4Ar/di8kyAs+c+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698546; c=relaxed/simple;
	bh=6Df13D3lx3rrIADu6c2XgGkndTUvUBHiNEgnnS+pyxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bj1qaBpPO59QXon24LIsvzzVrGvJRonC9xIBwYnqCVmohfc2jCvkFpwMEPTgs65mljyulltvU+dOts/BbtZlUnyWbZfvfZiySpvegdXsfSjppieurpP0Ul1CcA9BPUY6ALxIU55hfPTlz1XQ3cyE0oF8Bgib45WvcSN+rSonqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EnZrY4EU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQ+x+B85; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EnZrY4EU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQ+x+B85"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D649011400B5;
	Mon, 19 May 2025 19:49:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 19 May 2025 19:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747698542; x=1747784942; bh=39u2SyiIQz
	JS3OuhbrayEnUZPW/771oct89DeIx7Fac=; b=EnZrY4EU1uz4VxawfYCQ7uOU7c
	AbrAKxsKPdrIhoIe1/csYF5OWzJrhUxCnnbZZXNnzx2P1jCL6Gqb6g2zpp32GGYy
	xogX/IzNVQ2w0t8ufTlsTTddH7PEQnAypUd4j0aQpW722Y8rQWFDydTgPI6CDSyE
	bhvkiq0I5SLMxbPUVBjFtOIzXhU3xTmUllsmLnZJkz/kw5mP3nYXUbYHsMw+Y4Xl
	q/u5AQt1zVvOsw1t0SXPYnXNDJoJ7xEkQomYQs0nzbyzEXbbJvCTF62EKIaI/DuV
	aFnw6TUwdgDWaXDlR/2bxaO6kn5TSDUlX4vaCN1OyHQDLSvLeIimAmkqPa2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747698542; x=1747784942; bh=39u2SyiIQzJS3OuhbrayEnUZPW/771oct89
	DeIx7Fac=; b=KQ+x+B8503tf2ErXkOk/qvxA6lGUcGuPkY6CdigSzfEC5fQGaBa
	G4AbFCgEaJw9MNHavb9KFRIAhYtnkPith2Bo8CelBbKeV4Dc3gkGAJyaFXIZ4rDE
	eNAlc4p75YC27/Q3KcftHjl3x9ZX5S0SO3CN5HFIoFjx5JivZiWbNpC3RxWAYJwF
	WgNy1JH5gzXEX3gWFCJ70CzplNAU6R0WIYCylyVOlqDmFP27IdBjk+HlnrTPqb7+
	ZhPEQhoCHzyvyB0SpMX1ti3HBvQMgUi6zybHT0CUux2hUsbtOeAW5Fvq36x9cePp
	Q/oZqSrMT3ZmF0xdBNouWgWKaiMpBhbCp0w==
X-ME-Sender: <xms:bsMraOrlzzsUVW1L-mB0x9qS0GZk1pRAGx8yN6UZxSESObZKD5yDwA>
    <xme:bsMraMo8w2cUWDMJmc6BIW3J4eUkxiV-4pVJBE_caIcb3N0n45rFdNCJ5yPbl316y
    -nrWpZJkGwAgnUHTw>
X-ME-Received: <xmr:bsMraDO2VsTodmgirw2WMqOs_-SOlbyipsjlmG7K9tohrPtocrdGv_IQ5E3U41m0EIw_1uFRUv0ucM2AUDMEHpv66fe-XZjNmtPKU9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopeiirghihhgrnhesuhhn
    rhgvrghlrghsihgrrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bsMraN7RhPZgOZrTXaRH2xzxgpNZSSRxkTKT3m_pnTQF3bx20M3JkQ>
    <xmx:bsMraN6TBoRxuZMJ3JXz-zxS8bpw1P_6xnGyHqrL3HaGnOvDr3VweA>
    <xmx:bsMraNgFNXVkACioRh1-jYoE-_Df_iczqRuhgTr1gEwjh1cElJUGig>
    <xmx:bsMraH4ekbDZ_xSS6WW06_xOPRZ-Il4f91FqXD5PiUdeNEvs_boHFQ>
    <xmx:bsMraI0cwD00joreSNhk-DyTnP0XmGuAjd8mLxEy81YkzruhYAEJx8sH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 19:49:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Muhammad Nuzaihan <zaihan@unrealasia.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Small patch to add support for MPTCP on Linux
In-Reply-To: <a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com> (Phillip Wood's
	message of "Sat, 17 May 2025 14:39:38 +0100")
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
	<aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
	<BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
	<aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
	<4YPEWS.J5JRNETKLXF1@unrealasia.net>
	<a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com>
Date: Mon, 19 May 2025 16:49:00 -0700
Message-ID: <xmqqo6vokvpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> As brian has already said I think it would be better to have a
> Makefile knob to control this which defaults to being on for
> linux. Take a look at the various USE_xxx definitions in the Makefile
> and config.mak.uname for setting default compile flags for different
> operating systems.
>
>> Also another check if a socket is supported by looking for a return
>> value of
>> "EAI_SOCKTYPE" (not EINVAL) and fallback to regular TCP if that is
>> returned.
>> EAI_SOCKTYPE should work across different UNIX systems as this is a
>> posix error code.
>
> That error is not mentioned in the documentation for MCTCP on Linux
> [1]. Please make sure your code checks for the errno values described
> in the documentation.

Also according to RFC 6897, "MPTCP is designed to be totally
backward compatible to applications".  I understand that this is
quite unlike introducing IPv6 into IPv4-only world.  You can tell
the system that supports MPTCP to use it in specific ways by
updating your application, but your system's local policy may
allow MPTCP to automatically set up multiple subflows even your
application is not quite aware of MPTCP.

So, ... I somehow would be mildly surprised if Git were a kind of
application that needs to take advantage of "several additional
degrees of freedom that applications may wish to exploit" by using
API that is "a simple extension of TCP's interface for MPTCP-aware
applications".  Requiring a simple application like ours to tweak
and rebuild in today's world does not sound like a winning strategy
to promote a technology that "is designed to be totally backward
compatible to applications", at least to me.


