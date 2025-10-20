Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625919049B
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983584; cv=none; b=B6YDmBoZaF1YxSQ0uBEIJAUbDN/BYcWKnfnZFUIRW8MuUuQcsvy3e412EiTSQaVEXlcyoCff0Q2NsScjE3aMp+DQcI2YmwxjvNaGFguGDJPboJ7N1ADSu2OXnZC/yjyQmbCG3P6KHFPCm4uwvNVLR5SqCiXgU3lmFIRhyfl+Huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983584; c=relaxed/simple;
	bh=ZsYVK0U/dN3Gf6yYx2Oh1bBpt8lk0L1WP1t1anmKghs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iXEZ2NensmwWVzvDTpionIQz/hAOIvsjlm9vRtkfATmNQDxU3Bs5jPjhwGz9cJ3YowvTM6UKuMTt1JNgS59O3X/K09gfX/18jV4sDNdKMIZMvAuG0yQsDDmQyLG4Ear6mtiG415DClTgZUaa+KT7hELahUD57BT0ENVVkndm3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WNVohojz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xw/EJ8z8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNVohojz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xw/EJ8z8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A7C87A00E2;
	Mon, 20 Oct 2025 14:06:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 20 Oct 2025 14:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760983581; x=1761069981; bh=xADtcx6PMp
	b4zg9pBP1StA48CFAvBsB3tPDrYqEO9zk=; b=WNVohojz5eHPzZLSsyGnZ89yp9
	aWaZr4TxIeAj3COPAtJh8+xFuk8K6KsFrd1cJJ/ruqSmcoUJOE1y9+c/yNxikqpN
	RTZXG3K+Q9gzolhRKBpQ6k3t12bvXTt5riTdkJynTVDO4UP+6JHouCsj4RHFRQzB
	jTBFCWN9iuDE2yuzdKQhWTeYCtVtL5YMzRooBPheLyPa2kiRitrpcmLlNMTC4Fu1
	ZzfszGsgVOls6S7tJck5K162GDX+h03rMBEN5Fo0NXtntgwGG3nbP3ZeCRPP5SM7
	Djka23u14rpGtLXqUQi1Kw1fX+jZJO8qN9EF+UDjYetV0j9LtcKuM5kHVvjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760983581; x=1761069981; bh=xADtcx6PMpb4zg9pBP1StA48CFAvBsB3tPD
	rYqEO9zk=; b=Xw/EJ8z8Z+HAFUGZ2h1x+fFqm7G3jZh8F0v4xps+CRKQUHAxprC
	/GWxvaT8D1aScE//fv95z3Gsm5fZsxUtf4H7Kp2aiWbhg6IMbRvahVN8g4on/zgl
	2j+dOf18eVkKbBsOHLa7zsglXlUIpKBCH42gJDe7K76U8jxUuRT7ijBJ9Piw6CTg
	GICJaMF6UTGY7aKLKy5u65iJed4f/JWI2N3p2hWGrP5eZ/lqhOvu6jDM5aBWpEHD
	vNc8CPXnDIT6fRJ9oHONlEZNAYm3AZd7gJ7mcfibZNH1koo81FoQpAeNEUBYFG0d
	pNrURvQof0xUh1rbuariKQkITpG1lJDpWHA==
X-ME-Sender: <xms:HHr2aF3ll4dTDu1O-mb1tJ3Syva5hAhCy6szPb4uUmkQRt9erltQvA>
    <xme:HHr2aERH7A24t5CwAqClMKGe_6jlRBVq7bzinr1QFAkTWabUVbhRDkNo62Wxg0YDX
    w83eaHA-WCEUU2D_qB-KNOHZn1pAN4TdSDi6-noMjlNAkLNyfJt>
X-ME-Received: <xmr:HHr2aBcyzGnQWxttnbgcKXpNUpSaJoxySW8c-H_qKFW0M61UJMqg5spNjefJUekhX2gFI1TOw0Q3vklPp1LoVvd_5t5wx9uPz8pR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhorghhrdhpvg
    hnughlvghtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomhdprhgtphhtthhopehgrhhoshhs
    vghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:HHr2aNeDngKDlJ3JYPl_i7eGkAw77jzUsmrnkwGv6uDNcMpjXia5XA>
    <xmx:HHr2aD2Qc3uzgTH8--JthgHmIAwCDnbqUKUIT-JehY7djxzrRV5gYA>
    <xmx:HHr2aN8K7DiuRKBBwRv9d7ZVHmHxIF9T9plv1LvnIBeaj2If1NqdBA>
    <xmx:HHr2aA4WpIVV9CHZ0wLYvsMKtIIk_ZDSrtSA3vlL4r3yBB59-H7i9Q>
    <xmx:HXr2aDt_3NWGzpq4mwjh3JThfwQFGLWogOU0cyOmNTHOPbsIcxR7WiJm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 14:06:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Ben Knoble <ben.knoble@gmail.com>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  Noah Pendleton <noah.pendleton@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Thranur Andul <thranur@gmail.com>,  Michael
 Grosser <grosser.michael@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
In-Reply-To: <5d780103-285b-4e6c-9b26-2a87609837cf@kdbg.org> (Johannes Sixt's
	message of "Mon, 20 Oct 2025 19:32:29 +0200")
References: <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org>
	<A563E028-19E7-48A0-B538-82ACE821DB67@gmail.com>
	<5d780103-285b-4e6c-9b26-2a87609837cf@kdbg.org>
Date: Mon, 20 Oct 2025 11:06:19 -0700
Message-ID: <xmqqtsztzbvo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 20.10.25 um 15:43 schrieb Ben Knoble:
>> Going forward I will probably stick with using pwd, given the
>> difference in platform behavior.
> $(pwd) is usually safe, but not always. If we have to look at every
> instance anyway, we can use $PWD for efficiency if it does not matter,
> and $(pwd) only when it is necessary.
>
>> Is there a doc or test lint for that? If not, might be useful.
>
> If this were documented somewhere, would you have found it and obeyed
> the recommendations?

I myself forget about it every time, even after getting bitten at
least 3 times in the past, maybe more.

t/README has this.

 - When a test checks for an absolute path that a git command generated,
   construct the expected value using $(pwd) rather than $PWD,
   $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
   Windows, where the shell (MSYS bash) mangles absolute path names.
   For details, see the commit message of 4114156ae9.

It is mentioned in t/README, I know it is mentioned in t/README, and
I did re-read the part of t/README, every time I needed to decide
between $PWD and $(pwd), but I still got it wrong 50% of the time
X-<.
