Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E002512EC
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793802; cv=none; b=WUeNRQufCec65cTsWwWTTj1rnguGqv8s7MnF+qvzrZr+jd7qmaL3bVIJEETLpGP3R90/rG0on31ljtcI+RfzQEZGaa88eMIiegoUyofUs6NYpCIQmJv/nPLbYGdlpkelZgQcNRey9LbB/aT+GKr3LHM4sPUD0DryHSRt4saZIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793802; c=relaxed/simple;
	bh=SR7cBrEdiD/ZWmn8FOCkdviOfWwpmx9JYG6zLWcPJ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPvbCuFpj9bzhPz5AZi6uGdsLmn2UjJjrCh2/s7Pq2mcKbrroeDK7gIgoQPk8huhOZEuW/4fwe7/2C9XaRDlAwP5V/8z2EzbmGn/PAfiiRY36VGi+Sh+KE0RgOuyzaF/ZKpGByKdF7TfLzYslY45RR8CxhFydPdmaZirfde3i84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GHIX4U1N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9zN2WPt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GHIX4U1N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9zN2WPt"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98F7E254025A;
	Wed, 12 Mar 2025 11:36:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Mar 2025 11:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741793799; x=1741880199; bh=wqv387IsWe
	SB8X94GvfsaSIRiFv7VRpGl5FAWamIyKo=; b=GHIX4U1N0GFZ7IbUOVMBJlkY7e
	nWLA0ClE1HK29iaeyEvOnGDtHiLptEFZQz8hI9JODt70Q7VdJr7pfpKIkTMRo9AL
	bYoJhn4Gv9l+WIb90dHNdkp700oUmWIijKiTuiroudfPezDtVUNCJJTrSWs9kY1c
	IDbiMFleLfR2zix6GsQvl6E7o5R4bC51EKNsEUYDdH90ew21OGAODo3nOEX+ShFN
	S9u8sQxecgGYvWPCrESqKzMjgZ/NOKAUnEozokUqiGDYgyawzhaiq/l4WujyKpcD
	Ef5KfKLQ/rU9QVIBkBOkN2JgBoA78/u1L1G0nilRBleSIXIV5/2GB3Hdr0yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741793799; x=1741880199; bh=wqv387IsWeSB8X94GvfsaSIRiFv7VRpGl5F
	AWamIyKo=; b=S9zN2WPtVL3odghdnCNM55AT4NPf14mAkc8eh9L4cFnrcZQ80CQ
	wVeYxLOMZqj+Q+x/uNmdbY/yr695hjOPH8Mun7mEKgmy6Poo+ptvo/X7P0r68ATi
	AMzcqeDKMBslLXUhDw9unXUNIoJ+zJHM559ZeCWtizj7bogSJ0HC0ldJIT6Oq6yU
	fiYYee6jVH1D8Ayfno30vVbV9HJ+V7SU38NCaTqPoLBchXwK+PRs8JmU21khC9fd
	2n+buXihzQcRLchgDcxyGKffjz8X2kAlzcJztu/eXNsbc4wLC/LThamrZQsjIshj
	CxTH4TTjDeC4nnELh5DXHJGXNX36DSUl2JA==
X-ME-Sender: <xms:BqrRZyOcTWiI95WoVDTUqp6ZpwQd3hqsqBvOKCXhlrUXliNNOTOcjg>
    <xme:BqrRZw8JjbXznd7RA1noh8xz9JvlfIZCBxVb0rAV6_zbxAzMMhPbU7U8Zkm018-B1
    pJdvJigMPn1hFxR7A>
X-ME-Received: <xmr:BqrRZ5StZFYY3kOuDbiCQJfO0QEkXZ5avt-93uTC9ZSKJI34F_heCOl8ctyQoz5SogfyU4kHNt3qOIuNt7rLLPBMw6pM3lVKTz2MxHDaDGkrflUB9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:BqrRZytMJN7ZPmXQWomWYP2qSLVV9BPbwxl-yfRbU2T4WjAjgHimhA>
    <xmx:BqrRZ6fUyu8C9FE8gER752SpCcz4mcJzIdm0so8rFrCQnaiXOMtkfQ>
    <xmx:BqrRZ20xRbGb0N9eRVtp0Va-CDaOBLdar6MBB0rvPB2VEm-eO4Ry5g>
    <xmx:BqrRZ--K9y3O67pZDQrVkHsGaYlpECZUMf3-1jwWvV_hgqxzTNLOFg>
    <xmx:B6rRZwv1FuDgqF7ODanmMAIhGCTgwo2CUgRRF48UPzVhneu71NZMPv7k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:36:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 115295ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:36:35 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:36:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 04/16] refs: introduce function to batch refname
 availability checks
Message-ID: <Z9GqAYy4E0JVU7DA@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-4-dcb2ee037e97@pks.im>
 <Z9F_3xu6RXeelXJK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9F_3xu6RXeelXJK@ArchLinux>

On Wed, Mar 12, 2025 at 08:36:47PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:35PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs.c b/refs.c
> > index f4094a326a9..5a9b0f2fa1e 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2489,79 +2485,91 @@ int refs_verify_refname_available(struct ref_store *refs,
> >  
> >  	assert(err);
> >  
> > -	strbuf_grow(&dirname, strlen(refname) + 1);
> > -	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
> > -		/*
> > -		 * Just saying "Is a directory" when we e.g. can't
> > -		 * lock some multi-level ref isn't very informative,
> > -		 * the user won't be told *what* is a directory, so
> > -		 * let's not use strerror() below.
> > -		 */
> > -		int ignore_errno;
> > -		/* Expand dirname to the new prefix, not including the trailing slash: */
> > -		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
> > +	for (size_t i = 0; i < refnames->nr; i++) {
> 
> Nit: we may just use `for_each_string_list_item` instead of use the raw
> "for" loop.

Fair, can do.

> > diff --git a/refs.h b/refs.h
> > index a0cdd99250e..185aed5a461 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -124,6 +124,18 @@ int refs_verify_refname_available(struct ref_store *refs,
> >  				  unsigned int initial_transaction,
> >  				  struct strbuf *err);
> >  
> > +/*
> > + * Same as `refs_verify_refname_available()`, but checking for a list of
> > + * refnames instead of only a single item. This is more efficient in the case
> > + * where one needs to check multiple refnames.
> > + */
> 
> Should we talk about more about why this is more efficient?

I don't think the caller needs to be aware of why specifically it is
faster. All they should care for is that it does the same than the other
function, but that it knows to optimize better.

Patrick
