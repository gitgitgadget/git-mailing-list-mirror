Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C935F60B
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775240247; cv=none; b=T+tciQuDUqyawD503cJVT6UGn962ErLQ49LmMbP64Z/3+uF0ZhomPO2XSY2Mz2qf227w8sG8de+oG+VcfUdFjHl+YKu17T2+LhSob62wZdi8wVoRFVSQXuBOSXgJjranAzJVH8jtVoyM/lsAX/t7ol6ox2i6i/Ah7y5fEiMLxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775240247; c=relaxed/simple;
	bh=UbJyCPgV3O/IV5f1i7YJ9cwE60HXl0NrS7Bb66l7dFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVo9+uqIt62QbuBB/PMik07+a1lYQmayr6zqF3oOC+hlni81E5+H2VXHTK7v44Qv8fHQ+wwTgUo/61RdEB2NEnR9x6d6NWWjVp4KKiVMOmnHczlPYIWqd9pmJtBxv5lkdTX9FvZtLiz/UOOKnY0kpwxYRkx9TkajwGvXCwRb304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VIohZpRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYRUmTh8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VIohZpRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYRUmTh8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5753FEC031E;
	Fri,  3 Apr 2026 14:17:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 14:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775240244; x=1775326644; bh=4BWP8jatK0
	KE6K2o9Idy5UmMaN/slESxBsqK0PWsE94=; b=VIohZpRliEUbMPDC4o1DNzERrb
	Y+3vqbPYhMyGJ5rwNV6/+PZ50TuHNQk9RcKMje7BlCu5rbI3PebZM8dzk6YTYilI
	4IqI0XMcU6hb3l2zkeOec24eaWF3At9FThzG1MhT58uFh7SFuhLyWYjW9nBq/yBK
	uAGkUiO20DNhR56T7umMQmjWhOKRm9CC/06Qom2wi471f0irqOBvqwd3FxP37NqW
	tvfmhL4L4OhD1sjlFIrhj1aSNzVlhLTBPBNUNfFB0rHl3XPhitAeqZWb5NSr8Lxu
	89GOVrtxK46x7H8xem54xl2QcTF0M6FdAPmNfFcLUV3mg6papvNdl4QuPIVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775240244; x=1775326644; bh=4BWP8jatK0KE6K2o9Idy5UmMaN/slESxBsq
	K0PWsE94=; b=oYRUmTh8MOyhDIoTP9yRcP4ddjyqkQb2NekKbYSDYwXU8p8hIsc
	ZcFgBISFj4mddB/sEbXNg4/lKzeUItGhvT8A0CCsYs4SyfkH8fQQZgzTx2e5h0H1
	s2Y34Fi+I5SV+MMA4NjTfQK/4DpHIsH4D02J4jFrCoBeMaDoDD09Np0Yo/jQIbRy
	wN9pzTQ+TVRi5FuipJSrYXvJ4C5AByW5n/vi/9DXEYXI9CKCfQEnGfW+SLpO6nS/
	LsY8icMjzgEZd39Nsk1PgbHl9slAX3lm9EbDhrNDHtj401tlCWu2Hv5nOTpOnpBv
	CI/7ZS4VqqlPUYly1bqlSh/vWA19PvoC6Cg==
X-ME-Sender: <xms:NATQaecklIGGXzncHsBSfu8CBuHvaUAJzo_Bi0EokZDRQ--W07w7uQ>
    <xme:NATQafMAXv90uVZjImPGgiI1Jqew15S5WDZqA8tm9ZmhHrxoGpfN4p3RDuM-3P5Hp
    R_vHgN9W3qjVySfDoUQrMAJRC8wt1g_xw29viYpYF2OXhPpUwDAJA>
X-ME-Received: <xmr:NATQaUjHzjf_VIcmN9mSOcsZWEiaU13SxmkHkPc22d7usK5TXbBKvYnbnnA3mj4kW-RNN19MEPQLmoXsiaeTaq3KwmyOUSTz0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NATQaa2XlYkJNb8xXh3n1swirHT5xzPG2URFFT-aCqak8lJT6Vmo6w>
    <xmx:NATQaWg4tIEbHoaupzOteo-uKZbewr-HtgCFQNvna5tMTjiaUkWpPg>
    <xmx:NATQaSfC36KBN-n8UmOJVMs8YEEO17W6U7sHj9fn1bHNXXjHkR6EvQ>
    <xmx:NATQaRnIk7cyQuTJnJgA6-GFPY9ikcu1dRLW71yoNFeSgwoOn6-c3A>
    <xmx:NATQaR5SXnm6Nnzt-vlgr7kV22g-uaVDOorANqu4IZRFqP3WuZA8zTEQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 14:17:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 11/17] t5509: specify bare repository path explicitly
In-Reply-To: <f43a7add-6a0c-2368-1b4c-655dfa6361e7@gmx.de> (Johannes
	Schindelin's message of "Fri, 3 Apr 2026 16:22:37 +0200 (CEST)")
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<f6fc807af627701bf7f9ea413c7714e9bc01aea4.1775140403.git.gitgitgadget@gmail.com>
	<xmqq341dozxc.fsf@gitster.g>
	<f43a7add-6a0c-2368-1b4c-655dfa6361e7@gmx.de>
Date: Fri, 03 Apr 2026 11:17:22 -0700
Message-ID: <xmqqqzovnc25.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would be indeed more conservative, and it even results in less changes
> when done in a more elegant fashion, by appending `--git-dir=.` after the
> `-C pushee`, as the patches "t2400: explicitly specify bare repo for `git
> worktree add`" and "t2406: use `--git-dir=.` for bare repository worktree
> repair" already do. That will not only result in vastly less changed lines
> (and hence less cognitive load on any reviewer), but also avoid the
> proposed subshell. I'll go with `--git-dir=.`, then.

Ah, yes, with or without -C shouldn't affect the decision to use
"--git-dir=$path" in the first place, and the ones that need the
change to explicitly say "--git-dir=$path" in this series are all
the ones that wants to be at the level where HEAD and refs/ exists
and access the repository contents (as if it were a bare repository
even when it is a part of a repository with a worktree, or it may
be going there into a real bare repository), by definition what we
need to add is "--git-dir=.", no arbitrary $path adjusted for each
case is needed.

Makes sense.

Assuming that we want to tighten the rule and prepare for the
tightening before it happens, that is.  I personally do not think it
is a bad move, but I do not recall we had much discussion to gain a
community consensus to go in that direction.
