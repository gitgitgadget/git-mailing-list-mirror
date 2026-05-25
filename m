Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857F1DED40
	for <git@vger.kernel.org>; Mon, 25 May 2026 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779675262; cv=none; b=kFl4WCKfw4Fm+GE4j1m6JISsGbfhB05kauC6n8qWAWzn1EhPN/kz1h46EKKL2dQ13SqXdM6MZ3CXKhVmHidOwf+YBAr3yV5Fno+DSma2skrTNjwqUtW+FFFEkqq1gjUH/pQnhe/xjeZaojGJkZ79ef50kHgUFvW6Krp4ywiDADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779675262; c=relaxed/simple;
	bh=oAJDtxF0f22wRnblcyZDTgesPO1nnLRs/jaDp2YZkBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uy0nGC1pId0I8mE/50ucJMiIArTlTdzmf/W6F0UJ6HQj27EGB1GqRdpYQbRsVI8AHrvCMsKFsBSFUtg4bKdRNjso+HPvXDaZwfmLLvR+Ia42DqA1uV2f3sUSEkUOdGdfDk0pA4pNWORXXKK1WsQmqmIfGWZskTxYy5hiW74D5Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ElqkGS/5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhQzWkfH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ElqkGS/5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhQzWkfH"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 48BCDEC062F;
	Sun, 24 May 2026 22:14:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 24 May 2026 22:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779675260; x=1779761660; bh=bLhSLrHzrq
	cP6p2c/fyT4adKcx6yrEAQdFf4oMjcbNM=; b=ElqkGS/5IrnvL2v/9uQndsOgFQ
	P18fZkRrsD8qIdqRKnuVU5G884hGyah1LZq0SdTxkNxN52R6b7JJCE+d7P5pvR+w
	xvCkc2LNGNwsu3ZL/E0Cp2ElgPG6CR5v7zYgLj069JgRxX/H5KQcD8okSkvrRctT
	VR9PLbzQw9wEmTJexYmqxdpBbqsgaBx28qQxHYb7FR0qSD5/qSCXW0/PLZapYuOx
	OsWFlk+Hr5T1DxBXtjRGC7xrpPBnIRpGonL6nIaJJr1G7e1eKz8CSGyZAr/y7DIi
	yVZ53F4lewC5qQ2UGYvpQnfcs0PHe3Pf32is0iSqZVTx91v4oV8EC4vK2PJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779675260; x=1779761660; bh=bLhSLrHzrqcP6p2c/fyT4adKcx6yrEAQdFf
	4oMjcbNM=; b=JhQzWkfHuIpmEDH48Njie2e8zxey1RcMGYFQryFBJHjEwAPwR7B
	B+D+9wRJg1gkepyE48ncmCJ1nr2v2+wVbLJufFiGo0/HjlUyhd91Gtt7sle2M8g/
	PAgypqTx2Q+FkT9HLZ7WszFC2cp57DDCY3TlFIbKdi7/dvfeXgOf2dgSuBECB4zH
	XqX4gSBJy9Z2SPm8GbcMQ7L0c4Cg7CuhF+icwSzsNI0a0mnf23uDOq+xzUxAq9Ro
	+Ld2FODSy6GjP04GTL5bKys/hKdWBGUBRNNN5pxFm/KtpH8g7Uox51BIIa0OkXje
	KyYPbWhiwa3jqO2AzSCjM5zgFu/x2t3PpUQ==
X-ME-Sender: <xms:e7ATau1M27Tj7yQCoW6FNaDRduAFQJbf9rIaEaBnmA0zHqeFjVftRQ>
    <xme:e7ATahwdqAcReg4aROrIPJwVkEFiFLiGCHwYgpNs3DtOp_7wnxN78TqiSj3SyglYI
    g9T6FeFO1G6tAJfJMF6eNNa61ztinbYV9gEYt61IlN_tHA39aMcKA>
X-ME-Received: <xmr:e7ATalFhQLJZBdBwsIMKaQzdoOVUU4dTPlTH2vIqxFD2pl0flFL2RtEnTaKiD99u6jqM3uggWZozPToqM25mXUfayfl9zyiY5kid>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvg
    hvnhhulhhlodhmvgdrsghlrggtkhdquggvshhkrdgtnheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsegslhgrtghkqdguvghskhdrtg
    hnpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e7ATakaV0QN1Sp_PcKSOxL1HlvcjA3kS4eHIbdAyTeI_TSRjHITdfA>
    <xmx:e7ATanDOu7A8nN0HQ7-Mvly-ZDbSkJMoTwA1MT1Hey0l5RzDYMveNg>
    <xmx:e7ATasmAGPmsiLjy9R_PsZq4n5BTtjV1QF_3JFmkkkfK7CLDoVSMHw>
    <xmx:e7ATaowp_K3T4llD3toRAoZ-ce8iutyXqYi1Jvwel8SKM1lYXC-tdg>
    <xmx:fLATajbB0KtGh2MtbxknAC8TP-M13xgigkDH2Iy--_EzucxElts4tvZY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 22:14:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Cc: git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Patrick Steinhardt <ps@pks.im>,
  Chen Linxuan <me@black-desk.cn>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/2] includeIf: add "worktree" condition for matching
 working tree path
In-Reply-To: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
	(Chen Linxuan via's message of "Wed, 13 May 2026 16:08:16 +0800")
References: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
Date: Mon, 25 May 2026 11:14:17 +0900
Message-ID: <xmqqbje4grra.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
writes:

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
> ---

The test in this series fails in GitHub CI for Windows, it seems.

https://github.com/git/git/actions/runs/26377220573/job/77639885088

