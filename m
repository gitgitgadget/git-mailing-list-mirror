Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3D1C2DCB
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387932; cv=none; b=fpOM9wufuzpmLjVzX5C2a5u+PKg5gb41FjJrHNjKE71kj4e1LNh8HDoG2tTOU4OeyrEqk1Kwlwph8FQcp5tw6eTwrKn0x8BWxYLWiPiZ45laiRsQgRmc/5db9WXddSICki/n3ged96o28lXpCaa9D8Vh/iM9Rb87PX3ClExwm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387932; c=relaxed/simple;
	bh=7CA2FejnLqHKwA3ebM1yyu1DwZLMUHOIJ+VRxIPFp4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY4HpmfXoXbnkbK5Os+BVN1/gfMm6OjG7h6ubxlPev5Baw8BHKQRyRxuVcBx47usHNDltHWj6M+yep7V8LPjNl07rJKT76V3dPqSsfjsOJgkGujPwkHfKQ7GOEzAjEcPpSQxsZJd2v1W8/6Scm9ydPCL7M44I83gqhGJBqShQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IohPJheT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DswFgwRg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IohPJheT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DswFgwRg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 30FB91380477;
	Tue,  8 Oct 2024 07:45:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 08 Oct 2024 07:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728387928; x=1728474328; bh=keVKnzxo12
	MzSZfVIfkrr+xynejIKrX/yw8Y2ID4kq0=; b=IohPJheTFqVRiJw2mBjrNApaCK
	GUIRyTSwTSukRnqzB05qHNij8OLDWasifziPjdasQFv/8PNB3MmxgY0jKWcayWfR
	nxySTqr1QAlwROEoMB0JkWuszzngZl3MNZ0Z49PDv/93j3OczcGCRYzOV/qp4nTl
	3H3X61DHH+OxhEV/3BWqAvOJdo6bj2GbjTqflO0KHo6pq795rX9MaSZzyKtqlqvq
	GpUNodkZyYKu4G2jl5kRa9lpi6VZaOkPfCn63D6QP+o4GbvDEq/GXvnS1TTD5lMA
	wvCXOR3c4cXIpJ0csJoS7Ztwyl43TQptACXzUW6fjpjY3GtlDBLuYnecT7yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728387928; x=1728474328; bh=keVKnzxo12MzSZfVIfkrr+xynejI
	KrX/yw8Y2ID4kq0=; b=DswFgwRg0+VqU8ZuPDlN+aUz9xguhTMV57P0J4wsrURK
	+Hknj9tiocGDsz3eNfdkW5XhHyMp5b8YXyNqL39dnRYgA0aanGL78fAATzOCbRWG
	F0o60H0oHrtlNPa46rN3TDDn0o5/hTq6tOVOmBsGgaFGMPaL+Bdao8tU0bb/WwjB
	P8FbDYjdVUaS0FKRPI9iWiS3qGy8curG7mbl+27fTmhoqweeRT/4krNPfGX+0A6K
	ldOEll19wWDQzUouL0roR3E7eus/JJsunR7ncT8Qt4I7OtmbiSbJ7T8Ur/WwWjom
	KfobHcSus6cRao5FUn9BxSmW3UR8bodmnRXbhs2Ebg==
X-ME-Sender: <xms:VxsFZ-2bCypkQDkhDH5wuFZlIS3d6pPphZ2E5PcRfeFqE8mcGWxsLw>
    <xme:VxsFZxFueuGSfJSgSUYLpQ29a0T1v-h7UQm5KXMTrUUiCE8iMTfhKUhDVHYANaI2Q
    uv8Lfq2KHL7SZ8MFA>
X-ME-Received: <xmr:VxsFZ257EC0QVK5j66SnKG-slODj-rqGP8-mgFDzTpsTj4H5cBPzNfLC6YW_pnCnctQkynQwh5Z9KkZeoonBVX8dPSKNhu32voy3E9rk68X02BI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepudekrdhgrghuthhhrghmsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    jhhithhhshgrkhhhrghrihgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgshh
    grmhdrkhgrnhhoughirgdutdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:VxsFZ_3NNHHFe6ZRY0s3jVH0ogYpZfNt9G66FSdDaDAf7FS7c7-rXw>
    <xmx:VxsFZxHHDCxHuudokueGxknTE8XPozMMUaMGGvwc9ltiw-N1lIGgaw>
    <xmx:VxsFZ4-k3P7xCAJYPHiDz7CSw_5pPBRKm8dyzBBNi68KDNncVVEdFg>
    <xmx:VxsFZ2kcPOiHenfm0gtI2vu-kHAIZ93PozwPOtZ3mx-ToZnA6zjU3w>
    <xmx:WBsFZ1hvg-xqD_tXjIPiLHxsqPVrZIZRbzunZPSl3FaLeGdQEHT5-fn7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 07:45:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f204f7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 11:44:24 +0000 (UTC)
Date: Tue, 8 Oct 2024 13:45:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: git@vger.kernel.org, ajithsakharia@gmail.com,
	Gautham R <18.gautham@gmail.com>
Subject: Re: Bug: `git maintenance start` is likely broken in 2.47
Message-ID: <ZwUbTJS-mg6cCG1e@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>

On Tue, Oct 08, 2024 at 04:20:19PM +0530, Shubham Kanodia wrote:
> In the most recent release of git (2.47.0), running `git maintenance
> start` results in a segmentation fault error both on mac & ubuntu.
> 
> `b6c3f8e12c` seems to be the first bad commit.

This is embarassingly easy to reproduce. None of our tests catch the
issue because we are forced to stub out the commands that run, and the
error only happens when _not_ stubbing it out. I'll send a patch later
today to address the issue and will also think about a way to test this.

Patrick
