Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5C1B4138
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743292610; cv=none; b=PJ3aEKsq48Te5iHZcNjReCRdZfIqIWAqS+Th/WLXwbmIWs9RseO2o7uTsDH/6yu2Dwz2hgc8X4VH0vZWHJ9NxKLOjtL0/owx493Z45fWlJDmn5fvPKlLFGR/WqC/3dPUGIQwOC84PDL/Nzig035HNDAvzSPqUKqujQZVzwVT3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743292610; c=relaxed/simple;
	bh=6JfEAzPBVkB4VCrMHsqNbYC4IMqeofBM+a9K/n5oO0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1+Q5ysK+7IS1tgsqey7lBTAIJ2+FxtDaBouFZQt2PHRR4BUFZMa0lMgE++gH4iGfzVGo3mgJzsVMp1EsiNi1WdyGLpIC9AeAcmwjUsvRccT6RpOSLMKw3QUKECe+Tz2CZIn2uzQshLE5zJsHQ47pTdNcFxp8tzntf7spNZdoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xZxm+deN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCnligYF; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xZxm+deN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCnligYF"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 731001140108;
	Sat, 29 Mar 2025 19:56:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 29 Mar 2025 19:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743292607; x=1743379007; bh=545FPGiSdC
	ohjaSDZG/GHRNvNuNUPhRXWjVPA9ZTPO4=; b=xZxm+deNmYnH4rwsp9rL2ujVMn
	TilJJBapnaviRNdoA/rUAEuSOAAU1om8tRSB/7uDssc41isKAm/PJjxVh/DuS2sb
	20eSFhGrJJKJ8sMa0thF7tBDeOeUqLyRaPntD2TVPv9CjfQHKteSBIcP7geAZUCp
	mgHUsyWffvvZgQYCMdOgXbtl1pmapw7oaZNFGGELwkts6nWOXXGk7RO9Dx2PCToL
	pmxwWB61t1FEpxJERgaSvucVFHFODsQEah2RIoExLf36lksxMGj3Wm4CI04TlmGv
	PL+Bm2FSYaQbIIz9ZYSctM0wGv6tvE8/5CUHQ++ZfVB7dsozp9VToJDljlAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743292607; x=1743379007; bh=545FPGiSdCohjaSDZG/GHRNvNuNUPhRXWjV
	PA9ZTPO4=; b=ZCnligYF4dQvCzceRUQ8x5yNS9g0AzqQeGsfekXsHuo9zuILM0o
	W6Vpb3PE45icwe6Pg/cSeLQfZEg/YxFr0cIH8v30bmCfE42qb7fVuwm9px1gt3tA
	d0oSk5Vnm3PKpjBRSl6cJ02bw6256Vl7qKWqoC5PMa884uWqy/70M0p9ysvcZPva
	42tHuQBzY4ld7K9B1X60OQd0UQqfnUdVdS9XV+/cWj3GR1ci5WxqqPvsXOQJEtpp
	Zo7TPS20SGNrR05UzBMTuLjiG+0tC7GVVR42TTIncWevAZutr+fpoqJ4xr4AVaJn
	SOrgTyeO3LUxyQ42WO7I71xXMbcelf72mNA==
X-ME-Sender: <xms:v4joZysnUyyPBC3tmuGef79ZYew0AvDLXPxwfDbmJZnWalTkgSnJuA>
    <xme:v4joZ3drMkKTnaZ_XPDC7YyaY7Mr4vh8FvPXlcRE5YQECNXaH39dKRBJzNMvSM09i
    JZShJx30ZKIjojOYA>
X-ME-Received: <xmr:v4joZ9wDGbfiminqh17dT1OLZM_aS2Mh6zgfQMSIMYmObdgxJK_S7QMqW0IXSA98l2cRwv1ZUZwIWaWbHtX4-VSTqs3Fblbv7AX8Qsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeehheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v4joZ9O40QoI7HP1aVY0X6qNy6Ks3rC7BeZ5JLxVsWVW4b9udJoflA>
    <xmx:v4joZy8IIaAKyaexRVtGfaPyrH3T6s-2CCtHJDH7w8ploGvi0zJzHg>
    <xmx:v4joZ1VSpakf8gW2AJvQwChXrjV4WsjRVQOoKRISjaOB1LB_VJcu0w>
    <xmx:v4joZ7f9VdJAdKc_NCqwfeVB-JAcSec6fYhz2vRsfyM5Or7tt4mMJw>
    <xmx:v4joZ2bsDi-W8nC6ohGzipfR7KGdJjrolm2RpjW7TT28JPmv0jsrQebt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 19:56:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
In-Reply-To: <Z-Y1YbE2EVqLZhGO@pks.im> (Patrick Steinhardt's message of "Fri,
	28 Mar 2025 06:36:33 +0100")
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im>
	<0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
	<9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
	<Z8bL0HUuQqj7LlTp@pks.im> <Z8bQsflIqzZd3AMs@pks.im>
	<9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de>
	<xmqq34eyijbx.fsf@gitster.g> <Z-Y1YbE2EVqLZhGO@pks.im>
Date: Sat, 29 Mar 2025 16:56:45 -0700
Message-ID: <xmqqplhzbdc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> So we'll see a final reroll with the above changes and the topic
>> will finally be moving?  That's a great news.
>
> The topic can be merged as-is. The relevant MIMALLOC code only exists
> downstream in Git for Windows, so there is nothing that I can do about
> it in this series.
>
> Thanks all!

Thanks, both, for productive discussions.
Let me mark the topic for 'next'.

