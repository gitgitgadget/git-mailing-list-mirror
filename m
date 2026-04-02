Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD86A001
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153751; cv=none; b=GaX7B9xbvlUl3weQ7bAcPV18rXEdOa75OPESIZMae89EwCfinGdxsE3I+FR0miN3nBmdVd9Ej3qTUlXsGEmGWuoL97zLwIga8Y4sBcF29+PWtae/ANV2bTLaFEwwEIUJ0gphs8nVZtFggGnjxBV/Flt9lZ92jHTbhXWUTk3am1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153751; c=relaxed/simple;
	bh=gFDYiJmgy31ZQXzSCLrALNij9gnvQfYSM4QJovFpk2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETGic+1/lSQG0Rsa6qHiNhtX8ifORf9gSiaBW5rmiqvGJNrOkuKYiPBrY/QXcpwOCwkuJKHGBZRS35E15qo7b/FlAB0yQQqZkiS7Muv39ad/WDChfoFshb+h8jrzu1cl0IhsYR7dy7S1IEuRIV68PNMuIqkwr84w532DNaIzmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tLsjkT8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5+eflb7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tLsjkT8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5+eflb7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D28E1400255;
	Thu,  2 Apr 2026 14:15:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 02 Apr 2026 14:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775153749; x=1775240149; bh=IyjlSIdc9R
	3c+mIRuFezlrRvzefrNYmoFlGxyiBDKYg=; b=tLsjkT8no8FIOfibk5XmqX9RF6
	iKxgnkZyoL4lHzbuoQLBkwXx090E6t8wUpPys9G+e6+lIemup7s9H2znIxTKYuMm
	zN9Jzk8I5JBU5dd0Z9npW3Idz8D60UPCih6Rblt9rvDI5a2Ik8RfJldS4H175bCx
	vRsIaBSw96NtCaai1pk5Pq+VSUbP4g9NjLMmm+qZMf5dCGqTYSzG4efuWD0nyRoZ
	a4N5jKqWtADdfgnHNcVlo5xQ9ac5DS7GUeGFh0mWkP92Z42Lk7+/DbpfuN3BN+Z3
	2R9nPUAQ2tI31cpuk0bRgN6kNQHLL/da9zLm+NOdjCBO8qbta9LpsVOechEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775153749; x=1775240149; bh=IyjlSIdc9R3c+mIRuFezlrRvzefrNYmoFlG
	xyiBDKYg=; b=f5+eflb7GDWC5+p1n15/BqHnkNeieMjPXzWVqXiIRTCDkfJlfSY
	P1V0phaGEDSSE2p5c+9PGvw3DXcQQQ3gaKtlQtHesODbN9LN7RMqMKdOQldwUt/p
	RxaPLpqYh/7traz2X5xMq1wfBdLhrfpAT0u4AzssiMtINU7lvL3AHpL3DxJT4sSd
	wWBSzX5Tc39Q/ZIXTnvUeqS0xu/jB2pQnH1SuvEyBxukizBw9fq3BScwGfkxQVvd
	kAYYlND92pLYi/Ai7bh4weI3RIe+u8QaNGEqtuG51rs5Kh4j46GJpKFScB56qKMq
	oNRpD2oc9pG8gyE7arh5GF9lwB6zMIOjrYw==
X-ME-Sender: <xms:VbLOad2xaSOX8VxzpK3nqJs1usqD69KZqwOwT4d2DG4xY2r-Z6f3Hw>
    <xme:VbLOabEJuAqnlukgEP8C4JPRFOgB27grJbws9xNemyxgVfxUWzkPhRnDd1TKzwoLo
    jxzDHymt_KKARI91Q8fh5UlLp40ib9aAo4qPihQBepRhDKNrLSsBA>
X-ME-Received: <xmr:VbLOaS40J8Qak0mt0xh-iWcxHNyI5t0vi7SVbXu2MMO3fE8g60zFB5v7Hc8llDSmziGy4OiFoAU51AIEbwa5GR3cyWR8hjOcYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VbLOaZuZGpXBJnKZO-q8mL6zU7p5Iy-SSxjKFc1HUkIA9gyNTvnIxw>
    <xmx:VbLOab7eeRQDQTE-4RxvVPDyxGbTGFXaEtxsjGo9bYQ77vbMcmA5EA>
    <xmx:VbLOacXYwJ8vAu01Kz4o3aLNlYQkJls_tdu2wnZxKdbGH6NSMCPmDQ>
    <xmx:VbLOaV9dZHvJoan_7CsWT6PKJgDzTc2Hdtwu0k5jYQjSzZrc_pJb6g>
    <xmx:VbLOaQSAHvl7VrfamBAjxScej01IVz0UF3myuA25kwXn7WWt27bHEg4J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 14:15:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/17] tests: access bare repositories explicitly
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 02 Apr 2026 14:33:06
	+0000")
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 11:15:47 -0700
Message-ID: <xmqqeckxqld8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The safe.bareRepository configuration variable (introduced in 8d1a7448206e)
> allows restricting implicit bare repository discovery. Its default may well
> change to "explicit" in Git v3.0, at which point any test that relies on
> implicit discovery of a bare repository would break, even if the test
> subject has nothing to do with bare repositories.

I do not recall such a change for safe.bareRepository discussed in
the recent past, and I do not have a strong opinion yet because of
that, but if no such change to require "explicit" comes, we would be
losing test coverage with these patches, because these rewrite the
ones that rely on a working code in implicit cases?

Shoudln't there be a patch [01/18] before everything else that
updates Documentation/BreakingChanges.adoc to propose the default
change?

I've scanned the patches and assuming that there is no implicit
access to bare repository allowed, the strategies taken in them ...

> This series adjusts 16 test scripts and git-p4 so that they access bare
> repositories explicitly. The techniques used are:
>
>  * Replace git -C <bare-repo> ... with git --git-dir=<bare-repo> ...
>  * Export GIT_DIR=. after cd-ing into a bare repository
>  * Wrap commands in (GIT_DIR=<path> && export GIT_DIR && ...)
>  * Add test_config_global safe.bareRepository all in the few tests where
>    implicit discovery is genuinely part of what is being tested

... which are summarized nicely above, all make sense.

Thanks.
