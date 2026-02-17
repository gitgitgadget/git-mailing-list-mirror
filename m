Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17023793AD
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362661; cv=none; b=fAkkcYIxDMNbGRlbQ9i7SnSNSHLOgxjQS80jt1D/42ZlphNH3WjoPhKFYBl1iv8R1D2LDkg/61gSAdzk/FlpIGuxma1NuhSvidZJJBC/mEHae8eGJBuuG5YdnOUvHq0wf0b+8EbiaeGiwTTO+yvToSUrxqxBdI5fkoSunCXma9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362661; c=relaxed/simple;
	bh=JbnzoIqkv6dj9OhvqRreBgBUNTI3bmEpoPhdS8996ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V9zMC5HFbqE1209SPs8JRFhwM3nn8x34Nm+een4vCnT3CbeaH647Y0GZ7NSI5q0M7yxRQ7YiO2t2pHRLY4XrCXDxuNjpXCHOLQ0Vmwxgfl5FKJDcvW+y9fjFGfv2zJDJleElfzwo14kFU1qW7q37nBX8H1NH6ZEpa4K4VpamNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iRqzz4jm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEcMU2CR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRqzz4jm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEcMU2CR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F29741D000FD;
	Tue, 17 Feb 2026 16:10:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 17 Feb 2026 16:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771362658; x=1771449058; bh=XlWRDh1D99
	0prDrr4UrVXFEHyyX9qtnQsAPNrHK1u8s=; b=iRqzz4jm4Cov438XRHkXLDfB89
	aAzg4MP2RZx/JxL63ASjDtmi1U7Gx/y38IQiAVY4Pab0ya6jrNEpdegE77ss6P9l
	93hVofSiBbtzCeddDqWpYJHx7bcyUMpiIouocnCxFSZhBe8z9z1L2hCfM3dMAJUo
	9d41W68oymEykbRTiBWQwmklnu8M7X9cL8SeX1N04l7YxGQ4asIC3tItr9rK0joj
	LN8Bl7DkwG4yJ3iDdFu8rWSio2w79hEn+vu+/cPUAOYogWrWX46VSJzbQnOorRpN
	o3/IHcc7/+p57qmxekkq2dCp1VXsjzadgXhexcR8PGQfZwyblfhOLeu9RSJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771362658; x=1771449058; bh=XlWRDh1D990prDrr4UrVXFEHyyX9qtnQsAP
	NrHK1u8s=; b=pEcMU2CR4d6G5zpRfQFnZuSm3hu+9l33MjU3ttTmk11Ymfd+8q3
	rkzowb/690tKViPtlGNJe924QREebRYaTfe4jPjN1l6Rq1QHrgjfbqIf0oswtEus
	0CHG5mUHDBzI7qjlxpGK9jnZMPZ54yBvBKzKJCXxKBnL1lzY8gsi5gjKopiLOvn4
	tEmr/tJzJvHsgrM6pOSr6jP0B7fN8LVOlxXX7cuD3SyChnC/jwzUVzAfMvWeBkis
	lA3PeWLo80y15HAV9RkntXYVhvdR1AGk6O1kxXeT70VbiZJ//YCoYaYW2bzgEL+6
	bRviSEmRSrXIz72xCWneMvNEnIfdwa3DtAw==
X-ME-Sender: <xms:YtmUaSnlrLMw-83tAAtUhfKBcuJyY23WwNY78DGeU6_XeffOmROUig>
    <xme:YtmUaQ0pewmRjF-zjZcS5o0MMzgUvHwRqtOljYefSPfTpVaWof25VCcumjPVJxxLv
    XKOtSEjsRtNAnpnkUzoBR97Nj37NFowdiivAKOjsyXfAm9ib5Vtyg>
X-ME-Received: <xmr:YtmUaVo2ODyMNx32ZmgU-DdCSZZltsO8xqRioLsoTYtqyCcFOC4rPcD73BE6vWTV06C0ki-UvQYktmxf5ZYOIS3QlSYDOTqb-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YtmUaVcO3CTj8mFFSR4r39qoHLV0F_XKZIuBgc0vXJheiR-10OlbFQ>
    <xmx:YtmUacp6Cb4LbB-fizx0cRV9pqLa7E5s1OkLB9PDI5ABWePJEIP5zw>
    <xmx:YtmUaeERKRvqUljc7lVx80cM6g-Mz0Pey1txUQH_GIfG9LD3ispJJw>
    <xmx:YtmUaUvW45eIyRB-JOVffbBoQ1aKYgGZdrN8eG1QRkM4S-uEcXpUMw>
    <xmx:YtmUaRIRQ1j3TES0ayLTw5OCa7B66LBkUynSczdZ9vNhU0i510Utm001>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 16:10:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Tian Yuchen <a3205153416@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
In-Reply-To: <CAOLa=ZR-0DGm4eHB6oqi6FpdOV1YDT6mf0=ONZnpi==3o3ab+w@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 17 Feb 2026 10:56:03 -0800")
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
	<20260217084124.150366-1-a3205153416@gmail.com>
	<CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
	<e5cee6ca-b908-466a-b496-0b170c6a2838@gmail.com>
	<CAOLa=ZR-0DGm4eHB6oqi6FpdOV1YDT6mf0=ONZnpi==3o3ab+w@mail.gmail.com>
Date: Tue, 17 Feb 2026 13:10:57 -0800
Message-ID: <xmqqo6ln9iu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> My indication wasn't separate the tests out into an individual commit.
> But rather to highlight that this one commit is doing multiple things
> and it would be nice to split it out and each commit could tackle an
> individual problem with tests included.

Like treating "all stat failures silently ignored, instead of
treating ENOENT specifically" and "a non-directory non-file
filesystem entity being silently ignored" two separate issues, so at
least two patches, and possibly if we need a preliminary clean-up
to make these two changes, yet another one?  And each patch focuses
on one thing it addresses, with its own test?  That makes sense.

Thanks.
