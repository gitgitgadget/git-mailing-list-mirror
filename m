Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D31A4F38
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926761; cv=none; b=Us/Z2WQszF33jWmmj6qKLki+RnEz74dj1N7mzHlmmet4uOHHkSVx7WVyY3D/z06v6ZXhC69PES2hrGg+FDw3speB58j5QT3ZJQXxBqlctwUD2nCK+L8KFvzziSx5qv1Ic07Tcoa+INe5qN2sBPQxdjYeiyHcBgQz5XlsKDNGw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926761; c=relaxed/simple;
	bh=YiOEwZ4aAQ99KOLBbzNxzqlZc/tp9CFlM937yt7jwAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED/Ygpe9V9Bk2kpl4Xxa6FvWCU1m+E+ht4eBflkDlNhpk+ntfamqiUD0qJhGtVM14+DT8DgLjbddBuEJ4KN2uyK3/gVcJgzA3n23gb+FIwm9i+lRMuaaswxIiP6KJ8esdGOH185AoQOMK4gcGV8kVVTh2Y4q6ZvW1uVSxMJfyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AkNbxJJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzAubj+B; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AkNbxJJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzAubj+B"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 75BF81151BC6;
	Thu, 29 Aug 2024 06:19:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 29 Aug 2024 06:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724926757; x=1725013157; bh=MP/pMrKmgW
	X0MT4QwTPR6u2ltxIwcnglpLcME+k4ErE=; b=AkNbxJJFXDu2ACHC9C9+koeDQB
	QN21nyYdLLAr2dHLd/LdA53J7Br8hcrOWWvVSbq1L+m+iKa7Vr7WJoA4hFEV/h62
	WaTnRLr8nVkcI8rD9xB/CYde55WeGJCX9e6a9pVs5hG+uAsOeD4aVDH7sGh6dcw6
	U+68apEfoY2fxllWbjWVn6YVvMsAtUeqIe9Sfs5mZhSBCqz3JYKajj1XAsM4Wiya
	DBlC2JsyzIDa0I6+7rRiXOjP/T51hcD5A0ugfD+STw+513g75v8eeN7iNVswNUip
	rWXirWzFAggaa4vOtn5krlcu8x3zEAHworUzc31c0pgACMUVCx7mvFGrCC+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724926757; x=1725013157; bh=MP/pMrKmgWX0MT4QwTPR6u2ltxIw
	cnglpLcME+k4ErE=; b=EzAubj+BExkd4R6b8kMPB42yQKQ9gG4ewF+SxPRH2Fi5
	ziDnoaka6vrrXVcBqTKiLgizHaiWQJnnP/DL4O89Fo1CBOeh7VdZhb2I+1aaw/pZ
	SqqvdIwhJFqoRb+UxkWkhubcrC+IGktpK+v0suXHHhK8jkMHWrHfjOMK+IHW3VeC
	3G6mVL3MJCGS+4CECRTNjgF5PXMO2Eh/oLTqErDKWL0IwLl1ooAh0AXWxcEsHf83
	65WU8vM8dVB267uda6sTYMXDrwrx+dLaRh+O9Fpxq5kRaamzhxJYA97Nfl7TKixN
	dzBETQ/2B5ZaFqWn28vBn1PZftU+nawunU/1FeQ3sg==
X-ME-Sender: <xms:JUvQZnopiy-FB6G95QFYxfBSkFZoy4yOjkjAnOFS8VJud1JtSylmRw>
    <xme:JUvQZhph8pU7UKq-wQf519z_mmm2ovJuKv_pBs0EgH1ZWc84hzrZ-2iRWU6ZYbAIs
    TgR_DwMDrw60RVQ8w>
X-ME-Received: <xmr:JUvQZkMMyaIiqqXcJNVWuSL6OrfDHLkP9z3vz4CCP9mpK1DU_qDKX1XH1HeLvY3i6jVyGKmsOx-kUNBmElNSs5XQn6pAv0TLWef0g4PurNDpxZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JUvQZq7WRZ0GOwuU3FnExujv8XGp4u5Edoilkx25YYDTrFFgtocKDQ>
    <xmx:JUvQZm6ASL56z9aUwIb6fYJmQWzixlsyM_FtUoS1kPHYC1irwbCwZQ>
    <xmx:JUvQZigfkHJAD6KPaEik5HwH4fm6oPF7ILqTMr7KSwzr4AuM-rVmwQ>
    <xmx:JUvQZo7F2B6j7blj3IxO8yo9R5ufcwspSVXa8eAaSkcz0p5ymjNw8Q>
    <xmx:JUvQZh04HLFgZpCVBdaFYtTaTI1aNgx1m63fsxyAiuxlAw5dDyPW9zG9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 06:19:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9203fb7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 10:19:06 +0000 (UTC)
Date: Thu, 29 Aug 2024 12:19:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
Message-ID: <ZtBLHD-sXeNutI0j@tanuki>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs353oLDaw2SbNQs@ArchLinux>
 <xmqqjzg1aksx.fsf@gitster.g>
 <Zs8c_vuqOSSWJjpd@tanuki>
 <xmqqv7zk1ucv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7zk1ucv.fsf@gitster.g>

On Wed, Aug 28, 2024 at 09:32:16AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Git 3.0 boundary might be a good time to tighten interoperability
> >> rules such that we won't accept anything we wouldn't have written
> >> ourselves (not limited to loose ref format, but this applies to
> >> anything on-disk or on-wire), but we'd need enough preparation if we
> >> want to be able to do so in the future.
> >
> > I quite like this idea.
> 
> I wouldn't say that I wrote it as a devil's advocate comment, but I
> was hoping that somebody quote Postel in response, as the above
> advocates a directly opposite position, which I wouldn't usually
> take.

For context, this is the quote you probably refer to: "be conservative
in what you do, be liberal in what you accept from others".

In any case, I still think it is sensible to at least warn about refs
like this. It is unexpected to me and may indicate real issues in the
understanding of others that end up writing to the refdb. If there are
implementations of Git out there that intentionally use our lax parsing
to e.g. stuff additional metadata into refs, then we need to tell them
that this is not okay.

This may have been fine in the past where there was only a single ref
backend, but now with multiple ref backends the picture has changed in
my opinion.

Patrick
