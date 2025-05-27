Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE92798F2
	for <git@vger.kernel.org>; Tue, 27 May 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359136; cv=none; b=BrKOWVWE+5X4ZhPvGKUSDQTqbB6SOShBZIVdrw6064FxfPtTdlHxCXkKTL90vdkPLfhZVv9PDfGtIvmdXYbkn/AQ4UR+r1x32z67gp2ajpaAx5RTPfNwYhT9HacM8zfeRchFMffqEH1PuFLMHM93GcK9lBB1xzlhY1/YbKkIU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359136; c=relaxed/simple;
	bh=hkWbXpc+4UM3HqveDQzCGmgv8lOb8wlsi/jaY7akuHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1R6LTRsran68xCtuVuImcuZ+KEO7etPdXcOP3ESgG1r44+3MpV8dYzwdLvXWQ5axrJt9ENeB9yV4jS3+Tdz30ggamPaKU5gf14MV3pMACQ7ug4CWO0FGU9ubj5qv/+f7f3/Rdz1ihNAaqInPdpk9prElA9EV1HV0Ao8ZqdOOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YAvhf2vo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bj1aesld; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YAvhf2vo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bj1aesld"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 333D311400B8;
	Tue, 27 May 2025 11:18:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 11:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748359132; x=1748445532; bh=hkWbXpc+4U
	M3HqveDQzCGmgv8lOb8wlsi/jaY7akuHo=; b=YAvhf2voO3M0BgGSgo3yfys8Xh
	tJ5WLjHof7dUIDT9y+OWkklWWzHRenXBKGXa0+u+2uo4Om6392XpltSlUfB4Zc05
	bRcnmdQ8hUJsNogaiqbOKn7lQQ66R7/GCD66k66IUmQ5Lm4BxJ0CQcKKW2ERyBBM
	AzV4n5NyO5TmSywTK5PtUAjm8QirlgCfoyVZyQY8pVl7PbQWzUScKLTjezZVFR48
	tZ3MLzW7YilNO8HTi4OOtF24T1NH3NEYWmwsRzXnR/zSJOWGWnCbIgFYrYiiqZ1G
	nsj2qjL1YVSuvUX/eU0SjqWWd8iu9UjP7vUeySmIpVYK2IT8MRySqZ0z8ArA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748359132; x=1748445532; bh=hkWbXpc+4UM3HqveDQzCGmgv8lOb8wlsi/j
	aY7akuHo=; b=bj1aesldibzZKYB8bkqdZce2ZTdkZUhYUlxi1BuzV1aYiUXlmmY
	UmXw0Aa9zOMkD6sHQ5OxUgrq43ADjMPeUfybQpR6g0ciEfUIB5cof1FD7wkVv4o1
	152G5DyNKNGao7ELyAHDXfVv8MZ0SK4eRpbMPUvq8DL9Us4y7YhxQDBnGpHCn5Il
	n8IgNEhI0E85QtWG1C1IF2YmT9pKrQeCYix+gha7bP/lHP9sc5/lphGP+mtJ8jxM
	xd/bSHwdSpt4fiYCrdzcgNvwwfgR/9vIp6Uuacm8/X0gLMqG0LoqBTwo3vz8EV7j
	g9Foz/eG1jCpfq7cmoLyKcpE53Krrdr1+UA==
X-ME-Sender: <xms:29c1aIm-mHAvN0_JDEZzFLN0XSEFOAh8-sGzW4x4ky2hZ58PJvMs1w>
    <xme:29c1aH1SeujxltIxchlOnWzkRcqz02Hblpqpd4i9gqE8avc0S4oa7vxHEe7NrPzLy
    R1RbUWSabqxr3vHOg>
X-ME-Received: <xmr:29c1aGrFzUr0lidI1UJfuzR4qsgzdLLTOG067PzYcsc7xjVhXqkCYFAnN7BpryXgsh6fGocNOS4ri5XcB6AGZaWdP8VwthZutnpzy7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdejvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:29c1aEm2ledDaaPZAHW1DGKZeSLwpYp3TBn3MbQjXopVjGgrBYH_AQ>
    <xmx:29c1aG33E7KMgYKtAhbA8xBCzLhhO7_pjJER5ZEDNjuHdQY--OHUuw>
    <xmx:29c1aLvjLuLrk1jPwCo6lfZJ_-dJKP_YbYthwURAbHSqE4I7IU7BHA>
    <xmx:29c1aCWKkvuzLTU_Pe7BRrTXkxCj0FYWQgmapCH3IP7U5Ra0fvUG7A>
    <xmx:3Nc1aESgcXBhkG4zoz5eAokqCEVnavUGd2yAOxDjzaAMtwsHtCyMqamE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 11:18:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
	(Christian Couder's message of "Mon, 26 May 2025 12:35:49 +0200")
References: <20250424203904.909777-1-christian.couder@gmail.com>
	<xmqqselxtfyf.fsf@gitster.g>
	<CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
	<xmqq1pthtbdg.fsf@gitster.g>
	<CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
Date: Tue, 27 May 2025 08:18:49 -0700
Message-ID: <xmqqzfeyqdye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> I agree that we should have at least said in big letters that the
> improved support for signed commits in fast-export/import is very
> experimental and very likely to change in the future.
>
> We could still do so. This could give us a bit of time and flexibility
> until we agree on and implement something better and backward
> compatible. (Hopefully the v2 will help us move forward.)

OK, as the next release is approaching, perhaps we do a bit of
documentation update to address that "we are experimenting" and
nothing else, and leave the v2 updates for the next cycle?

Thanks.
