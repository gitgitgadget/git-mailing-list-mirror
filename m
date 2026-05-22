Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DC409633
	for <git@vger.kernel.org>; Fri, 22 May 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462768; cv=none; b=fRfDILDIHB/9y9wiEbYS/5pp/LpcGD1qgufqHmDpHk5e5pedkTj6NydHlp5PJFjr63sL/KC/Su1djyZL99YY3T+xAMzPDyfXMExTkA+RAtTkiYgIHhVVWJtVCP4RgVAXira4BctpdcbKTeV6D3B6t/Os16U/XiNbJIcJGKDpzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462768; c=relaxed/simple;
	bh=3t2pBW4scT8W/iyNY1pxPcgS05MhhrAVXHG5DT392wg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mXrxHz49ZJM6UOaV9m0lDJDm+UzamlmeugL56J1BtUPkH7mPZ1UF2sn8OJulAOz6qBGEdhK13NITbJVRx7lxuLcizUaRkNmeQl9pOQu8cV5fY6vcnFioWWjMrDpL4KeKLOuBgPz0rSVP7teTdLujemEVOfQr9ykXj3wc0u7uer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LwxsANrG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NXBpiVtA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LwxsANrG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NXBpiVtA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 898BF1400056;
	Fri, 22 May 2026 11:12:43 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 11:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779462763;
	 x=1779549163; bh=3t2pBW4scT8W/iyNY1pxPcgS05MhhrAVXHG5DT392wg=; b=
	LwxsANrGIMZFj/9/cev9mY7GjGc42GmzGkKIhbtSfPiL5F6ghgHuXb8YjizrvP52
	Myb9pQ7v2uVx/B8ZRoQyJWu1h3TaqdFzcpLwQVu56yboRK87tyfT83/6qM/Tk1QN
	E7eZFWnmkXoqGDh81lugRsLj75+5ACiy8Nb8m+A2KA3Iez0BDwoRvK8HszoLp4r0
	a4o6ZgAAe4JUihSR08moqlfKjV6v+PsIeRDFrV9XIwzUprqB9aDoNuE8ajzAn9o7
	ECdR64wIKDC4Mhi1QLa/dpPTjsjuf1lgBIDqE6ap1qdTbNWUwm2zHzRcF18NpgXi
	JuIsOw780HauRYpWZrScoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779462763; x=1779549163; bh=3
	t2pBW4scT8W/iyNY1pxPcgS05MhhrAVXHG5DT392wg=; b=NXBpiVtAG8+eOa+tc
	1YRud6RJmOoH6ipgXoFv8hy2CQiQ6lVg+oadIOzZuTyVR5CzGB/V+YehvzG08PTW
	9w7/Y14BGRe7ORwFJn+PYz8fC+kUInSVcdnEGwSjfiCVMCK7lvLgIso+x2xR0fuz
	/OGjeR/EP8oZivbuYqNKqXjV1tRG9DvbQ/yDpgpymD4UPknDiIf0Lr1l2uMgVZCx
	Jqj/rDoys0eN0ycCMJ5bOmw5VpIgN1ZGBk95kCvnYQP5c2ZpJGZ8b64QPZ617XI0
	Dim5GcR1uY80FtXcy3vRfzyQ9lseADbVssrmOJxDJqpEK0L4YR+DHNgps7H+Asmq
	tMELA==
X-ME-Sender: <xms:a3IQakQcztYua7-2mPHVTMJ6enI-Ecl2km_gBh11O-a9WHGmJl-LP4w>
    <xme:a3IQasn0ZYUiBT91gxwgZTL6715AQZkViua-Ej-hL1w4WWvIyA69YbdICeARpk0OQ
    f62xQcMB5xwigR_Kr0GfLzpi2E_DiEelU16F4eOZvN1HsL3Dbj_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehfrggsrhhitggvrdhsrghlvhgrihhrvgesohhrrghnghgvrdhfrhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a3IQam8cqHDCvfxrFWr_JDUF8adOeGqwaOUMvqMmku8Z0KpV-LuO8g>
    <xmx:a3IQakoeTqFbcA0i2ZdDow7Upqt4A1oIZHBFIUHl6yK2rsMWdcR6FQ>
    <xmx:a3IQajnfd9__78OabUJCTwH6F_gbzkFsiFTKYucgPdXeXksRjBotgw>
    <xmx:a3IQarIsu6xKb2hi-zy5s35Yfs36Xc5gy4F5a0_Bm3zoX6x6yoNXPQ>
    <xmx:a3IQalXdzO_OCzAkTiutJzdCG7ILolMrj5M3Lc2G4dX8CSr9ZzfNEuFf>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4655E3020088; Fri, 22 May 2026 11:12:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApeEllDEQus-
Date: Fri, 22 May 2026 17:12:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Fabrice SALVAIRE" <fabrice.salvaire@orange.fr>, git@vger.kernel.org
Message-Id: <b403477d-5587-4afc-bd02-dbd207c22e67@app.fastmail.com>
In-Reply-To: <36eec9c1-1d2b-4cd1-a64c-a02936d8a2ae@orange.fr>
References: <36eec9c1-1d2b-4cd1-a64c-a02936d8a2ae@orange.fr>
Subject: Re: Why do we need to wait 1s between a git add and commit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, May 22, 2026, at 14:28, Fabrice SALVAIRE wrote:
> I wrote a Python tool to dump a wiki to a git repository, that does
> basically a succession of subprocess calls to git add and commit.
>
> Recently, I discovered this tool doesn't work any longer and that git
> commit (2.54 on Fedora 42 / 43) crashes randomly.
>
> I cannot explain this behavior since my code is trivial.
>
> I had the intuition to add a sleep time of 1s just after a git call, a=
nd
> it solves the issue.
>
> I noticed for some cases that another call to git commit were
> successful. For most cases, git fsck and gitk report issues.
>
> It looks like the state of the git repository was not yet completed
> before the end of the git subprocess.

This might be caused by git-maintenance(1) being run in the background
without locking? That=E2=80=99s a new issue in Git 2.54.0. See:

https://lore.kernel.org/git/20260509175249.GA2336928@coredump.intra.peff=
.net/

The following script reproduces the issue on Git 2.53.0. I am guessing
that your script does something similar? It depends on how many commits
it creates in a short timeframe.

https://lore.kernel.org/git/20260508180341.GB737125@coredump.intra.peff.=
net/
