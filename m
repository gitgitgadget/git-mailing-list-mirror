Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6C23E334
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011195; cv=none; b=Rwg9zF8BzzixD0Zv88ZCTa5/0+HWBU2y7I/0EB8x4vzGJdJv9yNcRKXe7K/4dvejGbFyoEGlvv7wLr0VlVkIWcSsCL8KpOZ1OTtiTHnIZKkITipZjzvY8ht1xE4BKpVQDBo9RujLGtI8iSvJnatsxEcPcJNiumeM52wbG4BSp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011195; c=relaxed/simple;
	bh=qZ5UV/8jlFd23yCh9eWssqdDSkLTX1Gs1g2+Q1yQiLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2qRdMG+qKBFom55WFr85IHgQHhs5ioZ4jqtnBdz5bPEv4IZWahnWXv6jOoELA8NKlhtJSIrUlzRodYQb4gcyl+p4AsLMAHbXBx/I1J8sMImmr6M0LhloTE9fOIDCKVYz6YwDpeVO05Q1bum1s4ey8MYUb7W8Yg7QQZWYh5Z934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mdmwCclh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/w9D4SL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mdmwCclh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/w9D4SL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6808A7A007D;
	Fri,  9 Jan 2026 21:13:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 09 Jan 2026 21:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768011193; x=1768097593; bh=uqFiZRPh26
	UlAcNlp8JtsX+lcZik+7nnK5lK5nxp4cI=; b=mdmwCclhO4Uk7kUhk1zMBkJhOl
	9OaSYyAYLy2tZau25aAO8gILBARIDuwBr7XzjXhYlvgZ/vllOuWfOYyDuuYejnvS
	2t8svd3wa1rpCEUJm8PZAL+GufvWRMQZHAqfzgF6O/XVL2AoJtDmLoDC2qMbBlTN
	/siQbOyEwPwUHyv/VFs/bSttx3Qn2g1mKl9KI56NwHndbmGR9fV3NTCV504RpkN9
	oM4Rx+lrQMXz/mJcp/lTjtTTroK5uydWmXLznL0aGebadLfIXMnLFZdbwxj5Vgns
	xbAT7NO4Qe29/XvIbydl87IW3WbfKeXv5KFDvF7959yUWfwozVT78OGxerqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768011193; x=1768097593; bh=uqFiZRPh26UlAcNlp8JtsX+lcZik+7nnK5l
	K5nxp4cI=; b=c/w9D4SL3s7diaie3Fdo3izeoEKG17AMmNuIMvxQ+t21dTR4USu
	ATiflnXUBtnwS0bk64Ppf0W++Wu4d8OKVLOEhc5CbRf2A01nL9qciXdsV0nUeupR
	wIKjjMal2wTieB5pmcvsBkyK0m3vEF4JauadQmz7SgisZbAyYhvuazfxP1Q83FRC
	v741ubt2jP+bw9a25xO1z6t+tZgsuaa8xvACBAKihtkrkNDU5zOFdDCk220DHf5p
	b4OpWrL+D9GGMIMvjINjtXH3BewRJoFf3QgH5tv2agy7YRlpz9lk7NbGJDfJ8f/d
	oZTjv5gMZIiyvPoNTlO8Qp0hVbSLZUKgKvw==
X-ME-Sender: <xms:ubVhaRPT3s71eSwzmOTKDbcAEt1vAKFQli2wXXor0k90DHhOb54sgQ>
    <xme:ubVhaa-xNblVPnwsSyMYRvvZOH-DWNEGSMp7kCY4QjlinCTv7q_b3WKueNTfOWvj9
    2OgomBy59MbDOSahATfmo7-6MWYO43LIjQfeiv6dh7MK1G5O0bB>
X-ME-Received: <xmr:ubVhaVTvvRY-qF32ORR9kT-lnaimjWNBGHXdesNnHV0XFEHUPzRyKuZ-S2umrixTvL52WlWH_piz3_JNgj1qgckh3Vi35ZZ_Md1m0WY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtgeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ubVhaclsdKaYTi9haFBKXAZl2LUY0oFeeqW_t6IbaFTKKahz0eWrVA>
    <xmx:ubVhaVQd3L2vwJxIuTdL2s4BWLqynIv2BPKU_uxBDZ28ZcYV8uV_AQ>
    <xmx:ubVhaaNCGMkiPYWZR-t1BfeqVB3Dm0xbT8v8h6WFTnk7Yrqh5COkKw>
    <xmx:ubVhaeXkYbtyaJvlz8VWXpSVZjRimuuapudkUnzhqRmeCHTK9q1Tpw>
    <xmx:ubVhaYwGkmT5oGtmVZ9a44CWUOyQ3QTbo8ZAem26sIzOnUU7fIkZFlzO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 21:13:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v19 2/2] status: show comparison with push remote
 tracking branch
In-Reply-To: <dc8ab23158e5b43cf650f71ef5c2b3a094f54129.1767984037.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 09 Jan 2026
	18:40:37 +0000")
References: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
	<pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
	<dc8ab23158e5b43cf650f71ef5c2b3a094f54129.1767984037.git.gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 18:13:11 -0800
Message-ID: <xmqqbjj2tdu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2285,8 +2352,7 @@ static void format_branch_comparison(struct strbuf *sb,
>  			       "respectively.\n",
>  			   ours + theirs),
>  			branch_name, ours, theirs);
> -		if (show_divergence_advice &&
> -		    advice_enabled(ADVICE_STATUS_HINTS))
> +		if (want_divergence_advice)
>  			strbuf_addstr(sb,
>  				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
>  	}

This is not a new issue introduced by this series, but it is curious
there is "ours + theirs" there #leftoverbits.

It is part of ngetext() aka Q_() call, used this way:

	} else {
		strbuf_addf(sb,
			Q_("Your branch and '%s' have diverged,\n"
			       "and have %d and %d different commit each, "
			       "respectively.\n",
			   "Your branch and '%s' have diverged,\n"
			       "and have %d and %d different commits each, "
			       "respectively.\n",
			   ours + theirs),
			branch_name, ours, theirs);

But in this if/else if/... cascade, we have ruled out cases where
either/both of ours and theirs is 0 already, so ours + theirs has to
be at least two (because each has to be at least one).  Q_() based
on a value that is always plural would always use the latter form
(i.e., "commits").

