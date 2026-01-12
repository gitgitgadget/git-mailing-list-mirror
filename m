Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414230BF59
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209711; cv=none; b=jq16E5gzE2w6UM8ig54MsCTC9kwKRcSu6v8aZ3qg7psnIaCWTzBDUHaUHl5xBxgQLVFIoYPzlSY/yu7HD2miMp8iedABh42IAIAnxgp3EB+PPkt4lzPgwCsoSyo44RqihikiVuP8XrBt0M8jCpC3HTbFWtUOc1y+RTBNVeVgjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209711; c=relaxed/simple;
	bh=kMtkQCYbBO2R2C2CeeSbKXguvM146S7N/Z1s/zrmc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ5yf8rly8kmU8/cZqWysae72cXfDyJwshVKPucJzEAztSiWrqDTGQKAKS2Bm5Ey/dipRRvvT0W+nBVCRNCgNm/BJKEQnf20aYRcxD9uERV/QfDrmioHaaTJJ1BlmuLycranwJILWeb4VeBlHVkLvimJsT0+5vChAOw26xrP1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GwCzdQ5P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6fgJYMZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GwCzdQ5P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6fgJYMZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE3D17A00D5;
	Mon, 12 Jan 2026 04:21:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768209709;
	 x=1768296109; bh=crZUS+hIX2G5OZoXV3JjQKUO0oyHgFyHxKaKacC3ivQ=; b=
	GwCzdQ5PB1gBCyFB0zuA3QLg9xO/TiefV+4Xf5/7hGbJwyxug+q5KUk/v/TsyE4B
	SyIE0XqoNBFkc5MQ4XiALU/e0pUi3MQeh8OmwuIzfQmahUK1oTlGJ2ea2hJPsKrH
	qSG8pA5ewQQc3zFEGK4YaCyBMp8mX6es/VMS/IbXoacfhD15TnwGJgvHDDkUrOU4
	SgRhj1bs0nyD6soWHziv2NAxgN3v0EdjRGH6W9v9IhVrJALFzkVkqZjXT3gTmW1+
	IcY5jku3sFvoADfK9vzBsMakR77oUltiibk1k7HVAXsAFclY6Do2Awd7L+Yw3itu
	yoXabC/luXoHIxXQCca5ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768209709; x=
	1768296109; bh=crZUS+hIX2G5OZoXV3JjQKUO0oyHgFyHxKaKacC3ivQ=; b=N
	6fgJYMZ0L2xd+M76vVRAiu2xv9fXW5nT8PjTb7wZitGx62yTsKV2N/GuqyjUrob9
	uYVhbxmUAko7VyhFFBWk7sa+ii4UE0105F78a5DrbbuYqz7BU2I3mdqjCGVgK92o
	eOrDnLux0lkRvPr/Ec1gtvVO7DcpI/kuqj9DjX+ayvi0O62M5fgDfAvRBO3EUlKX
	4JQSeWRNnSAw/cdNf+PVL4AP62RDrgf9s89Dl9jFvEIqLxK3eK98EVvE50RBgEHM
	oWCuwHIhiq37mbPR3fiSnrFBX+7oDLXEITMsduc58TWF7BO/TYWE5YdDNU/i4oqc
	jdKIQLpwoKZisaRewTvYQ==
X-ME-Sender: <xms:Lb1kaQSfLqlH4GfkLCZemDDRol-yxPCMX6dkMjPd5-v5B5Fb6GH9jg>
    <xme:Lb1kaTzs-tM5p4u2tks_3uEyRLw9k_tsR4idnJ2Sla1DmvhwPd0urd_b5ccoNgl8k
    RYrM-K56aQ-uid7wicCVXxYy6uczrPIcmvzRfbnKJHK2XY7PDyvdQ>
X-ME-Received: <xmr:Lb1kabdzrbWMqdhNePCzSMa76j2Xeyd_FLoEL2TYcj720g0oeslcZQKePtwg-9boksuBi6-PN8ki42Y7baDuB2gGiooY-p8g5vqUBAK1cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Lb1kafL3XrdqE8mKp75J1jbyQAaczUU7l8XiXLDuBl0w6TLvlK2HEA>
    <xmx:Lb1kacF7Eb9SrXsbt39PnvzoiUe_BLb0vVJ3QwqAHLjhSvcHmDKD2A>
    <xmx:Lb1kaZoCJSEbcKe-ULsYa9rLBGpU-SksohThrX-Lx0V7SY8nduJ38g>
    <xmx:Lb1kaVQqpSpfWHz92Yr3BDQORxRbOV_-5jle4xw3gng2QwKKxHadsw>
    <xmx:Lb1kaTp_8-maWOIwE_YFvAwWdWlVAqpSJqfFdaN_U5fiBCG8UfdOcm96>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:21:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2e0e062 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:21:48 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:21:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] tree: use repo_parse_tree()
Message-ID: <aWS9KUQDrHj7J6zX@pks.im>
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-9-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109213021.2546-9-l.s.r@web.de>

On Fri, Jan 09, 2026 at 10:30:19PM +0100, René Scharfe wrote:
> e092073d64 (tree.c: make read_tree*() take 'struct repository *',
> 2018-11-18) replaced explicit uses of the_repository.  parse_tree() uses
> it internally, though, so call repo_parse_tree() instead and hand it the
> correct repository.

All of the conversions in preceding commits were trivial, so I feel like
they could've just been squashed together. Please feel free to ignore
this suggestion though.

Patrick
