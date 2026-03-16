Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA144231842
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690095; cv=none; b=ZN793x02y26JG6noxtr1WKSYwFn8fp5ZRrZfGVEdDPWYP+NWuNliQwQq2KWHGhVAxZIV4K1TUW1DEPqMbaPoB6lO4Slwghv+jTxOPIF4+W65SFXyxoWF5CgKA0z0Suqm3yIwYUWFJUINXhObCAo1ibgYliXG1HK1CMVTbMp1fNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690095; c=relaxed/simple;
	bh=VOx9gCWgriCvM9cScEquaTs+UADaSmzkC7iL1iq98OI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0L/2ko3ttt1JISnLAQqmDSCyPyAxAz4du10Rhkx8vMKuy0tPnXLP1va7RMJjCpQMS9ErcDyfid6OAyitqTzTZiwC0ql0nkIi2SBHa2rrSLVkmQ9myuFU1mRKwRcxt3OGetZ6vl80cx+eK8/UPEiQWAZQI7+YirhKXkxJr9XSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XTGPQ0cS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GRsroj5e; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XTGPQ0cS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GRsroj5e"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D21D41D002B3;
	Mon, 16 Mar 2026 15:41:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 16 Mar 2026 15:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773690092; x=1773776492; bh=vx2cdG8UkY
	k+VtF4OgWZzY7vBnD0vFjgPK8HclfsrNg=; b=XTGPQ0cSrkvLHPVZvkpg2EHKe2
	aK8MIDaqXfNmHf9CS7oSRBX5aAaM2CZ7L5z83t+NGO+m9VIDzkOorhXOqVOnuL1a
	Urf3q1nBXWeoYbBFrvBnd5La8xr2ZisiQT9iSrXrB5p8K6o1fePg2ZXdJA9bmjrr
	ofW1k3N7UpNR5VrLR9jMHTjwKEI4CtGeFoxFZhVDkQCqHKG9U0n32fUk1YOVoGRc
	4tcHhAajR+YGVZqlTQNJTcxn/BBBRqE3NRKR52IHecLztKzGMUQCz/imya37+JFT
	SK1tsBJsoa8zRA4v7DVUBOr1jANU2jEjclV2PCNOZH9CMYi5SabBenWTZVtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773690092; x=1773776492; bh=vx2cdG8UkYk+VtF4OgWZzY7vBnD0vFjgPK8
	HclfsrNg=; b=GRsroj5emeSFmzof5KsHdwgbMY5G1/rZ+n3y0iG4gjJZSrDJUzm
	bcgkfQlqKP0vHJiHmJu/qsnM3ksQgU2LYQ1K/a35B7eQ8rorog4tWpEntibRqHRf
	Maz2FsJT3vwkd2giT4c+W7pRMazpuQMC65DgMX72VrQIPx7kZWNypuexh0UCpW9F
	Fl7vCnIeYnS8uT/pLq2pMnSk7VkvUUd4pDe+RTcLZPn1hecSwqav/9jEkqcMl8D0
	YtJ4vJRUctm4h5xKP13l5NSsEnoy8c+nQHI+NrzD7EyE4uTTqBqMeOBgutEL5Vwd
	m6hVwwRJBf4LhyyLeAInkUcpMegSio962xA==
X-ME-Sender: <xms:7Fy4aUS8Z1GgMJjARCUeYdAyD0D-3SyPxcatQSZSHIxhc8a0uek6qw>
    <xme:7Fy4aYonLX5kUZY504HYm_tMTyjzJGtKw9fOUQY0iqQXyWoCHi0Sy4bIqBTn4w9BE
    dLfw5oT9evpboez6kAHk7_fCnk5YbDkVrrFkuOFTdEe3Wrgp_7Zfw>
X-ME-Received: <xmr:7Fy4aaJkCg0ywKyVrT5z3Tbh2i168Nr62wbdL1ZOJLIbBm0sJhiSYa4Y6Gwwmu-N3ilu69N9EEIIxrF5TAjvTUX-qNQKoyEw-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfeelsegsrghrrhhoihhtrdhshhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnhgv
    rhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7Fy4aTqPz6pwBkEOWV0CzX0k2nl42XyZEe752hFhFdXZ95SzqX32GA>
    <xmx:7Fy4aazUm7_yStUz6PEGfXPwOw0apv2nYwRZlqe5z6W8IjpY0m6IpA>
    <xmx:7Fy4afNu-NB5bEtMZzAYezbMIywb0MrjzFnzGmUOpOiE-mO3Ve8B-Q>
    <xmx:7Fy4aX7XsoXFCwekshlFLIykbfC65zEFavAhag8yV73JtSOmQtK94A>
    <xmx:7Fy4adsztVMdF6a3IA33XwEt_tF-vp3wQcxxJQA-_8LS2oDzy-Dq_MiZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 15:41:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 07/10] parseopt: autocorrect mistyped subcommands
In-Reply-To: <SY0P300MB0801E3F75349DFDF98C221F6CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Tue, 17 Mar 2026 00:36:20 +0900")
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801E3F75349DFDF98C221F6CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Mon, 16 Mar 2026 12:41:30 -0700
Message-ID: <xmqqse9zo93p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> Try to autocorrect the mistyped mandatory subcommand before showing an
> error and exiting. Subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL
> are skipped.
>
> Use standard Damerau-Levenshtein distance (weights 1, 1, 1, 1) to
> establish a predictable, mathematically sound baseline.
>
> Scale the allowed edit distance based on input length to prevent
> false positives on short commands, following common practice for
> fuzziness thresholds (e.g., Elasticsearch's AUTO fuzziness):
>   - Length 0-2: 0 edits allowed
>   - Length 3-5: 1 edit allowed
>   - Length 6+:  2 edits allowed

Is there a reason why this needs to differ from the settings for the
typo detection/fixes for main commands?  Would the same reasoning
apply to both, and if not why not?

I would have expected that we would just emulate what we already do
to the main commands, and later with experience with the subcommand
typo detection/fixes, would tweak the parameters either only to the
subcommand part or to the both with justifications.

> +	/*
> +	 * Builtin subcommands are small enough that printing them all via
> +	 * usage_with_options() is sufficient. Therefore, AUTOCORRECT_HINT
> +	 * acts like AUTOCORRECT_NEVER.
> +	 */

Sorry, but I am a bit confused with this reference to "Builtin
subcommands".  Are there subcommands that are not built-in?

