Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F115530C
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754154757; cv=none; b=PGUqQITDOTvIRCnt31gWIqizfqsTuz2AfL2eaFa3dsxGuupVOO2aHaOeA2JlapqVWiH3oJNC0L6OyLOz35VG3CoDuC3oS83FDREqcNi78paMN/x1rLS+BWNfo+BgdF8ZKlu+48fahzrZCJCC/qXfHuzJV60zO34oBAJ7+aJ5jUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754154757; c=relaxed/simple;
	bh=p25n6+HLM/M9bzXHvrsCfrPF54nWrw4ID6tViD8Dm2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWhYkPUDbvbyGrCcVC0U7G32teaKcR1nPiZw2KHl5Ky8kVB/DK6L0gq80xk/1W7Op8mV2dO+PIj0mZTYRvM5UpBEy7P/zm66GbPeH5RANFxFLIA8HMSoOJ6pog5b+roxt8I0A2sw2hcly3Y3f+nZ+AyrT6Y6C+zGadoic7AnNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dJc0MWnC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OyGUu3va; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJc0MWnC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyGUu3va"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DDEE14000F5;
	Sat,  2 Aug 2025 13:12:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 02 Aug 2025 13:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754154754; x=1754241154; bh=mDgjEAbxmz
	QVi6gNBj5xEBod6sJcFPSH6Z/WaPEkyx8=; b=dJc0MWnCS+gFW5fZ56jNY4CoFd
	fvPNv0NSAqkUL04Pd5ShmqpCJMKR04Js5aqBwaVe81QjLtZQgLqFCtwxNFVRste3
	TQBoFAg7ZfXosTNcXUP8yU/n1VxcXzbl1EaOhdiYN/Zfz+KViDGQ5phgDYUiY335
	r/yri24sSFC0GbOJdDzfNNQHWhMEid5FRSB8/F9r7VOV2hRSQMSomHg8hgpGJQbs
	tSqh7Suesp5HyfqUFyaSanU5g18BxjQPohZaBXHbaZ3GaZcaPkdSMuQ7erx2ZbnX
	pFxTQjGIPHDGx8zqE71HFNd01D2+dz0GGa1kNrw+pqeO3mQf9a8GGwQFmogA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754154754; x=1754241154; bh=mDgjEAbxmzQVi6gNBj5xEBod6sJcFPSH6Z/
	WaPEkyx8=; b=OyGUu3vaT83g5jYCSxrJPeOdfzUWWGIBgIoYiHfVZTBx0h1meyO
	tMw7NpYDF5zqE0rLWgaX50cFY8DZhqApzYZ2QahMH9OSWYhz2fsMEMudjo734JXV
	33eg/kEWqlmObZHvJZtBArenbgTPMiSngZXCIvE/C7vQafgylbGZNdhHyXQIWRb9
	BIkIk0ix7sf6YlExd4v+VkCYOjJxx67tklz9Bwc/Q+SGcoV6XbT6VFJT6eEFY5vJ
	CX0trGP0Cus0pemf2u6oZA3gOLhIF9opxzDdPVW5NlV5zz27YLA16zts9FnKUQAt
	N1g2ZS4uM3MPnTFrwd8qsgRGCZkVIj5/6Gw==
X-ME-Sender: <xms:AkeOaCdU5iNemM9a21KFq8zbFuPR_gtPExrOQKhBEsp1WgN0-3F6Zg>
    <xme:AkeOaGzsigwOBlo-KIU5naHJyLCEy-N98kfesd4DudEWoLso-f30Jf_pe2ygzs5eO
    LALgs9kBBXxO2MiNg>
X-ME-Received: <xmr:AkeOaAHAP5xGPZJQRY5KPmf99kXFae092whxlISwj4Z6S3tBlwg10d6nMJPYW2tcAszLyrWYsXu6pi1ePfR4p_BqIULVUey4DRd1Kx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:AkeOaCzc0lkEM11ThhwmZFOJdZCbL2o3ZBCzhxDaSTZwB-VG7ZUJbw>
    <xmx:AkeOaJuUvR9Ugm8CVPH69hL8FMNYh-Q4LVcgTU_3e3uSabHlj0t0CQ>
    <xmx:AkeOaH2bCsjW_gSq5umVRipsuR-tKVppP4iStmubsjmEAJXNq2qTAQ>
    <xmx:AkeOaM9on4zLyIgjuB0I-PACXZPYHchdoav4OO4vLG1qbW2ZPGMhgw>
    <xmx:AkeOaAOUG7u--mG615imDiCYBs_Q-BmVZy7i7NqML9ktsypFwuM35hae>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 13:12:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
In-Reply-To: <20250802094657.GG3711639@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 05:46:57 -0400")
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
	<xmqqv7nezdw2.fsf@gitster.g>
	<CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
	<20250802094657.GG3711639@coredump.intra.peff.net>
Date: Sat, 02 Aug 2025 10:12:33 -0700
Message-ID: <xmqqwm7lhcla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> PS I didn't even know that we allowed multiple short items or a trailing
>    colon until your email! Hidden corners of Git.

But once you think about them, it all makes sense.  The trailing
colon can help strange folks who have paths that begin with one of
these strange byte values ;-).

