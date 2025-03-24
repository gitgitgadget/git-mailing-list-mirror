Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EC189520
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856490; cv=none; b=EyuygerxSIUl8bBt6WRGCQBFsk2tiIqkl+7YZlJkFMN2yW11zlvzwoDo42/IcZy7BNuSfNhoO3JXK+bwr0rMsUJKRHIeLLxlFw9/FyRaAjKdRCmZYwh5/OKfhPvJwxDya479VQU9rGZb7XDLUJn68fyo5rYJvNtHH/yJ8X5adfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856490; c=relaxed/simple;
	bh=q0nxr7bTnNCLqR+RnRygmbMao0AfmfNBEhqHNTTntKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ4LfKRElN9BmVzGOmWWevbTTziXaSx6rek9iHxkUSORFbBr72Fi0YdicMKzup6TD99b1twjYC76dWPi+I4r9EUFrnnRWjhMcS1kD3yqs4MGU9nQcfMRA8Oub45pSKlynDPIK+MXf503tK05H7VRePHANW2eYNS3kxBTosNrOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=npidHdHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vXMNyGw2; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="npidHdHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vXMNyGw2"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 837831140151;
	Mon, 24 Mar 2025 18:48:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 18:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742856486; x=1742942886; bh=q0nxr7bTnN
	CLqR+RnRygmbMao0AfmfNBEhqHNTTntKA=; b=npidHdHZBvw/YUuzFwEZHRc706
	puAZAh7sTfNELtOFIWJrxjVlpw8+IrRgx0rOxCBDGBybVdMSSAACXp/mIwLIYwEA
	/2xozW+CsCuQCN/DNNClEXVL3oXopSYtiiCnG/iMpYTya51Nv7ztQQD9Pj+UZQ7v
	va5Bu03Jwe0MpGLBSgqmqZmkpECcWs5q/SF8gMnvmCDy6eKG6Q3k6eeyzgc5lGL1
	X9q46JXgvj6JyUiU5rPWB3jsyPZ9ODPEmBCUfbrbtDt5CURjkmgbozXzeXRzu85y
	IK2xOnb4ONzK7U3dgxYxxAu4pT0xMtCcy/RcRa+mIXJVz76TbZzbFKzUR5Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742856486; x=1742942886; bh=q0nxr7bTnNCLqR+RnRygmbMao0AfmfNBEhq
	HNTTntKA=; b=vXMNyGw2kUW4Xfn78SaWgbJL1G2lMF3sLHZBL/HF5hGdOwY+bIY
	zhGX7Z8IeNl5oJIUsnUx/hjmWPHS+9UQyYgs9CB4wsvddvw7dNZeOMu4Abt4FhsZ
	KJgrF4S822QN1l1LzW9WU4olBh35ECpDjmCD97vSETxMj2RgJFY+EMxTEshDECUl
	KtgLD7TsAyPhm7kXWpbdyHXk1HydC5LvB0Yg2B/oglrrqhrvs4AT69Gd9U8IMDmg
	XpTh78C0n+t4WagoFik8EeHBq7izfKg6GHEXIEtAF4ujB1KlqswgP+nwAaXLMmSF
	u8RclN9yWXHLhk+3JV3gcVZAQHGjVcFaU/A==
X-ME-Sender: <xms:JuHhZxDUxZ01SvuvheanWCgGHBgKb8XurWnsF3E_oB0iGLiu60Fq7g>
    <xme:JuHhZ_jGd5AD8mV_0nIQ1DNNRsZ_n7xRnmtJy82NJ4YdR8n2ELBHP9XViWdOhhXjH
    0Fgy8RLsBMPiM6bWw>
X-ME-Received: <xmr:JuHhZ8nfwpNaLwxDyA7O-TuitvO6VjCvI6UpV7IOXvXxgS_du7c3r-QWc4Dak22Z72hgnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgr
    mhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeffhe
    evteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheevledvjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhooh
    esuhelvddrvghupdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JuHhZ7xKN98Lf8eTh-7QihuBfrO9GhFzK8NOx5ziiLvd44eN0ap3sg>
    <xmx:JuHhZ2R-Q-HDFYUgIVrMKlyv2B2J5OhoOLHKj43eEp26AcMzE4c-Kw>
    <xmx:JuHhZ-ZEYUpKovsDSjOnN6CkWyKQa1fGXlsBPygAaswwNSCkvUbBow>
    <xmx:JuHhZ3SL9nn66Q223tJGznBnw_fBZ8A5jsf27etpaoxa8qtH4gpZyg>
    <xmx:JuHhZ0chO7V0JxR8zQO4dsYEsr-KNdBf4xIdtPj2C7RQ2fw8SA_SGFSJ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 18:48:04 -0400 (EDT)
Date: Mon, 24 Mar 2025 23:47:12 +0100
From: Fernando Ramos <greenfoo@u92.eu>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] vimdiff: clarify the sigil used for marking the
 buffer to save
Message-ID: <Z-Hg8AznMSSuZpvb@x395.localdomain>
References: <20250324205327.79627-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324205327.79627-1-ben.knoble+github@gmail.com>

Good catch!

If I recall correctly, the very first version of the code used an asterisk
instead of the "@" symbol... but it looks like I forgot to update that part of
the documentation once the asterisk option was discarded.

Thanks!
