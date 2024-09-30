Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05E188904
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735239; cv=none; b=HXX+Je3qxakDt0T7mYSaRwN5IyP22q0F5NgOZP7rJrXb5eRVruZsRd/jByCaG4nribzHLtZlquoLZmUawyKs/pUOUNE0Ot0Eaa2DlJkhE7q2YGEUe8f542PR00UL2Hsk1GHTwczWvtOv7srsdi94OTSJzgVvYaABPAntk+ytvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735239; c=relaxed/simple;
	bh=MoGzMZkV6/NArMipQnzY0fquTZ07ArEwnpkWtSYHTC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBQOmlYCEJnVV+ZS9OKAtEHWCLmY7QmebqyMlvvsFQF1xalprjU/nBBagr35h2TNa4Pfitilya7ae8uRmZVsmRyyLrM6AE8sWek6WJUgBxSWc6o14zK4ZvD5rIEWJMmqz+UVl7MjaaW/jWVJP6o1Hds1GLl7cWG5cu0ILhcfetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2smEujF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QU3LhyJ3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2smEujF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QU3LhyJ3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4DE661140565;
	Mon, 30 Sep 2024 18:27:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 18:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727735236; x=1727821636; bh=85hYB+pHE7
	leaamOMPslf5fSApegYJ5Gj2EdN1aSuCE=; b=e2smEujFyrUmf56RLU4xn1Fn8V
	5qPw1okXsVDx+WsZgp35pSvY1OLoN2ymTlCZeNAzn/Jm4GYaTaVEhYGTJk0bhYth
	jnKn+a4v7MSyGW35DrWSGafA++22+HqVxRi42G6UL9mS/f3xm2OI5CbLXeC26kr1
	+k6Zry4PpKB7COc4BraNIruomuW0espomeQEExlcOeAtMNgrZkNCM2zaCYDOul0L
	7JprvHiIDAz5ziHD8NKVIxgHYmh32ZAzP/5hcYaTt5wXox8FpKHosxe/2m1B9giF
	xNcAs/GjBsZaBvs94sFEbIbb5e9FRoL39heoTfmTTLdzUPftpaCs2XUtfydg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727735236; x=1727821636; bh=85hYB+pHE7leaamOMPslf5fSApeg
	YJ5Gj2EdN1aSuCE=; b=QU3LhyJ3sdqx3mxBASSYkg+fbQqiCClDglxk2krgZh5r
	P9bT9d1Tve+y6Xdqk7E2inwkwx0z1VSSzeFnMGiQPRKAKMoUuwJJToSlGJuZ9GHG
	4EDVDXwurUXDGvDvMye2l4erVGf24jc2d8p2LDMmE2ckOnrYccEJ2oNHbmJXZp/g
	yKA8mi4cyk150EGS2ru5D+z71W2pP33NsmP5ssZdNcixYmfRH8soM0+C85P9BHeS
	uVURN4ukjETPQJUzRgcHRght8NrsXrdbcCnN3Wx+ew1/m014+UWZ7PlXgi/Jpcdm
	iyaASiMvVuCwSqaGpvDG7tpYl0Kpm0DUzs2IXC0lig==
X-ME-Sender: <xms:wyX7Zs2xH88Ax14NgS-vg05CDwmPg2al7hXLGtgzShhRLitkyHiX2w>
    <xme:wyX7ZnH-LqE1Lo63uXNLDZtC5Y52IKW1ZVNXDa_WV6b04ok-fDkHGwL14b63yHy90
    NMZu8iX-fHRgLDV4Q>
X-ME-Received: <xmr:wyX7Zk40KF9maBlJTCPUT9KjEXHFZbFTUoC6YQk8-QHxvqsmBIPESEVk1qhUl8yS8sTqY8_LnmQyLGfoGYnkZr64MRZbVHxg2SUQ9ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wyX7Zl3F58OV0F8xpu6HiIyneicjrWLPQqrtreg3zEJ8AKyfpUe0MA>
    <xmx:wyX7ZvFaAHmwotmMdHHBMB37vCG7hZOdZscjUcZQW_M4SyWdfGKm9Q>
    <xmx:wyX7Zu_a7Sur-HXY3nuYk2hsNx6IIjU04S9UH_BwZamki8YDID0z6Q>
    <xmx:wyX7ZkmD6u9U4VENfwZXgBB9vRl-YlzXxTxWS0uO2RoKca25dJbJBQ>
    <xmx:xCX7ZmD3nPgmpVI_Jerk_fj6vk9YxzQiqATr3SSCcnzdez6hUh3f0yab>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 18:27:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  John Cai
 <johncai86@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
In-Reply-To: <ZvsXlq7-28mdxNc_@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 30 Sep 2024 21:26:46 +0000")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<xmqqikuijni0.fsf@gitster.g>
	<CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
	<xmqq34lkg1ck.fsf@gitster.g> <ZvpZv_fed_su4w2-@pks.im>
	<ZvsXlq7-28mdxNc_@tapette.crustytoothpaste.net>
Date: Mon, 30 Sep 2024 15:27:14 -0700
Message-ID: <xmqq4j5w4w1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> One idea I had about this was pluggable storage backends, which might be
> a nice feature to add via a dynamically loaded shared library.  In
> addition, this seems like the kind of feature that one might like to use
> Rust for, since it probably will involve HTTP code, and generally people
> like doing that less in C (I do, at least).

Yes, yes, and yes.

>> Also Cc'ing brian, who likely has a thing or two to say about this :)
>
> I certainly have thought about this a lot.  I will say that I've stepped
> down from being one of the Git LFS maintainers (endless supply of work,
> not nearly enough time), but I am still familiar with the architecture
> of the project.

Thanks.
