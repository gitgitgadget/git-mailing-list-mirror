Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23943306B33
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560585; cv=none; b=ST/iox5gWLiqZgOaaBeK4yUVLUJIam0V06MQD3Jx91IZ9pJDTH5X27clOqsBF9I3Pq+kXs5WMNCc5XOQCuO5AvZzxK0F+zn/dSpxlnzixj60WOnOFF911xpLCUuh4qOKAyf4MKD6/LEwJJmBNwu4Cv24Af9RemOfgNPC9EVJTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560585; c=relaxed/simple;
	bh=F5q8hZmbFaZhHH3D7B5kid9BkMiqWGHXCbSwNdJP734=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AZbgvMcfAYt/ByP1VGWYblNNgm0b/431JLDtsqHLCvxHYxCzeGbKv/HDXLMqeAKaow5fJnetYpX6T9dn+P4b2e50aFmud8Qtfk9mdMAbQPN1J1mvR0D4tEy/h9+syRpPg2EEvji6UfG3/NeCCwli0kBZFjY+vXftkZEGy4c4eE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VzD6IaTY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuCeQDzR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VzD6IaTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuCeQDzR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3208E1400131;
	Wed, 15 Oct 2025 16:36:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 16:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760560582; x=1760646982; bh=aqvREL38aL
	C1Wxi73cWOpk3TOKnxIzXkfSQJUaba74k=; b=VzD6IaTYQR+JjSm9MfTDDUD6Qb
	K9kWIkgxnksppL3AfVmr6GNP2NvNJ2SAAwTjD1lItsFGVndALH+hPQjNEw8/11TG
	Ik/vBeiZOX2A97M6AMpcx7hOu9snPMEyghBt9PhZmQnYHT9STJh9O/rUe3MXC7qW
	9Rf7k4T/pmWQOZhwn21KUwzFz0p/YJxQMw+CZRTOOlVr1eSy7LAYdebsQjcXML9U
	Dw5SMDadZ/L5k4ZrI3uylU2D73O4neuhTLbV3PktbsbFprxHNdeHEs7pRFZpW8cY
	OkdFmDL3I9iXbN0EMrq2BNldIEkx8ymAhKJS8ywQ5BpEnXN4FP2Jgjy0NRyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760560582; x=1760646982; bh=aqvREL38aLC1Wxi73cWOpk3TOKnxIzXkfSQ
	JUaba74k=; b=CuCeQDzRkE+nT5pSSShblmQRMc5F0PyHgFdUH6WT0HtRDyePvvM
	v7W4/LlqCZw5ljdy7ofDbPuJN+kyFEMS3Dq7kywu3x9rwYygsY89z0yvnieEhvCm
	Afw1+78KNjcqBati56/i3IeBVyfUz5BDvejlPJ0paDpCRoKVD5rSjKEGtNkjTeAY
	tCNiyd5terzbAniu+KuB4X/H968/hXJ9K08qFMPXkJuqGSn7smfu0MEQKWYO1lOW
	AJ5vfB42as4pxTpvIEpqcNLiVBKnkHm4vQIStnh5qeiXs9qBVmZVS/jkDUd31P5D
	G+t2NQQJZqXnEA/RWhUy/pz+kXbd6cDEhsg==
X-ME-Sender: <xms:xgXwaGVjpvbdCaqbp7b4V-v1GFWXkgxD75FPXS_-9dL7sLIvBzV95w>
    <xme:xgXwaE0UD7gJPmZOgMum1g6Azy4Po17ASsySgzFdAS7oZWTal6xF_HT33NR5rSvfs
    ur6-vcW1k3ONjwMyyzNPfuDmE9faOkHFryXnMSS4GcMuxw1jICL>
X-ME-Received: <xmr:xgXwaMqu6FJc7F8wJjMcb4pqFSuT2_5Iwbxi62TETrxya7CsDPpL4tSNOxdmUI2NQqXGOBGKo4m-It25eVWqfXE_-2qYxroX5OgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveehteehkeefleelfeeghfeujeehhedufffhueeftdeujeeihfekjeetiedu
    feeinecuffhomhgrihhnpeifihiirghrugiiihhnvghsrdgtohhmpdhkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdr
    thhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehj
    vhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xgXwaDVWAzfObYEVN6Hq45X3ubU3wFHFQIwm-gDCmZ94WM79o2hIdA>
    <xmx:xgXwaPYmcCI8kOmd17lbrQoNBF_3nPVVJi7t0NrAIo4fNIVjfWPa5A>
    <xmx:xgXwaIf61v1WVGTgpx3gJBF64rnLuSauZyOByCuqnvUTZWiKrYvq5w>
    <xmx:xgXwaB1R7LMecQV20ZBbX7YfNmwmMGuZ34It8x7QciKeCBJ8oCFFPA>
    <xmx:xgXwaIp9yvFMTzM9rZJR6tHeMInBcLhjaQUPLXPvVsFvnIiOFUWDsq9b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 16:36:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 0/4] doc: git-pull: clarify DESCRIPTION section
In-Reply-To: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Wed, 15 Oct 2025 13:13:27 +0000")
References: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 13:36:20 -0700
Message-ID: <xmqqms5rucl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I got feedback from 15 Git users on the current git pull man page, using
> this tool: https://text-feedback.wizardzines.com/git-pull.
>
> My goals here are to be clear about the relationship between git pull and
> fetch/merge/rebase etc, make sure users know the current default for git
> pull (--ff-only) since some folks still remember the old default, and to
> help users quickly figure out what command they need to run to
> merge/rebase/squash/etc.
>
> I've taken a pretty aggressive approach because I think it's possible to
> have a pretty short and focused DESCRIPTION section here while keeping the
> most important info. Open to hearing that I've removed too much.
>
> This references the UPSTREAM BRANCHES section from
> https://lore.kernel.org/git/0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com/
> , so if that isn't merged I'll need to revisit the approach here.

Looking good.  I have no more comments on this series at this
moment.

Shall I mark the topic for 'next' now?

Thanks.
