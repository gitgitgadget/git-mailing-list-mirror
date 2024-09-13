Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09C187334
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215669; cv=none; b=bcLM2SRjl5RQaZKvhj6ywbeI0D3nXTr54sxDwm+MNaoD314lvvgkDXR3vyHMRVJnVfU0cc4qx6HHamT+SdgKs2kY1MAu0O+0G4fhuVm+2PXDb9x/fUEJ1xiW8349Tas/LRoEDZmZHkfNb58GTEZjXoRAwp1KMBttsniUioMCiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215669; c=relaxed/simple;
	bh=j6jWgUH4suTYiEqU+2QsoIo8jsgQ/D0PnupxpCeywSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8Ht6QKmQSYs3ZUQ5qy9uapR6BDas+dxESLIisf1IH0XARmAn/jaNpdmtD9YoRlCJdaN/6+OR6L+JUMVx703QlRO7TyI1yKiEiHo7JasN7rf3TVRuEsPrbHdQ6zKMmAafyFCLIEB/0iYQHudyNSd2a+tOq0JOtExNLxKyIMDJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jDPqXuuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQ9acVz2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jDPqXuuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQ9acVz2"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 118681140362;
	Fri, 13 Sep 2024 04:21:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 13 Sep 2024 04:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726215665; x=1726302065; bh=NCvmGdkWZn
	gYOAxgcljYDud1kvV0B1ZOmFjq3vnHhK0=; b=jDPqXuuBTVeDaXlYclvd7bEHwy
	XGPLpBrMfbzxl89QXzFb5H05VL+HQbGXT88fk84wd0eZxlJ4haU+sFKJCkUoltmU
	JXb/EWBj+q06P1iPGuCXcUuiLKN5mKL0TaQLuh2pADvFpQ1uQK+BkMB8RKiZ0hGn
	IZ9vclEIkpAkqZokT1f7Og+CN6s3iXONWBEy3XFzDsEH2y2zlsx96NjC4CqzpOOH
	7wsfY/cb4Is9qNl288rZfL7ozYS0A9KhqYuxCwL8aCU15w+LwiCOsw6qVi5ySUa/
	gQQLnXjdCwADOOW0jQKRv0R5RyKABczgVMw57VepnD8mXzXhuAxnPQO2Rtfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726215665; x=1726302065; bh=NCvmGdkWZngYOAxgcljYDud1kvV0
	B1ZOmFjq3vnHhK0=; b=BQ9acVz2Mk1fd30P+bZplYPfpI7MBE2g15JCfRa8wVYN
	4YJmNWX4b/W2iFmURsqJzgrhJNV80asGZx2Egkgj5B4SJUoYZ+3X7copatBt2iuA
	ZvNVEcffkRgOCnvIdG2vO4EeceUy0Fq0U+pU3y7o8UizR4vm6xuoU7lgpatrFYpH
	RZtsI0quvK4wNNOP2N23fLb1K3nAXjbzy6Lh4KPBU1RMFY/VVlEubYnNsSpzi51T
	IsDiPF37sXBy2a11WLwnBmr7W8By8hLZiQZUmkucx9uaKUBOcTh6N0kKf/BP2+m+
	eyRSuZlhuq8lwnf3ssZN60a1Sc3hyn6scz3Y2xudJQ==
X-ME-Sender: <xms:8PXjZtVK5RphTptXhMA8ASaKWw0RAu9kmvH2H5r0dEnJN11PH5Xjtw>
    <xme:8PXjZtlWLm-l-bvg6jmrmRkYR4ZBhWLt0X-sM3JyBpJimpYer0PwnJkwrG3ywUnvw
    1-z3QPmCEtCXzZtaQ>
X-ME-Received: <xmr:8PXjZpZILi4SLAwuziIlpusMzSnBnlhPutonKK-dPZJjqTuYSxHrqFEJjx_KwfT0260KT_pC32MZ2d5DLuQwk0RR-jyEnO4G_WSyuYdsXRkZaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlsehhrgiggidrshgvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8PXjZgUYF4J6fLpI5g1dms4cDy4ZcsRNslpknEp7TOE366hPnNPjxg>
    <xmx:8PXjZnl8Sdqfbr7GCppa-E526JtHK2CUP4TENRKqpqQWhgjhYLv0IA>
    <xmx:8PXjZtdRkSXGlRXLFptU0ooDAczPjBmCkASaoHa0xh1-CoUoyu-0DA>
    <xmx:8PXjZhGUOOVFmx86FgaFSKXci9MJnRpXt1GChlUi7Lj2FlrKISLgtQ>
    <xmx:8fXjZsw_EKknz-5lje57d8SNME84FAc_T4Q10QiEXChu79vxMOcTr9P2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 04:21:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9d9f781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 08:20:50 +0000 (UTC)
Date: Fri, 13 Sep 2024 10:20:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Daniel Stenberg <daniel@haxx.se>
Cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
Message-ID: <ZuP168QTTMiv_DxH@pks.im>
References: <ZuPKvYP9ZZ2mhb4m@pks.im>
 <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>
 <ZuPdfsbHwjQPDPXc@pks.im>
 <565691o1-3451-o06o-2594-2750r90nqq6p@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565691o1-3451-o06o-2594-2750r90nqq6p@unkk.fr>

On Fri, Sep 13, 2024 at 09:49:27AM +0200, Daniel Stenberg wrote:
> On Fri, 13 Sep 2024, Patrick Steinhardt wrote:
> 
> > In a nutshell:
> 
> Thanks, this is helpful.
> 
> >  - We then clone a repository from Apache with http.postbuffer=65536,
> >    which makes us use a small buffer when POSTing data via curl. We
> >    typically use 1MB buffers, and when changing it back to 1MB instead
> >    of 65kB the test works just fine.
> 
> Is this a git buffer size or is this a value you tell libcurl in an option
> to set a buffer size?

I'm not all that familiar with the "remote-curl.c" remote helper in Git,
so let me try to figure out things as we go.

  - The code that sets up the POST buffer is `stateless_connect()`. The
    buffer is allocated by ourselves.

  - We then execute `post_rpc()` in a loop until we see EOF.

  - `post_rpc()` itself is doing all the work to set up the curl handle,
    mostly via calls to `curl_easy_setopt()`.

  - In there we hit the `large_request` code path. We set up
    CURLOPT_READFUNCTION and CURLOPT_SEEKFUNCTION. The callback that
    uses our buffer is the one set up via CURLOPT_READFUNCTION, which is
    `rpc_out()`.

Whether or not we hit `large_request` depends on out POST buffer size.
We first try to read all the data we want to send into the buffer, and
if it fits we send it out in a single call to curl by setting up
CURLOPT_POSTFIELDS and CURLOPT_POSTFIELDSIZE_LARGE. If it doesn't fit
into the buffer, which is the case for in this testcase, we instead use
the callbacks to write data via curl.

> > I've appended two curl traces, the working one with 1MB buffers and the
> > failing one with 65kB buffers. I hope that helps.
> 
> How are you feeding the data to libcurl? (callback or by setting the
> postfields option?) I noticed that in the working case log, the POST
> requests always have a content-length header while the failing case log
> shows that header lacking in the final POST request.
> 
> Is that on purpose?
> 
> libcurl should still handle it fine, it might just be a clue for me to
> narrow down my search.

I think so. We're using a "chunked" transfer encoding in the
`large_request` case and do not yet know how much data we are about to
send. We'll only figure that out as we go.

Patrick
