Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FC38F91
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785967; cv=none; b=bY8TPGthOAm/uQPxhtYgcraG1HsKAMDfmQ46C6MVO1oyXiPFf+YkSKcGs3TH36+G4mgAXo7mjzStzobeBGT9CiVSnvidQEYl0si1Qi3untNWzYvUt1CDtEynoPjQxV7KUqqJr+K3e7dkIC90xEJssI0xvyNs3OipU/ecP1fa8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785967; c=relaxed/simple;
	bh=HK49C9bdW7SacxhS60VtCViRI00RTMOsjaYPTago4fc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pboc2UjhV8s54VSpIR8YcnG3IuZtLljcaF7FRI2SvtZ/ksSaYJeHHVPqvl0mKhq9Wyi6oU4fJ/eAo/185GJ0jI/+sWZNRi12tHiuNLqz7PT0qHYaB5ToxQRQH64mZOTZj7OMWWISSgd91vEE8xr1AArUhJxhnl7Nux4lBo2Mj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YRKmJ07w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZzfyZV/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YRKmJ07w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZzfyZV/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C161211400EC;
	Mon, 13 Jan 2025 11:32:44 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 11:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736785964;
	 x=1736872364; bh=szj+mL5d/Eo6UcCwA/jiyeg9sL27kh13GjBzQf+zprc=; b=
	YRKmJ07wLlbaIgHXPVspkOa62vxMlxUiSjwMsERwLpdLCsxP3UVoFZfNEn5+ITiZ
	w6pwgT7uXQgB7SAB2jMw8y2AmbU3UCgZz6bzp8L8w1b7q8t3tmY1CaYd40ELTO7D
	tbzP6MwG+j71BGtb9xJI3d/ABV8it0pRQrcVJ/5qpfNCqkpbTOGvpqrWz1GXfZOc
	9UMHNUjxGFvMAAbzZknl8rlOON6DS2aI4r1R5kUtuwKLjSHHWhDL588szcbJqqdy
	dSw0ZVHcPqbn1CpR4B3cUbTHvXo57rA73gWesgSE5Peke3CebJWJCoA/FDv1J/ik
	B3qXKqeDGxrI2VAuMo3ylg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736785964; x=1736872364; bh=s
	zj+mL5d/Eo6UcCwA/jiyeg9sL27kh13GjBzQf+zprc=; b=bZzfyZV/+R8tfIsIl
	iQksiJjcG5yjPvlrUcnZ+ddJBh+j6aOxTh+UOR8cRKH0lQH7l6TjJEybWGCz6hfL
	K0IqtmGhBMyh2IvmG9DSjpGxxR31SU+3KmTa5z7yo8quzvCzLn3Z2b60Djim9uaX
	5BMROMWFi+k1/xt8SZQ/qwrer6COZNj9xHqQBK1jp1Sey1xF8+2jzfIjukI2bPCL
	ZQsd71BJxizXcjQbTDg3BNij0+i90nmaJXNtfXFPSrsInWIeDDxOL8H8Z7XhdUWv
	MhOcJAQc9v3fQ02Qbg9zJrEMTGpHLjFYzPb0GHcYw4/1cQzF7dJwpaYe51RnTni4
	pDcMA==
X-ME-Sender: <xms:LECFZ_-9CApjLQjzzINAsUVO7QxX7qv0RzWE6B03HUHgpwYI8LhBq2k>
    <xme:LECFZ7sbdrFW4N0NXbPIg2LRo-HsWrAwzuCPvGWFlcFl9GcnNGG0mVwmVpiJRIb6e
    uYdfwoH5SH5YBVS2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfduhfejie
    fggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrrhgrmhhoshguvggtrghsthhrohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LECFZ9Ao-F0UY4J01xNZwtfLIoIXeqh5bH3B96u1ZsXANA0NTJAr8A>
    <xmx:LECFZ7es9zsQpVAm8-bhlD0tc72Ly8QagFxBXT_GCFpxxy9EH-dovQ>
    <xmx:LECFZ0O4mDSjy6jiDEysgLQBHIJDFnzIbnCdFPwoy0yi2kKcUm9yXQ>
    <xmx:LECFZ9lCPRM31OCEdDtEZz6tGWOylmwhjXmg3BtECVMXRWvmzJr1Rg>
    <xmx:LECFZ-33_El8mR_Fuy9C2vq1EJHX_OYc4cR-i2QzTE7P18YNPMHK2F1i>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 454C6780068; Mon, 13 Jan 2025 11:32:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jan 2025 17:32:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Andr=C3=A9_de_Castro?= <aramosdecastro@gmail.com>,
 git@vger.kernel.org
Message-Id: <5aae11ba-b283-4d04-9336-31d02ff41c93@app.fastmail.com>
In-Reply-To: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
References: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
Subject: Re: Bug report - Apple git
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025, at 15:23, Andr=C3=A9 de Castro wrote:
> Checked out a branch, ran "git diff --merge-base <some-annotated-tag> =
HEAD".
>
> What did you expect to happen? (Expected behavior)
> To see a normal git diff output.
>
> What happened instead? (Actual behavior)
> Didn't get a diff output. Got the following error instead:
> "fatal: --merge-base only works with commits"

This works for me on version 2.48.0.  It seems to have been fixed in
2.43.0.  You would have to update to a newer version.

It looks like it was fixed in 4adceb5a299 (diff: fix --merge-base with
annotated tags, 2023-10-01).[1]  The intent of the error message was to
disallow non-commit-ish like trees:

    v2.48.0^{tree}

But it also rejected annotated tags instead of peeling them.

=F0=9F=94=97 1: https://lore.kernel.org/git/20231001151845.3621551-1-hi@=
alyssa.is/
