Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC8275861
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770927602; cv=none; b=qnQJp3WxexVSZI9QmJW06zKLTjrZ/XlGl8yzQgm4WShLJ2HxcSL1kF6f+LW0IBggfsdglNXIhbB9G8rcEVe4XnfpFplbb+OdCpx7EXOchDaNadAHN69Ektk2zDJ+Q8VkNPBI1e/eQyJdEiQFqHat8G9YnM4TrBi2cm2WP4vxwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770927602; c=relaxed/simple;
	bh=URUh3Mj21x0XzTlpxhMs2lzl8KoUQA+uZkWNU8f15fU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyPenKDg2Dx5wnazXzlWde+36pOnpjOeMm5zQUTY1IcDUKP4SRk2L09XWhfVC4wLMrgTKpN1pvWBNSHOVuUuPRCCrUVk//LnGhfGZWNxEK/Xmg5Zq3EA0QE1N/4CTKv708LfnP4Z+cM3ecZRQ6myvo5KJiNrv/98zNP2rrDJ6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sjl8DAwv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+wKgdjH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sjl8DAwv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+wKgdjH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAE837A00A2;
	Thu, 12 Feb 2026 15:20:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 15:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770927600; x=1771014000; bh=URUh3Mj21x
	0XzTlpxhMs2lzl8KoUQA+uZkWNU8f15fU=; b=sjl8DAwv2guxvjJK/q+4wdH8UJ
	w/zMGtz6FXlyVgoKLS/QELhxr6oC0XA6AcvI2f9om9sgS6Xxy4Z41ltmpvH1TJEj
	hAKT0yGHyaXb6iOQBNFT1+noMSMhlnB6AAWqMWSB3wWr/DqqZZcOm2/i6xeTR8NC
	QNE3nIk0ly+LXUGhjQ7AX5FFHhEle81oyTxXyj74mI3lUJik9+Ik8PBY/vx7KgYk
	ww3E2e7F6zwfGew52raeYacXKFY/kFjWJYfS9LzGTIuhaos/Vvle39Kq+rY54aXo
	GlS0tGxfkZ7rWXA2GSm36hHkD0Q0ldHWwtLHjShiQdvucPz9eay0fJ2Q9kHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770927600; x=1771014000; bh=URUh3Mj21x0XzTlpxhMs2lzl8KoUQA+uZkW
	NU8f15fU=; b=P+wKgdjHrkQImF4R1z/oVPKpg92Tqs2Wcq3DDu/g9nHp5NJT/6g
	LD1KgVcxIiP9VVQwhs2PS+YdU1xrEz4uMLN61e5RmJRvf6qjA6mBs47fhkARg+yC
	jjwjCOTQ9gw6TllRqVoAsbAvdx/tdvXlNBDNfi3qhDUNNeOejKJwTT2+WtpQdI+b
	DPAWLj1mBJg7J2rEeiy61dDQXR3RE8apJXeqz+GC/f7INKArYXjI/sqycGEPHLPB
	VWCMeVNsW2Vej9KOk/VGv4jxXDnHUdk/u/OJpMDohHVLMt3j5j7rTMFQQpvixaPF
	FcnRG+BeoTEiEY7+6PaDWSpYe6Nhs2DDoYA==
X-ME-Sender: <xms:8DWOae7ePMd-ylXPsLuvIIlOKc6FbPnXXjumh80_fN6xdy7p8Ry8dw>
    <xme:8DWOafW2bh6FLeQM3TqBEt6IXUCwd0CHhlZFXhawb-RoAHp1lVGAKNoLh7ZEhZ3wx
    UX8NdJDvPaFFz57SljkNkE9HBDZz7rnNQyOkJKikJjYA1DNB8fdWQ>
X-ME-Received: <xmr:8DWOaa0M3sHdYdXrbUAVxecEEmo8OYMBgLIs0aaFfI-_Or94U5mNvoU9IYAODsDW13k4aWXl_985zUOH7-NrXdxWDoztzHmg-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:8DWOaU1XNamZYStqIJ8S-Ip5_zXJjkWwnQiMGVrdxdxu0aJzaB_cSg>
    <xmx:8DWOaV_VgqNOpp1YApK0r64mOoi5QXmKpCsXCSY4I7sEfBx6hwKW3A>
    <xmx:8DWOaZ20jUquCt_0qBD-NZ9__7lN15XWDlql2tGhZw2e6cn7tDshTg>
    <xmx:8DWOaa_-KSOAOWW3FM45EMxzBrJpyVUStEsQy-GGRmql4KhwnydOzg>
    <xmx:8DWOaXfDIVMGo2IRe0w2-EPKkWf0luHk_Y62txnQ_HlxdIvioX12ZrYr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 15:19:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/history: replace "--ref-action=print" with
 "--dry-run"
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
	(Patrick Steinhardt's message of "Thu, 12 Feb 2026 13:44:36 +0100")
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
	<20260212-b4-pks-history-dry-run-v1-3-1ce03d631c1b@pks.im>
Date: Thu, 12 Feb 2026 12:19:58 -0800
Message-ID: <xmqq5x81ogsx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The git-history(1) command has the ability to perform a dry-run
> that will not end up modifying any references. Instead, we'll only print
> any ref updates that would happen as a consequence of performing the
> operation.
>
> This mode is somewhat hidden though behind the "--ref-action=print"
> option. This command line option has its origin in git-replay(1), where
> it's probably an okayish interface as this command is sitting more on
> the plumbing side of tools. But git-history(1) is a user-facing tool,
> and this way of achieving a dry-run is way too technical and thus not
> very discoverable.
>
> Besides usability issues, it also has another issue: the dry-run mode
> will always operate as if the user wanted to rewrite all branches. But
> in fact, the user also has the option to only update the HEAD reference,
> and they might want to perform a dry-run of such an operation, too. We
> could of course introduce "--ref-actoin=print-head", but that would
> become even less ergonomic.
>
> Replace "--ref-action=print" with a new "--dry-run" toggle. This new
> toggle works with both "--ref-action={head,branches}" and is way more
> discoverable.
>
> Add a test to verify that both "--ref-action=" values behave as
> expected.

This "--dry-run" mode still creates necessary new objects, right?

Describing this "--dry-run" as not updating any refs is a very good
thing, which is what the documentation update says, but at the same
time, we should clearly promise that the necessary new objects are
still created, so should the user then choose to update refs to
point at the reported objects, it will not result in a repository
corruption.

Other than that, looking good.

