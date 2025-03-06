Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E9145A0B
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277475; cv=none; b=f+VO2KO3rs88FY9IBzIEE8tnHcpGIUchqe8Qj6Ts920JeC7L3h4+/7Cb1RftRj75DFjVpEBcweA8LYEhS80EvuOTVwA3sqJbRyV8oS+9BEYGQ7nhpArixGv41UqY8O7V30xojHupAcA2I3aoCM04qwthJ0ubvUxDwltEPOF47p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277475; c=relaxed/simple;
	bh=mRSf9wR5gSrUrtG1LGnRUjQJNM9VENzFvOeZv6x4m28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMjxo0NcFpNe4Hks+J3P0IbcowALFPEH5LkKGmQlbq5VctXjepQJxIxvvBmW2eDFlMzuv4bv4FBzTbRpcQjUf9EfbMmuCqw7tjVCtqwzbDBR6GWyIWZlp/mF/rn+ITbmVhDKSpeI/VTKgKFLqt5fjYP5FfNd1xXIfaCjZswmutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zmqnv4Gr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oxa7Y/Qf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zmqnv4Gr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oxa7Y/Qf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4096B11401F6;
	Thu,  6 Mar 2025 11:11:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Mar 2025 11:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741277471; x=1741363871; bh=/oQysCTdv+
	IpuPfQSjIykhp/WvXq3VZ+UH0hQos1zIM=; b=Zmqnv4GrpubTd1H/KQUFHMPiwP
	KJeDCvbu3ItvVNuqLvAXQWIJxA5Ldowd6zQn5KLwRDo+fr14uBE4i3CvjtOWry2L
	rq7GduhU6YvSWpxZ2goYzFJoOzI7N0CdPEEcab23uCrXUffJmHSJJedSl8sAkQer
	RLTk0ylewYta46eOh9nvYVBjyuAid13ecEcKX8OXuXdOMDQeYtnJ8V2Lv06L0Toq
	vxEhnmSzPeDTw+IsUzAPa7V8Cnm6cJpZssSU8Ofb1Y/TSvTy0t3SpxIVhldq69Lb
	7jSwB3ZOw2+fjvE1VNRA0LoWhI4S6ezG1MK4CIuTTpTK8fRqNodzn2HiqgKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741277471; x=1741363871; bh=/oQysCTdv+IpuPfQSjIykhp/WvXq3VZ+UH0
	hQos1zIM=; b=Oxa7Y/QfGyQn8osxRrcMdoqsRQegyyD+xMxhiRav7o+ZDoKdqb9
	VS34Mk7xy5aQ9MJCHUoLaUvk8IQmr9ZXqjKirDsjfa434CxjWtwa7IzV7y0HF1sk
	ryjshlqBRwC58zsVkzbSYZpnWbSCBkD8ZGOrm/21kgL0JGlyRSMI2PavdCPsqMIL
	rz2cq1rrcWKi43WtaWokeZyEojkWpVYXkGm+RlRHL55EAT0oHZdTvY1reLqADNdP
	rscB70BL8T7noG0TlmxQgG3vxw30wx89+kpkGyT8Tbz9jD9s/inrbUsMz1qpUoLF
	R6jYh65LpoJO/uN/Vf7ODhGL/exMDcSyc7Q==
X-ME-Sender: <xms:HsnJZyq3llOL5K9LVU-cI27o37yTzELyLxq463DycxcFjfY49HIQ3w>
    <xme:HsnJZwrVaY6Kv-zYZ7ZZMjjc_P_e-lFFnW7nRSlxTOZXlE2M16lLNwMrM2nDI8JsV
    Fla4bxf2EP6pfUi4Q>
X-ME-Received: <xmr:HsnJZ3MJD8GURWSK1n6BWFX1qOMxNFIDEyhmWd5WGPZMXeYaYKhuBwRX5lkhf-627QNf4NBIbv-Qugh5BXWt43H4ddiHI6QRU5wX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhthhhusgessggvnhhjrghmrdhinhhfohdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HsnJZx7Ey2oXDXXtwR-1bgrWkyivb4TtCFVaoCm-HImpCsVQrnT-Ew>
    <xmx:H8nJZx454ZY8GuyTP4-8NqPps66wNpBWxr6OBvB8wV3BELOPPpwq4g>
    <xmx:H8nJZxjixMO8HMnAXd4dsQxVZxdWJDeszfOj9IHUajXKw8WcoUdPYw>
    <xmx:H8nJZ75ls-7xfs1DrYvw3Ci0zXZG2cPwrLdRuJcNnvRILTz734HTcA>
    <xmx:H8nJZ02uuDwxnUSQTUklRhGGslX1lsCqXLwmZ5-otKiIalJTQpJKEgsv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:11:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Benjamin Woodruff <github@benjam.info>
Subject: Re: [PATCH 0/2] describe and diff: implement --no-optional-locks
In-Reply-To: <pull.1872.git.1741240685.gitgitgadget@gmail.com> (Benjamin
	Woodruff via GitGitGadget's message of "Thu, 06 Mar 2025 05:58:03
	+0000")
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 08:11:09 -0800
Message-ID: <xmqqo6yejg0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> git describe and git diff may update the index in the background for similar
> performance reasons to git-status.

That is a wrong reasoning that is completely opposite, though.

The commands at the Porcelain level, like "status" and "diff",
refresh the index for the CORRECTNESS purposes.

The commands at the plumbing level, which are designed to be used in
your own scripts, like "diff-files" and "diff-index", do not refresh
the index for the performance purposes.  If your own script wants to
produce correct result, your script IS responsible for refreshing
the index after its last modification to working tree files before
it starts to use the plumbing commands to inspect which ones are
modified and which ones are not.  This is so that your script has
more control over when the index is refreshed.  It does not have to
pay cost to run refresh for each Git command it invokes, if it knows
that it does not make any modification between the two invocations;
it can instead refresh just once and then run these two plumbing
commands.

So, it would be absolute no-no to make the Porcelain commands like
"describe" and "diff" not to refresh the index before they work by
default.  As an optional behaviour, it might be acceptable if there
is no other reasonable solutions (like, using plumbing commands if
the callers are not you typing but your scripts calling them).

