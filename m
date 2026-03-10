Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100E38AC8A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145199; cv=none; b=GXyQY6Fu7+7/A+Eh9htcqn9UUNT47xjWgo+23s1UK0RNwQR+tt+Xokv/eF7j7k5fZRbAyY18ohYyXvOcuUc5W0dkjtcehUE2vUOygUdduy9+lNnKI3OylRqxrnCYqd6g5o63D4cPwycop0VIKFOOC9L7VJrPt/qSRTH1cKf3tGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145199; c=relaxed/simple;
	bh=x60n8xYHQ0/TJCct/kgaCLHUdOdShRduqyOhshTGLuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtF2T9n0U5hnqCskkmibGvbMPmxMpO5g/k4NU1THg/NttLvLNWMN9cJojhPFIYEFRMytf2BvOk0QZISQdTuoA1QVuh/2yY5T8mr/OY19RGbWkIByT4bgnO8YvOYh+7I7Eah8T/JbrJHymM4iUPEwQxT6ch8K23FLrkh9eyCExcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dCCXLxrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rhQAXtf+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dCCXLxrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rhQAXtf+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BC4E8EC0B53;
	Tue, 10 Mar 2026 08:19:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 08:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773145197; x=1773231597; bh=pRjr2tq7mr
	XaoQW1XK/+uJBKm08l43VLY37jsXaTyPM=; b=dCCXLxrAWimWmJ/jHLYgPvaOmU
	aX/h+HnJ8CdxRLqfN/RvOIe5PF5kQuz6h2o0z/kpjp+EAQjmWvtSsDD9PvrGlVpL
	W59bmO04p6m7fc/CuE11I/TXKnMoKotvqnxH8GutA1iuF0vbL3tZp1qws0yaJRoh
	/f9DnzdLJHlgUttdEZsTIYrROANfY1Buf7xIQtrmUaYOz7UpLlmLwjKhWEg/f2Sf
	HaWUJgDJMPWLUPY9ZaPLnhmvdVzzE+lz1Z17CGd/q6xa6Xcz2trr/WXErfBU8kCt
	LFW3u7jLoTWS6w0g4oHjMeDZ82h1jgnrilOWaoiRYv3JFX6Z0Kva1u/x3r0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773145197; x=1773231597; bh=pRjr2tq7mrXaoQW1XK/+uJBKm08l43VLY37
	jsXaTyPM=; b=rhQAXtf+MI9N6xrbJimNjc/H3chGtej2dYl8mEgl3yUqSX3mMoc
	tcOCCoVJMaAZW93mhI78flDhiO3F4uk276NE7jeJC7XYCVftEsmWXmR1V1/0Ffbj
	xOQNr+pJ5hLKozNufVTP/TCYRuW97qygIrpbz2zM/T514ha97H532RpHYSv+HIUr
	R+vT0E3PDTq/8LYeGLhQ3KZSpRBDjTtS1iftVtDDZBqshLwjj1LPvU7x8UPAMz93
	UOVLuDG5Y5vW7dVrLq+5RTYKqSzW+1rH3aDW2jNDDXpeWkjA+a54jTHCTs5i2SHp
	KZnMWDtzJZwU8Nu3Cly5hKAH+CTQkgYHRSw==
X-ME-Sender: <xms:bQywaR7PoTnU4tNLxNlgZ6hdAQxXP9ub8d564-GbgVmW-In6uAbRHg>
    <xme:bQywaV7k0EDeck7iWiVVdcWOrE-CwmzkVafTSQxvr23H5UdgrCsuRJ6IT_VM1P1bm
    t_1n3ZYkT7uicHWOWq9IkZsok_o-z3W0paJbQNn7S8MtKoPHV2i3A>
X-ME-Received: <xmr:bQywade9r76NbA8RrXOBWBoXcsTnU-OrgJr_dBV8j1yelNpTb7tdgf9-3mAJaw9lHpctm8x88MJHlCFcW14uBmYbOx7a-uOIJCej-l66>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bQywaZAMt2KMh_HuCkbXPDfaMkq4lAtWJMGUDYYlIY-0qOSJTOEzfg>
    <xmx:bQywaQ_vOp9X4JqcOW3gXq3LtOx7UMiPqR7EMBlyYu0f7e6OQTI5QQ>
    <xmx:bQywaUKRSXGtdMM8O2WUkAibS9zo0Vagt6J0tIEMUE7ohlsl8LVPpQ>
    <xmx:bQywaZg4lwFJfuXd2Ypjj3t2XBS2vNCaHvpfQOJttA6f0slnrhW4QQ>
    <xmx:bQywac_2ArnETlmc54jRNmdAiMr6MiTxpEsfOQh_c5Ph4L2hW3y0XyVJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:19:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4c2c6ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:19:55 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:19:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/17] odb: make object database sources pluggable
Message-ID: <abAMaCfGiAIiylvV@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
 <xmqq4imu2el0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4imu2el0.fsf@gitster.g>

On Thu, Mar 05, 2026 at 12:42:19PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > To set expectations: this is only a start, there is still functionality
> > missing that needs to be made pluggable. Most importantly:
> >
> >   - Counting of objects.
> >
> >   - Abbreviating object IDs and finding ambiguous objects.
> >
> >   - Consistency checks.
> >
> >   - Optimizing the object database.
> >
> >   - Generating packfiles.
> >
> > These will all happen in later patch series. That being said, with this
> > patch series one already gets a lot of the basic functionality, and it's
> > almost possible to do local workflows. Only "almost" though because we
> > rely on abbreviating object IDs in a lot of places, but once that part
> > is implemented in a subsequent patch series you can indeed work locally
> > with an alternate backend.
> 
> I've been looking over this series, and the transition to a pluggable
> interface for ODB sources is very clean and follows the patterns we've
> established for refs and streams quite well.
> 
> One thing I am puzzled on the design, specifically starting with
> patch 09 and onward, is the lack of documentation regarding which of
> the new callbacks in `struct odb_source` are mandatory and which are
> optional.

That's mostly explained by the fact that all of them are mandatory for
now. :)

> In `odb/source.h`, the static inline wrapper functions dereference the
> backend's function pointers directly. For example:
> 
> +static inline int odb_source_read_object_info(struct odb_source *source,
> +					      const struct object_id *oid,
> +					      struct object_info *oi,
> +					      enum object_info_flags flags)
> +{
> +	return source->read_object_info(source, oid, oi, flags);
> +}
> 
> If a future backend (say, a read-only network proxy) doesn't implement
> some of the write-related functions or the iteration functions, the
> current wrappers will cause a segmentation fault.
> 
> Do we want to
> 
>   - Document in `struct odb_source` which callbacks must be implemented
>     by every backend.
> 
>   - Have the wrapper functions check for NULL. If a mandatory function
>     is missing, a `BUG()` would be appropriate. If it's truly optional,
>     the wrapper could return a suitable error code (like -1 or
>     `GIT_ENOTSUP`).
> 
> Given that the "files" backend implements the full set, it's easy to
> miss, but as we add more specialized backends, a clearly defined
> interface contract may become important.
> 
> What are your thoughts on which of these should be considered the
> "minimal viable" set for an ODB source?

I guess this'll become more interesting once we have additional ODB
sources -- and that'll likely happen sooner rather than later. I've got
a couple of patch series pending that'll convert our existing sources
that we've already got into "proper" sources. And with those it may make
sense to document this better.

I see that this series already got merged to "next", but I'll keep it in
mind going forward that we'll want to eventually do this.

Thanks!

Patrick
