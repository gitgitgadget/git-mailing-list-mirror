Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC97192D8A
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054251; cv=none; b=eDyael8FX1cDPyBMS+Jn+CD8TitUWB5mAdQBqw2kLje0bqFyZjYOVcCvXro/6qPTACToxN1l7BLzc4vDS4Y4yzO3pSoQ02YIXWhhrr28bGXGzbX/lZccO6v07hSDaiQNtmDw0yADQHmn6ZCcq8k3UF8KDz9OJVYCK9guH/giRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054251; c=relaxed/simple;
	bh=qRkq2bviYlv55lraYrmiVXWdm5amYilChUUslyV/Kfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HYiPOd4tWDWq7OLO/XnIAB+CrnTGHxtPENf16AEArYxBbDKGqSefQjIPNFatRid4+JepPeMdGWBE+C8O9wV73BpW3jnIMx1s4aKLLPnS/+TA6mepub7Mila07BxeSaki7qn2ONlMxsc+pEg5R5TmUM3/BQwUTR0fi7XTro30VWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VeMsv0oY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ogM3RTs9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VeMsv0oY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogM3RTs9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DD717A0059;
	Tue, 21 Oct 2025 09:44:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 09:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761054247; x=1761140647; bh=jBnPqCp7JL
	9y1MOxjd+xwe+aijY5g3z+YqQTH3MdXqM=; b=VeMsv0oYHJMhc/t1zKPhaNGoDm
	63zlN9w37mMr2qg22hKniqogG4d5hPvmoz5wYJSgOH+Qd48tLkQyMHu+t6RgUKp4
	9h7LN00AGV9xEUgjW0Sd0lEK+ksotug0leMNXbXvbt9rNJy58WBtH8FGpd6/oldG
	AoeqV671gO/Fu4OyzsLAATa+yQuA3hysDbRBPPrap2EILAGkV9q/zZL/zVHCsaEc
	lK1TdJTu2yml89nwy1tvk0zv0pXaGeHla6o8KXn7XqPIa6KrdoSr9oSdXWDW57id
	HSuI7Gy0350cVdYXbShm0xhBraFPBVg9YjJwbJrYJHvPx0cQEb7hedu8BeGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761054247; x=1761140647; bh=jBnPqCp7JL9y1MOxjd+xwe+aijY5g3z+YqQ
	TH3MdXqM=; b=ogM3RTs9+LOswOZI8StVK01pMeTx6VgOGE/i9GdPaC9SP1SiPqL
	4VKfsOh7rX0EefIKnjQU8sEs+g6gHV/cCK3Z/qW4JeGYPahPj2f8AiXAUwpDkLYh
	C4/+TjWtW06pXyUZO6jWOE2qY5SvLr7fmooSWjsCOP3pIaVV0QKEOBkoxLPHMI8L
	RZQjfqe0SEd5A9QGo+2dnvsFjr5jEktHE75Rd3LJsbW0TAOy5C6ojzCBGzuOXi6h
	nKcARkvwbqtIGtB5phda6Ruzainhd4f9Fnnbs4U8lt4ayc0aBe0GsbqAAUgoYK4E
	bWU92v3QL2Bl6XwgdOZ+H0gKQrWOBwoUVAg==
X-ME-Sender: <xms:J473aJUavYhPdIgzK0EQFufybs598PN9h_josetU6NaQTRs5cL4slg>
    <xme:J473aAcW7_C6sP-GnBlftehC-uu8kH-cWJ3Xzoqemx_sk5IQjJv04B3tDDzbdTQ5c
    qJ98_WJgyza7B4GWcocv2cd5KltcofMUPfpLtBFz8L8Z7wMivvTNg>
X-ME-Received: <xmr:J473aNs9HWcUCFt-37CGM6ymkaXALj2L3EgMQ3go54f_b1iv1tWob_OZWGyVtp7Skq3obb5vVYLZo3Rkm01WYMyC3wFb_UAyw4T7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehluhgtrg
    hsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J473aH9Ci6KOwrU44UF_NnzG_xFy882pdz4RZaGT5kjm1yv8sZbqPA>
    <xmx:J473aA0nM_cie09sZMj12uNe1uKCnVf5aafP0ACB1lXPCQvxuwlijQ>
    <xmx:J473aECo1X-Nz_dSElIMn4FCeBCSbgu0PcRc43F8K8l7zFleplB2sQ>
    <xmx:J473aEdrW1RrwI4FAa8mjK8qH-62sgeAA9lVbFTvID2FF1AwTFAITA>
    <xmx:J473aHMZh1Mq6Ke2HmMEIEc8AiC8Tu2uecK4oZb8HyGM0gb5gr2Nz8mZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 09:44:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] repo: add --all to git-repo-info
In-Reply-To: <aPcduvnjD0yphja2@pks.im> (Patrick Steinhardt's message of "Tue,
	21 Oct 2025 07:44:26 +0200")
References: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
	<20251020181943.6314-3-lucasseikioshiro@gmail.com>
	<aPcduvnjD0yphja2@pks.im>
Date: Tue, 21 Oct 2025 06:44:05 -0700
Message-ID: <xmqqms5kxtcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +`info [--format=(keyvalue|nul)] [-z] [--all | <key>...]`::
> ...
> The synopsis now disagrees with the new behaviour, as it looks as if you
> can pick either "--all" or a set of keys. But we now support both at the
> same time.
>
> I know Junio mentioned this as one of the ways this may operate, and
> said that accepting both is the "most logical". I personally don't quite
> agree, and think that having it be either or is a bit saner. After all,
> what is the use case for listing specific keys twice? I cannot really
> see why one would ever want that. So I think we should accept either
> `--all` or keys, and die if they are used in combination.

Yup, unless we declare that the order of output is unspecified when
"--all" is used (regardless of the presense of explicitly given
keys), it would become awkweard to define the output behaviour.  So
I am OK to make the command behave as specified in the synopsis
section.

Thanks.
