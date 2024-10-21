Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC161E1C25
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504044; cv=none; b=ZIITaH24DTiUIgXNeR8fDIWiN61UWDqatjDPG0uHGhTvVy/sMVzcGODbHwWPsBqx4nZsklIaVeWk66LwFarjO1VQ44sYghBfDF7nDnWJ48IR2WDAXCmP0L0MBuFFkSQGKs0SPM47gBg4/amZYmd1xHg2p3yYz817mS/7lJ4PIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504044; c=relaxed/simple;
	bh=vWtot6EOHL5VT41n/BxDgNLQGIP+wxa91BzH0+TvVDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuXrn2GlDjkQFtBwnqFGq7Fmteho485YsmOAaOM8geG/XZ9uz9QIdb/VIkPF5Ym/tAZNrRSA3EJ0Q64xlIo6KGEXSdi3TZOCTn4Ktun16VRHlQTOSAsHZ0Ge7P6u1NWJR6HiVhlzzLoXvpp3JrykccsDtNMuuvJ/WWL+DlpQV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w0AU0wWV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMnRhV/F; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w0AU0wWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMnRhV/F"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 227D71140155;
	Mon, 21 Oct 2024 05:47:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 05:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729504042;
	 x=1729590442; bh=+Nenvm5lOQOZS8zTxgTKH9DO3IiTosJePsHtA1tk2MI=; b=
	w0AU0wWVtB8rgsdhLzFehOm0Nh7gOTzx3Y9MtpdJgOUpb/rGdhwLggN0V9VuEtNC
	y7BMddpexHW8CKuDPvaQ9N7t7hRUnDpo584dRFEeJlHCGWV8obF+aqCr1beQfPDm
	2NdfAFd0+b2VXB6y3OL8U3ZwFdJ+fOLqfw4N8fWSbNrSVVnz2H5f92u15H0NPlhA
	Lx+2aNJYyJds2u4w28XUu5qGB77iYFaoDn58k6OVEpvNhVkQwAeg3iCfidZy41Kg
	BIG4eu44dwyLIMOiPMDjztrrYu8bTjU4ZTCpj9trYwb3vkaTaU2KAVH2TOxnR2tV
	h4fZK3XSBOMQgoHOa46kSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729504042; x=
	1729590442; bh=+Nenvm5lOQOZS8zTxgTKH9DO3IiTosJePsHtA1tk2MI=; b=H
	MnRhV/FhSZxlj45eFQkf3g1Pfv+QDG1Hx0vNb4gG9rlTsiDWrilIjtTiat1IjtLt
	j5rk9ho8jTScphlaOMbCVVH3ifYrJHkQNyg7CXNzF+ntC3grfg3T7gGYA4TksGbM
	SaGBpBhSEcX02tlYP55LFV5pcVfBBQbqwQ7kQJ1Fps96kOJMyqHJusFkK8Ld7I/m
	5Z9iyElQWM/igI8gJ+fFuSYhW7yaGmTQZAz/ehizoM1WbAKbgdCKAF/MFUfruZCg
	OQSMTzM/34kpkPCuCr9HmISLiu9GlcUyZm59b57c1AnPN9BqrdHS6M9C+Ooce3Rd
	UfRYuA0PR36ZEcoNVorZA==
X-ME-Sender: <xms:KSMWZ5b3FYI-5GYZtO3Xlucm5Yq-6_zcDaJDiPbhqLkQUkH65zUc9Q>
    <xme:KSMWZwZLCbqBV9D3UhLSzFLMPVoWRHm1SYQTrIve-N1cyEMAjd_C0EGxQGvGkhipv
    izOOPv2NrKpPqF9pA>
X-ME-Received: <xmr:KSMWZ7-tRORnSTUkf4aTdYbxoTvlQg61v8m8mXGWeDruGns7qLIcEvMpNyjFhNbs5ORdSIpVDat1L7vyb2qqf_m_AeTzHy3tUIs3h1UpmryK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdegueeu
    keetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvg
    hmrghilhestghsqdifrghrvgdruggvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KSMWZ3oAT_ibswr6YZZhon44VKi6GcZ3b4LFE56pIuxBFx-duYds3A>
    <xmx:KSMWZ0qUzCxXPI6MQRLYKxoL-a__7AOzTnMKj8Tws8mWX60XNqak9g>
    <xmx:KSMWZ9Q7dEFC0mE-y9kYnVKep3jVs5mAqdfdL_OKW5PySMrulRMQGQ>
    <xmx:KSMWZ8qCS772G9OgmaDxYifpIUtgF6H-oYieFmrTuY9h_avcJIQN9g>
    <xmx:KiMWZ_XHcNjp-0tCfjeu6yyy_NhQ3uB8ZQHuZ7zGEK-uEYlEB_Zkj7wU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:47:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dcffe6a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:45:50 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:47:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org
Subject: Re: [PATCH] Fix duplicate word typos
Message-ID: <ZxYjISSiV-vlE96W@pks.im>
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
 <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>

On Sat, Oct 19, 2024 at 12:06:54PM +0200, Kristoffer Haugsbakk wrote:
> Hi
> 
> I guess it was an intentional choice to not use an “area” in the commit
> message?
> 
> I found this similar patch which used `*` as the area: abcb66c614c (*:
> fix typos which duplicate a word, 2021-06-11); review here:
> 
> https://lore.kernel.org/git/CAPig+cTjjNrU9q8UPm+CRuTKq8_XNc+1z7-3F4bvetBi+NjKeQ@mail.gmail.com/

I think many projects also use the "global:" prefix to denote changes
all over the place. We also do this in Git, even though I should
probably say that all patches that do have that prefix are from myself
:P In any case, I don't have a strong opinion here.

Patrick
