Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5582D24A7
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554456; cv=none; b=DEqW8Wd+slXJGj6Jx5+LlyFtkDBgDW03Sa5zPnJCeafBHDz0O53PlZx1FhGTor27V7T3nmyoD4UKWAmi0CyU0HnN8N/TjGltKSmxCBtnQjJsn6Fd+zxLDSs1lNkWW803vI7/yTEOYxjpFIo28PGIdEIZBbbvcO5cjY5j1HiI2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554456; c=relaxed/simple;
	bh=MWjfOQU8G05JP0AAKRTXLup5tgzLcUi3fSB8QSdd0Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RV6u5FB3lJoCrOCqy1I0gSQdsgCt9RKuM+VeoB7yjWA9wL7pWeds3yliKaSaYZIzMBwtqgiaHqZ1lmO79783+AnFEKhBP0EZoeQCqAxDUa7aTYZgysxUIoynki/3ZO1ekjkMYH7V+p+oEiKssvoEpz2Qf399XCp+W+s5MrI55gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PqJJ4mDc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjKHGsx1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PqJJ4mDc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjKHGsx1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA71E14002F4;
	Mon, 27 Oct 2025 04:40:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 04:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761554453; x=1761640853; bh=Er1q2Ks/vA
	1TZf85gxusJMbaTVrLhr50n7lmqXHLW7Y=; b=PqJJ4mDcvkYLIIE8GP3mmZN98X
	gSlq5S4qtTVAflPejcmEX4nEl/vb/ED40fL7eSw61pgVN1Os9NR0EalaYDCIRILk
	KnXv2R7Vg+RdjFsKo8k0ZOBaRcT3X7AszA6HEPDXwSKRAtCWmfhl6YqZm0lYif8H
	9SVHtMY0CrD8pa0Pd67iWp9L7PYfo8Km4b3mkEIP9ppMzgdaKRflet0fN7TQQ+mN
	JbIPlAjXOMsrBSH6PJJXlPen2xNClkliQYUBtIAc3TnU5BlR7EuGadES3JpAZKbz
	L1euafTX+sKJiF0miwi2qt5kFyReoj+BtoqV+pTqzGIHKqctkg3vzx9DJ/9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761554453; x=1761640853; bh=Er1q2Ks/vA1TZf85gxusJMbaTVrLhr50n7l
	mqXHLW7Y=; b=XjKHGsx1BSiTgXTVuNRnUSZUeaDWnizQMS+5rIK49YuaCVqw9Yh
	1xaqmWYHo5HTymnveqWfSWvqSlOke53t4wHwzEdAwyzpcNNJyEBQP7etIIcYSEgc
	TCo+BEd/EG9FDLFkID2v1fyhBSrufBKvDHzi/m6sgndaVLNzOUnMuuBrq5XG2AFU
	xvq57hfgqi93jm1v1vQoBNVzMotcDayROLHS2E124O7jx00bo7cRSjrGfpDBLxb/
	pfIn6O+L29i5qW2zJWOCV2qJfZm5nqfYY5Zf0zcgxM2YL9SWj2HnMQN/BBeFOjk5
	/icj0SBKAaSGSjTsouT6SCG/tYTk+d/6P5w==
X-ME-Sender: <xms:FTD_aHgOXDk1EoDnfpXj2Foj9_nt3OTmdusVVugK6M5Z1jR4060s6A>
    <xme:FTD_aKCYZWB21dwcO7UKMVq3b-eiSVsEXGPqYKu5Qr1P9wDRXtUc_ty2hSdzZtQJ3
    D1uFjzTHGO8KGqClYfehJICDXt6CFThc0qmpNMRT0Ki7OYpUzq3Ow>
X-ME-Received: <xmr:FTD_aEuyKvr0NWtsYfDsbu2-fKt7PcxoclCWQScNjMzZ7alGUhZ5slQ0SChOSxizK5OBtzLW3Bben-a_eHoJcw3YFT3bSrURPYUMGhIfJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeetleelleetjedvveeujeetueelgfeutdfgje
    ffffevveehfeekvdeiueekheejvdenucffohhmrghinhepphgvrhhsphgvtghtihhvvgdr
    phhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    hssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FTD_aPaUW2_UURngpvXRj_mNoEgCO8sHeX60MK047ouSC9IbWkY87A>
    <xmx:FTD_aHXuYUIA5ZtQZpba4Hm261Qj9xTTTbkyvr8yJSZl9Rkuhl4llg>
    <xmx:FTD_aD6RYyejE_YQmrYiWXWZv9GTNUjIUSHr_Tvg6SPVS09NSO_Tdw>
    <xmx:FTD_aCg-n77mPV0OK2nUyZn4R7nDfJPEr116WgX1aX60ozqA7TzauQ>
    <xmx:FTD_aK648dMPOaHVwANPLl6587uqoxjqVzvgSoi_Eip_dzj0eaLiKu0U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:40:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96937768 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:40:51 +0000 (UTC)
Date: Mon, 27 Oct 2025 09:40:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #09; Sat, 25)
Message-ID: <aP8wEEZa6_DgdKwG@pks.im>
References: <xmqqo6pun0ml.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6pun0ml.fsf@gitster.g>

On Sat, Oct 25, 2025 at 02:16:02PM -0700, Junio C Hamano wrote:
> * jt/repo-structure (2025-10-21) 7 commits
>  - builtin/repo: add progress meter for structure stats
>  - builtin/repo: add keyvalue and nul format for structure stats
>  - builtin/repo: add object counts in structure output
>  - builtin/repo: introduce structure subcommand
>  - ref-filter: export ref_kind_from_refname()
>  - ref-filter: allow NULL filter pattern
>  - builtin/repo: rename repo_info() to cmd_repo_info()
>  (this branch is used by kn/refs-optim-cleanup and ps/ref-peeled-tags.)
> 
>  "git repo structure", a new command.
> 
>  Will merge to 'next'?
>  cf. <eesy5qhqzi56qrzv7wlpenxag23l2zykakvpmr6p5rnak6cril@ap3rugp44bcz>
>  source: <20251021182601.2687284-1-jltobler@gmail.com>

The series is ready to go from my perspective.

> * ps/maintenance-geometric (2025-10-23) 11 commits
>  - builtin/maintenance: introduce "geometric" strategy
>  - builtin/maintenance: make "gc" strategy accessible
>  - builtin/maintenance: extend "maintenance.strategy" to manual maintenance
>  - builtin/maintenance: run maintenance tasks depending on type
>  - builtin/maintenance: improve readability of strategies
>  - builtin/maintenance: don't silently ignore invalid strategy
>  - builtin/maintenance: make the geometric factor configurable
>  - builtin/maintenance: introduce "geometric-repack" task
>  - builtin/gc: make `too_many_loose_objects()` reusable without GC config
>  - builtin/gc: remove global `repack` variable
>  - Merge branch 'tb/incremental-midx-part-3.1' into ps/maintenance-geometric
>  (this branch uses tb/incremental-midx-part-3.1.)
> 
>  "git maintenance" command learns the "geometric" strategy where it
>  avoids doing maintenance tasks that rebuilds everything from
>  scratch.
> 
>  Will merge to 'next'.
>  source: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>

Note that I've sent a minor reroll to address a CI flake that Peff
reported in [1]. I don't think that we need to fix regeneration of the
MIDX for now, as this is not a new problem. But it's something that we
may want to address in the future so that we don't regenerate the MIDX
in case we know it won't change anyway.

Thanks!

[1]: <20251025191550.GA279793@coredump.intra.peff.net>

Patrick
