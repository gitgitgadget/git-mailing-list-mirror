Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E741553BB
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189090; cv=none; b=mkGbSnk01pk+ssiTKFZSXMKyt6zMlJcSE2cfnl8wGTjZxMPEJmM9WM6hdKpsA7YnZ8jw3tGuXln8k45moiD2XKUY9DDNHKzXqWVMEdn6kVa2ZQ+qGbXQMYwXa5XqBW4dzPnc2rZwiQVyntldxnEhconQgpiHf0gYkFxdb/S90BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189090; c=relaxed/simple;
	bh=ApJkFfO5R3Ot59Y60Ho6KxTzI7LV+uzzo+AvR1RlD1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d68WHvTrr72Ft6nrkyUOjMYbxdsVEjYZLaSLsTXbTDX6IDsmy1dNGWVSvYPDq8ryXyKNBDwk8zAEEANKopf8p+Nw9XiMDgok+1GtzP0SVlIPRlQw6rv9+CWNyh+c7cdb1/GlmmEvS7z2cNPog0Z0slsVoCjLwrddrGFJcVCffXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uE8fmNlz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2pCuD0f; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uE8fmNlz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2pCuD0f"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B87D11405B7;
	Mon,  6 Jan 2025 13:44:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 13:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736189087; x=1736275487; bh=f4Gqe4jKKz
	RMva2po5VMSykRYblZWe/Ax91+FbSvrIM=; b=uE8fmNlz0gKCoPCxiD/rGulkEs
	nQUUI+HBfZYsnPaBzfhCMmI0r26i9NqDPQLYAmQagxYSS0D77nLyL3ox8unj/9Z1
	oRrzq1drqgHHs/5J3d1Yz5ohrEzYUmpQuKZf4dlv/pyQ64QXxUrp+pd4kqXkUK+j
	GL4ANuJszy5/hvaqSPiy33Mq0iy5/ukBHqTKmnhQtEGOnSpUPxIJqS3r222JF7/B
	knEqpxhUQydbAXFyArZ1K4FLmgI/Zd96h8Gd8WIcGLCp8aHf7GT7u5gmM8G7V1Nn
	FlufqAJtcMCceWsVauOKd9/wZJOd2KakIXrs02PclpzB50oRMk7VYufti7oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736189087; x=1736275487; bh=f4Gqe4jKKzRMva2po5VMSykRYblZWe/Ax91
	+FbSvrIM=; b=W2pCuD0fujtP0NnEBa7EjVx2B9xDAOpotnnYnf2jeY1U433l8xU
	vXW5Pm8jyB1os2IMzY9tnCW6mFHrH/83hoPJIxNoradUEP3zzshFfp258o+NU0AY
	7RW5Ek2DMus8jQ2gp/Xxv05kgn7mJjyIFHPRs3aJOYhrSVxlbVoWYobd3v8rXdg3
	xdJkzTeFDGId6OT9dIyc1udWcC/04ztMltA8IqsSuhd5GzVpZtjPezMSDge4tR0k
	0V2WooRsqR8RxM8esAokd2a/hReSa7A7jTOYV37DvZwFZ9f5f40XM9RlCgDqpr/D
	6iuDd6HZfU8T0W0BwcY5RXQQgK0TlgfN0zw==
X-ME-Sender: <xms:nyR8Z1dUKOKXJp--sBNlCsF_J_sSsVjeeGwZSuCdWFS7Z5ZfgMPkfA>
    <xme:nyR8ZzMvHAFYRp-CKaf9q2zCinb9TeDwWh2FshLBf9hWEG4SK42z4_QH5JjIrTvbL
    ar3ngqT9aheeO6lkg>
X-ME-Received: <xmr:nyR8Z-hCzH_nozz_vz3O_TapaZmm2konaZHSe4sYzHn3cXUrTVzxTCOlV2OP1wzT5VClkUmxYbKbh7Yp4lGyc9L0ZcoCGm6snMr5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehthihtshhosehmih
    htrdgvughupdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehj
    uhgughgvrdhprggtkhhhrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvrhhitgdrphgvihhjihgrnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nyR8Z-9Y2BB-o8-Lpb0wFAPQHGH_a3O_CT7bcHmeeNN8nXvf6ElXPg>
    <xmx:nyR8ZxtcnAZiop9Pm0cco47oZTGAs0vvzdm4-b64bVinq9U66GXPEA>
    <xmx:nyR8Z9EVHh9kX-QBXO077cNIJXbo6qDGQojkruxUkxU782iVeBNNDA>
    <xmx:nyR8Z4OhshSMhdu0eNAGh_4Mb8v7scRsiSFDPSHbCcv-2M-2HOxZKg>
    <xmx:nyR8Z3C1MZTRofYv1erJLCwJlz8dnp3qOUF4WDq7olr5t5XQ2tAGR06w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 13:44:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Chris Packham <judge.packham@gmail.com>,
    GIT <git@vger.kernel.org>,
    Eric Ju <eric.peijian@gmail.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Testing for existence of a remote branch from a script
In-Reply-To: <20250106163636.GH1284777@mit.edu> (Theodore Ts'o's message of
	"Mon, 6 Jan 2025 11:36:36 -0500")
References: <CAFOYHZDQs-mftqLQn5HiFgBWcFN6Z-WDscJt=zVLRyGTo36=HQ@mail.gmail.com>
	<20250106065121.GA8844@tb-raspi4> <xmqqsepw0xk7.fsf@gitster.g>
	<20250106163636.GH1284777@mit.edu>
Date: Mon, 06 Jan 2025 10:44:45 -0800
Message-ID: <xmqqy0znye76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> So if enhancing the git server's functionality (either via git
> ls-remotes or some other operation) is on the table, ...

Enhancements that do not require breaking backward compatibility is
always on the table ;-).

> one of the things
> that I would really love is some way of asking the question is "git
> commit <SHA hash>" in the remote repository reachable via some branch
> or git tag?", and optionally, "which git branch/tag should be fetched
> if the testing infrastructure wants to be able to test that specific
> git commit ID?"

Both sounds like a useful thing to do, but I wonder how generic
these should be and at the same time how common a narrowed-down
feature would suffice.  If we try to make it generally very useful,
at some point, we'd cross the line where we'd be better off doing
"run ssh and execute these Git commands" over the wire X-<.

There are server-side-minded folks who are extending "cat-file --batch"
to allow you to ask about objects you do not have but the other end
has, if I am not mistaken,  by the "remote-object-info" feature?

I wonder if these more advanced "info" about objects you mentioned
fit into the picture well as part of it.

Thanks.
