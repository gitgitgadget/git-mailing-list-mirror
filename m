Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB02B652
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389468; cv=none; b=LJfumz0knBCnI/2TeHZUrqMUPuZbqrxgMQIdX/5o789jpjK+bSMo41g4ZcdeNm44nrC8Vv+oCmuGTlc95mLw1nIF7aOH3f2ZP4eARYHO5dmFwxZ7XwoHv6aeluIK9Vi0HO/QxpjcxzQhhH3SJeYRcBq44HVJzN48f4Iiw8R+u7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389468; c=relaxed/simple;
	bh=1dLvRU3Z2F2h0wIPOtIDOY4S8XLM7q+xgATg9WY+6e0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fZy40ScblyUvLW9OgI4kNQdMeYu8uRKxAZutZpJu58OOE3h+PwO0Fv6c7KX+MR926fn4qaRq/3i8vUuHivUu/q24v39gC4uhpidYZuO3hOzGRTRXLDxxf5LgHB4jLCG1fVKqWFCWLtLQrmJ3L1kit2xYezojHLKwFCPiQgjeUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GGKp2N8O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9Oh/9gu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGKp2N8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9Oh/9gu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 65395EC0247;
	Tue,  5 Aug 2025 06:24:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 05 Aug 2025 06:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754389464; x=1754475864; bh=QUIlE516PZ
	TUo7DG0ch3mHV4FsPjYJ1dbywHNwSDDOw=; b=GGKp2N8OtWYeP5zrSClmaACxzf
	989I8n2r3RWj6evNcsnifmXrlJX2qVB/zTh9ixmPyComvEt6q/OuwWrd9QHOI4Uo
	bzHTcHTpMUrN4s3PwCOhO5yoSCs+nLqelpWol0Uoty1Uqguf3ZtYrdbz2WbCzzFR
	KVVzwTjEGSgVvG7gZnxC9+ttUedZiya6z3fQH7u4yVvfT7RQon+OR/UOOWbHqhsa
	BIo8i8NgQY/MDLRE/DOdW98pirFSPDfVHZNFKzeBewjzxqApfGPqPirClh/feNZX
	SSqjrBvI5VZrQP2lnhhaBIeGS1RSNyHBxigQQ4K8HGEoeukJKTU6F8iHtjMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754389464; x=1754475864; bh=QUIlE516PZTUo7DG0ch3mHV4FsPjYJ1dbyw
	HNwSDDOw=; b=S9Oh/9gubbymbSYQAZ6j+pxBQAHjTZBpMaP1ztHi46m9up2sY0o
	hkOH0cNLVCxZ/BZwQ10g3wLg0ApLVk8KPq/usGfwhNSRVuvO28Vt9dcEwrhQFEA4
	MDIJccRha9Yw2mt06ZiZxi0nyWXOdqPr4TQe7Cc2md4BPAtAW7evBEPnwoUYZ2Hw
	q78xezhmpp+ZJwD1XhDnjEj5DkE85GoS1LhDIj7yMJcYqMvb5WzpIuZl725sJYHd
	UA011+KSm6K1UQocE4tOObjprSKdUWndh0FVXFb3fIiG6GEl3duVPgpA8wzNZEVa
	t1r9CSkaJUyAt19Nv4dWIqvfusrfnKAlz4w==
X-ME-Sender: <xms:2NuRaC5KkcesvdDzfysqp1fmnnxDy7rL3ewJBe1JyxogXDSZzqprGg>
    <xme:2NuRaPLxZ_w6Bl8IcF6cYw9ROZHzS3Av1TIDH2HJo1cmc6w_xT0YXicNIdhgXkmid
    RXCQVBj2DZb3WXqZA>
X-ME-Received: <xmr:2NuRaK7zg6sGDSZJNbCLtf0HwfH_m8FKUH6Xe7NLmIC08d4vH0pZgi19tIQLXPTJA4W6qxO06sYOvfvWD70hDK-z2EjW9NWq3xF-9sM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2NuRaKyQ5oaHDC6MWWhHuFcKOac0BvsHkpvIaZ8ydWusWaVCnhXMnQ>
    <xmx:2NuRaGaiRycg0QDXDuFxFYIKfWN6FHhbsWJ6UI8rAU1wAatR85YS_A>
    <xmx:2NuRaETTQq0_YlKerv2FHzL8hDWd8WhZ1xptmxsfG9LKwElMKsGccQ>
    <xmx:2NuRaIzMIe0stw0j6F2l6dlwMJbPSUQpzokIDH0ZTp_ZLKECWjMGHA>
    <xmx:2NuRaPyIkdaY8RqAJJ8n_7VJenx0s8b3E5RGyfclcQ6aAdQR49YjRoRW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 06:24:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 4 Aug 2025 21:22:07 -0400")
References: <xmqqms8fbilv.fsf@gitster.g>
	<CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
Date: Tue, 05 Aug 2025 03:24:22 -0700
Message-ID: <xmqq4ium3w2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> .... This is true whether I use
> my copy of the topic or the one you publish (4c8db1e55c (builtin: also
> setup gently for --help-all, 2025-08-03)).

I think the breakage I saw was while testing the 'seen' branch as a
whole, so there may be some interactions with other topics.  IIRC,
it was running "git repo --help-all" when I saw the complaints.
