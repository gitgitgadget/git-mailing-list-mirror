Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09A6FC5
	for <git@vger.kernel.org>; Tue,  6 May 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563151; cv=none; b=ZTUHbEwDpIZNmOGAKq4QG5fLzEzVAWffVdLnj/KHBfjiyfoK3hayrloC2tPP2Q4zXB3PFtOr5RfucJbWaPC58H8tADHzVwUsUpgpar9TuD7fiWH47+Y30uDu82aPiPOYI4mhlspICNF0PTVhusshOGoCJQy9u6c3pp5ECN5Hy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563151; c=relaxed/simple;
	bh=840BIkmy4WWW59CCCjHbLBqL9vxJRzTau/Xlwbv90gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MMrHrA4Wf3cOIQb263V5vCaoGEGH0wMPjJqBiTwtznSwQEEpzY26uikJ+gJMtnVmyu4P1hkrExmf772EMFGAbTM465MVQgr7100bfM4ZL1kOMKpMYAV2toj2RGO4V3vjrh+sIHMZsokPnn3saAJ0SE7lkPpA/nvxhShhpijDf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E69+0KcR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sBFOs39p; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E69+0KcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sBFOs39p"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5ADD91140181;
	Tue,  6 May 2025 16:25:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 06 May 2025 16:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746563147; x=1746649547; bh=840BIkmy4W
	WW59CCCjHbLBqL9vxJRzTau/Xlwbv90gw=; b=E69+0KcReC+M9QlPc1rcgZBffr
	MfhbvNyo9VVrpJK6AZCZa6KjEHU064kyx2lp0PrSmfuEr8TZgSciyqTtOV/q1yvZ
	o9jvTdNo7XOQ6OhbtqEVCHrYMpU4dcmiRtV9ShmkP9THxHU5pvbPSctfAbrCMxOJ
	M1G7y+loBDOrRbsu/i++WkGx2B/YhsMErYxlF891eDLtQ8PkssqIrpNFGWRhD+4T
	YKemBRj8PHYlLp3dM00t2RoN5EW06h7ork2cakInzIqBxlXwL6+WVcyM6wdLanYE
	Epro7yTQedTKqTQKEeyvAtlWUu8/fXW4wBYooIPQmNvRfSynh6iEBuQ16Lgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746563147; x=1746649547; bh=840BIkmy4WWW59CCCjHbLBqL9vxJRzTau/X
	lwbv90gw=; b=sBFOs39pHsqEW71xx4mMKfAxKflRJU3I+KtOGzKHpnWf7tjrAHT
	uiwEYj6M47NTjaKuFA7qKa/GnvEoUwri+EsAKadnP8HjlJ9kxOvoVn/RsiPMTJAB
	T5aRejSbhbHC68kHF8CAVDZf7Ff7ZQ5PKotjTi7ryum0EW1h1gTuDII3u10CT7c+
	sN3xc7i23GQQPQlJ6Noyu7rtFTpIC/GnQpGIEDRKZJ4rbpGVGl45NmOvSISsYl31
	08N5f1BmKy5Tyb6dGPIXVoHWpw5MyZT+j0br4w7wEg8JkRsRKitBpBu6Z87E2iys
	j7ZVafVR9VN3RRmk3+0jKLQj5raNCksEk8Q==
X-ME-Sender: <xms:S3AaaMbbpn6cqOS4hmMa2_R8QDxlaYuUA08r7oa1WhDL0m3TVlrvoA>
    <xme:S3AaaHaT_WzG4_cCgClfU60S3QN_8FZeefdVu4XSGbfuFmkxeIF0zvyCfuSArnJto
    4J_CQR4KlhaRW_tOQ>
X-ME-Received: <xmr:S3AaaG8lnHb-9KDLqrrxw3I2D3UNnMOPL-gEzBqe6uGA3hPWYmP7ADkiSHGDdebf9xynTKBueUZw4UU9QTBKgP8xGA57FcX64lly>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S3AaaGoWVdOWO-DREyEK3b4KwXaSyPl_XvZcWW0Q0mRrXScrgIML2A>
    <xmx:S3AaaHqLWT9XFfs-zoUJERw8TFYdAo3E0HHMMBiepgsY30P9ZHiSEQ>
    <xmx:S3AaaESbzk3mhQNC_j6LL7q8rev_tzj3zmNl6NRQX60Adoy8lWQGdA>
    <xmx:S3AaaHrFxE0DhqWCapwQqa378Cby4Wa5d68ug_uO9c9zXO6Ui17Txg>
    <xmx:S3AaaG52T2C5F8FjerQ7WDxdoHpKoaoRdBqSnzG1AcWB7MNyd21Z2tRO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 16:25:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/10] contrib: remove "persistent-https" remote helper
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-7-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:40 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-7-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 13:25:45 -0700
Message-ID: <xmqqwmath4fq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "persistent-https" remote helper supposedly speeds up SSL operations
> by running a daemon that keeps a connection open to a remote server. It
> is effectively unmaintained nowadays: the last time it received an
> update was in accb613afd2 (contrib/persistent-https: use Git version for
> build label, 2016-07-20) and its parent commits to make it compile with
> Go 1.7+.

Unlike other ones you said "haven't been touched" and I responded
with "that alone is not a reason it is stale and useless", the above
description clearly shows that it has bitrotted.

If somebody wants to use it as a reference to build their own remote
helper, they can always go back in the history to find the copy.

Let's remove it.
