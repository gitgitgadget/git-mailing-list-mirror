Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC81096F
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140257; cv=none; b=H3zKBrqqxAisGyblQXzKh1Syg6mIGH2eVnKO5AnTZoN4lROwLuVMPkFv2LJhT9OaHkJySvLm3BQ/2RbkVUD60lBLk8Y32334CrRVMDEtuGjCvuZoPbTvOpRoKlQC4hSjY6ewPuOdU6YJ/SBVtnxucEfrEvd/HWeL0rOpmXWZSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140257; c=relaxed/simple;
	bh=/B+82h7Chg5Q/EelRLHvKgX84aZcAa5t4uo0uIiypsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T899j7Jki0gwtQFsU9at6GmOqhPz0ol0KexfsQ8iiAKsISoFiIMVIanwNTbA7aosQG5AsGUe3DglaDcLdr1QwKrAcZRAuuUlEfEWmBieqVBAMEwhzciw6NQoV/RCNUNBDtrlIF0sVcE7ZK+q6aoRBvru5Gh1OtbnZYd3wceqG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NJKuOxum; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0hjCzFYy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NJKuOxum";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0hjCzFYy"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDBC725401B4;
	Tue,  4 Mar 2025 21:04:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 04 Mar 2025 21:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741140253; x=1741226653; bh=/B+82h7Chg
	5Q/EelRLHvKgX84aZcAa5t4uo0uIiypsg=; b=NJKuOxumAbfYwIWDUQKF8WjyxL
	10+ro4e3LBrBUrZF0K6H49DLLqBUxhOoUVYYebMAdpxdwP1qfhi2NyNw0Gh50a95
	CoxjEXXFkTQk0zmafCZbUFHUO05k4siITrAqK1RcH4E2EOfED2O9xPp8SmYhyA/D
	qvhrSZ9bYesfCQ5saxhaDeEEPmnFWcTTJ6FIQOuNRvm1uebts+aqvJJFVFGXcChc
	Rcyi8eCp02uPE6n3o9UMinDaV8/txC4hr3YBGKxBaX/+SEKxJnSQLGtDkbZ44wL9
	nyGLnCNEZ5vWfDpE3ouHN2stE+Lz2rMXbdl60mfvehhw8V/EZ/YCmCRlxXpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741140253; x=1741226653; bh=/B+82h7Chg5Q/EelRLHvKgX84aZcAa5t4uo
	0uIiypsg=; b=0hjCzFYyoDKBabdGFCdKWAuZs3sdMZXi/dMD2wdp2yoHm5U58O4
	MuPTEcVdpzcyNGrgIpwTeDRhM8+1LdExh45EYmkXhubscPK2e4mUmX7vpwG7Xq+O
	AfapSAcznVzYndcplDulwpZt9osOQVhVkYzLjEyyxLygpz5x8YzXBxrWKMGxGeez
	0BX/Bz9S0xu5xrsLQEW5JPkqLRIEgO1VPUalA9XyRQPfUNZfPQCCRHpwzkNFx2Ji
	c1n8NtlhC1mKS+fvphyEpC0saQc1bvp6FS1r9M0bsrX7+RbVDhmSs2rAObAGa7lq
	hGqhrZnoKnkwxMwzFWFvfqq1X+ZmMX7EZWw==
X-ME-Sender: <xms:HbHHZ8GpL0PDAPGrUnwnMRS7J3XLBTMsCzvpYePxJd_1jj0-l_HpWA>
    <xme:HbHHZ1XJsJFY0SFlsTapX3z8xtktyikqTMGflLBAYMDZZpUZ8Et3tO1UDRrKivJre
    mkqJN2cKeU6DNTt2g>
X-ME-Received: <xmr:HbHHZ2Jv5CTCw5Mit1PuVe1ZxIXMDmIP0nKp5GfUA0UXQlZZhwMTUa8KCNvNFN6btPuDKDb95_LCy9Ef8YhCxXiYk40MON36AcIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HbHHZ-HkkODkuATGMiRnC0jFUs4FfMsHmh04yOPaRL-TOaorbNRnaw>
    <xmx:HbHHZyVeAyWkz9Cp4sXWP4GAFVltb151nX-YsR_28IHyit4HUzc3oQ>
    <xmx:HbHHZxPwBio7Eaff3c8Yh6ZeCHknNNSK7HssOIRB1DtnOdIveek9sg>
    <xmx:HbHHZ53bxl60c0eSZnfvOO34sJLsoUKDG5Td7Ef4XmmbrJYfMVP7Yg>
    <xmx:HbHHZ0IBT2VKFGeq6xVjVBSQIPBISYkavpBc6jVs1CwwYCmi74TS730c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 21:04:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
In-Reply-To: <CABPp-BGnbQdeSC=XUwTWOnr8=PiGMnt1Q0OXkUAzD=ZiaZoUhw@mail.gmail.com>
	(Elijah Newren's message of "Tue, 4 Mar 2025 13:52:58 -0800")
References: <cover.1740680964.git.me@ttaylorr.com>
	<8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
	<Z8FrIfAj_oVwxz3X@pks.im>
	<CABPp-BGnbQdeSC=XUwTWOnr8=PiGMnt1Q0OXkUAzD=ZiaZoUhw@mail.gmail.com>
Date: Tue, 04 Mar 2025 18:04:11 -0800
Message-ID: <xmqqsensmdwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> Hm. So the result would be a new set of packfiles where each of them is
>> smaller than the threshold, right?
>
> Are you assuming there's only one threshold, or that --max-pack-size
> == --max-cruft-size?
>
> I read this assuming --max-pack-size >> --max-cruft-size, so the odds
> that the N packs smaller than --max-cruft-size add up to more than
> --max-pack-size is small -- but even if it does happen, it just
> results in the cruft packs being split out into a couple packs.

Interesting observation ;-)
