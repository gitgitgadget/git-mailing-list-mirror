Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6A72610
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290829; cv=none; b=RlBIuylD+y3DTJasUrCbGGoa8UxstRFfsb3bjbST/66DvSoEK10BDdNen80e1D7W5tKK9q3syD8vDR+LdbFS+ycRxG+u4f3Zr8t/ddY85PA6f3mNSs1QWHYVUPyJMtFFxTFqXRBPYzJFOsoxzIV0TAIBUKf+b2eR8uOEk4Nfo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290829; c=relaxed/simple;
	bh=QuRwJqUIQY2fagyKvtb6t2eDxOCLFHtrYHdJPI6MGLg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n7ROb683m9DVZNKpfW6/agm2NAqKS7+RbOHVGhXngiTcFnpF1wed7HuBDgeZuiSWTPTXXGngjglX1GQU8nIYEW3W5edfZOioC9Xwqu3J+l0rgreAmz8rXPrAxkUxnXJj2CXfp95BpSELTsJ8LbvEWXgQEg27FphaE3jylHbkoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VvByqfml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+K54EA0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VvByqfml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+K54EA0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 578621D00085;
	Wed, 27 Aug 2025 06:33:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 06:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756290826;
	 x=1756377226; bh=QuRwJqUIQY2fagyKvtb6t2eDxOCLFHtrYHdJPI6MGLg=; b=
	VvByqfmlQbTF4LrauhrkS0D0jzP20VHlonYBtBy/yCbG94IXl5ckkuhGIuzSXU53
	rGC9q/mlwwQJ16xR9w+8T5zoPpplnEh1NwIlzBspjhAYFrpaILxHU8qS4aCwOBhT
	p5iNvoaq3dJr2hON85lN7qcL88Z4m2UMgcaUGKoYz46F/ynfjVvR8v6du2FYPodr
	oelKTywjuItEM33pmDSeJn0wSu8YZqHFwN+6Zl1tyMjGvz+B7WlKbDcn248V5E1v
	Umyb30W/Os69d/FzOD+SpD3cHBOEgy2i4nRLtBEkA9ZTcBXwXbhikCMGBDTiiqxd
	QDLpAcaeW+/8RNvmA00PoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756290826; x=1756377226; bh=Q
	uRwJqUIQY2fagyKvtb6t2eDxOCLFHtrYHdJPI6MGLg=; b=d+K54EA0kmZQCoVFR
	xTcG5vjKwsiM1gFTLzFAOsjkG4Rp9zGwWcqGED6m7oQzc0hm78bVil+z074JZuRo
	2n45FPOp1aBLp/67Cs2EYvEP1U4ga3imQT2GSJfZfd/wu4kPl37d46OfCoLGVw2L
	OS5Ov2Ecdm+1J0id+lv2dkLQN/v9cySqNxqfY276Qpdhq0eYo91bzO3XodX2n2N5
	uL28VcqKJGK5TcvUarCLZ6DzTPE0fWBpp8b+Wlv5vxRA9RS9oSjD1FmWi53vj2R2
	DEiK1wZ1FaiRgEs0AWqVE6ptptTkwhpSzaFxZusX7Mzm0WGY+N1pFvVwxxPiYLnd
	d4PVQ==
X-ME-Sender: <xms:Ct-uaJyjEAq85PsjxMO_lqFwyxk3U4VTx1SKXoQKrpsd2r0zQoUMs9w>
    <xme:Ct-uaJTt2Z8CyzgqA7l9FX9fbye-EEuRl1R84XyrDgoAwocLK6I6P7C8OTQGqA1mw
    M2Wpq9Ny_o08y8xig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelueehteeuleeg
    jeegffdtgfeiieevueelveekleevtedtffehueeflefgveehveenucffohhmrghinhepgh
    hithhhuhgsrdgslhhoghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhhpsegrsghtihhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:Ct-uaN0nnv0LiNiWP1xmcOmD4ovI9OFygiA_Xs4tx5Vfemvtgjillw>
    <xmx:Ct-uaNAEqmPAykcuwtln405oAt-9CCwSoApAaAmZRfuGlP1imdkVHQ>
    <xmx:Ct-uaP3XDp2oSGFjYwXuyZNGuqsk4QWP9BIYAGfd_HMNQC4BYO5Uuw>
    <xmx:Ct-uaHv3L5SvVakZtUopPxVGfl4nJ119AdVbRQSts5cPKWQABgAnFw>
    <xmx:Ct-uaPdycoy8LQ5fxS0Wavxni7d0k1N7UoSdzDcpljeaqjTNzrHr5o_K>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA1461EA0066; Wed, 27 Aug 2025 06:33:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAZOnxJ1Pc8V
Date: Wed, 27 Aug 2025 12:32:56 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Rune Philosof" <rp@abtion.com>, git@vger.kernel.org
Message-Id: <a0c393df-a23c-49e0-8985-4748e1769a62@app.fastmail.com>
In-Reply-To: 
 <CAL8J5gbKu7qB8Byg82CGqtrYK0gm4gf5V=qrc7npzAoF+kAXJA@mail.gmail.com>
References: 
 <CAL8J5gbKu7qB8Byg82CGqtrYK0gm4gf5V=qrc7npzAoF+kAXJA@mail.gmail.com>
Subject: Re: Feature Request: Add comments to commits
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 27, 2025, at 12:29, Rune Philosof wrote:
> Git commit messages quality is very important when you investigate your history.
> Often it would be useful to be able to attach comments to commits
> messages for instance to add forgotten information.
> Those comments should be shown when `git show`ing a commit.
> Could be implemented as commits that use a new field to link to the
> commit they should be shown with, along with some index to make it
> performant.

git-notes(1)

> Services like Github that already have comments on commits and PRs,
> could integrate with this to make comments made on the platform part
> of git.

They stopped supporting it in 2014.

https://github.blog/news-insights/the-library/git-notes-display/
