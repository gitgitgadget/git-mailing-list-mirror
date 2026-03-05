Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A51E5201
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717027; cv=none; b=IHpA7j8/rCGWjpJPimHJbsuHO6nzc423NDa0wdzWmncO0s+rXzRNAlT015J8Q1OoXa9QegnzzYDV2SGdYeYJVflC/xdqf6kAa82bls0RBb+zRgAORNNF86Ufu8M8aJxt+Hx+/yOnB5kq5aOb23iSjmoYMZvtWaqSW7bv81vspHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717027; c=relaxed/simple;
	bh=1bo036bMK82V3b9pE5WeqknSk75HyoYwIkWPwX9BDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikb3BwhJH3b1P82l6+1U94zTfkAv4R0RMq+TDSeBp6JBERCRoK2L+W3syyVRQGlAuEO3BqU1dRPZhzCk8lIGoclrAGNYN6KSRcPs8IdMxGgxJx0VigGGp6pdbjtxr+7LB2XPiQ5Vh6zsyM3RpjrmQm5L1dx4bQFrC1nRtOAvFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LC57+MYl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=haNCntnX; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LC57+MYl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="haNCntnX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFBBE7A0161;
	Thu,  5 Mar 2026 08:23:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Mar 2026 08:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717025; x=1772803425; bh=6BhOjjKonW
	inS58nBxRIgyCnqIbrBoSRjjcLuW9Jc+0=; b=LC57+MYlyV5ukdLQT5MY6iYt3k
	6xaMoF46rye+X9jzT+0XKcBM7T2rN3/FC/me+bKesLYmTBMBwqh45ZfqRQVxh9Sw
	pLNTC5mhPZEbskj6rL+EirCJssAow3oFHI+uCwr7bksXvDpWIkZvV0H0yQ3wV0hQ
	648VO4QRdj2nNtm4zW+DG1WMN2D+SSDE6L3M1RDXjwY+fBI1DgBcroXUYXBN4+ef
	uOmin/HbozBjt10tzga28nvxPUUCV3Wrfz0QaWbvChaUZJqBfjI3g2t/j7l1mOCN
	7tv6yx8OnsXuHFJeYjCkwrVKMpTEWOGLLDLzxpte7Ag1LxEknHipauYr8D1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717025; x=1772803425; bh=6BhOjjKonWinS58nBxRIgyCnqIbrBoSRjjc
	LuW9Jc+0=; b=haNCntnXeajc5pWn2koaJwoYC1i30cEou06M2tJZtWLSX/AqDCY
	PMZQQ5ulZfASkpHvGBbhoRybXYele1sJyF21/tOFzPX+RDoDTSBC4ISm4cV9iByR
	2Osb9pOHrm9GC9/oNmUsxaeU2VRCvncp7StkyMhB4BQEP76Rredj0YmMRaktKa1J
	s4MaHz3KBG0YL7v0MjF6hXUPx7/VcWbeODCJJjLgWZ+fsa3QA0DTFgZ+xy8Y/YMG
	oL3ksjjhYpSZ5VKz3CQfmRm0QNkA9LDCkevd2fLtBoYtGCVyxc8twnU6xGzTOdvk
	2G0JH18zLtNFdd+nCSZfGeNd4ntvTdPTyDw==
X-ME-Sender: <xms:4YOpaY0pohYYfNWJQLZK1I0auXqz7-m1VpGN-rHPUrBi1WjRG0iNTA>
    <xme:4YOpaZH-78DyBgkpSWdlWWyKpCNTAJHe4GLGLaFEHbg2XivSKA3gzy7D0qewp1B8X
    h-IH4IFRjpReISDijcm7b4XZnIG910wsPOeeaHGD-9AGRa31loe>
X-ME-Received: <xmr:4YOpaeif2mSypzcBKaSanwyGRG-5Py-B_T1w5ACaHpyX5HiHSQT38f-UpQtnX4eLNxajWgOF2eFCSOI6H4pPP5sj4rie1ndwWpGWQ-qSoiLT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4YOpac_Oeh5AZKS3R1Y3IOYUPhQTlzwqoRBC5jPaKPehIrvfwyaP3Q>
    <xmx:4YOpadqFsmKSGe4VHRjRXAkreQ7PKbc5YWnlJKRRCg8FAMicCtSskg>
    <xmx:4YOpaT_F1HgME_FnYbiLDo2wXgdBzfWgxWLldgBZlxIC6jnKdxuhxA>
    <xmx:4YOpaZVId-_Q4rLG4dKeV77R8rOMdswID0Z_YhQOpBPwlA77fCHJzg>
    <xmx:4YOpaVk1DB2F94U9MpSlerg9veiBWBMUGm4BFpE6BWmy19JT6WjAQEOh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b681912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:43 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/17] odb/source: make `close()` function pluggable
Message-ID: <aamD3Xm1_E5zMdj1@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
 <aaidbdpkpH7tfn9x@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaidbdpkpH7tfn9x@denethor>

On Wed, Mar 04, 2026 at 03:03:26PM -0600, Justin Tobler wrote:
> On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > Introduce a new callback function in `struct odb_source` to make the
> > function pluggable.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> [snip]
> > +/*
> > + * Close the object database source without releasing he underlying data. The
> > + * source can still be used going forward, but it first needs to be reopened.
> > + * This can be useful to reduce resource usage.
> > + */
> > +static inline void odb_source_close(struct odb_source *source)
> > +{
> > +	source->close(source);
> > +}
> 
> Just to be safe, should we BUG()/ASSERT() in case the provide source is
> NULL? Or do we expect the calling pattern to always provide an actual
> source?

We don't do that for any of the other wrappers either, so I'm not quite
sure why closing would be special. If this was the free function I might
agree, but otherwise I don't quite see the value.

Patrick
