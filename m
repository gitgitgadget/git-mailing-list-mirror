Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4C1E6316
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989104; cv=none; b=M0nqrkAi5u3kJLa0EWJ/8gIbT8OqqW5oX6ScNcTKwDN4Cvgy2acQpNOlQvevrF/y2cQis16HnBq4ZbZzEOP+UrdOFjEaf+5883bJ9FbSZuXh+eHdC+z8FNRcYXZaFj6ZTFoecW6n9DH6tlKW/kWd//JwBh6zQ0sha7IdTduPyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989104; c=relaxed/simple;
	bh=i3W2FXRCIACpTX3YBy9WPpscBIWget48yJtBxPCaocY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH3/1Jb2zkj8LdXS27NYktkRvyWqHS1UcxjOEDtXa7W8/hAzXtlDXLx54qnvpNhxxGPAGiYQRE95qJanN0FiL6fsn6Laqt0+3z8eqRn84c9y/LEMPUEh2UEfTaKAA+YEYV6NQXQlo12CqRSJBCc/+4o6PgAwv8glN0EILSH6UMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n3QhUXIW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMdPeVVk; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n3QhUXIW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMdPeVVk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 669A911400B7;
	Tue, 15 Oct 2024 06:45:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 15 Oct 2024 06:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728989100; x=1729075500; bh=9588bPoz8W
	uXi9Rgi4TEBmGP3xV8BkoCh3p3q8T2P/w=; b=n3QhUXIWsRvTP74I45kMk0s4lC
	9PFFWLYOtUUe4aB/l3SBak7twQOXVqk/fIAY9UKUzOVhjQ73ovwP6YdV97v0KWMf
	Rtgs/9ObMi15S3hlFKsAiT+jaOiqThg1EmEIalRPEjqrjvheMQj2+cXWa42YUNnr
	wlJYOe9dgl6Zu26besF8JFdtN8ObW2dpE0fTbc7LZkZ04kNNpKwvf+G6pUanNhUh
	kDyizhQxALEzjwKMnr4tFmkvWoJg9PtnT1GuS1VjgZRkMw+WJESwvzQHsAMo6V6b
	YtfCCtxbf/4aU622RSWQsjm2hyMJms+1vIgPrKYdrWujdN+9KWSwNl7ghpQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728989100; x=1729075500; bh=9588bPoz8WuXi9Rgi4TEBmGP3xV8
	BkoCh3p3q8T2P/w=; b=SMdPeVVkdS2vXg7lAan8IcX/ol60Jyl+YZELF6TpKVmz
	e1pHw3RhPIlVblCV+O6m27OJRoPvLX+4taEBSi8dWSd7osyuWHKdYGJXW8JvnLOS
	gP+/SWT9tfzlOM1baDv8nLC4rNewX+J027IaHfrvHjFDAlTgKdV4VLKTpIV5atYL
	OcsTI5SOHVYS9uRIGb4Qenyh91YDd8F3zrAuzNctnzsy85ovwPHoKGQqrwMkY1cB
	HjvaVr7/E8yiue9pmEyunU1KW2BRs6cDCukid1UE9MD/Bm6JNk0TBdFLefavO1je
	Ex/Z+X+/Nsi0byhO89feE1MUwuBfIqSUj8kTTnb3sQ==
X-ME-Sender: <xms:q0cOZ_SFd08xdAsLyEX-a28aKdeRLt79pPVtVwss1prWsy3DTcl7LA>
    <xme:q0cOZwxdI5Ve7z1VcbHPequKmMK7BaBPqw8h00dFKNgDeKDQqIgZ7zKJL4GH1bj--
    6dBUr8VYHmImNA50A>
