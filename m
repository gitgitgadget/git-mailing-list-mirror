Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9EBA34
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711219; cv=none; b=B2rcR/2alqBGTV8+ayPOT1lBt56dgeVx8sxaHbTjXT2N+mCUaQ83dQz9REVPlQjaTp0Uls8GGQIAf86mWDJ0pD0sn2zB1oe7XkEp2ie8pTVH4fdfPfIxfTCv7AFD+KdEjODxbtXiDwUEg7rZYWB36Zwj4AvXgms22ZFqog9hqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711219; c=relaxed/simple;
	bh=becv6oLS/2WOU80Tw28whHuDjGU+X5YstjNRfuW5PxQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bculgDjDqHviA2eSiCdUKzCKmSth+HFz1wvvb9zFv+4lsPmOSjdwJ9HVDbHdMH0oXhuZbOkg4fY2IPgY11Im5RVxwtMMrO8VJtvIvvfYwTc9DInMPgV6pNh5kfUMhiCf1gzZcGvK/LUxB3MIl6Z695MWTPsTzxkkZMabJmcEIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YQiHHwg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pvb1tesI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YQiHHwg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pvb1tesI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B15611400EA;
	Mon,  4 Nov 2024 04:06:56 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 04:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730711216;
	 x=1730797616; bh=ND6FUkPU+Mf3+Hbq6v5axz94B9ndKOg6gpQWc0mU7uE=; b=
	YQiHHwg+OqxfSxl8lrPUBsk3KXTNUF2gf5UGPw2R0xCI517hXmU8jK18GqKot6/j
	MkbaJNifDBPSQahzve3+dRClRf+5kkc+64B0fPZLAWtL2DnQuS40f6jIQ7H9Zgmk
	xUd/yCm6WVMmyHcb469EthiH4OCKdYmw8MdWWsTclPTAmiCmmQheEUWox0Xg9fBg
	u0cI74fy9kTkc1Lcp/FWtwuwGfiVYmre3FRmvgEUSxbJ06GGkIrHTeFrsGdA7jwr
	kd5ydQyddQ4qqttqIy1vo6OQr/CB7CydVTg4/eRMePyjbN4ZIB9vMc1PZpX9r/gc
	R3rApweBxU/tTa1CTYQAfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730711216; x=
	1730797616; bh=ND6FUkPU+Mf3+Hbq6v5axz94B9ndKOg6gpQWc0mU7uE=; b=P
	vb1tesIoBs5x3xndhY6YnITQZwja/m/CWyPzoKdUQFkJ6LGCKBn2AegBT6b2Okgx
	dDQ8rXK6MT/DNL1IEdnv8Rl093lxojM1YhY/LILUGaT5qSnU02VghALpR7UMAXfJ
	iFEQ1d69I6DSpOPFd+a3Nihsv36qX87Xo6BU56/Vs6JcVa+7V4wwvXm0ssG/XROE
	jkzIPi9+WpbjRgo/SaybPs1MJyuajS7NpvNek5urkemddHhmeLxhQETaW1nvqR+j
	EbcoDjikIHbxpgSOsArbpwwnx/HRBTKCuQ297yFYvAdG2lHDgsnOjl9FpHhdR2fo
	OKv5BHH4Q22EgOPeXstGg==
X-ME-Sender: <xms:r44oZ6lqp0IOk03c4oTG8_8P_sMlYzpqNW-_tBFY4Z65-uxVHMevCRw>
    <xme:r44oZx1c3vTlCf7V4f41RLb8SFwvrY5SGaXJbTETOqzPgxc9L7_-qsl0Ga3XKEnB8
    2dn-nVm9A-66_Q4bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelhedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r44oZ4qeixHGYbgiveyoytIxvJojq61UkgNbpug98wuDYvVvOnk63Q>
    <xmx:r44oZ-no_QD1GhUYuQ39eUi84rTl_rvXCckW1nGCBaaW0piq2qY8_A>
    <xmx:r44oZ41FbYwXiwtKeDPnFaQELyzx3GPG3tXrxXr2SFTDvf8qHF_KLw>
    <xmx:r44oZ1vn5dtcvjrwgDLtxZ_nPbxGN8GorhT9_-c-iuttlGo2Brp0xw>
    <xmx:sI4oZ2CXdFVD_Gco39sYgJ4ESifswVNrXQY_ni1gLWMvEEg4ymzFtEQ5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7E47780067; Mon,  4 Nov 2024 04:06:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Nov 2024 10:06:34 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <d37b443b-089d-40c3-ad41-f77a990fbc72@app.fastmail.com>
In-Reply-To: <xmqqcyjbyjdg.fsf@gitster.g>
References: <20241102165534.17112-1-algonell@gmail.com>
 <20241103135111.13508-1-algonell@gmail.com>
 <66df52dd-1b7c-4ca8-9752-646b5b223feb@app.fastmail.com>
 <xmqqcyjbyjdg.fsf@gitster.g>
Subject: Re: [PATCH v2] t1016: clean up style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024, at 00:42, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>> +	test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
>>> +		git --git-dir=3Drepo-sha256/.git rev-parse --output-object-format=
=3Dsha1
>>> ${sha256_oid} >${name}_sha1 &&
>>> +		test_cmp ${name}_sha1 ${name}_sha1_expected
>>> +	'
>>
>> At this point it _looks like_ some `test_expect_success` are moved
>> around.  But my diff deceives me: all of the eight `test_` are provid=
ed
>> in the same order in the preimage and postimage.
>
> Yes, the output from "git show --histogram" seems to match the
> corresponding blocks in preimage and postimage better in this case.

=E2=80=A6I=E2=80=99ve known about histogram but never tried it.  It does=
 work well in
this case.  Noted, thanks. :)
