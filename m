Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC513D8A2
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148761; cv=none; b=pVlxBUq9iRXDB7Y9k6RjGsh94xSpuNS8TuIXLXffRIMmQM7ZnxNlfcBpKbFLpXP5f0TSPIEBgWOtpLvpDjbl+Nu/6By/tCW5osX/kZz+8DYlxuUyyM7zBdFRtcZybuBDSXT5KcDvjt2fJ5r42VqSIP0G3lunVy2vfv8E+QDJ3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148761; c=relaxed/simple;
	bh=zQjzJ7FQq96D90falWefyC33bSn7ImTrR03UDTqxs1g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t0PNy6G3gtzQzhUajRmMhmTZt9YQIPeEqBLJkaxKbEUC7W80n/Xo/YJOgIPzW8Qdk4vWge/5+q6oqypFHqnE3BlCdRnueYvxG2Btb44pv3of6sgUx01bjXptu5FvU702KYwaM1Pa4FEw6FqlGo48aI+i4bT4dYwelJ/50qn7SYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qXGqpbRB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6I2dhdI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qXGqpbRB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6I2dhdI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ED66611482EF;
	Thu,  8 Aug 2024 16:25:58 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 16:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723148758;
	 x=1723235158; bh=d6dvZkgF3MPpdBJLaA3jl2+uaj8g7YGxFycWgDdlEAc=; b=
	qXGqpbRBBzWi/Yyq/DmcdtnHDj2NwmJoy6NalKnK0gP30K+TSinHjIK/ZDmkFBoW
	69qBXb7fEaV+ztXIcX/HHbT2tqv92hRAU2sAUgSnWmbb0nhksilTcy6gDiH3oX0a
	mnoV98wjOG4C9jc47AmLprd5tnEMwbHjo9/5kfbUzT9OBM8/N7j2L+mdxsY1a60V
	/bZjO92E2XoX2dOsqM2dTXplQNJX984LS1MIU7hso49baw6ytefzGYwG+4ibWAoo
	TX6D0JcNnY9Uykm9o8Cixbr9AhKE7rtYXFZUANVTYXVSJeeP5s9CnBypvruV2Piv
	gihuwUTvy9w9HzsWyVSk7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723148758; x=
	1723235158; bh=d6dvZkgF3MPpdBJLaA3jl2+uaj8g7YGxFycWgDdlEAc=; b=K
	6I2dhdI/BMynx7w4karZBiAiwsDPr8EfiQ3lwF2VgnKgZnaUfSU5nKUoWYznYO3B
	JPzXv3HKL/ytL3d7U43klltMwc+Eje/KPiousuLYLDdTYQ/qabWvGcfIgxtjwG7t
	xiBFbngqOxoAXrWjodqnHUn+bdpJ4qWo2KKBnMZYXsQL58cvgncD4MrpvzXnQ82c
	Yz+xHx0NOe/1SEOx9lNd6rX3JOl9ZRmgAKYLEs+2p1K3DkNiUI8qHBRiqfMTjqqS
	ffUF8NE3dX229iNXgsf04jo/FueiTMquV9BmVa2SiDKOYq1oRZW18P7y/nRthjbM
	aGOExE58BhdizbY/porYQ==
X-ME-Sender: <xms:1im1Zn2HlJcm2qhY4fBj0dNmxZfV_t7HT2f8auLF0GKh1aBQrnh0Kw>
    <xme:1im1ZmEaKpGedpGzTrLZ_2uT8NuGrqFZG9_766MdRkGfIv4KVy1tvTkzS9h4NDsZL
    HShQWxVhNUj-fLinKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepphhunhhkrdhlihhonhdtledt
    ieesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepffeiieejueeigfejue
    efvddvuedtveffjeehieelhfdvieduleehudelfeevfffhnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhunhhkrdhlihhonhdtledtieesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1im1Zn65bAmaJjUcD1ECwtNkKV_a0hEi4X6UmP3hOe08OVSkuYQExA>
    <xmx:1im1Zs2a_TrDe7YdIXaEYfGZApDAAxX42jhxZDbcz4jJDku0iySpvA>
    <xmx:1im1ZqHbTq4yTVurdurP9vQSnZDPMsm_P9dVQJI2dhDCczzDBmnJTw>
    <xmx:1im1Zt_FOKg7iBuesp_pMl5dSg_28-zc-eTM4MDasFswUVKLSEpKGQ>
    <xmx:1im1ZsNSzuuZPIOr1Lnb7RKYyNrDj7UJ8QlslK3v_ZzOMiK_Iq00J6vf>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BB8DB19C0079; Thu,  8 Aug 2024 16:25:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 13:25:37 -0700
From: punk.lion0906@fastmail.com
To: "Kyle Lippincott" <spectral@google.com>
Cc: git@vger.kernel.org
Message-Id: <9c46732a-eea5-4849-91d8-aa4cc3dc92f1@app.fastmail.com>
In-Reply-To: 
 <CAO_smVg=1gFBudrd70V2_AXSPOUTFz=j7QqBpbkvR7P_KqnBtQ@mail.gmail.com>
References: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
 <CAO_smVg=1gFBudrd70V2_AXSPOUTFz=j7QqBpbkvR7P_KqnBtQ@mail.gmail.com>
Subject: Re: Documentation bug (?) when describing `zdiff3` merge format
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> This line _still changed_, even though there were conflicts around it,

Ah, thanks for pointing this out, I absolutely missed that. My mind parsed
"... identically" and "... the same way" in the same way.

Now the situation makes a bit more sense, I'm getting a sense of *what* `zdiff3` is doing, even though I still don't quite follow the why.

In any case, in my mind this is now a documentation bug where `zdiff3` is not explained as well as it could be. I don't understand the situation enough to provide the fix, though.

Thank you, everyone, for the help!
               Ilya.
