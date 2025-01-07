Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A3125B9
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267021; cv=none; b=iHZoG8QsbpMXRjkEeqjUoTmCXQMZ8/DG3yOgB7EN0uHu596kO0cZyjKxFNbP3Eaz2cFaLd+ieqJNerHWC1KUfgkiXdr/PT5yBw/oCQepgSCra/HT9EV5xJwqr8M3cvPXnC/UwJojDw9ujvn3Mlu4Z1KKWbONJPR4db6NSe5onFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267021; c=relaxed/simple;
	bh=zNw0lEhJ1e7/ABQwAYoHNlhwjSIDFMt/Tarf5FSZ2TI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pkws5P9YZ7JnYsBd6FywZRB+pDCpv/alQeb8A//nrubo+PUpKKTwTZnDFBr6C4Eek843Kw9jNRImZUPm6kDyaUFdm3y2LJVcLaP/8pPEuhMfVhhclkLzxTlU7ILmVpx11SOQWPSHHbXV14eIISpZmBEQJhiURbYKtkOrg7nZcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hWuPVdY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+ixbMgH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hWuPVdY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+ixbMgH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E71D711400EA;
	Tue,  7 Jan 2025 11:23:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jan 2025 11:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736267016; x=1736353416; bh=lWVUIv/vbP
	OaezsSqH1i3oOP/PfAnoM8DH5jRnmXeKs=; b=hWuPVdY52d0G/b3jBCufeddafd
	CgVJ5OwMzep1CTKY3iSTmnZuY10DjajsgLGunIUXrc7VmPAUPNDzrxGlX7kg3Mp1
	Wj0yo2WzrDB/f97D5LyHF5pvRiPxu8CyKvYOzlFDjIimULAoxt7YbKP31EUda4qk
	oX1Vxw8PjDm144UBtzEEZRRTcHHB+ns/pKueXGZFNm3SgDlp95kZvvJc7GMj62ua
	jizIdu09lkI/roj2jU1gonYCO5bSbB4S4ESZMaRhCYLpKG8A38C1oaqySo8kaywO
	4aJHkdecywKnkczYi5jXdaHk419jAxSlouKDCO5ql2xDxBK8W0VO2rNQDddg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736267016; x=1736353416; bh=lWVUIv/vbPOaezsSqH1i3oOP/PfAnoM8DH5
	jRnmXeKs=; b=o+ixbMgHoWGxsEpk2sX2xXR1fr4mFU6OCOyP8QPYrzt5WPwCYZd
	rElepab85lJXr28jcM9Yc+Dqhr7jx213CnAh7IdpaGg3iUPvTiQYuJ1sv8in+hJR
	tAZqImAKOYEJ8ehNXCVVK+eeVtbkesTDWEn4y6z2+wqtxOk3QdXb5ibbMa6ePU5F
	6VoUlc4x3rXOZrO3iJp45oVVL2FzfBAVvfa4bTG+GXDf1DuG8wvZIZeHvZ7rsLn6
	DfizMT4slRwkU7UAv+sII88wcO04DQxMYe+Kdt9ij8JHnV0ZlYttDD+eLEavLOcl
	TJNezcasl2vO/+ffhFa0DoA98S5FKksYo7w==
X-ME-Sender: <xms:CFV9Z7vKv0L7nmCRcksps7CjsZZOEm8iwL3dylbBXAYyiZVIJEbQuQ>
    <xme:CFV9Z8dvJxIWEH_tM_ZpcBePOrEE7aYXvc0b_dGso1Ir_b1BrwMXbVbyk03if7qK3
    VQaPgbPKu1HMmUGRQ>
X-ME-Received: <xmr:CFV9Z-y5C75S2PZFpLkncWnVAjt2TwjbpmnUC7G8d3y3pRhQ7f6ZqXYUyQK0cIbb6ftrYyM1g_PlA59CQcbQMId8R_2hkGB9y7Ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:CFV9Z6Ode8ayX41U9aumMETwvdxsPAjRQCdyIGmLql-uwk1cZxMxNQ>
    <xmx:CFV9Z79UynrxoWndHxmfmza5PBxXWTWl1HYekFFBnO0u_Obrm_o94Q>
    <xmx:CFV9Z6VLRFOUshRG4VlHZ0DRUFavVZi2NMu6R_3jVlOBxi2ymVu8ug>
    <xmx:CFV9Z8cExBTBHaDaJwswJcbksZfNhqrKbIWHsjIwuSuNMSRfw87JbQ>
    <xmx:CFV9Z3bF8ArWSq80e4VFmZNZr8DjkIINXpqk7fNoHVX734dfnUt_YaNQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:23:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib: simplify lsan results check
In-Reply-To: <20250107070752.GB584668@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2025 02:07:52 -0500")
References: <20250107070409.GA584456@coredump.intra.peff.net>
	<20250107070752.GB584668@coredump.intra.peff.net>
Date: Tue, 07 Jan 2025 08:23:34 -0800
Message-ID: <xmqqmsg2vbi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We want to know if there are any leaks logged by LSan in the results
> directory, so we run "find" on the containing directory and pipe it to
> xargs. We can accomplish the same thing by just globbing in the shell
> and passing the result to grep, which has a few advantages:
>
>   - it's one fewer process to run
> ...
> We are now subject to command-line length limits, but that is also true
> of the globbing cat used to show the logs themselves. This hasn't been a
> problem in practice.

Nice to see it mentioned here.  And the resulting code does become
simpler to reason about.

> We do need to use "grep -s" for the case that the glob does not expand
> (i.e., there are not any log files at all). This option is in POSIX, and
> has been used in t7407 for several years without anybody complaining.

Also since c625bf0e (git-p4: git-p4 tests with p4 triggers,
2017-07-13) t9831 has also been using it.  It is not like a stray
error message about unmatched glob would really matter here, though.
We are not doing 2>&1 to let the downstream of the pipe see it, and
unless the test is run under "-v" option, it wouldn't even be seen.

> This also also naturally handles the case where the surrounding
> directory has already been removed (in which case there are likewise no
> files!), dropping the need to comment about it.

Nice.

Thanks.
