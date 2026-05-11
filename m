Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030326ADC
	for <git@vger.kernel.org>; Mon, 11 May 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778478369; cv=none; b=eHXJd5HgqzAkz2l01C3KoX8be/yxq00oyvEVL4AVVNjO+fJVgbvP7jn88CpAqZYRtDLd1esNpZ94HU73U8JbZZr4Rh/gXWe5uxWW61vex22yiHJlHPTfw1g+gYIgNJZ4gFYV2LatJfL3MCXT2TfKfn8N5G/SdrwxBSlKCYPj3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778478369; c=relaxed/simple;
	bh=bJbVDMmbBZGJoBQjzZOncPsSdkFMmD1F7IsCJOAyG6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1An2TLy4whpfpcqjCmrPhKEkYt1jt2XTWe0tTkWoKMFG1rfN6/tpsIh03QDJVxySk4ndy362z7MBNpuxpIfeGgNPNfgFSjsv6cNKyh8MZumJCJ2YhEhWyJnwO/HHwpPZ5tbScNNpfjSY35/Mvjf3/6w2aDEYD5GdPLqRy12m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jxt9piT5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b8lu8L/e; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jxt9piT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b8lu8L/e"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22F3A7A0095;
	Mon, 11 May 2026 01:46:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 11 May 2026 01:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778478366; x=1778564766; bh=15bUAi49vD
	6jmxT/xfDJL8ix0/bnK2aAeGBTjBmwQdI=; b=jxt9piT5cXwAqpRb5gVNyhq/eM
	fkfLyNblDDAC8F7vIhTuv+G+GYd5g3V8h17WtIALMtb64rjD9SEyvbEqvcTBzgWW
	0PpHajQhECo1XN4BUeAZ3IgHMxs/bD3LVK1t9bs5D/RL9bOBhZ6ScrLiR7dgMioX
	fJFI2zeGSSy0iFp0tI8EYguuF1eqO4/4iTsQVDeRN4zBrwCO9OG3uOVheGCtdQsn
	lRX0rSI4R9b9u6lx2Lx70Hy6bEcd/YqsgcuTuAEZ6xZH6cl/NgpBl8jq5+XzYwXj
	YXQiKaCh4b6gEb56Ho+UUDAgeku6D8xbLw9gJTiS2li9ZmjYDiP76e91R0KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778478366; x=1778564766; bh=15bUAi49vD6jmxT/xfDJL8ix0/bnK2aAeGB
	TjBmwQdI=; b=b8lu8L/em4pzMfEm4DmIOoTDmbDQBFy2KiJEZ+VMjvO4k0bZejn
	9SVhUo//Z6gS3nJW9uDEln86RYuox9JjlskWUddlWq7XrwJKJh3cCq9m9zf60FKo
	/g0zFVKMfXjcyOOkaibZlp4GnIBHtqpHeYc1VGzyr0Uu8hhDWGhxUUA+s8vJVpjh
	A1rMCgONIz5vtpYTPz8nx4Q+NADvxUk5TCkWK1ALzpy42nqfoae82gG5tMqOU9D8
	kw0QeNZFdEIadRvX9u+W9nP0IlCJFngmOaUGAsHeiJUt09BpDKQDsAz9m/+u4wkF
	nBmRg3tazTlpCEEDsqeGv432H48s8azEYZA==
X-ME-Sender: <xms:Hm0BavToDz8AZWtV_6Rz6J-67Rj08iJg16u-kCRNv8WSS9PyeyTl7Q>
    <xme:Hm0BaoNf0y-ggQpKiO8Fa0vh61evZFbjs95OtDLX76ESre-YvVm-Z5fYg0zoq3zEL
    tqQHWNb0m00DP_F2sol4tj21R-NsoVXpbOjThaDga2xDmnjrqP2Dg>
X-ME-Received: <xmr:Hm0BaiNlESBwE4jTY69VZARQxupC2u2IC2nvNWYmYko4m-1g7Jth8gQibJgTHfFX8fZzahbXvGs0oVv2aBH55NoAZXkiQQHs4bMdvKhWfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhnrghtuhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Hm0BaosFVMeB6B6kKHlQG2tP7zv3OygT01rMXJ4qFf-0Owq3f_LPtg>
    <xmx:Hm0BasW5Rmw5EDrkRVYQFbK3JtItbte_hb8XfoBEx3o4oCw80hz8hA>
    <xmx:Hm0BaguYMceZpkCBgdpUUCh-h6U0AlTxQl2hfnNDLl4u2Rq4okAP2Q>
    <xmx:Hm0BaoWoroD9oyE3URgUbrmXEa4BnKGpKOZ_gOcToTm6JKyqsJJqOg>
    <xmx:Hm0Baqa81hSY-xHd3aQ0Zj_hwrmdcAftqfLalSITJfD-13st1mPM1aPU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 01:46:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f30dd69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 05:46:03 +0000 (UTC)
Date: Mon, 11 May 2026 07:46:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Shardul Natu <snatu@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] build: tolerate use of _Generic from glibc 2.43 with
 Clang
Message-ID: <agFtGM0H4S87ZxwR@pks.im>
References: <20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im>
 <xmqqzf26sk80.fsf@gitster.g>
 <xmqqqzniset2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzniset2.fsf@gitster.g>

On Mon, May 11, 2026 at 02:20:09PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Wouldn't the approach you took on the meson side to pass
> > "-Wno-c11-extensions" be yet another alternative?
> 
> In other words, I would imagine something like this patch that uses
> the same strategy on both sides may be easier to reason about.

I was going back and forth on this myself. I simply wasn't sure whether
it even buys us anything anymore if we have both "-std=gnu99" _and_
"-Wno-c11-extensions". But maybe this combination at least also detects
the use of newer (C23) extensions?

In any case, I'm also happy with the patch you posted. Thanks!

Patrick
