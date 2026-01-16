Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9D2DCC1F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547017; cv=none; b=nPhP7t41Aqo9dwAuJjS/q1/2tnuz0Hp9Qdrh6CjoUjf9mDe01WpBHlG+5dxRRtz7V0oh+wy2Xrs89vMWp1Msu59OhCptqFUTtc14REXtN5IN4X7z+7hpqnjLn69OdL8/UC8/A99yyLWks+Ol0EI1HLU2TEuljR3zuHv89eQo5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547017; c=relaxed/simple;
	bh=PTVfY+btyawoA58bSXIV24mVfOuVWzWecSPGV9eH0IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnqtizx07PB2ppGrXSj2ejB3XJiM8M9SGRX5FCjI7tjYcayyQ8NND9kSMggRjTUqVt2rYEHKVGCyG0sRm40KcdmTeyMaI2wUnsfRTW5o6Ez9/4rWaPXAccw/aOsCxFYUEdZVHl5C5wwAHCwXeC6GUK0WQiJ81yy77yGRY39ABa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WMs9MboF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T79LmM8O; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WMs9MboF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T79LmM8O"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C0A31D00167;
	Fri, 16 Jan 2026 02:03:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 02:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768547015; x=1768633415; bh=3rOiWClyBJ
	JliPOxu4GvLEuFKiUSQFBqOE+rvKVsSB0=; b=WMs9MboFk0BlRjJKAFUG9kBoMD
	sr0T5rIzGaq0pPsHpPKj6qJk+imoJDWT7hGQV/aE00LkJ9REfhZ3MpTn7CFiwjXy
	X12Go2m3lg48/LpTcVbjwLS8wC5nNu3IgbVNN/zFB3v4f0L3cuFhKDoumx3Yb7kh
	e9U+Jzwz5kRYPFfRfz6+fNVb1knIdm8Fs5XwCLl1aM/ssZLQoOOhgduLxokz1e2s
	C9X0DFNpxR50dKnkM7Ws0NntspNo0amJPfDMvCL6nvQpY2/hTz4bdnSvSiGQZA2u
	bQ7bV7nt/rI2iR4GOlP9qalm/ZC/mnAUiWPwOm0qKfCBZTD3vz6E17kAvBLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768547015; x=1768633415; bh=3rOiWClyBJJliPOxu4GvLEuFKiUSQFBqOE+
	rvKVsSB0=; b=T79LmM8OEp4tPPMIFUV+X5gyCBp6Iybel/HwJg23Zub0ZmqyzRc
	ACzVsbye4cHtzrVlFFz2DQQWGSKoG7B6WjWjcc1yMnc8Fx+8QmPXONSbeo+ndciZ
	aWIzvbDOPgMDYjsxd6IQQ2rMTxOicNS5tQUz57a2fzu09UT4W2SvK5rsQHZ4LS2J
	fU1nQMgtkjo1o6Kq1eVyrntQN9rfux+bZZ0mCZmllr2KOGfH3oGQIGTUiiFXt8c4
	xQDo/ilPO8R0zD/SqDXK2paK53p8X2x0u22pi9beiR1sENWHaYtjLLx7S2G30eUY
	xemkOkgQmCB7piy6+4tRV0cBjqCW0kPQ08A==
X-ME-Sender: <xms:x-JpaWgXdq1zc7MHYfexn7dKJtJU97behaA0dp1A6DmcXi0qT_0EAQ>
    <xme:x-JpadAGw5CHTTu9M72APudb3D7zyB5Yvw8qIj7vwszL6ZHHaW8AmuXppPJGWW9UN
    Dr_4OqxuxMEAqRPGOCAV-zwApHRFV0dr1KUE3W1Y5ig6ZldUzOu0w>
X-ME-Received: <xmr:x-Jpabu8MbdFF4FsKXnpCPaprAnDUiC2GBiEWiMG7PBLZ4kMKjhj5-wqnQ8W2HVEffmNsTkCGjnyivf8XFUHb8c87MRZS6R_s09CgtyCYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x-Jpaaam-_026BgMyADJMhtflblE4ZQXn4yl8nhevM0JQmdlTRAvFw>
    <xmx:x-JpaWWWrbpbYrZNUdqsnyJ-C1DvjPUTTUHoZNH_gNCLy8be_4Sn6A>
    <xmx:x-JpaW6yu0kQf1G91yD9JuYjM-N7TiUKulXEBrJMac-kRcEHIRkP5A>
    <xmx:x-JpaZh_NsR6JmkZYtsjOjNeCfETY6P4pIzNiQMiRWWO-sDZYe_kgg>
    <xmx:x-JpaeRIOpdRX9pxvbwP97VLeJkvdc5A2JvKWbSkdlsYBtUVA_mhajph>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 02:03:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4c498a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 07:03:34 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:03:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/14] object-file: introduce function to iterate through
 objects
Message-ID: <aWniwzCL5S6FD3N9@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-4-5418a91d5d99@pks.im>
 <aWlSYGIe5izqWwte@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWlSYGIe5izqWwte@denethor>

On Thu, Jan 15, 2026 at 02:54:23PM -0600, Justin Tobler wrote:
> On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > We have multiple divergent interfaces to iterate through objects of a
> > specific backend:
> > 
> >   - `for_each_loose_object()` yields all loose objects.
> > 
> >   - `for_each_packed_object()` (somewhat obviously) yields all packed
> >     objects.
> > 
> > These functions have different function signatures, which makes it hard
> > to create a common abstraction layer that covers both of these.
> 
> I assume that the intention is to eventually have a generic
> for_each_object() function that can iterate across objects regardless of
> the source. Is the end goal to have each source define the appropriate
> for_each_object callback?

Yup.

> > Introduce a new function `odb_source_loose_for_each_object()` to plug
> > this gap. This function doesn't take any data specific to loose objects,
> > but instead it accepts a `struct object_info` that will be populated the
> > exact same as if `odb_source_loose_read_object()` was called.
> > 
> > The benefit of this new interface is that we can continue to pass
> > backend-specific data, as `struct object_info` contains a union for
> > these exact use cases. This will allow us to unify how we iterate
> > through objects across both loose and packed objects in a subsequent
> > commit.
> 
> Naive question: in a future where we have additional ODB backends, does
> this mean that `struct object_info` would also need to be updated to
> include them?

Yes. We'd introduce a new `OI_*` type to signifiy the specific backend
via the `whence` fieldand will (optionally) have a new member in the
union of backend-specific data.

Patrick
