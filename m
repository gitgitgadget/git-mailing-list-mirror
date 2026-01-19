Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F226E71F
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804449; cv=none; b=t5raJJ+jz04InhnwhPZ5lSjWRnd0Ao7q4wmi4rul4AOz1z3tbMore33dQaBJUEYLQjs8m1iv+deMdcmys4VXiUr3KAMwKpuVKEvj6/+OIgHgBDSmSb+SD4oEU4WfkSlcqZuJqdiwsQ7v6QkUuJopGKYCwBU0INDlq1CKduFPODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804449; c=relaxed/simple;
	bh=gKkLaNtjcAVBxCr3Jw2TLjbuSyc0E7cERFWkQz9AkaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyENXRvFnt12nrr8YVJ7fMj/8Old4+hMPEsNE4+GsI8e0G0j7aHrlowo2/i0eXwBGBZt6TgcME+jrqnjtkiyQdT+5kEQpRXxJCVFU7wtQB3w2uzYxsMr9GhoX22zZlOdp2yoHG4loqxO9Tz7POvZJNDsbUlH5CxA9gNgqsfbcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HPYP+4FS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClupmTjf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPYP+4FS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClupmTjf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D101CEC08FD;
	Mon, 19 Jan 2026 01:34:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 01:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768804446; x=1768890846; bh=/riROWihx0
	wfXgMMm7owGpTaMULuilMmqJfBjx2a3hs=; b=HPYP+4FSWHRjNLcl+y4bxZMOUK
	6BKSXFxVJxV4sR2dqxRDCgOTtc2Set/oucwGnBkHedNpyP2nisr0OVNHeb7QTKTs
	TtLBTmxmLrHMms7uZUTq5iJGeBkiOUnuL/VjZT44NtaBy/vxo/TmRNy5w1w1n+X8
	Fs/vzqzTrVNnNOg2qm20Q8QYrw05E3OG2lFxsCaOQ52Cih+qqJC5oVuF6Kmspe7R
	OebZMrzmC7+s/n+az0xa07K7CJISLfLkPSg1aRmDShHDVNVKRt52J3xK8zAEM2mJ
	69iGy0DeWK7FrjCSZ5LiYU8178lDFY8n3/6hlhSgE/laUNy1VB0gxmdCNUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768804446; x=1768890846; bh=/riROWihx0wfXgMMm7owGpTaMULuilMmqJf
	Bjx2a3hs=; b=ClupmTjfnHQ4/rs0RdTxxxgtJHaobZLQQNbKb6/cGfPc6Xb3cHA
	Rx47cKBEm7svt07Q4+TA/tN1aX7rjTFZRtPx5obiCRI4FjzCB+74GaJm+oTnldZn
	MAjmCz3tASDuyUmh87qy/hfpGmnta44JQWPlb5/ouzFaPas98doN/bplQ/p7Yrb1
	xaNW1fg8fk9x3HKFW4Z5IrVk+xUyA3VfDxJPEuLzKYfwhSyEdoiiJjFBULXbXFQ3
	r1n0PQsGF5vDSuX7f9/5BJTTFcCCQ+QLN3euYhRtOgEBZ50BvdAHa4RsnK11ky9X
	f+VD+SVJ2rrx6oCVfo84wFogijZnSRreuuA==
X-ME-Sender: <xms:XtBtaYl0EADPVtMZQGk4uCo7S8N1HWHfQWH1-Zn0CzPTD04V1L-MgQ>
    <xme:XtBtafSr0r270fNrprtpMEbfrwBTOp42qi6nBigUeD-Jhp0u5QmGR8L9OnJ8RK32a
    b7RCZbFYfpO8kQt21QVkz7H31QE9Q0TIBqg9kAmjCQW_HMllAmpxE8>
X-ME-Received: <xmr:XtBtaUB3nmo_TmGJKet579S0ivYu6ROzr7bai0PUbRNBxgDxUbbuLDJ65RO9a38J9TRLtJcTCi9yrAauibZui8KzW7eX4y96HrEoNREZUT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:XtBtaeTJZhxxkjg0ypKMFxodmGbFXydR3dyWUsYr5EF1RA4G0CQlKA>
    <xmx:XtBtaapJuLH0bORkr7X-HZZgAbVd4hGJbLK1s-bSCD7rFwvtXPEYKQ>
    <xmx:XtBtaYya75xAXGfOY99_pqQC08mwtZbIWad3Nn0q0pwfFziFTZReOw>
    <xmx:XtBtaXKfwWUQWDSZCvoKmhHlPMhFeKQna2P4d85dkAK8BclHG6RNLg>
    <xmx:XtBtac9Gg6EdCqkUvbfQBy04fRzbkZwGwusnGr88zZJPjWJ8gZbQTv7R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:34:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 943c6165 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 06:34:05 +0000 (UTC)
Date: Mon, 19 Jan 2026 07:34:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/4] remote: drop const return of tracking_for_push_dest()
Message-ID: <aW3QWxCNPy9paq9r@pks.im>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
 <20260119052026.GB1991523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119052026.GB1991523@coredump.intra.peff.net>

On Mon, Jan 19, 2026 at 12:20:26AM -0500, Jeff King wrote:
> The string returned from tracking_for_push_dest() comes from
> apply_refspec(), and thus is always an allocated string (or NULL). We
> should return a non-const pointer so that the caller knows that
> ownership of the string is being transferred.
> 
> This goes back to the function's origin in e291c75a95 (remote.c: add
> branch_get_push, 2015-05-21). It never really mattered because our
> return is just forwarded through branch_get_push_1(), which returns a
> const string as part of an intentionally hacky memory management scheme
> (see that commit for details).

Okay, so here we can now also return a `char *` now that `error_buf()`
got adapted.

> As the first step of untangling that hackery, let's drop the extra const
> from this helper function (and from the variables that store its
> result). There should be no functional change (yet).

Yup. The memory handling still feels weird, but as in the preceding
commit that's not a fault of this patch series.

Patrick
