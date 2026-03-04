Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5536FC3
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647854; cv=none; b=pNB0PYd6iCQFx8yqpR1OwTfKL3hKafUKZJUn0c04WLOE5H9lTZF3hYDP/d4z/0tYnNZ2sdJZuq3qojCmpOWmS3Z1loVxw+kEOZhyQOc77C1P0PwNUHhYDJJ9AqsaWnNXrhlDvh0NPjeOPDy94GH+GlfxkBcIDNk3HrxGjb0UFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647854; c=relaxed/simple;
	bh=RjEhWi5W3WnlbfUR0CSEprI2mltaHXPyHE+j957xQZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ruKAd/L4n+obYh50hmIRpy3pyfrJz/aN0lpa/7nKcjUU1F7UnFLDhhIRJZ2BiNIcXjRb+DL+7w6YMus2wnHL68Wyza980IRGco3xGHVEZImF9DoOsKHx2WyybQsL+990EopmMwx3KDYTwh0IZLhj60DsnniY2rrkUSL49PJbOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HQqVr6ku; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uS5hJmap; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HQqVr6ku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uS5hJmap"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 356947A0230;
	Wed,  4 Mar 2026 13:10:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 13:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772647852; x=1772734252; bh=iJ9fCd0ZWf
	ilXYQndZ8/12Zk+c0XGkyZVMofBXXG/Lw=; b=HQqVr6ku46aonQCX+d8tvwbYpT
	iW1AdjYlFGfZBzNcATEZAz9UW7FTJ88l+yeB/HdUfgroX7CU+CqUKThXXufPOE1X
	tFjqaJzkgLotn3Yqf4xECuWJxcBlCC0Ixsgy91i1glwUkQhvcVO+tHyQaHXx3sHu
	mgDjNnS2QZu/LyjDMTe1aREfeRAAkFh8xNmTBwV//OSCC3PHhfaKV8cbfJyc0Rst
	XD8yV9Oguq0xp3O90ohk2pHHjYZW3jgHgMbmqMFytp0hknogwpCjrNugc7fTyGum
	IfSSXLwqh5jYTj+i4QE3gWAHltXlK9CyNPm6T8lFTOMtnMizOQwx4DgVrEpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772647852; x=1772734252; bh=iJ9fCd0ZWfilXYQndZ8/12Zk+c0XGkyZVMo
	fBXXG/Lw=; b=uS5hJmapH/zhcDJfOOzQkgmVOOXzhLLWDAllutSx234CAvaw+E0
	g9ggmfJRC7c8ycmXXRaWnnVR9HE+CudTjho5cT6ZmNiNVjYq6HzU9/+onJyddIdD
	8SuW2HGbv8iTVfEHux4wsmpVy0QjTCgYA5J5H0MEZhF8ugpDqx3ae0xYHiBhNxVl
	km5mnqwJCicJfkMaVmlgf7MAixPiohRohwgRw6zkFM23M0Yt9FazbteOVE7brGDg
	StpInJANC/7zb+aN9SdaA2gibVsZ3lezIdvUEn0na/pXhFgenzI+YW3ed0GKkhKs
	Hs6k+OwLvCfP6JPNEvfVvtGAC+g0hG9IqtQ==
X-ME-Sender: <xms:rHWoaf2Z_GkcKKqmd1NB5aD1kJUm1qqTJSfEKh6XF135bci8wBZewg>
    <xme:rHWoaVjW9B_GDYBtCQpLgfUXn91Bq9FUY3FYE_KD5uRN2iEmMvgrIqH1ErFdrijMC
    xxKidVHznofRisJrBvV3YGwhOlzNSYiuUL1mBfIBOE776epkYK88j4>
X-ME-Received: <xmr:rHWoadRbcLGehiYmiZAcHERnQQA87cbBuhSAn8uux_3ln_oiKujQdYn2ZHtZCGXvAvQLNZTy4-xMu-6fiBHBkqeRoSwnSpWN8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:rHWoaegUkueUZhOyMYsv_nlWCzHa9rpLNhLEALcS_fIUhqhPSc2XgA>
    <xmx:rHWoaV7SPLgpFPFiTiM29e39QSVIRF_W9V5N5o2ZA9lw6bv3yGm8Hw>
    <xmx:rHWoaTCHH5SqQR9EaQgH1RpSiRANPmB_6vV8IsGDRpsv5sUsuAY4QA>
    <xmx:rHWoaUa59BLIYBNg8T8xuiXZ280NdoEUh0eyD6-PnkIKyLeVXXZlvg>
    <xmx:rHWoaVpQ0r7KgSE5kF3I6yX_1HGl-a3o5za2-g3NmI619is9nSMyTOVO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 13:10:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Makefile: deprecate autoconf build infrastructure
In-Reply-To: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
	(Patrick Steinhardt's message of "Wed, 04 Mar 2026 09:22:59 +0100")
References: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
Date: Wed, 04 Mar 2026 10:10:50 -0800
Message-ID: <xmqq8qc78nyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> roundabout 1.5 years ago we had a long discussion that eventually led to
> a rough consensus that we'd rather want to get rid of our autoconf build
> infrastucture. This eventually led to the introduction of Meson to cover
> this use case, which has stabilized for quite a while by now.
>
> This patch series thus starts the deprecation period of the autoconf
> build infrastructure. Target for removal is Git 2.55 for now, but I'm
> very open for discussions here. I also assume that depending on feedback
> from packagers we may need to adapt the timeline.

I do not consider autoconf a thing on its own; rather it is a mere
extension to Makefile based build, isn't it?  So the declaration to
say "we favor meson over autoconf" makes little sense, at least to
me.

Asking which between Makefile and Meson should be the "primary"
build environment is a different story, and the question does make
sense, even though my answer may be different from yours ;-)
