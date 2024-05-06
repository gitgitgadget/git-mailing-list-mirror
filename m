Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE781A28D
	for <git@vger.kernel.org>; Mon,  6 May 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957812; cv=none; b=VInh2N2pjt0LINpp3L4TFjSdLIteogT2iv5UT1cn3fOS2hYZn2nJLyacm6b0XsR0Qru7MJ1PWcZdo9JB91ND4IVF95/HEKrWG98Ey9RiqJZbEX1uGvr1nNh6bfQZschDdhbIOyJxMCBPTQB4qByOyBM5YzgZAR3J5pl1P/MVq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957812; c=relaxed/simple;
	bh=udB2VHDcsTb7jss8PoLDu2jaPJU1sxYDMPipKl5RlCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=d1icki1yUwQSrQP22zWBqzhjYSvObPQDR6wCzW8H321sq+F1ejH5AnF0NFvHBsRb+QwMct8cr98m2sfVnVEgP6jd1HRvwRvFFsw4xX31Evle1P8vj2VkRS33U3GyFrvmCfM+fz9d8bfJHFMw0qp5y/LOqTb0Vn3z7NcMyUCcwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=KqiwUrP3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jumFFAW4; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="KqiwUrP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jumFFAW4"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 3E9C21C0013B;
	Sun,  5 May 2024 21:10:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 05 May 2024 21:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714957808;
	 x=1715044208; bh=RpmQigaqZguHuviJL7bYzKwpQqjSHTVFMWnyBgvGR6c=; b=
	KqiwUrP3B6SuIt/pSq3SnfLKEyS9FJGtjFJwjDy9pUiisSeAOQImKGjVCwRuM+nY
	Gnpda7Rm9chqSyBSiAfqhOuXfdCkGQHV/vvLEo8lqQ+/ln95x19opLT49qk2gfjV
	3WhipdSfD8Zo7d9pOvmK4ZwcZQBUcUKIdx6G4ndrTonethVl/RAMa6cqbTzntj4r
	KZiQ6ePtN5uTchPP+SgrZv7MFdoay1MKUgHwS6kz61naUH6OddieXvdpjS9d7DjI
	Dn33vwtuGwjkO3EBJ5xy6vVkdWg6JLBFB2o4JbZIJ34vSbW5Tj0p8h91buWe1yuv
	FICDLlEaLwjoTF5Lxoa7yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714957808; x=
	1715044208; bh=RpmQigaqZguHuviJL7bYzKwpQqjSHTVFMWnyBgvGR6c=; b=j
	umFFAW4TKaJTwVLnecU09bAK8fz+/wQhXFE9F9TSXogSi9CJECUNGATL4FckgdZ0
	3MN0DPJUnYdWOFQE3cWFHGpvD1SAKUDQW5hbydCPBaoOC8yUClxYa8RD61P69ntU
	9c+FXnJwTfuY6UIANvtEE6xMiF7EVy/s7EnHUpGn8l7eOHZ1Nbe7ARWy4ldo+xjV
	mX6HQJF0Nu6eVOu7HaBOSQR983/THWDBrdPS8YAumDp0YrFxJQy9Gofc3FTNZA8g
	A0bQbZu7/SI4qsZx0B4kHKG78zdpBvUnL+49LYI5z5yyobJJI/nuDmUw++AvXE8p
	ZFpQ9AeY0+BTyeYrnNUyQ==
X-ME-Sender: <xms:8C04ZpiJ_g4jW2v2EIy_I8_0iGAfabAPgW_kttskb0QCTuh3sgu1eA>
    <xme:8C04ZuBBFQJlpfsrEWFsiNvr0BCTqPQ0E24Bbo2rL4OaPuy_jk-uFzk0Zk0HoU9RZ
    Nvt4SGRdskuecMtdA>
X-ME-Received: <xmr:8C04ZpGkHO4D2w2rzv1MNTqYTt0Hd4n0dO2eH81yYW2jvBuodDWh77RVjFwtmEle9glDchyuOekcd_OVg3ckrOuMgSso3T8Shl44-R1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkhffvvefuofhfjgesth
    hqredtredtjeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghm
    vghslhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeffefgudevgeefudevveevkeeiff
    fhteffueekffffhfegleeukeeiffehtdevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:8C04ZuTDm9YzjYYSN6x85tsB766OdN9vcvgaFO5GP6wlE7lqHkJVAA>
    <xmx:8C04ZmwExdyhYD7jWhOuUrFFZtcnpBkQ584hiI0OqUE1uKhKtXKZrg>
    <xmx:8C04Zk6GUj47740rzuzLW-6zLT_l6KA3M5GWpZ2fGOlrOGQhDVzcRA>
    <xmx:8C04ZrzUUpTinqiWzKTe5sIfUNNQ8h4kGl95MkbTIotcs28b8rwTSA>
    <xmx:8C04Zq8n_Ar6YwuSQiUsAHnwIEK69fUpyMoOHfq9S8cGw26IF__Axu9i>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 21:10:07 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 11:10:04 +1000
Message-Id: <D125SZ21UPI0.166ZOVLTOBCRH@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "James Liu" <james@jamesliu.io>, "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
X-Mailer: aerc 0.17.0
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io> <xmqqedai959z.fsf@gitster.g>
 <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>
In-Reply-To: <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>

On Mon May 6, 2024 at 9:20 AM AEST, James Liu wrote:
> On Sat May 4, 2024 at 3:25 AM AEST, Junio C Hamano wrote:
> > > Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all h=
ints
> >
> > Huh?  Do we have "all" option that disable everything?
>
> Oops, I think I mistakenly copied the subject from the original cover
> letter. I don't suppose this warrants a v5, does it?
>
> Cheers,
> James

Ahh, I didn't see Karthik's feedback. Will prepare a new version.

Cheers,
James
