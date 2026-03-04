Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99820371869
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654484; cv=none; b=ptITXcrIIe/8JyFyHnNH9EaVQili0qRW5S0VjBYfBej7pgnCnvcDhNCR/tgXQS1nnIxo3jFSBWPpQ1VKZrsUkySKobhqQQmTFwSF97P8K/W6wN37W5i8O02fSPa+YKF5J1c+ggkp3MEXD4exTcC1sAP+H3hXKgrcyb4Aret39OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654484; c=relaxed/simple;
	bh=/pqOfhxq0rP9GS/XqTumZHlIWw1+GKSXC4hOhnWj6hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcELQg+VKgvX4F5FyWY0PJiKLQQC2PrG4gMqh6oq1NrhBs95WPDAF4F7hmn6NUtOHMmaqgKq3fKiXtDS822Krc86EnD0Wu7bMMb7+gel1pxITKe2c0v055akhBrZ3pv85WrL4C3rMLhUIQJy29JJ3/Eg0zC0DaQUCuD9061Fo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ADAu1IE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wrNy1cZj; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ADAu1IE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wrNy1cZj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A7F8D1D00221;
	Wed,  4 Mar 2026 15:01:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Mar 2026 15:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772654480; x=1772740880; bh=rlazby4lny
	rePnzACPqgNWE2MBHccMg96e4p2F/M0X8=; b=ADAu1IE+4r/WM2it3iSGy5yDtl
	JBqhT2x+3yOkZ+8ZHB8ipjEBr7iXDhSeeLzQP0L0nOIH0tgsCg9c1ZHMFjR8GbQn
	tYsZOWg4ohgPzQlIH7QKq5yPn7mloJEEyJrx3bNn+VKjCeCUNNo65c2Bm6EzJy9/
	QSqP8Kn7sXSurg3WhkoJlM7spXDqTBrXH9af8KiNIQ3p3FC7DNS3Xte0curqjqlH
	yfun/ZLyVzQpvEoj5PiE6x0X7N1hUVUQF31HSWksguEcTKS3mtg8+BLGhth0A5Oq
	Ve683/Uh8Dt8AHY/z4rKDuNPHaByQDSvehym7AyanSoNAH1J3D6EOcV1U6Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772654480; x=1772740880; bh=rlazby4lnyrePnzACPqgNWE2MBHccMg96e4
	p2F/M0X8=; b=wrNy1cZjNSfQFw6rmsVRmlaXnujw+qrbIfeUDhPFpwtN+I8EV20
	+N9ZAQ5HEQWCFo44bVkF2m/Wvt2kLpOG3ZAfTW9o5XGvl5mAKvREW0NkrVOvfNO9
	7u5U4E825nVsPFPXHh/04onNb6hSkMPBNzr1T/bu4FcvXExdVQOT9gH2K79oKS1n
	eHlULyYNREX6PqUlfgGHTndGSY0szqHmZYptYbRBVk8QiqcTZ2PI8HHAIW9FiplV
	dvOv9/D2M/H85wbAJotnFnON8tJing6F1cNm3jVAfO/vczv8WL4SgA2zPXKsp2uO
	MEfmqKwaM+D3Yd88hl83XZdbl4Uw9Wi5rEQ==
X-ME-Sender: <xms:kI-oaYbelR04nGGMKlQh3hO92hSThLIzhNJn-4KyvFS1NLXFvqTzcA>
    <xme:kI-oaXFktY3QTcOTFvIn2GLCH7WjyJG7oYPRwncOMgADd8ZoveP2odhFulOwSm8rM
    0ifPjdIHDdheT9yC4PqM87TPlQDleSMXLuDXNX19riH3udDxvb6>
X-ME-Received: <xmr:kI-oacykaC0NX2l9zJCpOESj4D53eEpFovFQbC7tcibTyOZJQJG9H1enHss4izhsywDp_-ReS5GdYjL4DTrmTEQsrjUWS2J1CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeggedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehmmhhonhhtrghl
    sghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:kI-oaZnimhFJyrNZMYMuW8ILhHS66jbni9p4At15481Kvz4iZahULA>
    <xmx:kI-oaVnACaCNqRsAKaPW5NLEyO0Y98IbRK70yXyWa2J1qcZpYNp7zQ>
    <xmx:kI-oabz6MvYCB1zczHEf_QOeqYkah29z9VLlfVeDnBgwK-xUkZAy5Q>
    <xmx:kI-oaaogUtxmY10P1OCteBNPNM8qvzGS-uiSmQwGUH-r1xUJFac4EQ>
    <xmx:kI-oab_tbBCxOLPFWnoX_-ZAfKXh8BhsZNKmaRvnf5tWeoJF0N_SmuJM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 15:01:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Matthew Hughes <matthewhughes934@gmail.com>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH 1/2] line-log: fix crash when combined with pickaxe options
In-Reply-To: <6e97d88993dbab4070ac0aa999f70564368f47b1.1772651484.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Wed, 04 Mar 2026
	19:11:23 +0000")
References: <pull.2061.git.1772651484.gitgitgadget@gmail.com>
	<6e97d88993dbab4070ac0aa999f70564368f47b1.1772651484.git.gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 12:01:18 -0800
Message-ID: <xmqqh5qv74a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> queue_diffs() calls diffcore_std() to detect renames so that line-level
> history can follow files across renames.  When pickaxe options are
> present on the command line (-G and -S to filter by text pattern,
> --find-object to filter by object identity), diffcore_std() also runs
> diffcore_pickaxe(), which may discard diff pairs that are relevant for
> rename detection.  Losing those pairs breaks rename following.

Shouldn't that be solved not by omitting the necessary call to
diffcore_std(), but by using the "--pickaxe-all" option?

> Note that this only fixes the crash.  The -G, -S, and --find-object
> options still have no effect on -L output because line-log uses its
> own commit-filtering logic that bypasses the normal pickaxe pipeline.

I do not know exactly what -L really wants to do, but from the look
at a patch like this, it smells like it is abusing the diffcore
machinery.  If it wants to follow the rename history for individual
paths, even if the end-user's top-level command line option included
pickaxe or other fancy diffcore options, should it be *reusing* the
diff_options struct, prepared from the end-user request?  Shouldn't
it rather be using its own diffopt crafted for that rename tracking
purpose, I have to wonder.

Thanks.
