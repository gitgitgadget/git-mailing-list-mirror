Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003F150990
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364152; cv=none; b=dmfZTauauKxC4EpmLWe3u1uafBawq5Z/s808xS03bHKqmjqO72qf7sDw6QttnBAWAIR3QohAfaEjJ8GFnmJvTCDWYp5G6LsfDCcAZGfxaOlP7N8vBDRYZp7eoDdlQ3GvBj7Gjy0get++lr7osLv/Ia188Z93pjG/8HfMUibVVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364152; c=relaxed/simple;
	bh=PY1sMBBySrDrFu0b28xD9xLIk48yi+ApjhdEUTgNWt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRCZIFKtYOpBBZWmZplLq/w8DgE2ZUG7cssy7zo/rsUlXIm+IBu3BCoK1OU/E5Y4zHFpoOfCT08tYQLGGUSsu8LiQYD0sqxL2Z+4mFFK9fgPEHzJu06Q2u4w6FIGfYvngD50JVBuBEVaj+TlfFNgWhZDb1YeNWQiRot87LdbWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nPGbwy12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mEKbVGmX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nPGbwy12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mEKbVGmX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FD48254013C;
	Mon, 11 Nov 2024 17:29:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 17:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731364147; x=1731450547; bh=Am678TtTl9
	Id4wNifGn562BiCAQRhDtY07p3uagO+tA=; b=nPGbwy126sBQMPXLOcwshsa3PD
	N/LMJViF+LSAf2epau3R5qHuvLHnHPLt2f4DJ2qohIaVIhl6PKzfCKfTMIdnM1z7
	C5dCJyWce9sPsGAbMpv+VyUK8ydKlRNRiQxwWk+6fPfdpsK7JRLR+Ig9u+c9olo5
	TGbgMUd/nd4TsQGxjPTfrj64JlA9G0hvtCd3HRI3QhGlo2eKGzSX5Y6m8NRXVxBR
	pEl9AqNMf4EJ/HGmbyJ7k9SMVwBEtJSzoahSodh2ai+HxlgJwk0Ce03G+vKvG9CT
	ymICK+OiL4RAREgysJg1obkfiyriqVcvjKeDcuD2yAgxS3GSJDtbPKmf4uWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731364147; x=1731450547; bh=Am678TtTl9Id4wNifGn562BiCAQRhDtY07p
	3uagO+tA=; b=mEKbVGmXGoRuiTIhP9aKaV50qFUtlgn8x2VWW+o2ByXZDrFRPgm
	rWpBzATpqMEJDlWidbkTZWo+0A++8a01L1HQTxnflZvcP61AI01pDbb+5rt7rjCu
	ax/PsgW41yJSYGFXMatc24B0jB+LxvtKNjWFpQ6//LrKBCwlxTPVRwfDD95H85RQ
	bLc6uNIwpk+o0Ek7Wzu3RLexH44Su8D4k2qWTPIv86rKf0waUvqM7l4Ult0Lsoia
	r3d66MNPxFBav5+/5tXYL/V7fMA3ofv0itWVlrBd1ACgzWJCdOemfFkwrTU7sR6I
	r9I4QQHdYu5soWjzxwlT/7Ibs9tCp2b239g==
X-ME-Sender: <xms:M4UyZxhYSAa25GhjoZ37Yp0ISJ25e4GE3zFkMDEWpa_e8aBH_aOMMg>
    <xme:M4UyZ2AuCfpfpUkimayvLxHpbIR5xIid077w_XKnyu5NFcILQMJU5ECSbr3u_3L6o
    -ubaVcj_hOuuuMTow>
