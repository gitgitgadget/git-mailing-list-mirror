Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F81EB1BB
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941462; cv=none; b=InIBFwnLewbVwffmYhI+Iu1NQgpdmA+zdrNhQQAhPziPgD1MAtrAN9Hb+TPsj4Rp/v7V8qc5t+572nszd8IOUr9Z66Sjps+Lo1bQ2amg5myMosatqj8ZYqyvYsJ4PGcUDLEQ5iJM2k/RMSLVSEGWMJdoSLDaM1y9p/brijUifLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941462; c=relaxed/simple;
	bh=eljUaZKW/CuFYYssV5ovSlWX178m2aw66tiGtDDN02w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K0ZqXFivFc4ih2M0iLWnLpR/Wh5gdvPL/jBfhcr21wpv/qpf6FUUcjKljYLe9CmTeReLOxE3TngeYFTa0336XbOQ+qKM498l+0xQKx6mVwmUWInazcFetPAog59al1X3kgrkW6x82JGS3VheBlI2Ol4pcsHMugeZ54MJXzOrLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XMVp1n7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuI4fnH7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XMVp1n7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuI4fnH7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D875913801DA;
	Tue, 29 Apr 2025 11:44:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 29 Apr 2025 11:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745941458; x=1746027858; bh=qc71feiIcH
	w35GIHUXTdxc/Z+k7e8WqAT8Dbz7ge/k0=; b=XMVp1n7MwSAhWv0bQBSpK1yCZZ
	BgWMmghXt6LGoQF/tvOGvwLzvJ5LCT/dXVWYUf1jDSyrN9XxnMlFz2T5OQ0F6rAh
	jen0uCVmBPK9v9xcWM+WfoFdN0Gu3R7wPCcGnb/RSmRUSF5YS6/Vh2ndZKMgAVc5
	cvGOeYakjB/ej2aSNA0vIKk4OfzuRtMGQWcw0aHdL1QqlIXJdC0U+/6JU64Jfrju
	+4GVaqrursYYH20T5G39LWD4Ulsqt64mu++mjx913gekN7XwqJweom31keUFSzLu
	/F4cZqJVcYQP3OZosFzxG/RC9KFtbMG1H+u69rp8N/pVy8+kRQraGxkxi2bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745941458; x=1746027858; bh=qc71feiIcHw35GIHUXTdxc/Z+k7e8WqAT8D
	bz7ge/k0=; b=IuI4fnH7jvBPeIJO+es+gEp+oZvw7I6OoMpxlGaXAzkn5awhxgo
	O73ALJDscW19K7EmvNnBzn2G5vupXjoBfkjnXeYPF+qxBqSsj9ZmdYINgmuhbe1J
	UQN5YHHMlaCaIEmsc7JLn2iFK0LT/duEoUtLxJwB3REBrsUOsA9RBt9pC3QFX391
	0yhI9jlyG2DHidgSvjLTgp5PTzT/Lr/XYDV+fkGwEvTwvyJTwhjLReh8Rml5XGoR
	oBzMCFUAGqLy218seNYGpCe9kqFTLCYJpjJxtQcjIQkO7LwlaeMkxDOS5x9xv/0/
	9Q32gLyUhCaTwcxqsaThQmKANLujJR2TgTA==
X-ME-Sender: <xms:0vMQaC1tvs_wBYbgzOT0oe0HgCTwmfbxOiWy5mz7557KWZzLuozeEg>
    <xme:0vMQaFEGnX1NBEkflWy8IUoBnOjf7dphYhtvZHnegZRK8UJaiEkvXe_kHm_adYeVd
    wcPOWpG7Vlpsvr3gQ>
X-ME-Received: <xmr:0vMQaK7OlJcKcB7R9KFrzOtlT6qXhoegDgTtZJuzHUKdQ8dcuKBjZrprC4zyYoka-Ygkey91hwB4rS3jcS9LkwQqifvKVWFG1QuO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0vMQaD3AV-2Xjk9VyUssZihunumeznqfq3w1B-0K8TFT-nvFKpZpog>
    <xmx:0vMQaFFskz-u2AHsRuQYH7wRFKNsVdPWtgdibAJgT1Afdof3lv8_TA>
    <xmx:0vMQaM-AqB6z9lWBjfylY-tZLl6Pm2MInLJpA4NZOogAA5PNa7_RVw>
    <xmx:0vMQaKlj6iQzCvc_uLrp83rbL-x84Ac25Oogf50kqtkhBePw7cLeTg>
    <xmx:0vMQaJOSJ-EgOOwNymWQ-RvBXNFC0OAD4a1kL6voJtzqa233-J3cWqzG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 11:44:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Chamber <kuforiji98@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/9] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
In-Reply-To: <aBB6vHl5Gmtva7b3@pks.im> (Patrick Steinhardt's message of "Tue,
	29 Apr 2025 09:07:40 +0200")
References: <20250427185351.82520-1-kuforiji98@gmail.com>
	<20250427185351.82520-2-kuforiji98@gmail.com>
	<xmqqa57zamuw.fsf@gitster.g>
	<CAGedMtfwA2vqOFxjLnusvFNcwKpTCLq38bZYBz-9cpzFmbhUdQ@mail.gmail.com>
	<aBB6vHl5Gmtva7b3@pks.im>
Date: Tue, 29 Apr 2025 08:44:16 -0700
Message-ID: <xmqqtt677z1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We do want the Git history to be fully bisectable so that it is easy for
> contributors to find out where a specific bug has been introduced. And
> for the history to be bisectable, we must ensure that every single
> commit builds and passes our test suite. You can do that e.g. via `git
> rebase $BASE_COMMIT -x 'make -j$(nproc) test`, which builds and tests
> every single commit in your commit series.
>
> So yes, this should be adapted so that the initial commit introduces the
> new helpers without removing the old helpers yet so that the unit tests
> that haven't yet been converted continue to build and test just fine.

I started writing the same and thought somebody else may have
already responded, and found yours.  Very well said.

Thanks for spelling out the expectations we have in this project and
explaining how to achieve that goal.
