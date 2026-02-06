Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03A34CFA7
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770367462; cv=none; b=I2/w9HVQ5lqLVT19beLVR6rGJRqlEyiwoFrKIjIGngEL/4K/ZZYIHkPhxJHf6r8OXJCSj6W5pclCB1/XmF7B7hixxoJ/f8PTlb8FgL6/GZOcDS5+zhNSYHx9R7iWQMvrVeKrtmNqT8tiOTaw/qaHMtvivW8CybyMtulsWGYg1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770367462; c=relaxed/simple;
	bh=WajLYhBdYkaDd/ouLrO5LUBuFFtQaVRc4xkUMehSIHo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E7x8uAxCuLSL/z66I7p3m0TC4Df8lIbKpI6ShIdobOYCe92UioZALa9Xb+KVYnl8Ij8UnkOLvVN2cBa9BDoRU8kedZt0EFZp7mVxB2IbrvF4jIkxcMCTMUqCRI3U6uBuWaj7AdbI3sZmcdPFtnP5GKzRPvrSoNX2fkLqcYMQ8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=wAZfNY8B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FriI1t7H; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="wAZfNY8B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FriI1t7H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C43141D001A4;
	Fri,  6 Feb 2026 03:44:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 03:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770367460;
	 x=1770453860; bh=+cS4o0TLVXkfC7LhOkShC4gO50ZdMRMa0bC7NfQehJI=; b=
	wAZfNY8BqQgBs3e8LwczDy9ISrHoMAoQ6Ar1R6+Sl13wS1hurHHFXjKz8MqsVmaT
	Ln9oH9UImWUbl/4SA/ZO1h6HEm3mG+4ZTMJChdJPantSUVnBp3/3Yo5XjAQii0ke
	kvnebnD3oD54BKNxZC4uWakbevRbvGu+Qya2jpuW6oUj0/eAGt/XYQLoBZIukWqC
	isU/CfMPDh2uYuqzg1NDdTykewvOml4NIhdGMbFGNp8Ff4ieZK87rFSKzZ/tmGhL
	sKc/cGpj0Laksu+sYFuJ/969z0utTWxhk6mRB3a3z4r9+WuKaTsnkeRDi/mK8im+
	0DkyNDxyglHFP1jFihORaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770367460; x=1770453860; bh=+
	cS4o0TLVXkfC7LhOkShC4gO50ZdMRMa0bC7NfQehJI=; b=FriI1t7Hog1UBLpmy
	FYdFCHGh5mBqlOkAzVh2bPgfNI5FHt9T0+6yZoHp4EqALazPR35WMthTi4aNgS4h
	kedV5ybTRlAyDr7CcM4zEm3SAtWTh+TUq9BrbxSjttY4hKDzvkLO9/fa5LAOjEuZ
	fS198d25CDjuMEOXS+VGC3CvnQKG+WNkscqf+pK60y4o7ui09At2vOaTQUjBT/0T
	GClbGAaE907Qol7VGdjnlBSH7vn+5Q3h556Z3Aa33YOED6SEHOlu7l4s8sxuGRnk
	ObGy4ZKTt2lqrUvivSu6h2lQUC0cB0U/qLIj5J7T5ufMkIcFSxdmMLlwmpg6nk72
	wAmIA==
X-ME-Sender: <xms:5KmFaQ42UpayvJPwgiEOMe7IlASI53qnst9cJvTojTEUJZ9ZmwCUPv8>
    <xme:5KmFactrCLI8QgfQm7tt4y5Mc9qIGXrIh1fh-7Di_sBWvivSww5lPevzbfJtrRb8e
    4woo45mzdgKTJPDMovtoGogWxJGtmvBKbXqtTP9b8L8XKnzMvIJwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeefheehffekheelhfeifeegheetjeekffejffelteevgfetveek
    leejfeeukedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessggv
    higvrhhmrghtthhhihgrshdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:5KmFabk87ojAwb6VwmPcI510fdAIvv9sgPpPxRfKuzYxDGun_qOlPQ>
    <xmx:5KmFacxZZOhf72N8u6jViRZqKeBMnbfXG6ctcTKBroTTRXUebBIqRA>
    <xmx:5KmFaZMBPrUo8K5vSehwhKBy926rsrsNEldLrd9tmpMF31iEAc9ZVA>
    <xmx:5KmFaQSp7GtusHnEGX5bzQN7ldytDomt3PO1YvP6y436NWfwdQ1xxw>
    <xmx:5KmFaQL--8zK6HH5MDAxiGvlFSmDvl5f3XT2ZktPcsMobhG1FeIfFIX0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6B1881EA006B; Fri,  6 Feb 2026 03:44:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2RKoXrlnTsZ
Date: Fri, 06 Feb 2026 09:43:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthias Beyer" <mail@beyermatthias.de>, git@vger.kernel.org
Message-Id: <1b1f8959-aa11-4bce-8535-7245c8567d6a@app.fastmail.com>
In-Reply-To: 
 <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
Subject: Re: git-am applies commit message diffs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026, at 08:43, Matthias Beyer wrote:
> Hi,
>
> I am not sure whether this was already reported, searching the lore did
> not yield anything for me, but I might have overlooked it...
>
> This was just posted on mastodon[0]:
>
>     PSA: Did you know that it=E2=80=99s **unsafe** to put code diffs i=
nto your
> commit messages?
>
>     Like https://
>     github.com/i3/i3/pull/6564 for example
>
>     Such diffs will be applied by patch(1) (also git-am(1)) as part of
> the code change!
>
>     This is how a sleep(1) made it into i3 4.25-2 in Debian unstable.
>
> TL;DR: If you put a diff in the commit message, that diff will be
> applied by git-am.
>
> This looks clearly like unintended and might be an attack-vector, righ=
t?

Related: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c=
9eb19.camel@scientia.org/

But for the magic string that git-format-patch(1) uses at the start of
each email.

Like Jacob said the cure is to use indentation for code blocks.

https://lore.kernel.org/git/xmqqttcmv8a6.fsf@gitster.g/#t

Indentation for code blocks: just stylistic until it isn=E2=80=99t. ;-)
