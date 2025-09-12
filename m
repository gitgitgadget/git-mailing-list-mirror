Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A13191C7
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694199; cv=none; b=Egp9ve2JTFUQL3SeAwAuww5dSUxhdgnMrafCcwc8EgsyzXROmi1SffYW0ZTCaDAWqxaAMHpQ/FLSqT4FnyzZbZCEQdf/D2gN+zedIEk1gXb/kBGDfkVbbvvCh1zKsKsTrNeElqwhV7WAl4hkb+0hO99nmUPeAc4GRe18EnUblog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694199; c=relaxed/simple;
	bh=dWxyk7KzKeivPnQzlAOAh85zD6MPFjNRO2NpSsI++hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMkwzSYuY4K91G+56sf3+DWJSac2ki1W79KXfX4kVJgrcazopTF6p0GSsApd/6G/muixx1jv+qZpJzt23UPBv01IF2TJ5cPDrgxUPSRyj6btqI6Z9vqgQIPqyNlZuUmVdbVJ2f+kKID3SL0X0Hnl0y3DVgDq6Egsc6aqSQnwp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RQ5UQn+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/Zy1yzS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RQ5UQn+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/Zy1yzS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 14D7B1D00252;
	Fri, 12 Sep 2025 12:23:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 12 Sep 2025 12:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757694195; x=1757780595; bh=6UxPti7B1p
	DgykMIsL5VnMqSAs4ldxQYELYr7tdpy2Q=; b=RQ5UQn+pEsSxAp9m+2EvBFMLim
	ubJM/HwEhXy3Xbqcz0TgcsaPpEJRWnbaQW3J6Ogh1RxfoWWqNSuDrenP0Q77KpXw
	kI7maaQ5WIul3R2V6MqpFUsVI6pNrR1V9e53xyzXMzDd6DM8R5HVz4zjTXnoaG43
	Y6DtFf4qnTNY+tz1GoxBs2G4BqoOq87lFsZdy1TQflgauQiF1p+25CNRBPBH5GdY
	ObrJ0HpCv949Yk6uNfFpMYMcucBpbvvdFKEUy9tcBQJX8BgOhW9ndiUNPe3JaizQ
	Zz1Cb5XBRbb16qPYOGBznz7G6QVtgW+1tszUWhjlb3kgWrLzJvWpjoRcE52g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757694195; x=1757780595; bh=6UxPti7B1pDgykMIsL5VnMqSAs4ldxQYELY
	r7tdpy2Q=; b=G/Zy1yzSWDHxO3Syqg9mjm+1b80osMmk9DH2cuudjc2HOhcVjaN
	OwD3ATJhDYNPyLMnODpZdjbJftMEXd3KVubfZBnm01Kc6CQbKDjHF03ukRR1HZ8P
	veGb92z9vyvcDIjG5XWWSPzJlG04k3nKF6DwwyOB8S5PLK5d7eJdVnihxfABdbSE
	qE2fLmAKWe31iB6GdkzRHrwALJ5zSE4x4np54dNpjcjznQBbWDrI9RPqtg0J0sps
	l6264gPEpC9TfW7iZ60ADZN0hHGAq9HXUoooYGpEVQ6DCVzmcLVIZIk49+4BRE9y
	okxWYHk+CD6DBplkA1jYGsPh+O9shvznDMQ==
X-ME-Sender: <xms:80jEaA2GE6rk-dbbNn_9tn_3Hh5KlUgY4V6vFMvgQ4LJmIQH-Vrj9Q>
    <xme:80jEaGlUznFWxfroAtPFnoGrErl9ZIKfIdrrC_fDZko-JUNx3iGv_Pldnldcd2F5f
    huOLEUOwnTiknq5HQ>
X-ME-Received: <xmr:80jEaPVwHTmh3GR0KGnSU9PWCoqn4ZEToiNMWSkxMAIjj6juyHps6v_z7HBZo4Vue8IyRA9PnyhAQwCFGD4lUOwmm0IfSjR6F47qsfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:80jEaEvz9pEDWmIdd8ZWDiwwII0C0xQscTdLlqBfhRvb6L7nPLtzkQ>
    <xmx:80jEaKZS21sbRxcXtKwd2cOoC9feMUNzWRcgUQ6_BqvfgaY8fbCfzg>
    <xmx:80jEaLWc5KO8o1fPm2MyzNkysH-Y_1eHiypqXOdBPKfufo_keixoFw>
    <xmx:80jEaHSYbpFcKn3irMRz5VC_jWs2w8HfCNzCHcRah6ZVhlOakHbIrA>
    <xmx:80jEaIEgD0hLaZssXTvNYymVIwvEB8ox7p56iak_FvFFR-MJgjyedaY_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 12:23:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
In-Reply-To: <236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com> (Julia
	Evans's message of "Fri, 12 Sep 2025 10:05:13 -0400")
References: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
	<1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
	<236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
Date: Fri, 12 Sep 2025 09:23:14 -0700
Message-ID: <xmqqy0qjmyh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Do you think that the concept of a "pathspec" is especially useful/powerful
> in the case of `git checkout`?

In a project that organizes its files reasonably cleanly, after
doing a random explory development to reach a good stopping point, a
user would realize that changes to subdirectory X and Y are good but
changes to subdirectory Z are all useless, in which case of course
"git checkout Z" (from the index, if you haven't done 'git add' to
record interim state to the index), or "git checkout HEAD Z" (to get
back to the pristine state) would be especially useful/powerful.

Of course, all the commands that take pathspec gain its benefits
equally well, like "git grep -e pattern ':!not-here/'" to find
pattern from everywhere except somewhere, "git log -p Doc/" to see
changes that touched subset of paths, "git reset Z/" to undo earlier
series of "git add"s only for the specified subset of paths.

If you are trying to find a command that new people are likely to
first benefit from pathspec, I tend to think 'checkout' is not one
of them.  Be it 'reset' or 'checkout', the form with pathspec is
typically used to undo the effect of earlier 'add' with pathspec, so
in that sense, if we want to give a quick tutorial for pathspec to
newbies in the documentation for a single command, 'add' probably is
more appropriate than 'checkout'.
