Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DEDDAB
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868569; cv=none; b=LMgIXtrn95fhtIvJfRsmdHWypkP9l17cqsjqMpgoYQO5wi4NCShcUmbHpQE4hYd2Pm4Y2qvohqB8ON97x0DzjNbLmCY/GAd9AMJ9B2bjJvXHoh64Wix3WHeuRApbaY6z8dxH5+2UuzA861mkIwAR+1myhVJxLNFw5dUH0ygckfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868569; c=relaxed/simple;
	bh=lxlT9H7LYJ+F+5j8JIQ8r1GINZ90HFxxjYfSBLpedtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTrJZ/ulfFgXvtkFlY3cpT7Vs0Tn+gkAtsAYwYcgnPWR4F1iCuSaaJ+g+85tolpyltcLxlqGxUBkAjNEAN3uTew+/bQ7rGqqo3qq2/ALij6Zv2hNcE/SpagLWi5j5Wu6rRR0s1zuiKf31Ss3QvZ549ZphRsbnUaeRnESOixBfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K4Aihwe6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=al1Vc8WT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K4Aihwe6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="al1Vc8WT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E3BFD1D004D6;
	Mon, 19 Jan 2026 19:22:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 19:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768868567; x=1768954967; bh=GQfIb1FehN
	xM3c9h+uychkFlaKZKNnBy/VtVcKETWPI=; b=K4Aihwe6BJhEvsuRtf6dPviA4F
	qBgA6hRMm/3nKvMopSG6AuYlIfLYbbWvFjNpcxHecEFL9j7k16MvxOINDBZHvc0Q
	25cQdD+dqSMmlDZ5W4OuvINJnSdv58guXbo84psVJ1dTsMst1FpwMIUEB8IoUQvZ
	nmrPdBea9UFro9pWwgbgAxf2lQcBARyVIrcLXItThM+tmR31B8RhTN8rzDKI2ser
	z7Yh4oAybDVzp/C9Fc9gxCZUdHLeZ/5n0Pi26CNpkdGqP8eNWtobeACcFUbSLr0R
	x9G5u6Zk8TwOUN5buokHn4pWDZhPs6pw4u3778Ugw3NWxehxBKzjzH+LpDxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768868567; x=1768954967; bh=GQfIb1FehNxM3c9h+uychkFlaKZKNnBy/Vt
	VcKETWPI=; b=al1Vc8WTGGLwabZBjk2LsbfKxLexzT+InXvPcsVCnOMWgkOd5XK
	WpIbCG55+XstJaHdVLOse/EcgH2zVRvz/NjgZfEhSeLCFBW2hyoNkHTtHagC6AQO
	gFf/EyREaDya2+YlrQaLA5IJpcMwTBxJjW4IIbKz/YVQ++/UiLlwHqqKWeER0v7P
	Y7De3LuBZnobcwm1jCqNZWG7F0yUsqK54N5n9KdCuT5Cn0LK8ucgio1ATL+M5Dh4
	cUAe1jIZGl2qYGadNpsZnHuFHWpouMlS3lyFZA/ZLRJfxUQZdELTkIQ7P5dFvHeo
	FX5n9LW2qnIUaps1Qcw8e26ediyQ5+ogq0g==
X-ME-Sender: <xms:18puae0_kBWYJqHU3pJx1Gq5nUc9stpKLJIFl766OW3-1SZ6VPTQuw>
    <xme:18puaX8Mg1eM9_ZKI1UFtIs3MD8m3fwVQgOLlQHgs2wz1eMmBs3CekCnquyVn-8Fc
    VnlNnqL5ROqharYyDSniDPu685mvDZVv-dHqZoR4tyus1HZRUtNjg>
X-ME-Received: <xmr:18puafP-LEpADeQRUaRkax1JlPTvM_cWoMQA5W6sKnbnUxp0OQLFfjp5nJG5jj-DyOL-L7GUSxeGouPZoXsf8Ljc85pg4XNxBuQGCDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:18puabcJ3Ekctulv9y96Ll7fNEt47ol2jzxppTxH1pbd1uKwnMfblg>
    <xmx:18puaeVJNP919-38LBKUZ4SayGIqA8gG1FtdTmOalAAU_wtsVVVsqQ>
    <xmx:18puaTiOv1zgA8JhRVW4yruroXaETNMf_JhEzSiGL65jp4sX5swCxA>
    <xmx:18puad8lL5lSUM9Qu6LzneqZ2B0TJzCv0rew6iiBFkj5NJAtS3oezg>
    <xmx:18puaVPQ6_Uqu3pYj5k4kOzrNmNa3pSDb4w80dH0ylzLKk8Jj45hZZCh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 19:22:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Derrick Stolee
 via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] revision: add --maximal option
In-Reply-To: <1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org> (Johannes Sixt's
	message of "Mon, 19 Jan 2026 12:15:45 +0100")
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
	<1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
	<b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
	<1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org>
Date: Mon, 19 Jan 2026 16:22:46 -0800
Message-ID: <xmqqo6mp3zft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

Johannes Sixt <j6t@kdbg.org> writes:

> But even if we decide to use "maximal", the option must be named
> something other than *just* "--maximal"; this is simply too generic.
> Perhaps "--only-maximal" or "--maximal-only".
>
> Other ideas:
> - --hide-reachable
> - --range-head
> - --range-head-only
> - --most-recent
> - --most-recent-only
>
>> [--maximal]'s interaction with
>> --boundary is trivial because no boundary commits would be included as
>> they are necessarily reachable from a maximal commit.
>
> So, --boundary --maximal shows only the maximal commits? That sounds
> unexpected. Boundary commits are shown with additional mark-up; they
> don't need to be suppressed. But in a first iteration it's probably
> better to just make the two options incompatible.

If I am reading the answer to "what is minimal/maximal elements in
partially ordered set?" correctly, our "--boundary" essentially is
to show direct parents of those commits that would be shown with the
(nonexistent) "--minimal-only" option.  So I agree with you that it
makes perfect sense to make "--boundary" and "--maximal-only"
incompatible (it is like asking for both "--minimal-only" and
"--maximal-only" at the same time).


