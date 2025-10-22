Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6834D4DB
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144481; cv=none; b=XNuvbCRjCTmlXAx8NMJkd+Mf0z3vMbgRgPTUlHE7X9CYqQU6UkelDK8Lx0uZ8O9w3Lc9qYLDPdjIlgiKXVCDkDlNPVZFVazA7PM0+evIq6H6emxjZq4PVLLLe+2bd71rfw0378+1KNrD5m1EGhv24C/DJr1gj5FxHd87hg/MOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144481; c=relaxed/simple;
	bh=vKsVOI8mGp8J3mQ57w80sbAEEl0fZguIDjJJQkHILNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPDOG/oJNctrIweaQiqAnXEJp+M+up55qU+L1R2tQ24Q6e+N6xozs+uTdMPaov9vXHpV17AsaoRxfkO/z2tBHNS2Sfl1uw5GHWsSI71CuoYdifX+L4HSLdwa9iNvXLPn1rQ8KAZ4hfsgtN++ZAqd7aIlZY9EvBsCumsI3Yj/W1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uwsb5lZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qRgqIk4h; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uwsb5lZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qRgqIk4h"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AA8AEC03FE;
	Wed, 22 Oct 2025 10:47:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 22 Oct 2025 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761144478; x=1761230878; bh=IKFUZi+HvA
	NS4MDzPnw03OrTnDDmHZcl2+5VlHTe+qo=; b=Uwsb5lZMDQGKmW4ZX6S3CGNCbO
	Jr0b22phEWOrSvctMr3DOQBVTONqZ73pru8aioXJBF44Fkv0/a3rYWzAjVMTacjd
	aLXF5Xnnne/Ic7YgQjCcxPpA8GosaaRRcEUXAxc3F/VWTv7Wx5aTLte7uIpZQKda
	AZnrmhbd4N09OsHL6sqyslqJtuBm6WTXpb6n4RXx0BXL+UYhW0nxNvJPTy7Pn/1I
	ekemv0E8D/Wo5VPwdnjnaGj02r2yUqPWkbwE/YFveaiYcJHdFN6CD65QHbDAbiQC
	a1AdIshBg3vPoRAQS+xtA4NssXN3Dwy1zuUVx+/kpCsnB9q4ArRcaBNZQwXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761144478; x=1761230878; bh=IKFUZi+HvANS4MDzPnw03OrTnDDmHZcl2+5
	VlHTe+qo=; b=qRgqIk4h5Z0A2ksivX8PLDOZu1e3mVHaSBZttqhdh2iT3lpQ1ei
	PuiL53E5cNr8JgiqidPjD1zkol78sH8UUtaVWgflO33PGpHMHms3WIn0StemYNOD
	vcJ9yk+9c5zTZ3lSFijTGMMJM9gPjAuUSuYtYYdHlnwfD78SMysuGECgmLvZWBjx
	XwYfFfwpCpBDs2j6cSVdQybts/3qVGEcdmjKpgsLUEcgsMlfHlUKoMzg9EJAA8Rq
	wT5tMdHJQGxUw25v2sWNuaJDW+gIob041q7C1eEm9fqZ1SBGE50sgcxyHDn/Xy2O
	9zMK6Kr3T7QDQcF81DuHCFRLKeaIOZs4LMQ==
X-ME-Sender: <xms:ne74aLO62nAcB3xP00bIBDE8kwoh_gth5MVjo5W5--G2F6yjOF-ZlA>
    <xme:ne74aINUsOaHJ_2b1VuhmwtZPIWcviG955HU2hvvgsN-ry5HDPB_nJ8gp06A-ZSSb
    zNJGuKM-4yD1CKQOFTcVrL5FvQPXGZebHzZR-Z-KQAv-bzPwnG7PQ>
X-ME-Received: <xmr:ne74aMiJCRPwkcsocz2vpBcBFWj-0vHpFhhoUZbqLID5NlgwmSXOr5ZZPBqRKrsHmO-Jcgex2Nc1LMYM6feUNpQHfnsQBV7iuGxV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ne74aFvI6K_jCyMR5tRLZrg1tAf0qlulEzHxWaKOD3J2K2xOUPvupw>
    <xmx:ne74aCTlt-_5Ups0FaI7uk9bVLpCKB12WhiBgZkXu5LOrY8urjxbfQ>
    <xmx:ne74aB1IqBB31EAv9I4eLa180ysxZ9HRN2exEEliQ6XAlVDkX8c2aQ>
    <xmx:ne74aPsdB10c5QgCkR-Bd-y6U1wIG0hAUzGZ1JUQ8uOB2pA0wOvevA>
    <xmx:nu74aH12Tpl9IRD8AWJeeU0AZIYxVgHCwnUmoqG1Kvqvk7d5QXh-vEZp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 10:47:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/14] refs: improvements and fixes for peeling tags
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
	(Patrick Steinhardt's message of "Wed, 22 Oct 2025 08:41:00 +0200")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	<20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
Date: Wed, 22 Oct 2025 07:47:55 -0700
Message-ID: <xmqq4irr0z8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v3:
>   - I've rebuilt the topic on 133d151831 (The twenty-first batch, 2025-10-20) with
>         - tb/incremental-midx-part-3.1 at 935ab44a0a (builtin/repack.c:
>           clean up unused `#include`s, 2025-10-15)
>         - jt/16a93c03c7 at (builtin/repo: add progress meter for
>           structure stats, 2025-10-21)
>     merged into it. This is done to fix a couple of merge conflicts with
>     "seen". Both of the topics are only in "seen" right now, but they
>     are close to be merged.

The latter reference is weird, but I think I know which topic you
meant, as I just finished preparing a merge-fix to account for that
topic.

Will re-queue.

Thanks.
