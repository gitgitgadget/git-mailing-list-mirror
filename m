Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E32EB845
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081196; cv=none; b=OKE0ASzBynQUBToWiYRY21YzU4jeKpw1icuHy0aZt+MgirAjDPNVQ0FecH5h3+JuBgRmWZf7UttVdy6P0Nr6U9fmLIeKlHU13+BtT5y+Twtp9o7fn83IA6ZImM3clfwENSgT3VTfv48A9NeulHq30SXd5W+C9vLllRPvdgAotMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081196; c=relaxed/simple;
	bh=70HGist7UVHMv/1THxRlENVrZ2H2g/981Mx3KRru8ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PI4t7N1bHTwxUF6QCCRBMJvVG/waTJKrfIbzaV42O3qpIE5RZBjjOdoqIswm4jQWKfeOQBIu7tOy3NERADpnye8YnaTXLqG6bc1eWlEW7CVqTHNsh+gI6iJqtihxGeTOVoBkRGeRrCsTafFw2beHuJvQCHU06YppAGBaRwMS0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Czvnygov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WiDhAdP+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Czvnygov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WiDhAdP+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7EE297A01ED;
	Tue, 25 Nov 2025 09:33:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 25 Nov 2025 09:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764081193; x=1764167593; bh=ctzvpec9wJ
	Up0DZNZ3b1E2NsmljWmcRQtrHf3xXZ03Y=; b=Czvnygovj+Cyg2VeC0Svn0UHfG
	EK+RTyxOZjl7Wu3CmrMRP7Ll2mM9c34+T1FvNOk7MRogCcNBaaWhc3wVyZOz/vt8
	z6iv5WYBzdZqNhfoW/b38qgLbPylZXDxoINiZuVgvxAacwDqMPIIppVPsOvON+4W
	egchm9t2tWda5VXteg8ArNPtP9tTWNHdezW7rMdCt54u0OGKVGbH2e0/KaiimP0b
	Yo2OhoOqcxxs0N/P97iQ5Gy4Nq2Lq9RvdA/2SrB1xGNMIes+11HfnyRuDVvolXNA
	lVp/CPaAm1XSVKN243fBPpDgXgS+IUysahGfVT3NTbumuXG1mN8ZwmNoHvAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764081193; x=1764167593; bh=ctzvpec9wJUp0DZNZ3b1E2NsmljWmcRQtrH
	f3xXZ03Y=; b=WiDhAdP+mtGOPI6/vDmgSI0mZnN60uV+qOw3J1VnEOAO3Ck62GM
	mBxoW247t9kOeb/q0V9TQM4QLLdPR6kEwlLeRqc9qLhExx0UHVamj5AbwrlHG6nI
	OfL3nWHhzK3DvR5PqNTpeF3bkTnDQ7xZ1RpMh7EibrsMF277aa2iz/AK+u/Z55Qk
	nV3J1kfG5grxhMqRTz9QcBQwNTvCPpoHCf6Z0PHqhHq96rmoiyPBE2jt8HzWfd/L
	x6ZC4cHHcUVj1Bzr+fKxNliEVXl91PKaqjBdPBogvp1r/yq7ZJU2KxGSVrQx3eWZ
	J1oLLDrT7EkhMnPvu7Ug9ylG03tC+CLceiA==
X-ME-Sender: <xms:Kb4laWuSfiGNv0CUwYu4844l3E6yelk44Z8gejxiLgIMSi_OOHPgIA>
    <xme:Kb4laSc6QyKYviebo3INR1vcqps8lNCdpU_6M4jPsIUPEI9mfsLRuKoFz17scnhiy
    sB4LG-TYpXN6JbdqD_j6HPDOUBuR61dCRwbU1xXkAZD-cfkc93GjQ>
X-ME-Received: <xmr:Kb4laWzavNhwqK6pwE5h9nS29ERCWvvg1yb0KIvf8ZWhyG-jpp63EJgTL64sIO8rj8WIPRInGu8orousL62PcF06liFrkNmH8Ty8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrgihrght
    hhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kb4laQEWVtHZMYyO6RjSCXOpFj_0Xtd_4BI3sTYcxfTg2lHQrCrJ2A>
    <xmx:Kb4laSx6mU32Qjo51sgmkvL8SlduA9M0tJ8_rP_DwQxkp23F_s-rFw>
    <xmx:Kb4laZvaQgWb9Zq-mLyq0oNL7C0xkojT2dqG959RtLf9cLUuRrxhMQ>
    <xmx:Kb4laX1prcYhwWmCW24m2qiMTtF8NJepJkvaCBnMUesmMQALpD9M2g>
    <xmx:Kb4laaS_JPhE6f2_7n90KzkB6KJ13N96S3isZb8o2Q0LD1z_hMS1sSXY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 09:33:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: Re: [PATCH] submodule add: sanity check existing .gitmodules
In-Reply-To: <CABPp-BES6HBGxXKC9sfBHu_5oBEDYD+aDquHtoDSZtZdaqOMBQ@mail.gmail.com>
	(Elijah Newren's message of "Mon, 24 Nov 2025 22:49:10 -0800")
References: <xmqqv7jacvdq.fsf@gitster.g>
	<CABPp-BES6HBGxXKC9sfBHu_5oBEDYD+aDquHtoDSZtZdaqOMBQ@mail.gmail.com>
Date: Tue, 25 Nov 2025 06:33:11 -0800
Message-ID: <xmqqfra2tc60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> no definition of submodule.<name>.path variable, it accessing the
>
> accessing => tries to access
>   (or accessing => accesses)

>> A helper used by update_submodule() seems to assume that its call to
>> submodule_from_path() always yields a submodule object without a
>> failure, which seems to rely on the caller's making sure it is the
>
> caller's => caller ?

Thanks.
