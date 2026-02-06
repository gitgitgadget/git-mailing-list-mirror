Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD2242D76
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393339; cv=none; b=cN83D3dKkgHbdDNNeTU+QMl6GKxYkJ41iiwBGFbOeAxVZB7m5dGyKo5L6tuwukOIbqDBgmq21gSfhykgpB591AgD7Lql/oRPVUzxwatOHuQzX68jrxqeJu0igEuOsHc5EDOgq1qo5yRACwgLMY2m/Hl/bgYdpmsLXJ8aFhfTC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393339; c=relaxed/simple;
	bh=GL1eXzRN7SISTmnUlksnutYzFLDubCnM6Nrwm4qJO2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc1y1BldjE9vKzXumrkheFFBYBwuQF57X3YmjfEmKDEelBH1MDKli5Sxu7PBbl67A+pJb8p06jQZatCuHZWFXv6wyh3FA0wO6/VObsgx9TBLcEYU7GbFmqHOnnARH0hcFNSi7NVHVnRy+XdJezQCzzoWefjKm0YDX6FT611ullA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DNm4ydmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMzNXyCM; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DNm4ydmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMzNXyCM"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A71A41D0007F;
	Fri,  6 Feb 2026 10:55:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 06 Feb 2026 10:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770393338; x=1770479738; bh=99KPGfCVlQ
	u8UF33ADDFYuBLkLBw0rcfIqO94adlK48=; b=DNm4ydmQGCoELJFNjtOz3qnM8T
	/FsB/LolaBst7IYozAu6ia0vNExZCqpJwJpT2Lo9tqSJ9QzisRMM41tSZCjxEJXu
	8rymXRdcvdf1/lBVCUlMthm1xbzy29gmSqimh554Z4AsttFFznWj5ZNFWfCe8TKe
	dz6LKHYnL0igSvxEBRnmNvfGJVtoCJxyaOSub8DcESiKKYcq8X6yZqGpt3UI7FiA
	HkmN8fh6MEYFypIsaND1eFyKwwO4Ptxo8qFQXsVBtSB1cbdrDw+X0aO7ErEdMQDg
	EK0lKq06FktWxoQruKJ4DMXNcEdl0pdsuoQAsnktED2s8vkaDdDfRNe828yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770393338; x=1770479738; bh=99KPGfCVlQu8UF33ADDFYuBLkLBw0rcfIqO
	94adlK48=; b=ZMzNXyCMMhPZN3yGhO2cgGRrq6dJj0KgzA5yxuqFxA1STK955Hj
	eCLi8884KJfoH9qy2a9fCGpW7ZQ/Qt3qjGob92/UZum85Y1HHfQkzCGfeOmFrgRJ
	Q1Bu5zR5nd4sjfPyu4+zhigJqK/QObii9/Q0d9hcxDkU7r1BreNi+Pf6CxHjjCuf
	7HRQHnnin6Ar8NEdeqYmR8db+m2xwlrXfXO8yDE3n3R5gZHC37y6BK6Js4pSJXqz
	4s5ShoziHqlVLJVWvVmWPS5UenBpG2DsvhF9VzkfJJhv1RacWdCfHEurRXkH12NS
	XnfXI7xjR2Q1rfsLPUjs/59Gx6brb9ICjEQ==
X-ME-Sender: <xms:-g6GaQyzLmQ_BvZ5GTlIjrLTLcHy1hXCuTg9Y_kBYagW_tCnNY-SEA>
    <xme:-g6GabLq-y7iqxbz5pjC26-nSA3MQnmmgtL6ouQ9Etgtyg3D51T4S_3tnP79KQGq1
    9eRcndi9LjzGkd-1q93MM1hnvOOWqP3ThFs9w4gnSNwgj5xWyw>
X-ME-Received: <xmr:-g6GaapsSbF-r1Juz1KYdKIRG7Z9J1FkzOHzA3NWL13n4xlBQWB7WW1g0ZIXIGpeRtUu6QiJFgXxm3L2if8RAmUGDT6kskR5c1piAKzGUo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfedutdduhfdtleffieekvdfgheegvdevgedtudefvddvffdtteduvdehfedufedtnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-g6GaaIqPZLQItZn5BCdWB2WzhMg0NUtvQG5ftXfZQ_QqwofwyM2Xg>
    <xmx:-g6GafRvxjaQtJunsU6cQVdIB6kue_kBAh1ruaTiwoFQf_Fg8rN8fA>
    <xmx:-g6GaZs8_2s8tdcDizLX07rzrWqP4WRtOqTFhYEsw-bZotxD36msHA>
    <xmx:-g6GaQZYPeuaB9l62VNPux_Sz_xzNEy9zP0ec7tW2IRQWgMQk0p3Vw>
    <xmx:-g6GaSm005kSVRSQVgA5HaBUj2KVbfizIHgbeN9wG4GAdFA2RbXS3Hbg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 10:55:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75c50a20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 15:55:36 +0000 (UTC)
Date: Fri, 6 Feb 2026 16:55:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v6 0/4] Fix git-last-modified(1) bug triggered when
 passing a tree-ish
Message-ID: <aYYO9SxiC5zFbB71@pks.im>
References: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
 <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>
 <xmqqecn76nca.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecn76nca.fsf@gitster.g>

On Fri, Jan 30, 2026 at 09:07:33AM -0800, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
> > Changes in v6:
> > - Fix CI failure with Meson on Windows.
> > - Link to v5: https://patch.msgid.link/20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com
> 
> Replaced.  Thanks.

From my point of view this series looks good to be merged down to 'next'
now. Thanks!

Patrick
