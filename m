Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4E27466C
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099956; cv=none; b=jSaMFaXC/jBaD3/JPu68+v8ob20h4nY78rGNTieT0xjzJVpZWCEIL3JBON1wpUWZL+6FgembZt0yEEb7xJq3hq0+fBUp3+AZOYYeuzrl5H6d8U04rmjIEc429wT5eIM+Bm++1HChJz6NEuD0eeEzRg9F3Yy+uDPyEQhrF+isiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099956; c=relaxed/simple;
	bh=UOIl+TWSsnVKE/kELykK9xedNWSi1PemBtX6BUJu974=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KMxD5WvQTO8SFcE0ZBaskVO/DuEcfNtDnuGf6c4ty08EdPCVR9HW7pnKjlNzPZZZm2QOj30/i8NeSroNtD5TgEOZ+hXG9403kINld14NrDBPk6fgyDgHYNhb32bM0P5BDz5UcEEYO+qOcB5GibxpEWVLIals7AxZwAAovbmpNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CDvcZ4s2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6aT8neL; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDvcZ4s2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6aT8neL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 61D411D000DE;
	Wed, 13 Aug 2025 11:41:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 13 Aug 2025 11:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755099696; x=1755186096; bh=cR5SUikRSI
	A42GlOJnK4k15y5CAL3khUgQ8FITQUST0=; b=CDvcZ4s2t6fw/xUIMcEia6SQkF
	1eveKgyQVVbwOClWgZ6enAv0UDCVUNoQvm/5ZTBdnKv1TLWS1L5W5e6oL5gO24YE
	8xHxvVO26HNWEhmWVwsQO2M3M1aVZmgiGtqz7r/UI0gTecThg9giLwmqJ76OdhzR
	RcFYBMIZ5lzZjYOoSfrY5Or/5gNOPNYw4bhn7ueAEXpK/l7ytmeoQEC+S5vBa8wG
	kHdTidnsJ8fdR1kN367ZUA7oUr635ZSNMGgwHVjDRvk9t02uKAsQzHwgiR+dIV29
	RMVkbDFkIhH2gvxuSuwhppD7Vihhn8chF9j5X5oyF9HhbayuTKVx0fRgbH/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755099696; x=1755186096; bh=cR5SUikRSIA42GlOJnK4k15y5CAL3khUgQ8
	FITQUST0=; b=R6aT8neLSrK+BoeH/ahg3covKZawMXmMBXJaq8RZveta/cxzFhl
	H8/vJ0frOKEdDMMlWpZOFWQ1axFHHZyLVlvUBAq/e6ZAkwSJ+h9Z8fyHtncg0Q2w
	2HCbErZcpnX9QsTcmqe9KeCsInVrpyi/1og7Ypii3Kq3CWm6tMavq0TqoaC7Vm32
	sqBwKhxNJptqGgsrQdkPXTEyRdljRDLTQB1GOtYpteNMQElviiO+tWuRy3Gn7q7a
	EGKA2pj+NoOXGj+cBigKBQK9FkYI6uaevyV6k6bhJCyYnpXoZGk/guoPYkqtS4MD
	Hu2u9SH3hvFRPKVZTaPUwOXEhf8oIqJDogQ==
X-ME-Sender: <xms:L7KcaJp0w4a1JQx9UHbu7JBDjJ5TJ3IHk6-Z_N4XB1KtVvVnbK_SOA>
    <xme:L7KcaEFctk7l8pFuvCyUb3XXjBHpd3LJU2lfvbiOH9C_9t8RTrXMovD8SWniMF6Ls
    ZkyvYCzYLlU-Iv7Ig>
X-ME-Received: <xmr:L7KcaGodYaiZC-gPBVT9lv8Bab6oqvhCbU3nYU43zNKlkU_N89ARoBGsjMurW-oyHbNQF-UNOIRcUzUNuhku0aPtwM-wbe4pHv0cYXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L7KcaFaR9GF6UCHy5JyNRF-QsC089dP9pchX9bOr8dD9_8g9pETimg>
    <xmx:MLKcaHVELY6A2cc8nwwR8mxiCd9eWunoIsstgtQbCm-CyHTBZs4lqQ>
    <xmx:MLKcaG-6q9QKn6rmkmsBgJJs9OofYCf3dig76fIXTCOen4gsgZVT_A>
    <xmx:MLKcaI8fwPWJWBX8RXsRgVhE4FEDqz_qTJOY59LysnoNHNxgA6gUog>
    <xmx:MLKcaKJ4llTzFmd6c6kWNOy2bRVMoQ3LogsQXBM2TM1WVYYYhPcZNr5v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 11:41:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] clean up some code around editors
In-Reply-To: <2250a8fd-62b8-4218-9858-23032d9c807d@gmail.com> (Phillip Wood's
	message of "Wed, 13 Aug 2025 11:14:40 +0100")
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
	<20250812170256.71751-1-ben.knoble+github@gmail.com>
	<2250a8fd-62b8-4218-9858-23032d9c807d@gmail.com>
Date: Wed, 13 Aug 2025 08:41:34 -0700
Message-ID: <xmqqfrdvns9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Ben
>
> On 12/08/2025 18:02, D. Ben Knoble wrote:
>> Changes from v3:
>> - drop 4/4
>> - use test_env (including a case our lint does not catch when the value
>>    has spaces)
>
> It's not worth a re-roll but for future reference
>
> 	test_env FOO=bar git commit --amend
>
> uses an extra process compared to
>
> 	FOO=bar git commit --amend
>
> which slows the test suite down for no real gain. We should only need
> to use test_env to set environment variables when calling a shell
> function. In the special case of test_must_fail it supports
>
> 	test_must_fail env FOO=bar git commit --amend
>
> which is widely used in our test suite

If this were some feature series, the story may be different, but
since the theme of the topic is "clean up", the above clean-up is
something that ought to be part of an update.  A clean-up topic
should not be adding things that need to be further cleaned up ;-)

Thank you, both of you, for writing and reviewing the series.


