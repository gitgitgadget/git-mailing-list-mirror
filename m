Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713E378839
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629625; cv=none; b=j7b54+G/DtNQeo7uW1s0aMUFtCdxQKJ40Oh57T1nqpQiV3Z54UaChMYGKlEAb5KPS/ouomS2cdurcTcGKT1lJT+id991JTUWej0ZI0OxUDTKgZVjy/KlOnu+7D6GPipBh9Gy1sPGlMm7kcwnLAU6GMFbsH2pXIIIozodl2GXt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629625; c=relaxed/simple;
	bh=jTh2quWP4Xkf/6cyUOSQZg6d9sbRwD/XpWhHJOVIOVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LrNajXip0HiM/WgfxAXkQ2PVHbU+UKgvntD019aPjODHcxN1FKTq9AGZMhZmPmYiXUOQEJV4SuH/AqwLd471R/7zKHfedMjIok+jtgf0Y+7YI720Q1wR2NFcR+m33DKL4cYgnj3xcM4pzoNgrlnY+P/GA6n6xHX7t6hqUNKieMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RxLo7H4W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=la1nq6Eb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RxLo7H4W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="la1nq6Eb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F3B0EC0040;
	Thu,  9 Jul 2026 16:40:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 16:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783629623; x=1783716023; bh=UvfSlC15qa
	cnb9Dxqaw6Eb5NUiYTCudXsUpg2HRD//M=; b=RxLo7H4WZDwrlaW3dNS7bTIOgG
	BYUdQw+BiaDD6QvVI2AbJp+w4v/+MEzcNtOfipkkl3DqAM5XMeM5kDgHPSJs6SuF
	4vAOg0+BPzr6DEXh86v1TWPMcPkZRr3506BW5afHzXE73dArtov+V9FTUczJItjh
	ttjMU76d1GESGbQqDSDxmga/FnDQvkXL4xMX3FlIFIVbUu2AeYCof2rEktqGoh9T
	qZpzcAqx0cewFJ/vOPjvhNsA9eQQBpwQEGpn1RmZO2NhO5uE0RtgZHdy6o4B/kLV
	lL+vPAJYTODHejJKx7Bu7k00ZElIqDiarHlKGa2QCWaofaOG8gud8u1hHTKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783629623; x=1783716023; bh=UvfSlC15qacnb9Dxqaw6Eb5NUiYTCudXsUp
	g2HRD//M=; b=la1nq6EbF7IO7DVBNd5ts1NnVTmfcOIPO1gyeC/IxvtfhhZfLU4
	6jyRseny3VaoCQ3NoXheNG8/LVZ3ZyvUk6pj1zzvZw5Vcuef8P+3YLHxCZW9AWAq
	jgxVFOK7YkUIfsAcPz4QsqVu0XvRVupASMhVHYfssgBOpmLb0jlhJrQltsaCir0f
	G9r1nEYGX1i7DJaQFbmof6UAePxx2pPJNvw23C/68dE3OKZ0zpcoH+DrWaWTyZI2
	W3/w2nNqeBasaN+qWe1wZp8Hmuw096AfWaiH2ZUmy1GC8B4wnQpfox0AXxYCFzMP
	bLsj0UI7qt+bVCv3EfshTfsqXgo3aA8+qsw==
X-ME-Sender: <xms:NgdQat3nu0UnKX0XngmgwfHVhDQgTl-mHB09ny6opgIJsqOxpfuJqQ>
    <xme:NgdQaky1vXfKLQFHWA4yJNT2nPTTLyosVpOVn-71d19fDQd4oR4xb84dYSuzkKF6-
    GhgxxqcT99Qtr3RGkXnVX2CE0hhHeZJ0zAwp7-f0cC6HaGDimg4Tg>
X-ME-Received: <xmr:NgdQasFNbb6t-pBsFjlx7UCRNUbqQdY_9kv0kQq8SgIXdcAgBxqpMUBuElxkM-brbPFINpUBhx0QFZ9B1oRbnbiZYxVHK0PJVgrIiSg>
X-ME-Proxy-Cause: dmFkZTGp+yQ25DJ6PlgEbD5thZ8Mqzg47tNHYvWp+qm0hfhFdFOEQnLZkiNEXsRuR0R4Jx
    qJU5Zr2oFcnsOVvSdFA2XzReIT8cbNiLQjErqppcNZO4YaXMRt2mOQyniP7P6WyqA/bzXb
    QqaobRLxWkAweJC7i3zRBee6yZBjwZYy5coPq67+LITJyXXX59zT+WG+MhjBmhTDEPa6O9
    MZI7AT4pgygcALSKmcA/tfUtIbtswDuGjhytywx/pt0fsvdpQjU330/8PPoKeP1IodnuT6
    tHr2sg6JeK88dkohXxNaluDOU9GPbQVSa+gRgHk9CLhM7Bm0b5/g6y4IqvRLaU76BlHZFX
    KA+oMt0xzAoFJr2bIPwFmH197GUjXZfEWjb1tT5SrANC+t6lzXik0DtnwkDbO67NXoTBR+
    MiNA4IRJHNJEd+65vQ2IN4Rhf+gadJYeIXjiZxUn66vgKDs8xrDsA3Q0gDYr5fbLxN1G22
    TJS1w4nGp5Fc0fMs1kP8j9IRxFnqXk/EFc1xUSu8VAFNoeCsZ7wW3ArTUTYT47k3tTo9u/
    yOq4vfW5D4vRKvVwvRIyS3MhCFFKmYdhfaRK/NAqDEb7FmM3aQfDOTvy0OoW2gCRaQuoVJ
    UPc1g68TEUdlC6GQAXjRIVr9kx/aeL4Awqcsko/ZthkFwwS0GOiDah6PDLyQ
X-ME-Proxy: <xmx:NgdQavbgnqapCkmhOozeQNyleg4GQod-nSpKeqYyzPRQ9cnQ68rzqA>
    <xmx:NgdQamAoZdqTWDZGrulh2aKah-2EVNEIqBerroxzwS8itj29tFho-A>
    <xmx:NgdQavlrQeaJ_hHcupJe4qKOSv1ysu0awFNqcpJvPQM4_uk2Nd6BBg>
    <xmx:NgdQavxs9dsFjCfXUehyTRcAICbk0OPikNqCMsShke-PuCT4AJzovA>
    <xmx:NwdQaubUIItn36zmKEuixFgQzJ2V8BVf94joCzbZ3wLNiU9Ivp_rFGY_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 16:40:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,  Chen
 Linxuan <me@black-desk.cn>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 0/3] includeIf: add "worktree" condition for matching
 working tree path
In-Reply-To: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
	(Chen Linxuan via's message of "Thu, 09 Jul 2026 10:41:40 +0800")
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
Date: Thu, 09 Jul 2026 13:40:21 -0700
Message-ID: <xmqqzezzkibu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
writes:

> The `includeIf` mechanism already supports matching on the `.git`
> directory path (`gitdir`) and the currently checked out branch
> (`onbranch`).  But in multi-worktree setups the `.git` directory of a
> linked worktree points into the main repository's `.git/worktrees/`
> area, which makes `gitdir` patterns cumbersome when one wants to
> include config based on the working tree's checkout path instead.

Thanks.

This seems to break t1305 when merged to 'seen', even though all of
them pass standalone.  I did not have time to figure out what
interactions with which other topic are causing the breakages.
