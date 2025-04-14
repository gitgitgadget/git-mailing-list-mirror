Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F61B21A7
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613437; cv=none; b=fmOlzlh6HEMYbYI7riMDf8YxkI4o2OhJSYMzW3GUOyJHERyd3/TbAYTkn1D85g0LJEi7ikRAZ9uM5Tmg3sOIItsnng/AfjBOzg8ICVy3uXnE/Q2d9TFR5s+o1yAuVd+5O3eZsVZjcv4guGtmD0kX5BS/OLHKUKuY+CSG7LtpSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613437; c=relaxed/simple;
	bh=9jtfuwhZ5augXxfI6IfVfOU8PHkvitaYNoybopj7aI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT1Ouu7gGYqjYl8XTbKaxwNc/nq+q0pR0pnVpJ1YlNga3kqAPT89AbQozzSoprz6TkdwvBWECd0zZbKdjRdTpn18P3oLptHUL8Eq9YRuP7dT0ZdGKeqSDLnnENucLKh9fiRMnjQ6uG6QstVSgi2A420n7RSY17QYU5zPjArvRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cucrcKQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBs6nuNw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cucrcKQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBs6nuNw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 508981140140;
	Mon, 14 Apr 2025 02:50:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 02:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744613433; x=1744699833; bh=B3+1USxee3
	zZzqidrXYkBwBvdREgq6KxGcmFN5aIfPg=; b=cucrcKQkJEFNFQthzBKcBOddCN
	hdY05aEayFjr6dNcHNWRbLQl+v1UfLzl1FiKC2dfIN30EhzJq4NjBH8bX8kEjemj
	3NJcURI0yFHi/XiSolPNGOHEW212EmzdwynJHZsSliQEZvdVtmY7P5DEGxkCoFio
	OGD3cs/mt0i3LNGmXIWt/Qu8IC2adbieZpJh+uvDjGOsZCWMHglaimSk38mYACCp
	oU3p7RNQOBkKdqSCoHHhCEpcmkL7+Fd8cqQq+gNQyECrwN1/jLbgr+kd9oTfWGqP
	I7aPT13rBCrtULzDxCM/PqHsyQt/nU4zbunYIQPsya3oZkCSGSVTtZKS3IOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744613433; x=1744699833; bh=B3+1USxee3zZzqidrXYkBwBvdREgq6KxGcm
	FN5aIfPg=; b=gBs6nuNwnNtjJBc/Nuh8G6Rcwcg3K9b89e2oH7IJoTWhMrNnWOX
	FdD0AoBAHpOY8PU0U6BjbUolktBoBSbEFi6bBGuEaNKRSdBzHI26Eb1Ad4Q0uRiJ
	R6QlzYxm4mLuC8Hi0rLdju6QKM4w2cisGJf54nILPBInVAN7xaEv1g6V1KZZiqEj
	YsGHMzBQbgV+sBCx9pzKlki9FwE35E9koX/5CYCMtkH3XCrdhqE2toLcaIVZkWOB
	zWkJZGWFpj231KTbWcgylz7AkOTeTu78S8t1nEcKrZsD5mr49kIc16dKt0Jc4XTT
	fxgbVZOvCK+K6roQb/7EhzFAkrCF1jwb9gQ==
X-ME-Sender: <xms:ObD8Z0QSXQ0q9cWfl2xEF8hupTpKXppX48xEkrh5xZE0SJJIrJMHHw>
    <xme:ObD8Zxz7r2VlB0pZcLhZIRMxWSmvHtxo5ZI64Ns7GtixXvpjwd0NsK5e0NLdRNgSz
    zG2N3r2LeVsCOmcMA>
X-ME-Received: <xmr:ObD8Zx1ruSSwM33qCZyfqJYV-AqC6FPzv38Sn35E5xV7UrEIl1sQucsjaHf5uzLLY9-AkfhCn1V_j6K0BBYLxGD1FnrYQTwjbBK7sO6KxJQX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:ObD8Z4AVzmLwihHDZaf3lDqJ-dkVgunG4cpnjljaVYx9VoZP9rkleQ>
    <xmx:ObD8Z9jrU0eVKtn7yLUTF6YWOQesmrpY2yztrbq56qMkyn0xGSUL5Q>
    <xmx:ObD8Z0oXpgA7W8A84F8Kmkos6xcLOZBvu3Wo7lTytWWeN7MRuveaow>
    <xmx:ObD8Zwj4eZZvHQzLo_eaBQ8j8QNbbnu6MegkLcpWl00JvO6Y8wcapQ>
    <xmx:ObD8Z4SePB666XuBt0TbsPJ7RGeL97pyppqr1MH608S3VXjjmuOpNzYC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:50:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8e2b1b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 06:50:31 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:50:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] t/perf: fix benchmarks with out-of-tree builds
Message-ID: <Z_yvMp6j091ZXzwC@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-3-b2ace85616a3@pks.im>
 <87v7rcdzck.fsf@iotcl.com>
 <87r01v5k9m.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r01v5k9m.fsf@iotcl.com>

On Mon, Apr 14, 2025 at 08:28:53AM +0200, Toon Claes wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
> > I'm not sure if it's related to this commit, but this patch series has
> > broken something:
> >
> >     $ make && cd t/perf && ./run . master p0005-status.sh
> >
> >     === Running 1 tests in this tree ===
> >     ok 1 - setup repo
> >     perf 2 - read-tree status br_ballast (4629): 1 ok
> >     # passed all 2 test(s)
> >     1..2
> >     === Unpacking 485f5f863615e670fd97ae40af744e14072cfe18 in build/485f5f863615e670fd97ae40af744e14072cfe18 ===
> >     === Building 485f5f863615e670fd97ae40af744e14072cfe18 (master) ===
> >     GIT_VERSION=2.49.GIT
> >         * new build flags
> >         CC daemon.o
> >         * new link flags
> >         CC common-main.o
> >         CC abspath.o
> >         CC add-interactive.o
> >         CC add-patch.o
> >         [snip]
> >         CC t/unit-tests/unit-test.o
> >         CC t/unit-tests/lib-oid.o
> >         LINK t/unit-tests/bin/unit-tests
> >         GEN gitweb/gitweb.cgi
> >         GEN gitweb/static/gitweb.js
> >     === Running 1 tests in /home/toon/devel/git/t/perf/build/485f5f863615e670fd97ae40af744e14072cfe18/bin-wrappers ===
> >     ok 1 - setup repo
> >     perf 2 - read-tree status br_ballast (4629): 1 ok
> >     # passed all 2 test(s)
> >     1..2
> >     cannot open test-results/p0005-status.subtests: No such file or directory at ./aggregate.perl line 159.
> >
> > --
> > Toon
> 
> Euhm, it seems I no longer can reproduce this issue. So you can ignore
> this message. Sorry for the noice.

Okay, great. I wasn't able to reproduce this locally, so thanks for
clarifying!

Patrick
