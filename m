Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBD2D2481
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527417; cv=none; b=SKTTwu+KE5gxj2coYWgtCALKG1+e6Rwb5k1QgIYXNhYQOOUcHT4uU3/DnsZerDyrRjbv8X31k4GlvM4GvxlUOWTv1XAHOCA/pbEwPLjtWgBk356SPPApmnNahlw4ODtN1LTo0B62xkt39MC90oDrhdOI3EgnPG/DxDEOcKQBUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527417; c=relaxed/simple;
	bh=PDO66D11GYqLT8TXZh4U9UuC3h3eX2G0CcGDxuhIreM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1fEwi+FzvUEWzAjLs018QWwSWHXpgAgXCiJg6ihcAPbaHpgk4Ns8FeOs1YponvxANSiE07iyKEfB5LG/aX0I3AtOSt5akqRubLYUoix4/ofgYVjnqbdfw+/Am8NxSbVJdPzeU2N5HUVI00IdYlzYbpIRB6LglSZuG4gQ+cmET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AfRqjQN3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ms3D3swQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AfRqjQN3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ms3D3swQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 626C9EC0553;
	Thu, 19 Feb 2026 13:56:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 19 Feb 2026 13:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771527415; x=1771613815; bh=BCOlh6lvHa
	XCGnVhHFpEVqTBp5U+KrNHrJcbaAFPmhQ=; b=AfRqjQN3annPMSMMVi+sgb1MMC
	0qL8zcI97k9JDU4prfhEF/Vv73JaOmBHYJ2w4rbfFDICEJWHpwQNYEA7IobimT/k
	NjXU6MZMHQZicRT9IhUqFw7k9on4bwoLzFdk+BRC4BaicmDTKc9OarCeIEggNLtr
	3xQLjVfem/K6wejPvTvaf0yRJ5DE0XhYiX+fF4upwllNHPmP9DCi8jS6KlFLgVyj
	LszwdXECPGyrUbp2c45VDqe2XbOxZui+gF9RSJB2PR2QLWkHll8eIIlXmbw487wW
	2PvfV5vVE2CrKk2b6sSIebxx09iSAaxeRYvELLwDaiyx2iih3JuVOHS+HWlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771527415; x=1771613815; bh=BCOlh6lvHaXCGnVhHFpEVqTBp5U+KrNHrJc
	baAFPmhQ=; b=Ms3D3swQUBlhQZcm0R4oi0+G5PkRDCL18SdE4X8lErZQFAxrnXh
	WQQAi/tb8LV+GbdGODRteLhoK68FES3RXpc58Tt1XRom2w95eCuewMKTqA0j+kmK
	KjGSB6ytiKJUcophuzyjdoioAWZr+7ODfd9BFRsc0FnvcxhL1Ng4CC65h1wOutY2
	RWJVQ5xiWnuKRoTwczqyM65HbCQr9sNKhpHlCHLJqzBulhjLiWE14haGZVZiJ3Za
	Gi0Ft+5C1z72r8OpqqH9dC4K1kwEVQnAz6WpvVpcPKV9XKrNXWECOG7Rmjw8bPRK
	WyrNQarGS7HPd0xHxPNlfXFDgyZfrOQe7lA==
X-ME-Sender: <xms:91yXadGiM07SuK-dpsfTMpCAfAXJjpRHVBqjeQaBoh_WIQe-lZLAhA>
    <xme:91yXaZP_HCIue4-vjpgtIGDnmpOkjnEevzrH8WSTdQb3z0vhne8rWTM2GlxX_NRz3
    ob1J8YwV3WFC8dmFr7jHa4bHwc8dhF9MWkvlpyW50gPcLPUw_zctA>
X-ME-Received: <xmr:91yXaXd2jUw_ydPW_cNznfxvHNExhfP3Q-um5J7D_D6cd-0nAjpWCnGekAKwcXINfn_XisVm7yWlEmowGNxp1sppU9lU7J-kMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhn
    rdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:91yXaeuE_51cAhJN30QvtJG5QnNkZcdCnwhCQRg0xkOY3Ep0OrMe4Q>
    <xmx:91yXaQl38F4h3sNMUfxlfAAh-AyNOKLY_wDTs5Mixm5ZJwb4mOewag>
    <xmx:91yXaYwenQWzSjOsqjcAuRKeHBAB-MkRkocDMbCOx9XSgJMh1u9SKw>
    <xmx:91yXaaMRoXSjnFxYQuqvvxPzqAeBxd380LsvEJX3oBGDvOKTvDjqqA>
    <xmx:91yXaVZlWJZtJdcHS9oDoDHij-LuYosMhU5qqe6cfVKySLEO9uNZKCpz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 13:56:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Collin Funk
 <collin.funk1@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] ref-filter: factor out refname component counting
In-Reply-To: <20260219112149.GA3529@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 19 Feb 2026 06:21:49 -0500")
References: <20260215085755.GA86262@coredump.intra.peff.net>
	<20260215090052.GA695631@coredump.intra.peff.net>
	<xmqqqzqjckgu.fsf@gitster.g>
	<20260219112149.GA3529@coredump.intra.peff.net>
Date: Thu, 19 Feb 2026 10:56:53 -0800
Message-ID: <xmqq8qco5zpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> And then p moves to the right until p[i] points at the end of the
>> string.  It does count the number of slashes in 'i', but there is no
>> satisfying simple answer to this question: "what does p mean while
>> this loop runs?".
>> ...
> Which made me wonder if I am missing some corner case, and it is not
> just counting slashes. But it must be, because "i" is never incremented
> except when we see a slash.
>
> +cc Karthik, the original author, for any wisdom, but the commit is now
> almost 10 years old.
>
> Is it worth rewriting to the "slashes" form above for clarity? I was
> afraid to touch it just to shut up Coverity, but now we have two
> confused people.

Yup, I think the answer to my "what does p mean?" question is "by
itself p has *no* meaning, but (p-refname) is maintained to be the
number of non-slash bytes we scanned so far, while i is the number
of slashes."

And from that point of view, your "count slashes in the most stupid
way that even 5 year old understands" certainly does make the result
far easier to read.

Thanks.
