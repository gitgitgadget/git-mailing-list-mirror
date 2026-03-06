Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E933A02B
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838195; cv=none; b=YT5cCTpPGZVW5Q075PdHgcfTOynMjbBQFgk/5yq39ZXvHMq+dSXhCe6+2hbaR7yKsuB8b46tfLs0FAxNVHk9RWgymOQ1mvxFNGQaaLiZ1Uf45k+HzbqXcC8xyYi2+e/rWI4aSDB5Er0c8A9w0gu2rKsIEnaZKA9Wua6+yVBQUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838195; c=relaxed/simple;
	bh=TulhTw5S7mZX1Y2ZxsFRL2evtdBKAWKRcdMGXYBfCJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hl3P88nMH5cRAJX3a6FZ8nulwrwof8W+8P3v4pErWuhDgfA9fJwToSHNtLbe2FzwJ/UW/NYqVJ0kSm6lFlp3SnH2yRIW6y3Irff+BEQrwQU3tZ3Spzlyo0IboBB4m2mdZK8QQbDog6eHWRO8Jb7TD2QPym7FxTO7MvD46bfmxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EFsvVWIn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDDno4Gz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EFsvVWIn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDDno4Gz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 30F6AEC0107;
	Fri,  6 Mar 2026 18:03:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 06 Mar 2026 18:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772838193; x=1772924593; bh=tHfEWOVzj8
	Oda1KFRguLGkxcVajFnA0QEjLTMsA6Z+g=; b=EFsvVWIntY5CLDuSN4CC5sy7jF
	YPVXCTjWEQNj2vi9fvyn11eRKMxa5hfcV96Ed2jTp3JJjdlo3dlvTBUGZ1VNdkAI
	k3/d17zn6hslZFQ6tp0JRSBcFxHby2WlCkKZUjVex3NIppZW/A0R51OfthUFRY2I
	8qqQMRRTcIG8tIP9eTfmSqHCpT14wJCl1z8fgaYLOBktS2xGwY3HrzWam4F+j03U
	QUX27JjuJRC+BgEZYIkMzPUpu+Ow1xXqcrR1+hjyeCAQRpJf2oInVdZfCYmb5+M1
	tW7U0uX0pTF1T5iKIuqnCSWwICFWQnKzaJUpdY8AGfD2KKaoXblKC2JDmqTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772838193; x=1772924593; bh=tHfEWOVzj8Oda1KFRguLGkxcVajFnA0QEjL
	TMsA6Z+g=; b=aDDno4GzCQAPTQN2uH32yrVoyqVh4OuZNsIBemB24ckfrEHCoFM
	K+y9TphghF+GjZ5UIGiy7P9nBxn8fiGF+Yk7+WYmut6GQESRRNHnQ6Gdp6P93wIM
	G8KAcnAnt5/EogITZ+rZs/rfFIRJCqTYGSFJGol3OsEtNPGzL1wRnXe5WAe5prV0
	mK8hHCpmihgKc2ShXFgj192PgoRlRp5xwUJtbg7c/clgk4ETvgy5XxGdtaMK2hr+
	CQtL0OxjMP43qhTJVT74s6V08sQIP+ahxKIErRSrABzSSBFGQkgDRBsuwz7f0AgE
	6rxDzk0of2sHeab3yKjaB1KUL3lx4VrcIIg==
X-ME-Sender: <xms:MV2radiVqUc1mOOjVkR_M20jrxni0z81n9lna6MNtuOoiG8KvJKJ0Q>
    <xme:MV2raZCdI7aPdmHGOR7AVpebHcmnxnrbJmu5gTOPC6vMtWsrMFZK1_r-tp7Kg-ORZ
    1xUvZByHBltxDL7ZYFDNO7Z7ZtbmylKyJtaG-lYEcnDIQCO4Ah9_7I>
X-ME-Received: <xmr:MV2raSGEYxvL7XOYxLp7bJr84eHCawI9omN3ChN5VUJZ3VhrwYK7RxeE0JyI08silm6o1c1awMkbuBezW_prHijIDwy2WBOwQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MV2raRL2oFf-DC-D0Uxd2WoTi0TmtpUKWi1nVWLj5ic9kg4XjvVB9Q>
    <xmx:MV2raWkndg7J2rtpbW4rRV_N4cGzEyAQpmTrEyyqFu-Un98CkQtM-w>
    <xmx:MV2raZRrGQHTXMm39vhkFThgrnBgEIwELWklEBoWaR0zRbsj33vF-Q>
    <xmx:MV2raYLZ1FoG8CiIGXLnainHZ2rrE-Y9c-8DZgezX1DRN0DRKRyybA>
    <xmx:MV2raZm9R4kNL2G1U5YxJcRlYpLWiBS0otRdjqBvlm2EaLqMOhxvY1tu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 18:03:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/10] Xdiff cleanup part 3
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Fri, 02 Jan 2026 18:52:14
	+0000")
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 15:03:11 -0800
Message-ID: <xmqqy0k4wogg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Patch series summary:
>
>  * patch 1: Introduce the ivec type
>  * patch 2: Create the function xdl_do_classic_diff()
>  * patches 3-4: generic cleanup
>  * patches 5-8: convert from dstart/dend (in xdfile_t) to
>    delta_start/delta_end (in xdfenv_t)
>  * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
>    xdiffi.c

Is this topic still viable?

We had to stop merging this series to the integration branches as
another topic <cover.1769424529.git.phillip.wood@dunelm.org.uk> with
smaller footprint was making conflicting clean-up.  Since the other
topic was merged at 5465d368 (Merge branch 'pw/xdiff-cleanups',
2026-02-20) a few weeks ago, we may want to resurrect this topic by
rebasing on top of a more recent 'master' branch.

Thanks.
