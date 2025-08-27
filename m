Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D42BE04D
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313043; cv=none; b=pi5Hkiq7gxYYh8x2YvFJWLrr7JcU3vYz2RLe22rAv/w0kAWco1dpJ3zhQDJwarlsNIDnsOk/KUmD6IzoBdmGM2tqMbF9wDp+GvGmFnV1j7rGTKqZsDGUL0vkYBFO1WWTnScEvsyhCVxa8o1jh3le2pJEzh8gCmUTOfC3Cj1wXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313043; c=relaxed/simple;
	bh=hxdbrOlG820iCVNB5iz7zBTayesDohGGsfUaMD/H+To=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7H3/AfKdyVrZYbdjFIALB7eAkbjL6hc9ETAeIC0L5q4ZKWcZ3o9T8CV+5hlGxvLkdF81RbLOA4DGS/UtzFvBhrsGvTOkVKalafaor9FhMCe22Di1aUBvvp6jZIBKWghIVoYR7p5kZwVFRc4/45FsI8hp9ORiyBRI7w4TqtCYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dLeq7Lyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2tEgpDs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dLeq7Lyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2tEgpDs"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A8652EC03A8;
	Wed, 27 Aug 2025 12:44:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 27 Aug 2025 12:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756313040; x=1756399440; bh=1dckao2afM
	2RN9jvtDSdIX6bAKrIu6ZFM2kHOARGBAM=; b=dLeq7LyzGE3WaTwNbcANOV/q7I
	5xCJNEhsTlG4HtJYS94opX1Ezh3cdDFCuOKQQ/sWlqoux7jNUkDBpxXamigfvkYB
	yGopLBMHHkREM2xts2Zj7F+azNd3SScIZnU/octQHtkdGgbys6y38ZMvZh3/13XL
	vnoD8FMmWMT/cXZTJ5H+7j36TAx53zv+P5xx84RWjI56PowQEFrMAmoStbrWYxGK
	5CV+U3ViUAXBGXfVUUhUbmDqLV9E2Y4sw3AtrwavJqpmf8Kmdo3wTwX4obHxo+/l
	znl2y9PUcruTBKwQH+Qpp4Mp0Uto3w1sPM3Ru5WsJIkL+nPDDfNffqg9SMVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756313040; x=1756399440; bh=1dckao2afM2RN9jvtDSdIX6bAKrIu6ZFM2k
	HOARGBAM=; b=U2tEgpDsob1EkqL2xhwIueXUbsROvm3Q8vgvN5PrkZs7hHW51xc
	G3aPhjM49mMmSgQhDjMjdRmtys93v+hd9OaXQD/pxb1/xczQiZ+/eY8Rs+9zdZnA
	2JjoNvuDSUZRoGoKt5ImHfAhYnnb74cV3VXL/zEFiiFHJoju5CmRetiAM3cyJo8C
	sYnWmWXN+mSnektdAyIGwFwt8cpn4ZZqGJ2q6ocvsuQSonBEs18CiWbgyCTDA1JH
	7XVjl1Baa4L+U53aalzc9K46NjqIlCTiOGtBNBaeQLgFB5lkt3XiAPasbHKpH/Nc
	Q1kMclaZFjlBR7ZytgQzefPPhcqyVkEDphQ==
X-ME-Sender: <xms:0DWvaNR1Xw0RNmTrekWsOQ2Dt3soElDa-tPfMDFhsmrm5ShirD79Kg>
    <xme:0DWvaBWx21rsweCtZnFoJufsv_gcJplAkXdQX6IEzeCS8mevG9zkYc42q01dD4-Ke
    o2fWFxF3mXF1Cc-7w>
X-ME-Received: <xmr:0DWvaPZRH1-3oK6sHJi0MyE_ESEV_a6rPlKXFutnpAhYU6pqtKJvDh4t9qf-97h0dT31HA9vXmcL860sxxSBHz8KibzuJiyUa533RBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:0DWvaH0fAjQ2kHTZ2m6FobLt1yQCAziBH7KQ1vqj2JBrKQ6FtFQI3Q>
    <xmx:0DWvaBgEBMlb9Vg0ueMbv_0zYbtDNWAa4Rhx-gpydcp1VNFwXzjBbw>
    <xmx:0DWvaLZhblBW6YLHpHSYMDLvDKOzdVe_85HlS0f4EKJYB84ge1QKZA>
    <xmx:0DWvaBQFvm1xr6q0J9gJpvbUCCILJd2oX4g58pseqlX9Xa7SwehAGQ>
    <xmx:0DWvaMKTSAQvPQjT0NrdKn-qQj5y8F0W5nxJapVNqraBAKw74tK_9Pxf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:44:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 0/4] you-still-use-that??: improve breaking changes
 troubleshooting
In-Reply-To: <cover.1756311355.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 27 Aug 2025
	18:29:45 +0200")
References: <cover.1756311355.git.code@khaugsbakk.name>
Date: Wed, 27 Aug 2025 09:43:58 -0700
Message-ID: <xmqqa53k3eb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Based on the recent i-still-use-that reports about whatchanged, improve
> the error reporting with this command in mind:
>
> 1. Give more possible actions instead of just (only) asking them to send
>    an email
> 2. Hint how to replace their git-whatchanged(1) use with git-log(1)
> 3. Minor documentation changes

Nice.  Especially the attention to minor details shown in [3/4] and [4/4]
is very much appreciated.

