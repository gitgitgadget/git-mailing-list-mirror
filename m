Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79215B102
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917175; cv=none; b=VTLgijCY2MSnw3riF9b+W1G4jkfIakSeOnvI1lal+XBAJigvJJoUt3ZDzmmvOmCuwdFlvSDtCwTnYL4yxdKpHukZ57ZZcPEeNyMDVAwdz/cw+EjKByk7/g3NpJA/0NB0zcrpaCHrRNMmOShE627Y3WN6fCU4YyMIs7MyyXwM5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917175; c=relaxed/simple;
	bh=4zNgg/IIBT0UYtW9gltay05SxKDPtQj3i8t53eoiHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieGCJsFh2HhTi4lkL7+5O+xwr4HU/FnI1XxF26GnT+v7aNwV7MgcJdSrvcmEuKJi6OvgkiUzp9Ue2IR3tCdRIZEq2UR/pf45mwPrVGbWl8Pw/1v9UbI2iDgAq0t++TgkskSbQH/MT6L0KWrMPvGvnsuV+Cs8mB9ykvvQ1cMfHqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4N+A/nQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMw62QEg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4N+A/nQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMw62QEg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C10C25400DB;
	Mon, 18 Nov 2024 03:06:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 18 Nov 2024 03:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731917173; x=1732003573; bh=4zNgg/IIBT
	0UYtW9gltay05SxKDPtQj3i8t53eoiHzE=; b=4N+A/nQMNaBxIv+PxS5brUZvJY
	oDUqsvLSYyCC20VO3c6F/Fq7CK7c16YnDp8i5BknO3+dMKjBPTzHl8UZ61sf/OUo
	8WemB7iYfSdULsqAG/fbI60cHyQ/y/KQwDoKRW9wXpwvjqABN9oZV9LfbFiCZzAN
	tJpOjP73p8tbNroA2ALw0V2z1K2mOY9P+l259AdKdhiIZeNPV8eAlVYQ4jMjUhg8
	TilkSoKtj0fW1v8WA3KTqxqaobsjATLtUPNZwPfganindssBxcQRMDKSk+rxweXY
	Ui+LyfHr7WwO20L3cAJeAh70+KeaIice+HHi15p7JmekT9v3WD2Iuxp3y+yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731917173; x=1732003573; bh=4zNgg/IIBT0UYtW9gltay05SxKDPtQj3i8t
	53eoiHzE=; b=XMw62QEg+7makAxBb1c21M1qXKEwUOI6rCR0NF7BxEe2ABj8i9f
	kOetVG91RIawCkEM8TfeW2cyudGKenKPtwMx1LcUmwHOUpKRetUr7uOvzDwWtXdD
	ybSxJa/qNrrsAHhv8wjgoglUBJo997bA6J/PKABVZqcxwh20GcsSGwoXvCAKRdCX
	41sD+QKKR/BiUo5kwrz63qNKuqowiwJ+AYYNxDB220D3oWI+FNZRzbrD++CgyKE1
	g/Zh+aSZaZZlJ2VXTo4xbQIjjeLMGc28rAZy0eS5R9H504HDmqd0MEOSaC5lFAhl
	UDaqdLdd42lAg3mR1Ql3ctVKcOJC/ITniZg==
X-ME-Sender: <xms:dfU6Z0CmBFdqtmpBdhA4c3RPk8U0Llq-38YTNvISWRkF1hPbDDeOaw>
    <xme:dfU6Z2hlTkVYgMJn2Ks69JAAbr8kljkkAIkACTrQ1uIZ8KYE_rSogdzXi2IcKZzTo
    jF5eGGyaBpM30OviA>
X-ME-Received: <xmr:dfU6Z3n1vJQlNFuSWB3gV6J95BerlO_fcrFcFd4EfBfs0EcnpMXizxq6LYFKK2DJYpicLdpOsI7yhU0BXwq4IGWG6Xqo59d5GHB0iDnmVmt3QJD5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    ht
X-ME-Proxy: <xmx:dfU6Z6ymbpfAdtbVx8R5pQWNsj8y8U9ofpanpETFx4GDK4kI0a4anA>
    <xmx:dfU6Z5RDr-73idYHD-V9l6iwN9MO-kiaxoFinD9CeEDSKx2LXhdm4g>
    <xmx:dfU6Z1ZarTwrWvsbxsQKyTj1ZwJN5QmQLpa7Ewba1sFoHf94XfC5iw>
    <xmx:dfU6ZyRM3uL3-P_kAGEAw5s5OI4yb9EVCsB3Z0Ozj10fmRFkjdrHGA>
    <xmx:dfU6Z3O7FwJLNvneO6RewPFvztiMgNnWkesHDhPl9yJf5FzQXA-iZIH->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 03:06:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36e8f7e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 08:05:25 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:06:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 4/8] midx: cleanup internal usage of `the_repository` and
 `the_hash_algo`
Message-ID: <Zzr1at9niamTkEm1@pks.im>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-4-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-4-761f8a2c7775@gmail.com>

On Fri, Nov 15, 2024 at 02:42:17PM +0100, Karthik Nayak wrote:
> In the `midx.c` file, there are multiple usages of `the_repository` and
> `the_hash_algo` within static functions of the file. Some of the usages
> can be simply swapped out with the available `repository` struct
> available. While some of them can be swapped out by passing the

The second "available" should probably be "parameter" or "variable" or
something like this? Or it just needs to be dropped altogether.

Patrick
