Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341B335A5
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076655; cv=none; b=agNBpT1kZ3rffArked5/lrByThtEn6Ssq1/6zcwU+xMTp1aAtkNI8PCr/lIP1svXyXjeN7VBy1BCUAluMnn9hIg0rMaA/wUu3/K1cPYDZnkJbGnYgd5l3d2ZGZLqcX7qSQOwM2myPoRUosX4/e+gr0DNgYJuKMetQD3IdCd+9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076655; c=relaxed/simple;
	bh=VQGrwOdvl3j1mHJTk48/3T3huMILrwYdAJ05Um3J2KE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YqwmFQKQSXby+qQkyc6Hg8RgOzDkpg+CVKn6RSNG6rfJ022/qkep493rqgFEqMsEwIv2ixXcTAymXKsGTz+Vdy6Ys9YQpaIeLv268v61aiOkEGlW8NYNK1Jfz0HZaMxYMFMNxJcoVTZAIS5ms8zxleBkaOygmSKjPOj+pFWZFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RLK3wrjs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fTFp9x49; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLK3wrjs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fTFp9x49"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E13A13802C5;
	Fri,  4 Oct 2024 17:17:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 04 Oct 2024 17:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728076652; x=1728163052; bh=Z5syOKA/f9
	ItA8IxffIKWBKkhYbg9cw2yOKNbLmCGgA=; b=RLK3wrjsvCrHqBVt+r9H1vzfGT
	ZLmZCCll6bD7oUJq5ksWfR+ND08d31X9m34YrZpH/+WLkJdC369arhTMEeSI96aE
	gaQlJfryy/JLh+TtVqYBA8byLvZOJRL4aLC/E7/ViBd7rWUEyL8D+v688hwxjMMi
	E6ONhERHcDDbvkSt9J1qk7djPaQ/eYNZOU1RVQD/7duX6Wn6jiBfVhiT4y4SfPxy
	I4i5DulhB9SDd73ae9MElAZXf6+SbQno89/ivZTr5CvZLQE3eQvcFSC5QwXvvuWz
	DhzCcJxCtYbHUUJCkF5qs8vedAH6KvM61euOqgiIr6MaZt//xdY99MSr9tdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728076652; x=1728163052; bh=Z5syOKA/f9ItA8IxffIKWBKkhYbg
	9cw2yOKNbLmCGgA=; b=fTFp9x49IgdjdgSDCgvIg0GGZl6fJpzAQqfHTcEjGgLl
	NTshKiy1Gbw23uKZRmRJCFc7c/qj7pU3eKocVP8xt7ztRY6C6Zmgg2S6AG+PXyO1
	aIphhDRcdZFwfRMYa5Hb77qXnH2Iv+ksz76CHfaSpjmTEXSIgpETLePAYu7+dEdc
	pEJrcXGABuTMMnwQ2BEGxcgNSgsaXSv28CtpanhI6Ns0vHkEdssmiwGcEoDvO0Sz
	R/LPXiLkwKjVMijCehxWhE3azJ0crIIk/vUTgMyXSCe+AyRys0ZfONQMlM0+w/mu
	BxeFFhBhMRJ8sIg6nv6wJCFX60XoXUaaCsDBxP+k1w==
X-ME-Sender: <xms:bFsAZ7rFYC7PTIdUxAxqU-vXwVEydMrve40-3wLlCtyCC9SLpQ-uCg>
    <xme:bFsAZ1poR4xreer4hJK2P8Dx811mh3uxpw2xSRGDH70nmCoqDDAAByv6ci1DPXat3
    54Zlb0wQVWlBUtpYw>
X-ME-Received: <xmr:bFsAZ4OigBgZP9zzH9r9Chev5L7urSvp-6lkkepozeCGiVM6RlLwYKekdc-CywIxf9Lj8pyMYD1mKnT1aYcza2B0dacnKZIy41LllBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bFsAZ-5PbrA0lfqhbRu16Cq1ftlllhWxSEgQuILc0aBKV7D3gBuIEQ>
    <xmx:bFsAZ66gc4qGxPm7mOMecXJ91gxgJZiXIznXGwW39YX2aIqqAa1iVw>
    <xmx:bFsAZ2ha5loy5DfJGvdNAqd-EweKn0PGAd7-8MdpIjSAUhPx3hDlSQ>
    <xmx:bFsAZ85_y6NUcrafguxWj9OOh6utnYM4HGJYBLhQgj8AYxDkO_0qcA>
    <xmx:bFsAZ3y6262-wonSBKO0Ucb1uOF6qmq1S9nnuWVwdikclC8pNpuWm6iO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 17:17:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] pack-objects: create new name-hash algorithm
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Wed, 18 Sep 2024 20:46:15
	+0000")
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
Date: Fri, 04 Oct 2024 14:17:30 -0700
Message-ID: <xmqqiku7d0ut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I've been focused recently on understanding and mitigating the growth of a
> few internal repositories. Some of these are growing much larger than
> expected for the number of contributors, and there are multiple aspects to
> why this growth is so large.
> ...
> Derrick Stolee (6):
>   pack-objects: add --full-name-hash option
>   repack: test --full-name-hash option
>   pack-objects: add GIT_TEST_FULL_NAME_HASH
>   git-repack: update usage to match docs
>   p5313: add size comparison test
>   test-tool: add helper for name-hash values

Recent CI jobs on 'seen' has been failing the leak-check jobs, e.g.

  https://github.com/git/git/actions/runs/11184876759/job/31096601111#step:4:1886

shows that t5310 and t5334 are having problems.

I randomly picked this topic and ejected it out of 'seen', and the
result is fairing a bit better. t5310 that failed 228/228 subtests
in the above run is now passing.  I didn't run this topic alone
under the leak checker, so it is entirely possible that there are
some unfortunate interactions with other topics in flight.

t5334 still fails 8/16 subtests just like the above run, exonerating
this topic for its breakage.

  https://github.com/git/git/actions/runs/11186737635/job/31102378478#step:4:1880

