Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACD1A9F97
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764439505; cv=none; b=TBPwe/7Qy3dh4Slwb2QD02oZbMVnsSyYUUvfZBgusTvRP6rTd1O+7FTReRk8NBTATHtvAnKICoOppxot1Y2diW++c5w57gprxhLGGy8cO2hp3+qJMssKOo16SUqP53rElHUj0z8w3DjEI/VkgYzqDIh4lZ/bAJCYnw6lxGCUEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764439505; c=relaxed/simple;
	bh=c45HUwBsdn5gSAqYsGbOExLVEWN9ubmVizRikafkAJs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GxDKSGt0HU2sCpF4KzmuRTkOu3kFer0HX4crR3EC5pIjgqQKYMK+dvU9Lz7ZZpKop+ziXeKGqzj9mLs/skX6JblW3Z9sAcJQ9DuxsngW5PhLr3TR8i/3GjJ9A/Ucqiy8FK95l+E+VS8N4kXcI8bTNdwdS5TKYjWgdokopSNPgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AIdwMbN7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+H/o/FV; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AIdwMbN7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+H/o/FV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 53A961D001BB;
	Sat, 29 Nov 2025 13:05:01 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 29 Nov 2025 13:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764439501;
	 x=1764525901; bh=Z9Z0TX6SVseowjsup57i8Fhv8NhrmCBHylHS2H8hWx4=; b=
	AIdwMbN74g9xskhdUYxScximTbKUfLel2qx3w1UR9xVeSdZkgBX53GQWtmCN9Wv0
	q9/u1O+JgGQicX3vAIESkuGXOEmlObtIwxRamnoy5CgRrzTYgrAZMYCnZGgAm54E
	Lw+ubhisjnR6xEXnG6JHb6/7sTK8zQ8WOjK138aXN/XXXvfpzj/bQYVFIWwxae2D
	1KZQl81pW1eQlAgiui3bePu7yYWBu8Ka/GKLGDTmgxHrpgNRYO9vtHGt0neIUQh4
	7huu3uK11HLWeLSFnngVuo3KI3YrBdDpo125locmC5PKYd66B+otFhAVpXeHjCoZ
	j97IDLyz5FYwLajKKciE/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1764439501; x=1764525901; bh=Z
	9Z0TX6SVseowjsup57i8Fhv8NhrmCBHylHS2H8hWx4=; b=t+H/o/FVJrNkng83H
	jL1eWzIVsCeYeAwtNM4+856qO4XIdjqhlUDr+WWGqBV4J9ozWnzY6dRHn7DsEXFA
	6x492wq0mHKWQK6x1Ao6e1dWW0IqoPKJRrqADKl7RVKq0ZIAE9uA2S5R6V621Ekb
	6S1gQsFFnKX8Jz8KlWNwkyJtav+KEup54NSQeZ8WBhTTosqaSJ62Lzs8hz2hduh+
	kKPT2xHoCbLVHx54fxm3mzEybq4ezu2yxqtkJYqOFLr/omMpcwLW2bK+s9yK2MTA
	ThLQ/XVhYF2MwvruMAJeET1J3KzOmzC1yobSR4rohg5Ico1S2wcjVixp23H/7N6a
	noyLg==
X-ME-Sender: <xms:zDUraSX-YVqqoxYxziPYVXRup_vyHgkwkgYdpYdCzWhnOVRVOTcLUxM>
    <xme:zDUraZZHucGDaa3a4hQlfNb8ZsbJZKfsArhDT9Nqv0mHT05FtkCy-HRSN1EbjPYCp
    WCTUQUg513dp5ObYzYAFm7qkN3AllDjLCa516zvZDVzPi29E6UsUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhthhgvfihhuhhghhgvshelfeegsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zDUraZA47LpiSC3iwQMHLSYC2B_-55tc674q5T7rAv23qy3lLbvsnQ>
    <xmx:zDUraVe-__2zM4nWZvbpFAFt37pBUcU_EBSbwLMceVGl6bxK-UUwHg>
    <xmx:zDUracKy4L7CqWYZSB0Y2NsEmgwYH6M5Y-a_tDw--Afadg_aSIthCA>
    <xmx:zDUraQdUtspiUSmpH6bqq0xaM0h-VPufx2HdKyH_AyWuCVg87zqzmw>
    <xmx:zTUraWIfxkh970HDDrIQQxIjIkCwxt3Sm3EdAn2Gd1vmg2cNO9n56TOb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BD81E1EA0066; Sat, 29 Nov 2025 13:05:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACjDoOfx9FiR
Date: Sat, 29 Nov 2025 19:03:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Matthew Hughes" <matthewhughes934@gmail.com>, git@vger.kernel.org
Message-Id: <dde51b05-6f75-4eb0-944a-541da9622623@app.fastmail.com>
In-Reply-To: <20251129172124.4164-1-matthewhughes934@gmail.com>
References: <20251129172124.4164-1-matthewhughes934@gmail.com>
Subject: Re: [PATCH 0/2] Update documentation/discoverability around `scalar`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Nov 29, 2025, at 18:21, Matthew Hughes wrote:
> -- 
> 2.51.0

Missing signoff on both patches.
