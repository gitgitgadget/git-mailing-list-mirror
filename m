Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F61B4152
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619401; cv=none; b=mHkXoQF1Je+id6hiY4dp95Cs5g7GnnJszlkuv9UUR32c+FYf1CiK95zBHtzA4ovNY/mXeHWG5z5nWBPRRCm4cx5gRPeq2bZH5phHEDGwH6v8kj5pI4fh/1QZd3Ow+Zzr8UHwZVow8jmkqntU1Ib/7m8rZokgtgl2kSzYjYFxEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619401; c=relaxed/simple;
	bh=DjN4OWmO42Hq8eqhsrllVyiwv0NIeYJ5ismJt6B3llI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swKb0pzLsRaDwlxsNlXJwJw4+/GKV0z/V6ULpmThLk/PIr7DS37o8d2tC7e98Tvpgxya8R5aSEKOaSf31L7ykhu9FuO7ah+VzkR/nlNiaYrZ596h0mZCVL7z00G82Qzjd8IjfG5gdQV/AjjHKhc07LsgMJHIICXG4yI3czSGfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D9LTu9hB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqcZPmdG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D9LTu9hB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqcZPmdG"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 0199D1381532;
	Wed, 26 Feb 2025 20:23:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Wed, 26 Feb 2025 20:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740619392; x=1740705792; bh=repgC7omI0
	44EZ4QTQRS7xHhfVCZob6G4Csvzu+Ljss=; b=D9LTu9hBNkxE2qC2ixWUWjdeLO
	pCcfxtE48BPifWkI2wzRge5d5i9iQ+QlyAT/MZy+OR01n5lb2g93yPXS9blyjCtX
	+IesLIzB3TogwDfwl+NosbXUoIuQiC8hyPbMkrjTcvs5NCx3fPhLLsieR03IobT9
	UgkpZ4nFtsykObDc/gUai3bjZyBLWq7Ml7PmqpNSPM09nCuHxtjiFiKEaajoR1Bd
	GXuQo6ETtXNQLH+fR7/2UoiEV4V4iuS0UmgO5hOX8p3H35cJlNie84hM128EI6Sf
	WaVSKPQheLdP86RrYq8zGcnmtKk8F8MKlXqC78LlBLwY5jYR3S1Miwcn+wHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740619392; x=1740705792; bh=repgC7omI044EZ4QTQRS7xHhfVCZob6G4Cs
	vzu+Ljss=; b=lqcZPmdGkIXQ6QtRh932Ozbb4KFqIK3wBoOQWUMd3uAiBEIF2hJ
	VnF5OIDMvrGkWfkUaxW9AiGKJ+3dxKFWf0ipojKarAruLMk31aUWSzvBjgydYd6t
	HM09yAIJzTSSltzFpuCZxYfO9pl/jIYvWEf7w2SoySjWDCiXWHzMfOey3WNjitnq
	LjSbHso1lfM4JLEyU8HD6HiiHzjMfk7Qa+gQjkk4TJtiI0+yMALs8kRUYMXN7vPK
	C6EIGUTIVT5jl+b/EwfiXL0+WmpZ5Uy37+GrkdttSx3QN79t0bx4FlRZDOxADJ39
	m6aasdSx2sBnQl5I/7Py0patII3rM/iShxA==
X-ME-Sender: <xms:gL6_Zx0fyCLkqyRks7LPqsj970FdB63tSO828dbH-zxa1ghXd0kspg>
    <xme:gL6_Z4Fp27c38pjS4HttzsV8yZK48D6GhOPrI5MMPdQj_bbkatmeLjVtrIrnJjwVc
    MRrHvboRC7F0YmPhw>
X-ME-Received: <xmr:gL6_Zx4qgoFAXv7miNMqYrzO8C79LwciKpL53w6G7dH1j-CfTOgWRwGO_MNiiQQrPspVAEpQMfY3c5zZy44vpUjYLntBDTipHCet>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekiedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pedvtddvheesuhigphdruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gL6_Z-1OzjJ19f1aIxsDE5tu6VpNBQJ7P-3WL7YvT80Yz7tm9-INkw>
    <xmx:gL6_Z0FNgIEj_y3-i1VLI6gH5YcCd8rzMRGwO6MdNJeGrzTEzCIyRA>
    <xmx:gL6_Z__m23_BhkghKdfWrb-bfWdkI0DxIiGz0vLkNXb2539cnKLjvw>
    <xmx:gL6_ZxkG3IlFbhYkpGVk4D3kSOvt1H9_71IWSGaYcu1Sl1jf9PCRnA>
    <xmx:gL6_Z5McDW_Fmo6lAGVcDgX0DUUOcAIPEScH1J_42m2K_gaAQFlm2x-S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 20:23:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Markus Gerstel <2025@uxp.de>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
	(Patrick Steinhardt's message of "Wed, 26 Feb 2025 16:24:25 +0100")
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
Date: Wed, 26 Feb 2025 17:23:10 -0800
Message-ID: <xmqqikow9o5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series introduces a new "reflog-expire" task to
> git-maintenance(1). This task is designed to plug a gap when the "gc"
> task is disabled, as there is no way to expire reflog entries in that
> case.

I think in the longer run, "maintenance" users should be able to
treat the single ball of wax "gc" task as a mere short-hand to
invoke a set of often used maintenance tasks, and we would want to
break down the component tasks grouped in it and make them
independently available.  This is a good step along that journey.

Are there other things that the "gc" task covers that are not
available elsewhere?  "git gc --help" suggests there are things
related to pruning (unused?) worktrees and stale rerere database
entries.

Another thing, how much control do we want to cede to the end users
the choice of tasks and order of running them?  When you are
expiring stale reflog entries and repacking the object database to
discard unreachable objects, it would only make sense to do them in
the order I just said.  We could leave it up to the end users, but
that may be doing disservice to them.

