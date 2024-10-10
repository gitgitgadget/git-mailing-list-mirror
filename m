Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B21E7C01
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586362; cv=none; b=sLfwLTilKeBwvB5g1B+r52fPWl/zJQ0qGargvzzypiUxwVrBgXVXr/HNBjiTVHVxo7nBeWVJVAHo5P+CK+frDSayfr0SxgIsK0R71sI17lV1SWWq8QrBueNe8FF0InCCtuipwR9WydHY4hMOj7J57BvXzQU6/JsjICh/RmJY/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586362; c=relaxed/simple;
	bh=nQWlYusSQMv/lLfrwunuFB2iIDqHM/Xw6DBqzPCGmB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QDYAyCldbo4quC5wBf91CMyQjdheLoRwVfB4FcA9bXfRkCh35lte1BLboQrnFm/sYQ/S+ilHLFVp8UcJxpg/1gT1W9jkJrzccvrThKNZfUOFcgudAxPTCUcAIvpzI1GEdNMWQkgmA5T09ErkbmO2zrb8eCR+zDRJZIj4D/5JoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G3iORw3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvjKiLzJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G3iORw3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvjKiLzJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BD17D138020F;
	Thu, 10 Oct 2024 14:52:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 10 Oct 2024 14:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728586359; x=1728672759; bh=NEP4EYZxWj
	1KF6/2iTsEVpvJZ0HAA/0QfIIe8DBwYSk=; b=G3iORw3SUnglNNQ5V07QOodnXy
	EpghOgEL1F/tNYeTXb8mgccoZ+VNn2sIQVG7rZSKaJvUtleiS2jApkvzKTDAN0Zq
	3nZMBAw1xxecqlsky0s15JcXl7aL1b052LVvPIBvzugN5UGpJniWZtbhtlBctTzC
	gpy90q9r1DAtORm0y6LlPqN5OanWfVzyFIYvo27ZWLYmUxW6VI7HUxhbkANcEX6d
	g1xOYFelaeVx2SaGwYjIghao6UqP9sZ3IvqsERorN/px0rWNTj89U1QFj4ak2da4
	w/yvG21W6N9Z/eODLPYyNIvbGlJ343eeYfuQpQH0YJPBygKIRaFQmORgtjpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728586359; x=1728672759; bh=NEP4EYZxWj1KF6/2iTsEVpvJZ0HA
	A/0QfIIe8DBwYSk=; b=GvjKiLzJNW3bYuaTSyvIdEroSFSArmaFL43qAwCqP72l
	t7K3J9Iac9dhzd9nU4Sz5fPzRz6QmCMX4X0zTf6N+sorNlHVE0NXeR6k4WBbJ3kM
	f2qZpU3f3/2DiCf4sL7vC7D3PvMon9H3PjnlAFimPxqwi+ru1KmIY//5RFrBUu9G
	gRXNhq0vUZ+RjQXzjo4ys/wA4wThWWPfUu9cnWxFXjjKlXt2LbUCO42lqivhJEcd
	zdkgAQfk1th/uCZGhmuRAz4xaFSEv8Doy/GkBn/FM0zVUdHCvj8A3YXk1AiI/2wW
	PTWxM1fSpz1qsOTwd/tV4Stz35UIxf26x8ACKtfmAQ==
X-ME-Sender: <xms:dyIIZ3iqLPP6Ilt9DX5uJO7P4hKokwbVJcY_OL14sER6kbLA5pu_MQ>
    <xme:dyIIZ0CBwilU7E60-DhTcdR-fc_sFopYicwA6T0m4Yu-qXHyJjUXi7RINr1yW2f1r
    KNWVVAWtenmuxjnCA>
X-ME-Received: <xmr:dyIIZ3HgUCZL2ADBSairAPQoXhbqyf-UyQ7LChB8YKEguNtqN--DfIiml19fYbupSYDW3OBxeNs_s85LNwxuSdqjRwKtCPDQfcvU4mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsuhhpthgpgihinhhggihinhesudeifedr
    tghomhdprhgtphhtthhopeigihhnghigihhnrdiggiessgihthgvuggrnhgtvgdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dyIIZ0SCJCXyjZi15S4qUvxdSEGcvFQuYrzyPifinPyDg-dAPn_hSw>
    <xmx:dyIIZ0xTiOhUo0reijOszvAvYz0O4YpVxT0nf_KqlAkPt0uQCW_AnQ>
    <xmx:dyIIZ65b2K9w0H4dmyCEiyBoCHVI9n-q1ZGYXtZm_6PD_gBZDLLlCw>
    <xmx:dyIIZ5zughwW7Cri4rGb3Ng-1sdix9ZrMjvNzcpFpjksOs2J7UyJiQ>
    <xmx:dyIIZ7mdeQHLJYoIM2Oh8LAs56kWkzjCZj_CVIkEbuD33V8W6PYrKs-J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 14:52:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  blanet
 <bupt_xingxin@163.com>,  "Xing Xin" <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] Documentation/gitprotocol-v2.txt: fix a slight
 inconsistency in format
In-Reply-To: <12469838-46f2-474e-bc0c-8e3be37887c1@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 10 Oct 2024 15:38:46 +0200")
References: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>
	<12469838-46f2-474e-bc0c-8e3be37887c1@app.fastmail.com>
Date: Thu, 10 Oct 2024 11:52:38 -0700
Message-ID: <xmqqy12vkcy1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, Oct 10, 2024, at 15:20, blanet via GitGitGadget wrote:
>> From: Xing Xin <xingxin.xx@bytedance.com>
>>
>> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
>> ---
>> gitgitgadget
>
> I can confirm that this is the only heading in this document which is
> like this (setext length (name?) is not the same as the length of the
> title/header).  Also the only place where the title is not flushed to
> the left.  Well-scoped change.

Thanks, both of you.

Will queue.
