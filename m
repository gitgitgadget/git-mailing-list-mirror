Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2F76026
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766196868; cv=none; b=RUjPQGyvL1eBWoKq4Ir/nxGy3ex5w2KI7up30R6jq43hA0vyJ21RUwhu6cRueVBx1NLFUlYjhAUcOTCbTqgq/01GT6Cu0GNPuygIcJC4ADDQiqdq8OL2yIVjm1W0HXA1IR2pr/eeOJFWHqxWUF4WotpQ50CzbdjUDlFgEUkXEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766196868; c=relaxed/simple;
	bh=vw2qMMG3GgHcPzjdNP2UIBNTR6GcnjMEt07+U7KN9Z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMEP1iS/z+/y3nG3mTnvU9rNhjX1EWgP902B4P1emfdSVCIh6IlPGo1H8UwXwaruoCrTzljTKpuQXm7TD1W/e7cnakHJTy65Iri5B6xyWrhECJhySrsJ+5GirJ5Hfgjs+gXpoFTELscR/KITAoe3NDhuSTt6SUGUxS4fWVKWoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HBWxYqPT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r+yobDj5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBWxYqPT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r+yobDj5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A4BBEC00B3;
	Fri, 19 Dec 2025 21:14:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 19 Dec 2025 21:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766196865; x=1766283265; bh=8ie9cd++YM
	xUfVNJGl39/wWdFpq6y4yXk+vpTBcIRso=; b=HBWxYqPTGovC9NIx6xT287aosw
	NLxpZAtQlJffHZ8iBnMNNHtRrIHDbm0rP73WEdtlqDAu5IRwnrEAa6OyAAh4aGN4
	3ia6BpnZX1jzd6ZLUdBVG9L3GXz4ab3fyLuiKSh04QqygpMTFnpt9G18jGPeBgoO
	i5KaDo2dx22rify7L9VMYfAZfgy7KIVchA4smlh2m9EXCGMLdqEuwWKCf0OLNR+j
	a6N31tvsSv+EWN/4MhQKA35zuMr+zkhGm8pOdh+kSIKKnBKKOFT8d/pEG33OhM3y
	Oe+7YHdPc7a4DcvysR23P1Kff2dmHiUZQYVOWL+Qi1vNvfZmc8Mhxl1L1uGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766196865; x=1766283265; bh=8ie9cd++YMxUfVNJGl39/wWdFpq6y4yXk+v
	pTBcIRso=; b=r+yobDj5pegPGfJ9nnIROiDelgG9fg15zxL8pg+v07SfMFOh/9g
	6EMnqq2R1wA47zgjr9pHFIkvubS1CATF+ntRMGsX56w0lIgMiq6WYVvqoeCWcXHJ
	Nc22MvB+gjjoEz0ilgWE5Gu14rImVeVdQJ3KTCcFYI5IexI6vSqNv3o7zVIk6FdM
	F5dsZi518GpJztgtBd4G950fLEhs2fMkLSFcgcS4BKDCi9VTdqzDgNwMs98PV49i
	Vz59gpCx5nqKIAHFOuOOaGHg8fcOFdijmK5owV9wj9/fql8psZHKzy5Z9EOxzse1
	xGni3SC4yi7sKJIqQqZgaM0i1zn72Pu9aIw==
X-ME-Sender: <xms:gAZGadwCuNLIF3C5j3mqYOevYDVGu3Y16vU901pjftAak2SeDX6oZw>
    <xme:gAZGaULG55Dssfk0K9LQwOQp-uW2LHQwwEx4UqE195sAOOWrZCMNnoDh4oNC6I7tv
    Rsh55l1z-POeZfBpdshpfzbpSR0hBU2lhDKRcSjOFdo4wSidZWq8g>
X-ME-Received: <xmr:gAZGafpIuZKpt_OUc13FD6fnLM3z7I89b782LR2kIrmnMe__IIIBbe5ITkGx16JUPB9PdHQyKkJ7ZR29U-NT09uJl61akNuvTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepug
    grnhhivghlsehhrgiggidrshgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmjhgthhgvvghthhgrmhesohhuthhlohhokhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gAZGabLYjYh0kAwX-EixGSX96b8Q-UFdKr0zl6_idyICHRqYyAVbhw>
    <xmx:gAZGacTsQupjnyYmHxj_Z-6CuBXeVbwwRbEWw0ZGYNEZeA5sy0lrgA>
    <xmx:gAZGaStB4x-6vbEd3-jp6_LTMf5hk_1m8PZy0qID-jLL2RJuY8Ug0w>
    <xmx:gAZGaVapLHRf_VFepCTu32Ua_waqIineugJm5LIH5ZoW8PlnBZKAkw>
    <xmx:gQZGaTTBN_wp6JjE0zHSRwEq6I7dZ7e4EnaSeJ9BCcVr3b3U6SjdURv3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 21:14:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Daniel Stenberg <daniel@haxx.se>,  git@vger.kernel.org,  Matthew John
 Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
In-Reply-To: <20251219232357.GA3960837@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 19 Dec 2025 18:23:57 -0500")
References: <20251218121120.GA3252258@coredump.intra.peff.net>
	<613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
	<sn7p46s1-4o20-q05n-173r-s6716s8145q6@unkk.fr>
	<20251219080409.GC3784564@coredump.intra.peff.net>
	<0s72r344-865q-2n3q-o9q9-p701087s0n04@unkk.fr>
	<20251219232357.GA3960837@coredump.intra.peff.net>
Date: Sat, 20 Dec 2025 11:14:22 +0900
Message-ID: <xmqqbjjtvr0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Thanks! I ran Git's test suite against a build using your 6c7bc9871f
> (http: fix for unfolding line starting with TAB, 2025-12-19) and it
> works without the whitespace-relaxing in my third patch.
>
> I also double-checked against the current tip of curl's master, which
> includes 3388afd2b6 (http: more unfold fixing, 2025-12-19), and
> everything remains fine. Thanks for a prompt fix.
>
>
> Junio: I think we could just drop the third patch here, if we don't mind
> test failures against an unreleased version of curl. It's in debian
> unstable now, but presumably they'll move to the released 8.18.0 once
> it's out.

I was wondering about the same thing after Daniel started working on
the fix upstream for #3; you caught the behaviour change before it
made to their officially released version, so we do not have to have
a workaround on our end.

Will drop the third patch.  Thanks.
