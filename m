Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752A7FD
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669304; cv=none; b=OqyIPrWrD+WraAFzVA293vHfEREZE+g7U8kEVQb0joSIcQ4XSlHXlAfVRhJdNl6va6bKXxFjaUerSy+92HPCHhnoIWlLx+QjUlyQs3xwu840fBjsuJQyodAD5VmchxgMGUO5Zf2Fyk7EKQ5xWeYWCluPAlTaa0FyDTajlMsfkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669304; c=relaxed/simple;
	bh=b0im7ZqvNHUlxHSjsM/UX8N0tbbASmHS7SRWKA29Zq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euVGQHBhmB2ehliT66jxDO6i3KsaxoXfNTH1XGTo39njlnabMuCqd42qoWKJ63J7dP1HD6e34nJLAqSzmNkigc5dpYk+X84xqeSzRYfoozNQ6AlyJfKHirmy95u2AgHc8M0dT7rFaD4GMcAvyn5kS86dr/cnbQ4GCXOGyZbKr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iymcehKf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OPeBAG6i; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iymcehKf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OPeBAG6i"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50D88254012F;
	Mon, 19 May 2025 11:41:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 19 May 2025 11:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747669301; x=1747755701; bh=9SWaS+nWbG
	a1waHWLhAyLdrJt1v89D/Gutmz8y2aI7c=; b=iymcehKfE8fi/IY6cZNuWaNKVv
	OXXLNCzZx75P68fOjsdPMFGQCw+WD5AJzr4iBSkstHohVzaels/flSUpLYIo9AyW
	IoznNA/vIPossjRY9TWVz3SO5/vGFyiGHMayGA/lnsoxRCyJRw1HDiHfPzAbugVw
	RVBX2gokc9keNkXd+8WD++RFVDvLk2WceDzPG+IYEU2KLfxJihOBXz0krrN6cFU5
	7erRaLrEwno75QW2bE9o2LwyGy5FhNsOEe0UfmdRquxJt/iU2fxLBqfgd0SI8vBe
	DOEleramAlEQ7+MenzIPpfT0L6b3A02Qu7w7dWeRkOS4fen0kJIJgBcbNUdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747669301; x=1747755701; bh=9SWaS+nWbGa1waHWLhAyLdrJt1v89D/Gutm
	z8y2aI7c=; b=OPeBAG6itdknPPvs6BEcppjRPof2GaTK9FDmtkWW2RFVthsM4GJ
	iuCyvy2p0+qmu2ObZkNjsSbp1fBtXEWSZF1n04jxPdVyUpZUIIJipG79f4xkPtzd
	Lqmq847vzCMQ40aJByGRStYb/CDVbjqT8FUV+06UDEgbZrOSYpuZoBRRu17ZxU1g
	Q0IVlHzlnn6LXJNoIl3fa8dyF66mdDVlxcG/UgABRT9E7OutserzIgGNNvlX7FUp
	0K6NBNK0yb5toWPBDAaxWBh5YLCS+jpHdDwLQYeI6jhJmWeEFqzMyr3e23/+w7ny
	MCNapeJjM5oXNmWkFw9WOioUwwe3n9w1NCQ==
X-ME-Sender: <xms:NFEraM53GnE2S3EnyeI05BJCyhx60u7B5Kb4uI9nH0fAKQEvheKCRA>
    <xme:NFEraN4yxk3cxoiutAFv9LKBDhJ607Ne-ZX8EJ8TBN8R1yAnbRVKtAAF3fjVQylsj
    WMPPu6YRNU1HpzHAQ>
X-ME-Received: <xmr:NFEraLd0H4_FNM7UF0R-lp1wtcZUhxDsGokxZn0kB-8_XLE3X9G759AmCiJS7RlEWiPV9EGa2jYvDzFo01xrclunaf1uNG4rcmarXaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhlvghllhdtkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NFEraBKI2MKYtQGVm8yRACZBP1nJp2ndnR5SPbWCSgp8rVx1B9XSUw>
    <xmx:NFEraALgTcnISqr3Nxsgdb_RzJwGpCyfjdmH0w-e1MexKI7Wyas-Ww>
    <xmx:NFEraCzJKGxAhPmbW7WINcNr4VkRDwY8l2kCOjafD03pZ8UXrOwe2A>
    <xmx:NFEraELBSMG3fd0RDDmxdrWNZKtQ9DsxJe_GXR67GI023j5q9YV3eQ>
    <xmx:NVEraDVAAAncFB_7ItfyZi1Im7VJ_ijp11on44ykXJ6MxjjLU3M46zjc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:41:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  mlell08@gmail.com
Subject: Re: [PATCH v5] submodule: prevent overwriting .gitmodules entry on
 path reuse
In-Reply-To: <20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 18 May 2025 13:24:35 +0530")
References: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
	<20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 19 May 2025 08:41:39 -0700
Message-ID: <xmqqwmacobf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When a submodule is added, Git writes submodule.<name>.active = true
> to the repository configuration to mark it as active. This happens even
> when the submodule path already matches a pattern in submodule.active.
> This results in redundant configuration entries that are unnecessary
> and clutter the config, especially when pattern-based activation is used.
>
> Avoid writing the submodule.<name>.active entry if the path is already
> covered by a pattern in submodule.active.

This explains why the part of the change that deals the .active bit
makes sense.

But now do we drop the other fix from the patch, namely "ouch, we
are adding submodule at 'foo/' but the name 'foo' is taken by a
different submodule that used to live there and moved elsewhere", or
have you forgotten to describe that fix in the proposed log message?

Stepping back a bit, perhaps this patch addresses two independent
issues, both of which can trigger with"submodule add"?  If so, would
it make sense to have it in two separate patches?

> +test_expect_success 'submodule add fails when name is reused' '
> +	git init test-submodule &&
> +	(
> +		cd test-submodule &&
> +		git commit --allow-empty -m "initial commit" &&
> +
> +		git init ../child-origin &&
> +		git -C ../child-origin commit --allow-empty -m "initial commit" &&
> +
> +		git submodule add ../child-origin child &&
> +		git commit -m "Add submodule child" &&
> +
> +		git mv child child_old &&
> +		git commit -m "Move child to child_old" &&
> +
> +		# Create another submodule repo
> +		git init ../child2-origin &&
> +		git -C ../child2-origin commit --allow-empty -m "initial commit" &&
> +
> +		test_must_fail git submodule add ../child2-origin child
> +	)
> +'

The test seems to be about "the other issue".  Shouldn't we also
have a test about "we no longer add redundant configuration entries"?

Thanks.
