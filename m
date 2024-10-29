Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44237200BAA
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235241; cv=none; b=eQldxVKMNT0B/AgbfY+kjBPnAcbTXuoxKUkiEMxbhpswsFLgqgTAAfF78pYhlINGeMVb7hcwamV4WvF9PlCvOM+XG0rtvXbPVuHUoV1ZtOTs7PBybVC2ggi+hg0YHog6BaioRpvHRKP4GPJsV/87rNXIADOFXO+OAR44bpOmSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235241; c=relaxed/simple;
	bh=U8BdLXfbACqqspHm4QdApNgbOi2+yAN1+PPBUHOUbY0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hYeRr6J8qqD+b1rxb3HVMruQreyawmC2Qm+SsGV6MCk6pxeP2XuWD8dUwiltWG34r/9XBMcNbhW2uxhCnlwDeeDD1UJ7M9qLep8RfOEm/G2eGoLgqRPepvrnhTU7v1yQ6IsMIaMbRSZUtDbpMSrvPMdaPYaj6u8EsbsS8u4d1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TQAokfKf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8opMqtI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TQAokfKf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8opMqtI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63BF6114018C;
	Tue, 29 Oct 2024 16:53:58 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 29 Oct 2024 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730235238;
	 x=1730321638; bh=BqQu095fVOKHPd8NEHeLIhgcIfCFt68o6Eyn/LfJFhg=; b=
	TQAokfKfOKxJebkkv8i4DN5Z2xSZ7l7NYKEtwPOrL4wpqlhjRw8vxMMKQpjEbEIJ
	YZMCDcMtroIM4VZea6ZF6cxiUDOXzRWE1jofZB9+x26CUCzcGJeAjGeB1qwRW6li
	oeld7eciOtyIEkfKZnNSo9u3tRJ28C43/5br0EzZY+gy07OJNVZEAdz+ZumyHEF2
	RmOTWFx/VdshX+nM6335sgEj/UgSszl3HPG/XNvooX25z7r1ouFydXO9ci3OgULx
	B0jVOZlnSaKvJwdwBpvKagyj6ZWQGyWjvYqZv3D4YjDH9JkrXH/D2nACcGqgkmQL
	6Wu+2guff8w/gIxlFB0Oig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730235238; x=1730321638; bh=B
	qQu095fVOKHPd8NEHeLIhgcIfCFt68o6Eyn/LfJFhg=; b=f8opMqtIIrGweHq7F
	AY0iqAQrzKSVXpuHHqBTE17/+6sMtOF0hI0P2nU0DzTe3RJ2zRaBqZv+5EyX//Ce
	YVceD1xvRFypH3GkafRbjZGnvdt2KUg2iIqQGLFi+BFbHe2BdAT9ACBicIOm+2YD
	w3mWC8+ZKC0EUmzBIU8Q0h2Q8fvHw021+zvTV4bP9lFzD897Oxtd9Nz1FtruYx5N
	28AMb3+ZG26ID9MzIHvR9so0TU4VrrKsbnMcYFv48p/lss1KFUBoW7Q5Y+Fwrx0X
	rGothvtfnHPeOqnazAX9clKszfp/MVutT18zqg53vWbfq22aq0Qv2gSIEltmagXB
	c/6Vw==
X-ME-Sender: <xms:ZkshZ0SdP_pSbdpMxKYMjFHQ5emGKGUSEKs4kSjSOjbKakj5vJqcjaI>
    <xme:ZkshZxwqB-9FSKwpr7zQ3XxjXY2iIiWtIUEdi6hqY7k_UOgTC5KMiPyMmw8IV1_6O
    Epg-FOpVWfyoO_ppw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeghfffteetledu
    veehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZkshZx1uEkeNzJb4LuDewjwA8v6KxHOdlbyug6au_JPWZi1dqfQ35g>
    <xmx:ZkshZ4BcZr8MZ6p-1Gsmk2MZDxBLLghXgu5yeis7KfWtdnZSInDd0Q>
    <xmx:ZkshZ9gm9PfvkRhjMPaORiuZOU5Uj_1U2pEU0i13tbkLCUIKH0uIbA>
    <xmx:ZkshZ0o24Y1glHjbC6TVW3WuwrtNVUUqCrJTuGlHmjl7Bo_PW7bVqA>
    <xmx:ZkshZ9Z3fDkxxKbKY7rQ9icHI0NT22a-6vA5tR4HehkpOGxaRDIRhA_D>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 327AD780068; Tue, 29 Oct 2024 16:53:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 21:53:37 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <7a0520b4-2530-4660-a858-1def0c8d6de2@app.fastmail.com>
In-Reply-To: <20240912205301.1809355-3-gitster@pobox.com>
References: <20240912205301.1809355-1-gitster@pobox.com>
 <20240912205301.1809355-3-gitster@pobox.com>
Subject: Re: [PATCH 2/2] strbuf: retire strbuf_commented_lines()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 12, 2024, at 22:53, Junio C Hamano wrote:
> The API allows the caller to pass any string as the comment prefix,
> but in reality, everybody passes the comment_line_str from the
> environment.
>
> Replace this overly flexible API with strbuf_comment_lines() that
> does not allow customization of the comment_line_str (usually '#'
> but can be configured via the core.commentChar).

core.commentChar or core.commentString.

-- 
Kristoffer Haugsbakk

