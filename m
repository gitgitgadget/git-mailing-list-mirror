Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0536BCEB
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358894; cv=none; b=JCy/mc/iJ0ha88wmH/1q2thG3WkjqXjQbltcbe2ytZJwGyplKMQygDzUpHDIqZoBKxHOOcO2uQID5e5BD4eTIvFHrlQAMrk0qmlwiZ0p2fDymqJNwRfQrjwj+4AOCLyYEUT7AQ1hL/JxvKw1wYeqU4/PH4kF6eP8MjvYZZJlK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358894; c=relaxed/simple;
	bh=6NsSWjc/FqkWbQUH8eM/e2+pwuMNNt7BcI9y3YDb3o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1zjC0YsCM7/g2ohOGkbA9Z+eqzOaMf0tD3D6ffJBP8BZw6huchzIt9AiKqsPbe8YeQ40NUGP8O0Rro8p1PRygYU0fBZVas+KqIPhFO02xUxgornM/GsqUzFJkzoO6b2sOAuUZaidw54u8DK82RjOlv4pY0ShgXebUz5EPi2BAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GqAXeD89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPXxGaPq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GqAXeD89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPXxGaPq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D25A7A010D;
	Tue, 17 Feb 2026 15:08:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 15:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771358892; x=1771445292; bh=nQfy0t6j8X
	iuLsJPYBYMyxY5lqIhlRfzlbcfxG4X8Mg=; b=GqAXeD89k5frHLhq1sL5V+arEL
	WkLDJ4C6ZHJRSKTjFIMoG2/DLPOz0ZlOuUi9PVeJLxSWfHt6ezgCRSgz3SkOeKCx
	+dk9OPJOa+tyFP888mD2/Lf5zPDLi8D8ZFLRxJFuhd3eePp/LITr/tM+HUznJQEw
	JYcIESDPFa72XHLVr5BtHhUHY4COYbxokRarrnfJBPJkFwA1zPUJHNAc3H4WzQ6A
	DL0csFyA1lRbMVbppNFUaTLdArZ4xiRIDT/3cfB5ZbofDtIMbGmI4TBFYDTgSNJW
	/jhIbr3YCvy9GhAyV1osRMWa6sn0Cyf7DSIpEpQfjEeFacAU9RLJquMlcr9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771358892; x=1771445292; bh=nQfy0t6j8XiuLsJPYBYMyxY5lqIhlRfzlbc
	fxG4X8Mg=; b=qPXxGaPqpfl/t5j1CwaRR5OyAaQuHrRJ5yJ+cXPdfdmFFyMqf42
	T0hZ0AkPPBLMbjYaGzj4kPaL5DNjHT92HuzvoCyxpdllr3O/wxSDbTrxELHc29HX
	FempeOlA7SatpjVHLt2QcUZo9VJMMryHpXHzyU8mv8dcgYmO4fytcjCGJXrMk04H
	vu3yc2UQ9nBV0vJFowAW2TEo+2tOTEATkPFaFsWsF+4n5sSiMaNNAQgvn2KLkkiA
	bnyQXLG2Uv22wp/YigRSIryqXXPLmryrW75pUTyx/ajS8okksg/QeQJaN1+P/T9j
	rkJHGPQnxxb5A3clnCphKZzNzyCB8Ne+VZA==
X-ME-Sender: <xms:q8qUaeWhpdHfpv87LWRYa7lqMrQ1xLJ4cJI4gQXS9fxt2ztqF5PfJw>
    <xme:q8qUaXKT4V_9PEmvlpzYu0BVbOYzHUmAqUcSojY1R2SyAacNsRaeaZGg_Eeq3DbDm
    -NyYMPt986s25hzS-7psGoFwaZNcCUlNSzYXXddxguIJgEXzsVZWw>
X-ME-Received: <xmr:q8qUaW1sQrrGj0wBXyOoc7h5VyaonzlaW2GbNN8X7WvHZJmQXiJ3WEShZuu-60IEWwA-dW4YNDHzouiVIOJCs07DJL47KMIwdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvlhhk
    ihguleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhs
    mhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrg
    hrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:q8qUacIZo6bDbJ6VUSrGwwkz6WcV4eJLyRAlqtqVqInOZiI-WrZCYw>
    <xmx:q8qUaZgbjNOQK05lRsUSqVo9KT91XYRq81Xv0SiSxosyQDLGvp2P6Q>
    <xmx:q8qUaUDHlAweDZj5AspERItubxp58Ljq20_7kPwRvKoWzbs1gj4rrw>
    <xmx:q8qUaT6_HMntt17aUsy53DjIUjiJ_6V-Ba7ezqmo0OpPSuu0NnRrAg>
    <xmx:rMqUac7Hbzfqk8m_qOpB9qpdm3PXscu4JW7frzVWrPA_raeIJz6nsMyr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 15:08:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v7 0/3] store repo specific config values in
 new `struct repo_config_values`
In-Reply-To: <cover.1771258573.git.belkid98@gmail.com> (Olamide Caleb Bello's
	message of "Mon, 16 Feb 2026 17:38:24 +0100")
References: <cover.1769256839.git.belkid98@gmail.com>
	<cover.1771258573.git.belkid98@gmail.com>
Date: Tue, 17 Feb 2026 12:08:09 -0800
Message-ID: <xmqqa4x7b0ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> Changes in v7:
> ==============
> - Added the code to reset the initialization of the_repository
>   in the fuzz-commit-graph test in Patch 1.
> - Changed the call to rep_config_values_init() in
>   initialze_repository() by passing it the repo config_values_private_
>   struct instead of the accessor function in Patch 1.
> - Modified the commit message in Patch 1
> - Added extra lines between variable declarations and code

>      +struct repo_config_values *repo_config_values(struct repository *repo)
>      +{
>     ++	if (repo != the_repository)
>     ++		BUG("trying to read config from wrong repository instance");
>      +	if(!repo->initialized)

$ git clang-format --diff $(git merge-base master HEAD)

would have pointed out the style issue here.

Will amend while queuing but it would be a bit before I can get to
this patch set for real reviews.

Thanks.

