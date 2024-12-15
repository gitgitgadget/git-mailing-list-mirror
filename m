Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E01922FB
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734284609; cv=none; b=W0uaLHUIK8yDHSRCmopeiBXM539e/tFba3/9oFWh/QOUxhkUL4f0yEbOwGPoZqliAgAqSO8vUZh6lJGDrC2mfBMrHHiWjlTZ1Vo6WvYyWl2VzLSVB36nWcGVlCxT9Y7J+3i5FMTVY5TQV8/viWLRMZQVCBYO2seEqCIwRAhj+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734284609; c=relaxed/simple;
	bh=512NdAgvTmMDEqHSwZKJ7hYxA1B5ojXYLMtUhNAcBzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JpGLig8e2AQdme7KmqQ5RURGEv9RDMhl7El+WiX/qzLilWhPfPrjNAPDMiPpbUW8n/HSerwZ67Zpa2hZmSBjz+PpsvVsWLdgNCft+6UTlW+4V7zAgkE1yGj8mSsiCsKaIahpa1KJoIFMnfrD/Rz5jgIRGPSgaGxPumCiZaIiZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X97DMCAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MGHHfsXU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X97DMCAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MGHHfsXU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC15511400D0;
	Sun, 15 Dec 2024 12:43:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 15 Dec 2024 12:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734284605; x=1734371005; bh=GrJ+8IKGJx
	nJy2Mc/bhQ1NAvcFxC4gMYBsuMiuJb/y8=; b=X97DMCANkyb50+9nmhQ4ci0R3f
	cCY95FwIMzTcjDXco6/VYozVAyEE2aBCRvLsepbqMyoacYOULK5ATnupxZk3Cjq7
	z7LYkQGtZDBBPUtY+Aqu6MURJA9WZxe4y4Ms5KEaRQIzInQ/zxaoh8YK/X5zVphX
	ysq2nXzBGijJEzFXluIqWz922MdyCtlBQaAeZszjawHo0OIYvXUbp+HsGomLJmZh
	A9tk4wdDvHOmJVRGsmPblgknezFanVj0L+AgeeuQ7bw82gCa7+EsRST0ZRGRUffI
	BZ4PyWEVzQpim0NO3Ru0+mEwF+OZ/PKHttdn5JtVOXl1CXqRLoUvSFI/NTOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734284605; x=1734371005; bh=GrJ+8IKGJxnJy2Mc/bhQ1NAvcFxC4gMYBsu
	MiuJb/y8=; b=MGHHfsXUS9RLmguuXeRW88M/gpkTSCfQIYUVuSA2Jj9W/T+94ST
	PigAtZeoul81Nw/s6ZZ4CgrApz5sPO4i5rZ4AvWPt1dCGnwqAP4YUFK+eZpLElUk
	MNkMCPUvPGFoKxpTjXNvUH9wVq777ZXlJ0OAB+wlqwtkwIjfV9cQjJbUsbrzX7So
	fcxSY3udESDi78ku3NWSTjDAOK7eICtJAlyMGM0fy3crCD6PXDWPe3xhiLQmQVLL
	e9gy4bcJN0NqyrxZ0o7SZIznqoeygPYWzc2xVewZ1q4gH34sn9xl01ACvaaZz59p
	x/eDkUQyI5ivHi8d4JJlDESPg1nRahj0QBw==
X-ME-Sender: <xms:PRVfZ8tvu3Dqrzr6U4lCnpkVfL61yhesHq2yoxTgmBXdE8wFRXDNaA>
    <xme:PRVfZ5cXWceP_XByh-KwgQJ5Z8MP3WGbLVHAS038dsWQnut3NGXVxPh0NGr8fJfFo
    LBYsjCKP53-i2m-oQ>
X-ME-Received: <xmr:PRVfZ3wNtZSKqrq2-TcxH1Dm6g5YuzRGUhz5FNJyDTXOnF4v8IjfPpXve_VSn_ympdYjDigv0OWX-HSpdAqOl6nR1rcUAjYK3ASZ6_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehfrhgvvgguohhmgegtohifshesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PRVfZ_ORZzZmv-kQZcuHGj6TxNdsnHECAoWBqhQoVKinat5CiZTu9Q>
    <xmx:PRVfZ886gblH5temYZpWqWeJVXVgeEHVAS-bcLQ-_Ez1RJSBGkn5tg>
    <xmx:PRVfZ3WgllDHQavYUefA4zKIpE9E0ORvN5t7l27dWSSE70MgdKURSw>
    <xmx:PRVfZ1cBxXikxp_paaixMbWT_vTQnXAxvYRB0GTwnTGKOC9ieBOHQg>
    <xmx:PRVfZwbEvnwgVsMSrFWWmvzknSW05mlmCB0epChIF8xmBR-M0I6fAwOF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 12:43:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Oliver Blanthorn <freedom4cows@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: Bug report: ":/[text]" revision reference no longer returns
 youngest commit
In-Reply-To: <CADFnu5sMEvGyGy7xH1r0NGBUZJBznCi0waJ_bJ3tSHQ5Y2yX1Q@mail.gmail.com>
	(Oliver Blanthorn's message of "Sun, 15 Dec 2024 12:51:40 +0100")
References: <CADFnu5sMEvGyGy7xH1r0NGBUZJBznCi0waJ_bJ3tSHQ5Y2yX1Q@mail.gmail.com>
Date: Sun, 15 Dec 2024 09:43:23 -0800
Message-ID: <xmqqzfkw970k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oliver Blanthorn <freedom4cows@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> `git show :/Merge` in git's git repo
>
>
>
> What did you expect to happen? (Expected behavior)
>
> The most recent commit matching the text "Merge" should have appeared
>
>
>
> What happened instead? (Actual behavior)
>
> A commit from 19 years ago appeared

Thanks for a well written report.  I think this is the same breakage
reported in *1*, which was fixed with *2*.  Hopefully the fix will
be part of the upcoming Git 2.48, scheduled soon after the new year.


[References]

 *1* https://lore.kernel.org/git/CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com/

 *2* https://lore.kernel.org/git/20241206-pks-rev-parse-fix-reversed-list-v3-1-d934c17db168@pks.im

