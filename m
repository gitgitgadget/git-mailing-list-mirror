Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134A2DC339
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514356; cv=none; b=lvB733Mvyg65V0knM8FBitR8Tv0lMcqUL2K9aOCgknnXDXbZkKjIyx4HnSR7usBTn7Y694uzkhEwoh+837YrFR9iJNo+ENqpFfF1wbQ7ugBn8hXe5EsOP1zXP3CuRzlwVbE6cTjMvNJF212ZdJLildIWmZeUQAqeGjBbMl7JaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514356; c=relaxed/simple;
	bh=liVcZjYHXUMyPkBravcgfReOzQdxtfELUZZo7rG6cOo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JNSXqZ9CozZEXBBMPg1YBfHJZYZ11pDeYbs+c2R2XxIz4AGFVulRKqcQFghleoiwJWX73ABOVGRdxnxeLLJmpm3Pgqte6/ZnliXaLPWWQxu0X864aNW6+lKnquGz+5p2bbeUwkyzc9C1R9SQZKgzBWEVy/KtP6F37sWEVDnnxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Bx9nsmm3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FOzYifIV; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Bx9nsmm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FOzYifIV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 210851D00158;
	Fri,  3 Oct 2025 13:59:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 03 Oct 2025 13:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759514352;
	 x=1759600752; bh=liVcZjYHXUMyPkBravcgfReOzQdxtfELUZZo7rG6cOo=; b=
	Bx9nsmm3nkeeYB7khiYYFHZApBTae5W3DCh+hbWWiaweK0blGw9cDRfExO2ECScB
	auDGJjdK4yrRz/cj705ADNvU40VSBhMxuG+2iIzdgNwJbU1tve8+kbQx9I3+dyzh
	J78lTSNQImiEdChZ8ZuJEh1+CQhyCBsFU2kq6Oq933FTJVX7blwxU3y9zV23eKOe
	oeH+OhBSN8P3k+wBCKcX9tQ5xc1EqNZKa3S3TL7+vt1nRQZBqJe+pqEtYUv7Aiyj
	hINBe0hfbjx7Hsi1x41NFc2eLyOmI+f8AdifG2EBh3kLuR57bTgelROW6qE6RWEm
	pBHD9tDaprH2WEs8/Y6A1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759514352; x=
	1759600752; bh=liVcZjYHXUMyPkBravcgfReOzQdxtfELUZZo7rG6cOo=; b=F
	OzYifIVp/KYTn4ppcJvnctfBDlBAsASmloxR3gFVTVHzMFJr3PYaB3chuprWL0o/
	c75umQ601LljS18YPo6Y/EZWnHDb9rihG8QvLK5I16IQTf7dLbPokWJSeRGX0jjr
	3oMMpFBLrMTq4NhnK+akFlyW8wrAktJed2+xLTFVocO0F7quVOZtYo8JCf6Bqjas
	33/5GO1iAh53mclJLWoqVbTd1UtkN+ZXQr6fBPxTO6A277iN7PpNqkq9RaGVayiS
	mUaQaODXQbT/rt5gEOKKlfYl+pzA/DUlL0C832vtKt4qmSivunh8HumCMk0JIOqb
	QbDZzIAQdRG6I/Pi0Z80w==
X-ME-Sender: <xms:8A7gaA4J0v0siZEwXUIR66TIffQj9c8LKm-KmtQmViPLViZmeMlW9g>
    <xme:8A7gaMtCBx-9cNyRAdv8WoGsQKOZ4PrOwk5XxTRLGFhtvqjuwwHJcLMRWXxA7l3v8
    NKSxLVlvEhHxHOigJUu9rDPSGKv9rgOllClZsyS6-hmUubdbjIJRH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8A7gaNg4eS16sjm7HoIftdsynqdKigxN20DANyCemTt5mRdb446y1A>
    <xmx:8A7gaP1R79VZqsbXW79mag0_e6XSbG7ZLBKgG98MFAgG3ItrZoHq3Q>
    <xmx:8A7gaHhsDMOlUXJxXmXIUAEwuoNoiUOluKrwJOGmU6z9-2V37k9Ofw>
    <xmx:8A7gaPdM9JJw14UDpIBiasdePPj_Bzut3iDUh7HNLRschauYi5HeSA>
    <xmx:8A7gaOm-te_AciNNQ-T6KZ9L7gD5PUfYRN7whlioDt_9h7pCbegFRYwd>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2717780271; Fri,  3 Oct 2025 13:59:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Al3T2g8z2sfJ
Date: Fri, 03 Oct 2025 13:58:46 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <6e1233e1-ef57-4b3c-b9c9-5d7dfb654ec5@app.fastmail.com>
In-Reply-To: 
 <CALnO6CALtO_5Na-TyfuVK6p9A7Ufn7bVVMcizcxv+8hWmL=Mrg@mail.gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
 <9435f0ce8db946b6b3462ef9923503ed359b3379.1759262314.git.gitgitgadget@gmail.com>
 <CALnO6CALtO_5Na-TyfuVK6p9A7Ufn7bVVMcizcxv+8hWmL=Mrg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] doc: git-push: Add explanation of `git push origin main`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> +The simplest way to push is `git push <remote> <branch>`.
>> +`git push origin main` will push the local `main` branch to the `main`
>> +branch on the remote named `origin`.
>
> Perhaps "For example," to avoid starting with punctuation/commands?
> I'm not sure if that kind of thing is actually confusing for readers
> or not, though. If not, I'll stop recommending such changes.

I don't think I've ever been told by a reader that it's confusing.
