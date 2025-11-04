Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0D79EA
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223184; cv=none; b=ToMNmFbkl4Zj4Bv74SPZTVP/6O046Enrrf4D9cwJy2jWefuvfJ7TyDDbOgMhzBHlWnyhZhIqaYv4adLVpdp2oSXZIL+3f0zhnoTkk5FtLyMvFYLBXNgN2PB4GGs20lwcolhDKrPWpfzHRHlH0WJywEnNrCUnQe1zhcFKebIKRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223184; c=relaxed/simple;
	bh=JvOib+/cKNGOwYPqPzu5+fpAeCYx6oIsA9gYwr5YZNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BsvIDxjKfDy7SP3JlGH4m7U4YWKRoVfY8Xnsra0BRT6SdLRKODJorDqDnw1Nb3slg6K6ldeJaUq5kp0WAQU99GMwmkH93KLurwBh+Fvsbi6NLKcPDqySPdUqp1XcBetDumMWY7/ywCLZmx1wpWIEQFpVovrdbIQmRy+C9O82R3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f0Cdo3lJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWOvToia; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f0Cdo3lJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWOvToia"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E3DA1D0016B;
	Mon,  3 Nov 2025 21:26:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 03 Nov 2025 21:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762223182; x=1762309582; bh=WthkCnd2GZ
	VwL/dW/AQQyqqU7bvM+EmhkB/E0bLS3kg=; b=f0Cdo3lJwQ9muvqOanQpTU5yM9
	MIljnjBE5/ZoKonXtw80GIkwgYIn2PpZoOkLM9/FJaC+TzuiWKfPpL+Qw/zMWX+j
	r9m8PvVkr5K0gZlGVAhH0e2PV7aA03c7aaUUOxmnyNcfVTr0nVHTU50+JuR+P/KG
	AwJ+jBJSeGl9beDrM1xZEXdsjFBwmARryURT/P+pyl25RH4lQB/blA3KmYohoROB
	QummAH04CG35O2aNP6cCH4q71gxmVCmgC3hO/msaNaXtRr4Rtm344YxJlWsi95X4
	IeV2Ansi7ZW/kGUaWcGxVMvnX19Rst8pWmT6wlNnYuPLbOjH3QX4Igr2iwzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762223182; x=1762309582; bh=WthkCnd2GZVwL/dW/AQQyqqU7bvM+EmhkB/
	E0bLS3kg=; b=TWOvToia0PLrETT/YqJ6qLcjlWeswZyDdUUMyhYV465zLJ2zTc5
	wFQoJT4itO6/GwTv+M1vEMPpF3C4z4C9mu1r/Zg9UJxg33ET6+UEyw4HT4/vC1kt
	IJlb2NrBT0PDaQE6Nn0/OXNQAQziAJlj7BDsMBr0wl0Vd3OKdYEDHy87Qok1LfMH
	yx1liqhjjFHyvmaRVRmZvIZGpv4hjxknAMxJxi7eDjGZReebLrl1YcYNlDIEXuXa
	8MIB7eMhzgvbv/L/d3tjbe58TThXl4R6iQXicZne7ExOm2r5TnhmpaLA8Q/bgZw0
	zGaWJ4K4MFx08yrZFkURMaStpAAO+3NfAlA==
X-ME-Sender: <xms:TmQJadn8i95uUj-xc6vuhN81kju-P-07KIyA1-c_XP_eBrgqAwbMOQ>
    <xme:TmQJaTasuzooRRq8HrjDYqjgMolNIfEr1yIw4T3Awg3tn1_2Blz41-CM6V-e3gwe-
    Ix9QCGuvXQwcg-HzsUU56M92vdXlELPcF0nz05X4IqH3k2-0dpbQQ>
X-ME-Received: <xmr:TmQJaQPliA1NweDaBz09ozc-IDPQf4_vjg75oWeDtOLIkpvmegnKb1lC2YWdSiT8YbvfabaSR8Lp-jhtlEZBwfzqad3k-9x7p9D9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:TmQJaQZqDyeWVD0cGvVtz6IHUsmJa-yftZXGIUqg4EH2M2BDf8YWLA>
    <xmx:TmQJaW3W77pDBIkiZc32qUu9Yaub3o_ccIGmWrTO64bF-6SX8OKWBg>
    <xmx:TmQJaedNK83u7BfQ1TCD0N4ZHmq9a42oOC13gzXxJ4Yccit4ga4VVw>
    <xmx:TmQJafGbjoErYYIYGO253hfPQjU7cAzEYDgJ7TpmsjqZDAadv-H7zA>
    <xmx:TmQJaY1UJEEF1SLOutwVIEylelQZ2jL23pQ5cRAJEqT_Sbzfv16jSb2Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:26:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
In-Reply-To: <20251104021455.379807-1-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 3 Nov 2025 20:14:55 -0600")
References: <20251104021455.379807-1-jltobler@gmail.com>
Date: Mon, 03 Nov 2025 18:26:20 -0800
Message-ID: <xmqqa512sfcj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> I have a usecase where I would like to know exactly which files in a
> diff pair are considered binary by Git when computing diffs. When
> computing patch diff output, Git already omits filepair diffs where at
> least one side is considered binary and prints a "binary files differ"
> message instead. From this message we cannot discern exactly which files
> were considered binary by Git though.

I have a usecase where I would like to know exactly which side of a
diff filepair ends in an incomplete line in a concise format.

Should we add yet another column to the raw output to indicate who
is complete and who is incomplete?

Where does it lead us and when will it stop?

IOW, yuck ;-).

> In this patch, the raw diff format is extended with a
> `--report-binary-files` option to explicitly specify which files in the
> diff pair were considered binary. The output in this form looks
> something like this:
>
>         $ git diff-tree --abbrev=8 --report-binary-files HEAD~ HEAD
>         :100644 100644 a1961526 e231acb1 bt M	foo
>         :100644 100644 31eedd5c 402a70d7 bb M	bar
>
> With this format, there is a new column before the status that specifies
> the binary status for each file. 'b' indicates binary and 't' is used
> otherwise.

How will would this extend beyond 2-way diffs, I wonder.  
Should 

    $ git show -c --report-binary <a merge>

show [bt]{3} instead of [bt]{2} before the change status letter?
