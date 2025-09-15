Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491D276045
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969583; cv=none; b=FHP7n9Xm9PUfhsWy0KmCx95RJNfYV4oGUwI/oDmm147nebNA33gbfUfCu91nqN/KaPncJhQCL6eOzAY072pvr9/Om20QGQkerSl6Px3rh6Spn7OuP1dJSwlgLDvpHjVi6I2XpYAgOpjRPw7uUYnSkRnxsPl9WFYNijSgTYvquu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969583; c=relaxed/simple;
	bh=x0ud4sG6mNTTpg9eTiwbWPvsvtUG+4Gm6fhYiPZYV2Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lZm20fuyUBotnEyS/iTFhnHPHIR5V2GX5ltRJcPxnxvcuqXKYv/hPtjZzyaFuCOd85g6e4uSAnR8mMkweg8Nl3WgXX1cf+GZbm7meqwyVZjMj/fZhbE84Q8RJtv999cuhtYhCG4b5zhE7ON7j3W6CW441F/Uw06+xi3M/DV58bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=YZiRyhBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1j0HThM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="YZiRyhBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1j0HThM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F33D1EC01FD;
	Mon, 15 Sep 2025 16:53:00 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757969580;
	 x=1758055980; bh=KrXJgK5C+6ltxlHNpQZK/MySoBm4DJ6Q8H+XW3SXQE4=; b=
	YZiRyhBG+dYsL5UY5iCyCLuo9ZnYXGAqsGKTHbVnuT94+49i7LmGkx+U3rq8pYwr
	8FFFCS2cYgUw5yM0Q3IkQbfxfzqlRWJSQGI+YAB1LNnpTRkzQeKC/FS2BgC05yC0
	840/Pn3GHZVtzHSgcK4N0ouD6UL8D49P4z668uo4sOfniXrUaE67FJuejYgAqVxv
	2wwGeM9EwGX0oOzmZ7Idkg9nGrbA+gacEyiOtDui96vZOCS6dj8xJT1lXpXfFMqx
	bmfL/QRnmTJY5Rm0qcTwdhh/SbG4nAXfGJJdGP2gLBfgm7BkLp9eRji5Ux2aQm69
	88NqTUdSEcOj3xyf3naNWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757969580; x=
	1758055980; bh=KrXJgK5C+6ltxlHNpQZK/MySoBm4DJ6Q8H+XW3SXQE4=; b=V
	1j0HThMd1lVpV/RwvYV48jAG0zxtfIyJx2p2EwNwt1W0YXp26r5l5+GLCvovOeBz
	4cdZlP+KFwdd/xXDxVyel3JQTpAsymwJgB3EDobC8tJb4oEnNfIrI6FB6+mcNqZ+
	LVjOzT7LiJoqlg2EfOUb38PL9bD5BUbFqS1DdpttaTa+jKf7URH7yONc7fj/87it
	+T7OecRlGD7BhyBGIIkC6LJL6oDt7dVCpK0E6TVSBIJ5yo3FgdLiKp+ikRT8sLIU
	oDpzJFqOWycahTvvbHMrzVbLj32IhNFCIfk7wbkDIQDX4Gy2FdH530iXJ30ORpUs
	hVNa3LAKYECRwBHmc9vFQ==
X-ME-Sender: <xms:rHzIaPyH8Bb7D3thMLWyiz42F7NxsY75OZ6P5WicxyD3S0TgzBseUA>
    <xme:rHzIaHRq3AoFvlr1mCfGANycBL4UQyI2d3RugZDj23r0g3a6rHKI_9SdExPUwc-sq
    3CMsUaqQafuRm5y5eM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:rHzIaIbi3OJoojj0HaD8H4iXtNfJYrDqLwvuY6u7iPNH7sD2tTwMMw>
    <xmx:rHzIaMUwFRf5pX7nBBS20NValrLwits813kP17Rm7LbaKJgSt47ETA>
    <xmx:rHzIaOgJrP-ka7Lxty_bn3Tuugsnm_AiutWCRRUm1oMTc6YxLX7W2w>
    <xmx:rHzIaCvpd7aBtl-nibwQY_sRSvkB1Hfbl_bHHSpRGZtid02890dukQ>
    <xmx:rHzIaIBzK3t-S4e9pfduHTdY84sndWkjp_0VBs44YaKeLs4CQaSs5FUC>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A792F78026F; Mon, 15 Sep 2025 16:53:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1HKGT0kA_O7
Date: Mon, 15 Sep 2025 16:52:40 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <8d9dcb7a-179d-4124-9f3a-158574825308@app.fastmail.com>
In-Reply-To: <xmqq1pobl66w.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <374740c678a62edd5cb5bace7517a36ce7ac00b5.1757703309.git.gitgitgadget@gmail.com>
 <xmqq1pobl66w.fsf@gitster.g>
Subject: Re: [PATCH v2 3/4] doc: git-push: clarify "where to push"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> Be clearer about what we're describing ("which repository" instead of
>> "what to push"), and start with a positive "try X, then Y, then Z"
>
> I forgot to say, even though I did spot:
>
>     "what to push" -> "where to push"
>
> "what to push" is the topic of the next patch.

Thanks for spotting that. Will fix.
