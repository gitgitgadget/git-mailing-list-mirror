Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696861877
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765521; cv=none; b=XXPDcG7uXkA36moIrv6NalAsAPZRKS9Ignu+dBarZX71FtWpnj/Un5I+Wg30bke9/fOvcn1HSBaiQ8IpFlMbNMSc7Ces+2Sl1qUFPuzDwZxVPi5KxqiUsV/5cYxEbYz1GbLxiPGxpEe4zwcBsXi1P1A3NMJSSGIJC23sfV3pKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765521; c=relaxed/simple;
	bh=PDdzyllxt3SkJcgiHL8htWicPvPpwBQkyyqfCJ03aPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RjaxkZ+u1BvBh/v8N/XeSPlMjt7dJ62Y1miwuEOrGVFnDrSMM3S8nZ4M5+ZXCSln/qm5OxgBfhHOYEuxE3k1012lPtbn7y68iuSkgNw9hCpKW+CxAC38j97LIdxJ5Bz4l0rcIjWd4zhDqqOEdgLcNy22u7mI9okyGDn46kMvXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PcGlf0ef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q78N7qA9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PcGlf0ef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q78N7qA9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 745CB13800E8;
	Mon,  4 Nov 2024 19:11:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 19:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730765517; x=1730851917; bh=Iuz7ve7rF2
	JH6VjK4KiA0jsFyh9k4NNup7eG/iJleO4=; b=PcGlf0efC5pg41gVgHdOI8SwkZ
	/f8biVBv1Tx3HjRwPf1qgCxAO9c7FfLiw4NbszB7cPkzry3Pvst3W7t2pmpMiy6o
	fLUSPZrhcjWF32HkfrikjogarTKVSJfn/A9aKLAhR3/6VI1WluO4/Qu2W1mJgHdE
	NV7s1uzPQZuMcl9sZ798AD9ybV2Be6gHpzS9zt0Imim0oAG1jQMISempArwYZfVm
	RZfQJn/Xis2SHiK1X9c1t4QS+b2snx5kHFkrOWYMfvcHEd6ObUgv3PGPeAuozonU
	jJ9ukRdZAiBIzFTPN8/K5G4jg+VK3El1gHp/xvNzypCAyUUOQwt5NkOYVxUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730765517; x=1730851917; bh=Iuz7ve7rF2JH6VjK4KiA0jsFyh9k4NNup7e
	G/iJleO4=; b=Q78N7qA9sqNy3/dVpzLlcG7X1U0aKfAPBg3xDJpoxkUlHiD7MAf
	n2YG4s3LG6qZuHOmAjxYQxATaLCGflOxYo086EMDoU/wFblr6uWNQEv05Rmdr4xc
	Hn9G9DKvIbQVM/9fD4ORao2CfwqCs8iW+kkQrEQQxC+q00eFrm/ZM1Grd4YXwQ9A
	NKGDkzJzLXsyqjzY8B0fnIEKaAF7PE9xYpVDBO6AD2Te+sTJbI80P58PporG+ISq
	eVJngZxlgZVHzJdrZtELKJb7telzOcNeG+mRzvHUtCMxMHLLyl0wV0aglOvd2v5z
	XJzqcfFayyuKXzomS+1ctR+aplRZZH4zWUw==
X-ME-Sender: <xms:zWIpZyELSWm1uVSc8e6MTM8ji6tVBTxJzDIBzDM1fwweHEmodjrrTw>
    <xme:zWIpZzV_e5zYaoN07dBDuY300A2Y0wdmKqvAEcQKGGXL-6ME0hPEr8BL2AhQC9lsg
    xMYXNXGpJtCGl2wHg>
