Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AF27FB10
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664797; cv=none; b=QmBE9BB9BJvueRb3hfOZpo1RU1JZbLS9Q7Cxxhzv1S7Q9Gwxf2X55cOJXOWzsratzxv3XkEQg4oyKM4zWJ4UypYE13MwiME9OUVk5uxmAsOAhKjXkzafq0dU+Fp4vUnRwZqzeTZyWqfJA0Jr6BuR0M8RAoVZzCU2adDFLdgTnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664797; c=relaxed/simple;
	bh=Qt2YoJOGaTgDMHGKNbPRgqXEVQkVt+ebabfSVDX9cc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YrWL/W4z7nYgFenYN+tLpZ67Az9SPw1/sVz7hHb6X/fPr5hjRAkQAUf/m+xfFaPogHls6oM5t3BTCVanG0fELjPYp+DQ7X5FKIsO7jzuYA5at3rsw+64hdCRsODhQBDmrRkPQKvCbrcCCFIcdTT9+e0XxXxq9fvUquw61i9ngl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LdoHNGfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlFpXFAI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdoHNGfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlFpXFAI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1ACF7A0018;
	Fri,  8 Aug 2025 10:53:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 08 Aug 2025 10:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754664793; x=1754751193; bh=g2MC3Wgs+e
	pnHCLIxiA9GNeT+oLnlvOtksvoHKNo5IU=; b=LdoHNGfpcKu6NtY9tmTXpaB9GZ
	qvJ9aAbq7UwLeiB49DwuqigZCT7pIytDkK8+/NcXrwVPCSDUmPIzoYQhq2j6smqC
	XZopdWkWWvzekwkJ6xVi4zmxh8zgJX1hESMqii8bRhgUkmZjJp7t/7IT0jGr4/Z3
	ruEGFPYS6E5FXmI0nPErX0LzcwxoI48DPbhLsou5L7TPzdZe18dAe7q16MKD780P
	xWfCLK9iLHqhHBCuLFiitoKy1Te0Qf4xGEz4oLSAx/t8dQ6O6GaqBtGGGFZmNrNy
	nHT4UlSadGt1HVEE2AmI0e1KFSxKrEqiFvgVhZQDrLy3b1UD6tYfsTNTIk8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754664793; x=1754751193; bh=g2MC3Wgs+epnHCLIxiA9GNeT+oLnlvOtksv
	oHKNo5IU=; b=KlFpXFAI3/Dcm3lk5L+TIsZJ/sd+oLbq7fIrxUy8Nx2oASLCx1o
	+6opwkrJlZt/KDgeylVOA5cHkzE5Solxgj6b7kpZUScazMzDwHCT4BAtQZ5I0rOz
	R9pasqTa6HoC7GkPVLCNvEtVNtM7BaAdwW+8swE/YQ/U2wXQvmsiK+YS8gALeKHg
	3CH423wsw7i3IJrVlt+JeAmfSe+31ZbEO4Xsmq2cEazMNeBekif8O0h6lOVfHIut
	m2PWt0k7x3yq8OXwsOdhV93koqjrKsDfUtXp5ECj51TfhmW6EKH/w+kgnTrwH8Ql
	rZlt1XiJZ3jC4pS+gmi3u3LOMpMubm4HJtw==
X-ME-Sender: <xms:WQ-WaCFOUYy7XSP_5QRobpo-i6hHaqZiBB-59kYEAOyF9ZmPq7qGwg>
    <xme:WQ-WaASoyAI_vuOsuzFd6EOVNSjMhzwDktXsr-uhmLwa7P9yqcvsojPmh3h0gt6Qr
    6_BECify2uzO8Zzow>
X-ME-Received: <xmr:WQ-WaHw__EaN5EaEyxBWK_6yck_Q-fFHwrHAot0sF471rQhYFK1C3rjjDQg_5C39qErLvR1s7s6OtlYNQJbNScZ5UeiPkFNYtAey-zE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdeguddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WQ-WaEf-_hB0Q5wfRv4K4iyDCOMhCrOilRmCIl0tDtoJoTBH97pMRw>
    <xmx:WQ-WaCMMMjFh8U6Ubb-T9y3O7isdXAPBtKyZYrR7miaaSlzwJ34AhA>
    <xmx:WQ-WaHvtPfas770BoWWbZdC_cfHuQFaP9QZfLhqN5iAMPjRdV5KPrg>
    <xmx:WQ-WaLB_0kXAFBWDeS1XsfS3dOnHT5gJ0hW32h6wHJ948HWkv6KhFQ>
    <xmx:WQ-WaCRVD37yP0siYe6atI6t2DUA_-M_7n2lrpVS_WL7Z4aNzrK8vjGV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 10:53:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  chriscool@tuxfamily.org,
  christian.couder@gmail.com,  me@ttaylorr.com,  ps@pks.im
Subject: Re: [PATCH v6 0/3] refactor t1517 to focus on help output outside a
 repository
In-Reply-To: <20250808010651.591906-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 8 Aug 2025 06:36:48 +0530")
References: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
	<20250808010651.591906-1-usmanakinyemi202@gmail.com>
Date: Fri, 08 Aug 2025 07:53:11 -0700
Message-ID: <xmqqldntkgq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> This series refactors t1517-outside-repo.sh to focus on testing
> `git subcmd -h` outside a Git repository. It does two things:

Thanks, Usman and Ben.  This iteration looks perfect.  Let's mark it
for 'next'.

