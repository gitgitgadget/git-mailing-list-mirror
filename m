Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5DF1A275
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466758; cv=none; b=mAb49XyziK9l8U8nZuwjMAOgsYCwvKZc5yMaZnsG7EikiI3joO2RRWCDp3U36fGmuT/wIMmFthfnqcSCWvjo7hoY6aq9Qh6ANB4lQsrM/6lutNzMQg5uywFPeGoJZMBBVU77CfvuK+2OCJ8RLBStOPm12EQGOeYKvG08HaEg8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466758; c=relaxed/simple;
	bh=onN2E3tvQ/nLYeLH7ABLs5E+SkYOx9V66L1+MGSfRew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iwSze0byaoSEQ7+W8RH2jHB8c0f+L0KjWN1qFYkoBGG0fhu6Trh08L9apyBhKIXHlplnml4Ai4qeecLNmnC2Cy/eq1q3TjeZrSWvCxv9qrImSCiy4voHTrRziyOQUzYq1avFjPs04dzeN1lBa7EfNs5AHb1MsQ0yMBR+FwkjhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=an/TgetQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oiyjUr43; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="an/TgetQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oiyjUr43"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 937E31D0000F;
	Sun, 10 May 2026 22:32:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 10 May 2026 22:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778466755; x=1778553155; bh=82loOypB9v
	7TX6H6Zzqn5PDnEw+u+0No/kxjPWOgarI=; b=an/TgetQB0mHGV1lKd51ZaQq9H
	WoARhoWuN12PPbDG5sutJF2S/98zLEsxXyOaBK4RWzYCGWKXbmWp29vRmewUi9Sh
	ImW7zVEPRo5OQpWOoD74v6xDdA6xj39LFb5xQV3uZf91T7MRargBHBJXj+mESojM
	UW6bDWn8afnOYGjPmZMe+etROIz94gxQT26mEJCkE1nLOmL6kKhoUf5EbCQm7W7q
	cjhx5zi+bRQexWnikp2gsqu7/5ZAABmv0J92SwK2roEJSG1zu7XKJ2Yv5M9uIrl7
	kwXpD4UdO3aViJt8siYPsI/txC+2BncqIcD4tf/adObW4VjAQQgYUbUjJnJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778466755; x=1778553155; bh=82loOypB9v7TX6H6Zzqn5PDnEw+u+0No/kx
	jPWOgarI=; b=oiyjUr43xKuTTBb3Y9OCSAJ13MzC3/jvOctFaOVDjxaBJS0E5VW
	1cyNvxd2INVoueAM8BDIxEUoYInjppoqlFDJgCcNt7qBY5R7iDWmd7llxWs/YsNN
	9RGF8/L3ysg9dmCzp9fuhUxvNNK8NGwYeDJL+O8WXEJr1ZB4UQHZJD7LiejqqfR/
	59wtEDVOkq1y+IaFQFxvqLsw17YAXSJE13jOGyz5eUnlcmzHp/LzUCI/oqJHSmEj
	HvgJeNnA1W10AG5lL2laLzjpl6LKUxc6tOXjRXmdu454bI7SmymYt0sdaVome44G
	FIlaInvW+i4i4P//qE+fOjapVF+OzceibVQ==
X-ME-Sender: <xms:wj8Bar6UlysQ3lk5zD5hshWUWJzU_wenukeMvl59yB2VVHP6EC_TWw>
    <xme:wj8Ban7JgwVVqu-toisI2LlT864LkUP8vFkkSrJeHNzv5uoQ9qAeukbjOUnHtmujr
    tyGhi_CJyVrkkt7mOC9vuXjd6_rkFTzC7PM2vCIjlWAJaIQY3T_7A>
X-ME-Received: <xmr:wj8BancMNjIXYNL4Ld6l-gXyqs6-K0hDNUyLImbK0qany61MqYnxBa1QBcVfFm4sawU5wHghgBdC2uL-SP58KsWMpXKHEAglYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohgvrh
    hgsehthhgrlhhhvghimhdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wj8BarBGCnmEZ2uDQyy-7r_qCTe9XvmjI5dJPBGXRqhuYtmA1dJr8A>
    <xmx:wj8Baq9uYzzXFNd3_3Yr8X9t3U3U43o66si8sKYQAnuxIMlYDrZtFw>
    <xmx:wj8BamKosSXprF-zL_6vgK9Xt8FgoR-Vm4rDEBcJibPtAjTLctQigw>
    <xmx:wj8BajjRL2hXuCcKaX77e-_azVmfHvG4--L2fCKpb8PccZkMk6nSsw>
    <xmx:wz8BakBWtIPPzY_I1zzF2Lu833UKOvSAi9Q_6cIZpT1HV1lFVriMVIoG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:32:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Joerg Thalheim <joerg@thalheim.io>,  git@vger.kernel.org
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
In-Reply-To: <adYvSZeN0ZVqwRhi@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Apr 2026 12:34:49 +0200")
References: <20260403100135.3901610-1-joerg@thalheim.io>
	<adYvSZeN0ZVqwRhi@pks.im>
Date: Mon, 11 May 2026 11:32:33 +0900
Message-ID: <xmqqcxz2vfpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> This bites in practice when running `git worktree add -b` concurrently
>> against the same repository. Each invocation makes several writes to
>> ".git/config" to set up branch tracking, and tooling that creates
>> worktrees in parallel sees intermittent failures. Worse, `git worktree
>> add` does not propagate the failed config write to its exit code: the
>> worktree is created and the command exits 0, but tracking
>> configuration is silently dropped.
>
> This very much sounds like a bug that is worth fixing independently.
>
>> The lock is held only for the duration of rewriting a small file, so
>> retrying for 100 ms papers over any realistic contention while still
>> failing fast if a stale lock has been left behind by a crashed
>> process. This mirrors what we already do for individual reference
>> locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms,
>> 2017-08-21)).
>
> Famous last words :) Experience tells me that any timeout value that
> isn't excessive will eventually be hit in some production system. Which
> raises the question whether we want to make the timeout configurable,
> similar to "core.filesRefLockTimeout" and "core.packedRefsTimeout".
> ...
> Honestly though, I'm not really sure what to make with this. We could
> of course also add some validation that the configuration we want to set
> hasn't been modified meanwhile. But that would now lead to a situation
> where we have to update every single caller in our tree to make use of
> the new mechanism, which would be a bunch of work.
>
> And adding the timeout doesn't really change the status quo, either. We
> already have the case that we'll happily overwrite changes made by
> concurrent processes. The only thing that changes is that we make it
> more likely for concurrent changes to succeed.

We haven't heard any response to these points raised in the message
I am responding to.  Should I still keep the patch in my tree,
hoping that a responses may come some day?  I am tempted to discard
the topic as it has been quite a while since we last looked at it.

Thanks.
