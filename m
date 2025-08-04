Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963C271458
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317768; cv=none; b=RyDLzWabrvwIdOwjBpg70klJ/oaAsn5ddODNfalpjeWGwfyKTOKITosON0FRpy1BQ9AIUZlaqZXb77aZ3t8TTbS8gof1QmzYmQOZPFbt8jE/cgdCOO36rcvsC6qz2nmjUX8pytTbtf5IKuS1sOmXFJ+Q0Gq600Pu4huTkCl2OQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317768; c=relaxed/simple;
	bh=sthcfyb0/C6ONmeACF3YS5Yfr5F7FW8oIxegMTabTQs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AtgNZ+Wl1lkCZNz2n59XblUyvurS/M9sMrPXGHn3UeNQs5k+7Q2MW4ixsGKN4/prDkbZQIJdoVnh9Wvf8mvvBpqSD77t+vMlL0XcEyMFPIgjBM/dDnSRAV5LPBcxvdGYHcnD9k+vdckvqHtZYNyKfpoyFxEsciVFNiZLi6ibVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QXx5jlaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aElZwgM2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QXx5jlaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aElZwgM2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75052140012F;
	Mon,  4 Aug 2025 10:29:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 04 Aug 2025 10:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754317765; x=1754404165; bh=fwDDnSxLp4
	n9atW50xTGxp1K7suvrj6ofWxinsGYikc=; b=QXx5jlaL7zuo/Or0k3uCTl1M1f
	k85b5DT7urG9yVDnppb5dFgek3P10qFjB+u5GL0FGhCsTzJ//yk9Ssf88Ee+ocbU
	euD8yEhpFZZonoxxyFwXZIE9Gd+IoxENwSz3oW0dOePZWl4fufZrn2euLV8cJIzu
	NTZWMb1/r2/Cl3kqpcakrIdPg466lh/mCB3WlSHKYF2WXmgC1rhRGriHLxEZYAxu
	ZVc6nODlR3EwOPXZTPBxTQZZuVlt1+iuaNNwJIrr8MoE/FCFb7a57KR6qutk7bJl
	/h8TzDr+CZI25r2vmxgcuJymk+1gxIYa+ACneIbDRRKTtGfh6whT+F2Vk4Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754317765; x=1754404165; bh=fwDDnSxLp4n9atW50xTGxp1K7suvrj6ofWx
	insGYikc=; b=aElZwgM2J/eqChX6N0MbKNZhPNcty4/P4ryqraYZwLnHS2mHzu1
	Qaqsp0HZ4oL6px3//V4uIKGHml8xeyKy+KP1wO46E2briqFfF7lJ8aLMVlW93luJ
	8PAz1hNjd/9Zo4bKkgKf3wvRVQDKTl9QXnXjlaichJU1qvHKCA6xmYatlzT02wRu
	FILyPkbgQo+slUJA6aDnyeQc256kwjGwtGn+ZRXGsZdNV67rZjHTQRXZ3jVgtSI9
	II1LkKNVotOJRfmOcWNU/y6hcMhr22C3E7wk9FdgTh3nlPgpCTWEvpZIXCvDmOA+
	dZhqRL2/CZYTws6/tZnH8yVo2HcaEcKZjDQ==
X-ME-Sender: <xms:xcOQaIg7LM_2fDvdVlNd7-t_6C4j4Hjr-eq-TB-QppUbbS-eT1pdwQ>
    <xme:xcOQaLmWmzJmIhmb0lay2uWC7SyN_LYp_j856zttfaXSfmHAvYEeqoykH9B5Ub7gI
    ChE760hmzPKYrFq_g>
X-ME-Received: <xmr:xcOQaMpwVY938t52wmf-b16YkLgo4S4b_5DGjLqFAvPls-v4D63jP5L2zCrYjyn1_HzYpcdGy1wNVkBY-GFEfC3WiWx-9HB6qdn15rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xcOQaMG3L55vI6bHqWLOqURxRdE0lStvS3xoZqTugaIJdky6BEZhfw>
    <xmx:xcOQaAzx6kujzYeza5a3aVvs6bXAXtFQUQ8CCOilpGCM7tIO7gVXIQ>
    <xmx:xcOQaJp9lI6Spm6K4Do7kz3tjJaD6oTEMM4G2VcQP9Xm_-eqxgkXZw>
    <xmx:xcOQaCi9No-T9X9CfdF0mgQYRK37vTfTzLQR0sQbXmN6ErrZnJkBhg>
    <xmx:xcOQaDOTSmWKXH81FBQZijGI-Bjp6lFAy9TrtP6lE3K6LDpRrz9GV3Rn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 10:29:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <aJCBlnHp-db4Nd5w@pks.im> (Patrick Steinhardt's message of "Mon,
	4 Aug 2025 11:47:02 +0200")
References: <xmqqms8fbilv.fsf@gitster.g> <aJCBlnHp-db4Nd5w@pks.im>
Date: Mon, 04 Aug 2025 07:29:23 -0700
Message-ID: <xmqqqzxr88jg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 04, 2025 at 01:23:40AM -0700, Junio C Hamano wrote:
>> * ps/remote-rename-fix (2025-07-31) 7 commits
>>  - builtin/remote: only iterate through refs that are to be renamed
>>  - builtin/remote: rework how remote refs get renamed
>>  - builtin/remote: determine whether refs need renaming early on
>>  - builtin/remote: fix sign comparison warnings
>>  - refs: simplify logic when migrating reflog entries
>>  - refs: pass refname when invoking reflog entry callback
>>  - Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
>>  (this branch uses ps/reflog-migrate-fixes.)
>> 
>>  "git remote rename origin upstream" failed to move origin/HEAD to
>>  upstream/HEAD when origin/HEAD is unborn and performed other
>>  renames extremely inefficiently, which has been corrected.
>> 
>>  Will merge to 'next'?
>>  source: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
>
> I've sent one more version of this patch series for a couple of final
> finishing touches. If Peff is happy with that version I'm happy to see
> it merged.

Hmph, you have?

>
>> * ps/reflog-migrate-fixes (2025-07-29) 9 commits
>>  - refs: fix invalid old object IDs when migrating reflogs
>>  - refs: stop unsetting REF_HAVE_OLD for log-only updates
>>  - refs/files: detect race when generating reflog entry for HEAD
>>  - refs: fix identity for migrated reflogs
>>  - ident: fix type of string length parameter
>>  - builtin/reflog: implement subcommand to write new entries
>>  - refs: export `ref_transaction_update_reflog()`
>>  - builtin/reflog: improve grouping of subcommands
>>  - Documentation/git-reflog: convert to use synopsis type
>>  (this branch is used by ps/remote-rename-fix.)
>> 
>>  "git refs migrate" to migrate the reflog entries from a refs
>>  backend to another had a handful of bugs squashed.
>> 
>>  Will merge to 'next'?
>>  source: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
>
> I'm happy with this version, so if the above goes in I think this one
> here can also be merged.

You have an update for this one.  Perhaps your comments are swapped
between these two topics?

