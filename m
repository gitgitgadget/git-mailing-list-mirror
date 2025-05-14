Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2A17BA3
	for <git@vger.kernel.org>; Wed, 14 May 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231741; cv=none; b=P54umjhkOykl8noSCA9I+qrmfl0U5r6FjwXLniP6vHIfYrkXkajMQLolkM9rEK6ZgFFaw89tIN/pRWISoCVmrjWRF5dPHahGiFuHVtoJALRQ0CynZ5o9RGPnKQmLyekK2WvnxW8dF3NixqD+cMRQ61xv5Vj+XkTpntWKl71fjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231741; c=relaxed/simple;
	bh=z95Q5gVheJBHz576lKn28jwyIG6xzjXAJKE4kXFvXkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+PLqv2VDHMbdCALKWHkEkHYic7kww2z91GnbnPyYcVijKcyf4cfYTZ1pwVsKyKo1RElNq7j9fi8dJaRjFFGWxr/rh0ID7uNOCVDMN9SWkx1QiEyouQgibKbMSA1HVR07vqRV/SF37IcgWOYE6lA8AOxT4Bd9nwja+e5zxWcEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/Tgn4kA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InvLzna9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/Tgn4kA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InvLzna9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F7B91140143;
	Wed, 14 May 2025 10:08:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 10:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747231738; x=1747318138; bh=kSLXfIS+GH
	l8We1huH102yZIstZKSSbXMVX1Ut697gY=; b=c/Tgn4kA8Iac/9NRfNrFuA9oeF
	P9V/1iivoCYBSLfk/ljMCAfSrQpGxpcq4RpyZfcEqSmMqTl6jNZsgGZy5cNgVlAi
	nm6YNL5B9bxKPO4YZVFCq0+qHHslwkSY5+t4Vx9WRGuDD06ArE55GL9qawVf2oQx
	Sh0ZnS7P8y/K6ICewth0QvLpF5yt8MVLwlBQ+7UmFjkFgqUzOeTzIhFdB+BoXEH4
	NFc0f7CRceiguzOv79iY3vuX7MvZrrwcXFYsMuaf8/oqyzyXSYmwZEmbwo4vjhP9
	TD4r5RbYhBIknFdtXwvzihM7ooGUln5RWO67zt76DP9yxCR6WrmeBz20N1Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747231738; x=1747318138; bh=kSLXfIS+GHl8We1huH102yZIstZKSSbXMVX
	1Ut697gY=; b=InvLzna96t5GxBhOncDvLkaBH5hEsQ9PzxU5TdESooUgy5rmBEm
	p5agOC6lzUXqcLwrMTbo+yoc1SDcjyL/ueZy9IwgkzPT8J94a0w0dUSOZIutK0+o
	tsRwOTxfEE/Ygf8cAr7wNytoeTJ7yKEk7ncgyhN1O/PC+sEBaOGnkvd/sb4Pb9TG
	r0MEq07HNV/g0oxDX2b+Z+oA9yBCbLMxS0ZIRi/8ZFIqZ4FBtZAOAjXyGm/zFO5m
	SO1BVwMv4Z27U7rDK6E2C1O7ikMGwVWFhzrS3N4dY/P/nhdkdYofGOShwECU0/Bk
	nEBncekKl9UqPNx7IjtCgXOd2pKd7sl0u5w==
X-ME-Sender: <xms:-qMkaGA4qYxVY72Pkv4DG_J9bYd7aDnlNR8Q34IlVW0WbB0kjvEI0A>
    <xme:-qMkaAhdKW15W5n4FljO-UxxNzaI7-luCx1tDMNMnFz31qLpE0uHObllHYfe5TbbV
    MUpm78sBHElYvgJzQ>
X-ME-Received: <xmr:-qMkaJkk8k6DH4_e6BLHv_ck4J8iQGM1fqQ8GuigYbN7eWZAIa2OsJGhDZ8bD6WpmOaWKs-AG0ji81aQbBJGBdM8aOBIr1K1Rk_T1cU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-qMkaEx36tlhzsf_gC3tcUyWeN4Ls0kV8OU_WvPLezyld0xrSav8Vw>
    <xmx:-qMkaLTXVo4QvF3KhK-rxOOjkxvySMsY_CHeCReY1riU_-OTXdmA0A>
    <xmx:-qMkaPYrnBPlGXIBHLIz3fQjw3-vWNDFCr1oCVQyXWjkgIkEbqVk-w>
    <xmx:-qMkaERNY_YM6jhJBJOu7L7ZpIt2tRa6xOdpofo-O03npn5uIEVozA>
    <xmx:-qMkaJfe9qeZFyu3hBeKXiu2_xlE7kZDpVVsnvq87HbS4xWW_29Gr1zW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 10:08:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] merge-tree: add a new --dry-run flag
In-Reply-To: <CABPp-BHp7RXHFy18=fr1dqQgKiO3PNjXQkL2VX-cjSGsHp48aw@mail.gmail.com>
	(Elijah Newren's message of "Tue, 13 May 2025 08:30:51 -0700")
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
	<pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
	<1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
	<xmqqa57giqyi.fsf@gitster.g>
	<CABPp-BHp7RXHFy18=fr1dqQgKiO3PNjXQkL2VX-cjSGsHp48aw@mail.gmail.com>
Date: Wed, 14 May 2025 07:08:56 -0700
Message-ID: <xmqqv7q3b7yf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> external; Kristoffer caught this oversight too.  I'll send a re-roll
> with this fixed.  (I apparently also missed it in the
> die-if-incompatible-options too, not sure how I missed all of these,
> but I'll ensure they're all fixed up).

Thanks.  Will hold.
