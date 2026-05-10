Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2323EAA0
	for <git@vger.kernel.org>; Sun, 10 May 2026 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448683; cv=none; b=lTBICbyALxUHFp/lgSaKLYdwsY1JogA+Rib6xr7DpHgPri/rfkqr2dwudFTPFS0yt6t1+E3fNy1fc8UpOlyBC/0Hq5HSiMMwNF7LFxfIMx4/fT6gqKW6v0OlbAsnCvLVaJUNUiEmu0kspssNP/rW87P49GoYM6uPiQb5HTG78Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448683; c=relaxed/simple;
	bh=FQqFnSYztCB3OqGUgSJ5QxfVvguJ8aZ6C91FwW/pkjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uarVM2Lw2cVCOJFxw4sv+TDa9mjOTejBwYpbWZaBzUgqulVCizrou2V+qY0gQgjc29EomR8zAlyF2PyMi/J7qL7/0dpMsZCZS6NoF1mWFXi+91aICG7Hv6yt48FOWOqnHGvtva2G/TTIbzMLs0QA+Z8W7ZYWxEuSVNAODKLsFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EaptdSYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vkXMw/4M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EaptdSYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkXMw/4M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDA15140009E;
	Sun, 10 May 2026 17:31:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 10 May 2026 17:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778448676; x=1778535076; bh=oQ5yifAslP
	jcMyIWq66hJvHlQb0fEvvUok8CG7UdR5g=; b=EaptdSYMrFGuGcn2iL2A3aVUQ/
	8bx2n8gMvlYB4xAGPch/NZZAKG7ZpjebSpwMi5FDucRqkSE9EYe6d3E4DF/ttC+4
	ED0yQARu6Rb7MJy8i4vaBZgNPhkgpoLU+a0bEfkpdlfG+xWxne7JezbNFtvl6tDO
	ajOaHbxpDD+wVPFZM0dz9WfuZMjiBTdFwDL08jMwzbJjhBDxTNRpEGAEsGUsSF+I
	EQuHtufxv9TGe3fr/8gQVUXefhxIsWUigFfuyA1rVYf2WWqgzcErfKVt6tD8+wRf
	X3vulqFxxFTTJi7Il3Da1D4mA7pDnqVxb2AzR7kTLUYYB03h0pvs2d3HblBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778448676; x=1778535076; bh=oQ5yifAslPjcMyIWq66hJvHlQb0fEvvUok8
	CG7UdR5g=; b=vkXMw/4MvawunBF/PwdnZ9dxQeIHOTZ4p05M4fn37ofEqTTh/np
	xeMo98ZOWHYO+pez3mA1yE1/LVhupG5lVbBk2fcvbQcwrQkpIO4POgWf2/wFNviT
	SwYTUy8J1fuqmbj0cc0NvnazJu97tg2niz0z72K7oANd9Gu4gTyyWTPf6IqRELyN
	SGfiD0WP6+tNd3q5hy1oFfaLjyhV4VV5z6v1h3j3vTxO1bDEhjy+ywaD35eeyO5W
	jeexxvH0V3NfMdI8peXlyWFtmzvagDFtb6MZiQUG23h/ucAXUopIvwuPWPK0op0O
	XJg/oABLwIuQmUGTSlVNNNZSlbf2p3xdeEg==
X-ME-Sender: <xms:JPkAak9WEEfs3MJiILlDppu6y81Ypxk2cgSbToCngWz3FXED-6EjYw>
    <xme:JPkAajt6gmXnx_w9kfimmk5UqROdhgaJzXO7xSRuzpIkCAIjS9-ROHsyeZDNgJQoQ
    fU4S9aRY2BQQXT3m6N9ewv6J1_CdzuIyCKRxikXI4hY6nAjGbb97as>
X-ME-Received: <xmr:JPkAavAarbis4SG0jocPLyNTSGI9npoYNTcnzU07i9nXeD9k0YR0AFw4iIzJMpiK_qp21lnbPa4S8SlHOldcu8fMutzkQZ04cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:JPkAajUmSPYLxyTf7zMhOrRQE0uM4qg-Oh1vHoX392vdBMZgrQ7b7w>
    <xmx:JPkAalAYKYsi8llU_XiVhye5mE5Y6v3zyyEXJNSfaT-0Fj4LXYr6NA>
    <xmx:JPkAau-HrURmoCykdRgGK4YJ4ZkJUuHl8SasmIfNF9xJwsVtCA2RZQ>
    <xmx:JPkAakGuQkAFEbAM9xgCLG8xvc-InJo_95i52OsNRQP-6pBTSfzOow>
    <xmx:JPkAarAadN2pUPoCqzdNABDYdyAI45xAzRTuCoI38tLawde6gqbY7wkQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 17:31:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2] doc: git-log: clarify --follow options
In-Reply-To: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
	(Tamir Duberstein's message of "Thu, 07 May 2026 14:13:33 -0400")
References: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
	<20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
Date: Mon, 11 May 2026 06:31:15 +0900
Message-ID: <xmqqecjj9ckc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Subject: Re: [PATCH v2] doc: git-log: clarify --follow options

The second ':' feels quite funny.  I would have expected

    doc: clarify "--follow" and log.follow for "git log"

or something like that.

> The --no-follow option was added by aebbcf5797 (diff: accept --no-follow
> option, 2012-09-21), but git-log(1) only documents the positive --follow
> form.

OK.  Usually we document

	--no-foo::
	--foo::
		describe '--foo' and '--no-foo' here ...

but we do not do so here, which is a good thng to fix.

> Document --no-follow alongside --follow. While here, describe --follow
> as limited to a single pathspec, rather than a single file, and mention
> the override in the log.follow documentation.

"Single file" is more accurate than "single pathspec", isn't it?

It is not like "git log --follow builtin" follows only changes to
the paths for builtin commands across "builtin-foo.c ->
builtin/foo.c" transition that happened at 81b50f3c (Move
'builtin-*' into a 'builtin/' subdirectory, 2010-02-22).

And the way the machinery for this checkbox feature works is to notice
when the file it was given disappears and then find the other file
that the file we have been following came from, and start following
that old file.  
