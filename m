Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBB3A1CD
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704523; cv=none; b=ZvdMoGN1cs5W7BOe+yjYXGsx9KGzFJd5TMCLITrEMgB4PmHrZ0nM6bqjr7El96td8kOd2Mo/8ILuJjfsydXCXcIoCq3dtDwRvgIz4D0xkmW3KXtMQymF6VZD3YV8GfKyw2Yz0Swqh1u2gXwm7wYUiLBaTFhEu4Q2Qt3/09MpFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704523; c=relaxed/simple;
	bh=82pSJoYWZf6lyZSCm6kYiTARN1bVyS/3D+3rBPUNbIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1A2Jc1f+CjM/W67rBccuNzgtVsj9R5EEpHlnsbarweuejVh+P8u59bPw31fxhzoGlkdsNeqv7ATBOOhqu+dV/kDb5kEomhvnoP35Um8lI+IsGqyLOpIWP5sGg0vReC46P0zr8mHzyAXIcM5h3/SQFvnVK+31E7tMi1AcbZTJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bG1x/60L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRuiWJxv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bG1x/60L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRuiWJxv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EEE8EC023C;
	Thu, 29 Jan 2026 11:35:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Jan 2026 11:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769704520; x=1769790920; bh=4xrURCykS7
	ZK+DqwIC9lMVx17ZYNP5pq++WvXLAyz10=; b=bG1x/60L2d8ZZHBeGhiWZsamLx
	eFgdZBlUEAMLOWfqujxwsIba0UuizgDkh6gytaI/Xe/H8ADDa/WIPUsPS/kTSF4n
	pjFgcsXLnjOQeD0Rp3KDkV5ZxmtK6T+QIvmYd2TI16YPESFMZA4YkIwW+SrOiKGC
	J/xOqQvl35OmNYVt8ZDX9BTApfTCK0EmFJxMM2DGFp65rTOp0vrUdjFAoENT/9aP
	xHI67vGFap1J11qtveDv9gqeeL1Ve1lE6jiKqriRFO5bTVqTcRxmgZOm9fAU2FyL
	Up6SVOgdMSj/p7kITJpN8gR3GTs0O52IeRrUZrAGyqSatAzr+ODcpjQAqLvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769704520; x=1769790920; bh=4xrURCykS7ZK+DqwIC9lMVx17ZYNP5pq++W
	vXLAyz10=; b=pRuiWJxvggzwNdL/sNgdP/o0uBvAEm4P8FdIzNGdpctVPv8OB+i
	MX7ByS3LnGNfdgQfQv8ff02T/ajtJI632HBEpyAd3oBiVWFxME16W5ONUTY474NB
	buJdrKllbmuqhiQzlhkOme1HAge+dCl3f/gnDKEKaiv1aOYAGWgg980nTFhw6r+M
	RGfGLPICDWLbtJbhC++uX58tcArciawTOiQ3lvslOcJaKzvKdKxkYLxAGW9EA1qG
	HWg8MZID2Dx3Y2G5FUj9geBFrphG7N8UbEHM3LxDEZWD673XcoXQW3KXCSfE+4Tr
	z+6cDCPCNtWeJXVCD9xDqi5Q9MyS9jlwY1A==
X-ME-Sender: <xms:R4x7aQw4N8ZBHSosid4qlnpEAHk6vY7Fj7vR31GmtX1X4zseuJScGA>
    <xme:R4x7abRlHHg--8OGOLCF0rlz6-dWxfn7VCzUvozgrw1e8W_CcZgWgXgMyf7szm0QR
    5tuAUhIAgZeH80HJoVUsmSQpuep0ZoXn3pzGe78ziLSLFVAoy5Mfw>
X-ME-Received: <xmr:R4x7aXUTUe_Hdu7jPnChiCsX58nY1lB2F4bRzklvVbqhKQ7ie-mz_maR_3QMHmQPJsX4tcMqgrh2fvN0qZNjZ1g5FqMoq-t8AoCfNEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R4x7adZ0_PtOlfGaoYwxB-sTaksiEKUkptXHtXUTbmQNTXb2Dj_uhw>
    <xmx:R4x7ad04_xHxtpyIRP5DU8egboBCDZXujF2HCklom419entTSnj43Q>
    <xmx:R4x7afgRFFc-xhDQMpLblWKEC5BqvY0DsGE-32yp9e7FfNJ5jA3QjA>
    <xmx:R4x7aRaKO0QPxddL58cLoQKGF3YlFEETXvZTmarxmFCRZBXG56AQsA>
    <xmx:SIx7aWnOz1JAeDpZEGssfeUCM_ERlpUbRMJ0eY1B9SJ946tgqHyb9NVB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 11:35:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
In-Reply-To: <aXrDD1H4lvBR1sF8@nand.local> (Taylor Blau's message of "Wed, 28
	Jan 2026 21:16:47 -0500")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>
	<aXrDD1H4lvBR1sF8@nand.local>
Date: Thu, 29 Jan 2026 08:35:17 -0800
Message-ID: <xmqqecn8cr7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> +void for_each_preferred_bitmap_tip(struct repository *repo,
>> +				   each_ref_fn cb, void *cb_data)
>> +{
>> +	struct string_list_item *item;
>> +	const struct string_list *preferred_tips;
>> +
>> +	preferred_tips = bitmap_preferred_tips(repo);
>
> OK, so this is the sole caller of bitmap_preferred_tips() you were
> referring to earlier. That function's implementation is hidden from the
> diff context, but it's effectively a thin wrapper around
> repo_config_get_string_multi().

True.  I found it easier to see from the way the patch was written
that this is a pure refactoring patch, though.  IOW, we may want to
do that on top as a further rewrite, but I am not sure if it makes
the result easier to reason about.  Such helper functions that are
file-scope static often help reading the logic flow of the program,
and compilers would inline them when it is more beneficial anyway.

