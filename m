Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720762192F6
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415594; cv=none; b=t6leniz73gtHtPN3VId8lEL1GH7sEGUEA6z2BqD0LUGi8HW4xKSGIOiek21PN7oHMXGbOE6l2aXDFTlKmQBv3O/7iLAauIbZ7O1Q8kBindP2r6I1d7wc9bqy1N4JVppECSWZ+7lNVdlUh9JGXWjJDcpkBhXq9Tr2CL4o0kuqdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415594; c=relaxed/simple;
	bh=yRmxRTXO0kr0yBw//Khev7qvzu/Qb2jSFT3uYx6th38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I7YiqFzsCaJaL4x0fWcnUOUTx4qaEPlo0+jKyqkx4Nq/jb/Pk4Os2Lk44SgdILvknlQKCfPuyqFb3Wb+/rgn24/zlGQjcHmk6HQUaxvdyWm5oWC0nQKrbMcRdrLqHbbUJ7GDfUffax8mMNZarWkeCrSBqPymdUhPNDdLj0uph/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ppO9afRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JoACbOPN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ppO9afRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoACbOPN"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E45B11401FB;
	Mon, 24 Feb 2025 11:46:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 24 Feb 2025 11:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740415591; x=1740501991; bh=BSATK+yACg
	qA9pMzlMHHGEiVJI4GyAs7FC8Icwrtb8k=; b=ppO9afRwNE4YUA6p33TGf9QGI5
	68RbpaAzRJ9jcLS5sJ4St1qbf84llFW4hEs6zShb40UDLKURUHuMQ2CI0t6c65bX
	NVs/e8oDpylWypVmVgr8u9cSa7tAVZBeSmVRYGawc/mhpYee6Px5KboU7QlA3Sw+
	muIHfJ8KxmFkph28cI/UIUx2c+xWFJMiuqi+UrXKCu4BO85MTTwV0Y7kDH9m0z3Z
	6RcNexwbGiwOFzwXOFLsrmk6btlkxagYm4SMKFyUCWXHi17ssIr8B/P/tQR1JiiG
	EL2JlAfv8JUTb7Y2B9WOg4wfUTadm2CZd85xvp+f8632f1/VsHOnwKr6R9PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740415591; x=1740501991; bh=BSATK+yACgqA9pMzlMHHGEiVJI4GyAs7FC8
	Icwrtb8k=; b=JoACbOPN4Fp9OrhLYx/+4coUcUIIlhVp31D6x+WrIwbyMR9DNII
	FVXbUjEccsbdI7/3WGnVTJRsqEd8sJgJMh6c76uTBLuKD+Yc4rxkUgu6/VXb0NJT
	9yi1iAHzeJ4ahi6GOLhESyKrn8F+lyqPN24OP1+e9ZOZC3JDCD7jRB74eh6zG6wF
	2+gHM9JRvroAD8Nuxc9+jfL/sfxl4JZdas42kmd3Q0Buz1wwvbNMy2RO7pMTpSQ1
	2b5vqIkQN4dtAK+tPzj2HJhdAelW5al5IQAld0Q3YO3IGOsAkG4+6502V9vd51sP
	eG16exYunJZPO3MBL+CB+i9sAgkandluHqA==
X-ME-Sender: <xms:Z6K8Zz7gAeeaKiQHV6ceGmtaSmvO3eEHTxq_BlB3U0CrZWflt0WCvg>
    <xme:Z6K8Z45KYtBdz5v80btYTWMR9_LIh7T-f6DP3FLVGXNlD4Bu6n4-ILMrPOPVj0TZN
    ywhhGyQuRkBqpmw8g>
X-ME-Received: <xmr:Z6K8Z6eqHd_apmOtI3i1LgLuL3DIkq0ahEFPXhKcPw3p1XLkhFF6bcLBHM0vmYhuvRZXGo4g0zXAnk-XvIJ3Bueo2tLNs2HEGhaIYFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Z6K8Z0Ifyw-dZ6GCEH4hUj9GNHA25u9O6vdaXK-aTg-_gjqeHTkmAg>
    <xmx:Z6K8Z3JfrYAxX5maH-XiHdoKKL5xQIZNz5e9eee96vMlQl_vIIWyfg>
    <xmx:Z6K8Z9yrkOerm4vc0hVpXCDxEGlwYoG02axr2q0GB5lkRuxo6feBQQ>
    <xmx:Z6K8ZzJmbjwFEjjcGoQ2a4gSbehwGiPNshCZnKTsoBR_AP3flVNEWA>
    <xmx:Z6K8Z_0w2BRZN3KX0ulQFaE-Ksyzq_GgpVqOKvIDAzw4BGA4N-n8SItd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 11:46:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Fix netrc usage with WebDAV-based HTTP protocol
In-Reply-To: <20250223015331.588161-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 23 Feb 2025 01:53:30 +0000")
References: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
	<20250223015331.588161-1-sandals@crustytoothpaste.net>
Date: Mon, 24 Feb 2025 08:46:29 -0800
Message-ID: <xmqqa5ab70ka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> However, I think we need to either decide that we're going to support
> this as a fully-fledged feature and add documentation and sufficient
> tests, or remove it, since it's not reasonable to have undocumented,
> untested features that people rely on.

Does "this" refer to "use of netrc in HTTP code paths", or "HTTP
walker"?  I am kind of surprised that anybody is still using the
latter, regardless of where the credential is locally stored.

> I will note, as an argument in favour of removal, that we have
> git-credential-netrc helper in contrib that users can enable if
> they want to retain this functionality, and we could even ship it
> by default without much difficulty.

I am fine with the approach.

Thanks.
