Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7C18DB24
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988676; cv=none; b=fFB7mCy8MT4kmpwUAbXjgBTZMZdq3wSy8VikuuQU19PdHtfMSTdoL/Me3tzpOkeL5Wyjh0F4hLlHVUPHhoG/nkpO+bXToM8mu+qo3LdTIg8w2j0x8pGiffb8Kz5GZgvF5HfPA9ge2WXopRSu9aus0f4SM+hTe15sTp63XHtBfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988676; c=relaxed/simple;
	bh=FVwmTCUjiwr6Xln5QkhIoBGnwfDtUBfU6gJMafpsQ7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNlqQ79uk5BanjvXq0+KpPuuP5UymwyqRl6dfFhBErowgdvf6R5irvmfuQy485GziROTYitisobPC6N4TioHE43oMKyzUTT/AdDJiOQzYlYrOSxL5LzyIazYGCpahkgJUecPtiKOlaq0Hqf/U4cjuBjN8Tnar9olTAC92GokVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TkZFsJl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O10sUtWn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkZFsJl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O10sUtWn"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADF9211400E0;
	Tue,  3 Jun 2025 18:11:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 03 Jun 2025 18:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748988673; x=1749075073; bh=GONcnYsvnf
	a1y75a0oEc6LP9ALXuKw6s4giYVrUW1ZM=; b=TkZFsJl7envgAommWwRFTJ+QYZ
	jAAXlBUz45fP2Q6WrBmvRrYQS46YuGbP8GcL2LkfhJ8CgES2mPNbXZjkrr3eQtEw
	e62zYKRCYX9qNm76wWeM+E1TcbohSgKuVCC2DxfkgIl/98s9UKNw7XEHc4Z0f8aC
	ILC3JvM+rEjleTgOy93pwWlm3U76JokdRiXPjEbXojQLdWwvlfNk6QyMnOT7vvnV
	A84f+kT588mwHf+DwJiKPOd1rEWHrjReK478VHvPbZz0/NtJzemEcBcBXH0IpQNc
	tda+G2aZrxWVcbWd6xGTiXRmAaWf5iezrZjnukfD50B1xhoLiP0HhZDVRvnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748988673; x=1749075073; bh=GONcnYsvnfa1y75a0oEc6LP9ALXuKw6s4gi
	YVrUW1ZM=; b=O10sUtWnyKBBi0JdKAb+2iFicTVHfkgCx4M3cKA16AJ4WcmBKcu
	q3Y4d3+LxxDk/Gj8/26xa7gI2vVdrXgwh9jRMiLTPXZ2aDTwQ8be9hvQsWNTrUI3
	SoOqWR5WwceUbuId39ZL/eQXrSxorsH7sMLUaeUNkQMWsWhWrXmZAVtE5WLf78+J
	zGeTjNiSQquuZ1xnOtvKhM1MFGBobI2ZiwnNcqBxzoGRRCBIx13YN3YP+IxYlPhL
	z8Ev0NpSOyiUbbmZYrwNXl+sApMve7DU0801I/iYW4IYorA4O4O6CUUScoa7dm+S
	4JWSNlTgAEk1l0fGzsZW43kCmKXpbooTw9A==
X-ME-Sender: <xms:AXM_aK1YQdZrxxUrIgSck3PW4B7BlyanstX6uCnO6dOu9yI-aFOgNQ>
    <xme:AXM_aNFL8PzAyIXKAWto9MuLXYciZsVwtpN7aXwWGq9tbPTJnUJIgS7-_Ud6nEWEU
    gOjURD2KSuqOJGmJA>
X-ME-Received: <xmr:AXM_aC5merDrYF8n2sv0q0qwKh2uxgDbMVF5q_IvGVBT6-tq4pM57VZb9ed2kSra-66HpjAHBmxMaWiaOUMqyA3FaGro7osQN6VF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AXM_aL1BNne-k3wB-s1V5GYar_QkfSw-qJYav3iVRvC_1C10wKaVEQ>
    <xmx:AXM_aNGPqT0OpRYzS3Sh9XCgm3_HwpOLasGFvtZD0q70OVvsVkSGyA>
    <xmx:AXM_aE-e-uv1luN3Kw66Y5dIX4j2mYdqQKK-_eRQ_1lGM1XgXgW3Og>
    <xmx:AXM_aCnzYYn5i_50NyEE9U-LyWA1pOHfNVO5zpL61hN-o9hMxtE8Ew>
    <xmx:AXM_aMxGMT3d7pkNdbrkpiefDkRop8NbfVIhjHP6RVXZ6Gv3X3r0kSwp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 18:11:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] stash: fix and improve "git stash -p <pathspec>"
In-Reply-To: <cover.1747733203.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 20 May 2025 10:26:58 +0100")
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
	<cover.1747733203.git.phillip.wood@dunelm.org.uk>
Date: Tue, 03 Jun 2025 15:11:11 -0700
Message-ID: <xmqqcybkh3wg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> "git stash -p <pathspec>" should imply "git stash push -p <pathspec>"
> but that was broken by a code cleanup in c3713cede7 (stash: eliminate
> crude option parsing, 2020-02-17). This regression is fixed in the
> first patch. Although "-p" implies the "push" subcommand "--patch"
> has never implied "push". That is fixed in the second patch.
>
> Thanks to Junio for his comments on V1.
>
> Changes since V1:
>  - Split out the regression fix into its own patch
>
> Base-Commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-assume-push-with-dash-p%2Fv2
> View-Changes-At: https://github.com/phillipwood/git/compare/1a8a4971c...98ad3de97
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-assume-push-with-dash-p/v2
>
>
> Phillip Wood (2):
>   stash: allow "git stash -p <pathspec>" to assume push again
>   stash: allow "git stash [<options>] --patch <pathspec>" to assume push

Are other people interested in this work?  I haven't seen any
comments other than a few nitpicky one form mine, and want to (1)
gauge the interest in the fix, and (2) see how well reviewed it is
(and my review or reading over the patches again would not count all
that much here).

Thanks.
