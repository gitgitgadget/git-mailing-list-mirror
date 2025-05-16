Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3771D5CD9
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413756; cv=none; b=cg8eWrrm+KKXQTRZYWPCxvZ5kVlowuZ/bOwJrAFai4XxhjidA4Jpfwn1w+4lv44sUkFpKs60mHZJvkj9kLB9WmFqhxtrLpainErNc/VZix33zWOVF2TVQuZ5C6zMZL/FvT4RtA86NFa5Xo/q3Huz6yLpLY0mqsV8GyHIuFKlzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413756; c=relaxed/simple;
	bh=GwCItex5NAIGCZo+lRtexB1fcyV2RkrMWzmjTfCSJHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgZr7cjkei56ChvTgM8nLBjTQ/BonYBI8t8yKakMx5iyai65EsgqXBldxS1bUvKdaLSIYVMiCn7ujJMTLaZW3h7TAD+YbyYDp2/v4vOwGXmFLv6GMU7Au07kmqoPgbCM0yaLWD9RGt0/HdpL7S8lzixlnlBcv5XrIIHVTuptIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k4MYghgM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmIlThnE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k4MYghgM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmIlThnE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D18F911400EE;
	Fri, 16 May 2025 12:42:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 May 2025 12:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747413753; x=1747500153; bh=leFUfl2iX9
	YuxWN26z/9toCer1UXsozFeZonAoxH9tA=; b=k4MYghgMdPRwzkVu2IBrNo9UST
	pNYi6U/XYzgAJOFlamQyi4W2KS+O48ltkxvqhszd2dY0ZT4UONuucsJrHaYLfh/r
	6RVgVNUnPGKMxS4jfiaPAlV63X3DKrrJx27rGrJnYVF+P5pPykTNoPEZYydMi9l6
	W+4fHD9zqLSd/72dYSDbpYSoJFHTasL1jIAHmMDHp7WPJ1qOTdUhSpCYqMooULuo
	Ohi438UnbRysyoaoZtGItIB0sueVNGRsm/nVnq3fndPO+jG5rGBr8eUZoMZTgvRt
	UyrzvzRFMB04zr9ESgeJMYBIIBfd4GEiA5KXJlh3WEVKIvYEd0JkWHJRrF4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747413753; x=1747500153; bh=leFUfl2iX9YuxWN26z/9toCer1UXsozFeZo
	nAoxH9tA=; b=lmIlThnEOsm5Jq9HrJYgA9BwbGdjRpfr4D5sk33b92xU6zoqCQf
	E/zRmzOcEP7HaeVPX7Pf0d3iXK29EOhhIzsSfPJIDp2a6ZvosxXljT0j0he8G96t
	cI8BknvZJgS6VnvUMlbHXnr/M/HyhoEDKQ9HanAOZNnPihHGe1CsDrUPunKoXPF7
	NRgzduBk9iaHbEqS19k9I57XUHmy4/iL1WhalxPIi2GlMMWeZXGAdTvV6V3jXJO1
	9rWRfWaEhG2HEvIlNtyjsMCuV4Pj3w00pkhRPJLENSzUW1k8UEVyCnIMgjN94EGH
	FRhzXMSCQOjObxiZDSZL3x0CLyDze1Fpwfg==
X-ME-Sender: <xms:-WonaIy3TMcX9ZEAIBcQpZM8ii0yC5n40QvkeHa8aGGGCxKsuBeq2A>
    <xme:-WonaMQKmK001D6uQKu5a6uBGN6Rxlo-nQ8rQCe7_W3kcLTLbSCrxk5hf-c55RFkQ
    lVsEsHtWCj69pBxfw>
X-ME-Received: <xmr:-WonaKUFeV_Bgpyl5tQbA_6L6qHhO2crPkYZERgzRrvY4fNqYN6FmYt3wJSoVbpyNkLg3CWpzvxCMu9OE4TU2kRJwBTLfZ-dY2SneaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-WonaGgRmfC4VjzCLQstimH17elM0VtYb-ESgPGdsD1YRF7LFxVmLQ>
    <xmx:-WonaKCd8240mESnb__hOv35Hk_6tUW_ZRrXE02ckrulOtTFCOCzkQ>
    <xmx:-WonaHJ5vq0FNBawmqr-0LD1MMA-0gSyQ-0zn3SO47Xp5OjLlhvtcg>
    <xmx:-WonaBCz615G685t9uRTak0kpTeclFAzY4d1hGStS4lsPb1pYYmPNQ>
    <xmx:-WonaDBQxDPAEXJR1fYXCfc6LlaXs6Wsoz0P95uPj16p9fZshIUcTta1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:42:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im
Subject: Re: [GSoC PATCH v3 0/2] json-writer: describe the jw_* functions
In-Reply-To: <CAOLa=ZSH4CUdAUOT7H4B+2dwgfx22wJxxjt0SqPavAnEsdkHMA@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 16 May 2025 01:59:22 -0700")
References: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
	<CAOLa=ZSH4CUdAUOT7H4B+2dwgfx22wJxxjt0SqPavAnEsdkHMA@mail.gmail.com>
Date: Fri, 16 May 2025 09:42:32 -0700
Message-ID: <xmqq7c2gwlqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
>> Hello, again!
>>
>> In this v3 I did some minor adjustments based on the review of v2
>> (https://lore.kernel.org/git/20250512020935.73140-1-lucasseikioshiro@gmail.com/).
>>
>
> This version looks good to me, thanks for the update.

Yup, the result reads very well.  Thanks, all.

> I do have some general suggestions (not requirements):
> - It would be nice if these patch versions were inlined with the
>   previous ones. Makes it easier to compare versions while reviewing.

"git send-email --in-reply-to=..." is a good tool to use.

> - Perhaps include a range-diff to make it easier to review the changes
>   in the new version compared to the last one.

Here, "git format-patch --range-diff=..." can help when preparing the
patches to be sent.

> I can totally recommend b4 (https://b4.docs.kernel.org/en/latest/), it
> helps manage both of the points I mentioned :)

... and more, by helping on the receiving end, too ;-).
