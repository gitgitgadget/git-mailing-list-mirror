Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9F200BB3
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383918; cv=none; b=EfaA/XXdyy+O/6viWedByIhl5bE3AkrMNfkELdzE3ENPPuZUrlSajoUIKDyZATcvChG1WQRz2N1fjBaKv0KTH4xtKoH+j0iIuh7jAYgP3UZNdIqvF5J1w2pTH3fTFRjR8dY5PVd/q5u+MDDLMeG+0T9vYYfP14YL+ypKEEG/AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383918; c=relaxed/simple;
	bh=2zwAMREt17g7qAf3JrZ6HZopMpYYP1GhJsDiOM1Ru90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZFyehiyHv+RBa5p2mVWuXiwnCr5uwdcBvWvKsJdAIYdH62Jz9XF8zFqWQa+0On9+3hUb95V2XS/gzlH+gK7TRZcCfaNfR3lL0Cgmo/U+gdcvZBSs/NSymG6K1N0+lGaj5nx9jy/Ufh2g6Kv25ilH2XCzKOsinRamnTUWHa2C2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WOCm+inb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/Hav8s8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WOCm+inb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/Hav8s8"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EA4611401BE;
	Fri,  7 Mar 2025 16:45:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 16:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741383916; x=1741470316; bh=hPmup/wztf
	JtMbQ6kKO37oFet471w8zLr/kAXdHIRCQ=; b=WOCm+inbyNFR+wWLhRCJUB0hke
	8a+atOVXTeeFI6dXygLIaqpcibJl91wAri1b5gWCbbYvmj+pf7XeTqmqFWaw+6WV
	8BEqwWHhcrg8lJt05yV3wiWBpxSlrcktSpRUAZhmnSSOFaqNa5k06kMEeSJmywZe
	Xy9lDX9JZyMKauk7D+OMGmzsncP15lHGY+Irpcfj8B2LDvHZZpjaIryhmg4xLCzv
	JxoVkDoaMCyBIjcT256Xp6HMkYUN2pDOxe3H7Y4MCtnHw45Fs86kofbqaCiwY7qb
	cRQBysSTHYC49kiBkioxJtMyqP3R/3aVA1CT2VnkY24unWvsqA7b3rocllYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741383916; x=1741470316; bh=hPmup/wztfJtMbQ6kKO37oFet471w8zLr/k
	AXdHIRCQ=; b=q/Hav8s87HR8UZsYrHvL1cX8jB9+brd14DDyUKrOVYbgeyTwxo4
	mYv3gsOU+kifB7ZASirzcRDX5kSIvUYF0DB98m1C8PSRgPXB6zQmTlZJp1ZG9JbP
	v5k42XcvEudZOyA6TARI20BrSP/2RB+hlg8eDCYULtgeRR7KKu5kE27+PSB9wIgx
	Z1c/vCgBy8Mwgwn9IxqPI5pv/x5lsRL+7ZQqQOWwqGY6dyqoYlaKIHSnbCBPq5Ue
	b6knPkn5u8wI+yO3e1W+Qe04C0BOs2BDvko9/k/tWCL+XTp0pwgZ37uiJL1ojpgo
	yXkaDgQuhob5ve1tDpRPmjB2UX2sfUEdX4w==
X-ME-Sender: <xms:62jLZyOE5YXBSYjRAj_qNVzlYWuNBZFkrQxHLoQXS3PfTJ8ZBfgTlw>
    <xme:62jLZw_RqqknVOsbMBYTL_LK720fIbrtd_9djR_gKyLTRQkVkgOtOmJVNeNryw_GL
    Dcu6BLmTyHbZERS8A>
X-ME-Received: <xmr:62jLZ5TVwmgjrfd59PbSwjDyoj-8bDgwwn-i2d6SsvPbksqDXxqojejz4iWVKqdLKQ3ZFkwwSDrCihpx-9A118m8YzsrRbc0Ascu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddujeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesmh
    grnhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7GjLZytUKyilUUE5Wd4zAKmr5A2Gdbmf8V996lfPcN5BPPFKvQ1uCw>
    <xmx:7GjLZ6c8-SW4LNp8NbrAq2R-KvLK5wUv7pas-WolrgkkLCE1Txg1sw>
    <xmx:7GjLZ215d1RF2knGZaac56iefbcyhuYcESBdVA_OeMHbmJgkClcUWA>
    <xmx:7GjLZ-8yEDefML5HP8UnXcIT2xqG6i5uPsK46M8a3k3THIpOOMvmjQ>
    <xmx:7GjLZ3F9ra8dMBgdEbwmBw9-6aRNJRDUXpJdv7QJhrLqOfgx6dhNN7UL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 16:45:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
In-Reply-To: <1192682c-b68d-429d-9852-15ab627d711f@mandelberg.org> (David
	Mandelberg's message of "Fri, 7 Mar 2025 16:38:51 -0500")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
	<xmqqh645hopj.fsf@gitster.g>
	<05bf397e-4bc2-4255-87b5-925c80667f4c@mandelberg.org>
	<xmqqtt84d0dz.fsf@gitster.g>
	<1192682c-b68d-429d-9852-15ab627d711f@mandelberg.org>
Date: Fri, 07 Mar 2025 13:45:14 -0800
Message-ID: <xmqq4j04cy6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Mandelberg <david@mandelberg.org> writes:

>> As a remote name, we still do use "is that a
>> file on the filesystem?" to see if it is a local file:// URL
>> (i.e. "git fetch github/dseomn" may be fetching from a subdirectory
>> two levels down)
>
> Btw, I just tested it, and I think this is an issue for remote names
> without slashes too:

Yes, and that is an intended way local repositories are discovered
and used.

The problem with slashes is that the mistake surface becomes a lot
larger.  "ls<RETURN>" would show you "origin" immediately in the
current working directory, but you wouldn't know if origin has
origin/foo or origin/bar unless you look.  Limiting the local
filesystem reference to something like "only the ones that has no
slashes, or begin with ../ or /" would make it less likely that you
meant to push to somewhere and instead push to a local directory.

