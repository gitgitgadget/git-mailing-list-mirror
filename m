Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86B22F397
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621115; cv=none; b=CZ/flbm/kehywgwowPrqF1kNQ5dIwOboxKd8/wa5sAZn743ysa073Z7JGXpQDPOyB9UkhFtnH/vSBa64ppC6AMw7uYSYrVJ7eqtpmwnkgIi/a/uKr1yqeomlQxWkL7hgfLeMIjE/U+JiGCTMawC1drfttl41D7G/6dy7OXkkqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621115; c=relaxed/simple;
	bh=r0MWG21tPppKdpiTpqNI1gznZS2UENK2PCInplr5DuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SNOJh/888XtQm9AuEisNlKNvzenAitIUOrmUItP4H8IKdKVaMUs9qgjAJJI4V6KvU2/5BFKzSJOZLSI3U8E//OgD76YRxnSqHINB9lGeAgA8dAN+D2xtNh4FhN9hmafB2OyulpBUhd23mJixxG/MrPr4TaO/O/S9hCZConUWP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XgEdiBv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fznsNie+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XgEdiBv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fznsNie+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9544C1140164;
	Mon, 10 Mar 2025 11:38:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Mar 2025 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741621112; x=1741707512; bh=AihMgWx/kp
	6rIpeCk1cXjiB7lHRBeVYRoFC3WPbyXaA=; b=XgEdiBv7oY0Jl+8ZOWL6llM03I
	vfp+IX+0Dial2kWltj9OSuG7LmFmw1pvYCz4UztfLuDdH0/wAP2clj37eIjwNePG
	7p9UFgcQjwbTKllBXZsEZcjaAKocOhH2p21Byo5Qd7hCxpgLkMuUQwXb9ISEtbD1
	/5lqhULrLS5rJka8ccUprDN1A0wVb9FuaBwsR4bp0KNgeICWpOaxelpS5FdaaFZ1
	th608RdX0dCBDF9EIJ9CpnpC37Y8Vhobq2bDI0xPcozN7zqck0eln4lqJLP9QTi/
	vfnAZeyl4vZZLcucK9ETSgoHKOrovpVgoSUEbaxD8Q00jelIb++hszMMubVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741621112; x=1741707512; bh=AihMgWx/kp6rIpeCk1cXjiB7lHRBeVYRoFC
	3WPbyXaA=; b=fznsNie+ytTYXpZeqlkd/EVY5Kfttogo4f8auQS0PgEWkySLMFf
	hcVsCqC6cIyJyHC4eIGAhrBluuBHpgNJe9oDyMxat1y7DD8K06GR+6fFpestyRxB
	a+4ajLamjX3BctmgLLaM84LcRx4VOQef4662LgHIwBHGQgMj8+7Po4IknpBaUlr/
	JJeEygKjLVaevis2pxxxBTkK9ALC8ZIrq6DBl33fiqPna7iieR95kMrtE/3RRyCp
	Vhv58Cy0VUjW2/5PejIBqfmWfAilJmOZDPQqivkQhuwKv1UT1Z5C0/2WTdC0zuKK
	Cg2Pj0trCIRx4NdGiK0f7qztj0u9ignIa7A==
X-ME-Sender: <xms:eAfPZ7hO9WDut56t1DyJ34DfVQL6IQy0eYsU0jqeKbdZ-w1FEsVkHA>
    <xme:eAfPZ4DwwRbxFqPDGtHyEdgdlXa-7h9o-U0ZGWpulIBYh8iJzci0vIDESFyE170XT
    xH8IhNWfdfEz5C-9Q>
X-ME-Received: <xmr:eAfPZ7G-BpxCzVDOm9wNuKvzkHMAppUv7Fv7e9bu-5rf_REg-_In-ddmK1lPfw8ALMKuLuh1Ly4JUw7nce2vjG6mYCmmbUfqj8DG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eAfPZ4SjQQyfiwAIURb_cQJPRPctEuItICVmEMqu5jFyhdsby_8H6g>
    <xmx:eAfPZ4z7zqIF143oq7DKJQefkaIHLvpiacjVzyYHe-YwJWIs9cTPdA>
    <xmx:eAfPZ-5-FxaoySiO5I75p6IM-8quTd6OUu2a5AJRT7toUm9SBM2eEg>
    <xmx:eAfPZ9xwEF71QnIhbvKnwOjlJ_5bhrP98PS42kPadd3wd1lFwqxzbA>
    <xmx:eAfPZ_nRs98mX_MVE_JrskYSvOpOrIj7FczsvTSX_OJbMulgK-K6CRZg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 11:38:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
In-Reply-To: <CABPp-BG0AtKdUH2g8+_f0J0ViWs5xZKM9kCcbWYZ=uEu6bswdQ@mail.gmail.com>
	(Elijah Newren's message of "Sat, 8 Mar 2025 08:05:09 -0800")
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
	<20250307-b4-pks-objects-without-the-repository-v3-12-7bccf408731e@pks.im>
	<CABPp-BG0AtKdUH2g8+_f0J0ViWs5xZKM9kCcbWYZ=uEu6bswdQ@mail.gmail.com>
Date: Mon, 10 Mar 2025 08:38:30 -0700
Message-ID: <xmqqjz8waoax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> @@ -4304,7 +4304,7 @@ static int process_entry(struct merge_options *opt,
>>                 /* Deleted on both sides */
>>                 ci->merged.is_null = 1;
>>                 ci->merged.result.mode = 0;
>> -               oidcpy(&ci->merged.result.oid, null_oid());
>> +               oidcpy(&ci->merged.result.oid, null_oid(the_hash_algo));
>>                 assert(!ci->df_conflict);
>>                 ci->merged.clean = !ci->path_conflict;
>>         }
>
> What you have is an improvement since it's at least making things
> explicit, but these should really be opt->repo->hash_algo.

I think this is following the typical pattern in recent topics of
this sort, i.e. first make things explicit and use "the" singleton
instance, with the plan to find if there are instances more
appropriate in the context.  When we passed a repo instance through
the call chain, the caller at the root may have passed the_repository
down the call chain, to make sure everybody down below will be
bug-to-bug compatible (because they either used the_repository or
used a helper that implicitly always used the_repository).  This is
doing the same, and your "but these should really be" belongs to the
"with the plan to find" phase, which may come later but outside the
scope of this series.

Incidentally, that is the reason why the use of superproject
repository instead of the_repository was singled out in the proposed
commit log message.  It should have been mechanical replacement to
make this step mechanical and easier to audit, but with another
topic in flight that semantically conflicts the changes in ths
patch, it took an exception.

