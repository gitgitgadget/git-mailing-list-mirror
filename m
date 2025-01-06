Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13EDF71
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178150; cv=none; b=qYdkvFhAkuEq6CpDiiYM/ckXSY/MhLTgqSJMwg1xtuwzukATtaFtCdHs1nz/2KKKcOhh4gQChvNEYfJuagCgjqPpR+Y4somLG09gOv6cjoWdmJUQBEj+bpetWj9ttDqZwGhX2TJYGjZ/C/R++kI56PoSElYWNgB11HxAZTWP5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178150; c=relaxed/simple;
	bh=F67N+rHnsY2B0+6nM9zgEpE7pTM7qCym01rgrjsA/7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W2HaqqLZpdY7ODoPiTqUgRouVNFs0sM+rZxaOgWnkVqP8IMkMmhA9pafCkDFCpki1LcSC09wB1NSkgYVMykfB1q8d9eoryaWH1nZXhp/Q3hor7liABruaJVnBn4L3tuWYyxRwk9yAv5Fn5Z4jLBy0+1VMGm85bMNR9PfwIbz1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AP9EYmd4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/mE6dSr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AP9EYmd4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/mE6dSr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CE562540187;
	Mon,  6 Jan 2025 10:42:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 10:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736178147; x=1736264547; bh=sftoOxhOfm
	zzHwjF8pIYT4Fz3rRFKnJJ3b3Wpyqp7mM=; b=AP9EYmd4fyGKTVh2yVbopgJYO7
	YCEfjGZF4d31s3bbVKLJT6X//RdrPPzh1J0slL0G3kNq20mfuYR5p+INGes5CL/S
	lgkfArzVLAlwkd7oQXZNqL/6bQgqa5gJtzrwcP7J0xEIS1DPPIpWpX4noqEdzohx
	wxy4Wr8poHVfb3v725boKwje7kRz8t3ATQzBVF37kuSIlBFpeJaVQVe4jBu6gXWN
	VePtxeo7Z67lsQSHnYX8LmflnGXMcvH4vYbGmfcJrgAKvq+qKo4smdOOfySmq7JX
	M8f1JXgUyaBllK/K5CeKrdZeb7QZSn9cNTf8MmkApS8jBEmF//NYw6a2vVoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736178147; x=1736264547; bh=sftoOxhOfmzzHwjF8pIYT4Fz3rRFKnJJ3b3
	Wpyqp7mM=; b=i/mE6dSr6a1XT7g6Sgbhgj9emhSgfErEgQzwTdr0jJYFK01oPqk
	0UWeX7xYB9sR/hM1grQ8wMpx4d868O4BqS8x4h5IApJM2dnywUwDqRkzRkxKnfbd
	A+GaGyWja9j4EuIeuRuEJ/c7lUpfMzBpeihOcXOITwM334pqcLChPBad+UfPuvFC
	5KqfExtvdkB3HztaaVtVQ5K/hiZBVem0GJ0CAIiE12+LlYwsgGzoHEmVYeeqHTPQ
	qIJGGBl7945vMDZYb9IjKk7uei0Nwt9NFsbwiS/ycIIse4wHgH7rL+T3rBmrwqqy
	B9N6WqZbJjh2k3uehvICXOOa4wIS15iWYqg==
X-ME-Sender: <xms:4_l7Z__ERsRU63H3GAbhG2OQr6Nlo0RwBbdK0bPiQlLuvf_ohaqtCQ>
    <xme:4_l7Z7sWKSy_du6NR3OudPq8Ed7ReamT840buFLpcqoOeSbkGhAxoblcilskQH8dp
    uQ3ntqkOh6RQb9K5w>
X-ME-Received: <xmr:4_l7Z9AHr83iqVjL25KrRt8dB5Gii02-nUT1l2-YvIMEaDjTXO-pKEhu3tkc17YlQSRurCk70kzgvgvkiEv2blbCs-vRFnALvF1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:4_l7Z7efLq0DP8_HwYPM534vU2Adt2PdQHvw70p7NHb8JojohOAy3Q>
    <xmx:4_l7Z0MvUMu0rXpSvGWVVq57ZEuG_4LHA649T4_ainBuek94iFpDjA>
    <xmx:4_l7Z9ntRMiardktJxvlpzabzqqGs8-KNcvgVokcVbPkb2Tnqw6Qeg>
    <xmx:4_l7Z-vMsxe6KkA_r3inKIFjhqO87bB7QnMuNYj8S1W6CTeYwhnygg>
    <xmx:4_l7ZxruW6KmUqmy08tr_1wkxeLfpC1zIUPB2SxP6X2WvHfgHvG8CztG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 10:42:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	(Patrick Steinhardt's message of "Mon, 06 Jan 2025 08:51:32 +0100")
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
Date: Mon, 06 Jan 2025 07:42:25 -0800
Message-ID: <xmqqbjwk0x0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> back when Git was in its infancy, remotes were configured via separate
> files in "branches/" (back in 2005). This mechanism was replaced later
> that year with the "remotes/" directory. These mechanism have evenutally
> been replaced by config-based remotes,...

Just a historical note, as I am not sure how much of it still
matters.  In all of the above "replaced" is an incorrect verb to
use.  "A more-powerful-but-different mechanism to do the same and
more was introduced later" is a fair statement, though.

Specifically the ".git/branches/name" mechanism was never removed as
it had one distinct advantage over all other mechanisms for users
who have to juggle tons of remotes that change either their URLs or
branch names or both not so infrequently.  Instead of having to edit
files in .git/remotes/*, being able to say

	$ ls .git/branches/*partialname*
	$ echo "$URL#$branch" >.git/branches/foo
	$ rm .git/brnaches/foo

was powerful.  Offhand I do not know if "git remote" command
improved the usability aspect of newer mechanisms good enough
to allow us to start using the verb "replace" here.

