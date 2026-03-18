Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D83D6CD8
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864781; cv=none; b=uc7Bvs3QWsO5VcQzFjSVOubneUfMBZwKiy3XnZo+re/wJoFmI/OMRRFkH8g+uj9R/rb7qSoyAN6c8XnsLF/CCXKpF+eXKityx9bPLjW/6FjtyLcQvYu36u/L+9mwmwcN5+qW/sIe3QyL8bmwrrz369O1UOSSZayxFq/ej9KvqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864781; c=relaxed/simple;
	bh=gMqHVndSrlUIMIbdjekbSLSxK8tR6PONDqs5gsOMM2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G/luH/ASF2AQanmT6nwR77BXRJmmKOP2kKQbD/CmAVyDe3LDwn3Q4B1OxSKT+CVWVa2AkPit9XJCyNAP9dHrRN4+8HBSpN6CMMW2kq4m1TRYO9qV8FZuWQ70vvPEsz6A3tC/SZ/kC5U17PJFioYP2kS0gsMvzP4Yv5FsbevN6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BPRLMy8P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sk1f8s9y; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BPRLMy8P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sk1f8s9y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EBBB7A00DC;
	Wed, 18 Mar 2026 16:12:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 16:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773864779; x=1773951179; bh=gMqHVndSrl
	UIMIbdjekbSLSxK8tR6PONDqs5gsOMM2M=; b=BPRLMy8PoH7obqVPuvMZ1IoaiX
	b1/td8sYxm5cKcoXhGeh2xTE0iIkmQSrZAUqRfltG+bJ97MVLb9ht5thZW7hofJ+
	Nv5UtoOai8FZyWav2x+OJMcZTl4OQU1xqi1E5m9yYotT1n8A/6xRUFQoAVLJXUnq
	m35E/GxN57YA2x45GHhvgDJ7PNPUtzoMQ/3FevHZLZbPAuSNLaxMqRrDnFqYx1UH
	LSBTJhFq303LNq8Te3WNmnbSG1894OcMoG66qIzTdc/1Bhw3kFqRCan163yq5Iq4
	tfv5a5G/vgEweomwj5PO1dfePgJZbr93gv//YD0spyQWH6xQXw4qDFdXHskw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773864779; x=1773951179; bh=gMqHVndSrlUIMIbdjekbSLSxK8tR6PONDqs
	5gsOMM2M=; b=Sk1f8s9yHoVRuQ6QBJSfXQ3w9occ+IX7jM6x4ctejlfw60/w+FU
	f4sZ5vfGdiIsHvkCGlwyawpT8Ve+KvWLVgiARv0EdmOfgIxPL3SVwd8LSdlD9do1
	cbD+zI6BQF0mwIzjG4o66rAAaxydotOIFih79Wy/ahAvw/Y4sl3EryUT9BwxGRRM
	hPN+lB+tBsGcBq+Qj/3s8yt3pgdp9TcyvWr1RYCVYx91wXqyDTfXiZRCjp8kg6HO
	G673/MTZEzWJSY00AVazl0kTnfUzLkkCuhm1Vx2U6W7BBj7phctfoizZIRnGRJ46
	hUR0Uk+SBEuqUiLW5Zw4lN07ikoJ4dzZ3ZA==
X-ME-Sender: <xms:Swe7aXCClU2PgPWj7TZGhkCtceCOfHSedFbtkZ7Etd9jMVBZbygSrg>
    <xme:Swe7aUjqRx4xl8KSZNHIIE668plgHxudzmV3pCNYP84wRsVtUSwQueXcoqTTrh37g
    aJuPkLw5I1lqKgpjYXDBIb33lMCX05_3LwUtnZjQQIEK9jPS_P6Xw>
X-ME-Received: <xmr:Swe7aXl-ZVkeUjvB7dTsY2f4HEDA7LQWZic7XBMm2WRg8A_N-JDDaoX1soLZyqlPv_C_4YvHpkUG9JU_ryK7ge8YxwBfGSb5yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrughithihrggsnhiftdejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Swe7aYqdg56nVsU_VPP92R2MLn613zsmnNlwTlu6ChsA4jx28ZNYhA>
    <xmx:Swe7aYFFDVIIWOGLltjv-iFwF6HFJfVPFPG5y0E2xfmUyAO29yTdpg>
    <xmx:Swe7aczLmhv0ebyzA4e3koCQ7YXns6-Z7aYAUIYfJMLQZrcdwUCa4w>
    <xmx:Swe7aVoh_SPgLapbqWyNWPOJqDn593Z2XqUrR_YhD0aEjRE5rX6Qnw>
    <xmx:Swe7afEVUX7SRYRBxwNqylyLMUBRUjSm1dX6_AkBl7UEcFWc4ffmsoZA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 16:12:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "QUANTUM via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  QUANTUM <adityabnw07@gmail.com>
Subject: Re: [PATCH v2] t2107: modernize path existence check
In-Reply-To: <pull.2071.v2.git.1773864455956.gitgitgadget@gmail.com> (QUANTUM
	via GitGitGadget's message of "Wed, 18 Mar 2026 20:07:35 +0000")
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
	<pull.2071.v2.git.1773864455956.gitgitgadget@gmail.com>
Date: Wed, 18 Mar 2026 13:12:57 -0700
Message-ID: <xmqqtsucq4l2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"QUANTUM via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aditya <adityabnw07@gmail.com>
>
> Replace '! test -f' with 'test_path_is_missing' to get better
> debugging information by reporting loudly what expectation was
> not met when the assertion fails.
>
> Signed-off-by: Aditya <adityabnw07@gmail.com>
> ---

So we've seen you identify yourself as quantum, aditya, and aditya
indora; which one do you want to be known as to this community?

cf. Documentation/SubmittingPatches:[[dco/real-name]]
