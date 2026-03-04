Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6136AB7E
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644937; cv=none; b=sepiYrX/zVjoX3c3niLVQjdo/1ekjUCVS6nqBtShMhiMaL2R9IHmTWaRKVDCB1hKOTkrBNyZO2qQtVdxsJ2oS64UZIkQ2ibiHOEXGR9WvvyTm05BL5cJU5p8S/H6addV+bUFEiyienY9HsalRIFqliJW3p43bCuiEVEEwCFg52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644937; c=relaxed/simple;
	bh=u28xW1gSoQWRvJbvhpvdQdgfsZqu113qHUiWDQ7jl5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBejagFV1NRTszzCuUpl76HDcTJKYdx3agNOT7mqHIsZDn42rE7bycx+73RakxDiD/UIZgoIciuwJ+V3Q7Q7P2J4iBS6u+DQ0EPbPN84jSSccmNBQLEo09uSp7tvif72qAYzEKo0mYGF/c3ypyk744ajnzwDgRa3Y8vNPq0c/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SBoMe1oW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2AzjCNB0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SBoMe1oW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2AzjCNB0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B869E1D00065;
	Wed,  4 Mar 2026 12:22:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Mar 2026 12:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772644934; x=1772731334; bh=lIEIMALcCe
	+WEk862D9CSlcqgn8KJTBB55FQ1zaGtXw=; b=SBoMe1oWjj1lFjspy/8hgz2m0c
	rDNBT2g7ZMXZh8FhkXLGPS99QtWiWXJ1qpzulSg20U5waqmb+TKKu8ZdxRs8mRtO
	ghi/UGv6A86MvIEQAKtPvtxoa0H5X0liaWGVCqevIgnAb6wmtCMQSBVFbFIDhmfb
	yT8HSJvEbiHgMMZX2WsRn97QsfAErrPioOzFhatKa/tdS6p40uCeAd/sxWbtbOVQ
	xrYRK9MtNtVm8Qf4RI8Y8vFy6cOdEzEa/2g9rIbPfSfolU6PVl98zErx0BN7NXO0
	kamwm+KCbI8sQAyv+Q5ixwOR6dg3ACxRSuLBiKXJk4qPdULYGjSaLmaosWhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772644934; x=1772731334; bh=lIEIMALcCe+WEk862D9CSlcqgn8KJTBB55F
	Q1zaGtXw=; b=2AzjCNB0OlkI5+b4e+bz+QtJLBxlLkYFHLWqI33uEZwboqi8fmr
	BZhwN7ewgWwP6KE9XKsQ2abjKD9EOFdefecjZ3zOjDx9HEUxCZdSYrXsY6VmmUjv
	XPf1uJA9SKMY+tiMwmaFkNN1smhC8CUsEM9CPiOr9qPrM2EkaJZMD5ZGQMvPOKGz
	5gVMaKqLxfys0oFBlbM4pzl2BvOrSNIhjNAGOOMIQvBScRvFIoNcqwr8KVCaGln3
	RpKkwhtA4lm5bYSB+FKVEI49ZiXNQ4lRP6sbUzUgPY0Zw7M2Kv7M0wFd3nB67BcU
	RH9ZHL6u6jtvkkQbxB9Sc8XhFNMCzSrwL3w==
X-ME-Sender: <xms:RmqoaQXu2Un-UAupQp8ujhsJ5AJop9fCLN6ImxSl0ra8n8jMk5IKrw>
    <xme:Rmqoad5FLOTuI0ymMX_y55Graqg25ckUxW0EyIy3aa8eGmgNMfH6tLajI8yMuGbLq
    4uEGuxU9IrDsl0fLIHTmoIIBr8zygEybSryNWU8Ndnmxd8g8dREDA>
X-ME-Received: <xmr:RmqoaboCvUAPC-ZB06OmURMGssDYBpJoW-YZCUw9HHYjj75c6pXS1qphPonEO38beAOWdVC8Wy7RaJiCGvLT92T_YESmELHn2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlh
    hmrdhorhhgrdhukhdprhgtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RmqoaQlklb8I3LjfM_rvRHI-UCihzGhScbE4Oa3r8K4_cQzPv_QePg>
    <xmx:RmqoaXMk0N5ZdN7qujoJ6dgs-3d3i4Mj5-EYj0F-o0_50jFT-GlYGA>
    <xmx:RmqoaUPbMDLpYByeKxbOOLNaR9iduijXFbQmY3kb3Bm_BrhnoqKh5A>
    <xmx:RmqoaYhp02rxF4wy1G1JV_clvLtO9T4mAYJaz7KfrPXF7kdIePgh2g>
    <xmx:RmqoaZcrXxJXaN3EmWNOf8bMIqap9NSJkQnJA5XzqZzDm_D24oOk7Ald>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 12:22:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Li Chen <me@linux.beauty>,
  git@vger.kernel.org
Subject: Re: [PATCH v7 5/5] rebase: support --trailer
In-Reply-To: <ac09b00d-0566-405e-b7ac-b091448e0f4b@gmail.com> (Phillip Wood's
	message of "Wed, 4 Mar 2026 15:53:07 +0000")
References: <20260224070552.148591-1-me@linux.beauty>
	<20260224070552.148591-6-me@linux.beauty>
	<824809c3-72ac-43fb-8a93-4f48e0727e6a@gmail.com>
	<22e1de8e-935d-4efa-9fa8-ef8d9b4ffc6a@app.fastmail.com>
	<xmqqqzq0boi8.fsf@gitster.g>
	<ac09b00d-0566-405e-b7ac-b091448e0f4b@gmail.com>
Date: Wed, 04 Mar 2026 09:22:12 -0800
Message-ID: <xmqqseaf8q7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 03/03/2026 21:18, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>> 
>>>> I wonder if it would be better to add the trailers before the signoff so
>>>> that "git rebase --signoff --trailer='Reviewed-by: ...'" adds the
>>>> "Reviewed-by:" trailer before the "Signed-off-by:" trailer.
>>>
>>> Why is that? Is that because that is the practice in this project (and
>>> maybe others)?
>> 
>> I do not think it is a good idea for the above sample command, where
>> we can argue that the intent of the user is to have sign-off and
>> then reviewed-by, expressed in the order of options given.
>> 
>> If we want to control where the new trailers are added, perhaps we
>> would need to match the --where option interpret-trailers has and
>> let the configuration honored by that command take care of the
>> ordering.
>
> Let's leave it as it is for now as that matches what "git commit 
> --signoff --trailer=..." does and no one has complained about that.

Fair enough.
