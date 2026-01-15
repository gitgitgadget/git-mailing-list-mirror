Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170229ACC0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512996; cv=none; b=jLwYNqU1ApiTMZQ5ZO8r1PhH/rjG299CGjv5E4gEO58SZByWmfhpqPob2rblNPG1zMS8l3hoxP0+HykxLekFl597C50VUTa+KZEInEPSMoBe+0MkUnxXPL4v3jm6rUarlXFF8LZ7GO0vUoRQwTwlmLKOuQ21Y8nplUmCxpgLXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512996; c=relaxed/simple;
	bh=vuMbycuOgVrg/ga1bUhH1gIoK+hNkv/zHWdZTMRIGDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Be3tIXkJFTk92ULFWVJ8QgcEzkKHBvz6KbQIkOJScTlGPLqvkDzyLgjrenwqDRZWql8xkxFZM04GEsEPJ8A0HA4UmQetlekBNIuhJQGOdQ+mDNTjP6INkQQ2yZ0rtvjOt5YFcL81TLgjdp4bH+IzvGdpTIevINUpd+vof9dRLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NtXeld5l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u8o+gyIc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NtXeld5l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u8o+gyIc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 479847A00FF;
	Thu, 15 Jan 2026 16:36:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 16:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768512993; x=1768599393; bh=vuMbycuOgV
	rg/ga1bUhH1gIoK+hNkv/zHWdZTMRIGDk=; b=NtXeld5lv2Iyn3PlrLiaJa6Lte
	0ZhwjeCcK3vQuEt7mEsQO+r+hnNnj4Z6VY9dvdVPh0XF640kxwl46gnXeC0GtaQG
	PpcLGBKfDJ+dnLQqNLvBHRnHF5e8sX2gQum7YpbeooQa7YLzIx/CoG1VLFKGZRWQ
	CAgZAuwDBsfAntol5NMTb4vqf49hkIn/6PKWKPH+4V4Igx8a0QcPT1ai54hM0h1l
	eQ+QZpLec/z4/AbELtgEMaysIppJPTsW/Nl4jfUkWFmjIjt89Mb3V2KN/skV/R8i
	5z/D1GgSK3hvLjLvk1tQaY0lSKKEdq/L4lX6lYCLSJJcFZ7nTeHLetco7pHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768512993; x=1768599393; bh=vuMbycuOgVrg/ga1bUhH1gIoK+hNkv/zHWd
	ZTMRIGDk=; b=u8o+gyIcI798fyeNi+7xV94I/2qffKR7HVLddLdDQ7bldUiSpIk
	wLUtEbEub1iYSYKkK0cYO0ACcL9ne2e7FtvWSiK+yml9lftuybUQh+PsHCqRUZyL
	e1yHrI5YpPWaR+zpeU8uGrlVxcRJMFEvf/49KPCbTwFxP+vWJ2wjyV6F4y3pU49J
	5JkjHnGR/b5LaogEND/VoQDoFQ3pY1b9UaC1eeGZFdC3/e/gXa2UdLhIkiWRUC7F
	yk/7Vw6AzgW3AMogUKDgn2w1g5z/WTxx+EPz8X8eI7wqWCB9kMbK0kqtIaW6uRgQ
	/QquRdPCjygHj7B+ajvF6anYb4nySoPxWPA==
X-ME-Sender: <xms:4F1pab-Wg9JL-EU_zKJxmv2em5z7kOdVVhIxxkHjBfNv204xCkZsPw>
    <xme:4F1paUSwVu2NvRG1xOmXXApPzQ3t2oYOo2z9490yx6EOSvX5K95ppw7ep7bb42ifQ
    K-NlL-kbEMccFZa9aTxsBGKCWyBbgWHzoKYeRhVgKdjoKh4h80YUA>
X-ME-Received: <xmr:4F1padddnNrqNjinA8-h7uwrOsUOWE1LdprqQzo9AnUMYJXDJmybiIJ-enaOe-mDP9remM7kgK4X6lwEPk8E4elc2yEwMgBaGSYL3Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohhp
    ohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:4F1paeQfjLXVajXjiru2-sc8YKbHSAuOumxOR8XBINiXDvb6uIRLTw>
    <xmx:4F1paRJEnqtWDrLwpC_PSU_4CxHDejVO96HwdKZYPSzDNuIr2bWekQ>
    <xmx:4F1paTKfJXm8wDIGfd1dlT321lNm_r9H1xAMzNgr974LydmBvgsVkQ>
    <xmx:4F1paUgd5BMkKPMyUdqxrZEocti7hHkP8Q6_OPHoy3hW3k9fyKt4_Q>
    <xmx:4V1pafKHlT9315u2o9QAwI5CwaeXpBNwulRJrFZubfGI7iNmk8QOCfte>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 16:36:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>,
  Ondrej Pohorelsky <opohorel@redhat.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <20260115211448.GF1053259@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 Jan 2026 16:14:48 -0500")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
Date: Thu, 15 Jan 2026 13:36:30 -0800
Message-ID: <xmqqa4yeblsx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Is there any reason we cannot introduce the new functionality as a
> config option but _not_ enable it by default?
>
> That gives people the tools to protect themselves if they want to bear
> the potential cost. It just feels a shame to deny them the tool because
> we can't agree on the default.

Yeah, I like the suggestion---making it opt-in would have much less
chance of breaking set-up people are relying on all of a sudden.

Thanks.
