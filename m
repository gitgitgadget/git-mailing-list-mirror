Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152FD30146C
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239265; cv=none; b=F+aDMQhjw7LRi6vne+tpqiLxDXtpCu1IscJnNZ2QNBC0GQJeCxWchDMZc6zm9RqbcLLvbEhz9r4LpQuAxhQslnAaOIYaCjvPGpjNNKwc1Kwvbt99OE7DSNSXU9cQ7PDUa4lakYX30KO0lf7D0VRW6a/c/kIXqtgNy/WZKxDTqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239265; c=relaxed/simple;
	bh=T1MzWKd95vOWgcFFwUGkctR2yjPP0+JbF9S/dXQIWeI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DQB5z0Rn0SvQSFBSno/hasmFjDDQDLhLKDv4kPHGfNfOI3IJKbDRiw+UbmBkYCS9YVOgVjDJmyslhumlL9PgnHF20hFoM8IFmL9F2HESzsGz9ywbGLEiP77ONfC0EFzdHJXVeqrD6uC4s39gO4agw3lVMlRcWs8QWohHtS6sBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EqVibtC/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ao55jMj7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EqVibtC/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ao55jMj7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06FFF14000B9;
	Tue, 30 Sep 2025 09:34:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 09:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759239263;
	 x=1759325663; bh=T1MzWKd95vOWgcFFwUGkctR2yjPP0+JbF9S/dXQIWeI=; b=
	EqVibtC/ekJVt7ymBR8F2H2J83y+eHUsi3LJLN37fC2dH+LJXbE5NzVc4lT79Vyy
	CRnS6/cZ3sJI35qjZj7FiWYvWOEfFPu6eRT1BGKLBlL9UgDL1A5ZIklVoQ8Ybho1
	h+2EnUOe9jwrW0wj/QOTKmu/OiIJBn+2eZl2nBXmt+hilM51qB9vIiOAM6x59e8O
	vpj9k1FtTRg5DfezANefwpx2EVNnGxi4LJJehBWO0ouiAGdbGpDkEee5g4zGyyI7
	9A6NzWHoY8T97ZygB9BN3U2uOfRvTg6R9KSzjuf199drvZ4poJ2xRHEATkxHulD5
	5Z0rnb7i3auGAcrhLmc3Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759239263; x=
	1759325663; bh=T1MzWKd95vOWgcFFwUGkctR2yjPP0+JbF9S/dXQIWeI=; b=A
	o55jMj7HP7hAZaM69aW/C69b0ptorjAsTiCYHP+oKhFdYt0xs12QkePn3kOBUwT6
	90wJ20XCfvwA1VNbgDGnss9sWyFiXqCSE65PbqBuoBMl2NowG/xPr+NnMctr1W7l
	DV8dr0kTGoF0w8MOUiRUyhR5Sbi85KYFesoxgk+AX6OL3SbMAF8YVpNE8sUQk/Az
	S6Hq55ZpsOq59n1TgW801tIJ7SNQvxz54M/RYjft03f/HPZDwyMD2IKny543c0Qp
	JD5vqsDyOmwxtPi0O4D+HEwuvVmq7J6wA6/oKc4q4nlb5AcX4FMTWxjPv7tPmBTu
	gGLohGgD+bXQWABcw3VEg==
X-ME-Sender: <xms:XdzbaMzZtn1i6cu59ECMlrbJKyFdkAtylnqeQpOYgXdX_sp-gjudlQE>
    <xme:XdzbaLHXJlqoBhjQBbTeQfUBrI8F5NjTwWnhRtBUx_m6y1YzBoFxDd33SYtCt5XIa
    XQ5eq6DThmmcXCkOA2cAdKkciMNbVmXyUnqTzH1M9djGO7OZwcaTRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepudeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhm
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XdzbaMrrBzyubFF8BnISu4VnWtM1QkXjqlUdQNNr1fO89Vh2eavk2w>
    <xmx:XtzbaKOwAI5vrbbmDWMbJ0mi0zA1kvWELnp3KkIr--YyABB0WO6cQQ>
    <xmx:XtzbaA2y7F_HQ9Wiw_P_RqtIVgYiqPbe9JNhhGatfbwioJRvVvFc7w>
    <xmx:XtzbaArdbp1GtZZaYxec-_zE2SdQkx4GyywscFbe8SvDwn9__i_UuQ>
    <xmx:XtzbaPjPG-juz5GYb_Bej9Ni-XjD_BFvy1_uG3Js4OAkxCissgOFUn2d>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D3A4B1EA0068; Tue, 30 Sep 2025 09:34:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGfLeR41tt4s
Date: Tue, 30 Sep 2025 15:34:01 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Christian Brabandt" <cb@256bit.org>,
 "Collin Funk" <collin.funk1@gmail.com>,
 "Eli Schwartz" <eschwartz@gentoo.org>, "Elijah Newren" <newren@gmail.com>,
 "Ezekiel Newren" <ezekielnewren@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Pierre-Emmanuel Patry" <pierre-emmanuel.patry@embecosm.com>,
 "Sam James" <sam@gentoo.org>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <037d8685-6521-4ac1-8251-d93e8a1d7081@app.fastmail.com>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-5-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
 <20250925-b4-pks-rust-breaking-change-v7-5-4e49dcb904d5@pks.im>
Subject: Re: [PATCH v7 5/9] varint: use explicit width for integers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 25, 2025, at 08:30, Patrick Steinhardt wrote:
> The varint subsystem currently uses implcit widths for integers. On the

s/implcit/implicit/

> one hand we use `uintmax_t` for the actual value. On the other hand, we
> use `int` for the length of the encoded varint.
>
> Both of these have known maximum vaules, as we only support at most 16

s/vaules/values/

> bytes when encoding varints. Thus, we know that we won't ever exceed
> `uint64_t` for the actual value and `uint8_t` for the prefix length.
>[snip]
