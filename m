Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC428980A
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812409; cv=none; b=EDSthGu7VYIM8Fy4S/J7UTU7rEHGDCHPy6OL55EZ9Lczwru4kGcIqf2s4Je6oWuO3OaWccieDEhRb7PhTkrWI4rl1qcZTkOv8UJkhP55vBqWgQxl58XBEINzs4uYqP+4gAA11ENws0UhujzV1QXkhsQQddeIq4kVJATzS3gLcqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812409; c=relaxed/simple;
	bh=ybeFrEaGf5aYjCzc+xnhz8rQuYk0Ek00jXhjaFPVaoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dd85A8W7int24tJQExd2aUxeGSKwEur1v2zJnKuaS2LDEOxr//1IBFd5nhucu7ichUSUnDMspWXEdY/deA6Y8YqSa/os7L15unIaTrDnPi3yKSSznbuFUSntmuhmd4xuuv+NvLBcqgHozHBgaIdZVto5RF5ylZsXf7Hd94PIEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NW0i/cSE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hf4Nq7/S; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NW0i/cSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hf4Nq7/S"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6C1D14000BE;
	Mon, 10 Nov 2025 17:06:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 10 Nov 2025 17:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762812405; x=1762898805; bh=HN9vP1rac2
	sZc/kX1vB5VL4jnMkhcolyXkeQfmADLmY=; b=NW0i/cSE+rJmSeDyHFDU9nl2b8
	4G//jEJqS/zee+BFMB03Q5ilOXw5uuok54FTrmDRX/BNLjt+Oko1HYCAZfjuhPA+
	FcvJTC1AkZUjkiCuGarPdvN+OpC5FoUu5F8RZRqE4gQX1aRYMvyiVIxV1l+L49CJ
	YBiNMqEvAD+V37QjzIbSka8oVw5krZeD9vA43X1bNNVObmHWtseKxDhEgfWRzR7Y
	WBZsHSAsyDFMReKOfzbVMmKu4W/QT3sWB1Op2pPa1Nw4ZhywfXX+3/fSKASG3SXS
	Mv29FM7fAp13QD2cFuAkyrOihfm6qApJL0m+L/8hFMU50vFLDBZFSPwwGlLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762812405; x=1762898805; bh=HN9vP1rac2sZc/kX1vB5VL4jnMkhcolyXke
	QfmADLmY=; b=hf4Nq7/SXEdfQR/b/HtjzdPRh7awLIWYZHgb2CIBtt0k3/xkAfx
	1lm1s3OZHLUq4wIH1/ait/wyzUA4rCNhiqMCL5psTV4Nt//KCApn/yVorh0ISD1z
	TAUICVfIjdBieh8LCMzQhBwCt+2xujh75JHWdtZlPmDZKMVz8XyagD49X8nyXpdt
	x3RzS5FELD9nf6FXhEciYS+yVMLI/UjlN8CRYjnr1LpeBfv3pDlrU5qIP15dUftC
	OrmDDQIkixKu4D726O9nKakinsh8RZdcUa4Aj6UpySJSIGPfNQAW7ZFHljtK0q6k
	/ko2ltYjtzqiA7L5WFpFxU9i+/ck6CH+dMA==
X-ME-Sender: <xms:9GESaV_oL6CBIxCSopAqakM_ohlsPn8AyBZQ_mUhzw5ZQ3VxVyO39g>
    <xme:9GESaaa4bmexeczcEYPlbHnFKQbtbAdlpzy3ErC1M5anOa-4a8RA3NE3CRAPFcc9Q
    Pv_pj4axXrKsYVTWmCMfx6j88oVg1s1xGkcBOfY72XrNX4rPPdKltI>
X-ME-Received: <xmr:9GESaROXxvgJ4EBRTFtuCWom9bfoQnKMGKIhN_OAu69dtyBRzwJi1ld_5a_VCuMB_4Ey4h9ZjR3NEuRcXkdA1X-WXwqPIRjP8w1K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggulhhtvghrnhgrthhivhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9GESaeDEGmpp0Umpytp_b-Qyhyt4UGnZmA0ygTuiC6fFpUgcrrc3eg>
    <xmx:9GESaQJvoWzMBOVKdKM_rAsndQTy0s4-1Oykh7aaQFiGVG7HY2APBg>
    <xmx:9GESafMKueoGfFSsiZQpZw1DXlF7KSs0O8ZXqCTEuz0aYnx75pps5A>
    <xmx:9GESaW65MJZuOiLE-4HnBflCGL6wPFpDpsUXLDwpLqIBBkSWdj7JYA>
    <xmx:9WESaam50J2hkOsjF3LYUcOj5a-3MDRQJ-sDRbAMgaRrlyxk1nh1VexF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 17:06:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
  phillip.wood@dunelm.org.uk,  ZheNing Hu via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH] commit: add --committer option
In-Reply-To: <20251110201136.GB127132@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 10 Nov 2025 15:11:36 -0500")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
	<aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
	<20251110201136.GB127132@coredump.intra.peff.net>
Date: Mon, 10 Nov 2025 14:06:43 -0800
Message-ID: <xmqq8qgdzgng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Is a "--committer" option the best solution there, though? I'd think
> you'd want to set user.* in the repo-level .git/config (or using a
> dir-specific include) would be less error-prone.
>
> That doesn't help for using two identities for the same repo, but in my
> experience it is easier to use two separate repositories for that to
> match the organization of the work (even if you may sometimes fetch
> between them).

This happens to match my experience, but my use case may be rather
skewed.  The two sets of contents managed by my two clones that push
into the same repository (of course to two different branches) are
rather disjoint and they never merge into each other (in fact they
do not even share the root commit).

If you are working under two identities on the same codebase, I
would imagine that two repo arrangement may be more cumbersome than
working in a single repository and switching between the identities,
and may be preferrable as long as you are confident that you won't
commit a change under the "other" (wrong) identity.  Of course, your
reflogs and notes would also follow the "then-current" committer
identity, so if I were to flip between two identities while working
on the same codebase in a single repository, I am very likely to
export GIT_{AUTHOR,COMMITTER}_* environment variables, dedicate that
shell/window to the work done under that identity, and switch the
environment variables if/when I want to switch (or have another
shell/window with the other identities exported---perhaps I'd do
that in a secondary worktree).  I cannot imagine myself keep giving
--author and --committer between my two identities without mistakes.

> I'm not totally opposed to the new flag, and in general I'd defer to
> people who say they find a new feature useful. I'm just having a hard
> time imagining a scenario where it's the best option.

Same here.  The "give them long enough rope" principle tells me that
this may be worth having if even only to have symmetry with existing
"--author" option, but these two are not inherently symmetric to
begin with, and I am not sure if there is a scenario in which this
new option is the best thing to use.
