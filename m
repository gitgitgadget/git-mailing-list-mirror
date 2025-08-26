Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4764C8F
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219881; cv=none; b=QlqQoTMoJjFg8f/sarjkmRMzjQpaN20U3qkShae54nFdDckjtLDhKfp6RmTK/xPPmBugxcv4BUtW70bVKbnpAqWXpQrZDyvyUVioo5GZoDoiaokQwaP24OiNS+c70tgp9LXWe0QkuyvR2YUEC0imMPKeTk6MljgJxcAB1hYajsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219881; c=relaxed/simple;
	bh=+DBGik7pMTzYT0ALNVOYAn5vdqCNKbu79MpDPZuxyUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWCeptIbAl/1bgN90XNqmAb9zKiV/C3xgt2R4Zfgs232oSmBxTsJCBA6BxHTep9jC186kduJ8h3bUzMmhIvUt86rjwINvYuGqsJbOHyIDtfAsWwvLfeba5XMpLwBH+r2L28BMgHJl5s9Juw8sOkXsfVl1+yhzmv6MZTPlq1T0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z019ReUg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UYmvlmdZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z019ReUg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UYmvlmdZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B7B1EC0443;
	Tue, 26 Aug 2025 10:51:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 10:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756219878; x=1756306278; bh=NXbyGWKjS/
	k1cxJp625jClq8DDfJipzcjB2VfvFCAww=; b=z019ReUgq3oSMAKxb6ExiJaXUH
	y6U0wvVw1U/9Lz6xcisC9YayfAXeuMnLBC0qAcvGmuJPiyKzfsZplMDX91/qeL49
	8NEw3RQXD3MB2wbJr6z7pQ6xdNXeD3Nyspx6HvD/xHdWvEkxd7XzqpeVjatdB03w
	ar5T7YGCBlyXhyvTwhCLQP49k4Oc9Anff4Q8v1gxEACwxz1csyCM6kWn9qoJlHE7
	lCevHIxfqvZkkLCyCMsWFDhM06DVYgpIIjsaXHWXhqiokOqhYMdk4LGGHnlRooKX
	FHKDPnJek+exXto0ARiao/N4XZvGwNqhRZk6G1IxruABd7WiBIe8LbMkWBQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756219878; x=1756306278; bh=NXbyGWKjS/k1cxJp625jClq8DDfJipzcjB2
	VfvFCAww=; b=UYmvlmdZEqrIwy1qjTyZAfh/cbMfV9cipl0AaGPLJwGXg7lpym0
	mL+FDuCfPJHoRnTNG2ppN/AKaTWeGRKzube+53Xq2vYJnIDm2cDvx0i3tqQPCoLr
	WIsvDUb219eOK53M/PfDbkLVr7l8wnY4SdmqofzsSwwhdKjBx2X0UJbZTmM4VmoV
	hlZttVS4tKfgUp4NF+aIL09LBSzABXc4PIrzJtrva2cYbEP79ssJhohp9Y39xipl
	EzGE9wWUiGgTYxqL5GyfCKiHAyiT9ujDhyOs7mw5wL8GTCesj6n+T0c6k5+RCJEq
	iCQ8AMh0sgPPaLda+D77TIthEGGSPs5MMcA==
X-ME-Sender: <xms:5cmtaCCbukNimTb5Ib2LAVXq7u1Agm1CnlZdOiP6cIihiWlmZ5GYZQ>
    <xme:5cmtaHHaPK0FDr0ye6iMea57fQ_fVGPJN8juaACd4xY-8Zqf1lzwgsu5Tw-GyF3ia
    tSHnLQ2KKZ3knH-PA>
X-ME-Received: <xmr:5cmtaCKWdqachGT8-BVdYB2kQQ2Xej82VsGy_E6zW-WXZA0NNsndShyALOtBXewS1x_eSAPvQd7UVx-2HZChh_h5BuzLwuUsB1m7890>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtsehjjhgvrhhphhgrnhdrgiihiidprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:5cmtaDmu-fsVkNb1JO9hPIeMJug5MadjapzR63A-oLCQXq1mEUZjkA>
    <xmx:5cmtaCSy-PS0jVJDKMwswHV1JGOXhbRY1VHCDum8Th-DZ9n11XKT3w>
    <xmx:5cmtaNJEC7dtKCUHpfCChEjFJagvfiCENMxMG57unCm6MtVF0ocv8g>
    <xmx:5cmtaADgZbjBnxhUj37VD2G06yvXDJJf6G_FeNAzhMdle5t7nTb4vQ>
    <xmx:5smtaDRmAyBIc9QYAA-W70v5hac3USHtuKCFoM3iUunKj-_vY-9lQ8-J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 10:51:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julien Jerphanion via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julien Jerphanion <git@jjerphan.xyz>
Subject: Re: [PATCH] Add `-u` short option for `git pull`
In-Reply-To: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com> (Julien
	Jerphanion via GitGitGadget's message of "Mon, 25 Aug 2025 18:49:48
	+0000")
References: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 07:51:16 -0700
Message-ID: <xmqqikiam90b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julien Jerphanion via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Julien Jerphanion <git@jjerphan.xyz>
>
> Add the short form `-u` as an alias for `--set-upstream`
> in `git pull`, similarly to `git push` which supports both forms.
>
> This allows users to use `git pull -u <remote> <branch>` as a
> shorter alternative to `git pull --set-upstream <remote> <branch>`.

The above explains what it does.  It does not justify why it is
needed.  Surely it may allow them to type less, but is it something
they would do very often, like every other day or even twice an
hour?  If not, should 'set-upstream' squat on a short-and-sweet 'u',
robbing it from future developers to use it for more useful purpose?

