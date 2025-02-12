Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6670202C45
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399116; cv=none; b=vGiUIlsb5537X8mSa/0+tcCgF36RfOd0f3tGXvQaEazqTlLq4wc+ALEqWqmnJicZsRlx0Mg2LSQZwSN114WBZepAn0TCquGml7D83CUBUAM1tr0Wz/Pflbgq4jQlJAFnskdAO4B+8g19VaaiXhbgj8EkCUuJADQPG5MOg0QVBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399116; c=relaxed/simple;
	bh=tKrEDMJBR0o5Nw454jCuUKnkLsZwtqm7hEOEwAzMfx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O561tL1nXx+9OdcHotJfxcklBUyNio2wolFzc3+x0viyxs6VxuoYNQRqgx3wppkWchzADerANh5SEwCv8zZ7vI3Wp4OMe7Xbxp/wuXURBwlw7JhKQJGhz2xlAB3qImeFsvmGs9IvqIQXvBdlFrA7imef3VP1v5csxvfBem5gfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UYEP8RyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsAE2kxb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UYEP8RyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsAE2kxb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BCB16114011A;
	Wed, 12 Feb 2025 17:25:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Feb 2025 17:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739399112; x=1739485512; bh=cbpFrbIroX
	F7BLkGQuNFGHv5Cd0CPkUTTYPLVG+GDuY=; b=UYEP8RySMFLiUjweTAZ6eZyXQb
	Ol8Zitz6MKQ/wLE6nhv8xuYXqRHa+Op21t8iPesrknnPSxcwblDuQl2mRccaAegd
	EKD9oAd/52KheJCQzYAKcMeQ4B6ntr9godGpo8pB6HAV+az4aGm4O5rDKEW7qSTL
	4wTTN1D7MHtee5+2XSFFX2xuv0S+JUJeGHw57W5nQ6MJCKRShuCRh2MGWrwABDAm
	671Md5obGVE6RrBiJor2eNc3OPUHIeFEEl+hHEiMnMXIKAZGP9S1T6wUeFPLg0Dr
	1/kBalkwWchcIleI1/bBrUxvyl3n+HiUCV2FrMMEU5x9DYvghv0dIgr0gykw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739399112; x=1739485512; bh=cbpFrbIroXF7BLkGQuNFGHv5Cd0CPkUTTYP
	LVG+GDuY=; b=AsAE2kxbp7oX4dlFfmFKIX6dRemcOXXuoquri5kFgrYxbnTyvRI
	hicswspTItD739M8uEwtQklYX94ESMElIIf7BWH3bh+dsPbAvuVapPwLJqmqMQBs
	evUlEtsOl4T5nLV1Nr2Pwe7xTVcNQBfIyKiDopau2KxD1+kYoqXpGjcpVlF7dYKB
	GwYkZ7XAkSnWVl3ursRp10eBfNAsW4UYSzAozgehm7vxiKBxlX3T6cX+U9unaOrQ
	+KbzjjmF2zP/l/w4I8sVUo99314P3ogxPhR1L0dQNmmuBogYXUyY9hp5zPqj621U
	adfeAsFqBwZGtMgyt1n8kZhBr3Vk1fz5QaA==
X-ME-Sender: <xms:yB-tZzn8hntkAFZHAxdZSr2f74y-A6x6J2uUMnwOwyZl5WJI4FWHiw>
    <xme:yB-tZ222lhne2u2EM_nkteZLo5yzJbV9u-X6tO-DNzAO3y7j0LyCp66U6RTP6-sRE
    1DSjUI7ky4ztK1XEw>
X-ME-Received: <xmr:yB-tZ5ry7fbXxC1uC6rsSd3XQHdCWFJt9z7rJDfrKZ1zRNqcVZYKsA5ypYrMGUiuwkhxnjyPXPoG2--jM3imrpuNzGnA4Vo5BpWA_-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeghedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:yB-tZ7kTImJT4IsxRcPCKm17Uc-V57JSwyiTuyqrkJZqDu8EQ3b8yw>
    <xmx:yB-tZx1gCj9U8L4gFP-GtzHO3o5tWwns1vZxYni2Bcs1zs4yandutw>
    <xmx:yB-tZ6uWZ2s4iZ0o0sphevJLLAyeXQF9PoURtmgOeTRlSnVV9809IQ>
    <xmx:yB-tZ1Vaum6jPDJFIou2mX42AnRymekDBcceXxw4ITFiBUV5kBeWbw>
    <xmx:yB-tZ5-HmzrPC7N-bk9909N70gAPAQTChwrMCb_ux-q7LxqS6K-Bp4j8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 17:25:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
In-Reply-To: <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
	(Karthik Nayak's message of "Wed, 12 Feb 2025 19:38:52 +0100")
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
	<20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
Date: Wed, 12 Feb 2025 14:25:10 -0800
Message-ID: <xmqqa5aqu7g9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>
> While this behavior is desirable for most client-side repositories,
> server-side repositories are not expected to contain reflogs. However,
> due to historical reasons, some may still have them. This could be
> caused, for example, by bugs, misconfiguration, or an administrator
> enabling reflogs on the server for debugging purposes.
>
> To address this, introduce the --skip-reflog flag, allowing users to
> bypass reflog migration. This ensures that the repository ends up in the
> expected state after migration.

I do not quite understand the motivation behind this change.

If a repository has reflog that you do not need by mistake or
misconfiguration, I agree that there should be a way for you to
remove the reflog.  Removing it while converting the ref backend may
be a convenient way if and only if the reason why you noticed such a
repository with unwanted reflog is because you were about to migrate
it, but regardless of when you notice such refs with unwanted log,
you would want to be able to drop their logs.  You may not even be
planning to migrate your backend when you noticed that the refs have
unwanted log, you may have already migrated long time ago when you
noticed that the refs have unwanted log, or you may not even be
planning to migrate in the first place.  Even after you migrated
your backend, an administrator may have to enable reflog for
debugging, and then after the administrator is done, then what?
Should the backend migrated back from reftable to files and then
back again, only to pass this --skip-reflog option?

Wouldn't it be a lot more flexible if you add a new subcommand
"drop" to the "git reflog" command?

