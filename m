Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8814F70
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123708; cv=none; b=W4lg7iLk/Ab5dhDkVJVTHCEu5Kl5/w0o7pLFbUHFE+/fNfDRL4FN8JjE6vvD2VayEnqB3R+r3cfuYe2cjB5MDby0EiyiQGcpPBxlxt9so1k34+JleUIoWXejwQX3T9GbLCl8dbZrw2FFvHdvrrSh7QTyXpzdVjydUVHcB1OKLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123708; c=relaxed/simple;
	bh=iFXk4D2xoC8MYVF8pXaJWZAZWwkuuH3bf8ROVKieiOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mc7HYhQ0UTV2ikeR3l+dmAleHMQrAyvnKC/OxCsrVEp+LLTJgXYrc1irV1l+7QZu6WLjIbcOi+Y8yVumpbZUMiqD9ndSFUKaQVKu8YU6pXZLEUU4PlRnt+PNzJy3O5gr1eDLYSzvVCNfjzAW1/dBRLlSDmEiypQRzBPdefXItP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fjlfC/zn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZ0rQnk4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fjlfC/zn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZ0rQnk4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1A031400E8E;
	Thu, 22 Jan 2026 18:14:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 22 Jan 2026 18:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769123699; x=1769210099; bh=8us2JKa6E7
	oF4e7k8E8C/VdNEppKTKzmM8zsi9lT8KQ=; b=fjlfC/znLoP/B/DNtdrfQ93DgU
	jpNvJsFHPUKAOi2NESBh7aH2iwEdn3LcnME8I1BPr/RqCODHlm6YIdBVDzJdYXdn
	05w95o6zU5BB5hmJOy/10n5MZXzK7/czvovaRHzmQgL+Mmp7ADXSarcNJvviw3Q2
	T2P2SMc1G7ufFiUHmkeAKLOmfJ7GeJUU0iaZUskCYr1CuRbaOfAqVpcWOx1lV/f+
	iiw7lx615dVulHshatCnMHwwMx02Nrsv9/e7ZyUK4dC+y0vA6tyJm+GXNGmX68q4
	FtUYcp01ABAmF2d/Nn+4ffyPWKHXV+0eNlSnaOpBHFLyFPWbYv/ezByH1gJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769123699; x=1769210099; bh=8us2JKa6E7oF4e7k8E8C/VdNEppKTKzmM8z
	si9lT8KQ=; b=UZ0rQnk4YPIjjZxwDZtKpxF9Aafky3MQpxrPNvn6QxWBLoPSIT7
	8NSdPylDCyzRA96vTScJ3qZm4uxACKk/opkMWixqmI7oTD2xPwZnpRM+NDMSeN0S
	WWZVxx8x8BFkBHyk5HKNo5h/UtRzONJt9obSbUFQeqEbNSqH6SMWnQlFXa7XDgH1
	vXNNPVq2cLyvXxC9f8r6Q4RNCSb45wrgQkaeML2z2ThQYy0jtYqAZf1pu4F5vhLF
	zwYToOvvIAqraNvGww6gyq8d/c6iIhrvKZpHmRE8+I2aA1UV1mfHxadnCWY/QFak
	t5739mQ/AC8LUaURysOeNFzJtDsYv+PNwBA==
X-ME-Sender: <xms:c69yad2nOpMWEOZNJGDOoA2cu2d3yh5uTx0dONcyd-GpCvnXIDpXPg>
    <xme:c69yaa_tsuOFS8HT9aIbAE-s3RDLebn2uxp1WPMfzlyW5FO7Of-zKuoTYQe2HWv2B
    GUmIRlxDYYJ3AJ3tV57L0t8QYfci-GUy26XH_2E2xk3L3CT4xUdgA>
X-ME-Received: <xmr:c69yaWMAITexa8FY1gvYT37C_wqNO9iMWDnyZxYmzlLxdDzzuRxPD5a8XC4QBlgAT7RLu8S9csmbxXqfZJKS3Lt0mJVF4zCSlPW1qog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:c69yaWdGS9rSh5MhXjYyXicY24cpybqCpVsaRvYPTsZHx7FlaEQrgg>
    <xmx:c69yadVAVwEQQJMBRQmBLlxSaI1hNQn4aIuRuKoNhD8vQ8W1jq_c7g>
    <xmx:c69yaWhSvnT25sErZByH-saXZUy07GlotNXK_BV83t4j9F8STb7NNQ>
    <xmx:c69yaU_OKzFl7ijcOS1XiBmWEDKpUkGYqC_cMbgMJRJ1B513hluK3A>
    <xmx:c69yaaKzLz_YE5HNWnU-aeCq9sKvAONpx6Ll_O4Xmi6u8X7dTwdyS45Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 18:14:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
In-Reply-To: <20260122224427.GB2107958@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 22 Jan 2026 17:44:27 -0500")
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
	<pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
	<0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
	<xmqq5x8tmlj7.fsf@gitster.g>
	<20260122220154.GA2107958@coredump.intra.peff.net>
	<20260122224427.GB2107958@coredump.intra.peff.net>
Date: Thu, 22 Jan 2026 15:14:58 -0800
Message-ID: <xmqqsebxjl3h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't know what all of it means. The "%s" thing was short to
> implement, but the real source of the extra complications is using
> repo_dwim_ref() to do the resolution. But I think the overall direction
> is more consistent with how the rest of Git behaves.

Yeah, I tend to agree.  As long as we do not hardcode the
prefixing of "refs/remotes/", we won't paint ourselves into a corner
we cannot get out of, I guess.

Thanks.
