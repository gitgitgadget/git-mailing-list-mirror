Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448211B423B
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038654; cv=none; b=rLzaaSxudQzPSh4L8Eg2m/tzd377R4Ag/LRyAylhUAlRoZFpR82BjSLCGYpN9qRDHw+WPmx2sT70+7yXikRUVr9CcMNIOYYyFB+9Ro1WwbVR8tXWJ+GRDAUMitBF4r48ADurVZS4goHcdpm9sgYHV182/aNpus8Dz4G+IEufHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038654; c=relaxed/simple;
	bh=S0adhpMwbpBhQKPkEgHOrYsWMsPaMhwZoh0wgBGvbYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k14/YgR/5A+BZF2FK8IJSWjS0robOn1Bm3V/6FPUkP7T66Ia3zyWji8rkK1eAkUhxXu1Dtb/vFEsBx9p+gnms3q9RVVMToWol8tYAezwvhsrwAYHWEeCG1WQSCsiQ4ZK3PvXJxOrKsjeLHmyCnadVNYhrTayDEoI9DS9vwRKvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ltc+Hjer; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rgvCBa/r; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ltc+Hjer";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rgvCBa/r"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C538EC00DD;
	Thu,  9 Oct 2025 15:37:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 09 Oct 2025 15:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760038651; x=1760125051; bh=yB5wZN17rL
	IYGOXMndqItq9fPVmnb/h/5wHoam5uUE0=; b=Ltc+HjerVlKw99p1tEnVYv2CHE
	sC+LjCVktZsDwfFwB9neI5KiaInTHIUYLetDxay621aa7uTPtiC1zEAtazYDkh1b
	yAD0qjJm3QD9e3szmEMYbrWX+o8ENGJh8qK/FBShNrfyy1gjdxGH7i3kO2sida1W
	623OeCvmnJDKj081fVDfUaIRQnhYQnD/auMOtj+EB6uuxGJmD5Wk7Ql3jjwRDJb9
	KqUfU83dSVzeBp5WlyhcvbZ4O2CjF3E4VbHzi94w9E9ICyzAINBP/39cCL/+6Ag8
	EBji5NyT54GtztR2Hah7LjKeQZ1pXJJucxrtbSVoIAh2t1TpYN3bbpB2cYkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760038651; x=1760125051; bh=yB5wZN17rLIYGOXMndqItq9fPVmnb/h/5wH
	oam5uUE0=; b=rgvCBa/r9U6p3RuOMrVMZw0o+m6LoTR7rAV1AO6IEgSltv+LADf
	gA9oAnqW8EqF1rN8b0foLsOlqCjJHiTpG8kDTCEJxv1DGgcU6BisQ8IujgowLhyv
	728QDkSUveoilJGgx0APGCh7h882e9YgIe7T0YXmQysHYGbVTHw8B9gYOl27+JOF
	2/ciH7Vw+27mWQF951mO/fXdY5I+DoPV0tDIgNooIOWLqns6hCTKI5A9VZhvyXuq
	LsBMLvSLClQZVZv06NmRthx56RCQJCHhjeDrlqGbwmMMbYVZJAZxbp4D9IqbZrCh
	2aoFAmWUg/WZ25nqy5Qc4vhwaEix/119iwg==
X-ME-Sender: <xms:-g7oaNbk61iOGBGZ6QR2rc8i0QAtLFZQ_qfttNLcVW4UKNMhQ3FM5Q>
    <xme:-g7oaDeuueMrRvAxu30V6t7hJbyqlOgMXiXPrVtL3e4OFhE0DWH41G7sgS6v7Mtth
    -yiApJP65bB27KoCCO-Zl0CHROyE3stvZPAHDzpHi8RNClIFNJO-g>
X-ME-Received: <xmr:-g7oaGJV1ajH4jijrzFj8_VG665bxklQz0qGSsnNaz0Scva1uz2MdSwGd3Br4D4S8P_CGXPu9KJnon_H_BBBEmHISD7FlkBQkqOD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:-w7oaIKEzLSm68VBZVJduAUIfCatQZSvoabX2v3rRayd9o8XRPCzSQ>
    <xmx:-w7oaNXFN8ZK4qYgp12SUrlDnThLEdhXc8kbcNqrknYCybSfU-noHg>
    <xmx:-w7oaJmXkHjHNavJ58UwmAUaraA9-tYDbQqLhayW2HA3VbYgEjUhMg>
    <xmx:-w7oaLlSky_MsFEDBYwpftoYZ9Cj-9_-qMYh0-8HupjFGok6N8sg0w>
    <xmx:-w7oaPe0MYKkJHPH_FrqCxETjxxhPkhjYR2k4R3ZV0u36HDxxxt0-4z6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 15:37:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
In-Reply-To: <20251009053825.GB1614343@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Oct 2025 01:38:25 -0400")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	<20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
	<20251009053825.GB1614343@coredump.intra.peff.net>
Date: Thu, 09 Oct 2025 12:37:29 -0700
Message-ID: <xmqq5xcneuiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Oct 08, 2025 at 05:50:15PM +0200, Patrick Steinhardt wrote:
>
>>   - Patches 1 to 8 refactor our codebase so that we don't have the
>>     `peel_iterated_object()` hack anymore. I just found it hard to
>>     follow and thought it shouldn't be too hard to get rid of it.
>
> I'm really happy to see this hack go away. I've wanted to fix it for
> ages, but didn't want to bite the bullet on changing all of the
> each_ref_fn callbacks. The approach you used here to pass through a
> struct looks good to me.
>
> I do have one minor complaint, though: the name of that struct. I have a
> feeling that the name "struct reference" may cause confusion down the
> road because it's so generic, and because "references" and "refs" are so
> common in the code. From the names, when would I know when to use
> "struct reference" and when "struct ref"?
>
> Could we give it a name that ties it to the iteration interface?
> Something like iterated_ref, each_ref_data, etc?
>
> I know this is minor (and will be annoying to adjust your series), but
> I'd rather raise the point now than realize later that it's confusing
> and try to change it then.

Thanks for saving me from saying the above ;-) My feeling exactly,
both on the happiness of finally see the hack go, and also the
naming.

