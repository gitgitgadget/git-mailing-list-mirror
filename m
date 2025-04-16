Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E82459FD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799288; cv=none; b=Pr9njtciexeSOE1aKYkTkBqX1oTrkG/z+hZuYKBDnq8cl0Nxd033QhTa3oFYhEWChqOH3CUDCnAgq52K+Ui8ybRMC/nkHw1C9PcgNt3T5XMjjyzvOQ6jxiVh6GR0L1gFGh94BFKzVUd+BJgi5LRctJpVsdUVMF160qadx6KFnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799288; c=relaxed/simple;
	bh=5Slg++Xo14BHrOTSkPEnDsGIklQpbiHSrgEQ3Jm3s9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtxpd/I0jrKBrMxbwkJoe0jJOWpjhxVNlMPpAXVFXV52qA9TIRK4JATVxJd/hlT6EYs2wyRENLvzIWRNur92iT5XfMVuc7in+9Hnt2cccGryjIssqAvtuhEJTZ4RiGOot43owG/ot8LJvWcrbL1TmL7vSsEcLnDs3NC1TzZ9sQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PqjYcFKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4eOXn7R; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PqjYcFKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4eOXn7R"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CA62F13801C9;
	Wed, 16 Apr 2025 06:28:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 06:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744799285; x=1744885685; bh=2DHy5Fw5KB
	bcFliPIrs+CGU2Sp3VgIxcR/o8RVdIO70=; b=PqjYcFKcxKmn2DFrwJ+QAIrerc
	mBAWhty/Eo4O65SCVcmhKhIl86zGZadeCzgY8J4EIfwTy+z+zRSJvOetBFWKwbYW
	I/Htm1WscC6LrGyetxBwNpyyTbGEiFjA86w23TlF3eNkdGlhwOu4jlpgLQDyqqTr
	9HAnOXJvkPS8wbNX64q+54IT22SyJYcHJ91CuKHa+Sv5xnAv7D8NLrUpbpQTN8kK
	pZqwmytf1HzetTMDE3W81tJaC/vliwCQlv05PlVZgF421aM6YEqr8wmRmdAXOXco
	z/BjHt2kynSB/T8/ZEAITDKoVlBpqK3DRHEjgMffkAeCgZUDQuKI02hFRyuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744799285; x=1744885685; bh=2DHy5Fw5KBbcFliPIrs+CGU2Sp3VgIxcR/o
	8RVdIO70=; b=K4eOXn7R2oQroUsb5fZX8iwFbtMi6o/esulxEZU6eRxvxSFRwQX
	SE9N48H0EJSxtIR3aHGoZgRJti0O/6OvMMWsZIxqEFwLxgXxYasug6VUUylVz/oK
	mf1WzlXUrGYvRQ/36a7cKTroJgK+xHCU/oIQrtvGkt/oDa4ULYbi0mlW/dP+aFdO
	Z3YhTHghL3aawEqTG3I01NybFb8NYKdtCGzv1BvKCYOgoJaIvGsIuIf5hQZutJ8F
	giaET6ALJZ2Filos11KA61QQoyzYyAm1hp9Wlwg5giwCb9esrFpR8zBE0ASuZQ7Q
	rvNQHIBRIEIPpF2rnwUDjEwutKyV/WnTBhQ==
X-ME-Sender: <xms:NYb_ZxsY1OQRYJQb2XqoikvuiUlCZADnrIVHPX9gtqKxLXr3y8jwxg>
    <xme:NYb_Z6eh0OYD6A2f4VpWEDhaKP9CgRZq5M0nlnUrQ4PEaSC-3mZpmabaTbDaHr1q5
    IPegAAkxWLjFdmJ-A>
X-ME-Received: <xmr:NYb_Z0w2ZYeSvlCKMuWFlJlNqp9cvaclk5X-ktcGHSyCZUwROhJaMezXgunRIb3lwn0NZs57YM9pYKpWE7Ugsnm2ejdhw0J-35X99fZYNfS63A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdr
    uggvpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepthhmiiesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NYb_Z4PS088HsSKVPEFOhNSyctfR1fLWMTB3r6dM2W2j6-mcwHOaxg>
    <xmx:NYb_Zx8YWrPKyJiaCTOP6cL3G1t0_MC8ZtKjmtoZiQTM8vwmGL4TIw>
    <xmx:NYb_Z4W7gu5e2YxuNo13azJhtfYQiQXYumG5sqQ3OV2x6i2PGRqSOg>
    <xmx:NYb_ZyfnXKkuaH_6HDkll5sVLc0A6MgK--EpzXD4E36jrWtMuf8cBQ>
    <xmx:NYb_ZzTZwMyVemoOeED3QbA_oXHG500REdP8LAVFOU3aCmN-lPWNywKK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:28:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 70287f24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:28:02 +0000 (UTC)
Date: Wed, 16 Apr 2025 12:28:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/5] parse-options: introduce precision handling for
 `OPTION_INTEGER`
Message-ID: <Z_-GMXZmlfQmSuy6@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-2-ce07441a1f01@pks.im>
 <xmqqecxtmkdb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecxtmkdb.fsf@gitster.g>

On Tue, Apr 15, 2025 at 09:59:12AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/parse-options.h b/parse-options.h
> > index 997ffbee805..8d5f9c95f9c 100644
> > --- a/parse-options.h
> > +++ b/parse-options.h
> > @@ -92,6 +92,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
> >   * `value`::
> >   *   stores pointers to the values to be filled.
> >   *
> > + * `precision`::
> > + *   precision of the integer pointed to by `value`. Should typically be its
> > + *   `sizeof()`.
> 
> The fact of the integer allowing to store up to 16-bit vs 32-bit, is
> that "precision"?  "My --size option runs up to 200,000, what value
> should I set it to?" is a natural question the readers of this
> sentence would have in their mind, if we call it "range" or
> something (which might not be a bad thing to have, but that is
> totally outside the theme of this topic).
> 
> In any case, include a phrase "number of bytes" somewhere in the
> description to make it clear what unit we are counting.

Makes sense, will dot.

> Are their common use case where this number is *not* its sizeof()
> already in the codebase?

Yeah, this is something that I thought about quite a lot. I think the
"precision" and "range" are somewhat orthogonal to one another:

  - The range specifies which values are accepted.

  - The precision specifies the underlying width of the type.

Right now I only handle the latter, but the next step here would be to
also start handling the former. But even if we also started to handle
the range there is merit in tracking both, as there will be usecases
where the range would fit into a smaller underlying type, but due to
other reasons one still wants to use the bigger underlying type.

The next step would thus be to introduce such an optional range so that
options can restrict it independent of the precision. "parse-options.c"
would in that case learn to have a run-time assert that the specified
range fits into the given precision (and signedness). And obviously, it
would of course also learn to return an error if the value passed by the
user exceeds the range.

Patrick
