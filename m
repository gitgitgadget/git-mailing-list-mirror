Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70626A085
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215740; cv=none; b=FyjJg3n//B0ZM97u3ZKI2hZmjhl1noEwjJdpbUjzi1hJOnYaAY1nM1CyR3yPaG2rZuaXxRjlLlJOlycr4XrDRG/1mYIcxNqygsCfZBY9pyGfcTShY1muR/OAONYVdO0JiNoXb4qLVGCmDKUWbF/TFRqpivJBJ7DTrQRxbYLZw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215740; c=relaxed/simple;
	bh=I1Qqlv2mYFe46wYApHEvjnvoFRXL8juYM2n93MjOEuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTMSY9cBBswQ8RrdwgBJYiB2lnndrxPuV8HT62CWjTNZKjGlXV47srWA/5N5qwAxxHqWsNajMxZrAtuhai+F41t2Be/DjcraGf6qsAk4b6Zu4pw41d3jY3OflJlfoCjZDhqQhMBwY+CSQ08bNvxr/XXCChm6PA+TKP51uQyNNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dET4i7bj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IWT7s4eP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dET4i7bj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IWT7s4eP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 59E552540175;
	Wed,  9 Apr 2025 12:22:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 09 Apr 2025 12:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744215737;
	 x=1744302137; bh=I1Qqlv2mYFe46wYApHEvjnvoFRXL8juYM2n93MjOEuo=; b=
	dET4i7bjPPkHelM9NxzSRqSPODWRZ7iJpRz1KijmjcY8G6VzkrONhbsTeaolBR2u
	CjLOkP3yGkQfy2o4/CTRhATAu7qFbhbF/w1NoSFoh0uHjCG4iEKLCEuJ+73ncupr
	5Y22++Lu/tRow0pdnG7BFwuAPJwbJju+VlCdw16gN7RtypBlEJJs47P7ITYNu3jS
	II8RKeXoQwtXsWQsYEdn2dvg2H2LMTz0Jykd7foupK0xn1p4voqO2MSw6rKcamR7
	H/bWs48pRiHkRE3trxigIdKnrNFsPKaaLBu3w1wSVFLKSS24KFCF/zauqwp2cK+3
	yRqdsizf20rMqe/3v6ghEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744215737; x=
	1744302137; bh=I1Qqlv2mYFe46wYApHEvjnvoFRXL8juYM2n93MjOEuo=; b=I
	WT7s4ePNOOB3SRYgFj1SnSFHiDeG1I3YDvpbAkS3qfI8ZcgnaR9g/p70Ok6NbjdQ
	P28irLaPnOQV5FKXBkFltB77Dghc5WbRFK4GrglIWtAkAGFgdWRjwQya19R/UKKh
	sOvBJAJ9JpdL1e4RWKNE/dUr1JwPjYaEqyPim5WM7DIBa6sMBYplPDSJkRmQBf4p
	p6hpFGDHY44PN9GukGIFSRS1oiRPEwaeef4Tq5Gn2hS6XbBjFYjEB8KTvPExcXTD
	LLzMiyYdF6IQNt7GQFLj3q29bm/mz1EZODJHKPW+1Lue0aYiPp1b35uAf/x8FVsL
	UXZhnWbhyn9d26M4RTFxg==
X-ME-Sender: <xms:uJ72Z_OKcQmtmzpT1xCBVi0n5zpi31uli1daJLYV5jVAzmsPP0d4ew>
    <xme:uJ72Z5-XKCKKae5gFVJrtqDPPzG55o_6CanYYUJkJRlSLcqpzkSrRfh23FMfvPavE
    tRj9L3Q_w_untMgiQ>
X-ME-Received: <xmr:uJ72Z-TAdaMGcg6NZsuEkfJ3PvcpMgOaPdMYB3_BkKyO4I97_7juTOXDtbgj1UPR4YeDbmtNHw8qVebqGR5bTkOVv8oaAt5ellxS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinh
    drrghgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghhrhhishhtihgrnhesjhhohhhnshgvnhdrnhhopdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uJ72ZztlgzOCZXTtrQ_iopfsDYfywx8BPeXDOMyBQqQ7fvJYKgxwqw>
    <xmx:uJ72Z3fgjLQmx0gEcC5Uk9mXhzmt4l72-503NrsBUp5ys8X-71u6Tg>
    <xmx:uJ72Z_0YQRKmTFtsQT5Xal4obHDY0xUCkm2eKQfu_ixniFIKqWV8Qg>
    <xmx:uJ72Zz-DBCQBMb-UL7-igSEi-DeXjd68Oo5GK0Ll8gpxtFLfRjw5fw>
    <xmx:uZ72Z-qBG0YrQ-ggO7CCXEm0eB8QOGjxDzn-Rz9fNfnYXD5ri_izV8bu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 12:22:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: Christian Fredrik Johnsen via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Fredrik Johnsen <christian@johnsen.no>
Subject: Re: [PATCH v2] refs: fix duplicated word in comment
In-Reply-To: <CAN0heSoh4SuQcYHVVniO1BYH_C4O-BeF4kKxDg3uQPzpotLA1A@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 7 Apr 2025 20:43:20
 +0200")
References: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com>
	<pull.1940.v2.git.git.1743857867327.gitgitgadget@gmail.com>
	<CAN0heSoh4SuQcYHVVniO1BYH_C4O-BeF4kKxDg3uQPzpotLA1A@mail.gmail.com>
Date: Wed, 09 Apr 2025 09:22:14 -0700
Message-ID: <xmqqbjt5s3t5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Ågren <martin.agren@gmail.com> writes:

> Ok. In general, there's some trade-off to be made between "make a small change
> at the top of a twenty-line comment and rewrap the whole thing causing more
> churn than necessary and create more room for conflicts with other topics" and
> "make the change and live with slightly less beautiful wrapping".

Nice to see this choice spelled out.

> In this
> particular case, the blast radius is small. `git show --word-diff` confirms
> that you simply removed the duplicate word and moved "common" (or "*").
>
> FWIW, this patch looks good to me.
>
> Martin

Thanks, both.
Will queue.
