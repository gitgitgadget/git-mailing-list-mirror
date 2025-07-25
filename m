Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E872040B6
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430470; cv=none; b=q6eJOUkdOe43Bw6toS/8rs/BzNllMPGBrHW5mH7kHcJspz0Gccq6FUgrmhMG3NDHJpekNdSB/mRfG+qjAF8CpQHbxAGXvoc0nDaKqqvg/nbAHcEyZEu6bQvrd+iioT2EezmsNBGvAcgBe3f0r3cT+w1Na//zEGVKwcqB6UZjmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430470; c=relaxed/simple;
	bh=GU+0PkgqufPkYQYhNyEUfh9lkf3A4T6bPIQjmdHkl0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2ObVKhJ9OsxPkC98/h4CCUFWkad1w83P2T3ABr4LbN3iZvd+xamttXzYfLKF/lfZoPPJckXdHCR1Eb9DwrbmzmK6SDyTOlIGyBSRJvk0RflPOu6sI4REVgG+Fb7s0rLZ3hCernfK46mssPIra2sFaN66FRd5++lkTzWA30tudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uYcQ604R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j64uc/y9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uYcQ604R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j64uc/y9"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B8872EC0594;
	Fri, 25 Jul 2025 04:01:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 25 Jul 2025 04:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753430466; x=1753516866; bh=69s4NANXvw
	4Dyru1wvoXSzua8I9dOw00JbXloU1nHS0=; b=uYcQ604RmWYnJKaeQ9X+9uWur7
	MXNH3bo8tuXu2QbkhImRdmsrPEDL18DNmU06tMdBURF5Vx633ScVDuIxhhSwInbi
	HXhN6JxtlcGsJnwwcMnsPDk2D0jbtoZF4z214GVY2Gz6t57S5j8UcPdZ6NIn17ta
	l7SA2jTiDjdoKVQFcziooAF6saFn0szTlTzqfwM4jnB1K/CijGbW8ocHCgmuADNM
	RWcUJ2ZQk8gmWxcQKx2o734RWsnsuXPizqQAxQ7EbK7q3e9FqFc1avvaU+dvxZNz
	Nj3hmV5I9vOjsvWF0hPYCJMEoypye/BjASaWAaIvfKt6qebw+H8U9+b4jVtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753430466; x=1753516866; bh=69s4NANXvw4Dyru1wvoXSzua8I9dOw00JbX
	loU1nHS0=; b=j64uc/y9UGs1X48eJlUlJAKZxOejs0QU6FRaBJJWcl02AMcFM8W
	GnKr31ejYbFGBvVBdpRucJLFZFSKFhFtkW7ISLa/JUpwlXPozu4mGQLMzuSvt71d
	CIUmXzXKl9CNOfwZyp4E1hCpgxR6y4YyTWsE/amzX7XJlJiOoYF3WyEGQm9xTc9r
	gMfkGkP8GUdQLgaUp855XJx5T6O6CVfZp7X9gn8cLe02fpT98eKea2hBxnXdFnOc
	7daTvLyw5yi2RlHK143YbDeQPQ8QZ8NNI04P7Bw5r5FOWXfye5ZjkrjdowH+NEtz
	B4ys0QwjHRCu4p3schkJnkZPkj+Upe5g3mg==
X-ME-Sender: <xms:wjmDaCNgfkUViTSJ_QhD9Ue-LykLZHYai4sQFXBAKyyvAr2ewIgdjw>
    <xme:wjmDaLhuXIljY3TOmxWGJVaBcKnGYLKDec3IzTsZ1X19H0Xc32c6Hj8MzRYkJBTRu
    tp6OFSYwMChEjN2GA>
X-ME-Received: <xmr:wjmDaF2ClAI2P-oCewbsgspciHBPS1rDQMPevaECJsBHnutEsqyqyXP2WOj4WA-mk-zihYAuX1C2L4jbQ-Ifc0I-__Za2sGRwgf1EbMmjGKd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:wjmDaFhFWAe8ZXXLFM2-3vuDXK_zYs66d_OB0YbrmlWf6MC9q4rLOA>
    <xmx:wjmDaFfkmPqIaPeOMoMWRGWq_7k-kGBdL4Tgtph6GS8-Mbvv2_yWQg>
    <xmx:wjmDaIl2XoqQJDWpiXVl4bnQjrn70xuBWScUpeIoNJPE7qVheeBJYg>
    <xmx:wjmDaOt0MPim98AOsgIQ2opSgQ810kDJuMArBnFENDiw0Z5VmRGW4Q>
    <xmx:wjmDaN8wLrQw3T1bwY_H6xmOd9nxxHZRXV4_4LD8gQHrlww2yd_wmeTj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 04:01:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c46caa83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 08:01:03 +0000 (UTC)
Date: Fri, 25 Jul 2025 10:00:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <aIM5t3NMk9N0570v@pks.im>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
 <aIIf7S5iPspktxdw@pks.im>
 <aIIvHxR8wXLTCgMW@pks.im>
 <xmqqbjp9h1sk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjp9h1sk.fsf@gitster.g>

On Thu, Jul 24, 2025 at 11:38:35AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +	if (flags & REF_ISSYMREF) {
> > +		strbuf_addstr(&new_referent, referent);
> > +		strbuf_splice(&new_referent, strlen("refs/remotes/"), strlen(rename->old_name),
> > +			      rename->new_name, strlen(rename->new_name));
> > +		oid = NULL;
> > +	}
> > +
> > +	error = ref_transaction_delete(rename->transaction, refname,
> > +				       oid, referent, REF_NO_DEREF, NULL, rename->err);
> 
> Remove old ...
> 
> > +	if (error < 0)
> > +		goto out;
> > +
> > +	strbuf_reset(&new_refname);
> > +	strbuf_addstr(&new_refname, refname);
> > +	strbuf_splice(&new_refname, strlen("refs/remotes/"), strlen(rename->old_name),
> > +		      rename->new_name, strlen(rename->new_name));
> > +
> > +	error = ref_transaction_update(rename->transaction, new_refname.buf, oid,
> > +				       null_oid(the_hash_algo), (flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
> > +				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
> > +				       NULL, rename->err);
> 
> ... and create new.  Would we be hit with the same "while renaming A
> to A/B, there is a D/F conflict which the ref transaction does not
> handle by itself" issue we saw recently here?

Yes, we do indeed. I've now split this up into two transactions that get
populated concurrently.

Patrick
