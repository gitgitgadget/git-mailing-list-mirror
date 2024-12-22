Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4702F43
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852200; cv=none; b=fTGRMDjvSv9f09INy7WmPz8GEEsOCyh7RF6FWBkB9izWRIcpqODM4GNysS3TBymFONnM8a28zz0O4YgdJNBoBVYRAn/BO0VrZ8bMEcoaKEvc+xwG+Jffoq7ZpfeZ9THXNZVSVjzJDFAb9USyiLo22Y5cLVrs2zW5B5d0gObs6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852200; c=relaxed/simple;
	bh=TpFYcSwI7Vt81OnMrYkbmBY9dStIz9EaZlsDGflEYTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN75CYfMBtx+s1HqjJ+3kfsJ5Zzlf0mt3iymYQaSrggf+/yj5QrF+utNO2Cde3S58ZPYWX9s33GUr7ks2qrAjPJ/8F8Yf5ATljfwNuGzFR29xx3hyiBCxpLqcofUI2RwUMWncTa4N7zx4sUaoo7D6KJyGLG8drtC6JybS+EaqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mZ78fdoa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XXTeFjnG; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mZ78fdoa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXTeFjnG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E4F51140072;
	Sun, 22 Dec 2024 02:23:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 22 Dec 2024 02:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734852196; x=1734938596; bh=2yv7Iqb8s3
	bgJZR7GOyKJDrSlMcyDc0czXIh7fV3Aho=; b=mZ78fdoaJ9uyDiW8EMrT/fPnWZ
	P2GbW3qFyNsQZS8VWhU85F8yImIPcUjC7A4l7pRLDcHDhaSN5iRAniFb9LWKB9+K
	SztxUa00OHO17D8ZjgU9J21sRdZGHYPQCs5HDTLU/EGD4497OHGBkP6sQTqRtqCM
	erE09OzdXRRHVTvkKz14csXgD2ZPcUW/gbsqYjU9e09h4+y3DcQkKW18KicK1X7F
	nj64L8i+ezdnWxqagcls2biEE6mBnEc0Yxg45KZ4BEsBAFA/t1D0o6Lj7epLS7Ne
	Cb1hD+ewVx1WEzXp6w1U3fo40a5t7m+N01Z6wA9fhugS83pDKv7MJxdJIYTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734852196; x=1734938596; bh=2yv7Iqb8s3bgJZR7GOyKJDrSlMcyDc0czXI
	h7fV3Aho=; b=XXTeFjnG1Ofn4cMOr3OorrnkCIv4sqTYfMuO1ZZIOvQqg+uDCHz
	nDyARNO2/PoqLUSRqknFjFeK0brwq5YNFlNGKpbwAhwaTGcNx9hidTK8stvwC4u1
	f8CVUQPKO3cU1NoX1fbtxYC6NnC08U8IwTanPu83zu6TLnt0HLW9V8IFBtxQEX7L
	opCK5HLouPOGJEJ6G1bD17G8Mo+z3kf/YtqKcrYkU9dZhQ7Qp92uELxaYvmTl4Mr
	Lu0I5oCmVV0M3P4jT3+cDY6vsF5y/BypdqyvTn7kFyKYheXAzgj4dYzTr7sop7Q7
	gr2prQ2/UwefkouKosg5TnV2vliOysKzJRw==
X-ME-Sender: <xms:Yr5nZ4h5GXmtqsZbDLPKb4q5KxdauRg096_R70fCOnlwEdnwkbqN6w>
    <xme:Yr5nZxALX7SCy4jLoWhJlYUImWKEM6ChYOkVuk2a8MS0MrRPNuyAVQoA6tForOxjw
    IMiqtr8GTLTidlzZQ>
X-ME-Received: <xmr:Yr5nZwFuiDrDpRIME_1Bi8RzVdJo-FlrTo4lgARQywAeoJXpp2P3gacMCEFfCC_sUUWHMaapjGaFi679FMWWjGSCdaxbwtsZLwZDeMZG3J_T4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteev
    vdetteegueelveeitdfhgeevhfeufefffeeiudegtdekkeehtddvheeutefgnecuffhomh
    grihhnpehgihhtlhgrsgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Yr5nZ5QouwogGP-Xw41uGPg2ZkuuUTX_w3uRuBhNbIXXf0YPJrQkkQ>
    <xmx:Y75nZ1wD2bRWAt7Vf-uLRp-TVHXdA2SpvFHParuBP4CEXFWWdnabLw>
    <xmx:Y75nZ36yIVtLyUVkfCdBu1T85x_xIbb5kcY4AL96drt4tYVofzTE3w>
    <xmx:Y75nZyzFe1b-CvmnoXxx9VjDWVUPeRlNIj8bQ-8-Te1dkYqcQ1q8ag>
    <xmx:ZL5nZ9-pEqHBf-zSkSBVSK_fl18a0C3ir19KwiuzZfQ6DU3UwzwhBRbm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:23:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b801ad6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:21:15 +0000 (UTC)
Date: Sun, 22 Dec 2024 08:22:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
Message-ID: <Z2e-T0NZzrMwEvmd@pks.im>
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd9F3tZXC-z-5=csELdPakzFS=QU-e35So3Og_ak0mq3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtd9F3tZXC-z-5=csELdPakzFS=QU-e35So3Og_ak0mq3g@mail.gmail.com>

On Fri, Dec 20, 2024 at 11:37:23AM +0100, Seyi Chamber wrote:
> Hello everyone,
> 
> I just published a new blog post on unit test scripts I've selected
> and prioritized for initial conversion to clar. I would love for you
> to check it out and share your opinion!
> 
> Find the link here:
> https://seyi-kuforiji-902b48.gitlab.io/posts/week-2-prioritizing-test-scripts

Thanks for the blog post! The initial selection looks reasonable to me.
I was wondering whether it would make sense to evict "t-reftable-tree.c"
out of the first batch and then handle all reftable-related tests in a
single patch series. But we've got 9 of those, some of which are quite
complex, so that patch series would become quite large overall. So I
guess it's sensible to distribute the conversion of the reftable tests
across different patch series.

Patrick
