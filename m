Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2632DF156
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097938; cv=none; b=jL68ZsCfvUE9PUD/1MmvIynNnU4X/wCk64HAVJn9IdD900u0fvLl6m4yjibTZlHrWntpZPuLKJgsp4kkiag6gm28s/RxKCy/n96ClYh6BwXOeXSI2Y4J0KvUDWqmAlgjM57vXk/Z69dN5gQapnU4zHdsjj/19U1XgZxmwA+YqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097938; c=relaxed/simple;
	bh=iup7Mahmr5H2/ZADVEzbm76DeRydWI6NlBvn59unA7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYPsI7WSn3UQpQvWf1eKzTehAlsN3L+C49f4KRv07tNSMUD/N60LhoI5IZptpP8QO7a6xdUGRMooxCAYpIS9mJv+DhV1/guSgmcVU8ePvgeZ0MULSuvFvqvsWMuC9u9P6US75RLmeKets2dfMIrcSzcQfigISlj3Gz3Wk7p/8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ERkcQb3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlofH64U; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ERkcQb3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlofH64U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 727211400176;
	Mon,  9 Mar 2026 19:12:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 19:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773097936; x=1773184336; bh=UleLTbun6q
	9wA2q1+4Esgm3wc8d8dQ4kNByC7TG6wo0=; b=ERkcQb3Guf3XUotBqCrQkgt1Ot
	76znLgHfEBP0hRLW4jr+e4fRPs3WIiKklFe/HZAtfdszGtcd/nMFEN/elAjns0/y
	gK5MPQVAohoAyGaVfxl0alsxzApV9yUva1zo8TBB5+VbyetQa/9d1GSCjd4fU7un
	bqb6lhr+G2bMYIgkSEmyMbt6UPA3d+ojlujRCNMWT9v2Q0O1B9PIWdXBC/RGL0EI
	Pt3BUM+4rfXuQtF6Idd4z5K0xqQUgwzckx5HzEtxNuuAIB+jMTFyb3SLDZhnMVtN
	liBW/4Q+qpM54ZrelUSxpnc8uV2mewEDAQzmC8ARRPLu1jkZfllED9IU/knQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773097936; x=1773184336; bh=UleLTbun6q9wA2q1+4Esgm3wc8d8dQ4kNBy
	C7TG6wo0=; b=UlofH64UPPjFESxEg1Iyx3oqapUMFhoAw2maHwjrKidkvGZInF2
	7M+JsEJ8GKrXfvdTu+GqVim1SNAVyYV/1+Uteu2BkuDq0OEJ+VRk1EkzoUVaaJve
	YuwN+oz6PHVRzAccXb0tSClWv6VQtpzpBnIvKpRwnytrdxvRPblI+mEqB9XaKIsa
	LLPnZCF9RDuVO/zb/cHbWcXmgI1sFoWWeatskMWKzqLDowtbIphmSfchSqGVzMo5
	KS/uhxx5oC0VuRMwB82vZbOhtTux6qacOznTIEoF416/RYfBxcvKEpzsgi6+0r08
	uEhsPhHpGiCsdqMZvT9PeeCsN47huUdh8Fg==
X-ME-Sender: <xms:0FOvaTIg7--1oYoduDu94Y_fk3nQkPWxoJ4zXVWe8KZJzGHAgbM_7A>
    <xme:0FOvaeJhBG1M_0Fs3hkh076I0fg6U7KBSsE8gXFPSVfvrLhtzvBfinZ0BG-ffFA7z
    vYN9CbMe8dnCXowl6tNpVsCv9wXn0TtU6yPcog0c_Mp4E4GU285>
X-ME-Received: <xmr:0FOvaQvHEAFje3-oqRQGbCTxbb83O1Hs0bdBm68T2uRt2yerAq55zyPbyGLyPzFWeVQf9k2kDQMazkmEg9jDorPwe19cWbTlgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepphhrrghshhgrnhhtjhgvvgdvtddvheesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0FOvabSvPGgsaunXymVcYHEkT97sI3myCtCKYA3R9cwOLFuVg7zVcQ>
    <xmx:0FOvaWO946YZvfRMIZU9GkcXD7q7YXx9JAtOr3VYWSBZzZGkSOObxw>
    <xmx:0FOvaQbj-GqBiY0XBtYz0MqnM2NVgUEzLkMXmnhqrxsrrnWdTxxPsA>
    <xmx:0FOvaQwhYy3LoeVNzSWT147cAi1vK-SRxZVlWpEbaJ-HlNkkqO2g3w>
    <xmx:0FOvaWp4y3cw4ZlMdGZDUhM0ZlfAcHwPkqPnm2eZbiQF976F1JlfKCqN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:12:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t0004: replace test -e with test_path_exists
In-Reply-To: <20260309224739.GA5682@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 9 Mar 2026 18:47:39 -0400")
References: <20260309173635.29683-1-prashantjee2025@gmail.com>
	<xmqq4imo4sf1.fsf@gitster.g>
	<20260309224739.GA5682@coredump.intra.peff.net>
Date: Mon, 09 Mar 2026 16:12:14 -0700
Message-ID: <xmqqpl5c1ttd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Without "-v" you would not see the output either way, like:
>
>   ok 1 # skip some test (missing FOO)
>
> But with it, it is the difference between:
>
>   checking prerequisite: FOO
>   
>   mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
>   (
>   	cd "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
>   	test -e foo
>   
>   )
>   prerequisite FOO not satisfied
>   ok 1 # skip some test (missing FOO)
>
> and:
>
>   checking prerequisite: FOO
>   
>   mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
>   (
>   	cd "$TRASH_DIRECTORY/prereq-test-dir-FOO" &&
>   	test_path_exists foo
>   
>   )
>   Path foo doesn't exist
>   prerequisite FOO not satisfied
>   ok 1 # skip some test (missing FOO)

Sorry, but I am not convinced.

It is as if satisfying FOO is the norm, and not satisifying FOO,
i.e., missing path "foo", is something worth reporting about.

If the test reported both success and failure loudly, it may be a
different story, though.

> Probably it's pretty obvious for a one-liner like this, but I think it
> would help for a longer block.
>
> -Peff
