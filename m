Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9109156C6A
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785959; cv=none; b=jZKA/Wi5NRO4Ilo7Kw2T6ihGgqQwu5XxPlEAqzZYFoqbnXdyuDOZjeoqozK+RuT1bD2b/N0pd+x+zZU6kKDFoRhVfvGMrqbSOO65+AEkVFezUEu6wtZjttU778uEukxV9zKkcc7kUzwnVqP4bvFxDq9aIQWQvmN0wXaOH2fjwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785959; c=relaxed/simple;
	bh=80wGdwBBmmixOwySRR991jcmcDJE0kFPMz4U4DxW03U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFCfgyeRraUAoPWSRVqw7aC+b56HhXq3yBoubtIlIMWdumIFfoApQJQsvmk9zdGz/WzTxjvmrBjs3PjAGCNr64fS1heun2HOx5fmqvBz3ha0UXeRFlIgajPTueKiWcNDyb3My9zYo8pFeP/5oDGSLtUjFd6LiUMce9Cm0LVzcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nnDCGKqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/imZ1d1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nnDCGKqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/imZ1d1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9B9D1140E3A;
	Tue,  1 Oct 2024 08:32:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 08:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727785956; x=1727872356; bh=R1ndvtCEAC
	b6aBoZjbEydyH8A8zin/PMD+REPc3tO1s=; b=nnDCGKqRNlUqu+cZmMNNexCynR
	puv+evMUWeqDCQO4XB0TFOJekfGYmH4nnQRJEK/bMekSHQTAUcAUbtUZ8S9+SrFL
	g77hlBJVppJ//16LkYS3hZukDnbimovJOhLdXU/JNuiyKRGhjkOW87v3TA+sf5zE
	KVjZa7tvjM0O5xvGwNWDvG8r4LHg7i5aa9/Ap009u51jELmA46Xv6sSPja7+hhOx
	tVC1ZJBYJdBnAlsyFQ7jHWwTgrKs7QfXNvdme61hUmVr9BKF4QgBnFIfKAvNHHIZ
	mzjzbJe+eUZtH473HaLlQhQzTke8kdUa7a6482qqYxG7tsgU3RMltaO5u19A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727785956; x=1727872356; bh=R1ndvtCEACb6aBoZjbEydyH8A8zi
	n/PMD+REPc3tO1s=; b=D/imZ1d1jifbH3fcQ62RfkSoAqEdvZUVygoaKVKw8qcG
	t0uocHM1joEcMSq2mAXwRDgAucWtm+B2LY1FXm5hae/ikregXXwO6HkX9h6pdo9h
	/MqS6qzsRjnRqHDvmQSZnRhjTI4wkM8ded2KMd1P/Yoa8qO4k7yVHtRQXHrHFFAH
	cKXzH40ggQThBOe2Q4bbJTIwjn+X+CF9e8bGid9KHZddfoPxK7hn3wjcDBiHxwzq
	XifZpshOrjwrIkwEorJLbuG9vVIFRrVM3vLwxI1vraajPdrlqzjSrtyXs4ThHV6h
	0VpCmWYJeAGwlBOr8g2SRUCA7qJftVtbPIGNj3GwiA==
X-ME-Sender: <xms:5Ov7ZqYu2gAUt-WPG0KBvKe0NWo0gGad3JFwSHe5sGhLsVtxJD5R7Q>
    <xme:5Ov7ZtYczZ9x_w4bW-MJU9p6B_q3n0JVwG8fQAzFdaE_YaaUNRw2HsQL3AxS_u22r
    yDCr9If3Hj7M9Uf_w>
X-ME-Received: <xmr:5Ov7Zk_j5XIbzCcJX76i7gLRHFd9H1fqb4_8rdi4998Ww7pktFvHugUOD_S_-uX1XMbczFU01ByEGZB8BrgG3I9f97C5HLiuB_gkVVZQiNQumw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:5Ov7Zsou0skBy2aF8yyyJtvzeYku5f-F7qvEUj4LuTdieS7K7It8_w>
    <xmx:5Ov7ZlosA08iyahYmD_1ed4LENFZgxAKL1mSqrzuNXwfjHiIqsl6Ug>
    <xmx:5Ov7ZqRaEe7ypmhTcmOb0JuJ2jOp2AZW1gW3hxezC-4Z7ZMJrRHsnA>
    <xmx:5Ov7ZlqBoC50YHfq24jelvnZOds58EQU964m6bvwB2hotbhT5nearQ>
    <xmx:5Ov7ZuCFBs2ymHctuwcq9Lqer_TCnaVwNpKhpGEybG-t-UgeJ2ym-cju>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 08:32:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb77358d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 12:31:44 +0000 (UTC)
Date: Tue, 1 Oct 2024 14:32:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
Message-ID: <Zvvr1_9syRh1McVA@pks.im>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
 <xmqqy13852jk.fsf@gitster.g>
 <ZvuBduVg9TJeULpl@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvuBduVg9TJeULpl@ArchLinux>

On Tue, Oct 01, 2024 at 12:58:30PM +0800, shejialuo wrote:
> On Mon, Sep 30, 2024 at 01:06:55PM -0700, Junio C Hamano wrote:
> In my opinion, we should first think about how we handle the situation
> where we run builtins outside of the repository. The most easiest way is
> to pass the fallback object (aka "the_repository").
> 
> However, this seems a little strange. We are truly outside of the
> repository but we really rely on the "struct repository *" to do many
> operations. It's unrealistic to change so many interfaces which use the
> "struct repository *". So, we should just use the fallback idea at
> current.

I disagree with this statement. If code isn't prepare to not handle a
`NULL` repository we shouldn't fall back to `the_repository`, but we
should instead prepare the code to handle this case. This of course
requires us to do a ton of refactorings, but that is the idea of this
whole exercise to get rid of `the_repository`.

If a command cannot be converted to stop using `the_repository` right
now we should skip it and revisit once all prerequisites have been
adapted accordingly.

Patrick
