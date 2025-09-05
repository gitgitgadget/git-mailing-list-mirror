Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664423E320
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084682; cv=none; b=kb28npJqdYXlMqUe+2p28acknRcKC/EUr3mZKSUyMwzx3zBOTKjIlv5v6aGcDrIuIXsqO7Pl0BDvcCtUNO0Li7JbyGzAIJjgpax/I3WJCjYOlU5AM3m1Ri2BuUHZ/+9UVLDgs9QJXugY8FmCGWue7sKAIcq63jkJODP8IQ5O2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084682; c=relaxed/simple;
	bh=oiqrrdp7iA21Ac5LgHVFTsZ7oGodraa4RSt3ASuwtJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EozjNREVHDOhYlhxrYOOx3jxjkEDCaCi6puImniNasdZ4XCpQiwj0b0eIWR7N0QF873J87rl1nrNFoB1pRKVeeKkGK4lOsbv0cPluWFCoGem2H79ASvdjaJM3uXlHtv6rEbRbF/d8bi++MQl/IeyF35b/BL8laKbwYvZts+bXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BNpEbzvH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxNDZrMG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BNpEbzvH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxNDZrMG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9883DEC03CA;
	Fri,  5 Sep 2025 11:04:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 05 Sep 2025 11:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757084679; x=1757171079; bh=sv3qzzNwun
	G8ZVGxKFjZRUvSelaD7duZ3g8hVB/YQJ0=; b=BNpEbzvHpEN9Nnh06mLw5GrSrF
	0hEt5aKpg31QFqBz7NaR8/P63xTcwaqStZGdu2P+yXNLOzyYOaN3h/wlDjqOKYBA
	BZDlJSOa7Tnj6lQfORFnm/MiYbYeggOzYwJ31HMfQScFdZHcJpc6VGpbIvJKpNVc
	8GJyWx/JSLwPBicojgwNelh9+879hi4vQ/L+RdZK9VKC11o+L3IGfjDDIhLLqH8b
	y/tIyNd/77ZCFk9cyQZsSW1QC9e2s0kZ0kOmtwm8hPfD8jAyn3Yv2k6mBN1cJMej
	O07OZBDkKZ/8sAHAlznLkreaWQYZMri3yzeZALgVDbZYxrPtc4G8MGHmqAzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757084679; x=1757171079; bh=sv3qzzNwunG8ZVGxKFjZRUvSelaD7duZ3g8
	hVB/YQJ0=; b=MxNDZrMGaR8kf/q7TDNoFEoH2h5lFwBKS2Sv5koRgEk3EnOqaE2
	cZv/CCcyRjfQbBmisTNOELo8Dvj0D3s2lFcd/pLzeTwgRySolRAeql7YWo/360a+
	k4bSgQ68QUVEfcllWIcsd6g3IdVMT4BF3KSzfp+m+/u/hANwrc1Zymz5/Rrfsak4
	0qXq/m9YuXvl8W7YtmnEftd5rwsy9FWm9N3Q/B6aRwHexf4eLwqapFgcY7/bPyGT
	0k8Yr3hCaGQej7bj4mNJ04kYpIiKGlfUtjbkxV2DsrUhQ+ng1kR4Ehc73NBk3hYj
	HALnLFvab6Dc/colNseviE9sNucqTCEGYcQ==
X-ME-Sender: <xms:B_y6aDZJUmdTY4Q6hJ6U9bsUwHrfgGFnLpv5EhZHSpCm84WFWNs4RA>
    <xme:B_y6aK0KW4Y8XZMIZy2BpA94AEGDY5EtwIe_kKYZiSH0ym6rrB-y2zEBabY3vc8-K
    AjYwVVEFecrkWmgyg>
