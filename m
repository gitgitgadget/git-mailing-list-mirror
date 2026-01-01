Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92328277CBF
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767309295; cv=none; b=pxgn79AQXQdklwtMB28ZNNp1vlMHP3dtrXHGVj9uUFEhG4QRFHulcC4K7QWIMuYkfu6s2vvjk2lcm2xV2gZ7qYQrFb35awzKZDPqoV8Yt6ZJWzTwP+M1hopsIxjuKN77Fq0GSwnuR86hgqtHsiRvRYfZ3eBED6Z04HhemaTYj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767309295; c=relaxed/simple;
	bh=ymNuAV+uqeLPmLM2EtFbjvHAlZxBsvcnDvnR63WOUyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oms+eDrlahmdIBnZQ7fMvwfRyenvoBycmHBR39g77XxB/ecCNHn73qU8hSYxOWRZ9amb0OK2Hv8i3S2HOcqQEYwse3+H+VS5EgdrmUfska446wOPp9Kn1C5KO/zwn5NpGPoyLewZIEnorl6Z/jBJvhmTItkxe0lEVz7JTrNs6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iJRLSNuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcBGFX4k; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iJRLSNuC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcBGFX4k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C06B3EC02C4;
	Thu,  1 Jan 2026 18:14:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 01 Jan 2026 18:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767309292; x=1767395692; bh=ymNuAV+uqe
	LPmLM2EtFbjvHAlZxBsvcnDvnR63WOUyg=; b=iJRLSNuCvmkDE7ecEvIf/7OLAl
	pMjowqwac+5Xt1GpvGBhI+efJ0GsWMz4QexP6c2ElNBX38LlvEynraDNNd7aDasb
	qA4tCQ8HRtfg2i6qY+EZ6hChL8Ivd5A3Om9roE/Zc2d7uYbIsaFv6UXU8MDyjJGC
	xafZqhj6xKlU6PT6L3kp3eWl+K2NDx02aX4qy2RDSDIecaJ1u3o7yK9bZ9lKxq2+
	BO7EtrU2W8FdJhgfUHS/9w/lMhlS4EoieUwfJRFE0pdHc/FI2+TbkgAh6ggKvG4q
	Na+5FGJR6uEbWHFDvznHN7SuVLSiRUTUM4IEhDjzF3aCVz++VnhHXm64DpDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767309292; x=1767395692; bh=ymNuAV+uqeLPmLM2EtFbjvHAlZxBsvcnDvn
	R63WOUyg=; b=fcBGFX4k+Ev6HGce/4yNYZeRMZjeUjghfPQ2bAi7jongvV9jU2q
	i7cxNY5JY/8f2t0d5DYxWUzPZMs6wk/aH2x5UUyuex9ZIMT7HhmFBNXAnyBzvCJ1
	2S4l0+3hgiUTnLdZ81aT0ukusy8Kj8SpR9aIU22TGICHZXiYvV0+2DDCII3dJf0g
	tFZuOlm6VX3X6WgqAfhux80CCt6aZp3XILVNhDVOhfnW0vNhoNkcDPdNnXlUalBl
	dDT7+2ssjXfTM2Ul61NxCrQGqcmoGLuGys7UHtURfkgDD1KzzCY/C5k/cCTvIMOP
	6FDMoZyWz8gUgAs7JkFWEPaZ1TmHQjulb1w==
X-ME-Sender: <xms:7P9WacvGUrix0zsT8Xtn1dQ5_4J6HbtNWpFig0VpO26gf5yvo5rF4g>
    <xme:7P9WaQXtKUIolfiVElrpk6PFJ8GIqZi11Y0Jc055uHL5rRO9VZCKRr61gmEZgwuSX
    b3eFor_qPKdt9gk6ksh4_sBZAXjX-2I8FOvfBrDQqdrTv2Am4G9Yg>
X-ME-Received: <xmr:7P9WaQH8elBjtJH0VivYzK3K5oX8xy-Tsu4gViNvNAl16XJwu4wLwR_aLDpKItgTykksmqcuZcjgn-mY2eu1fefflYF3VTg3GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrgh
    gvvghkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7P9Waa1cU3dLDWg864o8uRBINcGIq9fNlFN01Jik4K6aNuHhU1k4gA>
    <xmx:7P9WaaOgU16N06-t34J8Ld3jEaW4oyGKEdO6MbqB4Xn_HjaFGdH01Q>
    <xmx:7P9WaR4xLsDswQNIoSXr7u249UOdcTsoc8431FqZVOqghQ0_bRKwUA>
    <xmx:7P9Wac0lrfXYWbkr_aogOVFooytqY3QUGT4_URmiguB6XINPlq3kvw>
    <xmx:7P9Wad1NPtNp5F6YbDvqj1G7wQil1fm0X50wQ15DxLfEttV3izIi_Z-G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 18:14:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v2] fsmonitor: fix khash memory leak in do_handle_client
In-Reply-To: <pull.2148.v2.git.git.1767191943962.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Wed, 31 Dec 2025 14:39:03
	+0000")
References: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
	<pull.2148.v2.git.git.1767191943962.gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 08:14:51 +0900
Message-ID: <xmqqbjjdc4d0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> The do_handle_client() function allocates a khash table to de-duplicate
> pathnames when responding to client requests. However, kh_release_str()
> was used instead of kh_destroy_str(). The release function only frees
> internal arrays (flags, keys, vals) but not the struct itself, which is
> allocated by kh_init_str() via xcalloc. This caused a 40-byte leak per
> client request.
>
> Fix by using kh_destroy_str() which properly frees both internal arrays
> and the struct itself. Also move the cleanup to the cleanup section and
> initialize shown to NULL so that kh_destroy_str() is safe to call on all
> exit paths.
>
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---

This is already in v4 of the other larger fsmonitor-linux patch,
right?

Thanks.
