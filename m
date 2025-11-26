Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983B1E572F
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176810; cv=none; b=Fmp/XffTvn62D81/lyOb/mqGn2rQS6bbOm63oJXDjYqmQch6X47vG1gLjJT64Vp8BWVSl+IjZz/6+BLUf+0Uit0XuV61pQFVbuOJuLVu/FJlqxRmeSKtjn4ZcAbL547Eb1O1VUDSNF3lzqPQ/h3foqI7ykdLi4u4xMtBBHGEygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176810; c=relaxed/simple;
	bh=EvHimsgnlD4PCCQVkAiCqpk5GeiPNgbnEQVwGJqui/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGXbO1bmDjLB8QfwRr2X1hNdhjwlH5Bjqko3ALkaSeDiFS7qBatEZTQrANAU2XIu670sUiTkQutfIffSM2VBLAsWsNA+UwczQ3bI3NLXkIZx/VjOAW8pwoDE/fxVpc+gC46ZbG95xKDWOdmN5OrCa/jjIPK9fI6Do6KCskEOOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZLuZ4lqn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z/iTGbSy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLuZ4lqn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z/iTGbSy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB665140009B;
	Wed, 26 Nov 2025 12:06:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Nov 2025 12:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764176807; x=1764263207; bh=CaqDx+YbAa
	EWg+BKSTamVt+HIWxlP1e7TWNApo44Pfc=; b=ZLuZ4lqnlWPOk0JaDGjDA9FTwz
	t6+idsJ5p5B2rN8vtnJsSozJU7w64K7YDs3nA78Ek0npBJsLitHXkD64metJDGAz
	oBCqsD40/o43GYIvoL/iOjmVL4FbQhGKEPJiLkaJdOCv91GBxOkGqh/0UCV0ZnJa
	aNrA7ivucN9HefewUZfjX0o0ginZIxZqtqFkOKTbe/GBVSL7puE8n/OOEpxx0w0r
	BZZBXvEMwCBo6NHyuTmoof0T+DkbDaxbeg2DUi7zB6QTcVAxku9cI5H7tUWi19ZI
	lQiwmj+I/Alc4v/D/abOynTPYXSw5kQNI/YlOfU4Tuwv6HJcrB+B24VUbZ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764176807; x=1764263207; bh=CaqDx+YbAaEWg+BKSTamVt+HIWxlP1e7TWN
	Apo44Pfc=; b=z/iTGbSy6S0660x3q5lW8KGATJkskJdw+2DZxw0maSSuTbei1xo
	d/hQzvl2KQoch8ZOCgR5J+NtWIdw/gPST4JanamMP6czmjZN0euumULSbKn865wk
	iexQWBslkR/4QTEaaBe22OMQa8ijzNBXLl7h04QVcpvXnaEqPd7M8ykvQYWeOhsf
	LqzO7ZabE82n/QlElvebfhk0kRopiZNfuqudphnMW7cwe27XKl0IaWjNqde1n22a
	UqDFF7SwYIC0YezL+FLjV2i/uTMoc50W+IjiAx8QCtXZKB+WeBfN2tBCGAxh4tPg
	pGTT6COp3rmU+efNaOu+TdIXJnTRJjY7g/g==
X-ME-Sender: <xms:pzMnaUrApuwvSH10NFGN2bSAbXX7-Vq8sLyqTFHOEFfe11peLMr9kw>
    <xme:pzMnaeWca_tqglVypnUbJMaSue9mD79YaqURcacF87baLnO1tJMtR8tvGPWwYNLtk
    4hN1UerMA8Bu5pSHz-vEBfQSuXeLXQP50K2kmaeGMbyei3k0cmY_g>
X-ME-Received: <xmr:pzMnaTDmpj2Vdst5S4Q20l99aBrHo1fvuHKmWJhkG_DjqJG0IQLQdkzDFkySPIDJfrPZzC1hwiHLBTk5n4pJjTjpWq9PGLAmtR-p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrghnrdgrrhhi
    ghhurhdoghhithesshgrmhhsrghrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrrgdrlhhkmhhlsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pzMnaS2SDOv3rGt3jA3JStIdZkZBGPpbMzlUcY-gQ8LS5rYRcns15Q>
    <xmx:pzMnaV16oI3AS65L6oqqGnbOVISpK32HpYNYQWOEDGoX_B2c0oL0ww>
    <xmx:pzMnaXDGL36TNyQucsgYP8Cp9crinPp6S8U71V5yHSzH8BnBMA0miw>
    <xmx:pzMnaU6U6MNBzVW8t-oG0I0Jb93-OPjTJU9W3kTh4VdcQHaPnmlNfg>
    <xmx:pzMnae_Ws4BqZmyHU3O_fbNsivCdmFY-w2TQmpPq95GMGU3FP4sZjgw0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 12:06:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Ran Ari-Gur
 <ran.arigur+git@samsara.com>,  git@vger.kernel.org,  "raa.lkml@gmail.com"
 <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
In-Reply-To: <20251126150215.GB4143292@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 26 Nov 2025 10:02:15 -0500")
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
	<CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
	<xmqq8qfvw2lh.fsf@gitster.g>
	<20251124235530.GC2051672@coredump.intra.peff.net>
	<xmqqo6oqucka.fsf@gitster.g> <xmqq8qftrcqb.fsf@gitster.g>
	<20251126150215.GB4143292@coredump.intra.peff.net>
Date: Wed, 26 Nov 2025 09:06:45 -0800
Message-ID: <xmqqtsygoh96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That doesn't trigger via "git -c", because we use the "new" form these
> days (so it started rejecting the extra whitespace in 2021). And you'd
> only see it if you hand-crafted the variable, or an old version of Git
> set parameters that were then parsed by a newer one.
>
> So whether that is a case we care about is up for debate. But if we are
> going to accommodate backwards compatibility, we have to decide where to
> draw the line.

I was hoping we already drew the line above the "clone" thing ;-)

> The old code actually trimmed both sides. So:
>
>   $ GIT_CONFIG_PARAMETERS="'foo.bar =baz'" git.v2.51.0 config foo.bar
>   baz
>
>   $ GIT_CONFIG_PARAMETERS="'foo.bar =baz'" git.v2.52.0 config foo.bar
>   error: invalid key: foo.bar
>   fatal: unable to parse command-line config
>
> And I think the latter would still fail with your patch. Again, that
> might not matter to us, if all we care about is making:
>
>   git clone '-c foo.bar=baz' ...
>
> work as before. But I'm still skeptical that is worthwhile (especially
> given that nobody noticed the same change to "git -c" a few years ago).

True.

I do not think I can convince myself to care about this deeply
enough.

Thanks.
