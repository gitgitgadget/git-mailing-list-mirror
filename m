Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE343222565
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606456; cv=none; b=VK82rBsGClvZgXdvc37ocsNfIZJfvB9827rVVyVk4AksHP626oEly0D4rcM96F3Z1rdeolKJHMk/vIRf2+OMZNwzmOwW0Zq7/GP7Ukr19vO4jo/qBUqoYr7J5LywiKEOxeinXXOQbqcpx6Zw8yYJzaVuGw46P5Vv1FbLPBnVqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606456; c=relaxed/simple;
	bh=rCiCf+4z3MqQ2pXXVRDUTC/s4Spq/eTZzy4JVoD2XK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C66BAVVXaqlLmKjNCt5Qn6tS0oSRoqEtmXh5vPTeEU4EVPxDhQr7P9d2XOwjoTfL3d3Li2NLvypLd2OttO0/VA/zIlsWxmvui9P0eo4iOBQi8/33ZLe6NuskObbtibV4HZrzs0vAzXFp/86z0k8CrojbZtU7HnXFav/+vNJFSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4u6A4yY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WesRVI+V; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4u6A4yY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WesRVI+V"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BA1E6EC01DC;
	Thu,  7 Aug 2025 18:40:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 18:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754606452; x=1754692852; bh=SDTHXrtfeZ
	FfYzyQSYBX5OfiN32Hdr+6tehEJXy1X2w=; b=X4u6A4yYBi4APp1qFCA7EWA0pe
	GLkouwuWCWCX7wi3VgUjzY9ENTbNkw8Dw/DtZdRXxIFZnkcLQmXQZ6loVlxaKc9a
	o5e9AcwOJagUAZTPxnG7e5NKPVDcY9P/HyDojKj+f20enqQvGrFUCGP8YrVAXf2u
	tyX0vpKDXhOFL+Svdy6GLNFZOFh30V2A2lr3ad/wwOBoD8su8Oz4fNqnPB+qqm/9
	Ge1Tytx4ZuT3WGYgoARiehdoOe1rWDJQOjQs8GelkNLk97CAnSiI6p1bnAYmqMDj
	vuiiqmhxJIDAHK+KvVdefiBL8WxIXvOiH4BFGl5wC3M2droeawnJ9g+M2lFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754606452; x=1754692852; bh=SDTHXrtfeZFfYzyQSYBX5OfiN32Hdr+6teh
	EJXy1X2w=; b=WesRVI+VoVBoIRuIYdw8JSwbv+KIxNjn05Qj21No1fWHMou4Hmu
	1KNJhAA7MnBBweEP3895Ycfz1uXRjP2UJ12pN7C5f/zOXf/YY+ulj+1woyXHl1Qq
	5ZHOjjWlIYQvZoKPQkjjHmeN3jptVRefOu4zLZxOY7WwtRrA6eaEmHeYfzdAXd9o
	xBAkasR8aFNKPVK7RxQmEnV0hNA1RoOiNx8VJ6dfkVxle+JZiE6qkuWzNc8BidG9
	zUSs2a9DlYgKKgUyQws6YQAh3IuKx9SNQbwTLPHT0JQKazAS03iSTZXR+22qy6Xa
	T22jXAuZDVlbijQOosW30wQAwwQAPYENZNg==
X-ME-Sender: <xms:dCuVaOJ18Ndp2MKCMVvTUjyvmSTXwKX5gBbWQE98jvURiXzY8yDUkQ>
    <xme:dCuVaPeskIdJtnrE7uv6y57n_spDiffNzOU3q4boky2egpfj4sfZdEQ2otLfYHsKd
    piRvyb3Ni-RR2qhaQ>
X-ME-Received: <xmr:dCuVaF9eKcDMBmpid4twUQf_DMP8VJVYWH1WUeNSg22GBg2B61gkrGwfP-T4x8o2grqyVY0Ew9-gHJvE15Shq0yS3yChHPKbbuQWCOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dCuVaEqnKu0WxDl9WKiXyY7yeg4i8PodwhOzJ4pYJZjhrjzuEnihLA>
    <xmx:dCuVaCAttr-wKFrMeASrWxSJS5AKI_eEoTpLeoz4Jx0_6RNbjSdxrQ>
    <xmx:dCuVaOz6aaW_6Wp5Bw4nVsCB0Z34H74t5AbA7nvEUFJlmux57C5s8A>
    <xmx:dCuVaH26Y4ofoqBfv3eD5_k_BGc5FDJg9ioCXNRDPoDs-CX1l1ISJw>
    <xmx:dCuVaBEEfxLwVCeoJZ8jotjy1a03Cq9rcu5yV29nTY8JhaH8RbZg6j7S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 18:40:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 03/10] commit-graph: fix type for some write options
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-3-82edef830a1e@pks.im>
	(Patrick Steinhardt's message of "Thu, 07 Aug 2025 10:04:45 +0200")
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
	<20250807-b4-pks-commit-graph-wo-the-repository-v3-3-82edef830a1e@pks.im>
Date: Thu, 07 Aug 2025 15:40:50 -0700
Message-ID: <xmqqv7mykb65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The options "max-commits" and "size-multiple" are both supposed to be
> positive integers and are documented as such, but we use a signed
> integer field to store them. This causes sign comparison warnings in
> `split_graph_merge_strategy()` because we end up comparing the option
> values with the observed number of commits.
>
> Fix the issue by converting the fields to be unsigned and convert the
> options to use `OPT_UNSIGNED()` accordingly. This macro has only been
> introduced recently, which might explain why the option values were
> signed in the first place.

These are platform natural "int" from their inception at c2bc6e6a
(commit-graph: create options for split files, 2019-06-18), which
way predates the recent push to appease -Wsign-compare, so yes, it
does explain it.  But because the developer who wrote it in the
first place is around and with us, why not ask them instead of
speculating?

As the max_commits member is comparable to 4-byte network byte order
integer that is .num_commits in the file, using platform natural
"int" or int32_t is not correct, because you may not be able to tell
the command to hold 3 billion objects before splitting, even though
the underlying file format does support such settings.  It has to be
uint32_t or wider (but if it is wider, you'd need to be prepared to
correctly compare max_commits with num_commits, and take an overly
large max as "unlimited", or something).  And unsigned usually is at
least that wide, so the change may be justified.  I do not see a
reason why we want to avoid using uint32_t, though.

As to size_multiple, it appears to me that the number is really
designed to be a small integer (for which even 100 is probably way
too many), so I do not see any reason to insist it to be unsigned.
Even "short" _ought_ to do fine.  And if our macros and compiler
settings do not support it well and DEVELOPER=YesPlease build
complain, that is what we need to fix.  Papering over the problem by
using unnecessarily wide type, or by using signedness that happens
to squelch the misguided compiler warnings, is skirting around it.

If there is any bug, it is st_mult(size_mult, num_commit) and the
compiler warning that complains about its CPP expansion, even though
it should be able to ensure that "int size_mult" (or "short
size_mult") that gets promoted to unsigned to match uint32_t
num_commit would not overflow the unsigned multiplication.

So my take on this change is that "fix type for ..." on the subject
line greatly misrepresents what this change does.  It smells to me
that "squelch -Wsign-compare warnings" would be closer to what is
happening.

It really is arithmetic overflowing and wrapping around that we want
to be careful about.  -Wsign-compare alone is not doing a good job
to do so, is it?
