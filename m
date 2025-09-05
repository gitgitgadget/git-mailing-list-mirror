Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1436998B
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081726; cv=none; b=HjfIg94Bhv+XwBRAt3N52UJDz+UqmVxK6kHcUglQv7P3zS1jJkNgZnj52kcr//rWdwq61U+XC5VJHA0tIYkFLk15hNxMA524VsY8muZGuMje6rD++SGDM4LLDzQBOGFiXWQvCsdOV/8Y7iJAZrV9eEJHJxHbMBlx9IEQTe4H5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081726; c=relaxed/simple;
	bh=gDS2p136IVsm13CJ5iGCAjssdFcuDfRMbMLqYXKAG6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7bO9Ls56QqqnjwAPWvDz7ozgZFIQeUBbAd4dZhXGxLFfZC8wjTaPloB+6VllnyvJwwIfvXLAo7ARrPvTOezu3mbrKg1z6OnXucrCXAXXQUzCMal/umddW/CRkhPs+zTFNOD+rzq0Hy1dIRvtMZzM1J2n546L98Dhk2n3X/yG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a0pCb0d/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlsnmvVk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0pCb0d/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlsnmvVk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BFC3140030B;
	Fri,  5 Sep 2025 10:15:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 10:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757081722; x=1757168122; bh=MmMTUuqC3F
	Pu4w9tYusuhmGi+2UjyrU7Vc1Uq20p0HU=; b=a0pCb0d/eCsCzXyU3Q4hw3eHbE
	lQQ8WSK8uc0MJbQ8gstqNsUUYewHfQW4LuHUNs7eYDvktL5uzpA/ZyOfSm8lA11z
	0tPzySFXA4LIxHjHPBN6wnjG/Qi3gBcWkBeC3uXzRsf6Ze5aWX60gHuUJ33kJ5z0
	wEhMki/s17O9XIfw8UE6EOOWw4n8MoNtSJmm4tW6rLy2nY876wbXtdfTawYiOjm3
	BmhT8x0hK3sG1wG+5wag78jRfhqt92FgAFmM0Jn0ezww6dfdcZKwbtOp/TsyK1y7
	HAruoJUFVivvArP/9/wA+S1CXIfx077g5B3x7LquiJmC4DlhPd21yb4N0QeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757081722; x=1757168122; bh=MmMTUuqC3FPu4w9tYusuhmGi+2UjyrU7Vc1
	Uq20p0HU=; b=GlsnmvVkpCYwXUvlQCjOlubweqTuSbH1NYOATRtYix4rCgQRhor
	cm7R0r1HFQDkXMR1jLjj6aTGxNooJtY61JP24ZEDouJyHyl+JshtcjSzhoh4gEKd
	orkXh0mt4AS7jhG7hwyhZHRHHPV2JHs4j9mqrjRVeNL5+dpBCT7bIv766BZqFVEj
	LDkAAdJ9Mgk5X1DF+ZsdsCHXETbOWGXSHf9B7UK/lceFYNdo2vH/SuHx7aEEj5RR
	dQRqGAR+5Q8tBRzNuKMM2i0bzkDVzTMxQtRW3u3IAKUEe5m16mAe+YgfAtH9aieQ
	iN48+4SoWVjUyU05TBFzvMb/Y7xHREez6Xw==
X-ME-Sender: <xms:efC6aAUiKuIxgmK17MzGTaOh3t1CWXhpzSiGNyGpFGXVLO-qcCnBuA>
    <xme:efC6aBfPOmDg8bEpHRGjYgdZkqea5El8libIbJ1debW6X3UGAekvgXwvmwGDB1uVR
    sozuFdPsZuw5sB9xg>
X-ME-Received: <xmr:efC6aEKM2bfOhccUD89-bn9KRxbbUEVjlduNKhJ8OHw-xl3_Rnorz08PavN3zSgn1SvUab6Doo6Q1Cm94I9lcPTs2zmmH_9k_4bKXw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeluddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghr
    tddtudesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:efC6aOwz_MVL4-l7zjhXvKtnqeembJpDzm-cYA3x-dXiAayTcKxbPg>
    <xmx:efC6aKvZOXqd66i5V8XQNEECBfWDhglYN1xC6fUiw0RTfoYgMtbn1Q>
    <xmx:efC6aBBM3MBdyuggtmbJAt1BQawcVzAHqpGbaA26U6GkTe-Ax41mJw>
    <xmx:efC6aMGproDR_ysl1Qo4zSTRw1pbKzIjj6SoOd0au1zd06WBKFogNQ>
    <xmx:evC6aCVkOc8nDUgIYJ6XJHDDkiwHMjdtO0nKdmlxddMSL5PBcmHdR8RU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 10:15:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,
  phillip.wood123@gmail.com,  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com>
	(Ayush Chandekar's message of "Thu, 28 Aug 2025 03:01:45 +0530")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1752882401.git.ayu.chandekar@gmail.com>
	<CAE7as+b2QKcPVnyEupriK54bMSSxdRAmSrMZqTvfq_KabaU-Ug@mail.gmail.com>
	<47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.com>
	<CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com>
Date: Fri, 05 Sep 2025 07:15:20 -0700
Message-ID: <xmqqv7lx56kn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

>> It may be good to separate the two things into different steps:
>>
>>   1. Move the globals into the repository struct, but only set
>>      or read from the_repository->sparse_checkout[_cone].
>>
>>   2. Replace the use of the_repository and instead refer to a
>>      specific repo. This may change behavior of the feature in
>>      the presence of submodules with different config than the
>>      root repo (tests before and after will be necessary).
>>      We'll also need to update the_repository during the very
>>      early config parsing but then update other repos during
>>      repo initialization.
>>
>> Does this make sense based on your progress in this space?
>
> Yes, I was able to do the first step, the second step means that I
> have to pass the repo struct to quite a few functions.

Ayush, what's the status of this effort?

Currently a topic by Derrick is built on top of this one, which
means it is stuck waiting for this topic to stabilize.  Should we
ask Derrick to rebuild his topic independent from this topic and let
it graduate sooner, and when you reroll this series, you'd base
yours on top of whatever the Git codebase looks like when it
happens?

Thanks.
