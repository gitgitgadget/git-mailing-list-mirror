Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF63542E8
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073417; cv=none; b=q0YUyE694Vb+57G0ZXC9a3+D3maK0ajyDBiV3if0ZWCXZon5maDeUWFE4NrZNaSs6zayjp/YHPlk9L1SGjsRONrDV9bpAsXOedhDXKYzR9MuLnARNOnM86QGF6qaQ+8T9Je/CDurNL+t+Z04BqbfdTbOr0SYx9pQaPnWRDbJYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073417; c=relaxed/simple;
	bh=AIeg5nmOEaYfcWNVB0u0jdLj9TwKlsel674qP2x8wDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GL78iHhWafcuySK9BhF49ihhAi/0Jj8owZK4l5LNcwOJOezmOaGGbuIrbJ1yf3JF0bRJiektU1LSXN0dR4thuLlvttUvCrFuRFluIpqE6lXdHwZn34udgnuo577/X3IkPgow+pOBkWEaXlgAVLvuCSr7ttkfE+arkzEj3vurFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fu2dF+Fk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCFL4REM; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fu2dF+Fk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCFL4REM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B1271D00056;
	Mon,  2 Feb 2026 18:03:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 18:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770073414; x=1770159814; bh=jDMheoK3c7
	sdNpgTN3UgB3kUnARR/aYh1qqD6DxPr0Q=; b=Fu2dF+FkPxFE52xWZvWh5aQmyG
	rHAVvUgGH+weQqcsOMwXEz7LaNzJkJjQYOPJYN5DmSwcVjDWd1rnWjbMSLE+ZdsL
	wmivIlQFz4aEr4OcK3ZH2WbB+EkUOQEbbQDNNrpXwnNO1sgvn7ULjBW2f4/4c9k2
	v2GfvoYHIx+uXZ6+kTSADYaFK4hlPguH8AIw3QRF0nUAWrClYmokcaDTULN8uUJp
	kO9Z0zWHCfV/jOMDiF80wG8bmwIBH1z9ioEqEC1ee6IIOxHbUC807wKbQGn6X7w7
	I2rRIKqmn90JixNiLr2k8flS5uNa9IilwgO2LQ/UDSmldoXg1GIxnrz+e++A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770073414; x=1770159814; bh=jDMheoK3c7sdNpgTN3UgB3kUnARR/aYh1qq
	D6DxPr0Q=; b=qCFL4REMOQ9TR3R+S+kT1Aei3j4uF0yMPUizCfbFU01Ql8HrkoN
	daIe4buHKCkbucS9fj1G0xu/7Ln3csvfoo7jvydPg7k403RO8WJv/LWdY5L0E01M
	fEfb/l8uqJ6LVkaxFrfxmkAHtpwiIchyXu0o7WI3Ynw2LsFVHp39M5mx2Cln3ZUk
	RHjrwVtpPqxANntzXVtPMevyz1TE1Nc9BSiKnaR+RFkXLGJRJH/iz1Mv8gJ/LWlo
	mRZ5MJ48K0XAtzQJjncfzSykHQLZxNCd8/0RlLcY4HscPONknLNoNCfAZVIn4pgQ
	1kKHjhI+9ySx3pom4nar3a+SD8Mb7+6kpug==
X-ME-Sender: <xms:Ri2BaZeMEdHO368wasnyVPL6w6jbg2MrsRFt4IRFuyedybrnUfTyGw>
    <xme:Ri2BaeNGK7k8TG0RdDKhNoWJS838Cr941IMS1N-wpwoZt2mHzjU1Q4rwuqApqtsbm
    i3-K1RCnaEfxXrE3iok-eguiSdxmKD3TqfM66Yjx-hAD_q7uunfVg>
X-ME-Received: <xmr:Ri2BaXguS1qyxzOlXk1Q-I22_7ViTZ_Fu2A8A5s4-rSa7dS2u17MQeF9QzPj0RZaxaqQ0dP5bUNifcrhMQ73ESGQJuosilb2ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:Ri2BaR2ngr2j-eg3WWUMQrrRmAxE3CtaSqaPJlHVeQoA5ZPP5IOHTQ>
    <xmx:Ri2BaRhrwvTWYqjSBKLoD0DYb1A6EF571NIFT1YDSpoO5UnHtnO8mQ>
    <xmx:Ri2BaRd3tbt66UZqtSAIRs5Nz5pUIt5PKA1P6b5rStqdf_ovr4kdyQ>
    <xmx:Ri2BaUlyYTiz2XefWQxRaXEPqpDSfud0-5jFud_swpgOO7jUMm08AQ>
    <xmx:Ri2BabAa1CeATTOq30FsQMgN2QcNx9KH_XFI3gYwoid7OLyj4O_RT_vT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 18:03:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with
 local repository instances
In-Reply-To: <xmqq8qdawyxf.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Feb 2026 14:41:48 -0800")
References: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
	<20260202190155.79896-1-shreyanshpaliwalcmsmn@gmail.com>
	<xmqq8qdawyxf.fsf@gitster.g>
Date: Mon, 02 Feb 2026 15:03:33 -0800
Message-ID: <xmqq4inywxx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
>>> > diff --git a/wt-status.c b/wt-status.c
>>> > index e12adb26b9..9f4d8fda7f 100644
>>> > --- a/wt-status.c
>>> > +++ b/wt-status.c
>>> > @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>>> >	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>>> >	s->use_color = GIT_COLOR_UNKNOWN;
>>> >	s->relative_paths = 1;
>>> > -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
>>> > +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
>>> >					"HEAD", 0, NULL, NULL);
>>> 
>>> Wouldn't it make more sense to use the function argument 'r' here?
>>
>> In wt_status_prepare(), s->repo is initialized to r at the top of
>> the function, so both refer to the same repository instance. However,
>> using r directly is more explicit and avoids indirect use.
>> will change this in V2.
>
> Would we benefit from further clean-up, either before or after this
> change, to lose the "struct repository *r" parameter, if we know
> that we can depend on s->repo being the repository we are collecting
> the status information in the wt_status structure for?

Clarification.  This function is like an initializer for the struct
wt_status instance at 's', so it has to take both "struct repository"
parameter, but what I meant was other wt_status_foo() functions that
take both r and s as parameters.  Once s has been initialized and
s->repo becomes valid, passing r as a separate parameter, as if you
can feed a different instance of "struct repo", becomes confusing
and a source of bugs.

