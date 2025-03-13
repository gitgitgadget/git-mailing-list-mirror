Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB921CAA6E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890852; cv=none; b=D1G+2YyWPYnYJQnLtOA+BJWlI6icbgGJstKB6rZ3XXEF7sdHj9iqE+4DCHkHGcyfzg1cWmoUqnp1fPeoQ/ki4hRL2rpiG9z0hDEPacdbbruzbk+mJ3tMYwYJ1jUGgOmSxG1LcpcoUkXcD+gBlPzwfApF1x2DF0fsNyBzGSKQ+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890852; c=relaxed/simple;
	bh=RZJpMuPmegET4YGnMycyTYvEeTN6/rF2042aeZ977Lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HiukMqU7sWYllTQFOENesTzBLjseFkmgKWfhttojMBk9swhACjDj0gy8iDmK79PqetYpflV40PsA76LyHe4HZ2IeXJ6Blm9akxJK2XconECSv/ZUYynUn7g9wWsWRSxamOO00sbRF/l0K9hhkJS25i0/b5fRPKAYBXkQb818MD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ywqw/Atu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hccu27mD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ywqw/Atu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hccu27mD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FE171140229;
	Thu, 13 Mar 2025 14:34:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 13 Mar 2025 14:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741890849; x=1741977249; bh=idzOCk3voL
	JNOyflqGm7APsgtI5DMBeWok47P6WpZQM=; b=Ywqw/Atuoqn6RFcR7ifMpbze60
	bJiNT2jtG564/cweahfO11AqWtiqgsr7kjT3m5VM2nuynYxN0RHwbqr2SPFNH/ZI
	eszt+yIlYF4ziupOKMXgjWdxXvz9HYtQuZIpegV7eb1vyf6JVJsw/Z52Fen3dq0w
	vFUv14FQHnoyqvlKgOlOTTT5aim1gIwGeJC5f2fwEOoEY7BhXato7GjPZCVPDDbb
	uSSpklGgR6xQGctGRwIpsCBzGw5RNPneZy7kLUV2dQv4kNGtP7NiJ0z2nZbCpU5J
	4SGfkfyKmuHLahXQdNWzF6jJQZzCA80OIcD8mrgmWA1g/sqDoa9bQCJxubEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741890849; x=1741977249; bh=idzOCk3voLJNOyflqGm7APsgtI5DMBeWok4
	7P6WpZQM=; b=Hccu27mD5/68dGp439U681v4eU3u8qM/k5uZWUT4bEmCuEc1c4S
	AJg3cU39QJCA7LvMAdONXNPJqZ8Nub9Y7qo38Ipk7XLqybZqMHaSQvqm9p7boofp
	mj6zYd8Vpz/x2jkPubCYc9lqTSn5tfjw36Qw5pWXqvQU5Uh0ItnIB8GfN8MMb9RH
	qEhrEBTky3dnHQVHN8NEIrn877lt/b+WIG25oeancoJ43LxrbjqdbnaSj0rOe3Tl
	2QEUpmmuQ2Ht+/z6YZhWA6vpvrYz3qRZx91APo6J6pVjj/7HWPlwW+bl89w7TUHq
	0osVI+tKbbg+qg4ZflJyfRZUSzx2l7nblrw==
X-ME-Sender: <xms:ICXTZ3-F3zd70fAwM6LJ5H-defc0h4WXTcN66iza4byaeiLv4ByEPg>
    <xme:ICXTZzsNJheuvaKhQ-XEsGwH_6roCNudMJvUzfmt6xtJR7bEuQH0rfmswa4iPojas
    2NBAf7xmDkv8mofTQ>
