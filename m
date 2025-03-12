Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1A254842
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793819; cv=none; b=atZNH11y/yKpeRqBVoWXPKSbjAMgSGWlcPjxFywgXpr72bzZtrs7g4yFQ7l37IlneknSff5Mxqa/8SManLt6C1yVrHd0g3IunqmNXd2eUpRgcuJ2PktEZACZqDHi/ASqyOz9L1/2DpL0GACJ8P4yYq4BhSUxlFq/o3GfNRxQy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793819; c=relaxed/simple;
	bh=tbCM6ZLqw1JyO32hUwYlo1es/xVjvjeTBUPkqmCreow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fjpb94gv8ne9K6GvjHXe0haZAJmUd1j9KPsd1HeOxhfbBpxv8/zHxY6pxGop+Uk2pyCZrsepcJ45f7AkmtB/5t+r5PtqBODfj/PSzqTriRD3Kxo8pOj9edkX9siCGUZw6c6Xb6GY4MmF/asjVT2QHDXzLiW96O96TwQxU86+0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tci8Anws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YquJbQ1E; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tci8Anws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YquJbQ1E"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 397611140208;
	Wed, 12 Mar 2025 11:36:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 11:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741793817; x=1741880217; bh=daRDDUoTnB
	oXDbeWg66+eu4UNEG3n/grlU6z+h2uOnI=; b=Tci8AnwstZT1l05/3Mx8fGJfLN
	76XteaS9xjk1IXk3446sxnZMoVuKUgIWAo9/aDBZ5y6oKvZPDbpdEwdEOOJC4IRm
	lrwCNGB7GpVGOZwY6DtQfDWADCLnWmHvdm/RCJcByntBY9njd0j2NdetfjXEnag8
	mOUMG7tx3INF7toyds4vhgchFlGn93AMrryMhxq2iy459NJV6NVui15Hw2jMQFN8
	UZ/34e17/W5/7H4T652Pto016PpDtBeDfTH5UZ97e0RuzENV7gBdEd2GyKFJ83BD
	QTODQIspt2B7l8vd1D/x0eYjauNqm0wNuRG/88PczTj7fAw8C1Mtvoh5CsXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741793817; x=1741880217; bh=daRDDUoTnBoXDbeWg66+eu4UNEG3n/grlU6
	z+h2uOnI=; b=YquJbQ1EByKmuO1QAIRxT45+sEO8AsOIEXsIGtk/k0c9WkU7u1W
	KKZ+aj49PGfcRDE+UFsG+sqh1wvWU7mfnU/G+co7Gc0aDYIKAp9+/Immn6Nmpujl
	7dCEvf5+7nuJIyU9j6jhrJ+cJZGcGxDWk/e/JlDm6iU+9q4NVZqWOZMpj0MH8fqR
	jg5I6ic7EbaeNp/fIFEa7CCfl1BkWWyC6emenK+Mo34NPmVMJL3ouR3emO3BD3vy
	mpAxfA8bTYwZlaeFMww/tBLIm7GLnzcxLot3rTUt/jl4OtvA/CbzQSVeIF/F2uVw
	/6mXko00miK3GcMWFbxvpu0pAbiMfzjc0Yw==
X-ME-Sender: <xms:GKrRZy3VyXga5QDpB0jWalPePZarvgWLT5UgBWQUlHUH8lOfwg3_aQ>
    <xme:GKrRZ1FO6JbpayRjZjGNIcAD1fWxFMKVpMCvwJ1hzV2bMpft4ppWtEld15R5--zdJ
    TXlcVhJ0Kfq0_mIjw>
X-ME-Received: <xmr:GKrRZ652Ul8nRDpkCP1SdzcEHZtBToTCSn-yWQhBaACvD-hFoCinbnWTZ2bsbCoGMPECbMg1CyIcNPSGbxu1uTgzt2_UyqIA2he0W7uiVBIptD3qIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:GKrRZz1ICD5d3mpQqsgrX8DsRPaRWeOQzgfgko32avjB7glhKzICQw>
    <xmx:GKrRZ1FU7ZRm7wLXe5Szy9I_26ptpJnzlSwLtN0KXDjSWSC1cR-P2g>
    <xmx:GKrRZ89IYBzWd5fUf7PpgOH2pXGrMXpgVBqnISR6a162ZqAn1QULdg>
    <xmx:GKrRZ6mL2qm5kvstmlEi_IXo2ZMrNL8gkPIfai51OTPhV3HWZb8EOw>
    <xmx:GarRZ80OtvDSXInQLxAJRP31bd-zhTU0TTjdPKj-lGxXljyzLVN9ZC41>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:36:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 425f64b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:36:55 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:36:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 08/16] refs: stop re-verifying common prefixes for
 availability
Message-ID: <Z9GqFmLBX6SAkgZy@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-8-dcb2ee037e97@pks.im>
 <Z9GKs9z4n4qgOP7n@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GKs9z4n4qgOP7n@ArchLinux>

On Wed, Mar 12, 2025 at 09:22:59PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:39PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs.c b/refs.c
> > index 5a9b0f2fa1e..eaf41421f50 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2514,6 +2517,14 @@ int refs_verify_refnames_available(struct ref_store *refs,
> >  			if (skip && string_list_has_string(skip, dirname.buf))
> >  				continue;
> >  
> > +			/*
> > +			 * If we've already seen the directory we don't need to
> > +			 * process it again. Skip it to avoid checking checking
> > +			 * common prefixes like "refs/heads/" repeatedly.
> > +			 */
> > +			if (!strset_add(&dirnames, dirname.buf))
> > +				continue;
> > +
> 
> Reading here, I think we should not sort the refnames for "reftable"
> backend. Anyway, really a nice job for optimizing the speed.

Agreed, it's unnecessary for this optimization.

Patrick
