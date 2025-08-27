Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF521BD9F0
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312770; cv=none; b=AiCU36Buw0MJ1kyLhcWiJ/ViUhWQ6/ZR2eu9is+MnDnYxe86Kv1N/F954bNEju3NrQ7F7XelrBvsVLJU5FZn1nsiohpsykHVGrj07h2vPOJ2Y9NemZOiVnMNBL+SxAwOIn8Zy/VDqMEt6yVfnGVXcpubz/HN+C5b5FBLfGGxT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312770; c=relaxed/simple;
	bh=gZAYG2xlnYLkQaQgd+3vmklzndN/IlffstSNxVAdQmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h6Dgv5MbGNkfUv4lf7wyyjOxMDtxxUqwnjx3wJqd0ZymD3I8epHePFVj0SU3vc2Ulpg4ZTX+j7Th39rfFynxIu5gbtwE/HkS+jL5iX1RxDp2NmTAqxVZfj87FliZxMAmkW4JW1vWmuVhZkWNhdByKCZ6Y6AfF+RWlE8vY1Lu4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CQSbMmWx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYtJ0Pl5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CQSbMmWx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYtJ0Pl5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC935140014B;
	Wed, 27 Aug 2025 12:39:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 12:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756312767; x=1756399167; bh=gZAYG2xlnY
	LkQaQgd+3vmklzndN/IlffstSNxVAdQmU=; b=CQSbMmWxIUZZmVruokLnMy0EIS
	pTB5ybxi8IuKz6cPmLt9H0lutkTX+jlV56uSSE6aM2KBUj6YtQOkDHHY47kEpJTc
	Yie1Jd1nngJUiDci/fbKSUmSe8dlU8369b94ytCtXkllM6EiJFL6MFw02J+JjqlD
	xSxBBf11UvCZsp+aKxfDU86W9QI0qdBjeUj4upr2Ce+QeJ29AgIwkMDC5j5ooYV4
	bMvOyfyVHxDR/c9R8rCdT6Q+OGffFVoRDRn21XHwJoZJy2WYQiK6LtnhRrbuxmm8
	jq6ZkTRG5jEDpPeqkgDREsHwVrXzQLJD8FJv5kZ9yRYGjFc4B+rzwlok5UWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756312767; x=1756399167; bh=gZAYG2xlnYLkQaQgd+3vmklzndN/IlffstS
	NxVAdQmU=; b=QYtJ0Pl544D/WTZZZTE7DB8Ce5D7JveQtlRvzppmJPFZUEnFTM2
	8Ul1rfcW+pLLLMDzARHByhKaZpozq+xLOQpIu5XeswzBGJWE82iKtpU4PCLeT88t
	zIZylr8aQJYp5p4cwKEdookUUImvDz38vDpL0i5ETIw2hof8TE+CS21P/L60HxLC
	PJc2zo79U0Wyto1MtiJHf/XlOqMSipHpx1UtEpwFgFPi2F0PG5tv5UZsnVv+uiAQ
	0dyIqsIH9ZHZknNhT06pmKSxR+HD3lPIc356TBQr/NBXneVOkJK2WpGYXKZMdW6J
	YDecX3FpuXa5bAStlLvvlBPBhQ54YXbtLlw==
X-ME-Sender: <xms:vzSvaNnhWm-MmEICTir8gNRu5ms6ukM09RbA4t6XY64oSnMXXeZ_iw>
    <xme:vzSvaC5_9MT-5PpD_VKBxzBu6yctYa3dtUVTvdEVlpViVQDgOUEGzpAp67sJ4QJaH
    rJyua8uNFnpaaxf4Q>
X-ME-Received: <xmr:vzSvaDjWnxwAGRslheZ4Dtd3eoOfmBlmHJQatQIV4eMRd494uMr6aOPFKt94EhxUF_3q5ctm39VRg_yVJw0dns4E8jy9XGUqJYrHa1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:vzSvaPGAjWT0yNgD-KE9gofb_EZz1hK-vpo6aVUh_uHo3v12y-a8MA>
    <xmx:vzSvaJQq0WEHCjN9UzqcJtvzawBgGlhGN5L9K7tFGXKorN_0azZZMw>
    <xmx:vzSvaMw2qZ9-E-5nX0CqYGSvMHsdFoY0OgAi-lqOZIztfddT9-649g>
    <xmx:vzSvaFcrlpYo0_n20JwdJ1-U1tSumtSmWFNJp43Qf1u2bjafzr7_Ew>
    <xmx:vzSvaKp6yIRroNhpr201jU57yKF4SsMa9jm3qHDPbPzqUaoJoyLayM01>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:39:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/3] commit: print advice when core.commentString=auto
In-Reply-To: <aK6_ivfXr7jIbBCz@ugly.lan> (Oswald Buddenhagen's message of
	"Wed, 27 Aug 2025 10:19:22 +0200")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1753975294.git.phillip.wood@dunelm.org.uk>
	<0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
	<aIzayan9nFZo4XYv@ugly>
	<af0c22b9-5034-4bbd-9cdd-f1f16d933e4d@gmail.com>
	<aK6_ivfXr7jIbBCz@ugly.lan>
Date: Wed, 27 Aug 2025 09:39:25 -0700
Message-ID: <xmqqfrdc3eiq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Tue, Aug 26, 2025 at 02:33:10PM +0100, Phillip Wood wrote:
>> Some of git's reputation for being hard to use is well earned and I
>> don't want to add to that.
>>
> i would find that reasoning compelling if we weren't talking about a
> case that is likely to affect only very few, and probably rather
> advanced users (who somehow managed to make the feature actually
> useful for them - others would have quickly reverted the setting,
> because it would have gotten into their way).

So your counter-proposal is just stop at saying (possibly a milder
equivalent of) "nope, auto is no longer available. deal with it"?
Or does it go even stronger and not even special case "auto" that
user sets (i.e. and start commented lines with "auto " prefix)?

A simpler solution that would work for existing users is more
attractive than an overly complex one, of course, but I need to
gauge how simple you want to go.

Thanks.
