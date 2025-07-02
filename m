Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641972E03F4
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469798; cv=none; b=iBgUY5BHqNlei73l5Ui0d3MKVYTTexXnoiaOKiD8Aw+6yA5+KbHfWS5vaco2RP0ouYf06eqBXRwVqWYqXja7wGHW4LPtrYPjtJEMoqCFFQGn4JnQMOj8eXEJRraRhpSHLdIDnFCk5ZsKUKiafSRIICU0rluqXYbuBJVMPQnxoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469798; c=relaxed/simple;
	bh=DK6n/KbgmB9OCdLBcP/vwGNUiYxu+KGpQRRXusiMsD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzMSupLdC4/vyg8+5ntrVpH9/6GkCpN2m2mawfoOwSFEMtXg99+UDPZRuB9selQbOD8TtbqgzPSotR8r6/jSF7Yh7Kh73uyKMtW5T1Isn/gA2QWo8Zfy8e7p8EWat/U2YoSGosT6X1FcW9jD5CIoRwg5iwQ9iVCp+T7j6JU3Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MRb7dxsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmIsoyxd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MRb7dxsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmIsoyxd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C0B71D00131;
	Wed,  2 Jul 2025 11:23:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 02 Jul 2025 11:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751469795;
	 x=1751556195; bh=PZ0wcL7bGzXuapLz+sgJqI2BduDsUOQba2o8V3BH0ZA=; b=
	MRb7dxsmKber14t0Pe9fn+IdHusgoxNrfnyAvfrlxFA4C5P3eT57rPBvPx3tNS9J
	6dXXGw/ENjVfVIgqJ2EZ4ZqiQA1p3j+iyoa2zMWQkF1BOw2UUbhOSjVeqkgHKCfj
	FianNISXgHCmN8+2KEC9CkL+iydoZ12uRF12vG7RLSr/0jUVkF8EunV4SkerqRkl
	jP54NNcl8nSFwXDvKbwUa0RlZAFC6tFsvx9yCcEBUmB0Sdu86BttbUASCB0ezxxx
	yYYBcob+eq5Ex96qukdt8JXtQ1gx8vQraFxflNi3wsQPZrTDa9NwLOV6mW30S3MH
	Yv0GGipORSdTfWyi7RUbPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751469795; x=
	1751556195; bh=PZ0wcL7bGzXuapLz+sgJqI2BduDsUOQba2o8V3BH0ZA=; b=E
	mIsoyxdwL7urd53iH0nkVg/JBLcme/poaAD/45vG5/U3/RjCT07sBjSmyrBruVp/
	bPLa58lK9fImgLh+5IIHc/HJYeKb/7tiK362D6sNEgNzxEbqBgI3xLjiHcndxfB5
	sOQwbT7kfWY/jmb30k3yVF+flt+38UyAOWgOItNiegSkkD1RqqbNv8OsIwrViCJb
	+d9OPbkt1MQi5oAZn59RdXdFfOVnNMMbSXtkd+O7KeGy52CClNIl4CeTc6yhmgbB
	oLmgeF3RHVlN/emazw5j+ACC53988RB/dIXIEXI3zWvQynhFRxz00/eZ99AKSfaA
	XUX/agQmT4i6vmjlTLlCw==
X-ME-Sender: <xms:405laDsB15ptE5RzbEeoqxjMBm6AB5Hn96W33eSP-n9npyN5RUPAAQ>
    <xme:405laEekAK2-5P-qyoP0Cayf3htCRiCy_79csxkZJEya9BFxS05Jq2o75m2qCBXuN
    yRO3eVzQpvEIO-ffw>
X-ME-Received: <xmr:405laGwUsjcS77g-H5k4f-f0ByVvKGrzrEVJO4FgnQkW7922qDmOa7ZJ-3Cq3LyheKqL1t9MTf8GzKwW17_D2Ou0IYwkjA75BEQBoaH6JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehptghlohhuughsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsrhgrugestghomhhsthihlhgvrdgtohhmpdhrtghpthhtoheptg
    holhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:405laCMmn3USpjuNFdJCMc5la9DVURiQYgr553OtFTB8PYQnkEffWQ>
    <xmx:405laD9zjs-dSqKQrxRyJRPt4MDh1zBzJcEUyynXUFyrpM5yv7Wjww>
    <xmx:405laCVILLwmU0Vq9vlZ6lfKIpnCfUaJn4m5EUAkfC1PvMzUPrxoGA>
    <xmx:405laEeHZfIjmFgP6XSRmZyZQVS22Ug_MXT1RG-Dugv4OQgReZggpg>
    <xmx:405laKt80lVIIG2p9nYuy8KYnNz9USEoajno_YlvOzyHJkODfITOyGVa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 11:23:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f503bf5c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 15:23:12 +0000 (UTC)
Date: Wed, 2 Jul 2025 17:23:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, brad@comstyle.com,
	collin.funk1@gmail.com
Subject: Re: [PATCH] builtin/gc: improve total_ram calculation for
 HAVE_BSD_SYSCTL
Message-ID: <aGVO3ej7bEo5swih@pks.im>
References: <20250702144244.43858-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702144244.43858-1-carenas@gmail.com>

On Wed, Jul 02, 2025 at 07:42:44AM -0700, Carlo Marcelo Arenas Belón wrote:
> In BSD systems other than macOS, since 9806f5a7bf (gc --auto:
> exclude base pack if not enough mem to "repack -ad", 2018-04-15),
> sysctl() use HW_PHYSMEM with the wrong size for the target.
> 
> Use the correct type for physical_memory on each option and make
> sure it is initialized, so it is safe to use even if sysctl() fails.

We don't use it though when sysctl(3) fails, do we? We only return
`physical_memory` in case sysctl(3) returned zero, which indicates
success. Which raises the question whether that function ever returns a
zero value without writing the value to the pointer.

Not that it would really hurt to initialize the value, but I found this
explanation to be puzzling.

> While at it, add a cast to the returned value for consistency.

Okay. It's not really needed, but other branches do it, as well.

Patrick
