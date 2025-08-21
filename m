Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5B1A76D4
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792067; cv=none; b=cF3OHmQmykyxKG4OD3N5ABH71oIuhLeVFHFQHJbQgQcuG8sBMWjANCo05E1faKKcz8RHaNLbb5YSeyNAZHnkQCDVQq6EOWiRR4pxTCLgZwfgUcP/PK3FhD0M7biv4R/qloT+U80B389BGOMEXiaxZzv2z1WP0Rf9o8uVwHwmS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792067; c=relaxed/simple;
	bh=LbsByRk4vKz06HoxLkvFFDArqPjKz2To0Vjo4ThHHIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCdVEwwE+m2EreCH10npVBumZUzq2gIiJYjXfQbRcXLKTeKN4hINJVbw0uJAaU4IZhgjTVSARyb8MsH5vhOhjaylit4aIUhpt11fAamJZzmmlBqbf9ADQmy3aVOcIRizxMQUJF5rpN8DEamaRMvJIivh2BCKm8+Ev2wADM3i39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dgW1rgnp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6S0VgYJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgW1rgnp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6S0VgYJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3075B7A01E6;
	Thu, 21 Aug 2025 12:01:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 12:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755792064; x=1755878464; bh=9GR8LhSoT8
	YxOV79TCaQEuRngqtuqLnq9bfijGQOiYo=; b=dgW1rgnp9Rq6iZahjTcTxkj15o
	QNbSCtdrL1e8GjzwyOtvJAwQiI88ysyHfA/IiY8mUcDBjOKybmbhh/t4spfJDr2b
	PLF3UTUPn5/dveYKvXCKofklCiPya/ce6hwh1X+ibsvYb5ip/djCaSVZHzUp3+WO
	kFMwBpyl5lS3k/5u3XLDFoABwqSBnP4lgcOmREsG0DczPfghNroWfof2d7foCjlD
	KkwvPFj6o6jb9nybK9viYsPIEFhVU9MHq+/xGA63a3K6+Fw8hFDmR6hVWEy8cHDP
	vARAsNLZOqibSj0Q486F10byhJTgdsaC+knkwrzFggrW9iHCmoWIKkUAoQkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755792064; x=1755878464; bh=9GR8LhSoT8YxOV79TCaQEuRngqtuqLnq9bf
	ijGQOiYo=; b=T6S0VgYJEzJwNh4RjSQZ2l+Gji6mJ2DQegN2NZ88YflvyAY1Nzw
	1t+wb7Nh176IgWCQv9Rm6E8a1ZXP3rrhF3A4RVrtf8r7NAbkPhK7zxd4tDh4jOwN
	EC6Zd3Bh4JqSmpeD0vv4SJeiu/PubngaxB5BDDz+E8wsyfZrrosVq8ejBU6P/vVf
	dxKJU+8vrVsZn8DvCBeBJlvN/AvlQw9Ru2sFkLCFm+H6rWQb3mDj93T+5tHvpFxO
	7dCJdzSq7SsbBGBH3Ku20EIAVZWaEvOfxK1NqQBuLP3s8TXNU4EhFptVTgpeXDdO
	xBI2nQYgDBnCJGmt/VXvogqIDEDREZrm/ow==
X-ME-Sender: <xms:v0KnaAQWFtlJM80zRkTlTRQ551BKvuFPrXCoHZvTXzlpyUpwfSmN5w>
    <xme:v0KnaJSK8ay2wq39-1mRRpHkqbxknupjTbr94CF-oQH2bjcYdsH5ghkpIz_HzqWB5
    xyJIfaoBIRFBopqkg>
X-ME-Received: <xmr:v0KnaEQjakM1x2daUZtRh_9nWbMvHZ_dA9qSvPfcgULsxEify69dDCtANEbJZIH8RIIduPf5iawtryNah01b6EHhbHXvehgB0tFw67U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvg
    gvthhsohhniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v0KnaO7Ypb99ATlB0vpz4GJoEM_C1uasg64BY7I_uinXUzSArHqntg>
    <xmx:v0KnaA2L5_1ygakPu4vtIT8tSODSTPyovfcUCO6W3PgABptL4y_S6A>
    <xmx:v0KnaJAque6dwY5zwNnnr2llq7XH9AjPcjXv8C_-M1lEecwJzmXfyQ>
    <xmx:v0KnaLPARRXceSDWsoTNfMFBb7AWMC_x1iJ2Ih6YoCeXSwumTyTliQ>
    <xmx:wEKnaORPtf3VleFRNHjMYtjiYtHEVEPs8XfOmrfm3yvbqJv7M9tNrQIw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:01:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 0/2] Add refs exists subcommand
In-Reply-To: <20250821085246.929307-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Thu, 21 Aug 2025 14:22:44 +0530")
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
Date: Thu, 21 Aug 2025 09:01:02 -0700
Message-ID: <xmqq7byw4qbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> prerequisite-patch-id: 235cc677f372e9571dade4313f8cfed4eab65f7f
> ... (~100 lines of crap omitted)
> prerequisite-patch-id: 553adfe23223a427db3f93e23dfb603c55cc5aae

Please don't force others to go hunt to find so many patches before
being able to even recreate what you based your changes on.

Learn the way how it is usually done by looking at:

https://lore.kernel.org/git/20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im/

Basically you would want to say

    This is built on top of <commit> with <topic*> merged into it.

where <commit> is a commit on 'master' (or 'maint' or an even older
maintenance track, if the topic is about fixing a bug in a released
version of Git), and <topic*> are topic branches in flight that can
be merged to the same integration target ('master', or an older
maintenance tracks you chose <commit> from).  And keep the number of
<topic*> to an absolute minimum in order for your changes to work.

Thanks.
