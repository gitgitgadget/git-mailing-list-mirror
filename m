Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757508468
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365569; cv=none; b=sKaqHFd/SDL0CCnyjFipD/HpjMiDG+1AG7ALyivVt85/I+S4URnwZQ2aIr4XzBWX1hYOA0Ck2uepAqMoNCrrqpnKCMbWZifIB+WaefUKaPWIXg2yHabgHwQv8bYos+Re4/n9CQ7l0AaLcIWKZ8wXgPA2sZdUYDbnKF/NxC+9xPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365569; c=relaxed/simple;
	bh=yYuY0/WcudJ2cBud6J7NFTk57SIjuCg3wJj/J+nB+i0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FDTe1shBL748SIaBlDUEBUckLQ6zNmjq4jBm1+1ETBpxRjHFOKszkovAdbc558VdqyH9dS1se+xqRImS0l5oLYR+ZjKkRtFt1l01Sko2mzjTai/1YzNSnM4i994sEvb33qaPc+M/WqEzvorve4H/MnQ0af86pe0KjbECeAbWCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lgPrJ/5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jV6RTFZ4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lgPrJ/5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jV6RTFZ4"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A79E114018A;
	Mon, 11 Nov 2024 17:52:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 11 Nov 2024 17:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731365566; x=1731451966; bh=jcrbJGUCis
	3h3J5VX//lLKs/DRozCoMSfkm2H/L9jFQ=; b=lgPrJ/5c2dGnKvkBU1JooMNQ1c
	gcs1UqYujwQBGrT1Dswr6/AiG0bMjF5nfNygU53Zd5PGYeOh/302u5JTryAjCItk
	uRqGjcPlOF7XlMJja3Cc9fe7O1ha9EFxNGLiq7Kz4ThRtaImDCGj9d6sdjXZeM/7
	6zJ1k7KGKy6fFFchjKoN/G6fVCoep/G6Lvalwc7XYMnzqaKspezURgVif4Zk9SmG
	bAyhvZIn4UiCmn3Yqjt0+5pmY1Y4mBcmvratFWZ82sNgKKGnL44Py5y+zbRCJxbm
	UNQuZCiCGHmX3EuhUvWn19H+bAC/jnRQ6jQtXA9+uXZDfQqnJomhRN2b8Jtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731365566; x=1731451966; bh=jcrbJGUCis3h3J5VX//lLKs/DRozCoMSfkm
	2H/L9jFQ=; b=jV6RTFZ4ToNaFYfGHR2egkXOZnr+NeNkezMvju6zOcYDIUdeYrM
	rgMigYsNRNFOGDCaUkNpcZ3+802rCkW+d/pwhVvJ0bcvVlhN1XM+hWehMP0evhZE
	N84tU9rq4ZAqLNEO4VQqpl2uPq4ba+T9sGvTzb4f5KwOEzdVu+leOLForl953xdS
	VzIIGceHiOoHfFtrq4ArIAM6GEbZjB6q5ehBGY8yTRN2YWSMZUmJJUVKwvIvdc7P
	PfZio+cj8uus5hJQb13VE9n4akHMIoB+kkMvvhzkYrVhQScMkaUBDI8M5ZW5VYc6
	HhRW+L3az4OeAMbTnojvB6m/YrIu71X0gUQ==
X-ME-Sender: <xms:vooyZ4-PVrdfB-H6pkAG0YorfXpo8kj6G6akW4Dels1z1fkS6Ysdzg>
    <xme:vooyZwu2n3ZbDxqNU5kTjJQVHSB9z9-eiszKSWaYeyMW9xhADbbJtpmIoqKySn0XT
    1PWy8aksd_iIk_HVA>
X-ME-Received: <xmr:vooyZ-C8ElNUkUuASkG5jMobmfr9oZa1gJDbyb4lGez__VHp1Dgrz_QvK3XVjuemAXjEMigRhwtU5ODaMFeUAU9LwRtwJEpftxeV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vooyZ4cXD9gf5-aHPUcnrYMxu7STEhxWAjM7FujNJQ6USLa4Jh8mJw>
    <xmx:vooyZ9MSSIwXiQCVAL5_WpMrlmI1JqUGEN74WAFRNDWI7x0C2CaCxw>
    <xmx:vooyZykyBFFULWdH9hJ2e3cQzCHEwVwmpmkVBdJ_iU1ixoupGcKYEQ>
    <xmx:vooyZ_vCQ4Kk8SaQt9Rg2fepQUMnVvAnzARo0WgHOLFqCG9EhZhNlA>
    <xmx:vooyZw2iIEVI5CUMCLtQ9Ed2P-dugyLJmM7haDmtSgvfTuaneCcGYu2a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 17:52:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Build improvements for clar
In-Reply-To: <ZzHAfgR_NpBfTkpV@pks.im> (Patrick Steinhardt's message of "Mon,
	11 Nov 2024 09:29:50 +0100")
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
	<890b423c-9756-4e1b-a6d0-3990f1091f5b@gmail.com>
	<xmqqiksuk0yk.fsf@gitster.g> <ZzHAfgR_NpBfTkpV@pks.im>
Date: Tue, 12 Nov 2024 07:52:44 +0900
Message-ID: <xmqqv7wt9ydf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So I'll take the VERBATIM and line wrapping suggestions, but for now
> keep the shell script. I'll adapt though if you think that this is too
> much of an abomination.

I do not expect me to be editing the awk script buried inside a
shell string literal myself, so it is more or less a "meh" to me,
but once people start iterating, they may find it irritating that
their favourite editor do not help them with its "awk" mode while
editing the script.  Once that happens, they may split the script
out themselves.  Before that, I do not deeply care ;-)

Thanks.


