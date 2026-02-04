Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3A28136F
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246300; cv=none; b=Fvr7HFWJNjOxejkBIUVPVCkV0z88AzxmE3Esuw9V6NflT1sdJIlhBPWuW2mneAv4L6PbZG6cgEEgIfqSBQjjlwxdFV56jhn1N3xhzSJdIGjGy1MrCi+Dc+FDvrWiMJ/gfvG0RuG03xKF5looBY3PXkUXWqpnbRtoXj9YIMyLPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246300; c=relaxed/simple;
	bh=Jn3DYSPfMPAjMDXUp6NQA2q+meD7J08cZyWk/dtIYaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=flR9kkis3Tbsp3E5E7PZ+/+EWHBNnD+CLS8SETNy0zn8WDLxibzEXLJC0z7ZjnE2VFBEqaN32/jbPYjOeQ5/zeTLoJ4GZRUxU7BjUL15UBULpz8Q8rMzzKvTMATmC0fWblPZ3N96ZMGt68FqmTiO5yGn4jtbtcqXAiuaiVWVX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtJOfAdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2kEjMY7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtJOfAdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2kEjMY7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8065DEC023A;
	Wed,  4 Feb 2026 18:04:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 18:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770246298; x=1770332698; bh=gZvQM5BWzt
	UrrngBYJNzscpySYV7b6wQnISiqO2WmCY=; b=QtJOfAdrfPP6BqLCTlAdejITqY
	xRZO3mTv0Djcd9L2E+wZeY37GH5sZYU7EIupmbInqTEd85/3lG0Nr55EjaP8Mhaw
	zPbleD1GHeUOKbMMoYsQC5g8VtavAYTKw2sFwkxQCmjauPEwtM6D/JTRHS86F942
	PSkzDotYMpQQ0G44GPrbrFLenOqQ/FM4/Tza/0Zs2dSsq8hbkSsrI5bxNpa2cxn6
	SQUSZCptuLJw+81AmWefrjXU8hXJUmZb2GjO1WEhFvOmYNXTiyOJXvGbce8RYrCc
	S0XBk2NbIQmQvTM1HEVr1trFhwMe7It2951myOu3RpIH4+wmj+XpIThkALNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770246298; x=1770332698; bh=gZvQM5BWztUrrngBYJNzscpySYV7b6wQnIS
	iqO2WmCY=; b=k2kEjMY7nimbSbCTb8UUfP4HjWrj9XF/+UgkJeRU2W+ATGae4j3
	emDXxded3Xoktf0mVvqTv7K4AfpxyPfrrYoNve5+Sdjfds2s0HVpM1kX44da/AYX
	z5fVdf0d4jzdkAuZ+Wk8vodaycRGs8Xn6YFnDK7Yk7ckjBrhoiCdS/2oV1Mb9HlU
	AzLIoxX0xVbKFOyByTubcRVhnFnKrs0oOKhRjKATT9xx9cwQYsSUoCBuFvfoAzQH
	+9ltZpxHvoBLD/JNYDQvALswCnUIYuLEl5RfRIwdj5+OiSLbrBR0AViC8RQxVGbm
	JXLe/cg6eOUrP0Ey+VsWgr8e9pLRTpf13VQ==
X-ME-Sender: <xms:mtCDaUWxco-MdwMoE_SVENN1eNJ5lxPYg7QJN9wGoJ0F5XqtJ4M8cA>
    <xme:mtCDafk45MMzC2MtqIBoIUyGpinkCZvQoPgZfcSr1-4PJcY4He5vQUNeVkEj857sA
    LrRswOTxPf9ByTmKULhwIzM1BBakcKVi-TU9O1iIH7HqAVBCC50>
X-ME-Received: <xmr:mtCDadYF0lSbyGQVeu9o-RBdszj5EGNkE1Dz6puCE9soz7jK2wiQSGXzfgVE_-HjqHDrQCHe9yCjor8YR5Z0Sbt3toNYKQ3lZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:mtCDaSPOEp1YlWxVhDbL6oTC6zi3x_NskfHoFVdCQ_PLLrFfEbUTIA>
    <xmx:mtCDaaZsutXHz_6r2bn-4v13aopCHbSElPH4opZg68n74FEzpa9mdg>
    <xmx:mtCDaY20m-npO067UdUvB7xbd8uev_WlleJNx-9rVPo04ipFrHociw>
    <xmx:mtCDaYehaZuU3Hy3WadszeFwi9mV_cy96owHVJe3TOvA_J_sODEKUQ>
    <xmx:mtCDaY6TcJADF6JaRF0KYn3ZM3qr0yyu8X9eN1KgDbP0xMLb3OjdzAv8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 18:04:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools
 querying config
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Wed, 04 Feb 2026 14:19:52 +0000")
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 15:04:56 -0800
Message-ID: <xmqq5x8cnm93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This RFC explores a new git config-batch builtin that allows tools to
> interact with Git's config data with multiple queries using a single
> process. This is an orthogonal alternative to the effort to create a stable,
> linkable config API. Both approaches have different strengths.

Just a few random thoughts before diving into the patches.

> My main motivation is the performance of git-credential-manager on Windows
> platforms as it can call git config get dozens of times. At 150-200ms per
> execution, that adds up significantly, leading to multiple seconds just to
> load a credential that already exists. I believe that there are other
> benefits to having this interface available, but I can't recall any
> specifics at the moment.

So this would be "credential-manager gets started, and instead of
having to spawn 'git config' many times, spawn a single instance of
'git config --batch' and talk with it".  Would it be beneficial to
further think about a long-running 'git config --server' that can be
contacted by a credential-manager (or other processes) whose lifetime
is totally independent, possibly over local transport mechanisms
like named pipes, or is it a key to keep the mechanism and design
simple to limit the number of customer this service supports to only
one at a time and we would prefer to keep it that way?

> One thing that I think would be valuable to include is a reload command that
> signals that the git config-batch process should reload the configset into
> memory due to config manipulations in other processes, especially while git
> config-batch doesn't have all capabilities from git config. I'll include
> that in the first version for review, if this RFC leads to positive support.

Can "git config --batch" write/modify configuration, and if so, when
does it make its modification available to the outside world?  Would
we have a "flush" command, or it would pretty much be immediate?

Can we do without an explicit "reload" command by noticing when
the configuration files are updated and automatically reload?

I am trying to figure out how more than one "git config --batch"
processes can coordinate with each other with minimum overhead.  It
is not a goal to have multiple such processes, but it would be a
goal to support multiple clients each of which would benefit from
having access to the configuration data service (which is why I
brought up a single and shared long-running daemon as a possible
alternative earlier).
