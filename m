Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555E21ADAC
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698211; cv=none; b=hSz78b5DZ3m3A+sFqY96951yBGpTOZhXgxhTVW1Yosg+DaSfx5fgXfm/WDDc8aum8Q6bdzte66aS3AxZs66zZNeBaE5WPrJu6pjHriCZFVj8YBk4NGjHqzr1e4BnmjwQwKg8Wb2Com1WNvdxA6UpG3U+PJP+RKoIj/V4Ok7HesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698211; c=relaxed/simple;
	bh=yVkvwtn/DS5bWyImeWaupr8+C4Hi3KQp4pUtDAQKQAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTejOgh0/nGt+ZgxF6gq7U8lcs+1sxrtYFf7KtVm46zX0OY8WDqCtifnG7mth2yHC69Ui8XMPth0FnZYHNKElOQuUYNWC3BLrRSpHnoYToAbg07cM9tTVmTfhA8pcKphUJXzFCr1MM21kZaUySar2diRbJcUrgm6ja5b5tc+u7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nXV0bwvr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYnS2bbv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nXV0bwvr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYnS2bbv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD82B2540133;
	Tue,  4 Feb 2025 14:43:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 04 Feb 2025 14:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738698207; x=1738784607; bh=SIZjnragFt
	cBGVODLnwMDyP3FBQru55zF86fU7Luz6s=; b=nXV0bwvrTkWwBKSFYIfOJU3JLW
	kmWBKDeIn+I922LA164yCj/BOVpqLWHPbvlHLY2Sj6RXviCoc4T6qh5jxpSd9z7N
	uTuOnbfh5iiUY2zIHMytY4omc/kOsBEbsOiqyeTkK+dxri0wqu2ywpMKXrrBd0Em
	88ogZpbxF/LzuS/PcQBjiw9sPatvTVysEaRXTuR28cbB+WAtueWTUF1AnE+nueLV
	4Yrmo5sWVvA2AWluxmkpITudB7S6F5GWhFqvl+FLsXz1mX9SO8np88dPpVcJpSUQ
	Aa695WsBLPlr9Y5S/d7UvG1lB45dE4w1LQsDJpXV1MJokcr7Nc/QdgrDtNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738698207; x=1738784607; bh=SIZjnragFtcBGVODLnwMDyP3FBQru55zF86
	fU7Luz6s=; b=EYnS2bbvUq7/TkWFsnV+Oz5vz1gTlDQDArjuGqCJ52FCqNKQHg5
	rHFTquLbB/3g0ItOd1ihOhkuT45pACD5r5e7lJ/frvHaltisR65wy2mG3plGRM3C
	Cm8sDCU6S3dQ/5v2X0aXS4TZfXe347xmEwta5AcHo9mA9xgwNjdifpQRu6wVbCZb
	FqY0U/tH4Xtm4jqdrKDV3uk3lKdduei6yrnFbzxTnYrDI2e22XFZH2TEM4nQYxTO
	EHeRuRRCmarXbKc55AU/c359FEoQC5Ra1br5yNWIWtlbhD0diu9vn4fVMJeKLqA8
	pZxWjFE7N861k37IH7FP+oeIJHO5vAWxuYQ==
X-ME-Sender: <xms:3m2iZ8WrVvMOd_pyOkfRMjb93yel6dYfTXhpyUzJiJ0AUOsE6RQdaA>
    <xme:3m2iZwk9zPH-MPrZxxJqz9eSA1QIKNWsNEH88QB1g2N1uLAUvcWE94VxFlvhcjBP_
    W263iYAmR9BHd9nxQ>
X-ME-Received: <xmr:3m2iZwZreHxtAQITLW1bZIBjWwpgvUSBbEJgL_N4Hu6kwjgXW3HIIb5QPhiJZ2VQ5ID8QWdutpJqf98a2bfcXj9rs3lTLsOVi2f9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhgrgdrphhilh
    hiphgvnhgtohesshhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3m2iZ7Vh2FHm_GPYDeG6Iz7ZsCOLn0hPDcwh_6SgpABXiAl5P4stEg>
    <xmx:3m2iZ2n8CYaTSfofEL-3-8hzoTo9urrV5vddut_xPZs3Lk5HJp892A>
    <xmx:3m2iZwdruUqQsSxbGJESbkBJpUgZ8azC_ID46SlZCjEPg-vbu9U8hg>
    <xmx:3m2iZ4FtLJbrCABWE9kSH3m9ov-Wh6vuRtIvvs7z89Cg4nHLYomKHw>
    <xmx:322iZw4h0IEWCv4yboanWfZ_K-PUzH4l6wXMDcRYizEh-j2e0Q79VVjh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 14:43:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Olga Pilipenco <olga.pilipenco@shopify.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
In-Reply-To: <CAFLeGL4v90zArJjtCOSGUTGQTq6qQJEcNMhi4P=ucDU+9bGRHg@mail.gmail.com>
	(Olga Pilipenco's message of "Tue, 4 Feb 2025 12:03:46 -0700")
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
	<pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
	<xmqqcyg294ft.fsf@gitster.g> <xmqq8qqq943u.fsf@gitster.g>
	<CAFLeGL52tKmurpAHymk42Y9DGazbK8nRdtWAoyzW85eMDxJQhQ@mail.gmail.com>
	<xmqq8qqq7n26.fsf@gitster.g>
	<CAFLeGL4v90zArJjtCOSGUTGQTq6qQJEcNMhi4P=ucDU+9bGRHg@mail.gmail.com>
Date: Tue, 04 Feb 2025 11:43:25 -0800
Message-ID: <xmqqa5b1ts0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olga Pilipenco <olga.pilipenco@shopify.com> writes:

> I have 2 versions for comment:
>
> 1. Since is_main_worktree_bare explains quite well what it does we can have
> a shorter explanation of `!worktree->is_current` part, something like:
>
> /* Additional checks are needed if main worktree is not current
> (checking from secondary worktree) */
> (!worktree->is_current && is_main_worktree_bare(the_repository));

For somebody who thought about the issue themselves (like me, before
writing the message you are responding to), this shorter form would
suffice.  I'd rephrase it more like so

    /* When a secondary worktree, an extra check is needed */

for brevity, though.


> 2. Or a bit longer inline explanation that partially repeats the
> explanation of is_main_worktree_bare
> + adds explanation about efficiency:
>  /*
>   * When in a secondary worktree we have to also verify if the main worktree
>   * is bare in $commondir/config.worktree.
>   * This check is unnecessary if we're currently in the main worktree,
>   * as prior checks already consulted all configs of the current worktree.
>  */
> (!worktree->is_current && is_main_worktree_bare(the_repository));

And this more extended version would have helped me by not having to
ask

    Is "this worktree does not have is_current bit set" equivalent
    to "this worktree is the main one, so is_main_worktree_bare()
    needs to be consulted"?  That linkage between "the is_current
    bit unset" and "is the main worktree" is not obvious to me.

in the first place.

In short, both should work, and I personally find that the latter
may be a bit more helpful to readers.

THanks.
