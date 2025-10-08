Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAC2AD31
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934587; cv=none; b=iT1DscXdeFIoBKTAjRxtkfz2lvIaaGPAql19X9mSNt+d+1AW8t810Oy5+Vrz1LKvvCZbw4Bt6zypfufKQXif+USa+5WnXP6/Rbz+9GNA/9RlheBYOUkHMYNG/LW71cIV1qrfghh1zSnTt8m+pWz4ECgyXPWGNj8x/aFDQiEU6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934587; c=relaxed/simple;
	bh=p1VYhpiotpgMQBarsooxC9SwxhYM1rMSUT1TyyuYvv8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tQJKDs/p0njzOhaLknfsnOBOPqvZRTlZ5Ia0zMLfEZnq3aEoaJVp9E4Tw2Sty0w/JIjTh1ynlwWNnOXaLJcBfbU5ifuyZB3bVOowQg6sMg+sFGZCtD99sEjR2/ZtTu99XvFJZWEpHhdZfYxmJBPEOEV47uatTIsUmcGpojEbEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m/EKsV3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cekDSsDr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m/EKsV3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cekDSsDr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B2E71400171;
	Wed,  8 Oct 2025 10:43:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 10:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759934584;
	 x=1760020984; bh=p1VYhpiotpgMQBarsooxC9SwxhYM1rMSUT1TyyuYvv8=; b=
	m/EKsV3gVevWPOakjA5BK52AKpOGTUvpNLoksNXMyuXg4bWTCSxYZ39RHKsr0ZHp
	hAfTbgjq0GchUl+htbFJwxSwpQXkbQ9jyGgUkxzMGtn6aJVmfKI4R6GWTJIVm+Dz
	eFwAosi+R2RKnDdE9iewJ4o3NnRpGs2eMuR/BUZ85pFdeIdeQDEr67u+gIw2Vhtq
	CzwOSG2UE4zMuwz4va/63FuYqTb/p8ZOrYUKpSY1UbU1ZLrjjxMebkksHBy5ZrVy
	DUTkGD/j1ObBFmsDg5swf7FTQPiSYa7mM9swdKiivnfvEiPWwc9xE3/rG8i/iaZO
	DkhRUne2l2Xy0Thj1bvqug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759934584; x=1760020984; bh=p
	1VYhpiotpgMQBarsooxC9SwxhYM1rMSUT1TyyuYvv8=; b=cekDSsDr7RJsoY9Bi
	k1xtVy3hJMuCyUZTZxNV8l4qahXu7fVINHWSVGVE2hVsHOplYwKl+ZO+J7vUCa9s
	o0LbvAh5dqFMTJdc7s8ySl9nxH0omJg4doslqVm1tPhQqS8NlKpwkbpoiznIEtXC
	IRgFbUB0qnnbMrNb48ZOh10z7MfR25qJYYrE3eqvxquIG9lQyXV45i1vPHNsF1ns
	qn0kT+YngFZke7WD6zqYbbEnumJbqsQsFfWswZO3DB6iA1paAedof0DbshbIfKdj
	BRDaNlVmhNwc/uzJivZHkmcGe1y3pCagriKd7zyh0DHEVQLhF83vFHEcj8FkiJti
	Wjrag==
X-ME-Sender: <xms:d3jmaMKO691T06ebMNOGlO8B2yigbgOYkTjQOL2XVYaxTyRZJwLr_HU>
    <xme:d3jmaG_o9NEWb09L8FczWnCC47xvlpgerwr1-t750FV-vdg86ozCowfF4B1j35Pa8
    OLjug8XcKO3dvUVDCfAGVLw_ApyVGIwAEKvt19C_py7c-oloBHabQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhhilhhiphhpohdrfhgrlhgviiiirgesohhu
    thhlohhokhdrihhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d3jmaG0qH5tAbt86gnT7YgXBBkBwZWVhRFhOJt0nBIg_RUE5RE88oA>
    <xmx:d3jmaHBHudaDjRrB9LS8qJMUD5NmxsNTII_0UnUwAIAyxFqPHo_T5w>
    <xmx:d3jmaGeIGMjqa6MFQCdcsKA26d2PXqsuTFW4550CWz-TpK_c4CUAKg>
    <xmx:d3jmaEiJiusrnQIIu6xCtD4fSQE54ZkLg4du11DyJobZ0ZRwiWlUyg>
    <xmx:eHjmaCHaZkdQJID0-sHqV8CT0e0FwRV5ynEAgMJdEYsvkcBoJm4L0QDB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A938F1EA0062; Wed,  8 Oct 2025 10:43:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AS_EA4afeNiB
Date: Wed, 08 Oct 2025 16:42:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Filippo Falezza" <filippo.falezza@outlook.it>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <d1273222-df3d-4e1d-ab20-1a49f1a692bd@app.fastmail.com>
In-Reply-To: 
 <GV2P251MB09937AD11689D3148CD342D8F8E1A@GV2P251MB0993.EURP251.PROD.OUTLOOK.COM>
References: 
 <GV2P251MB09937AD11689D3148CD342D8F8E1A@GV2P251MB0993.EURP251.PROD.OUTLOOK.COM>
Subject: Re: Git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good evening

On Wed, Oct 8, 2025, at 16:20, Filippo Falezza wrote:
> I am reaching out as I am still using the whatchanged option in git,
> which is very useful for my coding and handling merges.
> Please keep this option and do not break userspace.

This command is being removed because git-log(1) supplanted it over 12
years ago. Both commands use the same machinery, just with different
defaults.

You can replace the command with `git log` thus:

=E2=80=A2 Given: `git whatchanged <opts>`
=E2=80=A2 Replace with: `git log <opts> --no-merges --raw`

Additionally for the sake of readability, you might have more
use for `--stat` or `--name-only` rather than `--raw` if you are only
reading the output (not feeding the output to another program).
