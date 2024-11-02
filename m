Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5D1BC41
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513307; cv=none; b=JF1HLfwzw1tY88fniKFsNd7Yma/7gIzx7FttN621sDmMYl310gdcswDV/ia/bO0Tl1RqIL3RgJXf7qIzXHtTdKO6sEkTJsrBDFj+gIpiRNSr79JncV9uwT1AwLZAorFEqQnQkJbRVyyWXVV65375sL0VxmUP16K2CqJKGvPdBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513307; c=relaxed/simple;
	bh=0Iv4e8luMDiAQo4q4JEMFn/P9nK6YmnFK4KGtX+/CIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQw/TPNDpwf5FDyNpYBwy0zGvjiFWsN5FFEcWfIC4QbEKIdQauppMxI7tNh7GPg09VC/py1T1Ue3wUhg+NCilS50hMNjqjtaGCxV9fPYTDjiejNwOQJa0vM8DKHoh8thlq9vPG+IOjaX0fxWzwRVlY6mvCYMnkc2zRgrBhDdCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EORIDO/t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUZwXW/Z; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EORIDO/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUZwXW/Z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EB121140174;
	Fri,  1 Nov 2024 22:08:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 01 Nov 2024 22:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730513304; x=1730599704; bh=dYMsPQfm+N
	USSQkzSMEiVYPOHHCAojde8KA7XZwcxc8=; b=EORIDO/tEITwf7/6ec1UPA4r/B
	mK6Qqa4Bl9ltJvvDRo71M0kxamkB36JMTZzC66prCg3avpCIfLFGy4/EWbeom1ku
	ql/rdBkj3IcSRq5RRnXuWIyUs+tFpSl6NGa9OvSuCVQD+rukR3zJcr4Pr/R9Hgp3
	DKwJs8AiPtyKsvj3F4h6rODTXtfF+dE7/3vQesdP5tCV3Jr1yX9FhExs9jnvoTZl
	unDLv6cgjxaOhAEOceaLgwfIOKULfQDlC2nWbvK/Wy8rJArTs9uv+A8IviiO6BSY
	c1P2mHjc9HHf3/Jtsx9pnFxWjL5OeQXEdbR8D7KEsVTiGw3ZpcCLlnk5Ipdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730513304; x=1730599704; bh=dYMsPQfm+NUSSQkzSMEiVYPOHHCAojde8KA
	7XZwcxc8=; b=IUZwXW/Zxjg1No3sCKHQtZ53zEOP6b5kbe24XYNYZ3SQNDowToY
	9dADwPRjzek49VzqZcFW6MN4UU7WFM9Sp3OlMCqObnK4FyABJg2zQqQMT19RnN87
	Pm181soYs3sYPOxjCWZkIeY3pVvhnAteKsszwql0oTGkf2ruHTHVxH0WW+WCaYW5
	5sZsd18iSR45/z42jlZZ8kKza3rzyRFcjurgWE9IMVGGpPVg0nD6hUCXRv0Udo37
	OiPR34TjNJNeHoUtPnWbUgf9XS6GLGu0mo7WGddMj8m3X1FOEJujtsaoZgKUbe3W
	PECxgB9DpWNtCRDvkFQV4PGOJx9le+O0GGw==
X-ME-Sender: <xms:l4klZ3lyYJ_UKLb1rdnuVqrgdNK6MiA0gSVAL_XLKRd_Q3fBvVOE6A>
    <xme:l4klZ62Pa0BQP4W7rOh6wJ180LThqbx18__AWSQYqhhTKJwZsYJ-9C5YFd4n_RSn7
    NMbPnVZy4a4SEtCPg>
X-ME-Received: <xmr:l4klZ9ryvYE1qM34TAaVfq8i1zSJVrmF68c8gdKJgd3NYWWhCgw3fe25d5IGqanMVHETu0KmTPFQtHIp2bw_MJPHFvphsUFPuPG7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggr
    ughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohephhgrnhigihhnrdhhgiessgihthgvuggrnhgtvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l4klZ_mu6xcL8HUGYwnGw9JcqT--1-4AzoJ_JlOttVT2sANU8UtuqA>
    <xmx:l4klZ136XGYK4TAGaEXJiOHL7kHa6TZCj_0190nJiCWAZXizYNZ_tA>
    <xmx:l4klZ-vDKBOV-LuBzPj9rq4ZKNwaBLLMBKGMCAhr0o7qGLV5TaGksg>
    <xmx:l4klZ5UeoqHduj4BAwNHfByiko3X0No-uuol5luHC56BgaT9lPMhiA>
    <xmx:mIklZ_pnoyJQVjXk2k2xh9v2IlwDWkrGH44ryKGVp-ji8gZpYlyGVLF8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 22:08:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  me@ttaylorr.com,
  hanxin.hx@bytedance.com
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
In-Reply-To: <20241101174054.684519-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Fri, 1 Nov 2024 10:40:54 -0700")
References: <20241101174054.684519-1-jonathantanmy@google.com>
Date: Fri, 01 Nov 2024 19:08:22 -0700
Message-ID: <xmqqttcqz8tl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> >>  	commit = lookup_commit_in_graph(the_repository, oid);
>> >> -	if (commit)
>> >> +	if (commit) {
>> >> +		if (mark_tags_complete_and_check_obj_db) {
>> >> +			if (!has_object(the_repository, oid, 0))
>> >> +				die_in_commit_graph_only(oid);
>> >> +		}
>> >>  		return commit;
>> >> +	}
>> >
>> > Hmph, even when we are not doing the mark-tags-complete thing,
>> > wouldn't it be a fatal error if the commit graph claims a commit
>> > exists but we are missing it?
>> >
>> > It also makes me wonder if it would be sufficient to prevent us from
>> > saying "have X" if we just pretend as if lookup_commit_in_graph()
>> > returned NULL in this case.
>> 
>> Again, sorry for the noise.
>> 
>> I think the posted patch is better without either of these two,
>> simply because the "commit graph lies" case is a repository
>> corruption, and "git fsck" should catch such a corruption (and if
>> not, we should make sure it does).
>> 
>> The normal codepaths should assume a healthy working repository.
>> 
>> As has_object() is not without cost, an extra check is warranted
>> only because not checking will go into infinite recursion.  If it
>> does not make us fail in such an unpleasant way if we return such a
>> commit when we are not doing the mark-tags-complete thing (but makes
>> us fail in some other controlled way), not paying cost for an extra
>> check is the right thing.
>> 
>> Thanks.
>
> Just checking...by "the posted patch is better without either
> of these two", do you mean that we should not use has_object()
> here?

No, "these two" refers to two changes I hinted at in my message,
i.e. (1) regardless of mark_tags_complete_and_check_obj_db shouldn't
we check with has_object() and die? and (2) if we commit=NULL and
keep going, would it be sufficient to fix it?
