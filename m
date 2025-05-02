Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D01EBFFF
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179859; cv=none; b=hi+/idEZecwaXEnfcWtj0irMySv8pkpms40W5z0BSaGP6YQkEDkQZS08hVoGfJH/P8FPIkQYm51E2pBmvQLed8pXaTsDIKyjJDhWqypd2U05rXsbf1XsRU+OV9iE7d0HsEL7AILy2M3dVlU6HEs0wI9xXrYSXn/tpDy2BrMvM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179859; c=relaxed/simple;
	bh=k3prrzlmGD6o5PNC62FdzJBUTcrki/TBbUWDzi8fMUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru/pAbP4JLcDEYyrpfpKuzOMGnzeFnb3ktcFFTZIQDjzK4bbKgejHvW7UAhxDhxuNcJKYChXcoK+TQVeS4oZt7DzGM0UCCL20hWbvzQY4dTjCzdahMG3G1vcumG4YETovIvpvuSGxXEJEwyrVMBBU03nuOAg2Wp7r1WbHxoe52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ioQUNNI6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVQAqp+h; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ioQUNNI6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVQAqp+h"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74C5611401CA;
	Fri,  2 May 2025 05:57:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 05:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179856; x=1746266256; bh=pz2odnZl69
	msrYQTMmJMLmOo+3PQdV7ukZ6ZsXh8iFo=; b=ioQUNNI60oeRaBW4+DQ1t7GAv2
	INPlQOxmuPhLmVHrSjU72+QBzt278Ni3v6XlPV/kUbK5Nj9dl8s6xcc//BMZBBOQ
	rTZr78p3CyyVU56CXbqnbcTs3SdvMgveeZBRMw19BL32U0vBuZKDqAZwYRqUOicn
	xN0vwDa3N8fxMTRggtTZCvNlukPrYnAPMAnnChJOAMd1K6x4sQE+Iyls5RdHHFjU
	4upXX+QFSO+tUkhqcp+7gCvQbFCoqEnTM6aSB5g0aNgANj201TfrYY+gNIT5xb04
	BAlBZvzHE5tDCncD/jYOMZjLzOcZEiM9bV3ipR+OpabthFRhfgdynMRGS5Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179856; x=1746266256; bh=pz2odnZl69msrYQTMmJMLmOo+3PQdV7ukZ6
	ZsXh8iFo=; b=qVQAqp+hvWAw7HSc+3mgLhIVPdTznN8bobwJCDmHHGE7mPIEtVy
	hgSzKHlXD4h7pp9aamSVAAXsp+4pozBHV0cCRk4VQsEKGejQhIW9xuuGEESe3JN1
	GLQ9lovp+kYxlXN66nnIzdN4XsbQinLXt0UOoIKYjVO+Y+BPtMX/n38tzGIXgGO9
	V+imWAVEmzfRiT/DmpFTD29kfAQtAR32ncRri3E/UlGd45VNV861ME/YcUNFmyh2
	6Z/m67dGKB2FGzfW9WubwUJyIfJqEdlSJy7uxSbLg+aoDE4EBr5Oo5BNlWIPzV9Z
	lMn57ojEDAkZxStYqDlOcA0zSEWf2W526qg==
X-ME-Sender: <xms:EJcUaOKcvtpUcNdHpG8c7YX0HmrKtvqhcHvEhX7dLgG4xtBj4w6GWg>
    <xme:EJcUaGL0aUhHAAMrxcDyN_o5LN4C1MY9xnvSOYdIJR-OTZx--0vgfCarUbfErhW9G
    s9fO_JRo8BHoIOGtA>
X-ME-Received: <xmr:EJcUaOtxZURhLV0aL6lDWWvSnaTR4LjvO7MeRwDuifZlAN7-txQd0Vfd3PATie1t2CbXPSaawOQ2rqB2MdO15Oa74lxegGow_0l5TIKxjis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhufh
    horhhijhhileeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EJcUaDYPElfZcgkZVg35ejiIJwoVDNTKTRYSw4JTsrke3mfHHIVDUA>
    <xmx:EJcUaFbCZmLLzu6w3-xHDZ5wojhyRZRm9tkkKAeDH9EitcITqqBSYg>
    <xmx:EJcUaPCeiHShnWjj-YP86vN8jyk4uSAUxhi9i1pNzMGAka-9i5wLig>
    <xmx:EJcUaLbd1HSY4f6gFwgClOllwlocGRDy2U_UStzTaXosjFYAGtQIeQ>
    <xmx:EJcUaDN6tEzeyXMEn6PzDjAfoNbicI1pwQZ9zDXkD7Nz1d2MRaPDXiuC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3105dc11 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:34 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 01/10] t/unit-tests: implement reftable test helper
 functions in unit-test.{c,h}
Message-ID: <aBSXDQ5BjUfG-GKZ@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-2-kuforiji98@gmail.com>
 <xmqqbjse4ljd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjse4ljd.fsf@gitster.g>

On Tue, Apr 29, 2025 at 04:04:22PM -0700, Junio C Hamano wrote:
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  t/unit-tests/unit-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
> >  t/unit-tests/unit-test.h | 16 +++++++
> >  2 files changed, 109 insertions(+)
> 
> Hmph, this probably is a question better asked to Patrick, but it
> somehow feels a bit unsatisfactory that we are duplicating instead
> of replacing, as we cannot see "ah, this removed thing is now added
> in a different shape to fit in the other framework" in the patch---
> instead what we see in the patch is a bunch of "a completely new
> thing that honors the convention we are familiar in existing clar
> based tests is added here".

Well, my expectation is that at the end of this patch series we will
remove the old functionality. The steps should roughly be:

  1. Implement equivalents for the reftable-specific test library for
     clar.

  2. Convert all reftable unit tests to use the new functions.

  3. Remove the old functions.

Given that (2) is a bunch of tests it makes perfect sense to first have
a separate patch that adds without removing yet.

What I found a bit confusing though is that the new functions aren't
added to "t/unit-tests/lib-reftable.{c,h}". This would be very much
preferable from my point of view as the test functions aren't globally
relevant, but really only relevant to the reftable library.

Patrick
