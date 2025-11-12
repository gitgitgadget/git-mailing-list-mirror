Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3F19F137
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976182; cv=none; b=LArbfnal8RRUA+0Oq4DUUEDzsAIelQ7ibROWfUFJ2vxt+jJLQfT7my+aC6Wz/5Zam7+vvOHtO9pafpu4SsdNLnaS2SxFdpJMUizMNK83t0rfx5r5YmBmiUzUvriaZMDMhKt30lBcIE3DJlBhUCv5yFbK7VYUmVubNqt2uOSwaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976182; c=relaxed/simple;
	bh=YsxFVxvoUKGeIZj7ML9+KE29LdfZKu1mGn5AjNJogec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUU4qrJ+8oH55VVjpyVnDEuxG4Hx2luaVXT1hugXVnxn6P7eoZv3yciBTGFGbKksXR8eshhTcE4mQaVlPmhfx3waXGtTBKJfP1hZXZQRIIDGhAmvFFBn+N/W9b9etJ7sdGqgs1tsO5djn+vzme60pEWZTyQMwqA+hm/HRcqF9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AIBnD6s0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OehaI4mV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AIBnD6s0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OehaI4mV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CC2B51D000E3;
	Wed, 12 Nov 2025 14:36:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 14:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762976179; x=1763062579; bh=YsxFVxvoUK
	GeIZj7ML9+KE29LdfZKu1mGn5AjNJogec=; b=AIBnD6s0IUgiuco4qfhPaWqG5g
	5/ALyy1A4xRhdBNjAPL/l4bwIFdHBiXjZh5e2I1WdcLg3Uj/ajZ0T9tT+M6jvK9v
	nDRyp4XNhN22Ar0Vj0vbhnjCnfH4alKKaaAVGVMXns+UbqMcY6gzuWUcKIZvqiCF
	aLwCZ8kk3Te8T+vIYONNVqd2Z5TyobfSSt9KJH9wWxK0OP0/+IpBVT5blCz7ZRDr
	Za/VauJUQPGHsZqJ52d4QMp7xXltzkJMDuMdRKaJix7gxV1O+sI2O/VZSogbtXhR
	pYOkzaSTYZVAhyW4IVnyt1SvbUV5gRr4F2stw4a2YOi271MbqLj7s6H3IAKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762976179; x=1763062579; bh=YsxFVxvoUKGeIZj7ML9+KE29LdfZKu1mGn5
	AjNJogec=; b=OehaI4mVv83xDdDKvP5sPeTSlt7w+EuHDhlr3aUIkz9PFZ/8NRR
	K3ZYAFnuBudKlzpMzIUorNiDtw2e0CG7CQknICWRhDrdWohTq9ZugCkDs9rYZigh
	gvzTcmFacrfpX5GfduQ4dPDndmqegUWkTPzYJpkACUXdHlMNfT/EMnQwkdqbNOEm
	qiZ3B9xgkGS+UsIDwvTZQ6oVTg5HEZmh8llYxRixdVZCJWvM6KHGqfyzrrmGFobA
	1LRaPojrj48CD5tecFna1ot/k7AMoXqsX8qdFIbRx/Xu8Ywzc7hS6vL1DtTpRrcT
	3wV02FZvLGt3NE+QlRBgDFuAAZ2xYgrxcnA==
X-ME-Sender: <xms:s-EUaayWE2giBluOEr3Gjnrx3ttyXjwKOdV1A6glldAqtboN0Df2mQ>
    <xme:s-EUaZ_wtu8-SBB6UZVjZcjXps3EzDc_W-oydwFEfD_ZzVSNcy3jdDYmPglUa0dvK
    r4WNT7PSWlbBlhyShOk2vuwH6MvNyxm801c9J0rKyH5e7KLVsbvTA>
X-ME-Received: <xmr:s-EUaWKoamqY67ik8CWyyP1iYjSIJAaffzLfq8wVHqrnxqGs3nOQ1cfdZqA__zduvHykbW3WvZsGD6ztxAIg_Ow0Yt3O_VNHWS77>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:s-EUaXct9zwlqJ9f7mJKthu3huQCRQtMOl_LzORVoe_wYchg49rCNA>
    <xmx:s-EUad8UQYob-dJgiqHWnQzuPej0YGkZFa2jp-51RsvU6J50dZz2mQ>
    <xmx:s-EUacpbOoXQI4-tL1yW9DRhjLLn-TWooRRKmQIBljYsbgYNG1yWiQ>
    <xmx:s-EUaaAHkQDq9_5uACT0Ezsi1jVinbR_tP8YJMeBboOzcSFGausQIw>
    <xmx:s-EUacXlIrU278MBexXL3s7j6eJz4IfJ5axzTFQTEY20Pu4AkDYYRWR0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 14:36:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  correctmost
 <cmlists@sent.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 8/9] fsck: avoid parse_timestamp() on buffer that isn't
 NUL-terminated
In-Reply-To: <aRRux2uBfORc214r@pks.im> (Patrick Steinhardt's message of "Wed,
	12 Nov 2025 12:25:59 +0100")
References: <20251112075522.GA978866@coredump.intra.peff.net>
	<20251112081040.GH979063@coredump.intra.peff.net>
	<aRRux2uBfORc214r@pks.im>
Date: Wed, 12 Nov 2025 11:36:17 -0800
Message-ID: <xmqq346jqc0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So this is another site that would benefit from having something like
> `git_parse_int()` with an extra parameter indicating the number of
> bytes available for parsing (and a way to disable unit factors).

It is certainly an interesting approach that would work well.
