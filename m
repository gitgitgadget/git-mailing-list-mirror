Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3441C62
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603182; cv=none; b=fV0g4rMJHoveFex0FIaVUMXQxyNpnwBgsICp+6lOs2jjexx3tFaluXDe2CNlbRhhkGatN5/DdNBtYurA8j17L24EBdHXGznlI2aFAFp/bn0pCu3DkfbRo8zkKIfdgkm0IkyE5sFTNKtssxMYmi30F0nxKj5Dpbab/Za/N+Ct+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603182; c=relaxed/simple;
	bh=vCpfcFw7SCeY/iBGTi/MgUf3YCIulyq5OzP2dEkfs6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWllj5zxvATeTqhTm9/3daucZyfpngI29cTqDokRkS4lLruh0u2pMnKrLngVj2dBpwrpH4cD45Xgf1CwkKkPFLXoyUml5nXM7yGjVRUoEaB6v2KX4goo0KFQmjQNEU8SvA3jXYq65LShPOHS3WsMBe26ofA2HMwb65HzGwms2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tGJKagz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jpf+0R3k; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tGJKagz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jpf+0R3k"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8627D14001B2;
	Fri, 20 Feb 2026 10:59:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 10:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771603180; x=1771689580; bh=3Zjsg7kxo5
	ZTUqRrB++7qklDHxfILWRUvyI0r8ogGos=; b=tGJKagz/cAkudQnqstP63mAPf0
	pYwAW4lgh+ghiUOAB0XTtyvTtVP8K2CK4YxwXhg7CA005txRxZSngkz0MP2B4kHI
	/XyNtGhGJwnO21FBLXqW4xfHIrJRlkXRCWQ2fMl81gNMS98ATVG7c72caOyepUPB
	lfhkCood6NsQCMREy4J4ZNV9XgECg0D0JdFLcYLc87fXxZrw4pYfLTjBY8TfnDuv
	uw31QElinz6rHl+zZVkYj8tljdGy7X3HuyZwyTcXzd/mFRKVgU8woBXUjQiEV4q9
	+Mr25+HX3W8bwEY7DuO4DVSop5nsYX5XaO1YLajXf1kYgk+56MbSWbAGHBcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771603180; x=1771689580; bh=3Zjsg7kxo5ZTUqRrB++7qklDHxfILWRUvyI
	0r8ogGos=; b=Jpf+0R3kx/igKGt27rYOgUbLwXVlEGiAOtkPTEaCJ72K9q2ZVhJ
	OGenjSTYsP0FoiF2vJ+jETJzpY6fHNEJpkMQxbcErisyFU0BjHgYoTUV4lciA4hX
	M5WosRFZyJLaVeA0mXnxVJ4r9LoGTl0zSo4Xjwuew3BLASkBgi612BLMpSiuKj/+
	RCJVSu6vxIsmeTDMxjUVyCaL6npW4vVnM89z99NSR96oj5YsLpvxs9yZutzoE7wt
	uKb3nd6ofv3nnHMs88nQjAzfrM/0xNnQN4XBitA9Xp5MAmYUpIMJmS5SNSbSYF19
	2hHsRbGYa/dRgj5NJwtmGq5860325dDxvxw==
X-ME-Sender: <xms:7ISYaexaM03p9oPz8Ee63XCrAFJcYpLFDDgDiuyql8VLl1jGW4UgRg>
    <xme:7ISYaRKlSpckGuVDO01uPiUo2v5ptR7NSE22XJ6YeomuS2LcvcNgv0Fo-zis1SXx3
    sJwJvXxNfTwnWfklr58BBw6ViyFAw0E2hYmjt3pDzrrTu4CrJeIGA>
X-ME-Received: <xmr:7ISYaYoHweZ5YJmlnF0snSoUd0Jjdfjr1IOuHcnt7I8v1Ln0tGH6DQ5vJUTMCLJwmuB36qgq2FlGgF1YZyT_qBQnKy1Eey8TAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohephihorghnnhdrvhgrlhgvrhhisegtvggrrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7ISYaQJcz9HprDRB76HWvzb_OgjMq0Dr_Z_HnN3kgfI1Zlpyy02WrA>
    <xmx:7ISYadS14WQZ_LdEJASHy3MIHXTgMHILT90n0NCtSgN2klYqnerhUg>
    <xmx:7ISYafs84zhgBH6XKFZcpP47Ki2KW37iwJXpes5SmXDhERN8sJ3Crg>
    <xmx:7ISYaebAJ5lycAaR1S1umzmNknwfALitBBoCkrosGf7mLPjKWTBYKw>
    <xmx:7ISYafnRK-WWmczEOFVfSnXhTK8W7qziIEjmWC4EyrB6U9Q59VIxDtqH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 10:59:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Yoann Valeri
 <yoann.valeri@cea.fr>
Subject: Re: [PATCH] branch: add 'branch.addCurrentBranchAsPrefix' config param
In-Reply-To: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com> (Yoann
	Valeri via GitGitGadget's message of "Fri, 20 Feb 2026 08:07:13
	+0000")
References: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 07:59:38 -0800
Message-ID: <xmqq5x7r1k45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: VALERI Yoann <yoann.valeri@cea.fr>
>
> This patch adds a new configuration parameter for the branch creation
> feature: 'branch.addCurrentBranchAsPrefix'. When set to true, if one

We generally do not add a configuration variable before the concept
proves useful by being available as a command line option for some
time.  Have we had a command line option that corresponds to this
feature for a year or two?  Such a command line option will be
necessary even after we decide to add a configuration variable to
allow users to override the configured value per-invocation basis,
e.g., "git branch --no-current-branch-prefix maint-2.54 v2.54.0",
when you want to use the feature for most of your branches but want
to deviate from that convention in selected cases.

Thanks.
