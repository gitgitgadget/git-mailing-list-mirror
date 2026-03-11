Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461473B9DAE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213515; cv=none; b=kptxWUOdjuGi4rMCc63855Q/8Avj/giQY+HVSDSNcBYciHx1EPiHkKrkjIYQLVlCno5qgrcFzShFT03MPBde+9lDnC6pxMsayDJTJ9GW/6CF4OOfBcR/pPssMhqODmLBYL7zthBdqQKvE24u8jy24QzcoQ5M9qNe26LxgEDffXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213515; c=relaxed/simple;
	bh=4Gp3QlBemuwFBJfPGXmmRA5EiJHTO0YqgMEI4l/h7j8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BobkrZtLmD/mikIN5nAYdZF549Fan9mIOHxHh4DCmt63wASXw466tOxd/iSsr3x2Lxc5LiJ00XEkRkXKW6jMZZZ6UOk7EfgWU2fGiAM0s2kdF+IA76vKgy8DfbFf9nZZe4jCQATnuYZgpnBlwS0s2RhUtVzCO7xM8pkKRCnrKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BuHIKccn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HFDvh/qb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BuHIKccn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HFDvh/qb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C8081D0009A;
	Wed, 11 Mar 2026 03:18:25 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 03:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773213505;
	 x=1773299905; bh=4Gp3QlBemuwFBJfPGXmmRA5EiJHTO0YqgMEI4l/h7j8=; b=
	BuHIKccn05+FNgCqbGWALlpFdNx0c61Pk919hTbbBQDTgAGRRtS2Vq1Wg0otypUJ
	TSJMbhkIR7BVDCFgm+PcDqjQ9OXnOPypoRvjWa68YyRxl9CPvqRBHBjlzGGaecE2
	QkM/KXPAGr5dP1VTo2ryP2ctMPNPH5m7ohrdOKCF4uqlYxEPKjSbsl8ul9PCbOwz
	u59IuUmB47YbpSN94ce+amyALkYwd2Q+Ay5CRggUfnADHmb2FICZxY3JiHoPgL1l
	8K67BDZViKRkypKBlo9ZOlRltQnNQ5QD3rVyL8wRyaRPcMh6G6L+h4s1FqXh/Rcy
	e/zKv11x246+PtRbhKu8sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773213505; x=
	1773299905; bh=4Gp3QlBemuwFBJfPGXmmRA5EiJHTO0YqgMEI4l/h7j8=; b=H
	FDvh/qbfh9W+LITyXsJEAqo+m9ieqd1t1TvP9jIoEObE7iyTR4vxD23ASOFPI0Dn
	LF/2Sr5J5eTXGewZYOfry8RDThxYWlzR66NjSWcNga7y72leEy+yBRGRylgG8SuU
	VmYWz+jpgvsIZI/3BIfoDrAj0759aa4+sEBN0pRJQxup+7OGFZ0Bq1DZcMQ+OwXj
	0c/UvFtXpUn/f6PGxKHYngyvkIAH2UI8I3dHF+gAEJPu2x8EHZyeCIo+rdlGVI3z
	EfHg2n4pIdaZ8k7rDplfLusqiKnOmjJEbdgyggBXCDjjJ3GwPtuilsH6TxrjhRNO
	OSx6PitwfOaTo/3kAMR7A==
X-ME-Sender: <xms:QRexaVm3D0wwDODFntghWD7nJpCfwLWezjj1HFuMqOKDRDb2GmHkIwI>
    <xme:QRexabraBZG9MidcL62aehdjUcrPJjZrhYNCHgA0Cy2hB6-PupU3Ucsti6WTqt1bT
    YiutscFvA8uA-CXO-E1XDAq9f0z1EB5m5Ap6gnHlTBqiG4Nj4lbVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunh
    gvlhhmrdhorhhgrdhukhdprhgtphhtthhopehmsehgihhtrdhsthhrohhvrgdrughkpdhr
    tghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntg
    grihekieesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:QRexael3fwgbiVTKtscJ8m_vRF9cMPJLxITco2ovEhbt4_VOZKkjDw>
    <xmx:QRexaSZLmTRxxjho5DwzxsD2vxRHLSJoglBIoBbC_A1Ew8bxeeLVNQ>
    <xmx:QRexaRFcd83VfAzsx2orekYcRP4oi6_iTA3NY6x0sZ8rv4BrJe5RrA>
    <xmx:QRexaZZ6qobKVe4AR7ZfgXflHm8dtchiGiM0uI1jxgf2i41XFxOomw>
    <xmx:QRexacm147d_ybB1m3vhUsVUL_69E_-SEUG5biwz-lBFhMmSkZpY_Pnp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 148E41EA006B; Wed, 11 Mar 2026 03:18:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Adl1l9tAOWUZ
Date: Wed, 11 Mar 2026 08:18:04 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mathias Rav" <m@git.strova.dk>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <4176455b-87a5-4b13-a3d0-fd35b51cad37@app.fastmail.com>
In-Reply-To: <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
 <abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
 <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2026, at 07:44, Mathias Rav wrote:
>[snip]
> Signed-off-by: Mathias Rav <m@git.strova.dk>
> ---
> Thanks Karthik, Patrick, Kristoffer and Junio for your feedback.
> I've incorporated the sum of it all in this PATCH v2:
>
> - Check !repo before object_id and add a comment
> - Use term "linked worktree" instead of just "worktree" throughout
> - Use git -C instead of a subshell in test
> - Remove gitk's quotes from the commit references in the commit message
>
> As for the quotes in the commit references, I use gitk's "Copy commit
> reference" daily and am personally used to the quotes. Since
> SubmittingPatches seems to give equal preference to --pretty=reference and
> "Copy commit reference" I didn't think that the quotes were a problem.
> (I wonder how controversial it would be to remove the quotes in gitk.)

Thanks for this explanation. I was ignorant of this Gitk fact.

>[snip]
