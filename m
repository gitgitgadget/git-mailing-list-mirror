Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0D221F38
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905120; cv=none; b=ebSgiHdlKF4NsSGetyWo5a9i4OQCZJ0/sMUxj5pHJa5Hf2pt5NJJ4x15rDTlj3VbwQ1vaNIGZyh6ajDaVTEdTqkKPhBH8IZvwYSbdhPRwKJjTfihYARG56upOgTXRaLRQovF3TUB5Y4vOeW8z4E4v3gMppCNVIIttN+v2cZMf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905120; c=relaxed/simple;
	bh=o33vlaWbaJTxF6lURI9dWhLdf4nKVl4Crcuc02TO+oI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=umAvm398ayFf92q2ty0o+btKqa95vWB6PoQT+Ht5Y2qBlxbXk9rx/OHxcynmRJm6hJ3mjDNXTTBQnXIKdl4F1JVdTTEOi70L/gQHMmW8oVBCpZ5Qom8R0suhF2tILAemysYje9sEoKZP0JgXbH/a7yERBoAJ+Sivsp0F+dARs3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=R9SjMRHO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SlnmlBuw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="R9SjMRHO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SlnmlBuw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CB4011401C8;
	Mon,  2 Jun 2025 18:58:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 18:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748905117;
	 x=1748991517; bh=o33vlaWbaJTxF6lURI9dWhLdf4nKVl4Crcuc02TO+oI=; b=
	R9SjMRHObD7thV7sO3bpSBMKE2dtCNRz8DLckVsVatBDUELckvWZLNamwnUTqphm
	m8hTsSmNemZ/ztnTrTtk+1zxkWzV3BImoUxHNEbC7VpzNZ0udJWYyoaQhKyrXcrl
	QDweczbym6MXkzeQTJfDjdiXI8fjIvbOAgqB4aagZ2piXI/JYTqJEW0AMCXBs4MV
	CyVX8ziG3eqNZ085g12gC2CfOpZRJ9BsDQUy0l/hzBeKd1+5v5yPSdjx8kUhYsgc
	cJax1c3TGoZhgnNLVCJ71spQuydIqlfRE0/385RXQMQcTrGihHdw4FaUC8SIpIzf
	pIeIaDfxuu7fXmjvLOV2oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748905117; x=
	1748991517; bh=o33vlaWbaJTxF6lURI9dWhLdf4nKVl4Crcuc02TO+oI=; b=S
	lnmlBuwLZwG2/u1taSsRSx7nb3X2xk973UPn7APCiniDqyjAe9qEqeJf2tuiU89b
	IlTTQqLM7nyAtKUpF+0p5r9mHyCDZHSGw+6mMptSB7RKg2dEXNSjSrSN4umHUZ0g
	Vf5rYBjwucix5JFteD9IG7BT1VNfvWr8w4BVjOmJ4VWDKW3HLpVI/Pz+oRLhLZW0
	9E2w0lHEH3ceUaJ//fBKV4qj/RJsqJ1ySG0PFuvEgsxOqMA2RLY1Gfgn9vqLMlv+
	HuvdkTZhmGXN2Kn9YGpTcwj61h+u1qdfM/81yrXRBaKC55KXtHtMFjb+NsX2fVh7
	6ww8awaAqPsRDJWH8THlQ==
X-ME-Sender: <xms:nCw-aKl07KZD-tgvlJ4csNvn2-T7jT9yHL_P2BDrYla1H1GPnjrxyxA>
    <xme:nCw-aB2eP-XxEqpNelkP4o8TQQWrKa58WLptwEhOD7OCvY4kQ3E-HTZGt2NOMrqlC
    r0IZNO6TBa4ThiuSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkeelfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveeghe
    ehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtseguihhnfi
    hoohguihgvrdhorhhgpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhn
    ihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhu
    shdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nSw-aIq4QKQpyqL_5wG83-CqDUbWxveBBz30DKLXFnlBlU9NiFmliA>
    <xmx:nSw-aOn6dSUz4eRWro8G5u6sXU3sx65Eb9r_EbqLMtH2f_IBXdMRJw>
    <xmx:nSw-aI3vuIvv_RoAiSHdO-l1Moqfxz-1Q7IatKRdMBgpgWWDVo7P-Q>
    <xmx:nSw-aFtJ2UEz9RHnHwfUvm1EloPWWLMIvl7SMMtifoz7fsReuYlMDQ>
    <xmx:nSw-aAjfUJ51nVObf_-ho05zTW5HEyk23MO8xKw2oICF1SkqOtVdKeZe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D66181EA0060; Mon,  2 Jun 2025 18:58:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tb406bd161f062dd3
Date: Tue, 03 Jun 2025 00:57:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "GIT Mailing-list" <git@vger.kernel.org>
Cc: "Adam Dinwoodie" <git@dinwoodie.org>,
 "Junio C Hamano" <gitster@pobox.com>, jayatheerthkulkarni2005@gmail.com
Message-Id: <7e59a05e-9abe-44e0-b5bb-6bd633570db5@app.fastmail.com>
In-Reply-To: <d124a48a-56c6-43ab-8d10-0f6374149213@ramsayjones.plus.com>
References: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
 <d124a48a-56c6-43ab-8d10-0f6374149213@ramsayjones.plus.com>
Subject: Re: v2.25.0-rc0 test failure on cygwin
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025, at 00:48, Ramsay Jones wrote:
> Heh, so the subject and ...
>
> On 02/06/2025 23:33, Ramsay Jones wrote:
>>=20
>> I noticed on Friday, while testing the v2.25.0-rc0 build, that test t=
6137
>
> .. this should read v2.50.0-rc0. Hmm ...

Where does the extra *2* come from=E2=80=BD ;)

https://lore.kernel.org/git/061401dbd2d8$b4ba03a0$1e2e0ae0$@nexbridge.co=
m/
