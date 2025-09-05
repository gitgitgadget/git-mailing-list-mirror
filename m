Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD62DF6F7
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068221; cv=none; b=VHJUx5sbMBvu+/gyDH79fSgyYju8tQ8T22PqXsqa/wla9T9w0X1NglJCkjlW3mgRGJR8JEHs7uNkVwCFS+OpNiLaj5PEXzUvVnTHoOHS7MKpcf51SdQ1UGKflj7YO6o88Y+rQtE1OIrcDXzF1p/ptRVqHuco9SOz6fjoX7DwkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068221; c=relaxed/simple;
	bh=eDUznvz+tnanO5UHvYqNjaXkyuasqQXfRQK5b7T/5EE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kIxPYFcQ+YQdZ7wjp85autbYVXuzqM+S2Z6NSYkW4KyGvqugpppC7jfc6v04iLOsJrnugi6yadUfeT9TcLSuqdC1fDjv8bTkwa3WQmaXiDG+6UynyMRqG2HH8ga5us56WrIsSnFk0TtzlDYRqAvAgTScmyViqSWu35ezDoi7f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=X7qgvjfE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LUo5q6SS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="X7qgvjfE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LUo5q6SS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 34F81EC0440;
	Fri,  5 Sep 2025 06:30:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 06:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757068218;
	 x=1757154618; bh=ntu8IaCnyhtagJM5D98j/kl8jKmVMLbKqeE4Lj3Rajw=; b=
	X7qgvjfEld9X7i0RnhzTkxZLXdQwfI+kVyteIwCIm6yFPQevKXHmRxy3WkwfSHV9
	sDMICuUsgHN+BiltoWWRYYMx0ufwnsO1cnx3iGcPycSI3rJbAiOeU4raDPVnhnnh
	Z0WMFV3EguxMzhdBm5SaVmh5P8rvG9npOWRSvXdqmW1gZ8cFM7PJcjLb0a3wrC/9
	0ujaHjqkTKQlPSxsHX0QfZM3SCXcWMWyrf3ZMjVm8VDg5x9U639xzD8LpafZeMfR
	1TKSFn4eYP+2OV0cfwzw5/qJgigoWqgYaphPgQjWfxK73mqnGcjYG52GAl8NJoD9
	Fjcr+pXqkN9TvKDqNzxhnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757068218; x=
	1757154618; bh=ntu8IaCnyhtagJM5D98j/kl8jKmVMLbKqeE4Lj3Rajw=; b=L
	Uo5q6SSiyufDiNbGSqeoanako6UAbUBY3dbticte4i8G8f7IG/lnACruNw+xlNAz
	KxDlNrrRnnbYZLCJFbCMeQoJZYddKhOuY6Syl6DpMJ6Q/GnOPF3JYUryw9RsN5Ej
	IYppsVi0RnC+wMhd9lY4kpkXwLgy0qbgCv7Db29IfoTWdXOXEgmlRlN72V4j52fX
	3Fd33fXGNUEogFNhz0aLrlE5/rNdTiHF97vGdO2cQQ+YMCYhKdMSj9mU+DFVMvl3
	Slsbvf8iDlaEgLojP7yV6Zpmeo3xzj6tUqdgYWwCmcyr9iFuGFU/0ILDKgrRXy3b
	lI2LDrKqGKg4kP2BHwu+Q==
X-ME-Sender: <xms:ubu6aIyUMtD_ULazr3BZougilggtuzW1Oic8I_YrAFeyrk_bLQk8o1A>
    <xme:ubu6aMQjBbizOPOWGohXkMDmqoW_GrrmwUkCC6bSZuOlOnv2qOtsVXB5bS5EBsxEQ
    9zGrBbsnNQ_wBXkQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeghfeu
    tdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrg
    hrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ubu6aAgAjcyECi9gDxzQGw0OMQCZZG6h7P-kBAY8sDzcaI1F8Eg3gQ>
    <xmx:ubu6aM0HJQVuj_hIRaKggdYIii-BJ3S8xlK48xr8mG7hm0IytnmCiA>
    <xmx:ubu6aBLgD7-dfXYZAIBF-K_jxhkxuX-QifQB11nNgj-aix-V-HXRow>
    <xmx:ubu6aEzvhD2r9t7jERJL4JGdq5qXxM2BQtAQV4icSOzbu1gLV9qVtA>
    <xmx:uru6aAJO0u376izSHicCeIkAcFMWoh2A4W16OGofiHFWHCWIyuIO6ab1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D024B1EA006B; Fri,  5 Sep 2025 06:30:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ate3QFRcz-LV
Date: Fri, 05 Sep 2025 12:29:55 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Sergey Organov" <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Martin von Zweigbergk" <martinvonz@gmail.com>
Message-Id: <83d36c12-64c0-44e1-a5d3-dd7a5575ad65@app.fastmail.com>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy history
 editing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 4, 2025, at 16:27, Patrick Steinhardt wrote:
> Hi,
>[snip]
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
>
> If this is something we want to have I think it'd be just a starting
> point. There's other commands that I think are quite common and that
> might make sense to introduce eventually:
>
>   - An equivalent to jj-absorb(1) would be awesome to have.
>
>   - `git history reword` to change only the commit message of a specific
>     commit.

The cover letter is a bit outdated. Reword has been here since v2.

>
>   - `git history squash` to squash together multiple commits into one.
>
>[snip]
