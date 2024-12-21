Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF72F5A
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734803826; cv=none; b=MnzxOFU48xYxxwkMmedjOIymX9f+1I5WIN0lm+UJ2Iu73OUCcVOLzXs7zckh7QWdgmylyHrZ3tl8AIHqLsiwrFgkLpbosjANkcb2qPdh1YdAmul5GD/eiCRoY/4MbXxLZld6G5n7KZGu2RGL1Ememq60UTo4vTl33a3IMW8bV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734803826; c=relaxed/simple;
	bh=fYoXTgwUscP4jciqQOgp4kAXVPV8o4BRomIRzz5rw7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lr1nr+Bc9Fojnfd3i840GAmoBGyxeu3xWJY4Garr6FHHcIPXX08dRFkjOH21TstEvIjDAUEOn5Dd2PUfgzAScD50MO66zA4t2lgfz1xDhwaEUT9XSyA+2/V1abucv9wOyhiOnBks4stJz1qxeKKj/XJ9LGPT3rdYtabnmBsQlI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tAKCIa/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRdamM3t; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tAKCIa/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRdamM3t"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 604101380188;
	Sat, 21 Dec 2024 12:57:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 21 Dec 2024 12:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734803823; x=1734890223; bh=GL5dpOFJaA
	czwzXKoBNCp3pXZgEjHV1aFOK/ZkpeT0k=; b=tAKCIa/cNr1R/YJ/m00ujgpCu7
	0X+JQgZorUP6CpBoCvc/WoyICtxv5MP7pEZA6MXhkO/KY8TaKRn0Ipwgah8u7o8r
	edIj2NNm1G2UZVmtmmqRY17zXqk6e+2wD8xDyua0s17WVV7t4ZWLsj0X8kjY8a1G
	RYtTPAPIUO0b2go9vugMHsfYTYpSGRr/9aeGLOzhK90VNoIs+DQiuW+cP+Q+QP/D
	t1rOwxr5ArqScSPBM4gDqXvT3cVrIBKdy53W7KtL4/aWC5Lf3gs78nTlPpKeBzkN
	+s2FjUGY4dBrnjg7pGn5sUIQy6m4ASHEff2djFElPJDgR3tc+QgFIbP60tbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734803823; x=1734890223; bh=GL5dpOFJaAczwzXKoBNCp3pXZgEjHV1aFOK
	/ZkpeT0k=; b=KRdamM3tJd7L3z+QOgU0ajkz3KlsleZf/fQ/bGJhFoUt+Xt/ufT
	Z4KfUv+UD9Qje90lzePt5JbLgagZ12CdinODPMfrU7wclFwIdL3PfRI/ivv03u1t
	+XZlvcxpFod/t9HVEHN+AQ7/bSyaXPFsn0XVXIkOACFgTReKe7cVH0WVEt/bDOu4
	+MsOOJLP5FZoou1BGUkcqnzMN6kzPPkXLlZOeQMUTroAGXKHv+m77ijBNO8TT+K5
	ELanAd5Wus6AVx1RT/uBRzWgxR4WtwBkhlF/cwhociQNTEbAWsnnuo/824fEje0X
	OjW5PbyUUB8erTL5/6+n4qyAOYBtzxi5EOg==
X-ME-Sender: <xms:bwFnZ5WfcQyQZNDXN3RSwI1OkQV7Nin3X8AASgywriANZOHteBW4zA>
    <xme:bwFnZ5nsEv0rM185ApadEctKRVhbSzGwketGhzOHtJ5G3bkUehYOazNkY6xEDlthf
    OsrDXR287LQsf5BGw>
X-ME-Received: <xmr:bwFnZ1aLDISKaPP71El_Tx0IL-qZCAiIccA2NUlRF5dfmjKzJR8qLOp6fFucnZDefZQXsFhr71zzAK9ayCPGSm210yQwx_2o5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bwFnZ8UDsspwWExPs3QOScRsL2V3DY1f_ktqWNE-OAMlWs_WZOHrJg>
    <xmx:bwFnZzldDsnw5fEiXgxX63dgk0aisjyGctC0IryWxLztmOAhH8YtOg>
    <xmx:bwFnZ5eDUWLJFMymv5dyw6YGojntPpOqrCbnw8IeOWAvMQuADTK06A>
    <xmx:bwFnZ9FCwMzv8uhCD-AQ7YUke8n0HHd1zZNhP7T1wBFOP3wTxnVqkQ>
    <xmx:bwFnZ8D6bpouUXnfyoVRHLyqZNrDXZOSq_JVPFAMnWDueNB3AvNVCYeG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 12:57:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when
 there are no readers
In-Reply-To: <xmqq34ihc4zt.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	21 Dec 2024 09:36:54 -0800")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
	<xmqq34ihc4zt.fsf@gitster.g>
Date: Sat, 21 Dec 2024 09:57:01 -0800
Message-ID: <xmqqmsgoc42a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>  reftable/stack.c | 44 +++++++++++++++++++++++---------------------
>>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> This somehow did not cleanly apply, so I whiggled it in manually.

That is because I usually ignore author-supplied base, and this time
I used the tip of ps/reftable-alloc-failures topic, which brings all
the text these four patches touch, in my initial attempt.

Applying these on the author-supplied base (ff795a5c5e) yields the
same tree as the result of merging my manual application of these
four patches to ps/reftable-alloc-failures into the same base.
