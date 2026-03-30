Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A33E51C0
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911593; cv=none; b=qId01axhvVkfaEkfb9wQJTIfbw5EilnGhaeg6A5IiX9r6deOMHFL1gsuhGfyU9cTtU1w3qFMXRtdOm4h1QYL6kq88Xq/g5fEx3GuiOYfRdR5ZwLHtVuKhcFqzCSQCDY6ykFd3diFNmO4JH+u+ikQtByKrTgf5larjfXfrweZLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911593; c=relaxed/simple;
	bh=SMKIsctKpgmoIyI2luLdiozxC8rFChcm/b7dbB7N5w0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YB0+TJwxmE+jinF2ROKqJR3v4e8KEXHW8bLgeCWhlA2CGUXwlH8LbVTMhAfpTKV2U6aRb6STVS2LiJQFJNvKCkbEq8SK7YdkzJfpyMQE2Vgv49TikyDj3lYXkLvdvQ7Ml3+Hps8DdQlMeqS4p7QEQQt+QO+x6FEv28h8otKm6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XcqypmT8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n794k/dH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XcqypmT8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n794k/dH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D0203EC027B;
	Mon, 30 Mar 2026 18:59:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 18:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774911590; x=1774997990; bh=nnw4Tgw8Ii
	2WYy6Y0C6wXVJYhq7hH9BGp8/M9G0o8Y0=; b=XcqypmT8XKTbm4QXQeGCIHlR0W
	6gHFaaTlVpm4YwltzsASCQqK7cjZSulhqRbpZjfbrUKi6Q4n6eaoAxzRnB8XufiE
	kNsP/QQtUhuD6XNFWuHd8Zj8jCZX3vaSTNXfPbJPCU7TM6R+iZE9RaDI0/BaoOpn
	i05svXpAKqgWgvB6jeHKCW1nEl1IIH+BqmFIbEITLPYZvrAy2bXhBeOhUpTuXMpU
	5cHBexG0e1TDY84nhfAEJJ5rlx6SMkVd7yzWGsyIt47P5wf7LqourCCy8b2vIgbG
	KBpgd3pGmI+WUb/rFmLLptSdY12h2wItLaPQQROpxnBNnhfqMdNCfwALX5jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774911590; x=1774997990; bh=nnw4Tgw8Ii2WYy6Y0C6wXVJYhq7hH9BGp8/
	M9G0o8Y0=; b=n794k/dHmxFq/QWHIj0jqzZUg79C1umFeINgMiXQXZ60YzHdPyP
	B8yX7B3XQlt35PqHeIe7ZrxyM3DHHpZq7surSldB7CbFvsrqSR42tcisMkPxeO81
	aV191NNMWLMoXc4mHepSQtzHmKqL/Ib9tO1/CArhmdj7pevZMqG/Zz4NN9rbMrly
	DMd2eCEGAoeubF8FhnRyYbpXLSke800SJa1kt0tmqO3Qar7q1YA2Xd8NMrFucM4K
	s8mdD/gaI9K5vFpwVOHeC/W2JaD1F5slwL4lwRdsI5Hjix6J92pd1XiFdf17EX46
	Vu6I+hUHSS2JtilQCWTq3b+NQuWm67Hrjnw==
X-ME-Sender: <xms:ZgDLacNbU-EM3OH4RcwPqgaNQducrZ0W6GEp4xkl6dHybMvlg7XuYQ>
    <xme:ZgDLaVgkZ7nvFFxPT-X_GacHYmLE8Ph2sofb5WT5fdDQXuaRfDuoZXr7hUtTXOMp_
    0IcWy0xLcRsRPmEP6sw_Ju0wlswfc8pe2fX3lxBot2dn9R87IIApZA>
X-ME-Received: <xmr:ZgDLaW5ez_OHl4_YrMK4WeBbkRs8EtyviLhX3JbBdbaxgKBvd61_JSauY1_lQOdd-Pdj6rEPiD4HilqGa-vROrWj0QITUwZGkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:ZgDLaU2-Fp1hNDrclsIYxYyUi3OY0Z6m1R9ajbKcdW6-G7beDpJQiw>
    <xmx:ZgDLaZtkJAhWe0xYBBycndUd5XUGF0tl4AhA8RcgmIDNbXaFm341jw>
    <xmx:ZgDLaS7OZ2RjRHzbVsq19LBYEg6vLMrR4sQ3lbmC5bAw4JEk1KU5Sg>
    <xmx:ZgDLadcZ38JRvSh5CW0X-5eeji45GzBXxfX6Mreng0AB32HnMEmDNQ>
    <xmx:ZgDLaY1_hYoC9nzTg3LoF4GCj9J95_rz23V88trBS8k3TWe2a8xcCazC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 18:59:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 2/6] xdiff: use unambiguous types in xdl_bogo_sqrt()
In-Reply-To: <86b0ad100ccbcd1812b24eabd0abe1987592daa0.1774890003.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Mon, 30 Mar 2026
	16:59:59 +0000")
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<86b0ad100ccbcd1812b24eabd0abe1987592daa0.1774890003.git.gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 15:59:49 -0700
Message-ID: <xmqq341g7wka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	xenv.mxcost = xdl_bogosqrt(ndiags);
> +	xenv.mxcost = (long)xdl_bogosqrt((uint64_t)ndiags);

There is nothing actionable, but this makes me wonder if we want to
update the type of .mxcost member (which seems to never go negative)
somehow.  I also wonder if uint32_t should be sufficiently wide for
xdl_bogosqrt() that takes uint64_t.

