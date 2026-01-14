Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F32D73BE
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400109; cv=none; b=umURnPQdgB9gT5Lbgl43lbYdqlE7hDz8+l/nuqJPKGlh9KZ3PmDeITlwKSsiB+ST67NBc71exyL740Gfgs35QgYaQjXSVl5IhGaxum6ZXbZ0EEprPwInTGfvVqrWLkQG6vbmfdub/O/BwWEgh5l7tJ5gS9r8k9eqJ3kbXZIzRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400109; c=relaxed/simple;
	bh=Y/ozVxK14VwFG+KxRFRBd4ESxNNIFX2XPoyw5IOtBPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tfKzYMruUke4W3sclNAdWGTHySp3xB7Qsx5nTgsqQlS1JABkxUorBD1pE44DU0QAMRMrImw4WaWGaDLSECwTz5LUoYjBpQs5MsW9OBH+Cu1SnSZ4QZ2Slb3AKBqZlgzigj2pTTDbX03di+D1xbu5nJ/+zOlw5EOQoEnnRFjgSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jjsVu7QV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KixouJNz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jjsVu7QV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KixouJNz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 14C1A1D000F4;
	Wed, 14 Jan 2026 09:15:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 14 Jan 2026 09:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768400106; x=1768486506; bh=sZ6Fw/Yejs
	G3i+bvDKet6gO0W+/6y5u2ZBpq2dTOP4k=; b=jjsVu7QVg2QoQTGd+TgfTe7QKS
	Dog3m32L402ZWS4B5UnXdqUt3a8JT0oQhZE+t7Vi2z+oX0RxuHidB46aJ4DORZD5
	lcrQGqo+zdQyweFeIJq+UkJ+pRkuduCfjou2Y2x9/FlFSxHuMZn3V+BMBWwtxi9O
	229xNgnArw+Plc7oHzN4X+XnRGjHqn/okoIzRH72NckHmZqjPs0uTD817GeioN1e
	Cglu5NlJV4EmFgciWkXTIzCLwgi9RczpVBboR1DxtOPni/0D34+uqEyXYTnQ4lG/
	PpIpl4e3vmQlZV1UYRf1CTQ8/ukfNrmn7Ez+dN8Ze2tYc89Iy4aVeInxr3yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768400106; x=1768486506; bh=sZ6Fw/YejsG3i+bvDKet6gO0W+/6y5u2ZBp
	q2dTOP4k=; b=KixouJNzJnjZwxja3pG/udhoG7t4wkDHiWH+K+vTANJZNEEuVQm
	YsKHcXacB0qMkLFJ2Ju9qy/k1gxqBI5c6mDq1HCjvUrwmMzXClEMU3wWU5SJNWKq
	dEISzM7OMkRf6y/FjyVZlJgiTYTtIim245A/T1wiE7dr6Wvay/FobnkOeokb4xS9
	rLlJW517LEs5CQrh8W0tRSExqIKB3QheaViWtOe/NpbIotdR9wiDxrirykEeLq/a
	2nvrY6/cwtHib6+560mJRmTbV9NsMikP2jCmAapsJhGajrxkK4RlYsFe8QFud9Gl
	WKCNdWeH6q7C8kDuDC1SIVsGFytAmJJOIFA==
X-ME-Sender: <xms:6qRnaZia-zpDSWDilhqzsWPRON2Dj53U4aWGIN0ysZWSK8MDDxhbkg>
    <xme:6qRnaU5JUpk0njeh2J-HTpPp4mIDWDM7ZuAIpPhmjkv63AmPMd0GrTO5hCvxha0er
    g4QWxmn1KhTW_a0wM7UFSX35eiiZmiLeb9hCzGylhouI-UQJkUFiA>
X-ME-Received: <xmr:6qRnaRbd3xAOq7-7cfZNnxcoVHnUqu6szuK5q4ZTKlpJC2pBASNnUw4FFRWVHxc0mlrgQfMItJRT-lZxttks38LeinQVkZGEnk_zheo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeffeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:6qRnaZ4Q3LmqyCbxt9B0azaENc3EmxGtt3L4aSdV-nK7cnhbwblpMw>
    <xmx:6qRnaUDEXmScBIjzZPbuFtbDsWW3_lCKPY8N6T-6FbnmYnZIOb82Jg>
    <xmx:6qRnafdop0-YZziToURVbK74oxO87RyB7KyHZf295l8zOLaHP31Q7w>
    <xmx:6qRnaTLjgp4CDFW-jNWOvy3-2b_cFRRRvdwl6VdFmrWfjS8ZjGa2kw>
    <xmx:6qRnaebh5Jh53K3fwq_bLBJ3-lBrAhCrnMkRWm7Mehh5fclccnIV2AHy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 09:15:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org,
  gitgitgadget@gmail.com
Subject: Re: Triangular workflow
In-Reply-To: <20260114023408.GA858378@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 13 Jan 2026 21:34:08 -0500")
References: <20260113214059.GC288857@coredump.intra.peff.net>
	<20260113230107.16728-1-haraldnordgren@gmail.com>
	<20260114023408.GA858378@coredump.intra.peff.net>
Date: Wed, 14 Jan 2026 06:15:05 -0800
Message-ID: <xmqqecnsgu1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So even if I only do it infrequently, it feels weird that a bare "git
> push" would try to push to the upstream remote (which I don't even have
> write access to!).

Yes, exactly.  I was wondering where Harald's suggestion to swap the
two remotes came from.

> Yeah, though @{push} is usually not explicitly configured in the same
> way @{upstream} is, but rather a consequence of how push.default and
> remote.pushdefault interact. But it was added for exactly this kind of
> triangular workflow. I sometimes will do stuff like:
>
>   git range-diff origin @{push} HEAD
>
> to compare two iterations of a branch if I know that I haven't pushed.
> It is a bit of a cheat, because what I really mean is "do a range-diff
> since the last thing I sent to the list". But if I have just been
> working on a branch, and I haven't run an integration cycle since then,
> then I know that the pushed version will match it.

Great suggestion.  It is fun to see that comparing notes among
people with different workflows brings out these gems ;-)

> There is also branch.*.pushRemote, but I have not found that useful (for
> my triangular flow there is always a single repo to push to, not one per
> branch).
