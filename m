Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375C1990D9
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420729; cv=none; b=Z3QqvbZcGeHmGh0TRct5pkJ2IhRZ+LTTcnMp5F+XJVsJ676bWLTVifkfpravo773GGGQbYdpoyaprpYH51meeDRrYOi4o34cF2wMT4IslsY6PLcVp/SysDon4ygPuXif01l70uJpOEd4HdkVQ9DhAIh9YzNPRNEbsOQM+/1iJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420729; c=relaxed/simple;
	bh=4oga1qNCi5bFBh7DZkgge/iuzBvLmjfjZNAEBwULAL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAwNfKcc3To5RWWVkB1nuHDq8lFHShOobGHEJwyPHkBuXHUP3l/PwR0khc+czLu0Ib+O52H1Bt4b6mqR6oUP37LmipC823spvVaRg86/3qOeF3/mo73AtEP1a2A20Ld4PREgvzoKMoH7YPydXy5D8M2BlOjM1Mh8E6MB42axwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KFUYx9E8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mg+78W3K; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KFUYx9E8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mg+78W3K"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 975801D0014F;
	Tue, 14 Oct 2025 01:45:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 14 Oct 2025 01:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760420724; x=1760507124; bh=k0eaEUPFWz
	JXX9RQJ/eYSyeNEtfp5NyTxbVO7z7kmzA=; b=KFUYx9E8JJ/6hF+SxCNoFPQ+E+
	EfI0mt6FKesjQKbDTNbj41VZOQh9O2mxOJ5NqOP7r8bsL0mZLXVMuNdNmKeJUfs+
	VrggeFF9Rxb3W0hkQHxmIk3TgaGshthZ5R0ZwgtA0/zOVz02+j4P6E3iJ9yh06pl
	kvj+CYLU2Duz0rYrup54ZMTMdCLO9b12n+nUVsKh31lBQBzNGVB3i/lUtjOX4J9u
	+fkuFSP6iSxXhIIHT/C66DZ35/2N561zzziIFOjp2nfTwmlnZY2IZADXjhNP+9RX
	Q0JTTuOGf4ehwMJ1dKAX3YSe+Gt6aG9asWMHHJNunAv0EVtEeDtoNTT1P+5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760420724; x=1760507124; bh=k0eaEUPFWzJXX9RQJ/eYSyeNEtfp5NyTxbV
	O7z7kmzA=; b=mg+78W3K78vN8HZPZ6uC9Q8QRR7Pfk1clfAMUK7UgV1pdU/VaFR
	b1XAoRridNoJD22FA2pqYzLSr2tFc4BGpJyaociqX6vvX7mlRkvIbVGc7BQQv+Pg
	/tlXxMYNFamS+5YaBOIs+/yl7ou9jb2B8yAhlenZBLxj4SnRfNwMOnRBJzLCZWtJ
	Ve6wGWLNxN0XK0J7kg0OIaZxha2/Lwyn8SGZ7p4X7wXICURqB54h0Hogi88NBoVV
	8RPbRS++FMnl4xemDMAuld/svFc3qxjiJuBurL7wzXfTtGFKf92OAcmAjjL0U2JL
	E4gvDq/ud0rCyAkGrBtVe3sQLOdS43RXOTg==
X-ME-Sender: <xms:dOPtaOvcd9wVuK96TszJGLFMqYJ9422epdtreCLd96XMg7MOZ02sOw>
    <xme:dOPtaHJzmfmxMr2hY8YbkubnQvX-HCe5v3y9P76EeVs8zqMMwveR57bn5EIfL20I2
    MCLzdcFIF-qmbAztIN8AYnHuDr3Gi74XDqyKP_-a4yMudfZkuQs4QM>
X-ME-Received: <xmr:dOPtaDnu6bUrDhyxKh9tAmW_h9X71Ki0aQUAQ5yoCYs0Ox7IhurX8fSqKDXdgNk1C6fu2gqOq4Fpu8yNANop_GoTqp0naHe962SCDPebYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:dOPtaAIUG4_RnfBkKjUkeRAwZ7cdr9CSVkGapha8Ln63Yz-ba3F6dA>
    <xmx:dOPtaA4gz9bcl8Q4QNwSvyuILgHsQEgLE99ax9Hc-c-qUTJjkPr6Ww>
    <xmx:dOPtaM1YFc2PjaxmTi7EldTaPkU255l_P0yKq1XaW-FB1ZUuXh2gQw>
    <xmx:dOPtaOdz4zAq4RMK7JqL4M-0b7hpp1WxKTqnGLQDb9LE4Fa_PISKgA>
    <xmx:dOPtaLQh7vRkrOwJ6xN-WhrfIXID4Sx8SVxg-ks_BRy5XrlKCjwe1IsC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:45:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73eadbe8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 14 Oct 2025 05:45:21 +0000 (UTC)
Date: Tue, 14 Oct 2025 07:45:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: add a explanation of Git's data model
Message-ID: <aO3jbnXRI67JsAx7@pks.im>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <aOjzQ7-88m5e_YJl@pks.im>
 <xmqq8qhe5040.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qhe5040.fsf@gitster.g>

On Mon, Oct 13, 2025 at 07:48:15AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Oct 08, 2025 at 01:53:41PM +0000, Julia Evans via GitGitGadget wrote:
> > [snip]
> > Not quite true. Pseudo refs are outside the hierarchy and are in fact
> > treated differently. But root refs are treated the same as any other
> > reference.
> >
> >     References are stored in a hierarchy. While most references are
> >     stored in the "refs/" hierarchy, some references with special
> >     meaning like for example "HEAD" are stored directly in the root of
> >     the hierarchy.
> >
> > I don't really think we should get into root refs vs pseudo refs here,
> > so maybe this is sufficient?
> 
> I do not think "root ref" (or pseudo for that matter) is a concept
> that has no use in this context.  If this is really about data
> model, where you find refs (or what the "pathname looking" thing
> exactly look like that names your refs) should be immaterial.  It
> does help to know that HEAD is just a ref.  It also would help to
> know there are symbolic refs that point at other refs, which is much
> more relevant to the data model.

Yeah, I don't necessarily think that we need to mention root refs here.
But what I think we need to avoid is the following sentence, as it is
misleading:

    References are stored in a hierarchy, and Git handles references
    differently based on where they are in the hierarchy.

Pseudo refs are stored outside of the hierarchy and are indeed handled
differently. But root refs are stored outside of the hierarchy and are
treated the same as any other ref, even though they of course have
special meaning to some commands.

So maybe something like this would be preferable:

    References are stored in a hierarchy. References that sit at the
    root of the hierarchy often have special meaning to Git commands,
    like for example "HEAD" or "REBASE_HEAD".

It hints at the fact that these references are special, but not in how
they are handled but rather in what they mean. It doesn't go into our
two pseudo refs at all, but given that there's only FETCH_HEAD and
MERGE_HEAD I don't think we should explain them. The water is getting
somewhat murky around pseudorefs anyway, so it probably only causes more
confusion.

Patrick
