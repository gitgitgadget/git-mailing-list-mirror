Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D103146D6A
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051670; cv=none; b=fIv5OA5GeDui3La3nEXHv0DW6lktuAqd3cXlgayTtD39JnqvR+9HigfA3VQETRLk/6R65qTXISiEWacf4FmgEqU04FMaYE6jXNNXbyTt1WwwvHKJzR+KdJ4OJg9hJ14XNARVN6/s8ooxQtqoXcrpZWC/elp6QmcfTbSqbRoDdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051670; c=relaxed/simple;
	bh=r+7+iuBg1ClmVHTC7Q+YQjJDysxziWT3F4FAdcLlQO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oOCEU2dpFfq5xNe8tzYRP+gQSWGLCJqR3wXhcLx8P160gum+CjRLmrB9DNtUwMsVCZ9fJXpjgrjIWb/mHfn2rAWA2fNFxU76QDrxtlBUFarzxB7sMper38U+N8Po3pvGFazBasyBWCQIt55rhVoFVs5/UYaEVxxhgQWzlc8O8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YWRQFXXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SadU4LIY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YWRQFXXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SadU4LIY"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 497621140277;
	Wed,  4 Jun 2025 11:41:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 04 Jun 2025 11:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749051667;
	 x=1749138067; bh=vBWaiHhOUw3ifBXB+MeVWL92gYP69lrc8nkfPqk6hSM=; b=
	YWRQFXXZz9CpmebypEuOshdtUzZLQDyLzKGAYOWLxYWWBOu3p+/WXlgtMBbxasgG
	mw+lfZ1++tZwmGUo5sGupx8tF91lciREu5f7+ZBrIJLD4gM58vRGpk/p486Jba7r
	Nf2WTkg5p4Qkw1tVW/TMOqIKypJfyKVb+240dVeaagdwMEndQZ0rZp1k7Angd7Sl
	2wzpQr/ysG8VSpdL98EEex1xif5x4KyNBFkmUvdf2qzcySpqPs3qM3c0DSQj94L+
	Zywz0QpvCCT3egmA13tbyoJrMgrrzKXyuSiteie8S21Ua3JM95wcg11/NsYJzq9I
	+t5GacX/FrsTyU2LmQYIuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749051667; x=
	1749138067; bh=vBWaiHhOUw3ifBXB+MeVWL92gYP69lrc8nkfPqk6hSM=; b=S
	adU4LIYH0KWRBLthZlKBkTHKfKAFNwmuSf35jlBMklcdLK94iJOnpgcWDNtiIbX8
	YpelGCanLt0iYGbwC5gwCLbllNMuS8HICfRaWEZ0thti59OEktUJePls8wKPMryY
	Rt/VwytUtrnPbtLedDjxJh0AUpqCBmMSWFfXdJ5bGAockd+LB+wgnL089s+O/EFW
	GyAy6Z+sdgF72De/sfcptgl6kY+G1MZPu5yuvua4RltGrzi2lLdnKuyBlrC3b2S4
	YGiqEDMgw/CaPXAw0kIi58BR6MqbWUOJQOJQkv8H07FPROIxZsbpCBb3zg9gVkJ1
	0uWgJyOohLeeuA3SSqvFQ==
X-ME-Sender: <xms:E2lAaK80q3OA60x3g2qE4Z6WxI7Mz39yyC_N4JJ8e1ANC93rBzsLaA>
    <xme:E2lAaKvEhKxtEZ-E9Y9NVeNraw0eniGOPkhfRJoVvb3MHvGtgDiOIdwt0fTGnSfIP
    8WG3ugYaNuvrTPZTQ>
X-ME-Received: <xmr:E2lAaAC3PUwn2Y_IXElwdSP1aSBLToEMW0o8ZMBAUs2gz42_7kVo0NiL19wvmnhJ-yggDotroozU9PqSeZZ0Mo_D9vfdqwFERfsz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehprght
    rhhikhdrfigvihhskhhirhgthhgvrhesnhhuthhrihgvnhhtrdhiohdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghpvghnfigrrhhrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:E2lAaCdXlOHxj769miHUs1H9GnqVmIx7vTOnT2zmt7OSdd4NTzNoOA>
    <xmx:E2lAaPPprbgOC3PHWtgUOQRIZRggn_qGvg4oVJUSowbBFRU3kC6RJw>
    <xmx:E2lAaMmKJ8nKI1OcfPGVR5VqhUAxILDzxH4T1bDTrCmjxCccrAeMtQ>
    <xmx:E2lAaBs_cN5hbSAqAZUiKxjARiRbfeK43KuoJ6Bc9U0V4T7yf817YQ>
    <xmx:E2lAaM5npBuo6k26uNJBbXp9NGjAe4qqW0xTvZ5DH5JMp--qbQwvha4h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 11:41:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrik Weiskircher" <patrik.weiskircher@nutrient.io>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  "Josh Soref" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  apenwarr@gmail.com
Subject: Re: [PATCH 1/2] contrib/subtree: parse using --stuck-long
In-Reply-To: <0c65723e-fb52-43e1-8bf2-32bd421163a1@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 04 Jun 2025 16:09:33 +0200")
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
	<fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
	<CALnO6CDk4cP1Mef07F6Z8Sm-1MxwWWd-rYEfL-e5_Nnq50B4ng@mail.gmail.com>
	<CANMzfzjhe=mxrcxgyXYqOD3GJ0UdX=xsP7oq3H8OGPfuwOphow@mail.gmail.com>
	<0c65723e-fb52-43e1-8bf2-32bd421163a1@app.fastmail.com>
Date: Wed, 04 Jun 2025 08:41:05 -0700
Message-ID: <xmqqcybjcy5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Jun 4, 2025, at 15:56, Patrik Weiskircher wrote:
>>>
>>> Here we mention "-S", but that flag isn't implemented yet, right?
>>>
>>> Perhaps something like:
>>>
>>>     Optional parameter handling only works unambiguous with git rev-parse
>>>     --parseopt when using the --stuck-long option. To prepare for future commits
>>>     which add flags with optional parameters, parse with --stuck-long.
>>>
>>
>> Makes sense! Changing that. What is a good policy to resubmit
>> something? Should I wait longer? Sorry, very new here!
>
> • Force-push your branch to gitgitgadget
> • Edit the PR description with something like “Changes since v1:” to
>   summarize the changes
> • (`/preview` comment)
> • To send the next version: `/submit` comment again
>
> I think that’s it. :)
>
> I don’t think there’s a need to wait if you don’t want to.

It would be nice for potential reviewers to give at least 24 hours
to ensure people anywhere on the globe have a chance to comment, and
a chance for you to respond to them, before sending your next
iteration.

Also, for future reference, when responding to a review comment that
causes you to drastically change the course of the series, you can
respond whenever you want to, but it is nice to other potential
reviewers to give at least 24 hours to voice their opinions, before
sending an updated series based on that comment, since suggested
changes in such a comment may be controversial and after seeing you
spend some time already to adjust to it, others may feel discouraged
to make you redo your series again even whey they think the
suggested changes are not taking us in the right direction.
