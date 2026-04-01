Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB893A9DB2
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032108; cv=none; b=d//SMiXDxQSMd6r6xGwx05qAEhqRdO7mQC88/NlR7VzOk3NYE0tjUGNwhR0ONgheXzu7R2XRa1LjvEitdPZb+jAwbzghP/A1z6PgaEMRS0EzXWUISAvcwjY9tvNo4QjojgORABcqj96Ena2e0Z33JDL0svIpOI7T5L/ENuD8tbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032108; c=relaxed/simple;
	bh=COvgAsP/XeBZv9IJZwlp0XYo6TEOPfYdwh6W8LM/00A=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SLMFmN9l1CoTqIfOqJn/9uxvXdGpWxFKQWC3bF9rw2/VYlwqFkWM0GzFibOdZ/vVopF9sd9JYACbXRfnZHcaI+LkzOqN6qvtXzPyxw4smgQd00GkIZUoLBDfTyMiiEhRi4ewX1APMQG2UxXckpZDUaG9RVKTeVFFedQRO4GCRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TxXjz7fE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NweiGZR5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TxXjz7fE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NweiGZR5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C23031D0033B;
	Wed,  1 Apr 2026 04:28:25 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 01 Apr 2026 04:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775032105;
	 x=1775118505; bh=OxHtqm/2WOaut8jyg3IpSaudnDKOiB61ema/GeL6vmI=; b=
	TxXjz7fEIvkAzOjGMDJlEsMk2EOq+K5zvYJ88KnRXEu6lmxTG/2Mqkg4nDOrmU3X
	4gq1RtwxL2EMCH4OJSIIP/v0sKv+fn6z548mRiDEVPNmFfL1rRcHt1s1NluSn6jA
	8JCZ3rx1kTondwlWLSb73/aHer3tOY2Ze3EQDzfxpB90dzyDbwWmZBmj+bMOI0yB
	PPJ5JZgw65Yj1cb5OrEw6mvyebN4H8ulvc5/O7lH4XK0Lnz+np3Q6ISr0vM+17k0
	EZIuIMkGxjJolfu7BCusThfVLTAc1P1qbEhMtX8dDQ5FcaH3UXJQHHk3T1HzMNQm
	eCTJl9DyIQ50C/ykCCWLqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775032105; x=1775118505; bh=O
	xHtqm/2WOaut8jyg3IpSaudnDKOiB61ema/GeL6vmI=; b=NweiGZR5apnNv7LWj
	9+Wm+lBBEWbL0frRVBHy/stJCXxanBblusbWSwFxjinhTWDn4NA3dvBkFcSB7ZAC
	z62OsDJIrJAeLu6IW+tQbwrIHY2vmBf1fNVdRrhyj0vZWZnYm2jmNZBEzDLGrugF
	IlHj+/C9w20Av5vQtSs7EVQIg6gXnj/jZMMsesP+AZAjIkQGlrC8qRFMmI5TMznK
	lfHxagCbkxQqjMXv6N+cIvzkj/7ob2gkevuT4XGuxAOq2UUQ+IYaRAkr6kdRdw1B
	b3/YRPiW71edTo17bO3bwrI9rjO7Ofuy2PFuX7GIG1csvi2XVurkCeVaYlkvublN
	XrIoQ==
X-ME-Sender: <xms:KNfMac-jj15kUKS-9qSHjQXK6TBoxAmRZMhT6AD7Yv4aQH6NIHTsa90>
    <xme:KNfMafiMt7A3gCEA1IMZmRGXvKilCGy0fCkWKtoutgbuISy6bKDMLxoJLImWm-N1w
    Wb46C7uKuqUEsgj7l20IktDLvEx6QSO1fONc7NzJkncN9ITVd28Tfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertd
    dtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudekveel
    veffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgessg
    hlrggtkhdquggvshhkrdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:KNfMabqc1vawRgv6Xds7Gx27KhUrlj6eLrW4MA5ztjyZnyMwKdl56A>
    <xmx:KNfMaTkggtk_CBGU8ium-PUNKnzVkbov0peD0Xo5jYU6TSY7XMWm0A>
    <xmx:KNfMafxrrZFj26YIPuR8CI-jddKecvZCG6mcevt0VKHJgdI7eJ4I6g>
    <xmx:KNfMablNw4c9af0eTirCHmGv1n50a9X5E5lUXLTJkdb_9MXJWtw1NA>
    <xmx:KdfMaVAIKTfW5G2zx8woDKsC-gt_pGhPYLR2XcF_PHIg5sF2rlOwpdsn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3B681EA006B; Wed,  1 Apr 2026 04:28:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuJfFn2k_qiB
Date: Wed, 01 Apr 2026 10:27:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: me@black-desk.cn, git@vger.kernel.org
Message-Id: <54592b30-0b48-4ec1-a413-903db846870e@app.fastmail.com>
In-Reply-To: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
References: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
Subject: Re: [PATCH 0/3] includeIf: add "worktree" condition for matching working tree
 path
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 1, 2026, at 09:33, Chen Linxuan via B4 Relay wrote:
> The `includeIf` mechanism already supports matching on the `.git`
> directory path (`gitdir`) and the currently checked out branch
> (`onbranch`).  But in multi-worktree setups the `.git` directory of a
> linked worktree points into the main repository's `.git/worktrees/`
> area, which makes `gitdir` patterns cumbersome when one wants to
> include config based on the working tree's checkout path instead.
>
> Introduce two new condition keywords:
>
>   - `worktree:<pattern>` matches the realpath of the current worktree's
>     working directory against a glob pattern.
>   - `worktree/i:<pattern>` is the case-insensitive variant.
>
> Supported pattern features: glob wildcards, `**/` and `/**`, `~`
> expansion, `./` relative paths, and trailing-`/` prefix matching.
> The condition never matches in a bare repository.
>
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

The cover letter here is signed off (not necessary) but none of
the patches are.

> ---
>[snip]
