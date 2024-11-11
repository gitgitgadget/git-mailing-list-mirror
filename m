Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC036B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731300617; cv=none; b=tWcYn2TkB7GZOCGq2QSQ1CzvNMEyLSpjk38xS5o4rba1JU2aOlXV2slKb1DKS4l2aKDa7cqW5e4Ye/1oAKBdNb3scx2c0J5dyPFnpX0NZL+l0tJasUQFWs8H1QHH/GXWdIVRACZHWxqVvzkUbz9rIXKw3xnOrNi2PnsLeM9HCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731300617; c=relaxed/simple;
	bh=KbiSvuAMRus7weCo0KDZfJp0ShZGT884am1Exw05C8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mKwwOmGuTgAxDyL5mGsVGU8Yi8MuHk/S90ro2bMpVo7FmNnZ1TRCojHlBFQs0yxDo7N1sV4dy/sUJ9JSJYss6sPvR8oW59cR4Kv1Ano92KWvO8JQd7EnuXKqppJGSMSs+DUnrNOXm1KUBdoOAYg4hQTpHjBS9/zymtrUIRU/gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hEJRfieO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2fWzxOh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hEJRfieO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2fWzxOh"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 569292540182;
	Sun, 10 Nov 2024 23:50:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 10 Nov 2024 23:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731300614; x=1731387014; bh=KbiSvuAMRu
	s7weCo0KDZfJp0ShZGT884am1Exw05C8c=; b=hEJRfieOBiUOmi7JG9x5oYEn5B
	6izKjPqEU/j+P2cWRsdKNVW178Jm0ULjgy3CKYrcGm4IoaqMG/jgzJlt7bSh70lc
	Bf6/wQkV1WZbcf42C3U3uPa80xOuh9QgfQXO+8OnkC2WLuqw6VwO2xdoTf+5WUoT
	+yKABvJb0IaQayTSg+Z0moGK3Lx7ZmhBhEjQT1ufWv43m4K0AAu6Mb4O85V1aqmS
	R31KCubn5kzC8wNThe1apksusbUyuXON7iv2k6sCLOgtZbccxli3Cbl20pnxwBCY
	pluqr5e23VDatur3hz6WiXobTfsHF95sp+d9zqfhnUElZDFI2JI7MblatLZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731300614; x=1731387014; bh=KbiSvuAMRus7weCo0KDZfJp0ShZGT884am1
	Exw05C8c=; b=D2fWzxOhgCZdZVeXC34ARrD5lrkhTKaw3SkY06NNl7FxyzmJfRX
	a74cOFQwtlDYhbF7zNR5DDyhDaQgQWAy3PjlA3hRy2P+Bqed3Bdn27tkaOdiSEHn
	qwkP4iuQgi5t5qgtU8prXV1iTiSfrd9l825UCvf4MfESFMt47ZZdVvWbyuOWTjeY
	CJkAnjn4pKCyV8sIZ/yta4eFImcfvETSsNRxvZhSpKvMFxmTCFfViFND6uTNwdpf
	7Cqr8Oj8TQFDRZqUl4RV08OzZUF1s/6l14A/E0MaMtlLDomQjEAFNlGSv4EagMe9
	f/oTTqoBUFlho9pFbpq7I+Aq37vPtlUv3hw==
X-ME-Sender: <xms:BY0xZ--X_DfVbzn_g4612Gjjbq1tDFqlA5mJSABotWBbkVZcD3t5Cg>
    <xme:BY0xZ-uGV2E62C3oRhWWPgwA3RZ5w6LsoWDI6RyGPMDrymDmBoEKwBVNmCO3m13Gj
    AwbxVuWnB97autz-Q>
X-ME-Received: <xmr:BY0xZ0DsfzfKV1HYgteWe15hFZMrYUq_-2QVJi_2NOtSpIL86hFw1LPCoBB7e2Xs-YSP_nJWIhViXugHs54npxhaqEs0VC33NSOH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvhhinhifrghnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhtvggrmhguohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegvmhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Bo0xZ2eDnB-wxCEVjpVZ4HA2tEEW7wrfNJP6G3EhUPCmRiZO_fSKQQ>
    <xmx:Bo0xZzNB6sR1UEKxceVUjwWG28aJaPnZtK_BQEnoEVrbhDmZaa-CEg>
    <xmx:Bo0xZwkxPCQXy4-lXaTN3sZxn0kaLa05CUxrvh-S2EYD3vcny_Vw1g>
    <xmx:Bo0xZ1uImPYbDHLPg81WjYU_9sOotwyMjhl49sDWzNKBIePc79o7ww>
    <xmx:Bo0xZ8hkAlyfqPnvWTWDh0hf6F9xQm6BvkTWUuo0N5ep39-O8jVG69qu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 23:50:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steamdon@google.com,  emrass@google.com,
  ps@pks.im,  me@ttaylorr.com,  stolee@gmail.com
Subject: Re: [RFC PATCH 0/1] maintenance: separate parallelism safe and
 unsafe tasks
In-Reply-To: <20241108173112.1240584-1-calvinwan@google.com> (Calvin Wan's
	message of "Fri, 8 Nov 2024 17:31:11 +0000")
References: <20241108173112.1240584-1-calvinwan@google.com>
Date: Mon, 11 Nov 2024 13:50:12 +0900
Message-ID: <xmqqzfm6fk6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:

> However, this is not the case as discovered earlier[1] -- certain
> maintenance and gc tasks are not safe to run in parallel with other
> commands. The consequences of such are that scripts with commands that
> trigger maintenance/gc can race and crash.
>
> Users can also run into
> unexpected errors from porcelain commands that touch common files such
> as HEAD.lock, unaware that a background maintenance/gc task is the one
> holding the lock.

The symptom looks more like a controlled refusal of execution than a
crash.

> As Patrick points out[2], the two unsafe commands are `git reflog expire
> --all`, invoked by gc, and `git pack-refs --all --prune`, invoked by
> maintenance. We can create two buckets for subtasks -- one for async
> safe tasks and one for async unsafe tasks.

I am not sure if they can be partitioned into black and white, but
let's see.

> This series is in RFC to see if the general direction of the patch is
> going in the right direction. I left a couple of WIPs in the first patch
> documenting what still needs to be done if the direction is palatable.

