Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DD2D77E4
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933645; cv=none; b=I9PB72LUi6c8cPujUdYzi19YwVm6hiGhe49ixjlipLSrs+8ZXpSMXaV9mfo0H5/C7LjYSYgBRiHaqSN7X9DjdxFZvCfzihvxsZOsm0Sx51eSRnUB/puk4TXka5OfjCFxhsVLwGoyNpNxuObGWwGA8/a4lpgZSS982vgqAVF3sQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933645; c=relaxed/simple;
	bh=pqbUEnidkWOl5FP0PFEhPmk15RLaw8OYde0vI/ko6xw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4fy6Ihy1RvtPLToLX9X3DyJTg1qPW+NM3dcGcAcgzScFd5jNrdhlet+H+PWrh4vYJMLMowsgfrIppvQlzpZWLS+MtzDVxcOQ05xKoTmO68bZryzifq2ZuuXhFHNN0/T9TYuJLhLks4sHBBbdYxqNlB0QEyYhqgWz4e9Hqzb2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TG9YUA2c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEHuAkmN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TG9YUA2c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEHuAkmN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 61230EC0283;
	Mon, 15 Sep 2025 06:54:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 06:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757933643; x=1758020043; bh=UOKptnWt4n
	XUX8BV/xga2eRNGeNaeHQe9mR0gmIm9i8=; b=TG9YUA2cSjMR48L2J8tWqZExyU
	op6hAVBmUH93hf/4LyUgp0eHkv9Xg2SHmS2ajsYW7NJ+09ckESZKzxliw8Oji1mg
	7eDQBe6uc2XNJaBCcQZTP2MunVobHfBoBcboMeoHMLQIBrfR3gnukofDzyTN0oSO
	8tOU/0ahRL/3Bn4IkquKNn7iEqerW4Hy/KbcrUkbfug6TXwVGFFZmacTCrdg1I9H
	5VDgQ/2LGacgPyTxlsb7jbSrCC3TsBjYrRGCnaNBk9cS8gnU+CbpoWoA2goYqYGC
	YE3WSs3VAMgwxw2qX10+8M/DUo6yuh7nVgySkNMjyKGmaxmYJInb9UDjdqIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757933643; x=1758020043; bh=UOKptnWt4nXUX8BV/xga2eRNGeNaeHQe9mR
	0gmIm9i8=; b=cEHuAkmNSoq9iIc8ZXqWSENa/PJ22tei8l+ysr7fUS1vnY5nWyk
	KiOohhcmLgBeOEpX1Qtl6bwQCX33LBExdOUR5VFjgpzPADECYRUqPiDQg4aQ97I+
	zM+KUaqYVvT3gVNKqUe/fzofOG4ISAYwmcsHrxQe+l/vfz1Ix6CEpD+TcgHXVnkP
	02Pt86xlW7sYwBcGX943YuP1tIducTof0fj/GPnlztb0AZK742TUqp1yG90qzo6V
	Gk4bVi1xeFNc3nxi7rMUoFw0SFT7QUM6s44zGPLpE30mRm3l3OQKkzp8GDr4AUdY
	ZRJN/YvIMHRWB4etMaWcdkhMRAaikYJVwkg==
X-ME-Sender: <xms:S_DHaNO8dK3xehmr25eyroBzSZB0nYq5PwBI3_ND5cnpBaLwzzWJZQ>
    <xme:S_DHaAGJmQvuTNZDp8Ax1b3KxMNT_VTnsdL7PgCoJd9pf1t0nW8LJInsBHCY1XmLS
    8z9TaJWwgk-Cus-Ew>
X-ME-Received: <xmr:S_DHaDtQl5M1N-m2J1joRiHi55-PLdKTsWrZLNBNNbrGjqCC2JQL94a4qvPcPlTZSVDT6zkzspObHiWMf21dlHM3izbCfqS98ftB1NlZF5-x_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgr
    mhesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:S_DHaATLrJbv8O2pP78-d3wzLfIsjT4VhBtIul9EmJVFzwGBVhWlxQ>
    <xmx:S_DHaNMsDyEum0iR6FuCtWWrjP2JEd2hMH0e6gRImSTNX16Pz4Pl5A>
    <xmx:S_DHaO6sapYmuJtE17QBTZgwebGCg3Fy3bokzBN9Kp2KAWHRU0SYhw>
    <xmx:S_DHaIXo2-X8KcPnEvw4ZK9Qty7xdvbktg4pKKb5JfIoQfrohPq0ww>
    <xmx:S_DHaFwfQECey3rF9lsz6YmovUSwXy4GJVf_ESaqAQHPjybgSvj0ZBjA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 06:54:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ec1fdab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 10:54:00 +0000 (UTC)
Date: Mon, 15 Sep 2025 12:53:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 0/9] Introduce Rust and announce that it will
 become mandatory
Message-ID: <aMfwRP3AC-PHrljU@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <aMNFao0yGZ6yzKKv@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNFao0yGZ6yzKKv@fruit.crustytoothpaste.net>

On Thu, Sep 11, 2025 at 09:55:54PM +0000, brian m. carlson wrote:
> I may end up sending in a patch or two for these if I have some time.

Sure! No pressure here, us being able to iterate is why I wanted to make
things opt-in in the first release.

> I did note the discussion about what the LTS process looks like, which I
> don't have strong opinions about but do want to make sure the project
> (including folks on the security list) is willing to support.  Other
> than that, this series looked reasonable to me.  I also confirmed that
> it works with my existing sha256-interop-part-2 series, which I
> appreciate.

That's awesome, thanks for confirming.

> I think once we have agreement on the LTS process, this should be good
> to go.

Yay! In any case, I would be okay to help out with the LTS process as
long as it's still owned by the Git project.

Patrick
