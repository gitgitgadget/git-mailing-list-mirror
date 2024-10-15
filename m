Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586743ACB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967068; cv=none; b=Q7ZlKBYsF2K/ZtZv2+9QNqv6MpLVy2ZP7Ru/ir6lCWeq7hGozkSHkYOiwP5S9MDhYJMoT1wVlyukbDjB/mHFz7BW7s3xWzfRgndGtM0jb/YDLq+w89D/lWAq570wxHGGPt49Nt7ctizLQW3MOfeL8H44EmIZ0aloN5gTgMqe1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967068; c=relaxed/simple;
	bh=h+GFeTNaLGeuftesFKUGsTIAPChxJbwC6g9kDq0LZqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQS5QAgQ7sG8WSDvOKvwf2LscYBKuYf58oC4m9M6CYJFjwI6wM1ki/Jy+i7OTqh4lmldyBMkiFyOHaaU0MaorvjSgUDlsHQNlxg+CmgpqAgD4phjBroDCJiTZYBVTjdZktZe6JEdsctG1CkXBbazZydM0P0pglGCe2f39VYCw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XXjKMvKC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzEQUEK8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XXjKMvKC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzEQUEK8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1A8E114008C;
	Tue, 15 Oct 2024 00:37:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 00:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728967063; x=1729053463; bh=JYD3afhI+m
	ZJGR6xVmuWVaHSOoEYAmnyZbP+t0NdqMM=; b=XXjKMvKCAeaOiD/Hyz7C3g6JTR
	VyNwty8/OSFFUtXGoOoR1hNmQFS6nQgql9lVhTqF/4S3ade5HAtFeYrIvIeKSqvn
	wEkDACkz3851N7il4/XEcflQgrVpQ1M8AOHEeasNqGZTbubQzPCWnxRGrWAI0pAD
	cm7ut9PnJE1bhmt4YYytOL1uNSqKMLmr7AYKHKrVh2mfsw8eNXL01jaudflxZkr/
	5F9ADWxZ0J94Q9lK+EV5P/KSriKPee4ueNIi8Kh+rTt8X1L6+Wn4w4LMHq2L9NlU
	QmOl9goA2vIHRk6srElKzl62cdQLK9Rrt7C1OGZput7NI4YOxErJebF9Rnlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728967063; x=1729053463; bh=JYD3afhI+mZJGR6xVmuWVaHSOoEY
	AmnyZbP+t0NdqMM=; b=EzEQUEK8Aivu68n+SZTMgjz6/rM+N2VoH4edhNl6zNZL
	BB7UNupxSecGj/piAzHluYzzLIAiNe9HZx9wG2RVrGfH3zgEvm4WQL5rUrwC987m
	TOyOpKWVhj4PvT6HoJDICprYquyUxmcmXo0Z9fbPirKFwF8qmrjqrFdvC78IEfxr
	hfVL5sKA79FmZppTVjbUPhUqWhvCSYmX44S3fNd9FT7DfPeMXI1Uo7kwIdBf7Y7k
	dpoZgN6Brgf5Lyy7k+ywcc4cENciYQiUDw2/KJT/GjQ5bj7Ux7oqfRiK0H7KwHhl
	Qf58jfr/zoEYrPQe9Ubloj4+iHb8mJK9nTJfLubSdA==
X-ME-Sender: <xms:l_ENZyDKIsbnLaSPrqMqhb5gQxiHBJLIPuvynqz30jXwfrMAHb_7vg>
    <xme:l_ENZ8jr3vuVyE2jcng3VVbamtOE9imBUY1tsc8X19qf_p0DibwRAOgEvR8jv4JdD
    hiW9jwvQufXVObjGw>
X-ME-Received: <xmr:l_ENZ1lsgEk9jeDmfrX7bNud7dju8tTKZkNXO3hDjEbz9Mtrd4ArTejZNv6R58Ct3AqlwaA7qV4p4B30qLL8fYb7AHyldY_zGBCkk-QQXzqMVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l_ENZwyE9QE_LoDXdjGcubUQ_ZyEriAT5WW6wbXAJ2YAlBzy0Z0eOw>
    <xmx:l_ENZ3TFf8mjEmhccj-Kic34s-d7utLPIKL2fXAQ0nHAlWZxlY7Bwg>
    <xmx:l_ENZ7bmo7YtM62C0iuvJFqgmJlLGFtwTpC7UmSLAsjJNZQfKS-Saw>
    <xmx:l_ENZwRRdvvowN9HyWTqAKQ8aZ83wCVs95m1V9l9WwQ8V4d7xDIBhA>
    <xmx:l_ENZ1N8F23aY2t4PT-5fI0li9kq5w-L5Txh59Cz-5Q96xdQUWG0NT5Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 00:37:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f474355 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 04:36:25 +0000 (UTC)
Date: Tue, 15 Oct 2024 06:37:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: stop using `struct strbuf`
Message-ID: <Zw3xkX_a4KyrSNq9@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <Zw2e0w5bkDO4l/Qs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2e0w5bkDO4l/Qs@nand.local>

On Mon, Oct 14, 2024 at 06:44:35PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 03:02:16PM +0200, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the second part of my patch series that stop using `struct
> > strbuf` in the reftable library. This is done such that the reftable
> > library becomes standalone again and so that we can use the pluggable
> > allocators part of the library.
> 
> I reviewed this round, and it looks generally good to me. I feel
> somewhat unhappy to have to force the reftable backend to implement its
> own strbuf-like functionality.
> 
> So I think it may be worth considering whether or not we can reuse Git's
> strbuf implementation through a vtable or similar. But it may not be
> immediately possible since that implementation just die()s on error,
> can't easily swap out the allocator, etc. So perhaps this is the best
> path forward, it just feels somewhat unsatisfying to me.

It's not perfect, I agree. I initially tried to do something like a
vtable or to even compile this into code with something like a wrapper
structure. But that approach in the end fell flat. So I decided to be
pragmatic about this whole issue and just duplicate some code --
overall, we are talking about ~200 lines of code to completely detangle
the reftable library from libgit.a.

For what it's worth, I also had this discussion with Junio in [1], in
which we ultimately agreed that this is probably the best way forward.

Patrick

[1]: <ZvVPiIzzLTTb75b8@pks.im>
