Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33D2045B5
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635875; cv=none; b=Z8bydHJx0mtfNsHlPxdKKQsqnuuvHEa0Pg2YrbhLGhfQeraaAoRTSHET3WLBvdaQdviyMUGmj4fjI1qtQJ80FKDhYJ+z1OzABlOFWGRpxv/cGw8me0YMWhQglw7FMGzu9IR3qqrAwUI3JbCAoFO1xg6Y7eu9NlsWYQl5RFbo354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635875; c=relaxed/simple;
	bh=8sBsRSUqEomOJCX+HbBJrJBOS2uJA9NJ6E5pZicDUE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pMasRP8WvRx2PN7IsAb6W+JIngsXBKSyb/2wnPGW4PpV5WK463Mg0Qw68q4FnHlu3uzUEHGrzj03iaREoaSiD3/nLzRUaijhwvTbLUcrgjcqiFRCyTvdgTwQKnjDvaG9Y2g5fo8cFHmhdXu+q/ToTmA08Mq9q2xJFHCAlrXTyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OaCzGjN6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ta1T8oNS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OaCzGjN6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ta1T8oNS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D8DE01D0004A;
	Thu, 16 Oct 2025 13:31:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 13:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760635871; x=1760722271; bh=8sBsRSUqEo
	mOJCX+HbBJrJBOS2uJA9NJ6E5pZicDUE4=; b=OaCzGjN6odRiHMQenxfAPO2aXJ
	BO1IljXsq72y7FwnlruFtoaYVlMDoIiH8NXLaca7HM52n2xlrMoMXRuYA0H2jdng
	lAPkea8XwxWTXaVYGg7VdWWOEl0njw29rg9fYdQJDPnZQBHXxJtDdA1MCwHAIDr3
	hxbvV2cR3mRLSb7GZcFWtWAtWD3gk379j69fMWd5dtvU3UeDcllfRp7S1MFcqm3z
	yEW2kQCy+jFOiG1+afmU14bGv99DPTAIa2SF8lZDj1pknD/tlIgHag09nQu+zs8q
	9hBdXQRq/48aFymCccU34PWDicoErQPraEFjSUuW6q/94u9cd3+pOflw0yPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760635871; x=1760722271; bh=8sBsRSUqEomOJCX+HbBJrJBOS2uJA9NJ6E5
	pZicDUE4=; b=Ta1T8oNSfRkV43nrLlu0ajn2CzIJK2n7GBS9uOrsFppXBGp0dGZ
	3VjtUKjWfHCnKp8rLUPCJP/z0l1Fol4e8+Hp6yG4q8UBGSbw+FR002VLwAtrNs+D
	QYPt38OR829DVtijcdOjy4mrLDGvunVpPaLXPNOHnIvo5qaWd1wyyvdCJtVW2AFs
	5A5pvLcqOjcbJjBInIYeCNHtkIU3KFLGNtyG8mtiT7b8HnLPVrdaoK72jhA4LtwS
	cOGmQw3nnGi+OlcfnH6CeXgbuNN+Q/OoVPFCuKA6LCNz7BRfVAgIvi18i19uTIc2
	UdmgGw/404dA6HKK0/C35dLCuvINAYMDG7w==
X-ME-Sender: <xms:3yvxaANvfT5DEWPJIadDNOoz28JMSoilxtbgMB038KsOALLazscAVw>
    <xme:3yvxaN-2F6GDeFiSwRm-Zsz20zo8UYA5DYaKZ4F6upqMVf8Bs8tWTRHgYyOi20NOI
    vfIjP4QxxcZ-zvArufFfaYSNqfAIk8I_fae2oE7HJDj633Kr-e4hg>
X-ME-Received: <xmr:3yvxaMRE40oxDnn163QXrmtpUsywLcHtrNZMrTRyJL9qwx-3pCRoXQBn5-wIcwqFKnL17yzeBo8jGLyFp7Nalravq0upOoEC42kR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:3yvxaHltXEjUaoQu8z1nnIRNSEAsBzgdSK6dsD-koC45nlsVVMzOuA>
    <xmx:3yvxaESIgmBpX3LlPW6_Glc_su2Zk-jb7QtFtyWNzT9CiZL2tfw0Mw>
    <xmx:3yvxaNNqR0P0B_80RNNNYzVSjJEzUPqzU1hyo5rIS6ejqAvA3fjdaA>
    <xmx:3yvxaFUh0ct5_YIpuWFD_TdpWKisTcu75pmolhin2yPPwA3pBwOdlQ>
    <xmx:3yvxaC5rNm3WCKQRpt0I2TzJKNRkGbuTYNC3eHZcew3hL8c2jVuz57qo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 13:31:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] RelNotes: sync with Git 2.51.1 fixups
In-Reply-To: <7620da43552a693c0a145cee0637e61d678c8d35.1760610541.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 16 Oct 2025
	12:31:43 +0200")
References: <7620da43552a693c0a145cee0637e61d678c8d35.1760610541.git.code@khaugsbakk.name>
Date: Thu, 16 Oct 2025 10:31:10 -0700
Message-ID: <xmqqecr24uu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Carry over the fixups from 8c3d7c5f (RelNotes: minor fixups before
> 2.51.1, 2025-10-15).

Thanks, applied.
