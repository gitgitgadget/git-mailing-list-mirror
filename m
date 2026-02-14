Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB970298CC4
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083387; cv=none; b=k+GosT8MjDdU+5knmrHMgIM9FC04VMe3IjDVdxS868eS0pPNnzmTjyPsEnAPXQqfN2fKk80lsev8MeSUEoypIcxVbeCFclVcik566zoIzgjedboyG4MhwgvxCI3TJmRn5ZGTX0PxGho/ut1hsQ9pYPAC8+E5K9RVu8KYK31G0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083387; c=relaxed/simple;
	bh=4CoFboyRf2uvtejBQb1j3RcM+AKADN3c2karFjbFyMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pSY8zx10Pgif+lo25kPljgoqUQbFwC1OohOj+J5JFpvxE8G5tIxtWppvDrxvb0YgYhuiin6ZgdfShlc17HEjEJHK7PxuI/mCxgJt1PKxcRoJMWC73KdWJcCb50RBN8y4fli74aY0doYVafe9iL0ExN0KMbzl0Nb5xxt9szBgrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e15tIkYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDBKDM6r; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e15tIkYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDBKDM6r"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECAA97A02F8;
	Sat, 14 Feb 2026 10:36:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 14 Feb 2026 10:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771083384; x=1771169784; bh=4CoFboyRf2
	uvtejBQb1j3RcM+AKADN3c2karFjbFyMk=; b=e15tIkYQ1Ioy5mU8m+vX8Ursat
	vREz1L7bxfw5aoc8FZ3yuJUvLWbNDtZqMOs+d9CAreI5o6HKg5x/QHYIHA5IY41S
	FvgIPE3gYqIKOnRBOcpI2SsxCJZAKiwK6/sgUgZzeAcy3pzpeA3un9Mr1Qwwb+Lc
	VPogtdGeAMBa6ZcmtKPsE2HhwDLMsNi/2Ut21mnXiNwo920T3azZ/Hqh8jFdXPZJ
	GqzDrcLQ5FHNgFiOMo5Ec8xaGznMN32JgPSqva335ThRkCuGPll5ypkLKoAs5l+h
	29pRchJCW+SAMeJBZYZUeo1OWbg4/1eTvYv8KF6CJt6e829obVz27cNVbAgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771083384; x=1771169784; bh=4CoFboyRf2uvtejBQb1j3RcM+AKADN3c2ka
	rFjbFyMk=; b=IDBKDM6rgvRKc8H9PjoIwbhPg4xmOwUK28LhnlRRfmdGLu7qqui
	M4kwXyLj2XnYIzOccuDUY6tTFtySrWCBqcwApSbRatmUAdtQfh5XAYt4PwBir5gO
	thvFl30w/Cp6j93D52f+eR1y+ttbceLGiTgc6VaRkQp1EWT8PDoqoIghB0U3msUR
	Twii8qRj2eI9ZPTHLwUv5zjzm3CLcGinamyUBJ2I+CyAKxDPhYWOaHYkkGdHMHRP
	Bb+j93I8etIsAw+g1jyefYz4EQPUxE4T+tEUQylcHw5UEgkDlOle3XRqhIkg9aK3
	lNqvRfDVR2iUWh/errQbOdAVABKioAOQEng==
X-ME-Sender: <xms:eJaQab-PYmiz1zkK5P6Yj8qciUxMSri71okd2TPjzOv1rk2a4D-rEA>
    <xme:eJaQaeuOX4i37_2ApEgfxjP8HCloeXt-xeYfaxFMYSrGpJ2cgfMWYeqWI117QHZby
    w1OhJhtStN-0qhRBWMtcU26_0V9m7Zdo-Kbdxki11Cx47aZ1W2o>
X-ME-Received: <xmr:eJaQaeAJpeM80D0bng4Watv7rlZX8U5OL12LyOV_7ij5SZVI-Xgkk93_JI1EdJvkpyg4s1hXSTWVtp6hzWOtfuV9RpE3WN84nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:eJaQaWWCxGcRuAGtv4I0KS1n0hMXEQ4OMUWGTSeGwqwe-x0uVff5vQ>
    <xmx:eJaQacB4LzT-ROhjGPSa8OvyMZaiVcrfgPD4guUh55FIUV63qDuoEw>
    <xmx:eJaQaZ83Sf6qlys2ESgnwRF7Zu67K4FR___FD9VUua4ebKG3X2h6uQ>
    <xmx:eJaQaTGcpL1duZFtd78XZztF4pXZFQa5lbPCTPjEgF9bloeBfW3XWQ>
    <xmx:eJaQab-tQ6mNJzk9m7om_xgVrr8Fqi69YaqbCp1v3_-IKw5IsBW6Rq5h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 10:36:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] CodingGuidelines: document NEEDSWORK comments
In-Reply-To: <aZBMQGQPiE3cJBUq@ugly.lan> (Oswald Buddenhagen's message of
	"Sat, 14 Feb 2026 11:19:44 +0100")
References: <xmqqms1ft7il.fsf@gitster.g> <xmqqldgxmzbj.fsf@gitster.g>
	<aZBMQGQPiE3cJBUq@ugly.lan>
Date: Sat, 14 Feb 2026 07:36:23 -0800
Message-ID: <xmqqms1bgww8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Thu, Feb 12, 2026 at 01:22:56PM -0800, Junio C Hamano wrote:
>>+ - A label "NEEDSWORK:" followed by description of the things to be
>>
> by [a] description

Thanks.
