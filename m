Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D142A83
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252747; cv=none; b=DK9zjD9vebThAaAMKUMtzrs4pXRksETgGJzJZt4P9CMDZ2phJligd6FA3+tVaq9XW/wwve7Jb2G3Ib6OKsIDCNXLHgXLUEg93x+L+9TSKt65OeV1iG6gWtrVlEAzsKtqQiFcfo922q1AzV2XlLq4xFlsA2Fwg8vAtZICLTBGaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252747; c=relaxed/simple;
	bh=4sggu1dc3SaTXqQRozhbbv090JXc1mw0nXY6+XxYSrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AAilWSO2HA5HHcB6F0XXw/6Gv5i9yrOKBmQEs2QXM5BZzt/6xsSvxNPEUx64w4+aRT6ya+Aejy0lxGko9DOLEl5WquhSnWHKyWSB1UAKirO+DAKa1fPXTum3mSpZHcVPDY5/D9mNwav4B9TkoXV+2joCXN7DjhDJudE+i861a+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z4AUU3E1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ly5aAGNG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z4AUU3E1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ly5aAGNG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A1C01140116;
	Fri,  6 Jun 2025 19:32:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 06 Jun 2025 19:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749252744; x=1749339144; bh=LH3E0CdRiT
	3UZkcOXydlkp253E1m5PI4zvJw/OV41rE=; b=Z4AUU3E1Kv3ydBovVbZbjitJYH
	L77hpkzgKeNBAUywkrV4RPqgZN+v1M5e2uoN0oMV2iTLJSwodanwzp/ww3rYGPTq
	927YTHwWUN/VNqh00JMyU2pAOfQTeCypFct3iOICdjIO9tyUw1/JZGLGRV3oYTFN
	pHCkFBx/19IHl+uh/TvRHDcBECeOzagBuUVVYd7ipOS4yk4FZo4IDsRN88QrkPwc
	UfxYFo741xkWHAdIuDOPzZ49WjjzR38fDZGY6Qt0kti0pmN5Rpc0jPiCLTI8dVQ2
	9hmHnOG9HTDVtw8bDPw1e3qbztHFVd70gA8ldkIQV9+z9cNFZ+cP4BXcO0cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749252744; x=1749339144; bh=LH3E0CdRiT3UZkcOXydlkp253E1m5PI4zvJ
	w/OV41rE=; b=ly5aAGNGu7mhx6CJdseK72/Kd0lUAy+jytprScbdw10xs0tmTJc
	c8B/E7GJZ/3TH2g1MaXINvjYDAiQSFGkl0NOWuJKzH+/9BXqRO1NZOpshXg3+Y2g
	SzOR7E906mDiLV5ziPJ/CfVCJEOA/8IyIdB6E7XOU2oDh1LiQAoVsW1ekGAEy+y+
	VslBebR6sfFFYvOYsEqljTdxjQL09YfgNQP3j6SQuDxwhTN4KkvyRqLYm+Fcekpt
	bYCL9untZoGacGjQ5otY/xGmcOMXb83/jEo4DworhhNai/zG6FHSP5MncQcahJ23
	pX7cnn1kYRegfQZEo8A2XwbZzb5pd7cgByQ==
X-ME-Sender: <xms:h3pDaBdzdIb1Onr3gXve6eghECALHRENmgyIiiJ27_Fjc5xADPmqLQ>
    <xme:h3pDaPPGJTJckd5dutG-jG-9RSonfK-DiYZJFt9YbaeIP5WbCcTnAJsaUEUeGzYhQ
    PEJAXkeGtj4J2NcXA>
X-ME-Received: <xmr:h3pDaKhfOGSAf2q5QSrci1sKQfBkAb_IMTZS6jH1R1emVc5YcL4mzYx8BfKVkFlPpXi9z5BTedCSLw2Pgv0EtiGMamwf4sY11pTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h3pDaK8WtXVauvzVzOKkDCpOOAsGStMKvzDxxu1OHhBK5udPukNWtw>
    <xmx:h3pDaNumE7h9CfFMu6reysTBInNQODaI45ALE4gmWUyOSJK-1IyFaw>
    <xmx:h3pDaJFpEUXRW84VukqS4VGFdQusKYHBt7DsNqRbzo4uMhnEbktsAg>
    <xmx:h3pDaEPKi4_EcbPpXfWbR-rDo7bkaN1bsmdOaMczxJWbBDP-TV4a_Q>
    <xmx:iHpDaAlSoWJWQtRPDmGDM6FfdexKpr9V55S7X5aAmEEG5ljBA7YLrQhJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 19:32:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Git Mailing List <git@vger.kernel.org>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: issue with git submodules and a clone.defaultRemoteName
 different than origin?
In-Reply-To: <bdf7e50f-aa65-4514-b147-9f7ebed147ab@intel.com> (Jacob Keller's
	message of "Fri, 6 Jun 2025 14:29:48 -0700")
References: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com>
	<xmqq1ps0gzo5.fsf@gitster.g>
	<48c2af0f-348a-4443-a8b7-74ea4b666bff@intel.com>
	<bdf7e50f-aa65-4514-b147-9f7ebed147ab@intel.com>
Date: Fri, 06 Jun 2025 16:32:21 -0700
Message-ID: <xmqq8qm41m62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> It looks like those end up in the "read_remotes_file" and
> "read_branches_file" functions which are deprecated, and planned to be
> removed in 3.0...
>
> Would patches to modify those to take a repository pointer in order to
> allow callers of read_config() to work properly with a submodule
> repository be acceptable?

The recent trend has been that it generally is very much welcomed to
fix such a code path that takes "repo" at an entry point but ends up
deep in its callchain to ignore it and use the_repository instead,
even without a potential use case to benefit from such a change.

You have a concrete use case, so I would suspect it is even better
than "acceptable".  Patrick, what do you think?


Thanks.
