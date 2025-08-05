Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C0EAF9
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425084; cv=none; b=tW+Ad3AATU/eI51gPIaDJFZ1Il64fMaiuTUSEbC1SXof8CjmrOoAmCKYyreMMJHA5XigIHaUF1WvHXFR8qbO/NjQuUDmKspoBsxbXSP+wAfNHj0AgTM0Y9OopsWnB/4tUeRx8mHRYXfytaiRnA32HIQzZZe+FHMnZQR5bFd1h/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425084; c=relaxed/simple;
	bh=kJ9Bsx8nkOeeU1WF7m4cfiQXOiJyfRfFLUHdZvFo3uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aBqNjDGNO9Rv2s6g9MSqtIe3Oo3nGo/OgYguits3s2+FqYhLyDlex4Bu2pQhiVoVLr1iawjPT6YH3ELz0+xg9NMGK7C/RXQK+WhcBYyFWtYEbgTxUxQEpOfeBxqx1xa5VI2rp06FjgRilkFZuDcQmTB3N2Ft5vKjZEis6YCbMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WkQzLUEQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZI89clj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WkQzLUEQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZI89clj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53FC8EC01EE;
	Tue,  5 Aug 2025 16:18:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 16:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754425082; x=1754511482; bh=B65ocD7Wbn
	BJLKBAsrItkFyaKQQ1yuugw3/pM+xGR4w=; b=WkQzLUEQw1iLH5RNNjsh+31JAT
	mZe5H1sue2qffqL05GY3nzgRyG/RaDik95tU5YTveFgQiQ0qZSpZvct3s5Rv1Tdz
	Z9T/93o0MlEoo5oC2RFqBzpCd70NM6l4BbL8DfiNjKnrd7x+e1pmsFkoUQ65NhXo
	J39weHXRTjdTnsKfvtmQ0Um2jL+M04tOCws1j5b5cO0B1RPJ68LQLBrllgQYr1rl
	AdB6o8/U1gTcLPfWD89XLiaIwdD+3seW18HUPTovBV5MOnX+JvtQkbVW88yDC54m
	04GDKh67BbIg6H+bS2qdc2LJ3hl501dOs7pLZJNh8SR2zJUgfqCws9R/8TmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754425082; x=1754511482; bh=B65ocD7WbnBJLKBAsrItkFyaKQQ1yuugw3/
	pM+xGR4w=; b=YZI89clj7eJwVxfpz40DYPo5n3LyitigNxLbt+99LQ8FtYX6Tgl
	79E+GTk6qSMbAfLyzlbnzd2uLQncnNRqZMN8zoAvFZJBKdVVk+loV8oszPjerb9n
	MvnOBz7W93elAZzvkO7Q0vtb9FgnlBgTBAjOv96jCPj87afDO547q+QmscZ3DN9T
	qf+PNxBiNYOJlfqe9w+DH3Hg7WHeojRJAxa6cqLpnxP0ltiATmzK4NrMrt1R8iie
	4wnNQjmwGokAuz4qNN/JK1ieJvc802AGIU2eRmISMUfL6MbZobivP8ItRt6zvqSD
	NBaHin6afLCGVJGmSq1X8xuQioTE6wHRR8A==
X-ME-Sender: <xms:-maSaCuVxRZl2X828o9c4oLQ0ehSv27oSGx0LqSuMx0sSECeWDoeUw>
    <xme:-maSaC-426YH4i7TssdKagOmyLuv7Km4fIK3HO2B7jDjOYml7L54HArvv8Q164Zsr
    8htT8aJAakggcP4yQ>
X-ME-Received: <xmr:-maSaEPQ_IUQx565Jl0tXuK1-sfwoe0vZaLGMjdCrfCvPzOB_M6cjfMtyOaDQLbkcEXadPIef3LJ9-WC00wD7nIWlIbnILVBGr7UtwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-maSaIGbmnyRiCcf9-vjH9-VD8n-RuUQrSmGv7hChpRBfCPLqRoiTA>
    <xmx:-maSaKR1cjK1RRtW3UUdnAziMQYewYe0Z4cPtWuBx5Bu12GSW8ExPA>
    <xmx:-maSaNu21lEcixn1KXJr3VkjMHeMHM8qJzuTA7YqUUKej7010aKmaw>
    <xmx:-maSaKLeCTQQnk-hcKXpLnRxEmgd-5bM-6vw80FH46d5K4Sw0QQfjQ>
    <xmx:-maSaB_lvMe1-BKOv5g5bOTSNXLZZU_ZfI1EVyj0oWoe5dWPw3MN8yH5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 16:18:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 6/6] merge-ort: fix directory rename on top of source
 of other rename/delete
In-Reply-To: <7238c8caf2b3c8c2516a8939c7590566cdaabd03.1754422546.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 05 Aug 2025
	19:35:46 +0000")
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<7238c8caf2b3c8c2516a8939c7590566cdaabd03.1754422546.git.gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:18:00 -0700
Message-ID: <xmqq1pppzfnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
> +	  /* See testcases 12{n,p,q} for more details on this next condition */
> +			 || ((ci->filemask & 0x01) &&
> +			     strcmp(p->one->path, path));

All the other references to testcase in this file tell the readers
which file to look at, but except for this one.

	/* See testcases 12[npq] of t6423 */

or something, probably.

