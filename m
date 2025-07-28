Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550C274FEE
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724629; cv=none; b=WkloZuMM1q4MLf4T03TsYQZqDMcda3VHJYXKMTzZK7vjwGpLiIsWEFFjyAMUXgogDj7qcf+pYs7a1Uu2YYpWLgciOEvRi/+iAyYYBQbjCoiGDkxSCyi2DMBTRGMGv4Up0uDBh1z9tu0Xc9co1mzlFY3fJkyBhq49WdpfhVLqtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724629; c=relaxed/simple;
	bh=CG37ISlliLKG/MxrknyAMajzwiFb2ZPNKT4KXx0vpGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGAFuZyv3Ydwxiuc7qJ+XjIn+SAnLJt/W7EB/joFRhk+plZpetORqxgsXmVokP9IGdHyjBZt+hWpec3gNHQ1koLNCNwUCIXbaJPnM+ng1arTMkpvb/p6ncJj0YU0fadofZ6iEq3pO8tkYQtVdzNc5E5ccuZEdvQaLvTi5Wp2qlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WR4wUvy3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ss0hlk29; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WR4wUvy3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ss0hlk29"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D9B5BEC18DF;
	Mon, 28 Jul 2025 13:43:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 28 Jul 2025 13:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753724625; x=1753811025; bh=wDTzU35C+K
	1ghYnqbqlZEKJGjQvNR3oL7YWI3KRY8no=; b=WR4wUvy3Bz70ghCDj6IqP53bfW
	2mRqIFgbLjJ2EsZW+qWCs4AgFucRuMP582CduNarqoaNUYeVBXczqG8ce5pdBJE6
	82y4CXxWn9P+MMUjpQrEF3cvTUKRISpLzkuigFDIP0VVYLx5EWtxoM5987YM7j46
	YdRoWHEE6Y1hjOf+ZBy8ia/V1b51qjWl7Ru0i9PC41j6iJK0lF6d4637TTZbjCMI
	uPiFVO1kW3GDwO9WdIhJiJerAFYul9GBjDGODpglolo3BQzDQ0OYeaE/B1Q7kgIJ
	JQ03Z5qrHEE00mhQGCakXDARtj8q5soGerRhcsj7NlbHlxb/z6YLMgCzATcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753724625; x=1753811025; bh=wDTzU35C+K1ghYnqbqlZEKJGjQvNR3oL7YW
	I3KRY8no=; b=Ss0hlk29Wqc4KlxYQzoPCuaFNJTzDN7S4uk/1Zaw5FAwm9fTvZw
	4449ulr/0PN8NfrKw90hcOjvYvdRZ1LVCdnpqrEP2aTU1WdDDsfrUIMkVDT8wGBh
	5iP+mHlSxjYsz5YZjpSZThsKdHybHo1WzimMHc1F6a8izmn1EDWnuvRUWfGz0k+c
	ngkCtAhtmKYdEBiO5SVDgQb2lrH+uQStrbPigbvFkngiTm8XI2q49eorrQp0fEpR
	kQBIeK7Cnh/ahzQEjGU9dBeXTu7V/hZnHNl11e/nhUmfTM752PvlGowIJW+giT2A
	5VHXy4UeqJrRnHFg0sxFDR0QQC0dVLm5Avg==
X-ME-Sender: <xms:0baHaNiqwLthWKDfh6oOhbgwoSAhBiwBl_JXLDTxtQlAsg56mfDoyA>
    <xme:0baHaNhguXwypPPAO9zmDv4RyuVTYKU-6k9VwyIXKx4_xnv2LiJF9WTWaM3bhYUmV
    k4wSjoMoyLoeqqIvA>
X-ME-Received: <xmr:0baHaDh2scTfrLNiLFphulDn9khVCVsXddewyimbtgM3T4jwEIyw7djSXKxtTHS138DejDPgdtyD9I27U14SyNZZiCE_agFChA6e1k4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0baHaNJie_DJgBfO6eGVgg0qzdy-PizQj7XjfwgipN3Zfc4US2JK3w>
    <xmx:0baHaCEZ5nh3hILLIkPqPZclbe6t4nk2MvPXcxbp83c9jhMFHudsNg>
    <xmx:0baHaBShMVNGe9YO1nRfqIaSYSQbOWlfiKN3SX79RUDOj1Uz7pO12g>
    <xmx:0baHaOfOutCKA4XoLZgYWqbKHR29HlTJNwy5A3aU1ovvXxN5FlAkmA>
    <xmx:0baHaH8-IQDNlyhccUPyAF1-hse4ldUCA3rz5B_NEBW2Z2d6YCsgC5hj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 13:43:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>
Subject: Re: [PATCH 4/4] builtin/remote: only iterate through refs that are
 to be renamed
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-4-f654f2b5c5ae@pks.im>
	(Patrick Steinhardt's message of "Mon, 28 Jul 2025 15:08:48 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250728-pks-remote-rename-improvements-v1-4-f654f2b5c5ae@pks.im>
Date: Mon, 28 Jul 2025 10:43:43 -0700
Message-ID: <xmqq7bzsw6r4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When renaming a remote we also need to rename all references
> accordingly. But while we only need to rename references that are
> contained in the "refs/remotes/$OLDNAME/" namespace, we end up using
> `refs_for_each_rawref()` that iterates through _all_ references. We know
> to exit early in the callback in case we see an irrelevant reference,
> but ultimately this is still a waste of compute as we knowingly iterate
> through references that we won't ever care about.

Very true.  Even if we guarantee that callbacks are fed references in
lexicographic order, that would only allow us to stop iterationg
when we see an irrelevant one", and still would force us to skip
over all the irrelevant ones until we see the first one in scope.

It makes perfect sense to give us a way to say "iterate only in this
subhierarchy" like this step does.

Nice.
