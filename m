Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444541760
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745012317; cv=none; b=YrIOCLwM1PTgIlT+8p8XyUoD/Y3114p0HszEaaiwUfjs5jqnpqOfEsQgb4WkL388U6zyoULzycwd+kH93LtADe31gTZN+bNETOs6xuM9b5k0YtoqOMWOEdLrHWx4Y100dH2ZXrhk2hiUg2xb0bvaWUdaf9TKIoqYR60gKwU+InI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745012317; c=relaxed/simple;
	bh=8OV40C79WRlOGtP/Fe6wzBk/mAa/bt4e9Rk4nWrbggY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sElBwpyTUm02U7+q/GP7cP8eIj8LJTFjKbTuMLfFhfRKWRHn8fhrtA25pBnK7YfAZjbEX7q2/6dxV3nwXtXipIU4fYW2XhJXO5T/Q7imx6f1VIsdMOvt7Zn+bKMzRewJBrXvw0C9wQBSWwslVBuAgjU/Jt7Mon/eFXl3+hhdcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LCiaIVxE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dd8Tcuea; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LCiaIVxE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dd8Tcuea"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 35FF5138054A;
	Fri, 18 Apr 2025 17:38:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 18 Apr 2025 17:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745012314; x=1745098714; bh=8OV40C79WR
	lOGtP/Fe6wzBk/mAa/bt4e9Rk4nWrbggY=; b=LCiaIVxE/WIROFVopSu0Mm81Bh
	Rr/qJ82SYQRsS3JDik8Q/eTZMmdiL3a6quhYy8j5z0R3kBydxFe/1w8j9+ODzFvV
	46AYHv5apJQzdO7rVSvMuBUp9/ZSo2KxYcnC3C068I97l/aZyiqeW4Jj/OTuvri9
	eJvVdumAo4r7z4tPOtJNJQup65vxDMy3N8n8vb6VOtitke+mi3/0xOWl9lXrDZiM
	KCMU/UaNXBFw60t3HWC7BdvnXC8fqhh+6S1/RNmljVLUYwZl8psubfZNJZJMpI4p
	LpwoyOpggq9aTkqRSfMxRIfRPH2fSYP1Tu9dvy317tG4FXKtqHjQ70DY/w4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745012314; x=1745098714; bh=8OV40C79WRlOGtP/Fe6wzBk/mAa/bt4e9Rk
	4nWrbggY=; b=Dd8TcueanWsoBgS8Td7rMoVUt4l3XGmWLCtVqKNmaEjA8YakRFH
	A6ISBmkE5Y2uDfxuIojGPMWya9eAsaCdojQ6NYis8ReKNKt9AHKBDxpPEa9fpyZ9
	Ne6p3v0NwiL0ft1Fwk1kbT7MAeHQseuQfUQTBuOgKOvMNs8C+CiCO3p0ZO4G5QPJ
	ofztRDealdsI6RpPmtTK6iSuuqrl1JL8mEoXrOn3mTaXdaqMTG2EVvQyezng9aT2
	bcNJ/3EGPQSWH3D7NVV5fjHmMWXNNp8Wm/ubUdF+F8YvlIDTrTqLNRX8o2eRRCt4
	Ty35ZpOH+olZ6C9+Le1RD8t+7F0tL5zBIGg==
X-ME-Sender: <xms:WcYCaFxCrKky22Ew8pKzKXnvj9xIB2nN8G3WwfU1hpS7z-U3dE6Nfw>
    <xme:WcYCaFQFvT7pZKwEKki2HNLYKfbRTceE4RfDOIf_xu7lb1I9kk8-kyaER6_arQ7xH
    4SGzHJ1RY051cq4dQ>
X-ME-Received: <xmr:WcYCaPUUFUInyyVRTGgitlfRpDeK3_Z1e0k2M8KvWSO7bRXCceI64DXzOms22Mb9ZguNSaetzHTS8lYlAilWhqUGKFEY-D4AxBWB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopegrnhhthhhonhihfigrnhhghedufeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WcYCaHh2jSCLivNrDkte1Nvx59vXx-dYaNBFdkqMr_gL7cAmFETHSQ>
    <xmx:WsYCaHAFj3fCzbX-d_8LJU8eElaQ0lnZiBlUkJMBlEoZBxTJtXyQdg>
    <xmx:WsYCaAKN7gp4OQnYNT8PiPAvAIKZBM5d-N-w1KBonACXR-Lv9lmTow>
    <xmx:WsYCaGBntyaYtp8TsPUoO6EbVeaGnFTes0LQ6SbDS1L0W0wVUuPwow>
    <xmx:WsYCaN5sRg-VCMngQM6yBcZcOwwsx_Ere1mcqQPtpyZNz6PSq7raOyn->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 17:38:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Anthony Wang <anthonywang513@gmail.com>,  git@vger.kernel.org
Subject: Re: aw/t9811-modernize, was Re: What's cooking in git.git (Apr
 2025, #04; Tue, 15)
In-Reply-To: <20250418213531.GA89733@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 18 Apr 2025 17:35:31 -0400")
References: <xmqqbjsxkn6x.fsf@gitster.g>
	<20250418213531.GA89733@coredump.intra.peff.net>
Date: Fri, 18 Apr 2025 14:38:32 -0700
Message-ID: <xmqqtt6l9mlj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I don't know if git-p4 got smarter, or what. But we should probably
> back out at least that part of the commit until we figure out what's
> going on (where "we" is somebody who cares a lot more about p4 than I
> do).

Yes, and there was another breakage in that 2-hunk patch in the
other hunk I sent out a fix for a few minutes ago.

Thanks.
