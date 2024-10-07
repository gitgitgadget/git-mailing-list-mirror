Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3C18B462
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289362; cv=none; b=mHChFD6O63nu4crpg6x1O+wC7gTzvg0zmXQFV7EwpgO7Jf+GSxfr2ZewOEwu+AlVqOVQsIghJ1PK8T8/fs693AWUD9j7eo1lUui8OzEdycJ15PsLlaqX1oeMwfSGS/vt254UK8TlYS1PDGq+jvB5RNUN6gq5rlaGAje4SS6OGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289362; c=relaxed/simple;
	bh=l08w3sbKHJnwWGmXifidX4P3EuaRV8u3UvqzJxnOHS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSbmkXhkkBIuFS1qIb7yU54OYMZ8VjFfl4XfEicj+7uSB8wBrNZda60ylnKnDDEXUPEeUwwaj/ZQ9qYFMIpDaN2IMQUmdQlTStTLIrQ4j3KQm5zTPbQUpXXnS5QQ4a7tCYiKtk/RP5mhZAE7GRyRs8qpk1FbBFp68jdySj6Jguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SZC4oKHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IAgOk+ap; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SZC4oKHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IAgOk+ap"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90B8E25400D3;
	Mon,  7 Oct 2024 04:22:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Oct 2024 04:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728289359; x=1728375759; bh=/759LKffaZ
	yT0TqWk5Gi+gySwbmLQ0cbNPT8swhvy2U=; b=SZC4oKHbaNvOVjd+z8J1g3Egp8
	KoyB//zRSW/3f+RWBTTa3LCu/wahV36IHxNhh5WPKQSERR8nz435zQo6Q3R/si3c
	Jeqf6urBTDpC8ANSRbntdKIoY4cx4DbZw70vsfwpQwwIQ03gUMEQML469shcPobJ
	W7iVSpAs44EuSRsBW6Xk/3sjbEKRt0qow7G21b3wGj3kyaKODaxEYQGXVUYCSE9n
	DSXlcirZRaXIQ20if4xgHjhDQgQfoKszh76KGFhWzz9SNowI6fG394WJ/nKgriK6
	yCCnXejZqelqJ/xUtnip1dQDGQgeZYMjrph/4a/tX38MoRJ+/BwjNCMGsaEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728289359; x=1728375759; bh=/759LKffaZyT0TqWk5Gi+gySwbmL
	Q0cbNPT8swhvy2U=; b=IAgOk+apT7eYJ+N3Asic5GSrx3ghNj3rmJFcollvU8LT
	K6ffwuwNnzxjy+PfwfDN5qRIj4DVHKy0Qex2HlNnqLPkJ7o/J0ScMjWTLZoSHSpA
	t02e+z82MyPELcAaQyualZFMmW5HwbrRqd4LJgs3zQFRS5JdJUUUs99jftfPan45
	ScG6qr2tGqpLsNmN3idblD3sFoyd6w8Uy62huF7rySZIkbDEEd3/7sc43K5TrGJA
	jFr4x9VJeQBRSeRetaCrc5uwKdQPEZeOic/nXb70e0cOpwEbPWVekX4GnAJOS2Ac
	QD2Y3l7kJnwl/H24Dzcx1RjIf5J4Gqu3MlwzunXIWQ==
X-ME-Sender: <xms:T5oDZ5XKxPwFG0orwilAgsDzGkpsuZ8fg_uy0mJj13AGZxLUCQTzwA>
    <xme:T5oDZ5k7Hq1IS-1gvYKBTPWxcnX58LP51SwU9eM9rjkt8zlWpodH3tBdiPW1jH9nT
    OuY8ZjUPGXW9SMBJQ>
X-ME-Received: <xmr:T5oDZ1Yu13UjM75Fj7Sz8RTlpyZPXXU6T1Qi9bfG1e87zPJg4CN3ZOPkaA0yjqY5hA797y5gn48kbSOe7WuH6JelwIPWy4HL5YvHVWdSF7bhKpWIgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsuhhpthgpgihinhhggihinhesudeifedrtghomhdprhgtphhtthhopehjohhnrghthh
    grnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopeigihhnghigihhnrdig
    giessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopegsmhifihhllhesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:T5oDZ8VqaxAKqb3TfkWXhP90obVbhfcnazJbIhdjmlAVC0Gt3PUhuQ>
    <xmx:T5oDZzk4if-u-IxKX4HoftH7ayMNnj0xCKzo-RbozC9B8c_ftHuRtQ>
    <xmx:T5oDZ5fCYtkxvmTH0huDrwPxGDkq8SKgfPgni8ALHG8ASZA2vo2Wcg>
    <xmx:T5oDZ9EVshHQLyAL8XtH6SRp4gwd32fLqeYz86a9KRnobTebl2Zj5w>
    <xmx:T5oDZxb_fQ6oyLNyTNqwkiOp2MFudQp59voa8rFLrPHk61YHpSap4JCk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:22:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2970f59b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 08:21:40 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:22:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v2 4/5] fetch: respect --server-option when fetching
 multiple remotes
Message-ID: <ZwOaTJ95r3Jc_9n3@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
 <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
 <39ee8dbef783f425e6a8b01a68ac01fde304b698.1727093878.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ee8dbef783f425e6a8b01a68ac01fde304b698.1727093878.git.gitgitgadget@gmail.com>

On Mon, Sep 23, 2024 at 12:17:57PM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
> 
> Fix an issue where server options specified via the command line
> (`--server-option` or `-o`) were not sent when fetching from multiple
> remotes using Git protocol v2.
> 
> To reproduce the issue with a repository containing multiple remotes:
> 
>   GIT_TRACE_PACKET=1 git -c protocol.version=2 fetch --server-option=demo --all
> 
> Observe that no server options are sent to any remote.
> 
> The root cause was identified in `builtin/fetch.c:fetch_multiple`, which
> is invoked when fetching from more than one remote. This function forks
> a `git-fetch` subprocess for each remote but did not include the
> specified server options in the subprocess arguments.
> 
> This commit ensures that command-line specified server options are
> properly passed to each subprocess. Relevant tests have been added.

Nice catch.

Patrick
