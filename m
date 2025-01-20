Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100635968
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737356882; cv=none; b=NbTP3emjrW6J4ZbcmsQbuMlLLWavPVXtczbLIU2qvTQzyMlRc7zNiezbiMTzTXgLX+ppQYEqd8836G4iqH1xEY7lSrPvVROdfFmdMIbmNUUYliWyVOrsY+EvBg2nL6JoZuTRmepuaBN+GN4zdo4ETnaLm7anV+DfJVEu6kG2z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737356882; c=relaxed/simple;
	bh=WkQFt3TQM5z8qC13oQ8/8or0PB6g3JFh6a8ahY/YOew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szJPncP6TnfiSQb7dKxFxdbux3mDmTaGf1JDZ/gODtXOBTo/dTmRhvPvHjpcM8wJ6NI7VlmM6o6vEQXaPOVmq6lILCEkYVSs+7Pf8xnHkG2ZfzXEio/laZnxHQqFe61uFKjKy7b2056+b4/E60ihvTeGwRuB7vodHSzJQSlt5gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F+4h8Et1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKJBU+9I; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F+4h8Et1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKJBU+9I"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E5FED114012E;
	Mon, 20 Jan 2025 02:07:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 20 Jan 2025 02:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737356878; x=1737443278; bh=UNe5HIJCcu
	xJsYJ9yFHQNmqikuJLTvkdZyvz4L54Bc4=; b=F+4h8Et1WOY1dxx1GhJCuSzwWH
	qg9LdWGJ9HCKjYmNd45aJGbGeBldDq7paV/RYnc/RW8OhXUJG+vsnekzPaqcHTAW
	of2yLsYIPAEfo7B5EfQ2KR25DJEPivI29JnhCTq46WZ4Hhrh2Ei6+IMr/MMwBKe5
	pvx2k6+T5OZfFWeEGYJSXtvW+wvKpAvIMgBjur2sLOIrZnooY5bV1Ndo1eINbQSf
	zAy2WK1JvVf3cUlWWYp4dtnxIr4RCcqnfgV0OyYKwAlgjabfsejO/4mQYWJcZcyZ
	s3TTZpc6r50AeOUh4LypsJ5/02K/Ro9d80E3G1UoHqwRpu51FqORSBYCS/oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737356878; x=1737443278; bh=UNe5HIJCcuxJsYJ9yFHQNmqikuJLTvkdZyv
	z4L54Bc4=; b=jKJBU+9IQgtAy8hyVMlgYh5JmP2JAdZprsiIKx1V0AGz5joSdfw
	iOuJuVUkN+iIZJ3GxQc6jTTo4D/OaWsHYhEWurjpG0WhdjUdcN7g4YzBjFin+6g+
	WNaAPXLYe0XACDGlgYU/S1NafLE/M9/Bj7e2uMpSeeW+d6AzDVYs00aPr/eGvlzl
	zV+H8zt39RJxZW7dtm2iOlEDtgdJv/g7dneUyzLy511OyMnSCJi/H0WhFlfF8WNS
	qvIavixqLkFCvdNJ+hm4B9CINcpBDafAwyRiBTxZnO2yO/4buIIYR2h5y4ZXf99k
	PlNIRjDw3r8WXvRnqaBeetme3wYwmRcOIlg==
X-ME-Sender: <xms:TvaNZ9yKrtsqupywFYduH8MCkUsfK5Kl3YYdWdtEDlwrgarrL15ZLA>
    <xme:TvaNZ9Tj2GzQk-bAl4TGpE0jMymyBDm5e9GehZjANFXVcvfCi7UOEbcZDfoBzvLKQ
    Ydpkr0i5n44gAzm9Q>
X-ME-Received: <xmr:TvaNZ3XR2QuJ4o4s4Exf7nSnYhyELvXxS1KYVNqamTYKIsBUYxxcW9CxgHZKnfuwaO1AmloRWyvqNpLMcAL-msuFoKIvrXLX3No9wpJJi77vCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    peffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkuc
    futhgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeek
    ueelvddukeeftefhjeetgeegheekgfdugfeugfevuddtuddvgfelfeeigfeujeenucffoh
    hmrghinhepghhithhhuhgsrdhiohdpghhoohhglhgvsghlohhgrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgr
    rghrthhitgdrshhivhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:TvaNZ_i4rJD_r3HO7bNNG8VIayzjUkzF1u-mpSNbbUf8ul-xyh5Q-A>
    <xmx:TvaNZ_BVnZichlohDgtdnsXlhWGpH429zjgsTQ12eHAFm5ZFIkUd-Q>
    <xmx:TvaNZ4LTWTARjKYy-REWEnzy8rhQlNuXKq456by_U3freQ6JPqtFog>
    <xmx:TvaNZ-Bru3RUYFdcLXRkJWnLRGNMK9Huo_clFlHjZPn0DmnmAv9Feg>
    <xmx:TvaNZ6-WeoAu-YJIHj3SF8nLB0xINnw94zhd_UMuGys4x7_jYk7IufsF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:07:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90cd98e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:07:54 +0000 (UTC)
Date: Mon, 20 Jan 2025 08:07:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z432QXJb_TfzNBa2@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>

On Sun, Jan 19, 2025 at 03:43:29PM +0530, Kaartic Sivaraam wrote:
> Hello everyone,
> 
> It is that time of year. GSoC Org Applications for 2025 are open now[1].
> They are due before Tuesday, February 11 at 1800 UTC. It's good to see that
> few contributors have already started working on microprojects this year :-)
> 
> I could help as an Org Admin like previous years. I prefer not to
> volunteer as a mentor this time owing to other commitments, though.

Thanks for your work, as usual!

> There are no noticeable changes to the program this year.
> 
> The GSoC contributor application period is March 24 - April 8, so
> (co-)mentors and org admins are already welcome to volunteer. As usual,
> we also need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2024-Ideas/). Feel free to share your
> thoughts and discuss. It would be great if we could come up with a good mix
> of small, medium and large projects.
> 
> Do feel free to ask if there's anything that needs to be clarified.
> 
> Just like previous year, there will be a GSoC Meetup in Brussels during
> FOSDEM weekend on Saturday, February 1st in the evening. If you are
> around, interested and haven't received the link to register directly
> from Google, let me know so I can send it to you.
> 
> [1]: https://opensource.googleblog.com/2025/01/google-summer-of-code-2025-is-here.html

I'd be happy to mentor this year again. A couple of ideas:

  - Consolidate ref-related functionality into git-refs(1). This would
    mean that we add new subcommands "list", "get", "exists", "write"
    and "optimize" to it so that we have a central place to manage refs
    overall. This would replace git-update-ref(1), git-for-each-ref(1)
    git-show-ref(1) as well as git-pack-ref(1), which would of course
    stay around for the foreseeable future.

  - Refactor "environment.c" such that more of its global state is
    instead stored locally, e.g. as part of `struct repository` or
    `struct repository_settings`.

  - Create a new command to query repository-level information,
    potentially making it machine-readable via for example JSON. This
    would move such information out of git-rev-parse(1), which is a
    somewhat weird home for it. It's something I have been thinking
    about quite a bit, but it wasn't ever discussed to the best of my
    knowledge. So maybe not a good fit.

I'll keep on thinking about potential topics.

Patrick
