Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8E192B7F
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390090; cv=none; b=GydNyzD8vQC570UMXhRGK7zvvvOhutW4os+nzjY15XfK80ZXJLujzgM2RKu6e6fTLytBQSbvFVOw1Nzwf9nCm2klhLvu0bsSv152AOspV3PichfMHRLrP/sbboXq+ZSeBxL52WQwk6nUDutPScoREyXq2oHAFmLriQGNUJla01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390090; c=relaxed/simple;
	bh=GP3lpAUquy0hbBQEFCReuzyZ6Ji092aJbF4E05rsdX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KP9bT8zTqNCGMQR4UZCaKGTYJspypxGDMl4Mg5kGZpTYhZk9Qfn9bBu1zAB5Wx+rtstAMzJdqH3NocylmDJcpd/mnohnAbJkrAQdoheP2jZylvabjaaFrxLipGsodI2YwnGkF+ZFcAZgLFPCrxBviChiPIxqMVUHLD2Jrd2MqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PonI3wZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKuAHqa+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PonI3wZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKuAHqa+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C065254016E;
	Fri,  7 Mar 2025 18:28:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 18:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741390085; x=1741476485; bh=N/+HvTClbI
	VqrVLa60WgPcfZfR20fV+HAoVQGkBjdUc=; b=PonI3wZ7VjTpCWUdWTLSslk2lH
	O8H32Mt6PBWw2uWWgcegSYK5u+kP/P4METvvezpt/Zd3BNTPv6BOGvpniw1miyo3
	fgH1QpYpqtw/LfKmP1m9SoM4xm1tkUWnXxClqtJou1/dhqXY4G/MZQb3ACJ1ZHQs
	zFc54T+cgYLb8hSeZka1auZ8uEdPEiUWJBgXAq/1oOMoRYKbJzk6B4zgsJ1YfcsP
	M9l7fKfgcx+AWSIJLbBSZELnSA9kTw7+77ugysnNrkFUztto5sKj1cOs422InCtl
	lVKhZTjclht5+KyAHu3RQnojbXJZHlBG9qf2LTXiKzce5WxagTkzkuzW4Xwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741390085; x=1741476485; bh=N/+HvTClbIVqrVLa60WgPcfZfR20fV+HAoV
	QGkBjdUc=; b=rKuAHqa+jcNmVLElKzWGIgxFiSAICKz9+KhFReX75CmRgSkj86S
	KfmHItMp6DudqSWopFrpeayfWstgxQEdOstTaR9FQ+wfWiGP+WR7egGEGWcS01k4
	5PeRMt9FkJs6x7sVvnNnNhK4d27ZtG+Jgp9HubioFOTnUF5V+E1VZglIqGpVy6Mn
	LniAIGIPOUC3+STbUYvml9mMsmFjEpkkW1HlebwpgPpQ5cru6sa2TcuyTetctcLQ
	GoY9lrklnuplZJQYJ/En2aGgVCY25t++LuYiJxV/7NLeUYUw9GMzZk9UfOOaX61F
	K84po6JBI5M6xg+6JSbWEihXAOQyzDKWs6Q==
X-ME-Sender: <xms:BIHLZ4CcwZjn99EO-abCyJAo63y0Gi8_CO7KXKZUjXkqPxixHggGSQ>
    <xme:BIHLZ6i-AIu87JXbYG51NHDwebv6geL8wP3egZYpcN8FAwuSB2uewHDnxCFBOvukq
    s_RF5f5ub5W0hmOYg>
X-ME-Received: <xmr:BIHLZ7l13ETuNrORxCZNDEce6P0lcmb4y1xE_6M8LNdrbU56DDHvHRFPzTKDpNgbImRiO7WfkCQd5IuwS3B1sj9GnajBtMumO5xr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepheevledugfefudelleduvdfggedugedv
    teekjeeugfefieetfeefuddvffekieeinecuffhomhgrihhnpehmrghkrdguvghvpdhkvg
    hrnhgvlhdrohhrghdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BIHLZ-zBEZ3CTUbiIPYRLKydLZYn2Jpu-K3g0fFgBFZJJObu_WyJbw>
    <xmx:BIHLZ9RdnX6k7xwQc6LCbk2Xdd7jmqg6gtcCk5ci5aiNqYwCp9qN_w>
    <xmx:BIHLZ5YHpCPilao0V5quXQnGig8Soh06u3qcSq_33ParJHK3cztWeA>
    <xmx:BIHLZ2SQjRAH4hI-gxRsQinPse1nQwS-C0216mL2OgUz30frx5A2NA>
    <xmx:BYHLZ-RCN6MD-qUJXEXX92SadJ0IlHgEkdA-4XfZdQ0ktilJkt1VQaIw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:28:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250307225444.GA42758@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Mar 2025 17:54:44 -0500")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
Date: Fri, 07 Mar 2025 15:28:02 -0800
Message-ID: <xmqqzfhwbev1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I was disappointed that the compiler didn't complain, though. Maybe we
> should do this:

Indeed.  It would have helped us if it were already there in place.

> -- >8 --
> Subject: [PATCH] config.mak.dev: enable -Wunreachable-code
>
> Having the compiler point out unreachable code can help avoid bugs, like
> the one discussed in:
>
>   https://lore.kernel.org/git/20250307195057.GA3675279@coredump.intra.peff.net/
>
> In that case it was found by Coverity, but finding it earlier saves
> everybody time and effort.
>
> We can use -Wunreachable-code to get some help from the compiler here.
> Interestingly, this is a noop in gcc. It was a real warning up until gcc
> 4.x, when it was removed for being too flaky, but they left the
> command-line option to avoid breaking users. See:
>
>   https://stackoverflow.com/questions/17249934/why-does-gcc-not-warn-for-unreachable-code

Wow, now they leave their users confused, making them wondering why
their command line option does not do anything useful ;-)

> However, clang does implement this option, and it finds the case
> mentioned above (and no other cases within the code base). And since we
> run clang in several of our CI jobs, that's enough to get an early
> warning of breakage.

Yes, this is great.

Thanks.
