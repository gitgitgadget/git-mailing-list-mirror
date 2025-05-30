Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D5228CBC
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614854; cv=none; b=bGMWj6EPDEh5PzbKzWso1Vd523TxfTX2iopM1wzUR//C+DbfA/hSdhD2zkaCmO4wRW2T/5NbDOPdRLuubRl/d5FQAB8I5E8QgThNM815uIq2LyhfPOTD6OQMs3US9ydMNk+GAtTkcl8sKvkx0YovUC2BvUnh0gevXLvt3v6Jwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614854; c=relaxed/simple;
	bh=xS+e8M92LNOSBPkZhWLs3KQrDJEcaZw2mZUN90uZBGw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X3mwwfbJrqQfe1YzHiAG1SIiQyCgIaB+Kw0n0eDBZ2ucyT9aATctO5mNJXHcQ/AJrrKyzFNQJwdIidBQozeW9kfe3G7JDU9NkqwXGntKVmU4U0sbf1s9yUpS+i4NXGC386ne2b5I6yE0Qb+U+rIInFloJ5RJHhp+5ccQP5+J1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Kp3RbA7D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJ6WlgR6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Kp3RbA7D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJ6WlgR6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C1D69254009C;
	Fri, 30 May 2025 10:20:50 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 30 May 2025 10:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748614850;
	 x=1748701250; bh=xS+e8M92LNOSBPkZhWLs3KQrDJEcaZw2mZUN90uZBGw=; b=
	Kp3RbA7DxmlI2+WC4P2xlZkFwFc/D8v2D0lgjVNWKcHW8WZJ6kFC9jTBjzS3aUhf
	h8XWtHOvRLi14C1TTjLmXKIoh4wLyb2QTUKChQ/dAe5xb6ECzOnsIgLx+Yujr3mr
	/wXD+Jxbfi107gOvDHpbn4RVNhf6M6F7m3kS4gvjiXbabRo1pyxPziCaeQOsbq3e
	kT6N3OlpSo65OYDM7P+PYPxId+nUoBLiLbVwKP3OEkgBc/6TSxTTRnBOfkJ8fJDn
	lt6/i+ggOBng+495XecTQ6X6q7LFDcqnTn/LZn+0mx8O6n0llwR10/itAO3AfIcj
	8JBslOcI8tNfVPNLbBuxdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748614850; x=1748701250; bh=x
	S+e8M92LNOSBPkZhWLs3KQrDJEcaZw2mZUN90uZBGw=; b=OJ6WlgR6dHX9tZNLH
	T93WQQq5nzqF/+i0WRnlSlscXAkbVBVIlGXc8DIC6etAqukUHSfgw1S3FkntMda/
	TqbhjRPPyMcCip0ZfgdBuB5VOILiHrqsu5GztBV+kDux5GFrWjg0ksr+3ILdmFDa
	QfvLfAd8Q9C/t/yWx0JygMeD5HAotUMj4hjfXQRmBkkBgj9wsv1BCDPajJAoXoC/
	SPc1jmSLh6m5qQqhUmA2Ifc/4/OKChmAT1IdfKjxyodB3bKApY1kxJxhUP8ncuML
	hbybXpJrStGidRO+Jz2x5cuMLG19bepPLRwD+KeAY7wEqYowsYJP5IF+N7EXL07q
	PVc6w==
X-ME-Sender: <xms:wr45aGNMzX5PBJcyj0LnCOXEDgIjYxMybje37KT9HSdAb_hcXoGmSjQ>
    <xme:wr45aE-URP2AU5I_-_rcfX6Tu6mTbNyMVEMJeW3SHxBKznxss-Owmxiq6C2wFRVKc
    f9fpa-hR6tlfqcr3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeff
    tdffhfefffejfeffteetvdettdevfeetheegtdehtdeiudefffduleffleeljeenucffoh
    hmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wr45aNR3pqX8cOkV9INBrul5kYKRKh30z_vhHg-j5NppfPEKgx0SWQ>
    <xmx:wr45aGvp3KuRIPngs7XsaUPuh-T9S43oxmWtsViTcY8k4no7XI9ADQ>
    <xmx:wr45aOdIrdtzZfBOPPO-4ra09HOhAaVHlB4rHNkyeEYbSnyxe431xw>
    <xmx:wr45aK0wIkBBMoqkMijPOaSvIlrgAUkK3d3OXHQ30hag0Vj9YFwUKQ>
    <xmx:wr45aK961SgBZEZelyZ5gwGT02xh6iGL9gJVBOrHgeeo-kFZPk1ZFbu_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5CAE31EA0060; Fri, 30 May 2025 10:20:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T812a5e6ea52e549b
Date: Fri, 30 May 2025 16:19:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, git@vger.kernel.org
Message-Id: <51425125-0a50-4b03-bcc3-da3942c88b06@app.fastmail.com>
In-Reply-To: <055d01dbd15b$14d4c880$3e7e5980$@nexbridge.com>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
 <055d01dbd15b$14d4c880$3e7e5980$@nexbridge.com>
Subject: Re: [Bug] Build Failure: Git 2.50.0-rc0 on NonStop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 30, 2025, at 14:04, rsbecker@nexbridge.com wrote:
>> [snip]
>>I am not at all sure why this is failing at this point. Compiler is c99.
>
> Looking for help on resolving this before rc1.

Patch: https://lore.kernel.org/git/20250529101136.16219-1-carenas@gmail.com/
