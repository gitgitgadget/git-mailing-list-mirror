Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F52B652
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210484; cv=none; b=u6Gy9h6mD4XYXXMTr9gdl8dlYdUf/Qq9NQkjy6KKn7B1PVJbukySkiiEy64QC3YvvqpwoVSBfltcVf/MEnMhc6ezny145XbDzMLYpxO6P8p1+N0P7jKf2dq57EKRx6qBQucduH6U0Q2LUsEgiKB4BSzIXchokTXvHgs3u3Qo9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210484; c=relaxed/simple;
	bh=hExQLGW8lVcbN5WbIo94IFTwVXapJ/PcwRrKw218kKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPTyoE6wemoZygFQQa/5NpHpsq0INKJjHBY9HdKc0Ue+Lxg6ben5LtuzMCiTal6G9b6h/b30gu3yWnug7dxCyn+8GayrjSYKXdiokoRpf5c8TeKUhzdB1JnCWbyBf5rSXhZ/2xmareMa6e0fDz9a4DnEf4wnmo4bG29oySY5M/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O4QdxiEr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGC8ghea; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O4QdxiEr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGC8ghea"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35E127A00AC;
	Wed, 11 Mar 2026 02:28:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 02:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773210480; x=1773296880; bh=5etUkRUact
	hvpJPvp0ItECHY8Fls8LuIvRdr49J8U/A=; b=O4QdxiErQ6I3gDAeKJjl/FnqGD
	73nYkGLQELXLkwa/zvN1PggZw3wkqSdyOL4K44v1hhZFrCWNGy2jXBe14RhQb2Kh
	tn6LRz8Zrd69at1TF9rmrIzQxFh8QDbuUlYZy1MgSQIXKWBYiY1JMfaO7/32jAwE
	NBfzwe+5xqwnC5pIk2c7y68FQ4AZW4xaBlcKHFwAjsbthjL/ruZQIIgDDOQIBYP1
	QXnYpfYdtqMwdNAPpEjw2aGGZgFKNOvCVpPBdxCBmE63L+33+eZe0je/qJxKWu6/
	4mC7ToXWUGHS5j31DtRISVs5TVfnu7gFOWTIgIJFPj41t1qDqniXqYzzkfPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773210480; x=1773296880; bh=5etUkRUacthvpJPvp0ItECHY8Fls8LuIvRd
	r49J8U/A=; b=lGC8ghea9aDvxpVIWBCCv7JiOENjQzKuRJLUp1mytNEDCJvNhFC
	Wcu5wq+Hd7n3AT77dpzbAKA4RG56GIKoOQV2wo1jMsS9kfnXTtgRdDFPtlYuhA8W
	Sf9PxSw71m0m+0/BqmXZDoMV3OWD37LC8CPNfMwwPS5bdepN8I/r6EPjRTM2vpkN
	lxFnz7oIQ7Fpnh0DKVf8lNIDXCzraciFtHwzh4gra9qI/rib5Ij8DZq6qo8xlLoR
	tBIHz/g9BnMmInGYNvC3vW9Fteli1wrjQxlsUs9gtWaClkEzvY6KExIKWMTjvS+0
	8OIKPWDcinTG7HD4dlQI+L9Z8bBzJukK8eg==
X-ME-Sender: <xms:cAuxad4-pTyF_McNQLIN985sR25BiOYVKA9Ih1sDk5W8acAFRwHQXA>
    <xme:cAuxaWbLkWQvpyCTLR-N7LRwoMkMEk1uymXF__6cSrmNB--nRJ8qw_5sJOWLNeTWD
    tFrs_OIM9D3QRkuo41dV6lhE3-6V4QuMvzKHA5sCDHYm3vTkII>
X-ME-Received: <xmr:cAuxaa5oekqeYm_USweemZcZ6IwYwxYc46GHvKB_23L1ukIBjOBHaThJ4tdzkh8NUZCZ_19Uwry26m0WPyRgbUnMdVfkeHGByEopyRIBEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmshhmihhlvg
    ihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:cAuxaRCjqEkC6cxoGW_gugSUVsWjbft_OSDv-BPzM08Q7JPTrQUCjQ>
    <xmx:cAuxaYcnChZMdGcPzsjzEoJ7As0vPo-apiex69N0QGLRc87d98oBYw>
    <xmx:cAuxaYJmg1qBrPQp3f3j2fV-Oy_jzcEhxW3oVvVG2ISZ8sFMCL9a5w>
    <xmx:cAuxab2yVMtE9P75FGi7AwqHUbbL-Kp-WPL-M4Dl8371TBWlR2zNZg>
    <xmx:cAuxaf0xdkR5ufSeAlDnddUsvubH11H7-tmyQbOkr3Osrf4gB0HiKp3U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 02:27:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4dfbe2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 06:27:57 +0000 (UTC)
Date: Wed, 11 Mar 2026 07:27:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 00/10] upload-pack: reduce lock contention when
 writing packfile data
Message-ID: <abELa6EfYexb06Wu@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
 <2116166d-1aa2-46e5-b912-6268ebbcad4f@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2116166d-1aa2-46e5-b912-6268ebbcad4f@kdbg.org>

On Tue, Mar 10, 2026 at 09:56:14PM +0100, Johannes Sixt wrote:
> Am 10.03.26 um 14:24 schrieb Patrick Steinhardt:
> >       compat/posix: introduce writev(3p) wrapper
> >       wrapper: introduce writev(3p) wrappers
> 
> I looked at these two patches.
> 
> At first, I was thrown off by the early exits when bytes_written == 0.
> But I convinced myself that it makes sense:
> 
> - In the emulation, if the underlying write(2) does return 0, it makes
> sense to signal a partial successful write to the caller of writev. It's
> the best we can do when earlier blocks have already been written. A
> return value of 0 is strange and may be an indication of future
> problems, so let's just stop the work we are doing and let the upper
> layers deal with the problem.
> 
> - In writev_in_full we need to treat the case specially in order to
> guarantee forward progress.  Treating it as ENOSPC is plucked out of
> thin air, I guess, but not unreasonable.

This part is basically copied from `write_in_full()`, which does the
same.

> In conclusion, these patches look good.

Thanks!

Patrick
