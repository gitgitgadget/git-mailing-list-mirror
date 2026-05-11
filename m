Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0E383337
	for <git@vger.kernel.org>; Mon, 11 May 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541608; cv=none; b=FHUop3i6p+f/qXreDqTrOm9K3qv0ZYIUDU6nyEUVZrsfyZn2zYJLda+Iom1U1oIx/3N52sjO4m/xzk3eGmnk4zlMMzqU/ioEGrm8zCEG/qApZU38qeWVREslHDV6QOQNo7y9mMbO5so5Qma39WhGx8SiPnj6Z8+9AAl4D1EeHGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541608; c=relaxed/simple;
	bh=5/xTjQUCwwephimHfsxdQ4upEhgZ0Xjl9s1pC9zHbDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8Cj5euuayVj1F/f/UzdXy3GoqlA/0ABcWOyhlz2yZGvpN9WrvfAkFgkXJp0MPSG/d+TE8VAKAUdL7griUUjhrLKqjbdEWon2lP5zr7cuMEmq+C5ipGeqnYJfh6EVnIgqw2mKzMkZjnLHoSOQdeTlFbduWemER43frug8RDbYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tAsAn/47; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Utk3+X/u; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tAsAn/47";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Utk3+X/u"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C8311400096;
	Mon, 11 May 2026 19:20:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 11 May 2026 19:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778541606;
	 x=1778628006; bh=Sm/bBxdYTxBrjLPbFPlyenBzzYEgWl1OzpkI6n7Yww4=; b=
	tAsAn/47CVrDHOxBusZF7WsSk/tIaS5iXaeP6dPskh0EWJgf3vW1fvCofF7xdkwb
	N7rPfGpvUiNWVpxY4wxP93Z3A5Noxksp8iG7KK4iz8t5YNqonqIuNAXeYKRRcEuV
	IFVLpzvfmmC5xEUif1BOHvZ2oOCyg6Vi1V9ELtUwMJzDBHMURcEGnpRAncEnFs7m
	orIMucBeIbQRIAlkYZqgwvdt9xHTTeLFNvNdqXzxJF/I/d/Qb0ezp5pB+e6Ws4hm
	3xv3tqsypZrsKPlF8zjBcK66NrjFThvHE4s7HbRaVYrX1Ca6JSWHTb0i+L5AnI4d
	as0SclnA5yqxLACJiJ62Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778541606; x=
	1778628006; bh=Sm/bBxdYTxBrjLPbFPlyenBzzYEgWl1OzpkI6n7Yww4=; b=U
	tk3+X/uZ8fDnZCq+erWWkYK7QDnolqXNHRqv9U++3J6IFr/JKOlU/tJ8MbVw5sFK
	fDkkfWLbJJq9Z6xw/1PjK+bTe2zr3FEO0gyRiRofD+2sl1LO3Zt4UjT/FAZz7A3L
	Lxxpy7h/G98aeY2ia5NTyLrSD+iynHjkI9WaBhMYi09jZGalu4MxaIhZIWzIW/DI
	xE9ei/OYB8JkP4CvPKep8JOTw6sH0n+dxamlzs36lNpMFhYm0w6ekRuGv+ikba7x
	fy6NfdIgneWHqnJiNv4aoP3b3tOJFcHOkF0+CYNSm0Ycd0TdnH7DOpasdZ+HIyh/
	v7qYa87f83xYaq0pV9LPw==
X-ME-Sender: <xms:JmQCaiLK3lOwGbslkHLlfS1gg72vqrRV3dCzYNAmHKxdLykG6NcG0Q>
    <xme:JmQCat3dP6qx2wixwH4ST1Xy0l72epiVwEzvPRP-ueimxoudKFQUnN34uwqeU0HLS
    h7qw6wzQDhCmzHgR1E9XwXmtmHFVFAT_AG3u0SoAlG6razsqzA>
X-ME-Received: <xmr:JmQCashfBVVD-kpnGj0vMNcuAi0X2w7DdxnGmZEl1GpCjGetQXFLjouzEZAEar1fhsg7S-JRDVkeN3OTJt37P6VLChPe94PEwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhho
    rhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:JmQCauXnpKf72NkEZDfp4XCpJl7Hyh5w6rqx0LgZtxqppbFOYV7QYg>
    <xmx:JmQCarVJIE1eWIJvHDIl4MuPqbK0h5SGzsQ6NkuhGi9t1K7DBYctbA>
    <xmx:JmQCaugeBFEF4nYKYOu8Lk_0BdXWleKrGLbt4--Pfn3CqBT90Pj3kg>
    <xmx:JmQCamYPbu7-U1QSkNzmQwqrQXuVep4f2nqLW-L6tMeEqCHLKjEg2w>
    <xmx:JmQCagV97-eM-DdPvDmvGMZTd5s-_U3bkxnNirVZUiG532ZLpqjFu4Jc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 19:20:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 0/5] branch: prune-merged
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Mon, 11 May 2026 09:44:46
	+0000")
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 08:20:04 +0900
Message-ID: <xmqqse7xr0t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * --prune-merged now measures merged-ness against the remote's default
>    branch instead of the candidate's upstream — so the decision no longer
>    depends on which branch happens to be checked out locally.

I may be misreading the above and misunderstood you, but if you mean
that the feature now checks with remote/origin/master when I have a
local branch that were forked from remote/origin/todo and set to
merge new changes from there, I do not think it is a good change.

The two remote-tracking branches may not even share any commit.

The "what it tracks or HEAD" logic I raised as questionable is in
the function builtin/branch.c:branch_merged() that is called from
the function check_branch_commit() you updated and used in the
implementation of prune-merged.  It does branch_get_upstream() to
find the tip of remote-tracking branch that the target branch builds
upon, and performs comparison (which is very sensible).  I do not
think you want to change it to check with remotes/<remote>/HEAD
instead, as the upstream of the local branch may not be building on
their HEAD at all.  But when the upstream is not found, the code
makes the reference_rev variable fall back to head_rev, and checks
if the commit at the tip of the target branch is already merged
there.

It is still not clear to me if we want to optionally disable this
fallback to HEAD, but a quick scan of branch_merged() tells me that
it is prepared to see NULL in head_rev.


