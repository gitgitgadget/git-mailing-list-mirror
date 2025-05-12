Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B11F9CB
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039020; cv=none; b=F6L7Qh2tj4FSKJytr7o058Jl2c+3y0vLgxDQmAqq5WopzTCOEIYOz1uTVPCK2iH7xeFHZOi8GGY//ngiCyT5rbpv5Vy5c9Ou/TAjCDA/dH9hMD68lmO/mtm8MSspiRG6iXjEYGD1FTp0wn7yudxbZxvgS61k96rrBZyULqT1wp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039020; c=relaxed/simple;
	bh=wfpMNgfZhiuj4Pd8hbso0byVyNGibtw/g7IriPxL48Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj4xiyIMettiNq767Gv90qLJg1W1ySYnPsK7Vsk2LlhKKCVhxueyKybAmy9LfOVbj64jA7SeEUCu0xCuUi5P6PbYxBja0LlljpCxh75q3wH1zN5fVNtrUmzGuqvX+dKsqWFiADNf+tcBACOiH6SlW0vnRlV3Ju5BXZ7h3nNfHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uanvVkWQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NiJpfGMO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uanvVkWQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NiJpfGMO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 079EE2540051;
	Mon, 12 May 2025 04:36:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 04:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747039016; x=1747125416; bh=qAzxDnvy87
	coHD9CxqhFgOd1aoy5CSoPFxgwxidnhCg=; b=uanvVkWQmQGlG5OgvTVsB/Bmig
	XTPAECsSPIYtlXLUoI+tPZxfrITkAErMu31Ik25i/ite8CN62bPuEUzjj+5CsXMP
	xpXFxcupIQZVH1+slwCWP4+g1bKfPT0GcvluAkrzo0jIdfcmGFA4BRQr1d877twa
	8axmrsOWr6B9YfC9RyrhSqdvv+S2E7eSf+/JoCa8mqbe29m9uZ5J9vH+whny+ter
	Opdt1rCBEuMLAoOeGBIyjFIF2AkQOaO3vnozzd8dIONkQqIk9ePH00peywPuOkAX
	iaRTzjj4kApC+fK/e1pqCQYFHkzMY82/2RVDQwQlWgynhbzzO5VujXmEmLPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747039016; x=1747125416; bh=qAzxDnvy87coHD9CxqhFgOd1aoy5CSoPFxg
	wxidnhCg=; b=NiJpfGMOnPZHHrgZKRYZ6XRYk3WcYPx3m+t2K4IXM7pHdypCObe
	civgYec6EDMJSYyEg+mw9QMUKrzWA78tizejnd0XbG3BaKA4uZKuBTSkUQc0tdc7
	1AVTRYiPg9b6/9OBxkCLFKGstk40Q8W8jH9txBOuPk0+DtM+qjltJz0eJiJ9IRvw
	XagJl1B0m53P0T+Bmgq9ehk3+rUQfQr/Q4/EBNl+NTiUFWqPDNNfRqHbP/k9S4qj
	+kF6Tu5b508Z+/O+ALZed5uG9lfN2XeufvzqLDVVT2/cWNNQ+WEtIwcLay+QtHmF
	7ZqDUQ4xDEnb7kw2SImlXHPTXO9mWeWViMg==
X-ME-Sender: <xms:KLMhaNPuzqEYAyi0odOiEyiRLkEFwNU8K-uE64gHnx5M3lQTUnoXFA>
    <xme:KLMhaP9dJzwxtSheL-Z_tRYgUqVhQN5m9jrQKFNOdDYZ2xrTVGWXn2K-CmFyVpeRN
    K1ZvqDvX3GQccmvCw>
X-ME-Received: <xmr:KLMhaMR3qrupObLlfqPwEhfjSKkb00MYbGgPg4zXpKhj8OZAyKQkYYhOv3iFZ-TtTJoqx5azRu2RR10tM2hzg_8m4hDwn2Mrowd_SQrkSUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehteevgf
    evkeetvdeuteeujefgledtledtueehtdeluefffeevgfdujefggeduffenucffohhmrghi
    nhepthhhuhhnkhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:KLMhaJuCwrSP3zB2fo-pxru8GD6Uavq2Q9bRRt3HHKDTdXppxtOvpA>
    <xmx:KLMhaFeiUMXCovOB8EPpza3R7ojbtKyCoL7QpRvWcDRCT6GFHOvAFw>
    <xmx:KLMhaF3lSRB5924hpxk94vTN7rgr6Oc8trWLebd_7IeD_xW12KcdtQ>
    <xmx:KLMhaB_I4d3pmSO4ACinZpqrB-lZ_pxFAMbStQW4TJab9V4kbIUWbA>
    <xmx:KLMhaE0Ly6WRWAejxwUlQkPPY-VpFDOmaicSXf3DdNJYKZ_pmLdGbE-H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:36:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c825f41b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 08:36:54 +0000 (UTC)
Date: Mon, 12 May 2025 10:36:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aCGzIlLH_ESNg6-v@pks.im>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtx2mqihlc0M7H@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCCtx2mqihlc0M7H@ArchLinux>

On Sun, May 11, 2025 at 10:01:43PM +0800, shejialuo wrote:
> During fsck, an empty "packed-refs" gives an error; this is unwarranted.
> We should just skip checking the content of "packed-refs" just like the
> runtime code paths such as "create_snapshot" which simply returns the
> "snapshot" without checking the content of "packed-refs".

I think this doesn't quite answer the question whether this is a _good_
idea though. The question that we need to answer is whether there are
any writing code paths that may end up writing a "packed-refs" file that
is completely empty. Modern Git would at least write the packed-refs
header, wouldn't it?

The reason why I'm a little sceptical is that there is a common problem
with ext4 caused by its delayed allocation [1]. If you:

  1. Write data to a temporary file.
  2. Rename the file into place.
  3. The host system crashes.

Then it may happen that the renamed file is now completely empty.

The root cause is a bug in the application: before renaming the file
into place it _must_ fsync the file to disk. Git does that by default,
but it is extremely easy to get wrong and we had bugs around this until
~2 years ago, if I remember correctly. We hit the problem several times
in our production systems.

So I wonder whether ignoring empty files would cause us to miss such a
common error. But I guess if there are valid cases where we may end up
with an empty "packed-refs" file we cannot do anything about it.

Patrick

[1]: https://thunk.org/tytso/blog/2009/03/12/delayed-allocation-and-the-zero-length-file-problem/
