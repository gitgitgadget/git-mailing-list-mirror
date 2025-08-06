Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC304431
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463196; cv=none; b=aiCzjuvyvSZQWx1EsTGeQwxLo7CQGYaprFb20Rj6CabbBNR/MeqQUAP/DRDyeFP6cAf+MhDOvJ9+BnSTrhewv23Q9bgNX5Jhw1vup0K+CofymzHbIg0INSlC3pGNI+TP+6nshQ6uF2QgJiWOsl2BuWFBBUL/deQ4V0N3f+H6hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463196; c=relaxed/simple;
	bh=FdhfRwihOQkLisKLbCtNMBDsNjuQ+RcKZx+NcBG7w+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7qt0C7EehL0PM2UaA2nDvjzIcJxTDfJ6KAd35xFUlr2fwccraTzVL3Nx+4Wj5E2lmpDjiBNcNeMoNbEMPCQKYh0oBiCFRewPzumdpa1B+eefgRkTIUZAPh/Z97E6GDchvEnFU9xR3XU7QnyWP1+apad4EGxF8oVrbKFiyVHb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e7otghGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFFhMdRh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e7otghGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFFhMdRh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 953211D0010D;
	Wed,  6 Aug 2025 02:53:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 06 Aug 2025 02:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754463193; x=1754549593; bh=vVfE6xoFcc
	cScz907CskkOpcdbHP/OWD7w8NancK0/o=; b=e7otghGwIYUtAAZVyQwxohJX1D
	7NMDX1wykkPrQMbF1J0WCMl01zjo0Hz2OxjMWM7mrXggONi+smW9+whfUTRW5LVv
	s/KLedgWqbeHxrbzwzAgOWlYUiNRBkgYeBA3HsJt/LI/YguPIcHKu/oxnyBYLcli
	axosmileQaDEnxkhRj+i1963sisZV7EbZ/6zmPhipeseTd8Dl5JFVPCotkYu0Q2r
	3OEUCW3s3dwOddGtScjA2xB+YqHYH2/n7kxVS8JCazkfSiCJYDc8MzwPziQTfeyf
	g2IvyWs5l9fCDktJSKsrp2wPaxpkShz6pl8+B7fYMt9sDUFD8U2wziAnJKog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754463193; x=1754549593; bh=vVfE6xoFcccScz907CskkOpcdbHP/OWD7w8
	NancK0/o=; b=OFFhMdRhXhedUm1eet62npTgg92ELg8QMCctmQyW4dQZy0lfoWp
	DAmBKVT/TCqckKefot2nvij4X2LKY65WoEhBRBcdS606xtjeFB5KwfGx/rbFmguM
	aJzuQN+Yn3ZzHP/La8cFVV+VmiKFI/8VIFgXC8L24Kiryfehc90icn2XTfkgTe/C
	f41i3po/JlSbNyQP/wXfWRfjvddvbKtagcDZjOHEJedx+cNYBRb/+NATZbrvgq9N
	xaq/8k2xbN2oPwVySlUfzDn6AhonfwiSqc76S0yhjzmrbk5iBFGI3DC3Y8Mw8AJo
	BPb4G/SBusqjkgHnSCJ1fCPB99QydQElD1g==
X-ME-Sender: <xms:2fuSaONob88VyRY9QsPHVMeVt-NGS1WUiUHRJWL6SlQ5V2H20BXbgw>
    <xme:2fuSaNKQOCo7VC8HLp4U6FMmsYSG8N5SFYFinEDPksT9Z_LbdAQbjFjoWB-LH03UW
    -w-GpzZg62GKem4Wg>
X-ME-Received: <xmr:2fuSaHGepJH7EeKcNkoxBlj1j0YMCKutLFe9P26THbbs46bChlqxlWmYkN_10hxd9IB8Vm7cybEcvxNd2NyKSNZb4U9ibGirImz-KhOfZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2fuSaNR5Y-F01cCoUnkd23h0lG5KRs7qIrI5xmkOv5qoPXK8jb2vvg>
    <xmx:2fuSaLFC1xuqrGTI-qu8iwp_wqFTVOsvKxcCYWtvMDSD618kLkiT-Q>
    <xmx:2fuSaB8eUxUHxYl9paJ_vVvamVao2SI1g9PyHbw6lQsKoeWducraEQ>
    <xmx:2fuSaNKk2Rnx_PDRXjXT46I35bWOJsdbF-i37YOzppZyrr5HfJ-D3w>
    <xmx:2fuSaOeLLNbFE6LuRVX3Mnf0ZJW2sLK80YTT99CzOnVczmFR6miQPxXx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 02:53:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e22b001 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 06:53:11 +0000 (UTC)
Date: Wed, 6 Aug 2025 08:53:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] commit-graph: remove reliance on global state
Message-ID: <aJL71OK_52-nQ9XQ@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <ad426013-bca4-4243-9e80-7d002f0eb808@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad426013-bca4-4243-9e80-7d002f0eb808@gmail.com>

On Mon, Aug 04, 2025 at 09:27:42PM -0700, Derrick Stolee wrote:
> On 8/4/25 1:17 AM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series is another step on our long road towards not having
> > global state. In addition to that, as commit-graphs are part of the
> > object database layer, this is also another step towards pluggable
> > object databases.
> 
> Thanks for carefully working through this code full of bad patterns
> and fixing not just the bare minimum to get it working. Each change
> was sufficiently motivated and carefully done. LGTM.

Thanks for your review!

Patrick
