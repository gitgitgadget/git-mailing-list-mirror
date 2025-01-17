Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD819E83E
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143187; cv=none; b=AkwIIx7TEqXVmtesXppdEqQZPlZnG+tszEwz7cWuuwtiVoSjOusF8BKkXIlymovonwYGaZkrw4Jsd6teVsNJYTG9y+ujaAuDstra+mFHRv74b6kPWYRGArErkCe2v8JFZ0OcuIKGlecjS5jEOqIk5UPpSqfat+voDGVOku7VhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143187; c=relaxed/simple;
	bh=5BX4dGlXaXrHcaIPudCm5o8FHielBP+cwZBEji9ol4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OHxCGXt3bavWdVrnUmadOJKiDsKTm2U7qv/3pmIuVAnk44QRx2eL4GJ/67ja32P0T1qKbQBi8KFrGy48ipTpVe8xNoALWDlLHHnAKByClxgYAINC+dBMWNpZD40xp44AXor06fGMnNXOYL7J4uIjvbqxTfm8c36hUzisLPldQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2zjahkVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJVXJXi7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2zjahkVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJVXJXi7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4869C114016A;
	Fri, 17 Jan 2025 14:46:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jan 2025 14:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737143184; x=1737229584; bh=R09OFQOq9Q
	rrDGMSTTTIWQPfAd6unW9aLVNHbs4Sbyg=; b=2zjahkVVBKQdvXDYJGveNH9L1Y
	TeZwEnvf3WIv2Zd2xiSTAvjHun989A6tNQIS5zWY+kep3oa/IOx4Vo0Fpb1EN8Mx
	u7tOmUCtpnTXBaixlydt5hxQ7wlsjse4Aa/mJtQQIut32BngCmvyEG1/waOiXDCB
	BRLjLLBMUXFn5LVqAtnG9gVpfOSwY48IxikxrKs5uY6fkr/X68tVTpklWrjwn/9T
	Jk2CUQzr0dZHkgQgGsfrpHRx8LmqRwcphvZ46cTqg6iaZg1Q2zXs5QByRQO2tjGw
	K9uSVlDA4s6NJqOCnc1hbDx5rKzVIsxplMYfWynTjKsBG8ncaK3kFAz4MihA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737143184; x=1737229584; bh=R09OFQOq9QrrDGMSTTTIWQPfAd6unW9aLVN
	Hbs4Sbyg=; b=rJVXJXi78q2TfwYg8nJuAgMABSkeLjVPX8FKR8SwKvCt6rlA7cA
	27xEtkqtQHmKYil7EIHPwiIT6Vu7pO83gFBxMMcp2IDU24GVCJCMJ6kWhKJghcA0
	mUHhe6SlwxSR8FW9d8nYL+h42YkBLO5IyYFSPsEOWIR3yY3eqbmKn0yvO1gmr+ZA
	5HkI+7skB73DIaEElUMgvlZT7/njxxrNmxNinnVhf4DmGCXiUHazM6pr9OWu+XpL
	G3xncwKk/htyb0NVsNII6kXmiEmI8HhSUugh4OleSStH6kfEOJvTg+GDQTqp0UUi
	ix4HJK38q0euTQDT2paXPukT293Xr6yTETA==
X-ME-Sender: <xms:kLOKZxzaw3SnAw7nIKoxPaWub4N0nqiXGVQKTHlGd2ZtMOanhCIyDQ>
    <xme:kLOKZxQiH0_JuEeGeWLUILQohvxq5rQWLUUCTbfOnme8SXMyGm-FupRa2vuSKy4JM
    E4Ook5WiVV5f6rkyg>
X-ME-Received: <xmr:kLOKZ7XSr2LN4C8rVzeLXZP47bicGhOBKge0N0Hg845UFwUjjl8JR3RHX2rA3PaMJ_M5vUSO9H__YHHG1zH6A2EIzXvFJP13XCX7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:kLOKZzjB6nUc0xKAi4WZWfCquJClwOMBgDIbCrAjFCuM5il_HmmbPg>
    <xmx:kLOKZzBZcArEvdGmaCloo4XK3byskRdIbwBp-aWnw2iv1jFKlNMJuw>
    <xmx:kLOKZ8K1HbuwjGvEdI0_oCVQotddRnzSOb2dXxiVHSCxjJnZUTnaYA>
    <xmx:kLOKZyBBaJr4UgcXfmBTYl05ThaVvvFKKGeLvlslZtlBMoFWGMC5qQ>
    <xmx:kLOKZ6NRajvs1dPdLLSN2ee8VWKMjsvDfpmZqZCuAU0PYfrSxx0UClmo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 14:46:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 6/6] builtin: send usage() help text to standard output
In-Reply-To: <20250117114250.GB2356746@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 17 Jan 2025 06:42:50 -0500")
References: <20250116012524.1557441-1-gitster@pobox.com>
	<20250116213553.2563751-1-gitster@pobox.com>
	<20250116213553.2563751-7-gitster@pobox.com>
	<20250117114250.GB2356746@coredump.intra.peff.net>
Date: Fri, 17 Jan 2025 11:46:22 -0800
Message-ID: <xmqqtt9xjka9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> If we do, I think it would be OK to just drop the test_must_be_empty
> line. Now that we are capturing only stdout in "output", checking that
> the usage message is there is probably sufficient.

Yes.

> In the meantime, I think I prefer keeping the slightly more strict form
> above.

I am also in favor of keeping it, if only to learn why we do not
want the overly strict check when the time comes.  That would mean
we would be loosening with a concrete reason why we would want to
loose it at that time, instead of guessing that it might be overly
strict without seeing the fallout before seeing any.

Thanks.

