Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B3E55A
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839876; cv=none; b=fBvpzkz4QjaQd/xLF2jQEjRbVoe7EJ7UY0ZCzOhmXv1XXTeT9vmb53wVTiHNANW70XlmuTxdaoNp5pV46U+WemyozkdtK2Y/xcATfGDHtby+fFl4pH4aEcvrbPNSkkL5QRdffgq8PoHVt9NXP6NynuBekTQo6sr3aTZkcBFLl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839876; c=relaxed/simple;
	bh=pLMPjHW6BkHGK3QCnKZ9E7FtBtlTjLIIqK6znTmB3bs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Is4mu/e33qS+ltpo67GHcZtdNQPO1ezKS6Pbymo4XlR6AFgh+VuurMdAVOuZouDbbe0zjdSN192Wl3Rzg/5oLWoMhif0lnzu38vUOjPY37hw6F57WTYGr4gRHaXXvmj92O0De5YDKmWGu4ulGw/QE2/2EUcxVzT00FI3qKn4hKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GHnETfT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qBr1smVS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GHnETfT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qBr1smVS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EE2D6EC08E1;
	Tue,  7 Oct 2025 08:24:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 08:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759839872;
	 x=1759926272; bh=pLMPjHW6BkHGK3QCnKZ9E7FtBtlTjLIIqK6znTmB3bs=; b=
	GHnETfT0XKJIRg2QqpyJeNGskZT9VsKBCFDoxg2+n22i6wMat9jHdttfZ6XbdpmB
	vF8TELO3S2Xxg5vhhrwpbXYXpxjUccRfa3s9F5CA7zCOeFf3utMNsS/dc8thLC1A
	c3XyQfeTgXWv0H71IhgwhzQzeLCQo2y+0lB9DHyTQ8lUcXYKuCe0lWtP2Drx1AwO
	LQdxLiakonaMqGgDtC9NQgpOF49uA6J77jBKJNgeoGsYm14NWlHMbPFl9hIgceIm
	U66VDiXXeyjx0JVoBsdBrE+S2kdVUgxesZxh96CJUo+4QvTaW+rN/4DYFJlqWe/S
	KU5MRV5NnGQwZ7T5UeMBHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759839872; x=
	1759926272; bh=pLMPjHW6BkHGK3QCnKZ9E7FtBtlTjLIIqK6znTmB3bs=; b=q
	Br1smVSiBeWm0ASLhvDF80QXnoiNtrzr8hwWD0Xwq8tcqQXCEC5gUR2tOacOCPvT
	Tj0Xf6YRizv8nZ76dXYPhOasxBmV46mdH0iQtW251AZ5S2m3GQxZMV58/YJDiamO
	xayOgRmXOx5XPxz0hwPesoXBwvVyWdk6/UjRiBKYCjY+nXtA36FESzGNlvjUZhW/
	MWWPm0M10ua1thaoP+5EV7wBHh1Dsn0oJ6Tg3k2DaC2vFhlYfvJn8AyW4MOevgfH
	uaHiv9SqjZc+Y0y6f3FtezshOa7TK8tBHpfTw3SUzXYdXeL3aUBIx17Bk3J+fdWE
	vTYeVsA+ShQn+O/JBbRTA==
X-ME-Sender: <xms:gAblaO6mDNT1lrtWJFf4gMmy-3QeHHVbN-7z3FXs1pFgWGuI7dbYGPY>
    <xme:gAblaCu7U8qMbrv-0M7AdgbC_YxnwBO9hBA9pAh0koIWBAlh0TxgmpwYAtDeisOCu
    UC2RuKk0AwUxh_cvwIPlMpLA7t48tPENOuOYQL7W-wIXaoOU2Qw-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheplefgvdelieei
    heelheeiteejvdehtefhgeegfedvudevueegjeekhfdtkeegtddvnecuffhomhgrihhnpe
    grughotgdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gAblaO9mxoozr-u-uhYhOSQqLH3CYtWtkEuPxhq3tD9OKBfwLN_OWw>
    <xmx:gAblaAO46QK9EyPEga9iodc_DBUzM9afeqvLbbXd4imEJILr2qmxEA>
    <xmx:gAblaEHIr6roWh5bF-Xz4EZWzhSPfCoRHoYRkWrWdb0ETjlPQ8Xu0Q>
    <xmx:gAblaGQDq5jqwA4oTEbUIfXfB2IWRF57htNBMaJuh6AzSohW0TljBg>
    <xmx:gAblaEraSAQozkYwgVYN2A6-syNrxTIaiKfUZPo0n5DnQlQOn3CIoipy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8DBD61EA0062; Tue,  7 Oct 2025 08:24:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFEtArsILR8c
Date: Tue, 07 Oct 2025 14:23:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Julia Evans" <julia@jvns.ca>
Message-Id: <48224822-9f8f-4230-97db-a7fdefa557a3@app.fastmail.com>
In-Reply-To: 
 <10a9718421aa842573a2ba1ecf58d2cc46b5edd9.1759777131.git.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
 <10a9718421aa842573a2ba1ecf58d2cc46b5edd9.1759777131.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v5 2/5] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 20:58, Julia Evans via GitGitGadget wrote:
>[snip]
>
> There's also a very terse description of "upstream branch" in the
> glossary that's missing a lot of key information, like the fact that the
> upstream is used by `git status` and `git pull`, as well as a
> description in `git-config` in `branch.<name>.remote` which doesn't
> explain the relationship to `git status` either.

nit: s/either/, either/ ?

I think that would flow better given the long distance between the last
punctuation/comma and the end of the sentence.

>
> Since the `git pull`, `git push`, and `git fetch` man pages already
> include sections on REMOTES and the syntax for URLs, add a section on
> UPSTREAM BRANCHES to `urls-remotes.adoc`.
>
> In the new UPSTREAM BRANCHES section, cover the various ways that
> upstreams branches are automatically set in Git, since users may

nit: s/upstreams branches/upstream branches/

> mistakenly think that their branch does not have an upstream branch if
> they didn't explicitly set one.
>
>[snip]
