Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBF205ACE
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366586; cv=none; b=gSH9Ss2F7ENdCBZO5cseHfiNUJr5g3Dr5gCgqhgHYf8ONtjg5fW0guFI04KDNU1lrb7r7zsVVSjjuWtgm2ffUo7OsTLtwSf9ialwGdyHePyJqUHG5jRdrTqeiIQrh3utgoByH7DwdE8lbUSrfzhQvp7aiAYmE5nQij2GgYYqGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366586; c=relaxed/simple;
	bh=s8acbLTp6xYItak1kiQY0Y7XUtTF1F9ngbpBtEnrNZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tySRDqP0Wm5M1991yqilcq/nPvcvv6XXT6QzdUsnXKqRXHOuf8g6q+FYMjWrH14iax5lVY9WeNI5beTvP8FHLeWgYi9/BD5fE6v+ijxRhMtrC4uWsAKlt4xW3urjjDykKdxw6cMfUyBd3VHWPaymCTmWf5EkcnuUOZYNA9bNZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cMD3rhz5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDB545Wo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cMD3rhz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDB545Wo"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 85E03138406D;
	Mon, 16 Dec 2024 11:29:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 16 Dec 2024 11:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734366583; x=1734452983; bh=s8acbLTp6x
	YItak1kiQY0Y7XUtTF1F9ngbpBtEnrNZQ=; b=cMD3rhz5zHm81+C22sSBm8TuvJ
	FiJhqdW4tSfuOJKcQDo/970UY1G8Bk/fnwNj123KJUI3IhxyCjQzX+4cD0uartHH
	68nJcowcP6h+IQoALj3KrEFpB9wb7iKANgQ4z1VmuV/q/v8kwHTY4UkhJS+jC2Ut
	QVDJw4bmJGMBzYCK3na2F8SWFN44PIUinva+zB8PZ3E7u3XHpbI196gZ85u9JzCj
	AkuDct2KcBFH9mVS732oGXUiZjAxYtgw5M2MHPqLyi9eVQeCBhEA3jW2NLiZLeCw
	KvNDkSRRQMMZuGbpSmrosCcHx/Lg8KYxWB5Nht6w+X6k8tAwMC8I5wC68uzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734366583; x=1734452983; bh=s8acbLTp6xYItak1kiQY0Y7XUtTF1F9ngbp
	BtEnrNZQ=; b=eDB545Wo86C/ncLxqw/+kIgpehLh8QesjKv6qsSVSaZUCDJAqdn
	pdJwZxBU2IE/HStk8MhU8jOZdw/9KXk51igcj3N95/1jTl4AeENQ8wnP5FkPn/kD
	A8jmUKaDrW82S8IKVnocsnHZHqMW99SEezhMIHyDvrskPXsDsxnGgGdMbbEO4SRM
	YOrYKyW2lwIMzqKrdgRDQpJ8PtyQIo+apiVMy7yr3c9i9OvvITaps6opCGZFzZ0M
	H1HMaYaj6HnnfbuUjpmhWwEHegnmfTrfuSdVtxl/yuixU8YutDjm+QznW9pPF8sT
	Bre4fXb6Zzt3f69Ck8YnpUyQXR/ZOoOhikQ==
X-ME-Sender: <xms:d1VgZ1VfrMX8NwDUjEHLxVdecN73LCjCinR3-HeqdSOu_3lZ8QzAaQ>
    <xme:d1VgZ1kRXegC8FaxZC2wBBN4O__oyQmCOkDmVB2dxygf8zXol_sf_GCTHtO0cLOE8
    -OrM_h5oSPF2M2aMw>
X-ME-Received: <xmr:d1VgZxaxorCYqcBktrmrYkec8Y5Djwy6gNHcD90yrT5BVozDl9bIzuHCkATvLj_mrnLlkBHCbuOJAaB8y2thAXpwQWR0-bSPN_7YFYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d1VgZ4WWivmCp9qWBo3vKyl9gVrW2RKUweHaAkEb10bzosdDvpZ7lA>
    <xmx:d1VgZ_lYHRi5VLvSzSSE-akB4SyfUCGHEgZ9RHbRet9XD39vCopjfw>
    <xmx:d1VgZ1c04RbUiTdyUXPgmcXChUmMGXTNlIXJC2fl_tLuYi1hoWgbpw>
    <xmx:d1VgZ5EEuzd2vjASuXloC7nsaD0vjfUTYpwtckOlSdDN6LmzFHcBnw>
    <xmx:d1VgZ6tQglyA7ydliiJ9q9cS9IcAXNJCqYrtCBtKTdTm0OMz-9PRZVi1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 11:29:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <20241216111112.GA2201417@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 16 Dec 2024 06:11:12 -0500")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
	<xmqqv7vnevjc.fsf@gitster.g>
	<20241213103850.GA1456983@coredump.intra.peff.net>
	<xmqqcyhtaecy.fsf@gitster.g> <xmqq5xnladwi.fsf@gitster.g>
	<20241216111112.GA2201417@coredump.intra.peff.net>
Date: Mon, 16 Dec 2024 08:29:41 -0800
Message-ID: <xmqq5xnj7fre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I recall that the performance of attr.tree is not great for _some_
> commands (like pack-objects). So it's perhaps reasonable to use for
> single commands like "git diff" but not to set in your on-disk config.
> It's possible we'd want to warn people about that before advertising it
> more widely? I dunno.

Or we disable the unusably-inefficient feature before doing so.
Would attr.tree be much less efficient than GIT_ATTR_SOURCE?

