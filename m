Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEB2E3395
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405603; cv=none; b=sZ9QaiWawB3WOkBwVQ42exgHqu9upyi9es5lQVnM8UO9BuBx57iyL2zVUdITvi9eBHdGBBlXLnynDKQ7Yp+uZNT6nnvINXmOLp5Asv+RfGfLEsSMXPEO1xPOIC3Fw6c3FyTl6DISls/Ek7UvzIp1Jl6CxY5fs1lTZudwLPm/VfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405603; c=relaxed/simple;
	bh=D6ncd1FUBUbHXA6/dC4zcZqYZB8XohQD8WJ0xl9P6fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLD6U2uIm5YUrGFlPnhUO/J5LEwnLD6zBfby9MSsVgJFTd2N2qRbY1KrLaKWaR2isGaJKCdgaKEeVSHAsnCZv9rOe/TL6As0CJoM57FvMavFpge5FIhw0F5gdy9/ljueCzrsZ7FCJCcreac8Xz2GroothKMY1SyyVdZaXUmATMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mRnenspk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KN2PV26s; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mRnenspk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KN2PV26s"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E417D1140145;
	Mon, 31 Mar 2025 03:20:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 03:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743405600; x=1743492000; bh=S9VAXrBtsb
	aWeRSqsk32FGuOC/fpjB5WS/bDgQb1GcM=; b=mRnenspkCGUJoSoTS6/53egeMp
	dV0PF1hXjgd2WrMsJ+7CvYzc3uZ23YbrUw2UZ4E/o/CGzwef+foTwMWfigQAyUbZ
	kJB8ygVgaCY4LIS84AFIjU4paEB5FAbbnbENAX+2aZDjnYYK6/9AutsxS2erWYjE
	g5ohGmbpltd9cS+HGmcjQswk7iBkf66yioWdta61jiuFkmhWaoe+TtT8XaVKhIID
	UGnDdmLZ3f8+lAFqZDpCK2PiVzHir4eaL7yT6/UUXbieccX9g408vohDU1gA7y+w
	rzrkFk8E81jjHXBRvAwrTlXtsY/RoOLD53fxrFVMXgAsGFUs+SremjQU3hIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743405600; x=1743492000; bh=S9VAXrBtsbaWeRSqsk32FGuOC/fpjB5WS/b
	DgQb1GcM=; b=KN2PV26sl5Egt+XpImB/UgGVB/XE9tsCRYkByvjZzFl8n2dnjla
	gr2/9cxptr0FW8RQK0g6QZq7Doj0biMw8NwFvnlmOOvU/9MY+h+rTeZZVO9N5nio
	0prHvHe362OSxzqVZKgdxeMJXIE8bqYZ7OWVTo1gZ1qnNYV8KUKT/p2uaxeNEZZB
	THGjk4CFus4zFv4nMSYIUP2IsKrY3uVrLDH2EBty2v//36Lbi7h967OvE+2OepMz
	bMi9boZ465tfivyDsniISWlvjLo0Yu/fDa355Xl4S6i8tuC+F2O6ZzSpfdSPSuPa
	4SxGEjcoMPUgXpqu2CAO1U2CS2SF3W/iCDQ==
X-ME-Sender: <xms:IELqZ9dB8wbFx4GYKDgPiBXAy0TLp0hm1495IXvToWSMXL2P41CHBg>
    <xme:IELqZ7NO5O7VFIZjcfde-RMKfB5lh6vaLA9nwn3DdM0Cumt0IgTyUkeRbzM1glEBW
    iBzFfe3QMh8xSiF4w>
X-ME-Received: <xmr:IELqZ2isTpR67AecP-8X_-j5aa3lZCebdGNFAEOfUY2F3pcndXlZw-OvfTwn27XMIM66rI6l3vStrssLnmI3352UZcLJGsLXteL7CjztIq_C6tjm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IELqZ29EKDkdC5RFCiwCnxQA1Pkefcy8fekeOB7Kw9LzDcCbWyXB3g>
    <xmx:IELqZ5uhOBhMWmWJcNS-YYZcYbePiY-4Q9xEspRCLMAs-FtEdN75iA>
    <xmx:IELqZ1GtGBe2mHOBLsbxlBX2tl4eZVDoPscZpNgcffKpEhR-uc6ndQ>
    <xmx:IELqZwMjgnjBtje2dNZpG5xmpwNk59OGllA6-uj8Gg5qJMgCNd-pOw>
    <xmx:IELqZzLv5Z2XNHAH3gkDcSedTRHtvIXILNs563sfE4LADvFydL2Y9ZFe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:19:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dcec6834 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:19:56 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:19:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 1/2] help: include SHA implementation in version info
