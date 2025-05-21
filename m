Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671627978E
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832664; cv=none; b=rNb1rvW82EbMdH0X9O0hokzDWH36ckfU+vF33WFflz4LRfahRm+Oeix4gLQeNQMau1R6gibj+6MYRqz8NezV3PFKFOUDYwZJ3a2PgSV1Ua2DtUJKypR9ntuki0x/Zq6dGcouTXFm57I1wTi7QuR5cs4JILYG5eRXRTiKiDMjr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832664; c=relaxed/simple;
	bh=h6Vslfxy6hzBDedUHNsrnpn5XvwP3Qh4baso3zHDuYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGp/ryWbuR+vT5qYH+7jwJSXVzZP97nBDtljGq5m74csHfn7eDEVNPlworPOVIdeB7myFGXYCPazsQLL0Uv1g7J4KMdceCaYiuUWDc4qeQ0OIL+st/lj9z/4PQZa5TKZlylKgk1lANPOWankJDErXRxSwRZojV+nw3yOsn/WxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZbdwSm+F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PR/noBdd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZbdwSm+F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PR/noBdd"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BA14254011A;
	Wed, 21 May 2025 09:04:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 21 May 2025 09:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747832660; x=1747919060; bh=iYUrAcyM6M
	mjYAnx4BtpvEERBquEyCJM54E1jAxMKk8=; b=ZbdwSm+FCixQMOaBpRpeElrVDO
	1CkSLAcqCDgOaNxwwlgG7VBdvH2YzoqgU/WgzD6E4AHMMirSfMTKbd3BxJOXypqY
	8oyCjY7lH81OA/EhflTDCqMec+/ROMdTWhx37gKZ6bFiGaFUSbZzQa9XE8jv5o5n
	ODPETgMy8uTpAhKNaoNyhZvJziNW5F8FccgOtm4Gr5xANmkSRZTP13KG+e045hmw
	p46lFljI9Gb7CUPf+xPW0iFzEvLvBD1tNWN7CPOlslq0KfQ2vQqKpbg9OWJDm16I
	WyAEWc6laT7otx9NBPEPvS5wEe8ZgXDWQBh/RIfzCOTww4JNe+pAaOPDHkFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747832660; x=1747919060; bh=iYUrAcyM6MmjYAnx4BtpvEERBquEyCJM54E
	1jAxMKk8=; b=PR/noBddzCfMR9NgBpu+HYyy+gaLne3Ixw7bA75q95Crrm6rZLs
	KC/Gwy8iDkSUmxh8YkpEzcPknO7Zwal+0iNSj3tXT2+8Nr/Xd9xPPp9rEa9SaHim
	w2Wn2yAZuhi/COwdGo5qWDuLiOvF7C+mc7iV7RPluzIwgYqgiU4zq6rIlIlU0r/F
	6KgFQb1oBWcyXMYtoqrkqF7Eu9Phjzp8szoPvZyi+pdUZiWa6zarcT2cmV7tvu/M
	gA3b51ZHiSnATIUzda9PE08f3BTQ85kujnY5vo1rOnd5ioFZmUzWYf93EaJZ5rWk
	PsuqzYXmRlRTseUcAlBwzFC9/DE8yHX0cPQ==
X-ME-Sender: <xms:U88taJOCWWNmpooOuOvhwH8SPGeReq5zJ32DP2SQEvQjYj2VdfMUaA>
    <xme:U88taL_G5tnBxo4Sz-vgk6AFydl1rG0Itn_Azj76SNrm7hRbLi7hFYJ6Vja16UDU3
    SCJ_tcwphsasRps6w>
X-ME-Received: <xmr:U88taISRRu8pjIKcz1oZwdrEzz1goCEXJbxjCG72jdY_qvwMKqJzFUzWQ36k7SnEbscVEvzsoRW-cN4R-V0aWfsJ-HiooO67tyS-Goc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefudehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:U88taFv5WyrFZ7WuwQ1RXCfYK1QgxO6lq_a1Ydxbqz4XJQR9Vk10hQ>
    <xmx:U88taBeyWLEcdhNOPz0npHKCyedo7CokzHj6_lzwv0An_gNWcQpMaQ>
    <xmx:U88taB0a39LEN2JKXtya5oBJYSWOLWQmMJDhx5LxJOfbq2BfjoUuZA>
    <xmx:U88taN-9zeXx2AYR2kuynqDHMGECeUZiaavkkJGZTtGbB1aYaVfnrQ>
    <xmx:VM8taDp3RxXbNWR7GLA1sKCjRWYLIH6HCrqOOe8gQqHpC0d6vp2HmQOL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:04:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] stash: fix and improve "git stash -p <pathspec>"
In-Reply-To: <cover.1747733203.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 20 May 2025 10:26:58 +0100")
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
	<cover.1747733203.git.phillip.wood@dunelm.org.uk>
Date: Wed, 21 May 2025 06:04:17 -0700
Message-ID: <xmqqy0uqdsj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Phillip Wood (2):
>   stash: allow "git stash -p <pathspec>" to assume push again
>   stash: allow "git stash [<options>] --patch <pathspec>" to assume push

Thanks, queued.

