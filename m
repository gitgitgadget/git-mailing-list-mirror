Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB32F7475
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417447; cv=none; b=VESoh3pqQzAHLEk86ZAX8GMiTowT62CFIpGR0m6RAhqydr0sUSONdieSmYDBFq95z7Zz4HoUc9ce8jVbgF8ftG1asGTfh4ATbMVUZYuT/PGxvaky1OK+tyfGE4XuqEp4KTE1TuLEihGWZl5VM+pPFfbc6ttfnaET+IZUZcvEBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417447; c=relaxed/simple;
	bh=SFx7DHzrxs0t4jaqht1T7VZ+SdPgao0FdvhcGKtOp9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQrV7NBHwZzk6lHFNluKu8Jmtv+THqPzNi64kymms2WGNEsMjFWpLlwRy+1QholFURtMqNQSusk5TfJBnmLJUzV/qbgZwfJiiRZPK8v8ajmpCQGD38hamoU5kz5KmKZUEJG9nzGiUsEaVtIjAcSyV5G+Lfvr/s5qv/gavus40V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jkh0Kevt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+2RGW+k; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jkh0Kevt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+2RGW+k"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3DBD1400233;
	Mon, 17 Nov 2025 17:10:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 17 Nov 2025 17:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763417444; x=1763503844; bh=2mCAdpix3+
	6ssKZgvL70rlvIxISl/CmyL2kgGHNYEJc=; b=jkh0Kevt8v+JEC7qKAfvBTIPkm
	WSrqFnmWRNuluR1KoJ5V1VA8OOWZGka03zVq/cYxjqPgapLFsCFx5h0b0YUc4Imv
	PkLCy0pfH7dDiYP0toE53c1NW40avEuPSYhYuksbv2DPLHeS47pTn2jarDmdPXNI
	p1CpLMikLGK1yz2EydtYtGfcIoNeRL3qf/S6vfC7QsLr7eKCj3eDhlD4GZFB9h2l
	NrMS7g4EtrL7EQCh+1ZTQoVj1OWSqT0hlchujkjlnhQww+zIfKfeyOBhySG7kqfD
	1Np5QCJiVrYd11BVXSPC6NeNaYPbEir/YwBXfckSCte0LJAEOL6QMfLfg6NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763417444; x=1763503844; bh=2mCAdpix3+6ssKZgvL70rlvIxISl/CmyL2k
	gGHNYEJc=; b=t+2RGW+k+3HU3MG0uTPdLDL3xlWJHl5BUa8gZ51LLW1UVWT3WE4
	uS/NkJdVEwQCCkrDdCnCDcXdyIRqfZW6JHDLiEqQ4fSgIn1Ayg06gYsm/kzwYHTp
	zL020DonCtZZrrGP55VY/mIkDUQAFZ2upRhvz3eeV6spimKOb5hy6Eeo8WO9x7WG
	EjY5dynfYFCS9MXpdXFqnf4CS6tsj8PfK3MhCEM2RUW2lFaqW8zBYtwYP2zGMyIO
	qSCVu4F8/Vb4sMW52S6Z8/n5ln2Jfq8tztIzMev/WhKPjseC9tnslkRjtJEtVyuU
	SqA1zExR/SWzDqUMVglwTOLtNykuUX4xjKA==
X-ME-Sender: <xms:ZJ0baXE8sP0CeHWvZLFJ8mO8EJX3dadiCec036Y1DqxER6NYPplB-w>
    <xme:ZJ0babMosCuQDAQ13hc0mm4MMtzOmknxfg5ZWI_1VVfK1V4HDkG3sXS_MkvEj_she
    LjmDEmQN-i4Vzk6ooW4qPsi7xbKoGkvpklpgNFllmlRuD6oVrLZyA>
X-ME-Received: <xmr:ZJ0baRe5qEAm-zNtvaL_XWc3Ahx2UwwBgTYU37klCWF3XlnULKFc-LnMSsQUbD2s15Wa_WBmP21ZYzkIKzehrI2RhqqKdjmM4oA_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZJ0baQuj9jYIRl1QjdchNG_FN5LFhYCskxEUzr-fIVpqZcesHHXOfA>
    <xmx:ZJ0baakKuQrQQGsCr3XPyVJ7b3lg5JU_pm660zfsPAVkt5S9lPFfJA>
    <xmx:ZJ0baay5JTYvHKq0YFKASQsQS61Eft1Wxo3ksbd_5AR0Mzxd5kuM_w>
    <xmx:ZJ0baUPeqZugi0YDVWH7OJQ1FrUmR5CWZUPriqvWFNQ3wvl8WCZKqw>
    <xmx:ZJ0baV_ZdtFeFD5xiPohvhcH3Isfa6k-nmj-4ETL_4FNW0q1whcPF5K4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 17:10:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] t6429: update comment to mention correct tool
In-Reply-To: <CABPp-BGhU7KfRo9pS-PzRQea3YpU4qxG9iuJzxmWK=mvdhZrsw@mail.gmail.com>
	(Elijah Newren's message of "Mon, 17 Nov 2025 11:54:13 -0800")
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
	<950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
	<2983385e-daeb-40c0-a8bc-fb8bd3b744a6@app.fastmail.com>
	<CABPp-BGchyC6BB2p7p-6qHvwcu5AV+VCAdTeR247F0VamsJkbQ@mail.gmail.com>
	<xmqqfradbhgi.fsf@gitster.g>
	<CABPp-BGhU7KfRo9pS-PzRQea3YpU4qxG9iuJzxmWK=mvdhZrsw@mail.gmail.com>
Date: Mon, 17 Nov 2025 14:10:43 -0800
Message-ID: <xmqq346cia3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> And nothing seems to have happened since then.  I can amend the typo
>> away if you want after the release before starting to merge topics
>> down to 'next' again.
>
> If it's easier for you to amend locally, that's great, but if it's
> easier for you to have me send a re-rolled series, I've got it all
> queued up and ready to go -- it's just this one typofix.  Sorry for
> not getting it sent out a little sooner.

I grew very fond of "git commit --fixup amend:<that-commit>"
followed by "git rebase --keep-base --autosquash", so it is not a
problem for me.

Thanks.