X-ME-Received: <xmr:ICXTZ1D82l7Kz1EKzp36gKVjTpZYrCmOA2vySyCdfTAK7gZfeqiczEkE15L_Db_SnT0W-LZUrV4ek5G3jasTHgU-mhWHpnps3kCUWz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughgohhntghhrghr
    ohhvsehushgvrhhsrdhsfhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:ISXTZze6kGAwD5MRPaVaNiWjbUixPryiJlkHjN1s-Bl3Etn9qsRQAw>
    <xmx:ISXTZ8N35L0Llb_rv15cYmTi2GeExWYPY5Wix_tZN4xWGGHJuXWoNw>
    <xmx:ISXTZ1nMiiDECz3mn070JXroaQ-6x7R0E8dcwzj-K8WHJeviU5EbAw>
    <xmx:ISXTZ2uJWpH-EPEMYZ_PT9LS2BPfgxESBYQX8j96U2AaEsQ9zlDf_g>
    <xmx:ISXTZ4BIxbf1R_K0XeSB9L1Qx7IN0NT2cWFGQ2ad-77AdGUPLG0bN54E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 14:34:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Dmitry Goncharov
 <dgoncharov@users.sf.net>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for
 rename-to-self
In-Reply-To: <CABPp-BF01a8bEZ2mfp7H_=HKsv6mSE4+ee8bi9D9xKWbH=0b5g@mail.gmail.com>
	(Elijah Newren's message of "Thu, 13 Mar 2025 10:15:49 -0700")
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
	<f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
	<Z9ID/2zx25qesuJs@nand.local>
	<CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
	<xmqqr031x2gg.fsf@gitster.g>
	<CABPp-BF7iTvqKFvuOZ5wZ3vZADjCvB63iKR-4D5+WeTxnZGThg@mail.gmail.com>
	<xmqqbju4q39j.fsf@gitster.g>
	<CABPp-BF01a8bEZ2mfp7H_=HKsv6mSE4+ee8bi9D9xKWbH=0b5g@mail.gmail.com>
Date: Thu, 13 Mar 2025 11:34:07 -0700
Message-ID: <xmqqcyekok4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> "if (condition) BUG()" is invalid; it needs more arguments.  "if
> (condition) BUG(something)" requires a separate "something", which
> requires awkward additional wording and/or is needlessly duplicative.

Ah, obviously we differ on that point.

I consider it an advantage that <something> can be more descriptive
in a developer friendly way than <condition> expression alone.  If
you wrote

	if (istate->cache_nr < i)
		BUG("ran past the end of the istate->cache[] array?");

you can spot a bug of the assertion, because the human-readable part
tells us the intention that the condition is supposed to be the
usual array bounds check, and should be checking with "<=".  In
contrast

	BUG_ON(istate->cache_nr < i);

does not give us the extra information we can use to double check
what the developer who wrote it, who may not be with us anymore,
wanted to really check.  Is it a misspelt "<=", or does this code
path use 'i' not just as a variable to iterate over the array but
also allows it to go one past its end, so "<" is the condition it
really wants to validate?

> If you don't want to see assert in the codebase because of NDEBUG,
> then obviously we'd leave NDEBUG out of BUG_ON().

Absolutely, because the largest problem with assert() is that the
condition can be compiled away while the compiler does not help
ensure that the condition part is free of side effects.  If we drop
NDEBUG, that problem goes away.

> Such a BUG_ON() would be an improvement because it maintains the
> ergonomics of assert() while avoiding the potential mistake of
> accidentally including something with side-effects.  

Yes, we are half on the same page (as I disagree that assert() that
does not give a room to explain why we are checking the condition is
ergonomic at all) and agree that discarding NDEBUG gives us safer
variant than assert().

> "If (condition)
> BUG(something)" doesn't preserve the ergonomics and is thus worse,

Again, this is philosophical difference between us.  It gives us the
same safety as NDEBUG-less BUG_ON() but allows us to be more
descriptive to help developers.  While I understand sometimes the
condition may be self evident (especially while developing new code,
where the developer thought the problem long and deep) and people
may find it tedious to have to explain the reasoning behind the
check, I find it highly problematic not to give room to explain to
those who want to.  And /* comments */ is not the same thing, as I
think it is important to explain your BUG() well, just like it is
good practice to explain your commit well in the log message.

One thing I view as a downside of "if (condition) BUG(message)" is
that it does not make it clear syntactically that (condition) is
about assertion, and you can write

	if (condition) {
		do something;
		BUG(message);
	}

which probably is not what you want.  I am OK with

	BUG_ON(<condition>, <message>);

which would make such a construct impossible.

Thanks.
