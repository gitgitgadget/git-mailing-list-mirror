Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1B1FF61E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931147; cv=none; b=Mf2w95nQR47XlX6znbWDZ9gxsoEFibG0jZ9TXz6tpRDdkydQSuosY3IJb7JxyhXiRLBmTEMiZJufAJKt+fWPV4iROTfv+GfuBygXATy75YAknMB8H7ZbuIe0IFrE/TkNf+noD5cNkA8/h58Xy8PLGHf+msFml1cpSQnWtJGMSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931147; c=relaxed/simple;
	bh=TitNPRJ9j/bwDLN3u9JnNmVoo0mVFQUOJmK9rf0kG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAuhIOGkAbmnqsHyTimqH4CsKPmG4ymjFKHNCcXPNuLVyiCPW5YeYi56BNxFZCalobB6dz3rDpoZ882nML6njoykREigR3plxrQOjvdxvrXcWCCDgtctfLBW0nnBuhELE4bclgcZXJwLqfHt9T7eSbaECmd7137TANC4rn4SO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nBclzC0x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frP2N+mO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nBclzC0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frP2N+mO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CEF31D000A4;
	Wed,  8 Oct 2025 09:45:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 09:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759931145; x=1760017545; bh=EdplRZWk5l
	avvHgrCeAQFb1SPC6vxSk1DxjYr749Dcs=; b=nBclzC0xqKS8KDfODT2ecOakm+
	UoBrKLIfMYs1zPTxHtcdZlu7vjx5AZNbYFil3r3cWGMIbsvgKK6uAKRR/VW7MOKG
	vF7f/0Bv6A2N5BMNQC3nqty+xW9jfNjyHZaXFn4WXuotIjUm4xAgASWZi2XJYIR4
	ipiS1d7ySym15B9FfZ3cA22/CpX/qS1hv0/HHh84zHTFYf4eYe6avUHTqAZTkONp
	HPJICEsZtyLgqz3GFKHp6GQF9R1ar1EROwxu4D+q06Z1cueXI+bFr/G9ir68RGV0
	tt4nc8KVPH6g1DXt1QkgzBcBQjR102xC0QNeqQuWXO6udsXVWEEYb7jbvqjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759931145; x=1760017545; bh=EdplRZWk5lavvHgrCeAQFb1SPC6vxSk1Dxj
	Yr749Dcs=; b=frP2N+mOKfraLPdhL3Gc/CwrkBlekoI5r2c7LW+5NBescYFNVei
	GatPNxVXobPbRfdd723lhB/49ZZmE97CysFxWG1GdT+0BtlUvjxcwkJ9rHlP/FDn
	up6LSLMgmUDfYcJ6F2sv4SYWR1BMzRpR33i4aJOQMfY1AnMbQT9ewh+rZK0p5Hdb
	wc9hqBMH8Ga5c3JhR553s31S7FdfwES476O3QiR+HpTmXzfBuelcpJIukGX71Dvp
	THyfR73ykmylY9wmHwrWXiHdXDt0QUX9hAYVxCW5YxsyaWEwOhmB+/Md3gf2mTtx
	VtJ9p02rfvJAx+1950RLw2hBUBwn8IcOfRA==
X-ME-Sender: <xms:CGvmaDbv6Xe_stYL-7EVbA95HktIjIuug44Wip4v2mscDULMXXhwYA>
    <xme:CGvmaIb94G09alsikLPEHumBTcmJhwtYrmK9lki_4x1AbeyxdualRreHbktSCubRB
    ygOgO55vts9ivt-aVPCOhhrMUifoloKFfnWAVobD3CXg70-VWx4jK0>
X-ME-Received: <xmr:CGvmaDlMYwy5s2ooExovjHZjVb2n3m2wiZZNTBpmvX9leMeUIriTljnvQ7gl6Q4qELq-h4U8vxaRDrXqrlgqWInf-hi3y5RU26Rfh5BK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:CGvmaEzzKFfT6X67ZXAdecloEHkxuCU43c-2fEPqYcPl-7JvwIg4FA>
    <xmx:CGvmaBNd3AJeIxgv1oY13SReVFua1Xi5v2cUO-WQwRModPHc2bmgAw>
    <xmx:CGvmaISejhjmkgxH5Xl4pF10OKKyiixg-whe2NtcPyIgBndo-QRqUA>
    <xmx:CGvmaPbIaAxX8UK84uaWhQC2T7UpoOckodwU7BfURyoNZ5MBm2Py2w>
    <xmx:CWvmaGzQ5GrWr0Ili4hP8fuoS79CDBaa8hUzjIZKYcCZ63s5hqYnpYMp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 09:45:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84ec3e54 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 13:45:43 +0000 (UTC)
Date: Wed, 8 Oct 2025 15:45:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/13] ref-filter: parse objects on demand
Message-ID: <aOZrBHSnkBWPw9ma@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-13-916cc7c6886b@pks.im>
 <6e622432-12bd-42ab-95c9-6360fde75377@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e622432-12bd-42ab-95c9-6360fde75377@app.fastmail.com>

On Wed, Oct 08, 2025 at 01:05:13PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Oct 7, 2025, at 12:58, Patrick Steinhardt wrote:
> > When formatting an arbitray object we parse that object regardless of
> 
> s/arbitray/arbitrary/

Thanks, I've addressed both of your typo fixes locally.

Patrick
