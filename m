Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683505C96
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312462; cv=none; b=MqfwFP1f4VRy9zbjpDeYUvoYi6SfTlmB6P7RN+szKGMUt4Gz9HqyYa4KTU0s4gsOSgEsR77EXUsnary5wv7fzkneFDyupYqY0AUitZI/YYPz7K723K+iWYJF7L0ABkB/YwwjXB1Z1MBLtovoOhUOWTSRAZJffltb+M95P4voDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312462; c=relaxed/simple;
	bh=UImI6kM88FR0txy2dS9ZDrWuEvVq697l22yyLCaB2mw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BS6VWrwr/dXEJE6BiLuHaKL41VCYl/YQOs4vRzb9ZQ8s0LJNXLMIshbIy3BJFWJOqC0LBI50WgacoQnf08KHDsGM3qCk88Z+0K1WeenbvkgztUDKUtrge0TlYsQXrPlRNpCrh0DVe9aXWOd7rV1HLRadJKc4RRRnhZ/vxpzouxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=umfMzZMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImEJlzF+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="umfMzZMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImEJlzF+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6737C1D0014C;
	Fri, 19 Sep 2025 16:07:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 19 Sep 2025 16:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758312459; x=1758398859; bh=W4vN9XUF/1
	HNLXRZhUBotgajH53JE59tXnL0t/PPGgY=; b=umfMzZMAaScSAjeJERqpT/3gs9
	ZjDi4acojtfSm+pE0Jv/5ZT4dJtQEOp143xbOYquyfMxavqc9T1rn21OBN97GWfd
	wYSjrSfKfB30n7buZZVD0VHf4wptWFHYlHvrsBa1M3eT3jZGSeHKt9CYW1oz9DZ2
	PsMgFt25r3bjLx1D6JwK9b+EH5SL0ccSsYL/B++UR9COkdvq87eGovbBGpMD+EBB
	xf0se1I9BWuWAZ+6N+VOsDaae4ypkQ56RMzOAbcI4YN7QY0wxLZQNXjPn3PnTdMN
	yB2OZAEfwtXQnCD2uo0UHeX8L2XiNC0JGr/7ZouwZU4/pRuUikMlZS+C8n4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758312459; x=1758398859; bh=W4vN9XUF/1HNLXRZhUBotgajH53JE59tXnL
	0t/PPGgY=; b=ImEJlzF+NbHoPeGSpcP19mR3bUYlZjt8HExD8A9PgZ8zihJBM3Q
	CA+l6opX9QGarwAwMKGawHtQd/FrwrpQDeEnedMlCmOHyUAWvPCDaxjp/p5H73IQ
	YKmcbu3/+Phda6AteKWWtxmTTH5yV+AQDxpf1xaa0hbbpGU6C6brkLj89v+TPD6j
	5wZH8fWgf8uFqObuCg617fTYE46jvosWvb0NwmS5H20Elrt8Rboqe0HXCQWkYVeb
	2feghmSkgZ0lrglqcKpDsFAU2Xq4IRyJBD6PMN7RJgIWBmeu5wf3Of6NAQGLWhhR
	BpkWZ0orjytbV8GB1uwvgKwzUmTpmjCm5GA==
X-ME-Sender: <xms:C7jNaKaX7VfgAKCKgWpME2YkFjXHK45A40UOG2rE6lqn7axkVL5ihw>
    <xme:C7jNaI5Ig0q25v8YDyUlFCdJyNemXh4qCArCV7cUrTLd6viuXPEERGvsXxNHG2Z_N
    j1RnquiEqK2G9bcmw>
X-ME-Received: <xmr:C7jNaLainjlwfcsaVG_KQJf_ETNiSE-JhfGTTkijy6pIcSq1Cv24v5tlys-A2xvKRwc1sI4Jvx4gvOshsnv-8UuwpYWvv8FqHuUOqSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:C7jNaHiImBfoLMmK9X85Ju7WbJuXpg0xQ86jCUjWmAJi0ad9-bclfQ>
    <xmx:C7jNaM9EKvmiKAh9-PZoFGdaCb-2v8blOyxl1YWJK1GpHDfBT5KCVw>
    <xmx:C7jNaCqO3ldVQk6c15vPOHWpxvz_lEr_GMQgEXOFYxP3INmiFLMr0Q>
    <xmx:C7jNaEWFpc8C5jfAJZs1gBFwYwYZI1oXILK6sDQg698NVjNQ9V_ftw>
    <xmx:C7jNaE3_MSGJOkbbimAfQyJt1cEIgpJFJXLuPUq27-NXNqtpPYurjrzj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 16:07:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
In-Reply-To: <CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
	(Ezekiel Newren's message of "Fri, 19 Sep 2025 13:48:18 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
	<CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
	<CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
Date: Fri, 19 Sep 2025 13:07:37 -0700
Message-ID: <xmqq5xde435i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I was trying to get the rust compiler to link against libgit.a. Both
> Meson and Makefile produce libgit.a. No changes were to meson.build
> were necessary for that to work, but but with Makefile I would get
> errors like:
> relocation R_X86_64_32 against `.rodata' can not be used when making a
> PIE object; recompile with -fPIE

This sounds like a workaround that is somewhat platform and compiler
specific limitation, at least to me.  Does this need to be conditional
and if so on what?

Thanks.
