Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204301537C6
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838881; cv=none; b=aeRLu74xHUtXSufRrkZKCDZ7Ug3KVwOM3NbIIVrgrzJD9/eTABKNRdeEKi81tZ04a2/h8QFspPTXsBAuFurh99WxOy41AYuPlDDA74FclOqQxxnJjf9Zg7Il6GE6CnQBDOp5ZvHKSsYSRtOg93R4ozZ97D4iV5paslzF2JkH3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838881; c=relaxed/simple;
	bh=gMQl3/Td6Oi6YCG2NW+YjpHTcElbQVYqo93DXKO1iqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmZx6dzvi/MaKE2IOdHfdWRW+ajOQu4+h4SjnLeCy+iv/Umly3ZBsT9kDn22rAY+0MOR1UGO8o+N5gGDKdrRdlQ4QC1q8GL+8WKjXFnI2R6zXq2I4z09xyzB0pxTiZAHLAkQ08mIXHQKDg29BI3L5uNtthU5xQBSaB8EWIEZAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bvf0oX3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KsmvXdBX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bvf0oX3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KsmvXdBX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 21C261140152;
	Wed, 21 May 2025 10:47:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 21 May 2025 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747838877; x=1747925277; bh=ADQs03ZhW0
	JnThjgiVRJnsliw7VlwxR8unCccGmsy2U=; b=bvf0oX3p9Zii8ziZMPZRbaVFou
	T/j+y9JTZ3mz1tQF6KGRhkstfy+d2eLsNWDHZArPtQLqUJqM91Cov69Do5SZ/B9c
	zCwFN5Jl0R2Y1E+OLaO9OZLRXbQJk473BMS8ykA5J69fEw7TF053UnyhKTfWVf7X
	dycy5sbJJpf6D/nn2Na5L1+nVXmc+3By/xfXRdY7Lx/9Hfxct0u3+OakOy8I6TUn
	+1xJdJQuKbLmt55WHm1VHulCy1swH+oGPqsHKFKwT61pVO9AXc0oE2S+ePc/REPZ
	EXwcdUINfTaIeicR+/Xtqbbg5izqQnxCDO0uQrIVsni6rCyC/X5+Ef2gPvjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747838877; x=1747925277; bh=ADQs03ZhW0JnThjgiVRJnsliw7VlwxR8unC
	ccGmsy2U=; b=KsmvXdBXfLP7F+VT6HF+YpFyc4IXJsjeW6kzxREiNmpgsYpRS9J
	XZ3E3ZReg2h2BuQzO+fHI3GHNmtPgcMxvI4Z3wU8Arw8WR3BQBeiKGQLbUtyTSkN
	2C7n+SEIC2bpvykzI1fUDE13pBPcTOE1rPFFLUyieJ7z/+ZARafKrjFqYQYDPjUx
	iSf72rU/l5xmOJ843gZJb5bHw/R+NQIHsM20vzNrd7wT0s1ZOA+lXRSozIXyZWAs
	r9FqmG14T3fHwVnraiMbEAt5FQVffw4mcG5gVZy6vplMavjOWRGdND540iLCuzvp
	51Sp20P72dFx2ZuJZWmqTKvLhoih0xBks0g==
X-ME-Sender: <xms:nectaAFzfVWys3VnUWQQF1Wgi9loDC2BkJieiCqKBAkEz53ZzhXQ8Q>
    <xme:nectaJX5nka2y84jY-2BUqbqmcv2I-KCdDajRGN-hNRJ9i9XkVXiIv2zAEj7HhqFJ
    7NWXHqj6v4fJGfXVg>
X-ME-Received: <xmr:nectaKJ6qCi2NvOLZ3eh7f0_eqhBT13g0PZuoY-HCEb9ppO3XCbmTZ7vmnujHIb1jjD0kaDZy_cIw7UYxsjJ8gvKzRxPm03UymDt0mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhh
    uhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nectaCEvJXzvBtM63i4m60z6fCfZ9SeXZ0AZKPwuGRzNFjNlqEAAGA>
    <xmx:nectaGV73JAHsngi076WEdKfsB-rhg3J0vC0oY1ncUS5dc-exMAvPw>
    <xmx:nectaFPkv5wvkxiXXjrFo9JBng48Ks80RkYvEnyOftLP7HVDn9jzfw>
    <xmx:nectaN1a-A34NfTfyxZXZ_gZNRMEkMAxtYbrzFyVThDfJvbd5qDbiw>
    <xmx:nectaPPo4p4nNYEY4VLuTx7_NU04vVSvuajQsrw_olT1eBNdVeiwUUkI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 10:47:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Johannes Schindelin <johannes.schindelin@gmx.de>,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
In-Reply-To: <aC2OaeLYJQAOE_S1@pks.im> (Patrick Steinhardt's message of "Wed,
	21 May 2025 10:27:21 +0200")
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
	<20250520193506.95199-5-ben.knoble+github@gmail.com>
	<aC2OaeLYJQAOE_S1@pks.im>
Date: Wed, 21 May 2025 07:47:55 -0700
Message-ID: <xmqq1psidnqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I agree with what Junio mentioned in a parallel thread, especially
> around Git hooks. The expectation there is that those may execute other
> Git commands, and that should typically be using the same execution
> environment as the original Git command that has been invoking the hook.

If by "Giving the same execution environment as the original" you
meant "not just git-subcmd from anywhere, but from the same place",
you are right.

The point of GIT_EXEC_PATH is to allow users to tell 'git' that when
they say 'git foo', they mean the specific version of 'foo' found at
$GIT_EXEC_PATH/git-foo, not at $(git --exec-path)/git-foo that may
be different; otherwise they wouldn't be passing GIT_EXEC_PATH in
the first place.

In other words, "These days nobody runs git-foo anymore" may be a
correct statement, but as an argument to draw the conclusion "hence
we should ignore GIT_EXEC_PATH", it is an argument that entirely
misses the point.

> So refining this patch so that the mechanism is opt-in probably makes
> sense.
>
>     A slight tangent: I wonder whether it is even required nowadays to
>     adapt PATH at all anymore.

Meaning we include GIT_EXEC_PATH to PATH?  When a running "git"
invokes a subcommand "foo" that is not built-in, it runs "git-foo"
but doesn't it do so by following the PATH (with the expectation
that GIT_EXEC_PATH has already been taken into account, with
setup_path() in exec-cmd.c, to include it in PATH)?

So, as long as you subscribe to "the same execution environment"
like you said above, I do not think you can avoid the setup_path()
call early in git.c::cmd_main().

