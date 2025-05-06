Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C862188734
	for <git@vger.kernel.org>; Tue,  6 May 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562302; cv=none; b=qVKTUo07aaI2cON1NRSf1LFs+yPWI1hugc1yZubr649qS12mcc0pGAjq6Y1GUe9trJIcXRxAGMVpX4iu/c0SgjqKTouFnmnUR/Lqvih38MKA5qCj+ubklVXaxRCPByFWJf8uok4gtPA69sbgy6qgDKtzv88wH3D1sHPcKD4cz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562302; c=relaxed/simple;
	bh=OiXn/f+Lz21qMH34UOzWkx70IT9/wm+8WejWhT1MDWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MlC2IL/W1ZCHwiol9r5g6IdiO4I11DeBWiF7bcMpL7Mup2yKVDCleKIrELZSIhb/IfHvjTYBM9TA6frP8NT3u2/fOJ75Oa3dPo2a72I14cVXcrt6Y61pVW5DJKKMKT9/5DAxzPerjvmiwL/FwxH+Jky+yfv/I5YGCesLRthNnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ul1gY1B0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rY7k1XcW; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ul1gY1B0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rY7k1XcW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1690D11401E4;
	Tue,  6 May 2025 16:11:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 16:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746562299; x=1746648699; bh=jE9P7ncDNx
	RRQ05oyIrqtlPZ3h2UkManLA1gNSmB6Is=; b=Ul1gY1B07Vb+vM2J148iv+R8iG
	YSNxldyEneKouYok/T+s97PeC67Ed+djpyV/rXoIFLzd5/bulLfoMPewBtK+0TRj
	f8ZeLP8FdIim4vemA8OVX9FjignhCuhvTh1gIpZeywjeIIXYR595tDfljX1RHZ2O
	qmoR2ekH6MzK052kBMzqudg6XIbuTNM7dA+eavrXFM6aAfrlmY5Bbgsr2MX3KXeY
	6/0Xtu+VEbHqIaCGEtBuB4wESOkBscZNz5Ya+brcjUaC2QP048MiJSnpV2E0n48c
	f9MUDj33HGoxT46umjWP/yCEXrvzmzDfw3fNRWuvRbMd7jVqQl+7mG9cUpjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746562299; x=1746648699; bh=jE9P7ncDNxRRQ05oyIrqtlPZ3h2UkManLA1
	gNSmB6Is=; b=rY7k1XcWVN4aFh5AX/xDy6O+Qux/VqE6KoTd1h2LhOEwTNFqyFS
	KGmBeyVtXu2wxHY3URDuUI2D3YPycSfv/A6EGpacAMVt/bX2nX/lpumPjB2R5CV0
	bIpSmNHnAXmP1Hj/zGlcM/gkQRDltgCA6qzerAF6ub2onpa+VTC/ZMi8VvQSYkai
	SqExc0ZZj6gLmSeT+FDYtN3e1tGEjsqTMm90FKTobKDQ3ulPVnQNVoNMl1NrERxR
	YbseMz64Uk4MkSCXf/VdyU1yXz+uwliH6a8Fyu8wwd6Xbg+GFvtC7Ol/EJ72iUiS
	F5tA8EcTb5oLz6T8fKjOEY1sLtxLir5TxVg==
X-ME-Sender: <xms:-2waaJCqGx7a2YrysXQGkllWWVkc2rVIlCREnJ-JhNLFDgBZb2erSw>
    <xme:-2waaHgbuxEchJqcygxjSQgt66h1N0snZa3W9ODmmK3mZ9bmogYdiEuRiwfXk2Nh8
    fvbAnoJA1237d5TbQ>
X-ME-Received: <xmr:-2waaEnaWAGarEe2JiuL75oKAUpBY7LTsJ1BxCDlqKItPI8SUZfqEWY05cQNrpdb3BFsyJre8-TOmZMgNIegxmdrOs9MaLWdbHoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-2waaDzzITXOi471bBHMLRPB0700BZLAGB7ku0c9JaNbEH0bFE4aJQ>
    <xmx:-2waaOQ8kJ_Ycg-MSySrAFM4UbrdQpO3UfomqJ5t42YFLc81fwptuA>
    <xmx:-2waaGZhNeK2P-Jv34WngIuuMNBFRIT5oq-_0nxzHcce-3ot0thd5g>
    <xmx:-2waaPSt4fY0pbUj1XbRqXVIPONS2wSbomBmcQ4IvWLM9L9erO_p8Q>
    <xmx:-2waaHAnS7BGU1LLf4LmBM1MQv8vfw5gtE3_gOzZtQlAGEr264qC4l9Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 16:11:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] contrib: remove "git-resurrect.sh"
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-8-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:41 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-8-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 13:11:37 -0700
Message-ID: <xmqq34dhijnq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "git-resurrect.sh" script can be used to find traces of a branch tip
> in the reflog and resurrect that branch. Despite a couple of global
> cleanups, the script hasn't seen any activity since it was introduced in
> e1ff064e1bf (contrib git-resurrect: find traces of a branch name and
> resurrect it, 2009-02-04).

A single-purpose thing that is done correctly on top of a right
abstraction does not necessarily need further updates, so I doubt
this paragraph contributes to the decision to remove the script in
any way.

Having said that, I would not be surprised at all if large bugs
still remain in the script.  The reason why we scarcely heard
complaints about it is due to the fact that people simply are not
aware of it, people do not lose branches too often, and when it
happens, it is crystal clear what needs to be done with the output
of "git reflog HEAD@{0}", once people learn about "git reflog".
Even though it may be tedious to inspect "git reflog" output and
pick the right record to use with "git branch" to resurrect, as long
as it is a one-off thing, it would be more assuring to end-users than
some rarely used script with no correctness guarantee magically picks
a commit to place on the "resurrected" branch tip, I suspect.

So I personally do not think many people shed tears if we remove
this script.  I am for its removal.

Do we have a better alternative we officially support, by the way?
