Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F921C84B8
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973095; cv=none; b=RMbEyNONelwjF3/qeQWcjYluPBtee3RHWDMv6HJWXXSEFXt2kzUlTBak7MEOsl9gOVEb42o1iZAHIWT/z0WrPHO47dPKMFxCoVLFf0RcY+vmJ8nu7Eh71d+qLNgQ5L/8ZbK85qw3BzZxzvkSYCh7PZrdhVUvfglUMH07nRpkNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973095; c=relaxed/simple;
	bh=O9ccseRC1da+G6wUKCFuDSlZC77Ruh99vU/ERREm1Qw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OkHLeAyelLPsyECsVTkRXuR7ablOVEyYR7hrvpcemHpFQ2kTn5L2RAKN4Ff6lXRotFmYZBSPvDU3vtoZPDYW6DkEZr6n8v9wjbV4hk9shbNR6mhpFitYGbJBrO+MZVweo0WBWX6fhFSJo9vYXWsOUZwSblrQqrmk8r2YbKNbiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Xk8gSk+7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLqz4CNP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Xk8gSk+7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLqz4CNP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B2C7EC0652;
	Tue, 24 Feb 2026 17:44:53 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771973093;
	 x=1772059493; bh=O9ccseRC1da+G6wUKCFuDSlZC77Ruh99vU/ERREm1Qw=; b=
	Xk8gSk+7dKxaLHLa2a5UaR/P8oxwOLN0zVDGJVFOPgarCVy0axfAJm2cK29AmIRV
	j2Kth4XupXGu7Rm56CEyeWz0TlhNHK+ecLMizmAL6CiUaDtSr+8jnl8JOEtLuzvo
	hkMsnRqlCY1Uyo/CtyycujYf1N20L7vIOaxaM1LU5zucp4pal6Py2HrBIT6S6sR+
	c63Pqa4JdDPUX4KecDJv7hNopNZi38bHCfr5lhR8m7oy317Zknk61ZDv1dSJKUpY
	CCHtQ9fDk1SlMmtfjLls9fQUiD18782Kz8zqz1H2Pu5WY/19vLTZRjNbFqP+FwOR
	WJLiRFV2YLlr5utX1Yeb9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771973093; x=1772059493; bh=O
	9ccseRC1da+G6wUKCFuDSlZC77Ruh99vU/ERREm1Qw=; b=jLqz4CNPJ4q8Qfufe
	sn+Z6xEDbo4QWqDh8mx2MFah95uDjbOF2dF19XbNnzElxoPLwkuiSX2kENFwHUE3
	d5wEW11BcomJIKORN8qQrrMmATFuh8/aRIEIWEZ8f2wgEL2B8Tli68HMH/TrUMei
	ZwaHhxjEpJoavi73SGoEmTZQbQu+pZ4gO7YbjrIGuzzt7MQLRNktq8zcDGrI9oN3
	e3YdgscQFfyykbNN2Gg+pM5u57fMb2zcxmGNk0r0YMXztXI0adBVPU4XS0RxacoJ
	h7qvWThuAsP00q1mvF7foPE2JGPJsJphPjU6n33pBT1L/mL7NfrTTRRxbp916fNl
	j56fg==
X-ME-Sender: <xms:5SmeaafRPsk4iYUG3roqc44xQkN9aaWkC4qdkk1c9A206OKZiwJqIik>
    <xme:5SmeafAhnhPo49Kq4YVA3yW5e72VxjbyhVkDTYwFr5gYuJtMZxAvmhTrZtTOOgjHT
    8jtHnMvhrpboZXz7Rd4UvNp5E3IiO4sIRk7XGdFTh6rGbrnuq7-VjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepthhithgrnhhirgdrshhughhirghrthhosehr
    fihthhdqrggrtghhvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:5SmeaZLwjDFpHhzkRUf4UDc5-Zm0zg-QiKM9CRffVQ8KqEpg6MrqhA>
    <xmx:5SmeaTHjl0NMjdufLwr0RJQfGThec2GaC1LMZeZVTLdRw0-hXVWxlQ>
    <xmx:5SmeaZQ_vBZUBIqJCqV1auIBkBdy6lvlwODd1v0zmQbbtmNBw1fGaA>
    <xmx:5SmeaXH1TWGp5c0tA2JEg7zUAJBQ9-SG_1gBrM0uwSa5T_fya2VL3Q>
    <xmx:5SmeaVdFhY7Lobvn9sh3bKNpxSyaUGzbQDll0Pf5BflLFc4oO9me1VrI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E49111EA006B; Tue, 24 Feb 2026 17:44:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXazdfGPY0gV
Date: Tue, 24 Feb 2026 23:44:31 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Sugiarto, Titania" <titania.sugiarto@rwth-aachen.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <b743b7fe-5f5a-4906-9ea6-0755acf5875d@app.fastmail.com>
In-Reply-To: <14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
References: <532e9d58b905404fa625aa59104ce8f5@rwth-aachen.de>
 <14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
Subject: Re: Feature that allows the user to merge only specific files/folders from
 another branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 24, 2026, at 14:44, Sugiarto, Titania wrote:
> Hi,
>
> I have a suggestion for Git, which includes a feature that allows the
> user to merge (I want to highlight merge here, not replace) specific
> files/folders from another branch.
> I feel like a lot of users have spoken about this online but up until
> now, there hasn't been an update regarding such feature.
>
> Might be worthwhile to consider?

Why?
