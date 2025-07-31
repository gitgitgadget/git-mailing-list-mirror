Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279B25A2C7
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950526; cv=none; b=QGNPFIxYZ/BVkg0NAdf3a9aZemC/QUcxthemZzFbuJLFmsnFXKbLiG10J4t/Yl/r3B/K21d0jEX1YG7W5nP0Z8uZGKLU7CkZmENOuJljlFMUaFb1giAPlY9/s/9D4q61KYFtRNVuyAyigfUzICJU1u9gSFl+jDnD4Ko4RetsV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950526; c=relaxed/simple;
	bh=fD07nOUSRrSve/YBjksSR3/QEN1k5N3D09hLsRAmSuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm2/GcwhG/0slLtmwy4eVImHjLxA+oGyYvqO9P6fDOMiUFHjQHtUta9eW6xoJMszDcYbnlA8AhViyxr8ko42p5w2FpPR7klCz4nTCu4HAfxg72NLvucAq8olGUOjC847E1trk8oJCJBm1wa6DkrnNM0DO+k+zahYhKObqkujyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O6I9zGo+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPCxp7q/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O6I9zGo+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPCxp7q/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C0F71D00B78;
	Thu, 31 Jul 2025 04:28:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 04:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753950523; x=1754036923; bh=6l3LSTKuUC
	HqSYMARtwWrgYmqNhEfSnjG2TS1ZSbAAQ=; b=O6I9zGo+jxRb5BnZC5A0XdRzYY
	xKIvuVFHWTjr1CgOPs0DhCTtigV/5VX9ceO2lghos9r07FCOH3m4N7isoAju+242
	icZUQwPmbi+L1D5sNZP+smfiIA4BaQp96ieogyaSi+q7XfRdCiVn7Jntoj0viMsI
	PEMh5AdTNO7GQsm7GY3Be0R7yCcHIJRDYplTaWWlTzapzIB6cmFltGhJ0kfVO0Oi
	6hqAfbWHrMaCB85wZjher17znMz9TuF2/vE35Q1jwwpNlNhXXYcNAKL+td3q425R
	B+AXdQlWAiujWU6SW55hheiexEEA5LaQRvDgS5pEex1V0ILowArYsLz3kJ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753950523; x=1754036923; bh=6l3LSTKuUCHqSYMARtwWrgYmqNhEfSnjG2T
	S1ZSbAAQ=; b=TPCxp7q/epRRAOCef1Nj3gCU5U07F1JcMPWGG8i2QYlUxLb0Wog
	QWKBuFzrgRKqgAsGhOhZ3Cd4efT7InVqvI8KswBPKDNBPz48UP29AUOtbEOPzoH1
	eU9tt1/Er+BBpCH0uxINkhGgmvaGYGxOTPgzC59othQ+sRRR+DfYjpblxSrepOJp
	89LMariAvDBsu8fFCKTTPo8cF2Q6L9Tg5Q0OzhY5mP0epzQNKe7oq3ilZ5snkVHn
	6cMdU+tYc/1fUo2AxRnLTuiMqK5TMZahhQlpOpkdLYPUqId4o/XkeM5STz5wS/Ov
	/uKTtpqxd/LE5FhydoqsA3u99EaEiQ6d+RQ==
X-ME-Sender: <xms:OymLaKSArrdyZypz3hkuOnyO8A952cC3fEiuKzB4-_-QvTOVv6PHrQ>
    <xme:OymLaLSwIm9i3JE3iulK5TOAJRGSaIglwO5NDNXcPKrfIeAP0i4kSDXyJuhGuCF1H
    Ucot8IDbMA87U3iKg>
X-ME-Received: <xmr:OymLaOQeGADurg5rVsCf54V-GrCMFEbgU9BMtMqk5jFAxFyGVj5vrkSJSzTlDNbSH9Vi98JT7mvYHrV6Uze3Sq7n_p-sDKgOrjWqtysoIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hhtggrrhhltdekudegsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OymLaA68Sx3-c6RvkMr7cMlzSst5BlyVdG83HLPn1hVLOt6sUQu_hA>
    <xmx:OymLaK3_FwnzA9H8caAzY74DLAgiC1Lr27pWP1gdLWUWcPw3PZZ7aw>
    <xmx:OymLaLCSon43maDl-vOPtCZh7mv2YbhtagIfNCdKUZbBrYlN18A_vQ>
    <xmx:OymLaFPWs8yq0dH7EJ7J_yNZtjM896oSLCvsXqjW7SafbCy_UHlH_Q>
    <xmx:OymLaDvGd7JX_NaAfIA7mIOZSsfNozGW3Sbhd5uFltvYuZlnqWQ-MEQH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 04:28:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2911f879 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 08:28:42 +0000 (UTC)
Date: Thu, 31 Jul 2025 10:28:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 4/4] builtin/remote: only iterate through refs that are
 to be renamed
Message-ID: <aIspNyUCbf0_dQbh@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-4-f654f2b5c5ae@pks.im>
 <CAOLa=ZR=pQ58GSKh-M1fg5Ym5U6THmmvgTSNGUGCmdhhuVHFCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR=pQ58GSKh-M1fg5Ym5U6THmmvgTSNGUGCmdhhuVHFCg@mail.gmail.com>

On Wed, Jul 30, 2025 at 09:53:13AM +0200, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/refs.c b/refs.c
> > index b820c3908bd..861a0deb924 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1840,7 +1840,13 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
> >
> >  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
> >  {
> > -	return do_for_each_ref(refs, "", NULL, fn, 0,
> > +	return refs_for_each_rawref_in(refs, "", fn, cb_data);
> > +}
> > +
> > +int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
> > +			    each_ref_fn fn, void *cb_data)
> > +{
> > +	return do_for_each_ref(refs, prefix, NULL, fn, 0,
> >  			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> >  }
> >
> > diff --git a/refs.h b/refs.h
> > index a39f873b1fe..9decd3126e3 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -428,6 +428,8 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
> >
> >  /* can be used to learn about broken ref and symref */
> >  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
> > +int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
> > +			    each_ref_fn fn, void *cb_data);
> >
> >  /*
> >   * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
> >
> > --
> > 2.50.1.565.gc32cd1483b.dirty
> 
> Nit: we do expose the reference iterators now with
> 'kn/for-each-ref-skip' (merged to next). We could directly use the
> iterator instead of introducting a specific function like this.

I'll leave this as-is for now. The additional wrapper isn't all that
bad, and I'd rather want to avoid adding another dependency to this
patch series.

Patrick
