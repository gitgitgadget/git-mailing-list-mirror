Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A453AC3B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565302; cv=none; b=HC8y2rwx0zGPqRsvXbsW8BV+ZQ7k71WNLh+RG86LfVycbjoSuvb+aD/2tD9g3gf3XDx7GPmRnuutguICMFZUSE/Uyu3BRH9JmP1I/sRozhuuFwo+3kMAz/3m2OwHivlarIDbjnnzhgeOtajj6Knu+S8ObwAQcHNwRoAnJtMyoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565302; c=relaxed/simple;
	bh=zzW50Wzk8slFFr4y5yNdSacJwtNCA4fkOyyKSQHQq84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fI38wgAh5kfFTAcBIMHA7nCSeoLtC4JPpRtN/Zobvid46D6j43tHNMVTLnofXMbp774/NvyRNIONPsZn1O8XOMWxhEl/r0yDMNmkV8KwScNfqK8kO9riCo8vnqmicjSMJxT78pGODuTCKm5LAorDHj1g5lVtgHszFjGWyMh0gWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EmEcoMZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwFF7T9P; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EmEcoMZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwFF7T9P"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id ED3411D001A6;
	Mon, 18 Aug 2025 21:01:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 18 Aug 2025 21:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755565298; x=1755651698; bh=1n5HX7HXE1
	B2nYC4rlVKYC9tUEd2dYsAWyah4OhcnI4=; b=EmEcoMZS1G3MCIx2Qzsh1Bwlof
	RnPXGJIenE0E4flCoVpKGZ6uGeg5CUziSS6JBxVSEA+0mREDFaFn0dR8c1zDls6z
	fSEUZFrdcAN1yzLUSU7i/thhQ2V0Rqb21olISETFXcestxMdUmjhNjrSjLQNdjzl
	8cp7wUeT/rgT69NclVe3DgdGLz/gOiV+1kREO5vvJ/qh6SE5dsn0a1v0vgUBEdVP
	T4jtsgO80wRGqWHRqIqpZMRtUtnn2zYLOgBoGD8pnhBxxljFnuIOwRatp+O0zWcj
	2KiBMjbFwzXmqFDlXMgw4qY37zDrzDJG9pYjFNjjEIuAfzEIWgWcAqd6vvbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755565298; x=1755651698; bh=1n5HX7HXE1B2nYC4rlVKYC9tUEd2dYsAWya
	h4OhcnI4=; b=EwFF7T9PoqZvbu3yvk/BvmRGejv2tCcrB87pVM6zxGm6niRUnzA
	g7B5+NSOnditek9LudUHI0q3Ezmv9APinpQM0rLzliMs67TXzDGDn03fi5hlncpW
	kiEF8uhYsIGbKvQLczT88XSFJA63MeCAXc9ycp0ttj5dpFZ5KbW1rcbMvMXR7ZYu
	QZqCjw6dYWF966PnG/ZTfbf50Z0TZicRVCx9fewVUxKal9Hv8WBmsfvDwyhZ8em7
	2MsqrR60K5XdSANX6lYMEGnzcsKRSfqIOqf17ox/sEm7ORTQ6vNWFp1AqUrYIs21
	rZSEGM/Aw1KEDRECAhkHL5yRWI/KC0muJfQ==
X-ME-Sender: <xms:8syjaHGlt4mf9dlijrlbaIPhgEZ0-7i-eqelcR27X3MXqwWmqqsn0Q>
    <xme:8syjaO4E65EwV-w8ikrijUIvYHL2TOhlkAqLdn3kgo_JCKQ6ySi1A-WZ6dHbvAKS4
    CUlbVnyHUrUKlcozA>
X-ME-Received: <xmr:8syjaFv7BhBzKKbJlGaslmwKEK2i0k73ByaXd1YIoaUpxgCEaWF8Q8eaJCFNeCwAC24SRVhvJpXYrscvj0uDJEBqexoCQvbpxDa1CCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeguddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhgvshhthihosehstghivghnthhirgdrohhrgh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:8syjaH798WcC-D4t0JT9Sd-zMbrnrJcvNKyujJb_5J5XBe1ghhTgLg>
    <xmx:8syjaIVwhu4fg6Mkf9XqfBdy49Gws4gLA1P8XZAbTgB3E2xBYRkpVQ>
    <xmx:8syjaB963PBG6r4lni9Z0tasAhJJYXCMYxps_Du18LrlLo5hFKD1ew>
    <xmx:8syjaMm_WDVR1virU2XnnDFIXAMklxDXNxdW72OEp-e6y6TpPJIZrg>
    <xmx:8syjaIX4BaXp7I1i5Z4t7J0d7-zotmcn6pQwLP7VZj3b2ktgFqAJo2Dq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 21:01:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: why can't one alias `git stash`?
In-Reply-To: <d8b279098a41949eef06f26d3f09c3950486380b.camel@scientia.org>
	(Christoph Anton Mitterer's message of "Sat, 16 Aug 2025 04:11:20
	+0200")
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
	<xmqq7bz5v0mq.fsf@gitster.g>
	<16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>
	<CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
	<xmqqjz34txjg.fsf@gitster.g>
	<d8b279098a41949eef06f26d3f09c3950486380b.camel@scientia.org>
Date: Mon, 18 Aug 2025 18:01:36 -0700
Message-ID: <xmqqh5y4gm4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Anton Mitterer <calestyo@scientia.org> writes:

> As mentioned in the other thread, IMO it sounds rather brittle if
> aliases are considered at all in scripting.

As a program, how would you tell when you are run by a script?

If you are a shell, you go into "interactive" mode when you are
taking your command stream from a tty, and otherwise assume you are
not interactive.  The same trick would not work at all for programs
started by a shell, would it?

Asking script writers to pass "--no-alias" option to all of their
"git" invocation will probably not be a viable way forward, either.
