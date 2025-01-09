Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E940201017
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418728; cv=none; b=l8N0/Jf01NwZe0+mZ3rqCFRyZ63Yee3mA5gbRY7ZGDMma+0Lbpc6teDB8XaTruOiN9vR/QBNxl6r7Njhzh1URSMSdXc7P1qnjovbUqhmMpwfTi8p0EeaWqUXtM30jEhwERbUC9nlCqlJuzKIgi+aU3bha6d9VNov08KPO+Q6Ox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418728; c=relaxed/simple;
	bh=Xa/lRixAASaksk9/G3xmDlsMel9w2tYSTgIAFnXJ/xs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eD3Ps6OkQ6afw4O+FPel6Df0UJGUtDL23R2xCeAIdY/wWjFfFYLjRdktoKu754xykmu8V2KFRWTRV15Q7axSWNgqIU4aPCEFOuDWMi5gRcp7o2gnqcdJUrBzwLo3kENe4EC3+0pPXT51os2th9eAv+bkEAxPU94hHf+R+2wDW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EFjYtcVT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDf8SuNO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EFjYtcVT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDf8SuNO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 795962540130;
	Thu,  9 Jan 2025 05:32:05 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jan 2025 05:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736418725;
	 x=1736505125; bh=aru6G3B3s+moj5xEGjvsRGdxrnE1+b5u0DdWalCn4mU=; b=
	EFjYtcVTEHV043xujVNZX5OUzpYim37txy/7ieOFNWdDypmyG6Yv8RAhY6eG1XLE
	qdiEhQaAhjgcySMB6CI5DYcWRj3vMEsNnS6fDZCd1W7od9ECIKapNbZmqDbbyUmy
	RFf96Qm6b3ZcAnmPdj5rNhBc1l80IeZaRC/x7kX+TSEhfhuLLkpFFOkK1qqbbmA7
	QIjFdNm6aK4N5ht2fMLprJ1OfxAl76a4Pfv2AOB8jPZKJ2jqFYjFSXpz6d/amaVQ
	o05CrezoNhYdyUTtGmpFIsqvxUAM2dGLdyYdjaT4Muotz+n5wkgr8QukGhDx0SSG
	Lr+Lbogh+20auiF9RNkIrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736418725; x=
	1736505125; bh=aru6G3B3s+moj5xEGjvsRGdxrnE1+b5u0DdWalCn4mU=; b=J
	Df8SuNOgdsum4H1CtDUdjxjo+D0C486TmUTaj/mMd3LVWp07xVppKxGGErZ5o8Xf
	lnnbImK0vsjRf7aglUQcIZrR59Wgi8rfN2HKjkqKnN3MvPMDiM9yd2PiUSnTw2v9
	DzSoiMd6OzkZNFydrx/4tUzBt/cI6qUCSkEBrOGXXh3Y54V/xeSFaXAZvm14te3Y
	aVeAZhCLXuKOjR3gzr9WVE56cNh01sogS7fZVxeyPmg7PItoJbF8r9DaSMjzInqM
	rRk7nuWXFBiLkK6Tu/jqsefFlli3MarUBufApLvkPSq1M8DQ31nvEX9UMvgp80iM
	DJhwNPVhB7RgqdhPV/wqw==
X-ME-Sender: <xms:paV_Z-vZ2h5J3suQuBw5mXmA7euhG2OL21LrRAMomU3Egj3W51cMUbQ>
    <xme:paV_ZzcHkrlgeqgltE2K5QVVjXZUZdCFTeUpDJ8T12Xf0oAdOHi5HKScSAlYhK_9l
    zIG50ohS6SatpH8wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:paV_Z5zUvIVN14YZeNXPCA0x9-zehOEjn7orf4ZHtN2_ix8wKi5R2Q>
    <xmx:paV_Z5MaHiUBdS3HjcR07ls3QK0whA6iYrczCY7Ic1m5rABT1I8mxg>
    <xmx:paV_Z-8meQ-icSPo3pUbJ_tek870sEv3gcmDjW0e88BjFV7P1JsKeQ>
    <xmx:paV_ZxXqyhZywn2ETZVXoBorJ497Rzv9Rqa_xeKNWFP8nlwOwWzssQ>
    <xmx:paV_ZwKDIgxz7T7EZnb8mtz0jf1VdZbhPAMvtAk0sHe6WeL_rdv2SLeq>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C928780068; Thu,  9 Jan 2025 05:32:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Jan 2025 11:31:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <10051d40-2a32-4434-a034-87b6c678a3cc@app.fastmail.com>
In-Reply-To: 
 <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
References: 
 <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
Subject: Re: [PATCH] builtin/blame: fix out-of-bounds read with excessive `--abbrev`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 9, 2025, at 07:21, Patrick Steinhardt wrote:
> object ID. This is because fwrite(3p) of course doesn't stop when it
> sees a NUL byte, where as printf(3p) does.

s/where as/whereas

-- 
Kristoffer Haugsbakk


