Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D030F52A
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418410; cv=none; b=rSmdo9AFfOAm6weKaUosPyyqS4hLF6EqVkM6RgmPGWfbtReInzCh0otMSlvh7YUN1wqJYFvxlHEn+w/3bIZImNP44CUfsofvCe04t2R/vrJTm0SpIN2RtI4m70LgJpH6up940g5dO6zVZbWfsdt9/3FDf+ZCShrizdsANrO6eoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418410; c=relaxed/simple;
	bh=PBQjl8qORlhD3CixOL6XjPyVUiQnX/prargrJvlNtZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CdK5z1xrMsK2k+/i9MZGpUdTnPCqfl2HuZZ434WOdbCH9zO+n9OWAEvLb9d+G1DIpkq1aa0SWhv9CjHfdkywDFG8Nxion4eHdzme+Fu5ipm+OLbcpxIyP1HehIuk631OrYBr7HWcUpyDU5HPPF04jRaMVgr5pvWFALc4PpMnmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mXXuKLZ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFKmnbLt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mXXuKLZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFKmnbLt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A1F07A00A6;
	Thu, 21 May 2026 22:53:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 22:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779418408; x=1779504808; bh=DEPYv1VBGy
	4bjcKP1LmTHhFbvyBMxekLM1Y+PEBCkxQ=; b=mXXuKLZ+a8JRaSumk0v7iXvDu4
	eyBn3PjPZG7g1hT7816duKUEgOShZb/WNsrGzfKtUmhC+rF3wc2bRQd8ScdqWZHD
	YPhnS2JkEc5tLdOTNP4AADqCR8KcqGYO/u1rIIvjIOsKFhdT5URBk7ng7mCOqJtq
	xTlpZI8q929sWJwylDtbhcIkZ90FzrDJsa8eAdtA2PagwlAf7zntB+D69RqKbYQi
	o//MOPkHR9PLHQ2/toKSM/TBmgjjAmyVPnDbTz79ASYWlZQnyo4zifN/8Op+tHT4
	NAvHFkwI3YC9U1grBxozrWAh8dfiemOKEHmVWQph186jYF7mLgv6NRQnYaRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779418408; x=1779504808; bh=DEPYv1VBGy4bjcKP1LmTHhFbvyBMxekLM1Y
	+PEBCkxQ=; b=YFKmnbLtKreE+lBGWEgjpB+KzFZVhO1lKsuFtfMLTcaPDcs6gIm
	kg/Gz/+02xGBoWc9C+HJ2YU+Op9883+eJgC7pdl9Ae+ktNfaonMERsCRgew3LFwc
	1YLlZClUWkceT4XeWg+/hgrUIHGhk5fYj0gKRjGWRvONrdE7gWdEIbaeAZO9cqCt
	+WgynHp1P0PoOYtjewfIRr7DSUQJ3iw9kb8gtyTo9HTOrXE9X5rk95yvQvJWAIWQ
	e2UsCSJeuT1wR/oFstJUO9HKPWO+xohZPIc9UyiXIzKCE1cU+kRkmJd89LIRWO0B
	1zFzOMHtZQNTpbr99fLq1oqBv9V+vQJMuug==
X-ME-Sender: <xms:J8UPag6sJ9nV0he-gg8Kx_0WFoxAJplWLBnEbQw162F257bapHmFAQ>
    <xme:J8UPakLaLtqrp9-DzshCPE6FzE5GFpP3CoeCex1HBInQ7KVsU1SLeiYrL5NxNEt6H
    SnvNKQiw_XTgA0FVXyH3__3GX0pH45BZA9xgVCApPO0ikmx7_ok>
X-ME-Received: <xmr:J8UPahsWJlpt6C198RI3RhtK8DwLYfJ6MraPHPK7c9EjQwUfB80Bb3HmNQ5PG3MGl6sJ4iCoBOttlqk5e3U3u5WwbP-drE1aMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgugh
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:J8UParIZp_OVKOnAEzNcJWmRkpdnapzswd8x2RNcNIKLMbjRmtylsQ>
    <xmx:J8UPai-xCDPBDtIKkYn6PX0fb5gHgaQ6UCKSR_y2zDaAEvJP2Q4rZg>
    <xmx:J8UPaswKhfXV7h22F9bYPTSilpEuWzOZMrR40bLzo163hx5pPpBmdQ>
    <xmx:J8UPan48Q2G5CyizjSJidFB8ILPPEtE4HTtJBmOv-pjbUrgRHPwtdA>
    <xmx:KMUPai04FjyTpSqtc3XwEgQzE3F0-3Smx_24yYb4ZviGDgZCYvYTVm_u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 22:53:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 2/4] branch: add --prune-merged <branch>
In-Reply-To: <xmqq8q9cw40a.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	22 May 2026 11:51:33 +0900")
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<718e28c7e0120a826385189213cccec1f0fce1af.1779403204.git.gitgitgadget@gmail.com>
	<xmqq8q9cw40a.fsf@gitster.g>
Date: Fri, 22 May 2026 11:53:26 +0900
Message-ID: <xmqq1pf4w3x5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>
>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 1e24c95a69..29d38e9060 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>
> Due to the way the patch is split between 1/4 and 2/4, it is
> impossible to comment on the change to delete_branches etc. that are
> needed for this step.  I'll use "git diff master... builtin/" instead.
>

Please discard this version.  I had unnecessary draft comments that
I used as reference in it.
