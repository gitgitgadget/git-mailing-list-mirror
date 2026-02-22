Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68C352F87
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771799857; cv=none; b=q0S5GbooTVQCrothoKGumkcSdQk7XNhXKx0lEo4s0ZbdLieRg6wyQEgvhMg/CAN0ezpOXM5MZTHaSaNK/cUTk4oygEVUN0NjDLmePRYmwa0D46KIaCpNRBirxcHgc6bQkIQ4zo7uYqEAeljZYW0LF+JcMaAQv1yEeMLhBHyl5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771799857; c=relaxed/simple;
	bh=xu1orJvAUStUxJsTqxM9TFQEmBVpIZjuKM+MSco+cg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emyL/93WT9GWJkBaeaZuCb673hFD48HBR6+8kein5NR5VB2NdP0QqfQk6WZwovKQjI4m9I2s+UxKIk354B3TJiM4qY/OI+o1JaGrRN9Nay1Ii78ujF3U/+5hONL2Gnlep/oa2sWwGTK3QX7BFRQjn/Xv4IC/FHeP98d+OceKbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oGdYWWJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJPJ4R4n; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oGdYWWJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJPJ4R4n"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09B627A0160;
	Sun, 22 Feb 2026 17:37:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 22 Feb 2026 17:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771799854; x=1771886254; bh=OzK72bzr1q
	r2Ih0Faw411SG7a/FczwMMghwcUfnp9tE=; b=oGdYWWJNijXLBZvAYLjKSF6A7n
	publivmLoPqDIx26eFmUU+MXCOyOl/kfYoAd9NDJQFXWh2u8aDh+E6/Rl6R9NUQa
	K+uTdFzZlVJsvsZErS58RgzgBSmQ0jAcJiNj3WUHXB3F7Vk9zMWS4xgwPpZI8djf
	/RYhMIvS289dOC+THKSOiBjt5PIoHnmrFJm+nEB5P8EoplAxaq7qscGhcNn58d7Z
	/TI1JoLP+Q6N6xKjk29zmiImTBrHGn2r0Shrv2oiaUyu5C0ZGF/P12qDn9cZiIM0
	NwvX5a3LsKa8Y14TQ7ewno7fajSIu8zKnBfepmHZrTRE/8j9BYYfE/cUy+xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771799854; x=1771886254; bh=OzK72bzr1qr2Ih0Faw411SG7a/FczwMMghw
	cUfnp9tE=; b=SJPJ4R4nG3slNawSt0C7HtJm5iOKiI12810oXuQYdYT3E/CwUIz
	1Y/v7j9PPAId9lSP3N1eMVAlsP9P+8vQOKGXmtuoZDY3BmkZrBqt7g+NQ6KP0sUJ
	Gu3BkYEwNDEWigtopYTIyORPvHfvg0vMWoA+dnCT0VUESggrccMj2yB+8rnyfv2S
	LNDfsRZIeYucapkM9NMC3F7gA3vEKApAi0sgGMVia4NkqpRq1WBG9W22Q3A0Qo4a
	LY+pGyQDTRd1ATGm6AQYNP5bL9+2guM74L2C35eSxcBdK1wclmpx224DXWshSKJd
	0Nfj6M24Aaxx+FtDLyiqPbxdegq2DLINU9w==
X-ME-Sender: <xms:LoWbaf0nP7lA1WDiWpWrQE2hrzxcJQyn2CNiY4kXrY5Y3QyG_OCx2Q>
    <xme:LoWbaQo1wRMt4kX6uy755Kg3fyyPJm4JiTPG7zJZjCnHYziCtpU4Zp9-u95Na0vHR
    0UWblSDg5Rd4aV7EK36Nk-I8zlQ2wm9tnxsz0NOExdTzrzzkLJu9g>
X-ME-Received: <xmr:LoWbaThmQBd1zRljxQ5wxVZExc4d2rO38bVqaM57QVO05oUigNhMCzNbHqsDgPonPqtSFwVTkCUkYrc4YyMFmoRtPXdYFMBBrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggvkhgrrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefud
    esghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohes
    ghhmrghilhdrtghomhdprhgtphhtthhopegvshhlrghmrdhrvggurgdrughivhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LoWbaU-LbpsjEgCacHfse6u-lheBtn8VJxSVJ7WrSNoGGM9hzp-s6g>
    <xmx:LoWbaXV6ju8YevSkOGRgMJaMM2UNntAIFW3qnJvQEDeG1M0nFttKEw>
    <xmx:LoWbaQD4LG18cGnolVJqMePJxtwvsUDjdKNEEvQx8KGhu9we-PLDZA>
    <xmx:LoWbaUGU_EtnqTnFKN1W2aMMAOZoM5Ios9lkA-rjHu8UWuGatO7yHA>
    <xmx:LoWbacy8ZFFOMRumV7wTlmUy7Y2g52Z1yfhNviNC1YlMDteQ5FWB06Bi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 17:37:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  eslam reda <eslam.reda.div@gmail.com>
Subject: Re: [PATCH 0/3] repo: extend info path reporting and structure
 statistics
In-Reply-To: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com> (eslam reda
	via GitGitGadget's message of "Sun, 22 Feb 2026 18:28:53 +0000")
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 14:37:32 -0800
Message-ID: <xmqqzf50pfpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"eslam reda via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Eslam reda ragheb (2):
>   t1900,t1901: make repo tests hash-agnostic and wc-portable
>   t1900,t1901: fix test portability issues
>
> eslam-reda-div (1):
>   repo: extend info paths and structure statistics

I do not think you meant to send a patch seriees with these two same
but different looking folks claiming authorship.

I'll let the main change 1/3 reviewed and commented on those who are
more invested into "git repo", but both [2/3] and [3/3] need to sell
themselves with a more meaningful proposed log messages.

I think the test updates in [2/3] are all good things to do---they
make the test more robust against changes in the hash algorithm
used, what the history left by the previous test steps exactly have,
etc., by avoiding hardcoded constants in the expectation.  And in
light of that, I do not think [3/3] is a good change, especially
without explanation of why we may want to use hardcoded numbres.

Thanks.


