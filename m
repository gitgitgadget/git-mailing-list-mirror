Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE06350A0E
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289720; cv=none; b=nhSA52aHTvzKtL3OIuPtPo5emCMz+91hS4nEPn45ltc+wxeHVCV4X/pth9p6prbwwJ96YE4E8i2YCdezxfhpm9ABSEmpmp6b8oNyIRiGTh3p559F6/PGUhRgWQyeZfkRo8sg6xK4UYErwKObfRbj7DGPvoPpuVDHxNLacW0acZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289720; c=relaxed/simple;
	bh=42xjcDjvvq/MQ9fkCkdPvOFy6/mv5byKZ5aupKJ9Z04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBOL3ektJSOVNeEGqIE1yRJhb9VZFejRmrwFDeo06bsZIYtrVxC8zabfpKlCN9jQ3Cj1Mwi0S8E49XGs88rlhadgvl7jsATPKp5gOobipAPDJ1vbjJXC04TOV3B45e3mdd4TAzaQqEd+/BUQvR1cLvdsRQQzXrFM01wUpRlXQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vu8xOU03; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0d+ObTAH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vu8xOU03";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0d+ObTAH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D54CA14000C0;
	Tue, 13 Jan 2026 02:35:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 02:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768289707; x=1768376107; bh=qIvDdN9V4T
	hRdyqnvr1+ik2QAg2AOBuTIWtDp4m9wZ8=; b=Vu8xOU03M8Rqr1KyyNvDXWz+sD
	eCIa7Z1ubCcwz3wiaD8B7Qi81bzj41KAjEwWJJw1wZNVd4+SyWwQ+6QGZDuAni6l
	2/12kAs0tIcsRHoJ2kqZcLloGFs5I4TNBLKyXjrFav6Ur9hiE8y2g0fPUPCxc/uG
	ty1Y/MazTboiXXavCShBWZkdvwgzE/zlX976lKdQyidG9DJfydYgCrNitv9KHSG1
	Z0I3l2Ak0FZHKZaqlkgXg6w60UxxrwG9w/ga8bEPbk6iu+T2LGCKUOAetOlrlMHh
	vi49IEFL1UhVE3FYo8SqAFAuak8V+Ip2+whPZqRyfFw/RkOfAs+fcuyfSfVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768289707; x=1768376107; bh=qIvDdN9V4ThRdyqnvr1+ik2QAg2AOBuTIWt
	Dp4m9wZ8=; b=0d+ObTAHpH8p2LMDPRczgoQdfJ9a9ulVQuPT1grumy/Dm9p8Ii2
	oFxfNiQSgh+DSvSsisiclhdqwpeKrToIH9WLlf9exQKw84BcOAACbD0Qk1CPrOOV
	fCcy3bRs2safh6WH3uDz1flCk2GlCfl3hGPAWaXQO1t+L2wMpWDo/GUuiAL4er42
	25WDRUZFacTMZ7rnMjgz/EVrMjklOMPwFRkfE3WSvp3CKnjotN2qKzUkPPzOJ4xs
	V70g6p54PnG9yBHDkxxoQclcMFqSRM2g7lJX1dFBAI+OHdrkD11Rh+imB7V/X6sB
	v//CRjzX+VIIKRfsNDWmKH1fENtSVIjc2dw==
X-ME-Sender: <xms:q_VlaWX9i5lQj7RO8SarJXDbFAeVD6zYPH9x06dLVKXd1bC5Kydkxg>
    <xme:q_VlaZlijri-aHEX746XJZEYqp3aBiy52xYZjgJGKgqHyZunB1IgadiUOJXNNfxLf
    A3SGHtwadKWFcp43LIfgJsu-q4wPQCvGqHdR4PoSDsVc4Q4n2j6>
X-ME-Received: <xmr:q_VlafZ-K4LhsoeOabLDKUVhmqccApwpqH71LKO5RjhYNXB0yU-gSqBjzqPVQvL1Y3tSIoOsIipV678shFhvtkH0g8xyGjlCXKQongnl5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhhrrghmvg
    hshhgsrggsuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvmhgrrhgthhhisehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:q_VlacMgfrhrN3tp8p0JyiKjZ_HU9t2bXWyA8FfeJ64up7nAHHI6Yg>
    <xmx:q_VlacZaKNrAY_3y4B9NBI_BSpn4sD-J9lwETd09gSoLoSKp8a81cQ>
    <xmx:q_VlaS3Y2tWzrKBlPLeb8NfDSJud5hlLRziszJ1M5tcVtcbKqqMPjg>
    <xmx:q_VlaaeMzYPMr30IW1dN1w3ZzwRsVX-bDtk9LTYoqVYKequcGjO1cA>
    <xmx:q_VlaVWXHhKcGI9mPE8gMD-sLD17Ok0S0FpzujglCyACmL54dDjMsjTJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:35:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d179a52a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:35:05 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:35:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Lucas De Marchi <demarchi@kernel.org>
Subject: Re: [PATCH v3] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <aWX1p2fjo2XPpXiP@pks.im>
References: <20260113072013.3775439-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113072013.3775439-1-aplattner@nvidia.com>

On Mon, Jan 12, 2026 at 11:20:12PM -0800, Aaron Plattner wrote:
> v3: Combine the setup and test into a single subtest, use test_when_finished to
> remove large.git.
> 
> Those are both good suggestions, thanks Patrick.
> 
> I contemplated leaving large.git around since normally it gets cleaned up when
> the "trash directory.t5563-simple-http-auth" directory is removed, but it's 16
> MB so it's a bit big to leave around even in debug mode.

Thanks, this version looks good to me!

Patrick
