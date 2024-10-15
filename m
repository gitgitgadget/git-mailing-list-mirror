Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13743ACB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967107; cv=none; b=gaRZ3LtwbursdmO1h+Rme749lrB+wHpTvZcjIz9OWcorYxCh5+hUGgdnwFncGiFCQDaVZkdibcwSHp1YsBBe8v8pLpNYOcE/hy5dKpcqjjWUMxXfb9G7fvZiIsMafNJyUmjdmtR6wktxlI7qNH+tI67wx3WtMyRxQ9L1asE2lCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967107; c=relaxed/simple;
	bh=ZmbZXDHQeoNDTiQmvv7yUuMAU7OssW23ou8TCmfFzlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXC1WXAJva1atFAEY3tK7FLODjQq2dHOpg5HzO0prwqoQlWgqBDv1kQsTHtBUqgSoa3VQ3y8y7gJ92TOTNfRbTFDqovWRsJS/1akFWQP5axkStnO+f4fzAzSakvHKt3gI6+slszUDWtLvMYhKrNSafpLo2VfHl1Yutm/DshDZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hyhRb7Co; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEnhD+4R; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hyhRb7Co";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEnhD+4R"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77B281140086;
	Tue, 15 Oct 2024 00:38:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 00:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728967104; x=1729053504; bh=lNXG2Esx01
	em0up5DHoAL2H/hXSzl+F69DLwzON53yQ=; b=hyhRb7CogO6jj4SfrtlkxEihcF
	R77zq7PGeToDpgHOWrOGM7XA2+EPN03Wp9gp+pay6yDyCo0IQQaVMpYMqb7217rn
	JJNUme7kCbTQAwo+zwfBmeCnXiy506Cu5gNJ5eYlRfCiW9MA7lgeXXgZX2MhxtSO
	mPeiOUVllubePW+d3NirtHICnun8a//fvil6bjqzda7sNxgBY4lHOCj+DNYraf+m
	LyoaCvytMvYH3QqkcwJWTMvl4Uw3fFz1/F9OzuMGPOQmYLNN22YW5DTiW3y6oAWP
	SuXS3dNhREDjXyF+2gqIdfO3cFyzIYl6hYP617AZfoNswALADFj//syjyfaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728967104; x=1729053504; bh=lNXG2Esx01em0up5DHoAL2H/hXSz
	l+F69DLwzON53yQ=; b=XEnhD+4RInXEcHVpijWuTi8Oa1SXRfKog3wDQACW+mJw
	ZINo0HckhuFq8HoXSa04rSIP6AMggCDJ5anbE3LfmoPbloxhU2Rp9q9Ht8J64t6W
	vGxHy6DEIrdJeWGVIgdYMHFEwUrwzBmo6wfytRJBSZjzP2XrYptmzkHZPNUI+TsP
	iePWE2f03RKpIOINDGqC5DcF6/o876ziCNnRxEofvmY+fTNG/MpfIBmfjYiP8pvw
	aqmIAoXPofYngmCVB9WH32uUTC+gSO7RtHLRx2BSLh+0Hm1x6o5KyV1WWl0K0Rm7
	nw2/H95gVdRJfC0crol+99PqS0QHSAIcUKUuD6s30A==
X-ME-Sender: <xms:wPENZ1TYXX0oZ-xoQKd2RQ2ohMHF0vhuCLSk5DrpOzG3HqRP2wTtiQ>
    <xme:wPENZ-yvtj5wBGCaBMhmOCpqLNr4x2VI28qXnp6aIpKdq6YuQA5MYsqFLIzzBAs7h
    0yXMJhBjeE8oLI_fQ>
X-ME-Received: <xmr:wPENZ61Hx6J3dozFhkhR4LOdMdBInojy5f8JMn8LmmkWdqW7O3k2v9qyE6AyGhowvRtpJLHPVuHLsQil5KP1LSytTZ59i6bhL_RBTX15LhEj3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wPENZ9BenrdDalJp11_6tD3IQQsVnGyLuJqTXBbRcsYLQBgQ3X81YA>
    <xmx:wPENZ-gCoXvqpXuFT2LgiVcI2dAVSmQo9wbCvlj9QMzJPCrmslSO9w>
    <xmx:wPENZxpJ8aqu65gvPdXrGkOS0-gzUb8lvGhm15LxchT2Kn4d9I8grw>
    <xmx:wPENZ5gN__KMMjyOv2Ot1TSLqsQPC3VC4SoB8rKyBtKCEMbO8-eG5A>
    <xmx:wPENZ2e3O3Dequ78AxAoxBRXCPeT4qKq-KcbgCTeF6uBy3SI2okNEgbw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 00:38:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 774bd040 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 04:37:08 +0000 (UTC)
Date: Tue, 15 Oct 2024 06:38:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <Zw3xhwLFlznU_JvK@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2cjxpDf6MowCP+@nand.local>

On Mon, Oct 14, 2024 at 06:34:55PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> > Implement a new `reftable_buf` interface that will replace Git's own
> > `strbuf` interface. This is done due to three reasons:
> >
> >   - The `strbuf` interfaces do not handle memory allocation failures and
> >     instead causes us to die. This is okay in the context of Git, but is
> >     not in the context of the reftable library, which is supposed to be
> >     usable by third-party applications.
> >
> >   - The `strbuf` interface is quite deeply tied into Git, which makes it
> >     hard to use the reftable library as a standalone library. Any
> >     dependent would have to carefully extract the relevant parts of it
> >     to make things work, which is not all that sensible.
> >
> >   - The `strbuf` interface does not use the pluggable allocators that
> >     can be set up via `refatble_set_alloc()`.
> 
> s/refatble/reftable/.
> 
> > +/*
> > + * Add the given bytes to the buffer. Returns 0 on success,
> > + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> > + */
> > +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> 
> Is there a reason that data is a void-pointer here and not a const char
> *?

Only that it emulates `strbuf_add()`, which also uses a void pointer.

Patrick
