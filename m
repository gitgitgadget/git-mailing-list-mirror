Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BD2C21CC
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947554; cv=none; b=DSFF1Rs76PBgYOqHjwn20BaB1uAgyrrUsYo2LDtcebft6aDXJBf/Z+3LlsDGL04gN6Kp3Y4XEvO7Jto/I1z00IjnGh7lFe7t1pFlIwV7WbA1Go1L/Tqi7NRpDtEcb+wxo9x/iOWS1oE59q/QBn3kmVmCpVmEyAMZY2jYxnKXYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947554; c=relaxed/simple;
	bh=4x7r87upIDCxAEQiNX12rV0d/oyY6Q/OuQNAMS1iQ/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F6kVXiN1GqvqHUDkTJ/+RcqAUCtfO8ee2DkeCjfBhXXidpB+u9c7eKjuX9AlGPzjG9gW8xk4ptZNzRsCpwJKBkZm2QS2tywCTHoYa/l3NYoZFd1HhHLrIL9zGu/0xXMrBmtLpRw7jPN9Qqc5IN/AvQn9MEJAkWR1pB1+TRh4D04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z3w4JR0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWmK7N9X; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z3w4JR0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWmK7N9X"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F176EC0191;
	Mon, 11 Aug 2025 17:25:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 11 Aug 2025 17:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754947551; x=1755033951; bh=q6KE2I9qLI
	kHt5NvYnLzourvKxar6NuVpcYQAm+Pi6M=; b=Z3w4JR0F8a8LUnenjXZgitCUkE
	e3x7ZOszcpnOLMqy4dDD8RigaOLjK/AO+nk59pbJr99qqhsow9hQeb5eBxst56El
	XdC6ezmufSIPsgELmMpLALliL894dT8/YNLteBnFIepxnc9JvqL8iDupnWf9h7n8
	9imkQSB7SJUswRHSCjvl2I2b48jVT/xJpUXz1pVUit4nMU0jXenXRzhj0PUBHPMP
	j/GsiY4nQg/qcUcqyYnajyYh9g8dvpAsi5hquwcH4v1XVog3UF4h9XAq4CtNJLBM
	Fm466u/6W84GjioRJKvg0GhKwq1fZZ4AiX6FZkvqqKULIO2D/ILyG54UGecQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754947551; x=1755033951; bh=q6KE2I9qLIkHt5NvYnLzourvKxar6NuVpcY
	QAm+Pi6M=; b=KWmK7N9XoAsgLsjl7KhjKAB9XRFskL+OCK5SaDvYW3a8cYt44h6
	DkI+uq/HM8YX4OCoTcENexIcgoiRrGFZIr8YOUd0UdZvZBDjrphHILH4V4EJAHAf
	1j2b7S6zqSlFBgjCC8iKk3kOkdCkwxDu4bY1z4yQDg14YvKR+S+BpfQySbvpQWpZ
	YZbWlDsPqCRQkRyaj6rsyTRKDV3KVovz34JGYk+5Uuy9SVbaWf29KZ69b+VcKKX4
	6kN17GxblB2wxxg9J/HMnTywhuuAi0w4A4OvGEZgoaVGXSpvtWv9KPmYOsssmaon
	EiIqyvEEfF7xqKwA5FefmRto5yj0gDsgftA==
X-ME-Sender: <xms:31-aaD3bLyZPiC5kv9bIOz6V7a7kTiv9V0kLkTQ89FV3xMkC2ktL7A>
    <xme:31-aaNm5p-a_oOxvmRyVBlalUuFkblX26Sw2w8GVfzgByjPbCd70s3z1e_Q2UvdL4
    HzcMYJT2nJkzyHnpw>
X-ME-Received: <xmr:31-aaKVBEO4iQg3R43oVAn5l1Dwu8rZvUQTrQzBB5mhzH-aLt_eE1KWX4nODVq8nqOVamvjx7aGfULqXvMsYfwi985DJv87saw8Rtxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:31-aaDvuF8f1FmCbhl4C8odGiwgHtlfLmPW28FRLQBKzaoJCFY53cA>
    <xmx:31-aaNbKmREqjY222dgOHgK5qopAKMIKtsCNsKdSC8BEayYgGXjgQg>
    <xmx:31-aaCXpOJKbdskHQO6QmeWTgTz-Eoe3K2GzqHE2q6r7vn-qNkS85w>
    <xmx:31-aaCTEP19mc8o4-2yHs_cFeqBB--rtp-2Ak9E_cCw9km2Z8_F_SQ>
    <xmx:31-aaA6Me_FLWuZxdlrr37rX_FGfTbouEKBi22lWa3uPoZJsIyAwRopH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 17:25:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Jon Forrest <nobozo@gmail.com>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
In-Reply-To: <aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 11 Aug 2025 21:17:12 +0000")
References: <xmqqfrdx517b.fsf@gitster.g>
	<aJpd2MYMWgEoxQWi@fruit.crustytoothpaste.net>
Date: Mon, 11 Aug 2025 14:25:49 -0700
Message-ID: <xmqq4iud1rfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-08-11 at 15:26:32, Junio C Hamano wrote:
>> When you have two or more objects with object names that share more
>> than half the length of the hash algorithm in use (e.g. 10 bytes for
>> SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
>> fails to show disambiguation.
>
> Is this really the case?  

What I wrote in the above is correct.

> If the restriction is due to using
> GIT_MAX_RAWSZ instead of GIT_MAX_HEXSZ, then that's 32 vs. 64 in our
> modern codebase.

The above numbers are correct but irrelevant ;-).

The thing is, the offending commit changed from 40-bytes
(GIT_SHA1_HEXSZ) to 32-bytes (GIT_MAX_RAWSZ).  Plase see v2 patch.

Thanks.
