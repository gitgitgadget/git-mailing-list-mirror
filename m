Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450F42AA6
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150822; cv=none; b=LX/ZlC8DiIGgnlEqispUbIW6ZcIrR/YDEQsyUdlKq4U14LAB2wQ+zVG9oYu/rcyzNnMomgq1Sh16f6DZ87XYg5c1TDU+stXYM1Bi5VwJ9arJ/oHPF1ZoV6kAqYX/ENoUkkstthJFdfjQIbfVICeNReXPc5V1S7HCL+NxNX3PtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150822; c=relaxed/simple;
	bh=0gMe6Pr5rdMr3/U/7B7egtB9q+vkDF/OWYcHlX1dsMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPNpuSgRMC6kFJMq3wNhiaF+W8iC1WWZzLpZCSrPiarcPkdVWY+yAuCsf4nQB31CsrDo6T0be0OdyHnjypCmamlJQP83X3MBUSQi1IGarhuv5/j0ZwdaiHBWSfr841CErO3L2FJSnpZH8QidQv/z0fzpIlIYcrpDagy4aVuQCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hUydVTIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JOMG/17Y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hUydVTIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JOMG/17Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7433EEC03ED;
	Mon, 25 Aug 2025 15:40:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 15:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756150819; x=1756237219; bh=6jeFAMJkbw
	8xiH88DzSCJgtDLr19a7P3zlI4MLhrqbc=; b=hUydVTImIQV9aUoDKKA1kOHTi2
	WUnSDjhVqwh57xgymeqeDPP0lveAherEF44PJw4fUXn4XirjefkMIlWGDJBxobFT
	b7v0DZWrMc0JLL64nSbw0xkOHogQXI4uxr+vDvawtXP2NZgzEVlA+aPfOnDaGrMX
	xUg6zN9QuX3di/2o2Bzm+aniez0O91d4gPpiYlhuzgLPjQsosk5lVywMRkS7EuIM
	3xdnVob4HWcKyMVD2K2ZOOhx3XF9vwzguew4MFK504lFjotGHMGodEqNnvVR3byI
	ojEWpN/3feS2XwZ4BqdtWEiAUkJsut2GViv411AuQqlkw14Z8LoipK0Noi+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756150819; x=1756237219; bh=6jeFAMJkbw8xiH88DzSCJgtDLr19a7P3zlI
	4MLhrqbc=; b=JOMG/17YGqcYB5/3+V5dA6ED63qOp4vECHiW5GGPO7NsJxjrZAJ
	oa7zHqmH/7sp+/MX5MbCEOrUTnI5B64Wqdp79OAvHEvloRM6xvN7/xwhVTiffVDU
	X94FY2CZhSjWOHmG3SyZLlRvqsOfj+iXOgQBMVcwusBM3MHOByjK012fBZkEUuCb
	e7zs4ZDG12lgzUcAE6tyvLRWWSGXIsb6ZIjgign32mvU+GxZXC5WH+T9/GN7ZUJQ
	M0jDA7AFDSvu65lGxE3c4MG55Y0/5Qv5/nSt4WoTDqo9QmiGlK+FV0uT3MOSOKMq
	bel8xtay1Gj2GgytQowshcZiQwJfsz697xw==
X-ME-Sender: <xms:I7ysaMICyVR4DBubmXaDs9Ss0rWnaOccSX_jFJouz_MFWcvnZ5yUww>
    <xme:I7ysaPaAZq10nt-T14U3ug3b0ExfUD8uADZciREcPTEv1jla34sNup37Caqjr03ss
    fpewHf_Gx4qOcpmSA>
X-ME-Received: <xmr:I7ysaGJwFAxgsh2vxMzWwaANct3sSKlvEF05bF7kYntTACb2GYspp_aviG_9TIFybxeWzkrp0yxwUSvDwNUAroO7jiDV9CXycHLVBV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvnhhgugho
    tgesrghlihihuhhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I7ysaFBhZYKrZbwFdhwjmRzrNie84DZmhu5Dfmmhnj-BsDxv7wOVqQ>
    <xmx:I7ysaDrQ6bqs6Bcg7WaY21t_-NDWuIuNCwWDju6HWfuDxryF70xGvA>
    <xmx:I7ysaIjO7FXoUvbr8qjZrDAHPgO87KLnBakQabom4FBpLoGvXjX1wA>
    <xmx:I7ysaIDg8A_90stwHkyKfTlsTPw6y0BPplJzUPPRkI5DgPRQmmwXNg>
    <xmx:I7ysaHdLXOQ6mgjjIFo11qOIx_uCr-kYwtAvx-R075Hdj5_-v5OowPfa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 15:40:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "engdoc" <engdoc@aliyun.com>
Cc: "git" <git@vger.kernel.org>
Subject: Re: [RFC] Allow includeIf.hasconfig to take precedence over
 includeIf.gitdir
In-Reply-To: <a903afc8-9bf6-4ba8-bdab-87a76adf631e.engdoc@aliyun.com>
	(engdoc@aliyun.com's message of "Thu, 21 Aug 2025 12:29:57 +0800")
References: <a903afc8-9bf6-4ba8-bdab-87a76adf631e.engdoc@aliyun.com>
Date: Mon, 25 Aug 2025 12:40:17 -0700
Message-ID: <xmqq1pozqjfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"engdoc" <engdoc@aliyun.com> writes:

[administrivia: please wrap overly long lines]

> Background:
>
> Currently, when both includeIf.gitdir and includeIf.hasconfig
> conditions match for a repository, Git always processes gitdir
> first, regardless of the order in the config file.

Is that true?  I created an empty repository in /var/tmp/x/includeIf
and added this in its .git/config file:

        [core]
                repositoryformatversion = 0
                filemode = true
                bare = false
                logallrefupdates = true

        [includeIf "hasconfig:remote.*.url:*"]
                path = /var/tmp/x/includeIf/.git/hasRemote

        [includeIf "gitdir:/var/tmp/x/includeIf/.git"]
                path = /var/tmp/x/includeIf/.git/Here

        [remote "this"]
                url = .

where hasRemote and Here each have a single line

	[jch] included = hasRemote  # in hasRemote
	[jch] included = Here       # in Here

With that preparation done, I tried

    $ git config list --local --includes
    core.repositoryformatversion=0
    core.filemode=true
    core.bare=false
    core.logallrefupdates=true
    includeif.hasconfig:remote.*.url:*.path=/var/tmp/x/includeIf/.git/hasRemote
    jch.included=hasRemote
    includeif.gitdir:/var/tmp/x/includeIf/.git.path=/var/tmp/x/includeIf/.git/Here
    jch.included=Here
    remote.this.url=.

Notice that the multi-valued configuration variable jch.included
gets hasRemote first and then Here second.

Then I swapped the two includeIf in the .git/config file and ran the
experiment again.

    $ git config list --local --includes
    core.repositoryformatversion=0
    core.filemode=true
    core.bare=false
    core.logallrefupdates=true
    includeif.gitdir:/var/tmp/x/includeIf/.git.path=/var/tmp/x/includeIf/.git/Here
    jch.included=Here
    includeif.hasconfig:remote.*.url:*.path=/var/tmp/x/includeIf/.git/hasRemote
    jch.included=hasRemote
    remote.this.url=.

I do not doubt that you are having some problem, but it does not
look to me that your description above points to the source of the
problem.
