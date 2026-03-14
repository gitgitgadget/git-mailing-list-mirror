Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430034214F
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513537; cv=none; b=A0CVKw+nYvgiM5hswCSyKwLnaDG9UKxNZDyciNMHAu5hgwOCRZLBZe1KjCRk44/FXIwSJgNnNrjaurqP5g0LCKt/Xw2dWAuN5Ig4HKNA3M9kxiXYBf6PGnUtngFx+JWXcEoGwwmERa7hiOi7pDYjYazRYp5woeU1SuUgyVk2g6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513537; c=relaxed/simple;
	bh=zGttCP5nTjBESOW7nlMiXRiUWtK3a7IjYQf9VHwJ2zU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZjxbfCLBckoudHojFB9sIZHlbdnqiZHPPWvorBtCe4Fdc1hCItxJJbin/ue5TAAGYxIu9KM3JSgEYn/ijN9pMM16hfeA026GAdItwguX6MO8SMqhCRBZwAVjSSmHD81RvDTWGd3nvbwn5mvx5oQI6Lw4n9K6OR98OHzzE1jaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lX906LMl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3126CSwx; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lX906LMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3126CSwx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F19F1D000A4;
	Sat, 14 Mar 2026 14:38:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 14 Mar 2026 14:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773513535; x=1773599935; bh=C0nfplhcog
	pwT9HG4+pvuBak/lAvA86NDAeD/Rv8AcU=; b=lX906LMlD425XQhKGAvpBFQxAo
	Ae7inFca5Y/cQ4yw7swNYL/xP67Gk/Fa3onswsf/4+0j35uOJEvlD/MfAgF6Uew5
	5JIb5zJrvFAoCcy62GIzu8n1vbn5xiGiGruRdqznLTOVZukel9FPZNDcXZhXMTl3
	WpJ1JMEYxyoiDjrjKOc2EXsVbi7kuc6/cs8S4VUAdoZjZeiVLbCKaF2YV1L8+rje
	55XN8snXC4UmLZ0NLrSIdJ9g9rYFbor0m2kVSgqPmvvCsbAOgkFGKNkzCr1Tgxwe
	IB2YuzqfyreLDFwPS8I3ACdoCctla+sS5cWg1RBq4D9X2/EP1h3l0Obht4jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773513535; x=1773599935; bh=C0nfplhcogpwT9HG4+pvuBak/lAvA86NDAe
	D/Rv8AcU=; b=3126CSwxGcI0NYE+Ovjq/p0sP/e5QeBUlTXwLgPMfoC+wdML6Sn
	AQThN46pxE+m8hf2QtoRtfQpJAH2vgpNDn7SqiarxrNi3XRCJaa4ThxYNB/Yxu7A
	fXKwSWtoVVdDIxRQMnzMerAFf37aUqHcte6xbO3hsJ2BEJ8JdDE1Vya29NQPmm3Q
	FIlCQxW4FVF7V6QMz5wN2YglEWcK/v1w1lBiJFFlJuNAojfZYDmeKPz9GztdIeiV
	cdPgvGripdXh1fABeZ7wq3i6+SHaZhn5V7guJRK691c9TPZqmm5vWmMxtLIms1Iu
	FHMdXbdJk5B/GRmjmLevYm1Oy4IkZZ8zIJg==
X-ME-Sender: <xms:P6u1aaXoDgzqMM8vflliE5gYAHXVf9Rb1fcdDjXRl90pNKRP40RiBA>
    <xme:P6u1adkMqHj-SmLDPzOa60H8hkjq-L0kgaS-08XX3cj6ISTJejlr0s7QENZRJ_oHo
    B_8btvVBwP2RGJRMC9Y1R2RC_X1GWJ8C1ml0QMAYY-8RCd5YBXB4A>
X-ME-Received: <xmr:P6u1aTZ8Ds8IgbKe19DkD8pTtTr5dfDqTqvdiSGVO6Lr9ZCuw1qz9nnESra1kem5ZqSMnXTZpCd-_NGRaTqKbY0imROvb6zXiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeffeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P6u1aQN1q1tkRMl02EYzDGVUgFKFinXRX9Ths4sbRv1INzzZRK-WSg>
    <xmx:P6u1aQa6JjkPZ4yMXjkL1i0lVqIL2R1ybo1fEWC_61nbz9Z8FkeN1Q>
    <xmx:P6u1aW3mvCBbHg8zHEwam9hh_i5War9Z07lqDtXUnmZabwfMfVbEHQ>
    <xmx:P6u1aecd2yEYjx9RQJZjDHEX2hxyG7EVIr4WTk_EDrj5gZZzK3hHew>
    <xmx:P6u1ae7BHFSyMrs3FwlF5UEnitoSYKyvH1pt3kgQRCPIvJSp-ObWZc5_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 14:38:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] remote: use plural-only message for diverged branch status
In-Reply-To: <xmqqqzpmwdyi.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	14 Mar 2026 09:52:37 -0700")
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
	<xmqqqzpmwdyi.fsf@gitster.g>
Date: Sat, 14 Mar 2026 11:38:53 -0700
Message-ID: <xmqqtsuiuugy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> Drop Q_() singular form and use _() with the plural string only.
>
> I know the commit title talks about plural-only, but please make
> sure that the body of the log message carries all the necessary
> information to justify the change standalone.  "In the else clause,
> both ours and theirs are positive integers so ours+theirs must be at
> least 2, hence there is no need to prepare singular and plural
> variants of the message", or something to that effect, perhaps.
>
> The patch text and the reasoning behind it does sound familiar and I
> vaguely recall discussing about it ;-)
>
> Thanks.

I queued the patch, tentatively with this rewritten message:

    remote: don't use Q_() when it is not needed

    In this code path, both ours and theirs are already known to be
    positive integers, so ours + theirs will always be plural, never
    using the first variant given to Q_().

    Just use _() with the plural string only.

    Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