X-ME-Received: <xmr:B_y6aGZpxMEPwWVsScM-rqqV6-HLMgIKZdJEXZrkOSKfwg_r97mbZC6k9dN1tLq3S36ZOzyuSnv6zvAsng1wcXU7d958uvGBi4DQN_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    ephhhurghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:B_y6aKJT0Ps4TVsn4ntWC1K8O5-RFd-FMfyEXNoeWEeFCufmOc5moQ>
    <xmx:B_y6aNFGX4d2mW3vSY0k76YxHz1mrOX3QHYRf8vAbSvTae_OLaCgSw>
    <xmx:B_y6aJtj5dGY_6LhLG-BPSL0Bku9gmI3-qCv2y8eZt1IgflFRYu2Mg>
    <xmx:B_y6aEuv2rEXtrq0VB1GZF9ysj_p1ohx8rZANznDsrz5hqEb7reKjQ>
    <xmx:B_y6aK4o7TZBnPyY60JO3aF2NjGzXy36h4IJZ2tw-HkOhxwVE6pxog16>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 11:04:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/4] breaking-changes: switch default branch to main
In-Reply-To: <f43c3e61-01c8-47d8-bf0d-7cfa13cacca5@gmail.com> (Phillip Wood's
	message of "Fri, 5 Sep 2025 11:06:41 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<cover.1756992089.git.phillip.wood@dunelm.org.uk>
	<6986375dc379a646bb184be3cf7a018b2eb3eec7.1756992089.git.phillip.wood@dunelm.org.uk>
	<xmqqjz2e86b7.fsf@gitster.g>
	<f43c3e61-01c8-47d8-bf0d-7cfa13cacca5@gmail.com>
Date: Fri, 05 Sep 2025 08:04:37 -0700
Message-ID: <xmqqwm6d3pq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Would there be folks who type "git init" to get a 'main' branch,
>> while trying to follow a recipe written in pre-3.0 days that assumes
>> the initial branch is called differently, and get confused after
>> seeing many commands written in the recipe for them to follow , like
>> "git checkout -b next master" fail?  Do they need a different advice
>> message to help them, i.e.e.g,
>>      $ git init
>>      Initialized empty Git repository in /a/b/c/.git/
>>      hint: Since Git 3.0, an initial branch is 'main' these days.
>>      hint: If you need its name to be different (e.g. 'frotz'),
>>      hint: you can immediately rename it with "git branch -m frotz".
>>      hint: Disable this message with "got config set advice.foo false"
>> or something?  I dunno.  In any case, that will have to be a new and
>> different advice message, and defaultBranchName should not be reused
>> for that purpose, so the change in the the above hunk is fine.  I am
>> wondering if we need a new entry protected by the same #ifdef on the
>> #else side.
>
> Personally I find the current advice pretty annoying and would be glad
> to see it go away. Are there really that many people who want to
> customize the initial branch name that it is worth adding some new
> advice post Git 3.0?

Given that the tutorial materials that were written when we gave the
init.defaultBranchName mechanism _all_ assumed that by default the
initial branch that gets created is called 'master', the current
advice messages were primarily not about usability but personal
preference.  The message targets those who dislike 'master' so much
that they are willing to replace all 'master' they read in the
tutorial material as 'main' if they are following an existing
tutorial material.  And the instruction is primarily about how to
switch to a new default permanently with the configuration.

But the one that I pointed out as missing in your proposal is quite
different.  It is meant for those who need help about usability, not
personal preference.  Even if they strongly prefer 'main' over
'master', in order to follow along an existing tutorial material,
they will find it less error prone if the initial branch used in
their practice repository were 'master'.  That is why the
instruction is only about recovering only _this_ repository they
just have created (Notice that I did not tell them how to use the
configuration mechanism to permanently live in the past in the above
"... or something?" example?  It is very deliberate---"the world has
moved, so should they, except for this single instance" is the
message they need to hear).

> Although I find it annoying, I do think the
> current advice serves a useful purpose as it informs people the
> default that they are used to is changing and that they can override
> it. Given how long we've been warning people I'm not sure we need to
> say anything once the default has changed.

You need to remember that there always are new users who use Git
seriously for the first time _after_ switchover happens.

Because it is more about usability than preference, I see at least
the same degree of need, if not more, to help these people who still
need to use the old name to follow along the tutorial material than
those who have been helped by the existing "Sorry you got 'master',
but you may prefer a different name, and you can do so by doing
these things" message,