X-ME-Received: <xmr:q0cOZ02-F2wB5HjSBeHrx57yPkuMTvxLBFsW5Y5A2pjDMxR0WxEE7v-SOtQ6ezizhZE-eK8s7g59R6cBWiQr-hNIkE4FZq3JAo3FtAwh9LxR4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:q0cOZ_Cg9NTTTjfKXcMqnyd-zpq3TIYxASKgD6D2wqe505YTawFCEA>
    <xmx:q0cOZ4jqQy6UA_qtQPHkM4WI7djZ4FyFPXCku86SO9VOdoSDm9G3aQ>
    <xmx:q0cOZzqo5117OEvZMHElln0OA-U6Kr297-vREGOlAmaoPaVVZVwfXg>
    <xmx:q0cOZzhO3PCHmfePBZjpkfxVtzFgbqg3hfepQ9UuWAEFYOg0r8PuHg>
    <xmx:rEcOZyY_rTN9ZVygOrHjLuV8AP1kuSVKYlUJVfqZaK-_Vd7hSQr2KtyN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 06:44:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d062d702 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 10:43:40 +0000 (UTC)
Date: Tue, 15 Oct 2024 12:44:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: stop using `struct strbuf`
Message-ID: <Zw5HntIyk_DLWESC@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <Zw2e0w5bkDO4l/Qs@nand.local>
 <Zw3xkX_a4KyrSNq9@pks.im>
 <Zw5E8d3AotDBYKSA@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw5E8d3AotDBYKSA@ArchLinux>

On Tue, Oct 15, 2024 at 06:33:21PM +0800, shejialuo wrote:
> On Tue, Oct 15, 2024 at 06:37:37AM +0200, Patrick Steinhardt wrote:
> > On Mon, Oct 14, 2024 at 06:44:35PM -0400, Taylor Blau wrote:
> > > On Mon, Oct 14, 2024 at 03:02:16PM +0200, Patrick Steinhardt wrote:
> > > > Hi,
> > > >
> > > > this is the second part of my patch series that stop using `struct
> > > > strbuf` in the reftable library. This is done such that the reftable
> > > > library becomes standalone again and so that we can use the pluggable
> > > > allocators part of the library.
> > > 
> > > I reviewed this round, and it looks generally good to me. I feel
> > > somewhat unhappy to have to force the reftable backend to implement its
> > > own strbuf-like functionality.
> > > 
> > > So I think it may be worth considering whether or not we can reuse Git's
> > > strbuf implementation through a vtable or similar. But it may not be
> > > immediately possible since that implementation just die()s on error,
> > > can't easily swap out the allocator, etc. So perhaps this is the best
> > > path forward, it just feels somewhat unsatisfying to me.
> > 
> > It's not perfect, I agree. I initially tried to do something like a
> > vtable or to even compile this into code with something like a wrapper
> > structure. But that approach in the end fell flat. So I decided to be
> > pragmatic about this whole issue and just duplicate some code --
> > overall, we are talking about ~200 lines of code to completely detangle
> > the reftable library from libgit.a.
> > 
> 
> I have read some patches yesterday, I feel quite strange that we need to
> make repetition. Could we provide a header file which requires the users
> who need to use the reftable library to implement the interfaces?
> 
>     reftable_strbuf_addf(void *buf, char *fmt, va_list ap);
> 
> Thus, we could reuse "strbuf_addf" to implement this interface in Git.
> As for libgit2, could we let it implement these interfaces? Although I
> have never read the source code of libgit2, I think there should be some
> code which could be reuse to implement these interfaces?
> 
> However, I do not know the context. Maybe the above is totally wrong. If
> so, please ignore.

The thing is that we'll have repetition regardless of what we end up
doing:

  - We could either have repetition once in the reftable library,
    reimplementing `struct strbuf`. This can then be reused by every
    single user of the reftable library.

  - Or we can have repetition for every single user of the reftable
    library. For now that'd only be Git and libgit2, but we'd still have
    repetition.

The second kind of repetition is way worse though, because now every
user of the reftable library has a different implementation of a type
that is as basic as a buffer. These _must_ behave the exact same across
implementations or we will hit issues. So I'd rather have the repetition
a single time in the reftable library such that all users of the library
will behave the same rather than having downstream users copy the
implementation of `struct strbuf` and making it work for their library.

Also, due to the nature of `struct strbuf` not allowing for allocation
failures we'd already have diverging behaviour. In Git you would never
hit error code paths for allocation failures, whereas every library user
potentially can.

So we really have to treat the reftable code base special. If we want to
be a good citizen and be a proper upstream for projects like libgit2 we
don't really have much of a choice than to detangle it from libgit.a. If
we don't we may be saving 20 lines of code, but we make everybody elses
life harder.

Patrick
