Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C98202F7E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403849; cv=none; b=Mk/jKo+05oxCYt18LOyu+OO1UodG5S0EstKjjS4SB4naSwVliy/yLBerFvYk9sOugAphRgGUYfS1//zLoUuU/LGhMDTIStlatKnHp6ijfLMxNPUkYcIeNJFCpKf4JskWHD71X0yqCNrVTwVGTZvvoeM+9RPyoOvGhfgmL2j/Zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403849; c=relaxed/simple;
	bh=QE1h3Ego5Y1jI3tEfCFWvT4W0KumbZlSga+c8fxQ1Hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4bxCpobYiApOJs7yLIjFbopy2LuGeswpxDbearjjFbFJM30ypTu/YXm+0ttxC7SPGdheYNQxwFT3o8MHQpqCIszcqBMCPdhW87fZ/66y7ZDJU9swQBjSHwccvB2Kz379zBVEYbVl3n4ACIVW/bKxkBBp8AscGYiuX/tsgmOlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a7MuDzFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4+UZYJs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a7MuDzFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4+UZYJs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 061A61400208;
	Mon, 17 Nov 2025 13:24:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 17 Nov 2025 13:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763403847; x=1763490247; bh=LSdMfagBSX
	+IZqk2NspP9Vg9fcGIBsKjSZGZClFhaTw=; b=a7MuDzFvRJ4MFDIcoWmsv8Cqu3
	hMAGqAvQ4esH0AO+RKgsV9Zr3RdDO1zmTNI8bpAzbvw9Xk+hvzHt0Vcz3DbvgEBL
	nCbSOMFbB5pN/35+luGqhci6WW50s1wVZABm3dFOLOTHBmVkA8apSjN3g2heR20i
	L92w+WLc3R27c0uVe94Cut+2yFVn2PvJ9ZtRa1SbnQyE/QKJVSrs9Qj/k1uhbvw6
	hRgQatMRT8YB9IVTsVO42/t39LgxZCOoEsZrAFnpLp1fbNsOYLpv91rjCdZRhUUy
	ym08OQS79aDiCrVi3EytEp+KH0SRSnwJgPprJV65Big6E7L8HOV+CFIjaqKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763403847; x=1763490247; bh=LSdMfagBSX+IZqk2NspP9Vg9fcGIBsKjSZG
	ZClFhaTw=; b=J4+UZYJsvdl+i11ZiON13i7iRdPq1X4FHnbnKe2aaPsiQq+N5b2
	wS+to/vFRrkGQSjG0Z5S3mwukbkbuJb26YJl1bI/GdH9fUADlPBFrzWthRTib7G2
	95zrARk/2RCW+oWiY55Pktn6K6Yws55TMhPp1JK52D790qKmk6yhiwyF/KycZ8zo
	n/Tzu2BvsEWGtJ2JAz8pvBq3b5p6M0p294P8bTWe+4kyFe7SLs0D85B4GIw4E6sM
	v0AVeauu4EbupUUgPduntrsTtjq32AF60s0r2rQSY52naMhptQbPPt65QRKcH/sm
	Y29u6hmkIgjbJozFEmQ8Q4PVeNemQ2MgWEQ==
X-ME-Sender: <xms:RmgbaQ9ouNIIYcsWd44yCQKcx4oSR6Cw6HABZwcXx3iSnW6J9T4Tig>
    <xme:RmgbacYJR01sJDXQJrupHhaCltDuwPnuR4ipZjRbOUhZWSfpN_l9HtHLXQLjHT1iM
    7d1vEH04lsUFOs5lClnSNoJaiE2BjjHypI-LRyYphLLFrgfmNOlqQ>
X-ME-Received: <xmr:Rmgbaf1nUrkk4JbCzIv-68zeTywooFKwqMvtxUwDOeXYLSVSeIl50sEVmKe3LMLcYbZx0-8GEgHXN49cVQqmGV0lQ5TvrOiQ-l-5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhesuggvlhhp
    vghutghhrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RmgbaXYErRjv87-y7iBwiekhbAcY5rcaavHBWuNZVLksqsbRDZWzXw>
    <xmx:RmgbaXK56sr4gPQ140PBGybAi9e4x8CgF3y3kw9qPkeKlURIVyVkLQ>
    <xmx:RmgbaWGA1ajwWD7ub7_WdgEgVfX3tj2n02ly2ca8XU5OppDYm7W2QA>
    <xmx:RmgbaetFszl0w4jWEnO9wkefoCrnUOJbSkhJs_f-vCOCN7JSJMDH6g>
    <xmx:Rmgbac4flb5fKVDc7m83iN6E-beOT8TzuxyjdYMNJ7deIGWmnh0Zasjo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 13:24:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v6 0/2] blame: make diff algorithm configurable
In-Reply-To: <pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com> (Antonin
	Delpeuch via GitGitGadget's message of "Mon, 17 Nov 2025 08:04:30
	+0000")
References: <pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
	<pull.2075.v6.git.git.1763366672.gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 10:24:05 -0800
Message-ID: <xmqqtsysikl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v5:
>
>  * add back /* clear out previous settings */ comments
>  * remove whitespace in bash output redirection
>
> Antonin Delpeuch (2):
>   xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
>   blame: make diff algorithm configurable

Will queue.  Thanks!