X-ME-Received: <xmr:zWIpZ8IfG8d6oaz5hvGnQEfAgnOOwY9O-KmK8g0LpX48xWq-bWWlF_EXIpw9dVL46rYZ1nJgr6Ulwwea3675QHYTSDYD1q4a5Jwf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgvddtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:zWIpZ8E90OyFauhZvXMjW_pUkfa3Z4NdPjAQbV-cina6cD3N-cXfTg>
    <xmx:zWIpZ4V1VXR19JZZkINwPeGKrOyfgiLoBl99ZVcD9IYyOi-634BmGQ>
    <xmx:zWIpZ_Mje33CBWnnyhr7QvGcD39TCRmj0oLfAiGUVpTIAXqy9voUgg>
    <xmx:zWIpZ_0xXGDD2bMyDC6n4FUL9PvODDZK0GAzhgfu9ZDl1Y9YdtjU2w>
    <xmx:zWIpZ5XOp26ZZnxUrPAjLJjS1vFt9Lfyp7aKltGC58r36dkNTrkq2GT0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 19:11:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  ps@pks.im,
  johncai86@gmail.com,  newren@gmail.com,  christian.couder@gmail.com,
  kristofferhaugsbakk@fastmail.com,  jonathantanmy@google.com
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
In-Reply-To: <20241104172533.GA2985568@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 4 Nov 2024 12:25:33 -0500")
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<ZyUqr/wb5K4Og9j9@nand.local>
	<2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
	<20241104172533.GA2985568@coredump.intra.peff.net>
Date: Mon, 04 Nov 2024 16:11:55 -0800
Message-ID: <xmqq1pzqwnck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Nov 04, 2024 at 10:48:49AM -0500, Derrick Stolee wrote:
>> I disagree that all environments will prefer the --full-name-hash. I'm
>> currently repeating the performance tests right now, and I've added one.
>> The issues are:
>> 
>>  1. The --full-name-hash approach sometimes leads to a larger pack when
>>     using "git push" on the client, especially when the name-hash is
>>     already effective for compressing across paths.
>
> That's interesting. I wonder which cases get worse, and if a larger
> window size might help. I.e., presumably we are pushing the candidates
> further away in the sorted delta list.
>
>>  2. A depth 1 shallow clone cannot use previous versions of a path, so
>>     those situations will want to use the normal name hash. This can be
>>     accomplished simply by disabling the --full-name-hash option when
>>     the --shallow option is present; a more detailed version could be
>>     used to check for a large depth before disabling it. This case also
>>     disables bitmaps, so that isn't something to worry about.
>
> I'm not sure why a larger hash would be worse in a shallow clone. As you
> note, with only one version of each path the name-similarity heuristic
> is not likely to buy you much. But I'd have thought that would be true
> for the existing name hash as well as a longer one. Maybe this is the
> "over-emphasizing" case.

I too am curious to hear Derrick explain the above points and what
was learned from the performance tests.  The original hash was
designed to place files that are renamed across directories closer
to each other in the list sorted by the name hash, so a/Makefile and
b/Makefile would likely be treated as delta-base candidates while
foo/bar.c and bar/foo.c are treated as unrelated things.  A push
of a handful of commits that rename paths would likely place the
rename source of older commits and rename destination of newer
commits into the same delta chain, even with a smaller delta window.

In such a history, uniformly-distributed-without-regard-to-renames
hash is likely to make them into two distinct delta chains, leading
to less optimal delta-base selection.

A whole-repository packing, or a large push or fetch, of the same
history with renamed files are affected a lot less by such negative
effects of full-name hash.  When generating a pack with more commits
than the "--window", use of the original hash would mean blobs from
paths that share similar names (e.g., "Makefile"s everywhere in the
directory hierarchy) are placed close to each other, but full-name
hash will likely group the blobs from exactly the same path and
nothing else together, and the resulting delta-chain for identical
(and not similar) paths would be sufficiently long.  A long delta
chain has to be broken into multiple chains _anyway_ due to finite
"--depth" setting, so placing blobs from each path into its own
(initial) delta chain, completely ignoring renamed paths, would
likely to give us long enough (initial) delta chain to be split at
the depth limit.

It would lead to a good delta-base selection with smaller window
size quite efficiently with full-name hash.

I think a full-name hash forces a single-commit pack of a wide tree
to give up on deltified blobs, but with the original hash, at least
similar and common files (e.g. Makefile and COPYING) would sit close
together in the delta queue and can be deltified with each other,
which may be where the inefficiency comes from when full-name hash
is used.

