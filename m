Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE82772D
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250768; cv=none; b=kfxrLahy6GBAN2kyqAoj7xDhJs1mJSVUaU5VOODchtb2C9SeNmpwhZc7iEpnCNmzJiKUzgKjenVR3cOv5ADvOblGLrLoYHH7sHGU0LOtaM1gdQ+3srIEsLBaOhny4EWZFR9ee3+tMRKDlkI00u6fXez5D7qPAdLDZcqACmvx6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250768; c=relaxed/simple;
	bh=xuCtdN2ICYQV0W5cWc0X9UKDR2VAhSd1Yp9u+qf+Bqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XjP8oqwvWFsSKxmoUP7R0Uox9+ck19OEQzKr4DtPXmXyOLNqhwwElPkbd1z09cBZM1A8EaB+mB4WRWmL+q08exAJK0LKTdDkd/5zRsjWwNQpjZAKKV48ZyO+OoGKR4k1S7CnwGgobipyH7B1TSCdLnmazfFfyury0zJlHVYcFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=onB29u5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sHb6HKpH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="onB29u5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sHb6HKpH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C88E51D00159;
	Mon, 12 Jan 2026 15:46:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 15:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768250766; x=1768337166; bh=bLwyA3eSPy
	7yIvUe7+uxHyKIgVoGJDl77ngHnd9AcEI=; b=onB29u5S6jzY3vsMQr1LaPrnJr
	UeAmrUpVqg02tKBWijbrPmFITGrxtIdr4tWzco2Yz6LYNhiDGu1h+b0lDd4Mm6y/
	D4qhnpygttBJ6qBsiR3Q9U1BdRJb4AJFzjPv99ZJP/pjz9wr40Xvx/lfa+zVO37K
	xSuO43LQTQnXxodyW5H8QnfkIm8ub9SVUpBJr8wpqHzSLh2UujK72KugCkM5s29l
	ZU7+y2jhden50tI+saiNeZVJXntBWpb50tSXKjRC+WY9FtY9PILgfYn2bYw72J3J
	nmy0sAMeq/BxCRs9lLtdsXzcsqcYwTW0RuvHPgaLovrVVrtPVOlDQKi1GtBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768250766; x=1768337166; bh=bLwyA3eSPy7yIvUe7+uxHyKIgVoGJDl77ng
	Hnd9AcEI=; b=sHb6HKpHEbjsYT32vNErLB85mR+O6vSaPCWO0ndyY2+ztUTcZ8e
	XOruRB6o0ggAZe9xxOnakRqIyRu1mfvQFm1v9J9s8KZgt0PRL0GCwJ5zeoCRONdm
	Tx/n8FW44L5Wz2D1HisQGfL8P1CbQbnJwgp4GdyRbJLvoUFxB6LOKY1E5IB1eBgL
	MpuPWR8Ci4THVinMZOwZH7TL1Rk8Ac1DvB4rAE93cyjQNFSLhpIXdmny/0b3Y+CE
	s312jGdIYamahixPScTssPMlFsWVNaKHuThyACrA7QTD/IdGNedSk+anxKDb3PIe
	TUSMj/9kGLhO3GC8+T86Y79kYuQMBs3Mp7g==
X-ME-Sender: <xms:jl1laQPY766-3yGST_ZMl2OmeSd49ZcCcXedKxYKjMXjSSdSIm1k2A>
    <xme:jl1lad9rJBgmJYPqm3QFNvJgMEsqdnAl8mK5gda21qwQs_aOhFE34BLquiSxobD3S
    1AJmayTN-7dYLVsLd6xE3RauDmVKB7mptZozyPVzDKSqPff_GORr-c>
X-ME-Received: <xmr:jl1lacRV6kGjW1HziYGTvCb_wsz0845pii8F4rYAUvGPH6xj_BaV_Vp8w5BhsJQ8brW8tn5dANpTs1Fu9X26pjhIHNvJ6PnQacxZDwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jl1laXmqpHu-WzrZ51G5pya97g3ULfUAdEdAqrqNYG-KkF-jAph2ig>
    <xmx:jl1laUSBEln-bcjMH-KwLXCrl1Im_pzbLIcAZtofMYQ_wPh_k0f2jQ>
    <xmx:jl1ladNvSv6yKosNJflUV2NLYAvUj6923zkajl6WS-1TIr2N1YyxWw>
    <xmx:jl1laVVCmL4ujPGC5kB-xxD0o85SN1PDa8DCARGIm9JCpMTB89zJGw>
    <xmx:jl1lafzYZFAd4LA0kSZFuyOwg4H9vQKSvHfERUTeFylD2O48_F5WPAhD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 15:46:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v23 2/2] status: show comparison with push remote
 tracking branch
In-Reply-To: <f1ad7a1b6f7239c5f52a9a74721f340cb35d0b36.1768249586.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 12 Jan 2026
	20:26:26 +0000")
References: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
	<pull.2138.v23.git.git.1768249586.gitgitgadget@gmail.com>
	<f1ad7a1b6f7239c5f52a9a74721f340cb35d0b36.1768249586.git.gitgitgadget@gmail.com>
Date: Mon, 12 Jan 2026 12:46:05 -0800
Message-ID: <xmqqv7h6lfua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	bool want_push_advice = (flags & BRANCH_MODE_PUSH) &&
> +		advice_enabled(ADVICE_STATUS_HINTS);
> +	bool want_pull_advice = (flags & BRANCH_MODE_PULL) &&
> +		advice_enabled(ADVICE_STATUS_HINTS);
> +	bool want_divergence_advice = show_divergence_advice &&
> +		advice_enabled(ADVICE_STATUS_HINTS);

Just an observation, and not an objection, but it looks curious why
the last one is so different from the other two.  IOW, the above
makes me wonder if it makes sense to roll the show_divergence_advice
bit into the base_branch_modes flag word.

Other than that, this round is a pleasant read.  Thanks.