X-ME-Received: <xmr:M4UyZxFXc625FBTmbLy32w8qK-MrDrTaYbXfN__xolSjZqyVe08h9vC66NrjyeL4LGZBHBUOQ2AK8dFvfnLqBO-OLFtcU_BoIMDT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhnhgtrghi
    keeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:M4UyZ2TE5MAW9odnfCERvWYDxM58JK1v_EuBDSJ5QqABD2n3Fg9y1g>
    <xmx:M4UyZ-w6Taqejc06OMwBolNT9OeRG9XilNQ_FDg1O1HIXqmQ4XNAXg>
    <xmx:M4UyZ866SGBjFSk-bchHrgIJ4eMychcI2nUpUwXLmBP8ejsaS_gkfA>
    <xmx:M4UyZzwvUqMODrd4rT0_9kUGWbrE6r1uuykaaOMPWh9EUBCxu7ykPA>
    <xmx:M4UyZyhXUrNBLuWABvjO0tPR8celFdNilGcUiEp-L4MumQZ8ZVutvvgv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 17:29:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  ps@pks.im,
  johncai86@gmail.com,  newren@gmail.com,  christian.couder@gmail.com,
  kristofferhaugsbakk@fastmail.com,  jonathantanmy@google.com
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
In-Reply-To: <20241111215502.GC5019@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Nov 2024 16:55:02 -0500")
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<ZyUqr/wb5K4Og9j9@nand.local>
	<2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
	<20241104172533.GA2985568@coredump.intra.peff.net>
	<xmqq1pzqwnck.fsf@gitster.g>
	<f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>
	<xmqqo72miim6.fsf@gitster.g>
	<20241111215502.GC5019@coredump.intra.peff.net>
Date: Tue, 12 Nov 2024 07:29:06 +0900
Message-ID: <xmqq1pzhbe19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Yes.  Due to --depth limit, we need to break delta chains somewhere
>> anyway, and a rename boundary is just as good place as any other in
>> a sufficiently long chain.
>
> We don't necessarily have to break the chains due to depth limits,
> because they are not always linear. They can end up as bushy trees,

True.  And being able to pair blobs before and after a rename will
give us more candidates to place in a single bushy tree, so in that
sense, with a short segment of history, it is understandable that
the full-name hash fails to have as many candidates as the original
hash gives us.  But with sufficiently large number of blobs at the
same path that are similar (i.e. not a "pushing a short segment of
history", but an initial clone), splitting what could be one delta
family into two delta families at the rename boundary is not too
bad, as long as both halves have enough blobs to deltify against
each other.

> I'm not sure in practice how often we find these kinds of deltas. If you
> look at, say, all the deltas for "Makefile" in git.git like this:
>
>   git rev-list --objects --all --reflog --full-history -- Makefile |
>   perl -lne 'print $1 if /(.*) Makefile/' |
>   git cat-file --batch-check='%(objectsize:disk) %(objectname) %(deltabase)'
>
> my repo has 33 full copies (you can see non-deltas by grepping for
> "0{40}$" in the output) out of 4473 total. So it's not like we never
> break chains. But we can use graphviz to visualize it by piping the
> above through:
>
>   perl -alne '
>     BEGIN { print "digraph {" }
>     print "node_$F[1] [label=$F[0]]";
>     print "node_$F[1] -> node_$F[2]" if $F[2] !~ /^0+$/;
>     END { print "}" }
>   '
>
> and then piping it through "dot" to make an svg, or using an interactive
> viewer like "xdot" (the labels are the on-disk size of each object). I
> see a lot of wide parts of the graph in the output.
>
> Of course this may all depend on packing patterns, too. I did my
> investigations after running "git repack -adf" to generate what should
> be a pretty reasonable pack. You might see something different from
> incremental repacking over time.

That is very true.  I forgot that we do things to encourage bushy
delta-base selection.  One thing I also am happy to see is the
effect of our "clever" delta-base selection, where the algorithm
does not blindly favor the delta-base that makes the resulting delta
absolutely minimal, but takes the depth of the delta-base into
account (i.e. a base at a much shallower depth is preferred over a
base near the depth limit, even if it results in a slightly larger
delta data).

> I'm not sure what any of this means for --path-walk, of course. ;)
> Ultimately we care about resulting size and time to compute, so if it
> can do better on those metrics then it doesn't matter what the graph
> looks like.

True, too.  Another thing that we care about is the time to access
data, and favoring shallow delta chain, even with the help of the
in-core delta-base cache, has merit.

Thanks.
