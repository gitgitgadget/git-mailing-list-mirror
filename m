Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED81EB5DD
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812239; cv=none; b=CtZNb4TRZ17VZEP4T4KGtuAaCPrbnbd14RTB9h1v0RqADPFlZcE6rfT4byey1A8PKMN0pZL8LmDASxpQxefMZxqZjU8noglxjQnWBePioaaHluqT1yPhd8fLBWw99orK31oLLFr4jfaX5mDJB5ts/izA8APmXa10LFLireEajnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812239; c=relaxed/simple;
	bh=Rbq6ji8CJRa2C6i+A/HYhXYYIVf6k4vApqPwPX5+RwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N58NOtZxQPZ90EnRSyGHb68zukX3TPBXxi7BOpzwAI3+YEkA7zni2eDTUym8RzkbdLFsMZNmni6FltyC2DrzxdTVRwaHnWL12nt5NJbbMMvHI1WenDVk0IJM9KHQVQlpx0UxVkRncSqER5Voz8TmeIuntHed/m56S98cnLqqz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eTd3uIq8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqEVPtJQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eTd3uIq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqEVPtJQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A46B114011F;
	Wed, 12 Mar 2025 16:43:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Mar 2025 16:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741812236; x=1741898636; bh=mOYOy2qBcz
	Ze63BdMNKy0yJyrh0YMtWbRoi6WuXVH1c=; b=eTd3uIq893v0kOVbUOYwYcX8C4
	C7WJaL5iCud4N7/pa3A/7izMUu2x/Np3t0GI26JeJilLuOZOm5tx/hhnQLnmydGV
	95DcwGQFWjejrpF1mhzw2yZmj6i+j+phsSN09BaaR0tmmCllfy4Vn67ECoIfwvPn
	GmedUbpIZKnlCeQFS4zoCYOPerLxnaIZb3t7hvTlliFifRw3YkfGJUHdqlYBki1S
	h+M7TS1TxNYM842UTxQdhc3W41MlCkdta/DfJcjkcNZ8YcSujPimHJolPSf+l6sV
	geLIWGmg3zJwzruYQ8dZ1uujvdpmtNczViP1SihTGKnqXKs4/DkGMznqTH0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741812236; x=1741898636; bh=mOYOy2qBczZe63BdMNKy0yJyrh0YMtWbRoi
	6WuXVH1c=; b=TqEVPtJQB6e0+FF93BnkGWiydDbzcfS9SJhLOlQ0/j5bzvZOJTD
	k16GjZlkvizUv35bzID3aN0AP4LimBFQoHHm47NHEMfYPhTNgGBoYAhdyohqMW/s
	OIXW5CsWS45s9pqBg4VWpH2n581g1kEMUSZoZLgXk/ATRwLWr5hbKqODM97qLWkW
	mlmJYziRnPhJGs6a4ULgaLESeMNchv3GZ8hC/aB+otVQmknwnAxX2Hjce3HPk+Gc
	SJucuXo04Slv+4/kDEqRpUzsXHYNSkDT8vyjzgWdWMIeTGrUSy2Lmpsb3HI72Ggu
	boYrwRbZrGjippalcSLtWtkGT814Vc7PCiA==
X-ME-Sender: <xms:DPLRZ-tQxLrhFZS6gl_sxs0_ialJi4oM5lR_shJXn-5LX0A33OBbCw>
    <xme:DPLRZzey45CcNINpoyNRv_lmBIck1t-id6cH0HH2nP_j67oyihz9PPUJVvjkk41lz
    XkRL-BmYF3-f1Bg_g>
X-ME-Received: <xmr:DPLRZ5yjJDfc4JyOIJOeUD49T-PCHbk26eb1Af5gL77w6XYb-sOcZmjPx5vgJWyc_iTF8ALzf9NlZpIM9sjB0WLiTiHLO4XZlIZx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DPLRZ5M9S8YHq-Y7H-4h6jAX-rkMa8nrIvjNVc6CP39omLVYDp9FOw>
    <xmx:DPLRZ-8NI4EcVCqiIqTAqwIMvgSz7YMwGrcO3DJbRqj7Icsiifa5NA>
    <xmx:DPLRZxVFrBXhVlRnmPbZ64nbdToCaDEXEOD1JN1TH9nfGCs2NwRfGA>
    <xmx:DPLRZ3fZY1gjHwBzWXh2es12Bu8EJFgiUtoCoc4IS9x_vkFFbN0YIw>
    <xmx:DPLRZ-zGY2qMLtWU9WRBCy29evUaxJyvWIeJpmsnwO1gkFFQaVFTMoYN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 16:43:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
In-Reply-To: <CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
	(Elijah Newren's message of "Wed, 12 Mar 2025 12:13:10 -0700")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com>
	<f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
	<xmqqikof2pqp.fsf@gitster.g> <Z9Gmo2P3Fnt3JeOs@nand.local>
	<xmqqjz8uxfyq.fsf@gitster.g> <Z9HaYEyYgBYTiia3@nand.local>
	<CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
Date: Wed, 12 Mar 2025 13:43:54 -0700
Message-ID: <xmqq5xkex9md.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Would it make sense to break the assumption that --max-cruft-size ==
> --max-pack-size and perhaps rename the former?  I think the problem is
> that the two imply different things (one is a minimum, the other a
> maximum), and thus really should be different values.  E.g.
> --combine-cruft-below-size that is set to e.g. half of
> --max-pack-size, and then you can continue combining cruft packs
> together until they do go above the cruft threshold, while avoiding
> actually exceeding the pack size threshold?

With below-size and max-size set to say 180 and 200 respectively, an
attempt to combine the crufts may end up filling a cruft pack to 170
but the smallest of the remaining cruft may weigh 40, which means
including it would cause the max-size to be exceeded.  In such a
scenario, there may not be a solution to satisfy given constraints,
i.e. go above the below-size without stay below the max-size.

So I am not sure if the approach would really solve much.

Other than that a separate names, especially losing "max" from the
threshold that really does not mean "max", would solve the confusion
that comes from naming, that is.

