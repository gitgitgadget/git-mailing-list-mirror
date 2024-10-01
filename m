Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF041CB33D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795078; cv=none; b=YZ3q5WYr2zPBZvgo2a24uD+xNk+m4DpyfWW88u9m+/gD3YuWlErPH9vNG26AhoZEPWc4x9d8ccGdZkUyhGyru2KT0emg1h2Nhz5yw8EzQuNTTSWgzwKFIR9Q/huR4qCO/8lU2MA8xSWFs10u7CoHXxBWZF0fXUUKBF6/J7/t8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795078; c=relaxed/simple;
	bh=zaiT01cBZRH8sz3uA94tgwc/exOyptFgL8pelWNZMIs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hLOU/F7B5VuO06lXZJNSVEEWH/WRiFbwx/6oAizyUpKvcZcvpwGvr0fAZd5LfNyfY+tnjO6unksxhGOXn5HRQErvK2FTmfxXkl77qd5jApQtBCKD6LlvV8t3o+TFJxanu6TnpowPSHS6zMgI6tQRWqlox8sBqgRQVYdhZXwDm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V9AThs9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+A0kFda; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V9AThs9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+A0kFda"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C87761381719;
	Tue,  1 Oct 2024 11:04:35 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 01 Oct 2024 11:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727795075;
	 x=1727881475; bh=DtU1uwyefuulaQpqYexmUlrBX4IkvqL/rQHECkj+l+g=; b=
	V9AThs9Q4BVMYWktMCMPhBPxrfwU4uBd71hCHFB+XEbkxNmI3IOLJPV+6eN31RcP
	DAUelzTgXC1LVy6IDmzeEASP2W/qhxOGTNK0gD6L94/abLUW4MnKAa15NAE1OZw9
	kD1mLlzIeeDz9QjM9Y2CEmmjiTZhbogtsyGAQ/BAOx+GyuUExObevSQPaC3lOgIp
	Nk4JF6UCznE8Pt1bZiXjMLweelU0Ow7qc1ZAQ+565w62V4/NztGzGVdoJVIds00e
	I7Jhj04W6YSSSHWKDr+wBypLy7SiP3sF2Ehy4bQ3XYW7dnkd2FDGnsOhbsZEjMuo
	f64l1rcXOOf2qxNRbQ2Htg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727795075; x=
	1727881475; bh=DtU1uwyefuulaQpqYexmUlrBX4IkvqL/rQHECkj+l+g=; b=C
	+A0kFdaa16VFiG4l0o5XXMTtRPlmUwQHCOgFpuEKzyUwXSAqPAqfk95g+Fv0/GLv
	lDNTJZBtDWrEWAnOdd4VPsAy6lbQdA7D1/9ASW8Io0QeWVtzSWc99sWOW4OwmdAZ
	lCG4HHaIRHc29NycPZy9zXIDyga7FH80aHcudftuNNC7AnDhU8jJOEaGwJhy3Up0
	WuNiCIoeEH0WkJOZE/IkrRG1bnxmfAXi70Ens/CLjIMdajNu/J4HhpeTylKHZxvi
	BcyLAxYq7eVUV86g49pTWClCuv1UTQoQPtetPsNsl3yfU0oAVAibxlkHGxxK36ap
	SQ6oHNXCGGOFsVwKPw5tA==
X-ME-Sender: <xms:gw_8ZjW5C5JrERzFvVrFAAiO4cMPEvykKuWYCi1A4-tFyY_3wSG85JU>
    <xme:gw_8ZrmVNbL3cF-D2Vb6sUMi6us1hSuZUQnf8HeBrf2h78EV0d_gmJDcO55o56m5t
    dRl57bY8uqChymSyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeej
    keelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepfeefgegvvghvfiegvhhjsehlihgrmhgvkhgrvghnshdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gw_8ZvZNQXGeuEIKrpJilwCt9_VS5wWdejN1Tnjp4K1uwwYjK4axtg>
    <xmx:gw_8ZuWhhFyiwPI-Tvk_suLvo-z41Wilf7zAy6EZAzKPvXXQK2AhNg>
    <xmx:gw_8ZtlwTJ8FiUnvQjXw6ZuDG2T69FQikbkoqiAU4xS0BjVNrLHLAQ>
    <xmx:gw_8Zree4TePmrG-_nPxhg1UiaqKVuqGuH8-SrJmgBxF4dsmfJM7ig>
    <xmx:gw_8ZtskFgrL_RWOUQDhO8pEDhCBIuCctpUiEZ6SOCgHilA1z-9z70Eb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F7D1780069; Tue,  1 Oct 2024 11:04:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Oct 2024 17:04:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: squeaky <334eevw4vj@liamekaens.com>
Cc: git@vger.kernel.org
Message-Id: <7fddacf9-55f6-4520-a288-279d3784badb@app.fastmail.com>
In-Reply-To: <24417-1676937251-531825@sneakemail.com>
References: <24417-1676937251-531825@sneakemail.com>
Subject: Re: git rev-list --no-walk RANGE not working as documented
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023, at 00:54, squeaky wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issu=
e)
>
> git rev-list HERE..THERE --no-walk
>
> What did you expect to happen? (Expected behavior)
>
> Show the commits between HERE and THERE.
>
> What happened instead? (Actual behavior)
>
> Only THERE is shown.
>
> What's different between what you expected and what actually happened?
>
> The documentation for --no-walk says, "This has no effect if a range is
> specified."
> Since HERE..THERE is a range, --no-walk should have no effect. This
> isn't working as documented.
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.39.2.501.gd9d677b2d8
> cpu: x86_64
> built from commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 6.1.6-200.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Jan 14
> 16:55:06 UTC 2023 x86_64
> compiler info: gnuc: 12.2
> libc info: glibc: 2.36
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
> [root@xps git]

Hi, I get different results based on the order:

    git rev-list HERE..THERE --no-walk

This (like you say) only outputs =E2=80=9Cthere=E2=80=9D.

But this one outputs several:

    git rev-list --no-walk HERE..THERE

--=20
Kristoffer Haugsbakk
