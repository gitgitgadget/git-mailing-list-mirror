Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBB12E1CD
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420136; cv=none; b=fxHMYEL9AlmDJhdiDOnphu1MTB+FOtnruglQoGrMjb5Kg3qrZUDDwzYwKhhmKIHHL+ythD/VKqvOWo7rDPd8KZOJyHwcCr4PpPBAJFd48IhY03aWTmTIqfQ7c9llmi0p+BTFZmv///U6opSK3Qd/dVl7gWjvQz3WwdkpImr3UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420136; c=relaxed/simple;
	bh=Nt5T8qpwe+yMLLBbr3Yg/vkm2Tf6ssEY2H1YYp8+K10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3GMk7MSUntEmRMV5hFDBKlY3y7e/At5PPULGMA2FvpkhCpaxYZz0IryaVuyZHoScCY+CQ7gnPr+33XR86fq2O9I0jSg8iY8Jnt5U+Q+Lj+90WuihWzlpTpGT3u8tQQsO3aUWQR6HQeM04kAhJFmxEkILFQzxLpg3oGWxkquHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tkDCTOd8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYN9vKC/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tkDCTOd8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYN9vKC/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5D811140262;
	Tue, 17 Dec 2024 02:22:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 17 Dec 2024 02:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734420131;
	 x=1734506531; bh=tBrZRK3bLtdOyPoGDpBpeFpR6KhcwG6cI2n5jV2+kHA=; b=
	tkDCTOd8GL8XuH42Vl6lJXNB39e9iv0kd2uhiGcv7sA1nbGbgSgY6z+NK6oAccxm
	/udKD+1lbEeaTuPYaHehT3JH4tqkxB03jzF6GrYbGxpgFURRNKeQyR4Y+3MKxnLx
	FkhjOcwjMx0AFKgQmkzF3t7B6YkqrQGKFgsDaIhcBNBaT+5po/dgUvPYMaRtFWMW
	CILOlNyiP6clCUYt3uicnIauf2Uccd0xQfmCclnr9RvE1WFExtqr3ZzQzImPb5vl
	CsKq6cVSyv86mm7alazxhD0LGeHtO9NjcJlW1ZLIc8fpPbxexaPLZdCjRsddRPfS
	KhrSn5xTkGX5qxnOqSid3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734420131; x=
	1734506531; bh=tBrZRK3bLtdOyPoGDpBpeFpR6KhcwG6cI2n5jV2+kHA=; b=H
	YN9vKC/f8P9DTzwqwqlLJPfhLZjSu3gup7ulVqBmf1BWhaOGmg3ufRK1PBvgxpwV
	xxdohxWmYSrJiTnt3eGOTAy9R2XDZhrJpsfw//6MhmCZ00Lk2QjB1gP9UkNg3T/v
	TAcGeSg3e03i35taxP16F8+80i9dO4hqh5DXYUhGhsSnHtR9o2ABtZY/Yh5Q8yrh
	Ci6J59JY88BiRVxvce8BkXIsYCZCVMadx197RbFg4MYpGfFp2Gj89GxgpURh4KyF
	gc5InnqpI0GnKEfCRxBwqn20Ux+fdj6oTZ/dAioOT6Z4nqqF8/H7J8gqhCa2NlEg
	KzfDVz9C0LKVlDm3+yAkA==
X-ME-Sender: <xms:oyZhZ2W8Cmf_iOKrbx1CDXOhEO15gqUwk5d8x951OxHX2TyPFNEj1Q>
    <xme:oyZhZykR5w-XUbP3oxdk78oxvhTWONukEbIo7eDVMRtX0VzGi77HkqNbFDSWtkH3o
    pVu4XsPXr2JGx5N3Q>
X-ME-Received: <xmr:oyZhZ6Z8-bXMgZ4F-q2p_Ct-7Vg787wi6hmZhoh0lbpaWwnxuW46SYuphvt6sbq0fYgSflvO6M3buZMWbfd7lpktazNj48CkA4eNdsVkqdTFVXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oyZhZ9WiIsPyCAtWr2k_IHBP9pqHXBRppbl0Gw2qpDsNYnZguJl0Aw>
    <xmx:oyZhZwl3qkKi_bfkLwdR5XOMBZTqJYP8d7TGZeZc5yzN1AbzRkdXQw>
    <xmx:oyZhZydhuZTJGx6QdZT47t1Mr6FLEh21BrHNGaOPkhO_5QJqae24gA>
    <xmx:oyZhZyH5yLR60V6WUlzgariu6ogUVY4TVerdbNnMPhDv2n0mxeYa8g>
    <xmx:oyZhZ6gkiHhP_jji7eIAtWVKLld25QD07PWAtD6H49rx5jhG4QDBU9yY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 02:22:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e954ed0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Dec 2024 07:20:25 +0000 (UTC)
Date: Tue, 17 Dec 2024 08:21:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
Message-ID: <Z2Emh42DJkHFGWq7@pks.im>
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>

On Mon, Dec 16, 2024 at 06:03:03PM +0530, Shubham Kanodia wrote:
> Remote-tracking refs accumulate quickly in large repositories as users
> merge and delete their branches. While these branches are cleaned up
> on the remote, local repositories may retain stale references to
> deleted branches unless explicitly pruned. The number of local refs
> can have an impact on git performance of several commands.
> 
> Git currently provides two ways for orphan local refs to be cleaned up —
> 1. Automated: `fetch.prune` and `fetch.pruneTags` configurations with
> `git fetch/pull`
> 2. Manual: `git remote prune`
> 
> However, both approaches have issues:
> - Full `git fetch/pull` operations are expensive on large
> repositories, pulling thousands of irrelevant refs
> - Manual `git remote prune` requires user intervention

Fair. Neither of those issues feel insurmountable, but I can see why it
could make our users lifes easier.

> Proposal:
> Add remote pruning to the daily `git-maintenance` task. This would
> clean stale refs automatically without requiring full fetches or
> manual intervention.
> 
> This is especially useful for users who historically pulled all
> refs/tags but now use targeted fetches. Moreover, it decouples the
> cleanup action (pruning) from the action to fetch more refs.

I think we need to consider a couple of things:

  - It's somewhat awkward to have maintenance jobs that interact with a
    remote, as that may not work in contexts where you actually need to
    authenticate. But there is precedent with the "prefetch" task, so we
    have already opened that can of worms.

  - Maintenance tries to be as non-destructive as reasonably possible,
    and deleting refs certainly is a destructive operation.

  - We try to avoid bad interactions with a user that works concurrently
    in the repo that git-maintenance(1) runs in. This is the reason why
    the "prefetch" task does not fetch into `refs/remotes`, but into a
    separate ref namespace.

If we want to have such a feature I'd thus claim that it would be most
sensible to make it opt-in rather than opt-out. I wouldn't want to be
surprised by remote refs vanishing after going to bed, but may be okay
with it when I explicitly ask for it.

At that point one has to raise the question whether it is still all that
useful compared to running `git remote prune` manually every now and
then. Mostly because explicitly configuring maintenance is probably
something that only power users would do, and those power users would
likely know to prune manually.

In any case, that's just my 2c. I can see a usecase for your feature,
but think we should be careful with how it is introduced.

> Happy to submit on a patch for the same unless there's something
> obvious that I've missed here.

I'm happy to have a look in case you decide to implement this feature.

Patrick
