Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA830C627
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205228; cv=none; b=EDdPoPlv+f5VdUQwiGuGWY4VYexXbDLaIePTRrW8ptFUSZbmxbJ57iBdbSKQK6+2E4iLApXLsSfLhsxaqZ9Exv4SFJgvzvd0ORJqGT8P3QbCPoutWGOfY0HBxTWtdEVnI1khP3FhZxrRXTfxjnLCKUgrWvBd+6egPaaEmjh/IYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205228; c=relaxed/simple;
	bh=etyE8ujbWC5fRP5m15SwPrKYDQ4TYYu+ShgjOLG8dBA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iBLdfRHX52eATQaKjGjClSV44P2b1w8QX01xvils/TnpHzdbCHaprVA4tsqONRqglnvVbMR7BSDnzQEwJahKkDtBLPP6++lImfqFjWeA0jemnDEyOtbkBIPZ8YJOC7xblLFgejsxeylvYyRKLwuPbnZq60r3R2ic5ayHzx8HG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=UL1E3C+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZhhhsQI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="UL1E3C+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZhhhsQI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DD381D00352;
	Thu, 18 Sep 2025 10:20:25 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 10:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758205225;
	 x=1758291625; bh=hannvoAbHUkQ7lCU/nnwzLV8USP53o4Oeko35ydgwV8=; b=
	UL1E3C+GFAE81S4N/2F7VIWTWUH4yd5MZWT4owopixOC6aEBa5XzhV9nDGfJGphR
	ogV7Rlvv53Kk4NRg+rJRTOTHi2Q7539YkVyUBuEH7qgRina/HpckQhF+fHIRZ5fv
	FeUoVRxhCorndiDOAnlyHtjFpqnPRJBjC+53x5ZYMtmZGmONWX4sSXc03TihHuiO
	U8BXyQ0HM9nJnwOQnyTF8r7y4CotKtdPncd+ux8trcNXjIGSD1w3ONOj3PzeDdkD
	4nHlhLoMU92tg9eDuuENhe/X/dcO5rb0+2YT+U3D9FJ71cqd7k/4sTy4mrX9hrC2
	YxAPknfaNlpmQ2MoKYPbOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758205225; x=
	1758291625; bh=hannvoAbHUkQ7lCU/nnwzLV8USP53o4Oeko35ydgwV8=; b=l
	ZhhhsQI9ZORG2v+GNOSZKrNbt+F9LLjuljAE/J1CUiSDphJw2RZn/Smm/Lvdaa7Z
	b430h/+rVNdkuIwdj10zOOvwsQ3P9DqM6RO62VP6WvTQ/Ve2e3/Cyk35pubpHVdy
	X6GJ9xbhx54wQmYZ1F2MifC7NGq9nMPDjalgL0AhpfKP6ikBR+DOwXp+VhEjzAtj
	l6Y48CzkEGX/uYNo+O2WWQo7S90bykBzvWZ7bDMy3vwrOgP2TKDY5R3naPo7e3jJ
	hvO+NTtPITZKYT1gXGpSIh4SaVTePK9tkhtPNGwVOg5xhqYy0Cq5QgUO19pkcJ5y
	dl167qFg6Ikx0mbQNmASA==
X-ME-Sender: <xms:KBXMaIDSrma_8UggcjL0YOp0m6ISgVZ3OuKbJnuDpcmldDkxqK8pOQ>
    <xme:KBXMaKi8hB9x5aZondnGVN5U8Je_X4VPbnHO5DhGlrm0hc-pGTt634v4eu6dpfn_I
    OzAGI4DubZoDhEyAgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:KBXMaGDOZ5UTWOIAGZ5rRhES5MNwDL8EXSAI_0PG6OXGtsHwcdtx_Q>
    <xmx:KBXMaNrbMpY6J2o5bqcf5ItB0U96rRRNj3jVb9PuKtJIdhJPye1WBA>
    <xmx:KBXMaInRIWI47mqNytFZEsKcDRN39qZpAxNdkhEB-_TeEgIrTD8B6w>
    <xmx:KBXMaFyVLHlMqXsV6pdUAGyJ4UXbkOPFb4m5IxgJV7D7IUzCapE9uQ>
    <xmx:KRXMaJTok6ib225B5pAdGflSrmS4cX4zPRT8eXI0KJircn88JG84DoGE>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B78D678026F; Thu, 18 Sep 2025 10:20:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2KDzlJCb01s
Date: Thu, 18 Sep 2025 10:20:04 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <1af0f455-1ee0-47a8-94c9-5a3dae636781@app.fastmail.com>
In-Reply-To: <xmqq348kdipd.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
 <xmqqjz23l7ci.fsf@gitster.g>
 <70034c35-8f08-4ee0-9017-7faf6f55ae14@app.fastmail.com>
 <xmqq7bxzcgsj.fsf@gitster.g> <xmqq348kdipd.fsf@gitster.g>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Let me change my mind here.
>
> If you are trying to avoid overwhelming the readers by carefully
> trying not to write things that do not have to be said at each point
> in the teaching, I do agree that the deliberate vagueness I
> mentioned above is a good idea.  You seem to have better "taste" of
> knowing what the right amount of detail to give, a lot better than I
> do.
>
> Please keep these goodness coming.

Thanks so much for the encouragement, it really helps a lot. I've
appreciated your detailed reviews.

let's keep going!
- Julia