Message-ID: <Z-pCG9d7Rf9SMuXJ@pks.im>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250328170121.157563-2-jltobler@gmail.com>
 <xmqq8qoodq5u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qoodq5u.fsf@gitster.g>

On Sat, Mar 29, 2025 at 04:36:45AM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > When the `--build-options` flag is used with git-version(1), additional
> > information about the built version of Git is printed. During build
> > time, different SHA implementations may be configured, but this
> > information is not included in the version info.
> >
> > Add the SHA implementations Git is built with to the version info.
> > ...
> > +static void get_sha_impl(struct strbuf *buf)
> > +{
> > +#if defined(SHA1_OPENSSL)
> > +	strbuf_addstr(buf, "SHA-1: OpenSSL\n");
> > +#elif defined(SHA1_BLK)
> > +	strbuf_addstr(buf, "SHA-1: blk\n");
> > +#elif defined(SHA1_APPLE)
> > +	strbuf_addstr(buf, "SHA-1: Apple CommonCrypto\n");
> > +#elif defined(DC_SHA1_EXTERNAL)
> > +	strbuf_addstr(buf, "SHA-1: Collision Detection (External)\n");
> > +#elif defined(DC_SHA1_SUBMODULE)
> > +	strbuf_addstr(buf, "SHA-1: Collision Detection (Submodule)\n");
> > +#elif defined(SHA1_DC)
> > +	strbuf_addstr(buf, "SHA-1: Collision Detection\n");
> > +#endif
> > +
> > +#if defined(SHA256_OPENSSL)
> > +	strbuf_addstr(buf, "SHA-256: OpenSSL\n");
> > +#elif defined(SHA256_NETTLE)
> > +	strbuf_addstr(buf, "SHA-256: Nettle\n");
> > +#elif defined(SHA256_GCRYPT)
> > +	strbuf_addstr(buf, "SHA-256: gcrypt\n");
> > +#elif defined(SHA256_BLK)
> > +	strbuf_addstr(buf, "SHA-256: blk\n");
> > +#endif
> > +}
> 
> While I agree with the objective of the change, I am not sure how I
> feel about the implementation.  Given that
> 
>  - The code here, and probably the existing code paths that depend
>    on these SHA1_$WHOSE symbols, assume that only one of them is
>    defined;
> 
>  - The "git help --build-options" is not an end-user thing but more
>    is a developer thing.
> 
> The thing I am most worried about is that it is unclear how the
> order in which the SHA1_$WHOSE symbols are inspected here and
> elsewhere in the code are kept in sync.  What happens when, for
> example, SHA1_OPENSSL and SHA1_APPLE_UNSAFE are both defined?  The
> above code will report that we are using SHA1_OPENSSL, but hash.h
> would probably use SHA1_APPLE as it has its own if/elif/endif
> cascade.
> 
> Perhaps it does not matter, if the build infrastructure ensures that
> the build fails unless one and only one of SHA1_$WHOSE is defined.
> 
> But with the way how this part is written with an if/elif/endif
> cascade, it makes readers spend time wondering how the precedence
> order here is kept in sync throughout the system.  If I am not
> mistaken, the top-level Makefile has its own ifdef/else/if/endif*
> cascade.
> 
> I imagine that making all of the above not if/elif/endif chain, but
> make them pretend as if they are independent and orthogonal choices,
> would make it simpler to understand and also it will help us catch a
> misconfiguration where more than one is defined, i.e.
> 
>         static void get_sha_impl(struct strbuf *buf)
>         {
>         #if defined(SHA1_OPENSSL)
>                 strbuf_addstr(buf, "SHA-1: OpenSSL\n");
>         #endif
>         #if defined(SHA1_BLK)
>                 strbuf_addstr(buf, "SHA-1: blk\n");
>         #endif
>         #if defined(SHA1_APPLE)
>         ...
> 
> 
> That way, we wouldn't force future devlopers who are plugging new
> implementations of SHA-256 wonder where is the right place in the
> existing if/elif/endif cascade their new one fits.  It also allows
> us to catch misconfigurations to define more then one of them at the
> same time, if such a thing becomes ever possible.

Another option: we could ask the implementations themselves to define a
symbol `SHA1_BACKEND` and use it here. This would automatically ensure
that any implementation must define the symbol as we'd otherwise get a
compile error. We could also conditionally define `SHA1_UNSAFE_BACKEND`
depending on whether or not we have it.

Patrick
