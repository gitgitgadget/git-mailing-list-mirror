Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF93D7D7A
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119735; cv=none; b=QlihfrBQfX0sufvcgZZP5F6IK2qpCwlwoNl+lA4AVeY3sEPhyV6dwpQ+J+tXLfK9Fue31lgWwzppQU2Zt7JQpZwK96KI0b7LGqkIZWBywZ5VUMLG5xFuKFvKmx1pOslFq+vvG//ZtqLv6o33O+uH4gpTX3Auncw9XRvjJEQ3DOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119735; c=relaxed/simple;
	bh=T3/QKrqd9h8wpQ6721mkNdK7CxYjL0UEi86tH0/9UnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QB+Dxq4TZwcd0alnYf7y/mk7P6Vo0LRZQoo9Knibw+NwXewIzQgI/9R51JEyue9vctiPRQ56idQqaE56TD5I4hbr01Qe6ylHEO/k+CypOQFFmYeqYYxKyFsYQedOy0CarqkefFNixWjaDj7uJtiZaAUs0QKcFk11wVsuqvynpbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cNzx3ewo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYYNwSiF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cNzx3ewo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYYNwSiF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFA5914001AF;
	Thu, 26 Feb 2026 10:28:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 10:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772119733; x=1772206133; bh=hENl/QkWe5
	HgQ7nI1/KaSBCTR0ZhRDG5Gzx5UBVZlDI=; b=cNzx3ewoVj5w4nB9P58lNJi7nv
	2BmmM4j4p336NxjWkHWmCh6r11tuKT6Lr8IVQHyXpaKEB+g+VCVaiztmiwOYbVBv
	GMN5Gdto4ISbRK9lbif9kSQEqFlsws0eM/TtsUa2tYZmWoJnUvwBH3Bfu7mORtPQ
	6v4DXfWxhf5qLpz0jzqxmTBDAp8zwzKh4VDl6s7Sw7kJNC5SjRfnNmMpOmV7fOb8
	zSg+u6aZxQeDFkIa5/xX9XHk2d+pzoKBF0XVoP4h/WC8zdY7TLRna7CVZLyRbPEU
	GruYaxqAqmALY8d6oIVl+11TGiCdIOuqhtf89ynQz/GRBCNmufLHulmedtPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772119733; x=1772206133; bh=hENl/QkWe5HgQ7nI1/KaSBCTR0ZhRDG5Gzx
	5UBVZlDI=; b=HYYNwSiFTrD36QFp06z13F7YpPD8cedZNpLZlkLrsDcrGUXW0Pg
	UvRCzo3MJWuLde0P+3b2tr35jqTLchjd25NqTyKjBkAjDL7lFLftoZem9jq27Hon
	5n2RKVho7npAZISRNH8x8WhM9o9ZrkKY2PVQMozLNhVhhOPtBjBrZpafHbgQeDnp
	yB+wl3d0cYWXWP85hOeW5SCROrpzWpUHFWz1HkhRSL9Wnd7uLRPbRcDP7ZQYkSG7
	m9IpMg/ExwyJk3L8dQP/8U9405Iqwzz3n4aKnMli773IVgWJv1Rv0dGsVQXgmEDb
	GltyQh4ZYYc1DHeoM1UjDDJKws+z22m4kgQ==
X-ME-Sender: <xms:tWagaZrs61DeUg-jHO8cyNVpVwqzFBxcVjrBaVYHZWcYMp1zALYBTg>
    <xme:tWagaSraLHjqKkUZGaTOfZTEswF2hCCXsU6z_GTqIS1vcsIAH_EMXAshuCKCeU9J8
    LB1BtPHovUJztyvmkOcydTOHCyXd8WbIqS5zLuz6pBIh9eZrlsUGg>
X-ME-Received: <xmr:tWagabOtvG9uOxLXul79qHYvc-YgxGsf8wJpNp6_XnOGynVCmKiZJ2rF_Um_j-Q8bPrdbpY1NRs1puNAAb1Pc-Pj-9fx4Tmlvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeigedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tWagaTzViEtFgwPN3r3mgeGAYdENFCiEJ1Sj6aYlgcfaTWQDO8xojw>
    <xmx:tWagaUvoZ2GxpMvi8Tfs8mjRbqNEyPVm4_87OljBVbpg9TVa5CtADA>
    <xmx:tWagac6Xq1GICm54-2u4enPk4mTVaJnf0fU_5kpxTEVk_3VT__ZOFg>
    <xmx:tWagaTTKRQ5rKv-Fuh1sYq8Tm_dUHM3wYNpa50qmzdinBZNJGSuAVA>
    <xmx:tWagaavRS1Ak1yusnh0xMXIvV3cFP5ihoMvnYMmWfp4Fr4m6rE-G3vPZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 10:28:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v30 0/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 26 Feb 2026 10:33:40
	+0000")
References: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
	<pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 07:28:52 -0800
Message-ID: <xmqqa4wv5xsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
> ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
> cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
> kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
> cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
> Jeff King peff@peff.net
>
> Harald Nordgren (2):
>   refactor format_branch_comparison in preparation
>   status: add status.compareBranches config for multiple branch
>     comparisons
>
>  Documentation/config/status.adoc |  19 ++
>  remote.c                         | 178 ++++++++++++++----
>  t/t6040-tracking-info.sh         | 310 +++++++++++++++++++++++++++++++
>  3 files changed, 470 insertions(+), 37 deletions(-)

Will replace.  Let's wait to see if we hear further comments on the
topic for a day or two and then mark the topic for 'next'.  I didn't
spot anything unexpected in this round, but haven't had enough time
to spend on the test part, which I want to read a bit more carefully
before merging.

Thanks.
