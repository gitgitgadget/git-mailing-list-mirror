Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E253093CB
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785426; cv=none; b=tCz6CUBdYZaORlrrbhqDYASZyrOyUwsgUf6ucs5vKnIjm7g0OGi+Kq8jHE1r8VeHyW2tBCSpssE5eB8YPKtR52xq1LEyJ2OsqvLLg5XXJEgSgLgG1bYDZS88gUjgdUrnPxq6eLzAWDgY46NqaGaUuHI8Rba03mtyD+hgfaZLpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785426; c=relaxed/simple;
	bh=xZUNBg73UlGOc621xUNdwr7Uw6fKTerUuhrKL/TthIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cno5gH8UjGg3j+fRcTBX1z+LEztam8oiZ+Jx3CF/LwvPZreKSctWT+nVtc/2pn4ZPUi2rAOWWcLOtCpTvTGXiW4/kpzNqgbBKTjErB0DGhGdNsJm5WXJO0EbkTMBSTpyiH35WVrykboDzRTBEiA8hrNjGThI6hUe1evDBrRjHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dC8H4nOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gE5ZZh8k; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dC8H4nOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gE5ZZh8k"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00D8D7A01B2;
	Tue, 17 Mar 2026 18:10:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 18:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773785424; x=1773871824; bh=nnRECnuw+k
	m7ywpH2leB6V4QPPTnsmVG3OZ2g1DyRB8=; b=dC8H4nOdghK4BEYhZY6LGHGVTu
	hJgnSxz1aQOUXquJYfSvEn5wSSqrurz1hBiTS4ycWQAC3Gf1LLV81HjaUvfP26sw
	mqp8yHWBzbgwwZRSFr/a9hG0Hev0EvbbInKY4+HR/+bvRec1fjO2G2nwUJVXCiEt
	eUw4g4SXBjx2N+++6gw2yxrxuoGQP2xhFXMcW1SSyhW7G1Kz4VlgtEIdlcaiPFXs
	5ZP1KWAqhZtFul+m0Ger1K93I3iD+t3xeBP3B+5PfxciE7QyKsxOB4yFmgOI29wF
	Tb7yF+ek8ZJHkRj5B1D6H8kUbAkSwIcviWwhl5F8226ey4p5ivNJzHwD7TBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773785424; x=1773871824; bh=nnRECnuw+km7ywpH2leB6V4QPPTnsmVG3OZ
	2g1DyRB8=; b=gE5ZZh8kx2FSOd9s+ijhFxKTVQSZ05vZiHbhKIA51Jh7BqzgDmW
	mIKqZJqbzPawy9aFHZ9Hco3C8YvvabgoxMhb5NeuzLz5KN3HRg74Rzw4qVRgHEgT
	Nb9gRAGAooJDX9fkZW+3MgpLPlTLnUGkpJA6pWpLyT7FAjM4ZtJf3RVGU+QOW65j
	otNm/IfcB6tViu86NUnilXfBp+5RoMChoLdyvopK2L0I62OasYgYvwUb7NpcR2Rn
	WLHtkw0mQSoNUGDy/hkxvXn02ApL0pXg3+SHswIFLIk3Wxb4sPPv2A3Xtfqqfz0O
	Qf436om1B7XdzM5js1qIRE6Q3b9aM1gpdbw==
X-ME-Sender: <xms:UNG5ab83NBstMEHzmPMFmNHxL2XH15VAxP3Zd8KWImB54bjamAyLIA>
    <xme:UNG5aesWlOi1TC_fhWJaHYQc1fItNZXePDeMjt-LKvTqwRaUjnj5nFAx_YFy5H7Y-
    C8JhdPf78J0-PXJvn4cRpsfqsv-SsjuPignKOkkMb0ExEafr6eQw0M>
X-ME-Received: <xmr:UNG5aeDxMmzNNM4PYpMviLkXp6p9hhcTDkkXdulMJbmqHrl6MXPZmUiwauIsYMuEPu2BGoN_VVsi1WU_pK8jhxSsLHGIgaCxnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:UNG5aWVKoOqhbmqpe5qYmdZ4GMC9gr6mgMwImMB1qi5cF8lkzBQ5RA>
    <xmx:UNG5acCgc8EqJ5zXhJtCxURTFhfGfknYOP1BSX5eRwuyUnwq4gaQIg>
    <xmx:UNG5aZ8_PkAgLfZPEgXItr7qb3hCoK6Fjy0rayBZRqpOkhll-CY7MA>
    <xmx:UNG5aTEEKVgZ9HiSxsmqLFYOEi6oRJMHXtn7hqxMPK8r31rxu4BbHg>
    <xmx:UNG5aRgwYwsFDw-ndEKiYZOO_P-bNXe053IJagxne-01h0RlzwiN9uVU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 18:10:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/5] backfill: work with prefix pathspecs
In-Reply-To: <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 17 Mar 2026
	00:29:20 +0000")
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 15:10:23 -0700
Message-ID: <xmqqse9yhzu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The previous change allowed specifying revision arguments over the 'git
> backfill' command-line. This created the opportunity for pathspecs that
> specify a smaller set of starting commits, but otherwise did not restrict
> the blob paths that were downloaded.

"pathspecs that specify a smaller set of starting commits" is
puzzling, as starting commits would be coming from the revision
arguments.  "opportunity for pathspec to further filter commits
to those that touch only the matching paths...", or something?

> Update the path-walk API to accept certain kinds of pathspecs and to
> silently ignore anything too complex.

Hmph, "silently ignore", instead of "no, you cannot use that! and
die", or at least "sorry, I cannot do that, so the result may not be
what you wanted, you've been warned"?

> The current behavior focuses on
> pathspecs that match paths exactly. This includes exact filenames,
> including directory names as prefixes. Pathspecs containing wildcards
> or magic are cleared so the path walk downloads all blobs, as before.

Ah, "we punt and lift the limitation to grab everything, so at least
everything you wanted to have will become available to you, even
though we may download more than what you asked"?  OK, users would
survive that, and as we improve the pathspec support, the user
experience would only improve.  OK.

