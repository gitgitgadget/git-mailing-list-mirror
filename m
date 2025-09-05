Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD01CD2C
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075597; cv=none; b=F9hxTX15yk9yXcomMrCDJBGZyk4yBbz/g5VAxRN47Ahe+/FeOH5OzkJ4hf7SvuDsaR7JaaNAF8fB83Lb6EuodvsModi/CsbxiBcQyHm39JD0acfr24p9BWKb5dexcMr+Hl434LQmpDFXP67+AMmOP/Esiy2deZDfqowQV1nicVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075597; c=relaxed/simple;
	bh=agOsO85dCi3Yo11Y6dCwu/iNMHYLlBqtKSI3Sk8hmLc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LjfXGKhSAWayrV6zFVbDz4tQ/hjpfKIwrA67/qFim6DgqO6lT752g4aCtDZ0KxnLgiXi7DuLbIe1/mtKcIgHiB2r6w3P1fBTcYFuLATczQDUVKNNMZpr+8A7T+XVNbBx0U0DETAo5g/jrARV7KRIgcgVvNoFCjGbqu8z5ez5ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hNEO2q+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYTvO6MF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hNEO2q+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYTvO6MF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71E457A04D9;
	Fri,  5 Sep 2025 08:33:13 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 08:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757075593;
	 x=1757161993; bh=j9wGT61KdQc5WyQLBNPNgk/YcXimFLQYEnhdX77Ae6k=; b=
	hNEO2q+YBXygoCoz8KbeGjAv/+7MTBKuCqFSDCZQTs/UttVecAKNBokKaudWh0Md
	7MzCCraDU8j9kLw95kXAB4RFzFW7/c/Q6KgdyYF0p01SXKP/ugVEEWqUD3tw3VTu
	4J0vWjGzhaS/fiZ4WYW/05RNjf/8UpPjtjGaizzs9aGKS7P2C8uUaq8V/NEj0IG8
	9h0afdLzL1gop7mu8Hhp5mm292Vm9dLVfRG8X6K+Gzl3Txc34V+PNJSLPlUaLIen
	opc83TmJvTLZwerJXFUSf5VIh7plmS3xKZbxp2M108oWGQQ3qKo1VPgZggzPcCaA
	0omtBctwHkBSpWMySjfm2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757075593; x=
	1757161993; bh=j9wGT61KdQc5WyQLBNPNgk/YcXimFLQYEnhdX77Ae6k=; b=L
	YTvO6MF4qpo133upFZWoUAa8hpwH8dXlEu62A6B6za8pDs+EhkWHl/kT3eTfKqr3
	mzqXvGXhUaUq4uxZa0ymaTqvyhVT/usoy5RjUeQ4JTGhIwrMFyjvZPAhL041a4TU
	B/I4PZ1uS0qNexUyrljVOXDr8AdAUv4Yww9Jd4pgyJdESSE4YaxKC/SelpQrUdKv
	95aKsTCFblLWb/JUShP0ygVoZ8miaMI+W8NUnMOJKopz7CLTrGd37mUAFX/0Ycdc
	0pVd1aefrRzzs6oW9Roh+/1gJyGapHnqkR0r198PXTJxzQXbPnSDUSbge8cC5wb2
	ilXyM09+c9++EGR34PpLQ==
X-ME-Sender: <xms:idi6aKNwU9yFyhaLE5OSziJ63-QiJSrSWC1YVJAK_sDkiT3uaRirGQE>
    <xme:idi6aI-D8z7gRmo6TORkei0wQCa7LiFzOsk1BV87dJ0QoAEmtkbelgt6bQBgoEfBs
    y4d9zbzswoU-pzU5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefh
    heeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehjrhgvsehpvghnghhuthhrohhnihigrdguvgdp
    rhgtphhtthhopehkvghrnhgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:idi6aDtSJVcpZho_PYS3TpGBpadv_zeTqwSr9jriaGL69WaMtvpyEw>
    <xmx:idi6aBnCPtBP70DLgc9tZdSQY1YPAWDosQhHkeQIV0zL3ArdBS6xrw>
    <xmx:idi6aFx0I65FfPEh40uDOZXUAHrS4F5hzmWr5gSGtvs8ZYyeUyb9kg>
    <xmx:idi6aDN7rGKpon-exQBiCdGP3WlOj6mfVk_IP-sv8QHerMlUcRxC-Q>
    <xmx:idi6aNIXvqp4FhR0_d6qILO9AWy4i-i__QXq7k8O8paSm3879rQbKRDs>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 11BF51EA0068; Fri,  5 Sep 2025 08:33:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ahw_2eax9Mnw
Date: Fri, 05 Sep 2025 14:32:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonas Rebmann" <jre@pengutronix.de>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 kernel@pengutronix.de
Message-Id: <8e8255bf-79d0-41ee-85a9-d664ee01b5ae@app.fastmail.com>
In-Reply-To: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
References: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
Subject: Re: [PATCH] GIT-VERSION-GEN: Use standard versioning suffix
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

The following might not be immediately relevant in light of what brian
just wrote.

On Fri, Sep 5, 2025, at 14:14, Jonas Rebmann wrote:
>[snip]
> This is not semver compliant which makes the output harder to parse in
> tooling such as b4, which currently errors out when using a snapshot
> build of git.
>
> For snapshot builds, use as version string the unmodified git-describe
> output with only the leading v stripped from the tag.
>
> Fixes: 5c7d3c9507f7 ("Allow building of RPM from interim snapshot.")

For other readers: this can be traced back to from

=E2=80=A2 `git log -S'VN=3D$(echo "$VN"' GIT-VERSION-GEN`
=E2=80=A2 which finds 374dfaa2e39 (Make GIT-VERSION-GEN tolerate missing=
 git
  describe command again, 2006-01-26)
=E2=80=A2 which in turn references this 5c7d3c9507f (Allow building of R=
PM from
  interim snapshot., 2006-01-16)

This project doesn=E2=80=99t use this Kernel-style trailer.[1]  Also not=
 the commit
reference style. (It uses `git show -s --pretty=3Dreference <commit>`)

It=E2=80=99s more common to place it inside the body of the message.  Li=
ke a
replacement for the preceding =E2=80=9Chistorical reasons=E2=80=9D.

=E2=80=A0 1: It=E2=80=99s almost only trailers which attribute people. (=
I am having a hard
    time coming up with exceptions; you can find at least=20
    one Cherry-picked-from)

> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
