Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7822DF8F
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154985; cv=none; b=rYA5XBX6uc8a5CiwkKQv0gWHOEts30F+ITq35QirbH2XVzn525re8BfEk9mQcIJcc0g5PNpFLWjX6QxMM7c3+U9bApQupo4z22ddstSjsFofeG9CbOzPZ86PltP6oQ0OXg3t60SRffBCrP5MUwv2B2JfgN9CUyIirDMIPfffY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154985; c=relaxed/simple;
	bh=/7KHjflKSejLr+YH4A69MDXQaRvIIQAOU/AOFtx7xp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTjaALih+gFOzUVpIksoJA5dANOOmkLN8seGQOVmOMysobV7xYhltWHpRKFnIKpEIGNBMTb/Rwr36MgHb2UfW9KZjwREYbFdlft9V31KxW17bFVN+HALdZYXoU0287P5/zUFjATAwh+cULd8vK3jZiTZ0jUxFwKua87y1u+qJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nt41i6M6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUgBoa0n; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nt41i6M6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUgBoa0n"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C103F2540224;
	Tue,  8 Apr 2025 19:29:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 08 Apr 2025 19:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744154980; x=1744241380; bh=blM2rvqH7B
	cJuzbcIzEeo98ep07CswlQBnsnPzqYOcc=; b=Nt41i6M6S9vU0hnbJtlS4lnSLa
	Azmby9AL1SNdjT7MKa18Ap9tp1GMDSkqg488tfTg8nQVjO6f5h4WWUadonDQBe8D
	uHBnqipUal5klF05qofz4dC58YCNWTHf/IS9AdvJ74p/6l9JGEF2zD8nuyhjAxQV
	NqVC6ACmgMCtS95six9Yiu0itRzjONYkQF26r7Hj/7aKyb2watlh6ohmyqL2+wyG
	ExVeV2ZGq87pPygQoMVnxcEcyUT7ea9Scj9OeQZnJPX/VT6dKZ0vDXN1m6xCqtHZ
	GiqQZwPP9FiAU2M/xrHvrmO4OLjzTTTzE7OB6SUtN4zncFzKNcLItJR+7kXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744154980; x=1744241380; bh=blM2rvqH7BcJuzbcIzEeo98ep07CswlQBns
	nPzqYOcc=; b=gUgBoa0n26w3aXVl+nWHyP8CSMGhVfs0xTOa73ywPna1F9cNUvv
	UV8St+L04C7iUuEqtronY8u9EsMg58iQS881U313pc4ueocRZWH+jeyOT2CLp9Tt
	X+9aZsFChZoKt6MN51boGMQwqJ4st5YOJlbDbIL6x1bm/Qukx+uMnRZ14aJ5LNBl
	sIE8QR8EFY1Z6Xxc2eqAAm4S0bl+TRJbJ6NpTucvmMehaW0en65jCy/SUndhgcoy
	c0Daoh8sk/V8BqVL9Y0dvW9NNiiB6IvBw86Xl3hSt5P/maKPrnM2BdeZJf9W7jqW
	rc39ehVqCr0Ud3aqC8lSMzCahIZDpiHpi6g==
X-ME-Sender: <xms:ZLH1Z9uQz-Fco5O8YLQCLgQvVpp7NHy_pZ2q9oheuOae1enAKv4iXw>
    <xme:ZLH1Z2eLX12nHTdl3Ba-eXTPVM4a2cKqlIDNq1JatD61WOLAevygSpReo9_xaV0Q0
    1UWFdF5IPyUmQNidQ>
X-ME-Received: <xmr:ZLH1Zww9QWWv8ItTRu0EtenxqEZJGAJm2KboEemLwksxcAT59HpdONpTBnXIeq2ALd-9hCmGY3cJdy6G-ktdlzsCvcbRfCIsOozX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepteevjeekvedvvdduhedtgfeiteffueel
    ffdthefffeeuffekgfevfeeifedvgedunecuffhomhgrihhnpehrvghprhhoughutggvrd
    hpshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:ZLH1Z0Myk60prfW27W74GImc6bXVh0NNBAHAK9h4LMHxrlKmOkksCA>
    <xmx:ZLH1Z99c3NJ2Jhrymm-wjEIyhHIX0pp61HwDYu5A779pimUn2utKBA>
    <xmx:ZLH1Z0WBvkOw2fD5hN6Eb3nOxMIdfQiSlTAuac2Jw1kCdXKDLslgUA>
    <xmx:ZLH1Z-eZenQwhC6oeS0lb8q3qqScwCtYNS7Y97faT8c6g03TgOEojg>
    <xmx:ZLH1Z986Kd3P41OE8Rd_s7L6ZvsU4Aioyx8nuKJj4Q6bibDOEd6hfikF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 19:29:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] Split up "object-file.c"
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
	(Patrick Steinhardt's message of "Tue, 08 Apr 2025 12:24:08 +0200")
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
Date: Tue, 08 Apr 2025 16:29:38 -0700
Message-ID: <xmqqsemiteot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
> with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
> branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
> into it.

As 9442b1c919a is not public, this description lacks a way to verify
the result I attempted to reproduce.  ps/object-wo-the-repository I
have ends with 7d70b29c (hash: stop depending on `the_repository` in
`null_oid()`, 2025-03-10) and it hasn't moved for a while, so
hopefully we are in agreement ;-)

There were a few unpleasant interactions with other topics in
flight; please check the conflict resolution I made.

Will queue.
