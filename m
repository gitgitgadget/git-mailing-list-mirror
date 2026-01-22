Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7569325496
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105986; cv=none; b=MenKZoxewZSbXIrIOd7t2WXoNuuZgm6T9x2cs5VvH56GPBU2Yhs6DdYLDoSO1M8tta1UZvDHzn/zq1lHla0R2tilbDMOzx3rJG7hvoukW5KPnY1IRwgePa1o+XF00R6BmSHZM1Uf7ZjuWHG2zMhYse3rw1mqhT6bNAv8wBSAaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105986; c=relaxed/simple;
	bh=F7DhJyHdwT7sjGAAqNVAk5JYuhZplL1v2KG/6oOPaMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3Fe1g5SZqqnvCkCxLUZlQMXYXD/GD9rorLP5Z85SydVAvmVWclvc9FauT5HydD0G7lLDc2GNeRYCUoWN4sk0oUII1/G5CZ58BgPjFc03RRT89FjWXsBxKWDrcWIhei58XtceljkvPUTK6z5YpDum6knd7ZiAMOSsEiKyaHMY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CI68TURM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+JQFPgJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CI68TURM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+JQFPgJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87B8B14000B8;
	Thu, 22 Jan 2026 13:19:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 22 Jan 2026 13:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769105972; x=1769192372; bh=pE5leXGFnP
	N4a+9dLg9KZ/R2sqR6FO2++UFwITlKLzQ=; b=CI68TURM2jswflpeNC5Ylqqw7O
	6eZ7MyjXxPHNL68ZYR+un8TJApySij+r+oG8CFNQG/pX0jOLkM2WfsZldhPIj/Ig
	6swc5cL7Kl1MgjXgwPtYb3l6JH6riJAdg+Iq1uLDcmmumAQ5zbDoQ2Kx1mw8ba6F
	Ym7L6eYRTj0kPUWegVOTmDldjFDXCnvDcrtTY6F7wewH1MVJ8KxBoEnZe5lT6ASy
	opQN29jre41xExFkB6BijxshXuaowkQs+dAvqStJYeOgi9XblVTPqygdq5U1Ogeu
	YLdvn5s8xRr44DJJkgAYegnYspGFHJRod6K6axMfEAAlsbwj0mz1cTcs0Xxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769105972; x=1769192372; bh=pE5leXGFnPN4a+9dLg9KZ/R2sqR6FO2++UF
	wITlKLzQ=; b=Z+JQFPgJQl5G3JhxxeRppvwQcPQCjA4YAb4krDPvH1QpPfHzhlG
	ygJdq6QY5kHwf2tB308flkwKhZ/o8RCr7KxlecAulZAaC3QOhwUDkNYTdbeHYXGK
	ZnTYwouEy+DIgTFG8BBlNMVqFkBSfinSH4csfihWFNCCF5xLDFS+oeltBfKf4lf0
	3zhqTbuJOP3Hv0wtEx/MctmINpS/TXDKvZwCR5ncZZ2+UXZCDMEHGLd9xU4lkOui
	KdncmxFYTVoEhB36vCcGh7one7OdoO4gWSUjPOVJzICyj5d3k8ip0ayNjZVYp7ZU
	nmCIxkPS1P5ZDJ7WWboutk6V4obqy87wkpQ==
X-ME-Sender: <xms:NGpyadkFLDrx0RPTjtqSagFgATNPOUw-2gn7zOwM1j00P_3P7OA29A>
    <xme:NGpyaUUGHockZIwtoC0BPbKYSE1L-NctH9jgPvhcefpj434lr9azKCGlX6rkl6sby
    IAdIswHgojE-BcfMb3XamjHJTuMyG05RT9tciNtlexkJmUhUKyNMA>
X-ME-Received: <xmr:NGpyaaHTp6QU-3cYwor-sv72YYyQ6_H-IwnWqnTCQ9V6ih_DjOyvfmVM0ANvMqlc4aUDLXGu6ria9Xmeh-1hfchPiQsSNDcUb3lHXxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:NGpyaYd-Gc8XOpUjl1Faxo5NqA3ex81bWUuSrc1SkeOkfDe7LunGBw>
    <xmx:NGpyaTKD-M-v4TpBoK7WvVkG6DIh2NpR_unnKOMxYOyvDPGq9cvKPQ>
    <xmx:NGpyaVEQAHfpHxBFhT-zy4V2ZmkESOmyPXzlx-QRlWB-2cqjK4O6Aw>
    <xmx:NGpyaeD5zPkGS5Pt0Ftj1RCKy4Vr11h_zrN4rGfFGrUQOnx1VDDRtg>
    <xmx:NGpyaRRYTibNGte-cns9uSfR7Q2O-BiD8_8lOtSuU6YHMGqLqF6xdwpp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 13:19:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  peff@peff.net
Subject: Re: Memory leak
In-Reply-To: <20260122150339.65566-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 22 Jan 2026 16:03:39 +0100")
References: <xmqqh5seu7jz.fsf@gitster.g>
	<20260122150339.65566-1-haraldnordgren@gmail.com>
Date: Thu, 22 Jan 2026 10:19:30 -0800
Message-ID: <xmqqbjilo6h9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I realized now that my code would benefit from branch
> de-duplication.

... meaning that ...

> When
> running it from the main branch (which has upsteam+push = origin/main) and
> my git setting is this which I intended to run from now on:
>
>     git config --global status.compareBranches "@{upstream} @{push}"

... when @{upstream} and @{push} ends up being the same branch?
Yes, if that happens, it would be irritating for the users if we
do not deduplicate.

Thanks.
