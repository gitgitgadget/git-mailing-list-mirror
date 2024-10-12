Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE907F490
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758136; cv=none; b=mj+Ct0p+bCrZOM3wLcv2AePCpi0eos7lj2Pmqo9y2t9VzfISUXgvQDri4T94VZ4NbGXemF/3lVbbKlk5DWkKzcixtWa+SMlElqm3zf+jG+3d5wi5bTlSwdqVLSmQPvayKaa3d2sMgq5lvDdCvdHgCep0llGCc0772aBvKR0wMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758136; c=relaxed/simple;
	bh=kX3lEgaUZqzCziayr/hT59eLI/jnB8oPu5jWe2NarE8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=moXhggAS4zZjXJqt56h6FI84s0cEYmtnncxv6mxo8gGBx2pfw0ekH0rbMo2Yy2EXj1Er1jY3cveR93aK1jDSV5+xxJSceA2CzFYX8jUMa6Wez7GE0fmvAiYgJvh1/rUr49cxPNiyAz9xwmk0u+Hk3qiaMeMukhWxWXKpU8+heoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VhhILkkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzmybOVH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VhhILkkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzmybOVH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D101138022E;
	Sat, 12 Oct 2024 14:35:33 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 12 Oct 2024 14:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728758133;
	 x=1728844533; bh=9dSXQN59e16Sxyd+NhgqpbOW24sceMi2qGqLPT0ngKQ=; b=
	VhhILkkUA+axYcijHKaIUjg+t01ZOJ5oeRSUQV6sUSaTViD2wLKLaxkVfZOzajXk
	pxHRjsSkc2utHGmyHl37A6lO23P20hcJSmM46DCJpzL1VyHqB8TRlxvYTgmXBjMz
	W33Dkcukz4anDktAjddheNk/OK4YBQKjsKalLDGiwM6TS0XlLhvnYWt4ycgO0TfC
	N7UHKN2nTXTLed8Zoo1yOb7Xj+Uv8SMXClryPhsrMV8+ruOLbHxkvTEgd7AR7Vco
	AwFTU23ainhHANUEWUbuqjuEKCjnAXHLbXixp+eBgAob9p615pTxHaPxtYVMUyVA
	23bnSmI5UY87lo17X8xrPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728758133; x=
	1728844533; bh=9dSXQN59e16Sxyd+NhgqpbOW24sceMi2qGqLPT0ngKQ=; b=X
	zmybOVHvGXZ8WFVnTKoR8ZSjGHcjuY2jPSwait8ESHNc/oYIMhp626xyUMcFlrC+
	J3MCEM5vrT8HTo0AT21cNbMBGcXyO8eZitaHBPTlfHuQ+hwIOUkCVOieuYp8v17t
	A7M5O7wstqWt4vb2PuxEiHjt2DVMDxeY9Lwq2mD5dPudbgw2Xn/rkeHRqY6As6q4
	qR/ONbgHxwkkUcCy3AjhYe4cOR0e8Kh/k4o/+gbbL6xIbfxgpg30fqJV5kh6QsHb
	a4yTK2+X6tGiPE4qo2HeSuI1Cwa1hDDeJ7vV6aXUnUrNi4zGy29HDRNEfGoqxTEY
	F9fHgUoFj1o+AlLqUa54Q==
X-ME-Sender: <xms:dMEKZ1VXkmlRmH3F2_LwUKLfvGHGNYdyHluOqby9_yLnk9bFG4ge0hU>
    <xme:dMEKZ1mpF-68Z6pb_94M-MAhmvqCSFe4Eh2wSilQjQZsaUc7QjzTpNvcwsC_c2H5j
    VT087nS223VZSD6wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhdouggvvhgvlhhophgv
    rhesfihilhhlfhhrihhsrdhnlh
X-ME-Proxy: <xmx:dMEKZxZppeWWrvr3GzBe1kF8X5YqSOGxq1iPH9SjCInkM-hM7JbR5w>
    <xmx:dMEKZ4XuAp0IiIZlyo_8ROzonnNhV6OUS17BWzBaWwgEC0QhRsJn8g>
    <xmx:dMEKZ_nQavETyevEkhcCF1ZjmNmaf7tFKqr0YkgB5BncepTs3uPqvA>
    <xmx:dMEKZ1dMrdYghQnH3OQ0f3Eovn740ZEV57vgSs6Y7WlMhv0WZJejyw>
    <xmx:dcEKZ9hF_EX4wDzh9IPUg0ibQ8K-Rqm6-AkdKnVRM3CUnCtgsYM4-TIN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 963AC780068; Sat, 12 Oct 2024 14:35:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Oct 2024 20:35:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Taylor Blau" <me@ttaylorr.com>,
 =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Message-Id: <d2aeda41-84fe-4ddb-89e2-5cafbbb213fc@app.fastmail.com>
In-Reply-To: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
References: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
 <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] diff-highlight: make install link into DESTDIR #Makefile
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024, at 19:30, imme=C3=ABmosol via GitGitGadget wrote:
> [PATCH v2] diff-highlight: make install link into DESTDIR #Makefile

What does `#Makefile` mean?  Previous subject had two of these:

    diff-highlight: link to diff-highlight in DESTDIR #Makefile #diff-hi=
ghlight

--=20
Kristoffer Haugsbakk
