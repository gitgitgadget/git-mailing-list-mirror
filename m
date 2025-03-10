Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727922759B
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609537; cv=none; b=kSioAH5tyaNWrqI+mxfvTgb1YyQoTs8ka1ZyWga+tHUycn761cwOT+vUeag2WnzARSWubmeN9ohsaSXReYWZzlnH1CIo3UW92sDqR5cEAYpGKlmM6yR6YhQ2tpl8OqKm1ikox6+ihpCRrySOc0Y8PAFeY1JOT9gvFzCuxP3kiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609537; c=relaxed/simple;
	bh=aMC6ZlHzTjpR48guPFjOe//31cKr9TH0s/s57vFCWXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXbz795sEJPHU0vXLu5rDRePfXgErf6UWBVjc4VFmIkqn/X3fdhle+72m+xDYTo43IIAbOLkR6mZp1VPK19s64ZChgJLuqBkKBabC5IKHspfbvMRv1PdCyPbqIxPJJqU4tEEAfYPolBW+PZ2OxEwGIy6u2EA6i7rXMElGTb62Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xNhrjwiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ch2lOFMz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xNhrjwiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ch2lOFMz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BC24114018F;
	Mon, 10 Mar 2025 08:25:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Mar 2025 08:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741609534; x=1741695934; bh=Ms85LZUSnw
	nCnfIWrjjR8tsFwLoVJCjUDmHrhXnzXLw=; b=xNhrjwiK6n24OUqZ2FyjE/K6Iv
	qHb1ytHz4ozqfp1A8lu/lJNBW8QRdTJiItissiXplTpibuTgp6+tMMeh3JIbpz32
	u2Rw/xENN3gEEopdBGKPgiAXmERGZ+UJ0agWtzUYmrf9Od2BTC5jI8klBy5RFAo8
	37VxDoo0ubJqphv5cHHPdEWN0e8qDfj8KB5F9A6DdqOVq5gXPFuE75sr+wMH+B6L
	hAPq9ucgRZmpW3kqazOGKwGPNTd2z8GQjV8pA1kXNJiPUWDezdN0uifSPr6XZ/Ir
	+7jDveqXUnl1P4PzwrLv3xY1gGLsge+g4/LPK6pMnaAYZLx8fGEf8l3RRUFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741609534; x=1741695934; bh=Ms85LZUSnwnCnfIWrjjR8tsFwLoVJCjUDmH
	rhXnzXLw=; b=ch2lOFMzLQgF7g1WlmRvWfhPgq5O/pdxNVW5OEi9Kkg3ONKb47M
	tP+g8FoC7uPT4g3cNFSOajo6z42t0mctZhsd2VDhtr9cUeSVmclOD/sXatYlwJjt
	ENtQsXUDovSW/s+Oxzs6LWWZIp7hDV334E3QM71aPDOury5hXhX+poI5CB86a0Z6
	ybF/y4C78IuSw+IPjwRCdaRK+oqoViCHcLJ7N55wD0y0nyxj21tASRryZh0/EtJn
	MsAAPrAKVMauX3mXA+nsA2tiHcJ/VaUtV4gldxDwsUIlQJn/XDOuU2z1gMWciPPu
	s55d6ejEnbf76mDxynfqXiwiLNIfImfu4Gg==
X-ME-Sender: <xms:PdrOZ0yXBWZvEIabHuk-6ossDyKEFhJpe4MZ8hDdIEvEb742vvkT3A>
    <xme:PdrOZ4TPVSAZAZQe2tw8SAiHshoxriKYL-lyfNIQpTEjFDfOyb09Lh7y7bbecYTDG
    vrvnniWYXIh9344Lw>
X-ME-Received: <xmr:PdrOZ2VLCpp_QyPhkB_urx7VnQyOwsCCikabG-cJV1Uqrz_8-fODfILIsOg5COoYbjAUgoJSZL3614qmVH4TOS6f1Q7V6XibxT0u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhhuhgssegsvghnjhgrmhdrihhnfhhopdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:PdrOZyhEHjL5qfDyxyEbB71kYsNZnD_htHrRsEglv9ITY0eKaPvlVA>
    <xmx:PdrOZ2C5Qkk511XP4YWeTc901_Ys_mal6iYydG06z5Yen2n2W625gg>
    <xmx:PdrOZzLKW8lxRz_46hbx3PQzNnZWmLEv8idCZ3pa8ReRbOXM_h8qsA>
    <xmx:PdrOZ9CUc2hSM4ToxNktwCHFGFThQT3MAyLWQS2BrWbJZTksMzkNgg>
    <xmx:PtrOZ978gtE3uytqBWuOf763gtE3I-2rUswJ_nXXb224ElOmJoJ6it-O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 08:25:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Benjamin Woodruff via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Benjamin Woodruff <github@benjam.info>
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
In-Reply-To: <20250309033908.GA2361799@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Mar 2025 22:39:08 -0500")
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
	<xmqqo6yejg0y.fsf@gitster.g>
	<20250309033908.GA2361799@coredump.intra.peff.net>
Date: Mon, 10 Mar 2025 05:25:32 -0700
Message-ID: <xmqqwmcx9io3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> .... What
> git-status does with --no-optional-locks is to update the index
> internally for its _own_ use (giving it the correct results), but not to
> lock nor write out the resulting index (to avoid conflicting with other
> running programs). So it's pessimal (losing the opportunity to share
> what it learned) but prevents lock contention.

Yup, that sounds somewhat sensible.  I also have to wonder, other
than commands that are clearly about changing the repository state
like "add", the inspection commands like diff and status should
always opportunistically write the index back, without even being
asked?

> ... Either it must:
>
>   - accept that diff-files might return stat-dirty results (yuck)
>
>   - use its own index that is separate from the regular .git/index file.
>     But that may be overly slow, since the index "update" would rewrite
>     the whole thing from scratch. Of course all of our index writes are
>     from scratch, but you'd pay the price even when there is nothing to
>     update.
>
>   - use a command which operates all in a single process, with an
>     in-memory index that is updated but not written out (e.g., "git
>     --no-optional-locks status").

