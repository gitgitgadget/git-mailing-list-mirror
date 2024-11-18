Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7B823D1
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914564; cv=none; b=U5xY09JSWv8Mx0+aJ1ax98ZO44ASPJ4O+W4jbNi1tgHHeOJFEFCd8te5t63PKXrtwxYkFQrpbO+qeIcV5mminS75Smhyeb5iHhbtfV6XYDhPs24izFkffbzabImJIzQQiuc0AfQ1zXtG/Use42Y5DJmIXccTmmHLaFDum8MhDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914564; c=relaxed/simple;
	bh=/ZOzDoWlI6nPeNpW+kXLM0nq54lSUGVdEbn0ZeFnFSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN+Gnty6bQl/mH3gWvPN+Dag2uKYciAUU6UpcrAHmMC3IMg8Gt8Z8HOIT7kSHLSZmT/wJn0FDbsuFKFmCng6M1iPisFELQBzVJgoh/64VEAZv0RWo+ZO/XmjHXsLcViPpVNpLFvsHdCJ4RUPMZpuoUi0RuS2jmCCFO/1wFje5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uE+tqmtg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTbrJ/5F; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uE+tqmtg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTbrJ/5F"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3083325400E5;
	Mon, 18 Nov 2024 02:22:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 18 Nov 2024 02:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731914561; x=1732000961; bh=0VxwqcWMnT
	/VGu9zHmk9BhvaZWK9kIncyj7vn/SEyfk=; b=uE+tqmtgZMiRT2yPMtvYrk49nB
	NGFXzEuqHwE/K5+EuOMnyOf0b++73UnM/US/JxcAptE1ZMysmsKlweLAe1VKuqzz
	bI2OLlWWbZrlaJGFaHcGnmqO060zRgOiqJltjduQE+yELHAZSkNZtOLX9Aq5jFh0
	lY3hwRBjzoNjWb4Nad5p3jB0juJwmLfTXa2icq3CaAzLi1+M4mF2TLAmOCiVOaxc
	nagZ5YFVxPSfd2QkO9ROhn6leB/qFCf5roRiGqgHgPrIq3zXEhiG4nUoZIVj+P0o
	rCxXXq0FBUMverLOdHV1OHPsUPJNvCW0IwuG28Lhua3658OfE0QVb7SzFyHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731914561; x=1732000961; bh=0VxwqcWMnT/VGu9zHmk9BhvaZWK9kIncyj7
	vn/SEyfk=; b=KTbrJ/5F0XfmXH8uyuVhUZWVpvsNmRl4HIfRtEUyneUKUQ2xkQ3
	OmGNEVzPCGkw8eeY+0eRAr8mvUycrMDQdPMe9MnHY71IrUh3rnSoppp/x80uqbjK
	HXGL8k2zj/vkqlrfZRppr9vs66DQ2Z9W00Z4qbudxrNyOqpYaXftxOuIni7lxsM9
	cKNuTy0txHF6vm9yUKt9Tlt90C7e0QuETm9DME/sBK+l5qhPXWxnnLMv32eQdmrB
	eFLQ6NoeQBqvlkwVtGZw1IJhKHkPbd/w+IFH72pyshRpPN3uEwGZK5EQv7gj308n
	NuAq40RIFv6Vfvzf3dNndnaGdYMzssahRGQ==
X-ME-Sender: <xms:P-s6Z1-8Yf-oyOpkE16OlX0S9SbmvMj7OyK4ZOOn1qvO96NV8OoT8A>
    <xme:P-s6Z5uqZN2yAyE5ruRCbjfoMx6Yt_Uq69c8qNUfDMWKA6nlRpjL-CC_cbicsvNFW
    pEIC4Mch_gEYSKoHQ>
X-ME-Received: <xmr:P-s6ZzA-aF0dQW229z5actG4eqwxlaif4GTFdFz7CJRRKsQVys-CGU2BntcT7tNOP3rRDoG7AWWPuUTm9lW9xbjJKcvEX20aFzO0GGh9Ri5qJlwB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghp
    thhtohepfhgvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvgdrhhhupdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:QOs6Z5cGZaYqBzg2CeBkLC6yf88yCKp11YIBBcQZEtdxELjNY156tw>
    <xmx:QOs6Z6M8Z94dgEYmOY0jmnFbpNYzYTHUU2wV6P1RhVfEQLlBu9NmOw>
    <xmx:QOs6Z7nfmTOKG-pSdeDe8xD0F-MdPUg0zaqkNQ1ydxnDuLzmAsU0ng>
    <xmx:QOs6Z0sJrlYUVsvmYT8_fzkmAs-wDZ7yBMOKoE-PCdK_jDoo2y4w-A>
    <xmx:Qes6Zxr7NMOfYnoIYQ-DE5XDX711QZCIdpTwF2c-466VNIkEWhJd2REa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 02:22:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ed669c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 07:21:49 +0000 (UTC)
Date: Mon, 18 Nov 2024 08:22:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <ferdinandy.bence@ttk.elte.hu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Message-ID: <ZzrrMrhRxOuB6QKH@pks.im>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com>
 <xmqqr07d11wt.fsf@gitster.g>
 <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu>

On Mon, Nov 18, 2024 at 12:39:43AM +0100, Bence Ferdinandy wrote:
> >
> >>  	} +	if (referent) +		refs_read_symbolic_ref(refs, ref,
> >>  	referent);
> 
> 
> So I've been working on detecting a detached remote/HEAD, and it seems that
> "refs_read_symbolic_ref" behaves differently for the files and the reftables
> backend. These are the exit codes in the various states:
> 
> 
> 	     reftables files
> detached	-1	 1	
> doesn't exist   -1	-1
> 
> I would assume this is a bug in reftables? At least the behaviour of files is
> more useful for this case ...
> 
> This now works fine with the files backend:
> 
> 	if (referent && refs_read_symbolic_ref(refs, ref, referent) == 1) {
> 		struct object_id oid;
> 		refs_read_ref(refs, ref, &oid);
> 		strbuf_addstr(referent, oid_to_hex(&oid));
> 		ret = -1;
> 	}
> 
> And 4/8 can now also detect being detached, by checking the return value using
> the test you suggested, but this fails for reftables. Just in case it might be
> something about the test not being correct:

So from what I understand you try to execute `refs_read_symbolic_ref()`
on a non-symbolic-ref, and your expectation is:

  - It returns -1 when reading the ref has failed.

  - It returns 0 when reading the ref was successful and it was a
    symref.

  - It retuns 1 when reading the ref was successful, but it was a
    regular ref.

This behaviour isn't documented anywhere, so I wouldn't declare it a bug
in the reftable backend. But what is a bug is that the two backends
behave differently, and that should be fixed indeed.

I couldn't find any callsites of `refs_read_symbolic_ref()` where we
rely on the current behaviour of either of the backends. We do have a
check whether `refs_read_symbolic_ref()` returns negative in "refs.c" in
`migrate_one_ref()`, but that one should be mostly fine given that we
check for the type of the ref beforehand. "Mostly" though because it can
happen that we race with another writer that happened to convert the ref
we are about to migrate from a symbolic ref into a normal ref. Unlikely,
but it can happen in theory.

I think it's an easy mistake to make to check for a negative return
code. So maybe we should adapt both backends to return -1 for generic
failures and -2 in case the ref is a regular ref?

Patrick
