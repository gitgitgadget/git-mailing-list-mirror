Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F22D4803
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945440; cv=none; b=pKtqzEtb7qJ4SWtRVFsXNLGDWijPspLBKwTSsw/+oK2T6qNgjgynG/v1f8a1mcmZ1DYtV6aTukTUTL2NF6og7TTFCFNB2jj9Sm7P9FJUV0O76MVJDOd7k51XQzSQmO4eQMKWYMXmgky1QXszTZnKKGxk77jYbTtvN9+k8gggE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945440; c=relaxed/simple;
	bh=AlhVxc+CFYcExq5SU7XPZRGmlYYpWaibeoVawXlTlZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FAetXnG4vI3S87OoO6F2dlHyV3D7r445aPN4MvNkGRfMW4qbcAetx1IW8zS6xqMI+Y5dNtw3mAfl2FhkJCtS1nhF1xo/JzPlVPE9kDbc6mstrrczSxnGkxaub519kJiJeerZbXUbQTHFlDL3dO9r2tCyii2XcR/L8+X6F5bTtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g8e5Cahm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bb9Fr6Xf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g8e5Cahm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bb9Fr6Xf"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 784461400095;
	Mon, 11 Aug 2025 16:50:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 11 Aug 2025 16:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754945437; x=1755031837; bh=aRCU7GG5Rw
	WqvqlYhBD918dsqE8eIZqz6Fzp0pA7PUY=; b=g8e5CahmYFHxQzEBrISK4EcEms
	ZjIZMinHpQ14SI8TubQfaYBqB9EhKud9GQE1KbUzSwUNg1Y494VF1UIC+SWHebwM
	W69RQ/5rbIaF3pGM4l4RKhp9iLy9zwQmI9sIp10unhc20LP5aFSa5muJhYO8FFf2
	Hd//n/sKzA18RA9u/pY8w8o+Bw9e9PjWNoZOEJzN5qBubqrHjCkn/x6hvZnW2nro
	16nTkkXkfokFHv+NcMpMLXsqk89Q7XXlxj+CmIOw27zxE8pYkBaSoJUy8tPWubva
	Xc6htIklYQILp9l86ns9Q73v7UoeAuQC23Uox8S1y+BN5BZIKL4Lq/FTtSFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754945437; x=1755031837; bh=aRCU7GG5RwWqvqlYhBD918dsqE8eIZqz6Fz
	p0pA7PUY=; b=Bb9Fr6Xf/ywY0DZ+h7iz8hUXR5TKSncJRLL2yGPnSEUx/h6TOlL
	dE+kz9Tqd5QsYkByVUl2E2o33m6+2cUcqdXHd+oWMPWD28r6msK/yAUlcneHMb+j
	J2OCx8/gEKXGHvhjLZaK8qNVKPUhhzEHzKkpkgswvd0Qb219hLhBv5HhaZ/aAiUI
	JeUHSlywUosecjTMpAbsie9KKdMoZkp36V21Y/VjIMIyQ+lRvWvpf/5VOogshzM2
	W1jK3rfLY00pugg7BKXB/xvnAnwuUEM/iY/Km/HeHtTmku5BSukAPTmn04VhBdCb
	5SYCe/dyduNCVGur3wairSPsjdcD53MFZfQ==
X-ME-Sender: <xms:nVeaaNfbEYkcAWKdeM7-EPnJmFAt1ZauEih_s1f1QzNH-xNbZ56SkQ>
    <xme:nVeaaIKC3hedCL4Q9jp0SVc8ga4g0oaPX5c-mPOop21CRfov-aj-LyS5Cj9_Mayvj
    P2uMLyZmXF7ZVh-vA>
X-ME-Received: <xmr:nVeaaCJ7v5MtQtPDOU1hNUeAVCI5vQGiOg3lw3k3FftIjKyPpKpaLoPkewpbAf6dwgEZ1h4L_Mhmynp4flVFw5P7rxsRpNodS8jBAfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:nVeaaPWHvhjrs6RHm2Vs34_kRBC0XZHwTEgj8xR7tZ-ffCZtoGzUwQ>
    <xmx:nVeaaDn_2WMadoefxmQ95sK9Ee-QhBEbWMlMy3YAun4UfGY-ipqTQA>
    <xmx:nVeaaNkxbphKGujTB89w3gizNufzE32EILbKLhncRry8pNV_hEhCBQ>
    <xmx:nVeaaLYPdDxdmUJv4LMpflXGV0b1tX-G26b2mP-Kp1PYG5HboDMYCg>
    <xmx:nVeaaBui-RBJ9KeDQthDfKQfLIz6r1ddYvADZSdG3KUsfqKotgu9NVzp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 16:50:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5 1/5] doc: git-rebase: start with an example
In-Reply-To: <c2f2e05078f3be604495b53f295e9a8a75f223a7.1754943127.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 11 Aug 2025 20:12:03
	+0000")
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<c2f2e05078f3be604495b53f295e9a8a75f223a7.1754943127.git.gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 13:50:35 -0700
Message-ID: <xmqqpld11t2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - Start with an example that mirrors the example in the `git-merge` man
>   page, to make it easier for folks to understand the difference between
>   a rebase and a merge.
> - Mention that rebase can combine or reorder commits

The new comment added by this second point looks somewhat out of
place.  With this patch as-is, the text talks only about the best
case of the basic usage, tell the reader to go elsewhere if they are
not interested in learning the basic usage, and then switches back
to the basic usage topic and talks about conflict resolution.

It may be easier to read if you covered the fact that there are two
major use cases upfront, perhaps like:

    DESCRIPTION
    -----------
    Transplant a series of commits onto a different starting point.
    You can also use `git rebase` to reorder or combine commits: see
    INTERACTIVE MODE below for how to do that.

    For example, imagine ...

