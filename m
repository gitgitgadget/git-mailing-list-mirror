Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62E72613
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056741; cv=none; b=AOBOe3ABbCKOP3q7i0RXfZsITvA3et7oRDC9AxD3Yar3/g7kb3hepRwHqIebOYq3l8tr6MnBaZqBYWwzekiRxRNlqLB8+1hTPo0v9PhfSjyLQfUwQ+NxwchGDSmK0tWzo2Vv84LiSFKjPudasOvsQTxmur5l6FycQNtF0X50UXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056741; c=relaxed/simple;
	bh=pR9HPHXRsSi3j934eMxN0RBrcG5xIws5/o2Jb6NgUa4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M3VkyfpxxwWqIeo6Y9uD31XJVLTQgkImk8jKb4IYFNohjPK+FsXHfLJGQ+OeBlRGqwIx973qIQCx4LeovNM4mcTB/uxzVSYdDsqHRovQYoEnkiM84caQrJlR9D2DsuQViBLe1btsSsGb5iCCvR/kVSiyJe+U2sfuM3nGX2lJFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ya00P3XL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjRvCbZR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ya00P3XL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjRvCbZR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 875571D000AE;
	Sun, 24 Aug 2025 13:32:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 24 Aug 2025 13:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756056738;
	 x=1756143138; bh=IzbuoFh+0VSv9u0cXpXfbMHDqrvvpwJiUqv4Rz2ihPw=; b=
	Ya00P3XLi4BgLpom0lTdWmuUOINfNWT9EzqOJG0vzwCureH5jEFk8PvYmlr3r93E
	ohVgFYbkCRnjJ6qxKzqq2WD4Wa7Nl42rs5/uIYJYE1dkGcsZbEPlk+ueCozPfIs3
	r10r/a+y27TQEAIIdrURCQtLSoLoLYA7mAnRoTeNoMVJ4vGZT5RvTHmihfbav9OA
	ZTIexnFHXKYzDI9EUMum1iItiy0L+G8SemCRf4PXqxPKZ7CcEqG2T7DChjH/3XHZ
	LljR2yG/xIavxbbhUTIFk6vUeaohv5+ljnPHqYvQIHB1vyCl3bgyfWtKJCKLaQAz
	KgPMThIa7ZpbKyDx2gV/0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1756056738; x=1756143138; bh=I
	zbuoFh+0VSv9u0cXpXfbMHDqrvvpwJiUqv4Rz2ihPw=; b=AjRvCbZRJ67Tk7r5o
	FbX2qgdgCm7aL0HWmxBNdVRGKbrS+KmxQd3L8BVkRIJC3/IFH0cjTi0m2P6AAtn7
	/MNHhY/UvCv0eJnNp5r1xrJkxgkMLjuizjPF9uRe5ba/POAiATNkzflfa6OwVnNI
	JLf1CLqki6n4GTCV4JZQ2ld9w9AXAePRh113/auozkelAUgnwNssI6cSQmln3DvB
	pvfhN8+6t11cSnq3/alabr0+iFz1CWheytO1UuVygs4fRR0BUHmsi/Uet2Hr1p8a
	jdaVVMdTL4XyY1naBQBt73ipri5MUAymiHtVTpksDkWUbx11qOX/C9O3huhRcv/L
	up3DA==
X-ME-Sender: <xms:okyraIU4_mRMaxuQ7vqDzgHjXBfI171AUgHJf-56H5TLhfxyq9Ptvy0>
    <xme:okyraMmqlx-Mmnkk9O9Z-yX6HAasnAwoqrbJCQtkegY0iaQjHm71JfgmB1bfv_ZU0
    isw3Z1kkbVOwbtmpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:okyraAbJrsizMTWIVZWRusFfUOz_PZt5wJeusATVTwO1lY09g9r2AQ>
    <xmx:okyraEV5VeoNjHFd26ybVjYgbkmMThhn8atB4pSV-dLJFocJgDzYFQ>
    <xmx:okyraM6LjNA0rSK67nRCL78V1JSR3422K8bJLHQU4R-Wv68IyjvbfA>
    <xmx:okyraHhN73JqRCNtTz-ESef30TmrqE_Q8O4WAzL3200xD8neYdti8Q>
    <xmx:okyraH5e4JCGY0WOkWYkA0sGf2V-OMMpyln4UE2SdOIS8cJFZLenZG-m>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1EB1D1EA0066; Sun, 24 Aug 2025 13:32:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ate3QFRcz-LV
Date: Sun, 24 Aug 2025 19:31:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <cfb5eab0-ae72-477c-91a7-e9198ef7464d@app.fastmail.com>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy history
 editing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 19, 2025, at 12:55, Patrick Steinhardt wrote:
> Hi,
>
> over recent months I've been playing around with Jujutsu quite
> frequently. While I still prefer using Git, there's been a couple
> features in it that I really like and that I'd like to have in Git, as
> well.
>
> A copule of these features relate to history editing. Most importantly,
> I really dig the following commands:
>
>   - jj-abandon(1) to drop a specific commit from your history.
>
>   - jj-absorb(1) to take some changes and automatically apply them to
>     commits in your history that last modified the respective hunks.
>
>   - jj-split(1) to split a commit into two.
>
>   - jj-new(1) to insert a new commit after or before a specific other
>     commit.
>
> Not all of these commands can be ported directly into Git. jj-new(1) for
> example doesn't really make a ton of sense for us, I'd claim. But some
> of these commands _do_ make sense.
>
> I thus had a look at implementing some of these commands in Git itself,
> where the result is this patch series. Specifically, the following
> commands are introduced by this patch series:
>
>   - `git history drop` to drop a specific commit. This is basically the
>     same as jj-abandon(1).
>
>   - `git history reorder` to reorder a specific commit before or after
>     another commit. This is inspired by jj-new(1).
>
>   - `git history split` takes a commit and splits it into two. This is
>     basically the same as jj-split(1).

I think it would be nice if git-history(1) called the `post-rewrite` hook.
In particular for Split; then all the possible rewrite modes are covered
(one-to-one, many-to-one (squash), and one-to-many).
