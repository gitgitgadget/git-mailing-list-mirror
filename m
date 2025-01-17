Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3A1991CA
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132665; cv=none; b=WXKlZfFviAc3qMfua9pFhZW3wIUVQZPOfoSp+T+PWTgr4aDOg4Jbd0FlNfzwXXAe0odFseTF8RL59iFZxIq7G/aCzTiWXCkk1C9y9GFtAqcebfr1lHXTIY1adpxfaHlpMW96oWF2F9kRpL9vlzTho+foGBUK0nlUUK3VVMh93yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132665; c=relaxed/simple;
	bh=6JAgItA4BHR44y4DvNCfNKbpN/duzPKJ1Ho7z7qzA6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TIsvaKM3WJ+YVhad9O99XQORTHtUnxoA07JDF3KDaIrrzv759CfRjY0ueWuwIAQKjGVwA5NZrRz/kBGkTI7MnfREaj2tDItwBkexe8jaMl1B4xKqjjm/HBdVxTXh8H/PXJrutLQRoAnUX9Y540+TigjnFkFX0Otcz0nFLlPXLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s8/Rcwk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTl1nCwW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s8/Rcwk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTl1nCwW"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46B881140226;
	Fri, 17 Jan 2025 11:51:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jan 2025 11:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737132660; x=1737219060; bh=99tuAQZ3Wf
	DQoyjceKEyZ/GboW+7phPhHG54lRi1oJ4=; b=s8/Rcwk8tcBKDQtUxk4M7+Tih5
	iNTJJFjr1g31lgviyfqURqCxBc+CFSMzjb+25r3wf83l/FnQXGD82pAkiTanpIk/
	NDFbYGQNdzKoY/2z/9q4N5pdYmwGRgz5SM2zJa4JXXMwziJMt+UebD2UE4J9zmIZ
	Mr8SzXGFFM06lm3S8BjtGEGE7lyX3k6QMun0sk/kPprfgsY3NnwhTzdBEr0JnniB
	54T7kw3QtvNShuYHXA6PEdW44qTAH+VrhdFxSaLIVETAFsOi+7rbka3UxBusFIbL
	WQvmvHzTKt1OPD2dh5mPDnO+PaeY994M22ZpDDYRKqOiZWuc9LJzZ/6f/7ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737132660; x=1737219060; bh=99tuAQZ3WfDQoyjceKEyZ/GboW+7phPhHG5
	4lRi1oJ4=; b=ZTl1nCwWpRalvLi9r1RcPVHzTPKLxRHMOO9muKNWOSWy0ikR6L9
	qugHGbv8rsxZ+v3Y7naT9+HnIJNOKoOChUAbfCtTgM3FnATH6qL0w9FH+fPaZtZc
	iiGVFkBY6wtFLrD+HKV/jruqVfOk8xAVR4y+LbuK/Nd4BqNAQuO/towW2TSsTN9+
	+TAeIsc+dix4AXHN094TdvtNBXza1QFUnWML28Tl8v6KI9LD9FZMr8os7y/enuZi
	bcbXdUGUYbWdv5k3Vu85to3wwb1W6+/z/XKxEX47e6l3kXVxWy68kc20YFFrpoTO
	WAbPcT1dblIAR2ASNunViKDdXziZrWZ81TA==
X-ME-Sender: <xms:dIqKZwJ_wc7wICna9XWeYyKBKkFSaOUysWuYr3ZeuV1y_eaVCnni3Q>
    <xme:dIqKZwL8TPpTaas_fltCDuT2fAG5r6PxoCK8lsh0IJsiCqvoWKvzECxCNjX5JKRAD
    2uubOHbDDuvfcVvfg>
X-ME-Received: <xmr:dIqKZwtxacKc_crTIAhajmCvawnsHJyIc_rKK0IucNqjV9kapStvyKloRPSuQ8rbdB06De5FnCfbB8aZJSderq4Kc2k8by7BBOQa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehsrghfihhnrghskhgrrhesiihohhhomhgrihhlrdgtohhm
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dIqKZ9ZvfIcDEa4Ur2KrudWfaCYEBC1E5tzS4USHRlL7-bel4FntkA>
    <xmx:dIqKZ3amAWbG5geyEgc5inUIH40tETe84hUABoOLRQTJy9LWxIXeVA>
    <xmx:dIqKZ5CA8DOmkSBCmpzqp6EY5ohfQj5U4NGClxlBykfLlmiDKCT4tw>
    <xmx:dIqKZ9auRQjIFlVx9tkGyCAmzb7ZvjpCfBvAbUaqwVP70TR8XK6D_A>
    <xmx:dIqKZyy5Fkq8q-vKTsuTIYO4IbsSl_RhWkOzeaccjAwc-3gTJ98yXgx_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 11:50:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Askar Safin <safinaskar@zohomail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  git <git@vger.kernel.org>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
In-Reply-To: <20250117131404.GD2893666@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Jan 2025 08:14:04 -0500")
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
	<CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
	<20250116105246.GF773990@coredump.intra.peff.net>
	<20250116125313.GA2301268@coredump.intra.peff.net>
	<20250116135227.GA2323616@coredump.intra.peff.net>
	<xmqqo706u2z0.fsf@gitster.g>
	<19472bf2353.2c31e5fd10001.1997220058832133228@zohomail.com>
	<20250117131404.GD2893666@coredump.intra.peff.net>
Date: Fri, 17 Jan 2025 08:50:57 -0800
Message-ID: <xmqqv7udmlji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Both of those are trading a bit of accuracy in finding the exact
> midpoint in the early steps. It's perhaps another possible option for
> git-bisect itself: if we see a very large number of commits, we could
> try to approximate rather than finding the exact answer.

Another thing the user may (but "bisect" itself cannot) try is to
use a path-limited bisection (that is, if you know your breakage is
inside one subsytem, you only check commits that touch the area).

> In most
> histories I'd expect that taking the midpoint of a linearized topo-order
> would get you a pretty reasonable outcome. E.g.:
>
>   total=$(git rev-list --count v3.0..v6.13-rc7)
>   git rev-list --topo-order v3.0..v6.13-rc7 |
>   tail -n +$((total / 2)) | head -n 1
>
> runs in about 2s on my machine. The commit it finds, ed194d136769,
> is pretty close to the middle:
>
>   $ git rev-list --count v3.0..ed194d136769
>   526863
>   $ git rev-list --count ed194d136769..v6.13-rc7
>   543312

Interesting thought.

When I did the "single strand of pearls" optimization, I recall I
punted and said "we need to count the weight for all merges the
honest way".

One thing we may want to try is *not* to do the count_distance() for
all merges.  For example, if we have 1000 commits in the range,
first you pick a merge M among them and count how many commits in
the range it can reach.  Let's say it reachs 400 commits.

We are trying to find a commit that can reach as close to 500
commits, and we know any ancestor of M would reach fewer than 400
commits, so we know the score they will get would be worse than M
without running count_distance() on them.  We should be able to
exploit this to optimize, shouldn't we?  In order to count the
number for M, count_distance() must have traversed all the ancestor
commits of M before coming up with its answer, so by the time we see
M's score (1000/2 - 400) and realize that it is the best one we have
seen so far that we aim to improve, we know that the score for all
the commits we have seen during that traversal cannot be better than
M's, no?

If M can reach 700 commits (instead of 400), the argument goes the
other way---anything that can reach M can reach even more, so they
cannot be any closer to the middle than M.  Knowing what can reach
M, however, needs something like reachability bitmap, though.

