Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FA1F1302
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216123; cv=none; b=tvw0hWCvhIZ7a6DMkZEracFSRe1yc9zOPfDLTqkQt2vOMLSOOQU9/9WiPkkEFcn7Yh6W4desRGJms9JpQnppuoRtS++gFFt2JlTlfmGgzOjv2l/Rlzu+Jidl5M+PGpepNP4ShUt28G/wzPmKRTch27gmoAbFzxtvNxMiGlCTTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216123; c=relaxed/simple;
	bh=LrBTQgpVQF0r8TO5uWXkEGqkXMTkhFzza58S7WkxkMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oNmx9gV5s6S9x8udo0aYRFM+sHfWvOm0dKoeX8Wao5CxZC+mUoDp/ZtDEYFqDMdOy/Pzhop6z9h0pYQDKIO/DxX7X+glqYgsdH9Gktf2X0jmpN7M3Qa+jh5Pe+jH2Sb3AHVQ2jcb0Z44J5E/dthK32+e8zXnHiKecwqNCK65/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b2wf1RHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNV+JmaF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b2wf1RHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNV+JmaF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C64651400597;
	Tue, 22 Jul 2025 16:28:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 16:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753216120;
	 x=1753302520; bh=Oc8Wp/Uc3qKHdgIyI9LgbOpHviP3mLpahI+W9LfkZO8=; b=
	b2wf1RHoBpelT+s3SvTtO6qm8e6cVzFe9vAk06A34eUnyuX0a+bYx3EoOMswOqMM
	lBKRk6GaWKENrJxPS2PLd0f4Ac3oaEObvRzmg4tJ2U+PX6f6Ub9270wAbGVNZCtz
	c6OVdPqqqsd2dz1rLzkCEIbUj51qNpDIGiJGj8WzGOj25WPe0T0NedLQGDvWsZXg
	xgt9e3qcS3hnA7KyTmEFqDn0x+aRm9Dp9eGpv7ldP4xryyWETk9TvGdctE4sGuSk
	c1OEl92/QO4T9uL/zLN/URKy9yYRIxORCWDMRBz3u2RN/Qgf2iYqRsNriBu5RcX5
	+bC8A1Zk9s31ws63Y3Yttw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753216120; x=
	1753302520; bh=Oc8Wp/Uc3qKHdgIyI9LgbOpHviP3mLpahI+W9LfkZO8=; b=D
	NV+JmaF8zjQv3vsHVRc8SoUkh3tpZfWOJncDGaYpy5EXref3CPbLXZHqtJs977+k
	ePyduKQoA8PXyTF4yXt+5I5VxpGFUSUWcLKaQEokiVfkHZy6+I0zu7gpPiuaJSbK
	PxfpcSjQYvfA/SUK9qWHyR7znqTMLlSc8gXpTA4Ofu8v5Ip285z5mF4ZI1PY68Y/
	bQ7fA+iPC8xkIJhQOsD8sLC2RaMIuBfsVvK2hwMds1AoNfkHaVh9FbeS/a7KQQKb
	BPHAO6ZD+KY2ie+/W0PFHkBifobrKjpqIvO+ITSpfgj4BA/oSV7SFV/GjRdjZ/dq
	2xLLCNZFK8ocJe73Xfnhg==
X-ME-Sender: <xms:ePR_aGiQWfyJQxAbJdkdDRQwHQVHAtwCjK2IUDAFMoZLwMxiExlWNw>
    <xme:ePR_aCh_0twrtjtiQuuMzrUrXkv0CrPw7P0rNLyYQQWZ69dZ0T-BnCZk-AQJHsaja
    ru_DnOu5c9KuWxn7A>
X-ME-Received: <xmr:ePR_aEg-X5JcvNmh1UUiK02zImuwAjwHaRTq4bK6WoOzi_9CfRuXc_wef2ogXWDu_BGml1tqevKjqEh9_BOwhw-euQEnZZCYBXXW2aM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrshdrsghrrghnughsthhovghtthgvrhesgh
    hmgidrrghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehfshesghhighgrtghouggvshdruggvpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ePR_aKLx9_NB93JA-iCRv6GgeCOyTGBDxXhGsNpd9U-hJiE_vp32hQ>
    <xmx:ePR_aLHH_eSiTFVc47NQAPFbmO_XzUV8yaUid2eA8zy9gHD_9e5pGw>
    <xmx:ePR_aGRU3GxKZcCilJeL8wdQQ-TUk668v2FdCHkCEPKLUKyQDQ0dgA>
    <xmx:ePR_aPcHQ8lowHdjfvepCNpr_cj5WY-BvSryhgTq7kyuLlkYBakp6w>
    <xmx:ePR_aOt3JAOh6SSOA3nHRbmq66hLBdM18Uhhnj_fVPPvhJr4_yAq5v18>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 16:28:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas =?utf-8?Q?Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
Cc: git@vger.kernel.org,  Fabian Stelzer <fs@gigacodes.de>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/2] gpg-interface: expand gpg.program as a path
In-Reply-To: <20250722190922.51183-1-jonas.brandstoetter@gmx.at> ("Jonas
	=?utf-8?Q?Brandst=C3=B6tter=22's?= message of "Tue, 22 Jul 2025 21:09:20
 +0200")
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
	<20250722190922.51183-1-jonas.brandstoetter@gmx.at>
Date: Tue, 22 Jul 2025 13:28:38 -0700
Message-ID: <xmqqh5z4rmvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jonas Brandstötter <jonas.brandstoetter@gmx.at> writes:

> Allows users to specify a custom gpg program in their home directory.
>
> V2 adds test cases for when the gpg program is not set as an absolute path.
> The test for gpg in a home directory feels a bit wonky to me, because it
> assumes that `~` is an alias for `$HOME` and just overriding that variable
> with the test directory. But short of creating a user while running the
> tests, this is the best solution I could come up with.
>
> Jonas Brandstötter (2):
>   gpg-interface: expand gpg.program as a path
>   t7510: add test cases for non-absolute gpg program
>
>  Documentation/config/gpg.adoc |  2 +-
>  gpg-interface.c               |  2 +-
>  t/t7510-signed-commit.sh      | 12 +++++++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> Range-diff against v1:
> 1:  b551903c16 = 1:  b551903c16 gpg-interface: expand gpg.program as a path
> -:  ---------- > 2:  ca22bf2ee6 t7510: add test cases for non-absolute gpg program
> --
> 2.50.1

The first iteration of the patch was merged in the 'next' branch
long time ago, and then to the 'master' branch already.  It is way
too late to wholesale replace the patch from the previous iteration.

It appears the first patch hasn't changed at all, so I'll just take
the second patch as a separate, follow-up topic to add a missing
test for already-graduated topic.

Thanks!
