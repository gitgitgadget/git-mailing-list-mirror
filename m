Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181723C505
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562793; cv=none; b=S50o2eZDZx8jGjYJ+8NGVi7j1NGPTS8ASgHvBmdw+FImFjb1G4lHKHJPcXqNsrJfnkxvhw7bASgUUP4pli4tofZaS32zYH/jde8lcLL/7NgU8VkzX3zYhyY4PPB+YRZPYYZHNyzpi8q98sZVmAO4hHFEBAcOQKI5a70F3wbWO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562793; c=relaxed/simple;
	bh=w9whbmEpNqUpLTryYR52w4hdEJD7fjLXhzbRy4CoFAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JyUXY3YoJHNbvcaD5BuiM9CXErRd1B9hWyBQbGhs3ozDaWTQhrub6oJOt6TwVUgZG8R6j1OZRPzm85qe8QlnMc2b0ktqS8+ckPCwFzpaP/UTJm9bDAgR0rOdbxstO6tpnrSzGRMt0/Y7I1tyPx1OEhx5SzLjVgeCqQYJpyKoIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V4qavqfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6zef50F; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V4qavqfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6zef50F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D35CE1D00156;
	Wed, 19 Nov 2025 09:33:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 09:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763562789; x=1763649189; bh=w9whbmEpNq
	UpLTryYR52w4hdEJD7fjLXhzbRy4CoFAM=; b=V4qavqfiliwn6atl0oh0YhU8/w
	KkL5xZkr+JuD0mFHM14fRLRbpTU4NksvLj/QqROLPI8St7EUIy8PI9c3I/ODzotv
	As75zbJwu5gC/JcmFs4+TTQJKOYnUlqG1AuF2eSjyrn/xzXZJKESiTS0q3zIUQ19
	N20+5MrxsSp/mWRI27Q+uOsgs2bBODIqJp1BHizGUBXv8vmRm4hIY3RjF72hB9dW
	M4vvu38xvthbqQd521APPRKjCFd0dsCsw0efHGxPr4k6BNjBEmPx8Mvwk5oAx94a
	S5kFt1VTeP8uWBSVLOV/675hxXMlHiW/s/Siq2dhZ95ussXAd38lhbKOeOaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763562789; x=1763649189; bh=w9whbmEpNqUpLTryYR52w4hdEJD7fjLXhzb
	Ry4CoFAM=; b=U6zef50Fpth0dQGmNDHEbdNPkaPn1UoxfRQaTMHFgdqJAu/wPiO
	2E6rMYmFkk3rHCzV2CWn7JSbbdIzNVJAcAYCyVMNCq7+WXJaiB++jTDoOt+kh3xT
	mvN1//mI7HWxYBvmSg4alcyo6dg8ZHg/3KrHy/MMoUrzlAPDJBWK+p+8s9KMhRrb
	X8aYjEP9MrVyVSE0l4HOh6JPDoIZxpoma8bU/lOoqlGNQr1XiNgmVlI2Xh8f/82K
	0rGCbeYAfYwWJU4KxfhUb9AGWBZIBvW3Wjv13lHPW5bNuIvodgUfQ4U+6QMZzAZp
	DfN0RfOZH1o5AoGZaYfyS7cTAugptSuXbuw==
X-ME-Sender: <xms:JdUdaUKtzmPKrmLTXYvmqh2Nr5nVFULCTmltG_1yZgrPlbsDu-lJ8g>
    <xme:JdUdaX1S8hq906OM1shKndquGmkp5V1T6B0NhgvJkT33SWzIPBRf5QEsK2wLvBmO-
    DMBdFYMHNmsDq74t0NAjGsbOc3rqVFO0__shlCX5ZCvy5GsbThq>
X-ME-Received: <xmr:JdUdaejHSOlUG9nn_WeKpz0xtc26ib9ikEpCBoIbB07wbAhEO0VRaWgaH4Sq_749jR9rOvHJml7a0mRKsn6-mgWSp7qjPAUU8vsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JdUdaYX9ZBVOTubZgfakH_XQAjxU5vmoyEwiK797gEdQDwtf6Ltojg>
    <xmx:JdUdadU-10psC-Npr4dscMxhjIEB-9KLtmpxlofzixhAah4WgHyiAw>
    <xmx:JdUdaYg9pXHn6u-aWdLxUtVvLni7ro0qs_9bZ1NjNbjAokqvFVdOkg>
    <xmx:JdUdaYbZC5ASWHueZ4my5BZtFRPAApqIV3bt68eaIVBvtlbv4GK1dA>
    <xmx:JdUdadObiuO25DzZsU1-RoXvvrjrPrf3kPCwP64nPUBnOtw3EvEFS2LY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 09:33:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [PATCH v4 2/2] repo: add --all to git-repo-info
In-Reply-To: <CAPig+cSMOEWUZPfLQJBWpAgK-cvAUMgD1t2KsVVAMWn30ngwiw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 19 Nov 2025 02:32:22 -0500")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-3-lucasseikioshiro@gmail.com>
	<xmqqh5usiizp.fsf@gitster.g>
	<CAPig+cSMOEWUZPfLQJBWpAgK-cvAUMgD1t2KsVVAMWn30ngwiw@mail.gmail.com>
Date: Wed, 19 Nov 2025 06:33:07 -0800
Message-ID: <xmqqfraacct8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> For what it's worth, I had the same reaction when reviewing the
> previous version, and thought about proposing the same rewrite but
> figured that such a comment might fall into the "too subjective"
> category, thus omitted it from my review.

Heh, then that makes the subjectiveness a bit weaker? ;-)
