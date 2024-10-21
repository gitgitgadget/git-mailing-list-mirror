Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347A1E3774
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503754; cv=none; b=riFkOrW0OyIGb1Koblwup3ax3ae4cM3MUDZ7KvcBEkPFilUFAid+1syWr0rD63VXb3YcKSda4TJjrwC/Wl/B4MexpR2O08c5bYWafsTIXWHIWXFPpzxAc38RF9J981S4zCkbIFsdi5NuHx1VV6YHwpoGQGfbTv26Kqlmm24MyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503754; c=relaxed/simple;
	bh=6JEK0KLxkJEZsd/vzSFgNYeyTn+VGz+pXRlYGTRSMAQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YLDWI9mk91ya507u2X8fxhs7JZ+tuCNGNVHKV48ptzl0nUC5iGQanuan2iZ5xJB11PBCmEzfgbwVyNMly92HPs69AEEesiRnTz4r/KzcE10Y2eiltU51gfPBLUVEXJc5ZsxkOdyuSFgbQIWG9BYtSNAKU6jdRP+TohReu0/H1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RUP18eUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuYD8jXo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RUP18eUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuYD8jXo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A47C138029C;
	Mon, 21 Oct 2024 05:42:31 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 05:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729503751;
	 x=1729590151; bh=6JEK0KLxkJEZsd/vzSFgNYeyTn+VGz+pXRlYGTRSMAQ=; b=
	RUP18eUsHHh2aN/86FO2XanvD5PADC6JG6dy7HU/IlHA+QXr7mccyEkq/4ohLxEw
	wm3ckTGLGfe7M3cvbdUY7nu+MS17+0dwVaOMY0TCtuedPEVudrlXH09/QtVvHDSA
	gVTlEMpFiSgsM+V/afg1ZORPk4wuHoN4R5hG/YarkW8XUOny11clAPhWmGTaNGsW
	b7yoGuKIo2UmgUYzT+fmCKDS9CylFsStUQfsxGdP9CGcFbQLxhVDKMAWkUGYpgwG
	3sCDu/NPi1FBz2qnqeMcUJgQmZlmxyKWvYtGOjPaTSlLdQ3dWdVurRHgIJmSABWl
	xzXTNkiqZnDUaNCdlP9qGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729503751; x=
	1729590151; bh=6JEK0KLxkJEZsd/vzSFgNYeyTn+VGz+pXRlYGTRSMAQ=; b=f
	uYD8jXoOmtRaSI3L6a3kBINawdqfpV6gVpUCLlNjqFR46Nd5Sm5KtUc1oPvnGH4l
	pqdKX3+j9qeRkgcU68SSANhRSvu7TQnHe6q5v7oWSLjRd66MDAGrJPvLCNKUFJAL
	DsE5F2Ygv6XeSV2fpZgbQ3u2URQhPSia0S/BUbFvzzYUwEcGkFO4M2yifmkU3Y0A
	e50mqupg4kePWUJAEPXiHQtTa9b/kWHKnEg24fMoKy9ufpDpe/g8XjoY1BHf576P
	DyHd1m9sjmw3DgqNYLfuCwLpRtkAqDmFh8gBw34ws4W9uO8WzuPzmmg5oSB7KsgQ
	OPf0yvI98AVIm+FZKkntg==
X-ME-Sender: <xms:ByIWZyqOzQKrdtXURHX7GvriInpOIoQ8Zx0jk2IXVFdPFNvqP3Wr37U>
    <xme:ByIWZwpg7aFxFcDmZmYAfqMXPHHGmazzd3CfiMaq71K4_KtaXe3aHDogZHI_eIw3a
    eCFHKWLvX7yYw58ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:ByIWZ3M482LTzUbBgrzY4FL7MjOSuHE9hrCucTtLbS2wIv2YIRUBxw>
    <xmx:ByIWZx7HLa989MUX37EJy0z2qYIV9e0cxtep-lkGgoEU5FX1TIxhhg>
    <xmx:ByIWZx6AToellA6zjgDKxHgVnruBwqzLKftdq-agqrl5KgIpsMrSkg>
    <xmx:ByIWZxgdFsT_RE9L3zvz_DX1x-SQsBtGm1JCaw-cHHxkdujr46d4qw>
    <xmx:ByIWZ7kNDAUPDW0UACt1atE-PanbhTR8mPgTtASMfmjB1LNNy-9ETsoa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 20E28780068; Mon, 21 Oct 2024 05:42:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 11:42:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Taylor Blau" <me@ttaylorr.com>, "Toon Claes" <toon@iotcl.com>
Message-Id: <fbbcea49-82aa-4cd6-b288-88b9e95530de@app.fastmail.com>
In-Reply-To: 
 <cb4eee37b4024a451a385f94ad57e7278e542de7.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im> <cover.1729502823.git.ps@pks.im>
 <cb4eee37b4024a451a385f94ad57e7278e542de7.1729502824.git.ps@pks.im>
Subject: Re: [PATCH v2 03/22] grep: fix leak in `grep_splice_or()`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 21, 2024, at 11:28, Patrick Steinhardt wrote:
> In `grep_splice_or()` we search for the next `TRUE` node in our tree of
> grep exrpessions and replace it with the given new expression. But we

s/exrpessions/expressions/
