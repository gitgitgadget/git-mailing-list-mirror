Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E734F491
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732209; cv=none; b=egtqQagufKv7ne5RmyXCcxuuh4bVAp2iLR+cFVmHeUsIOtL3dp1Xck9NrgWSO/XKgfm2xWMvR6a10fJrnnjWy/5FKwFT86gvWpKbLP8OggOo1G+NHyEYJE1hx782FStpIvcN/SLAGAm6WUlavGqSRhF6w7hMSTaGa8U7YzXNRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732209; c=relaxed/simple;
	bh=FDPLWFxfXOeBK72RoC4Qnhltrc6DskPYQqHzfxkbfkE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BCeIELziJcf96sHln0r5JnpoJXnM6qSjIj6/c2RbBqXR//r37lkqWFl0NM0A+Rwuu60MLUI/OWlpST5nYI5oE2b+aCPzVRnhiHcRHt/E2J+hNCD6EXigauS6USkKZRxcJDK4Kshy9RKMDMkRoK/sGRaEyDI+eNmYdZcmWvyv61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jNwpT0+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYY/9HMr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jNwpT0+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYY/9HMr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 895687A0139;
	Fri, 21 Nov 2025 08:36:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 08:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763732206;
	 x=1763818606; bh=eT66E6PK2iC2dzUiOjoP01LGjCkmokBtW4FrgOSi+M4=; b=
	jNwpT0+n9XoBhLQhI9TYGDBN9rhlsu61XIIYevxdaWY8AT5+gEJT/1QZg16VuKaG
	Bqcy9WbO//IxsETz9ZL9t7Jk33O8hHOT1o9RqdEQp7/dVHc+rWVLpDYp05hgYl19
	toJluk6NAlpjDNGCKXe/lst5GqpZDs+x66ua8rbcTLrKCd8/VBDOjyiWVo4dHSBn
	QorjpzteG72yEeRHDAddwtAIIN51P1Jbmf1HPZFyQP06KLbsi/nkUKlZ1ma94Ckh
	yg8Vvza61uF0dOBl+vRtmqhsniY5Ha0TGiaj3XmKm6Ta3ExcUlTCwjUnCKB6bn2N
	FDQWQPm+xY9hP41hobewVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763732206; x=1763818606; bh=e
	T66E6PK2iC2dzUiOjoP01LGjCkmokBtW4FrgOSi+M4=; b=NYY/9HMrLq0QfCVce
	0J9+i2nU5aM/himiRJpjqZvrLGGEc1FBzdDzZ/88lBAXU8MNsdlNYKFXi7FV0mY0
	jQ8wtTfvm92d83axYSLE0F72ShdQKWZ8lMA/O168FQTQ4XItM3TdCfEzZW54dAzc
	MQEuRtbMN4CLKFPmVItQcgvP0Amq65qIJrS8/ZrwV9VbIKthou0yq/TIjrw6Wp+w
	452zasY3On5VyUih2dxQJH0W1ls6stPf5vYKagtb3A//PZsg93iXywircikVoQFN
	9ZETZOhqcsz2vYrMfeqz+edsmbZu1mQ5zNBUhYDYpiaD0PlZAxIUahxKEzl5Ufyw
	LMcuw==
X-ME-Sender: <xms:7mogaUpX7hTd37YYPJhhKuLT7IK3RcgDt9CeAyhkxr2PS2e-gEce_Os>
    <xme:7mogaVd6rovRcO1-IqqXgAUd5lHsfzTfXdNtphtADfNA7vNO5_8FwBVT5aQKmscLf
    YNnF-jh6iyFB_FvuG6tY3UaY5awWJkRjbZ0cBHLp_YBGEjel-4kng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepffdtfffhfeffjeefffettedvtedtveefteehgedthedtiedufeff
    udelffelleejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7mogafUkBXZKfbMYXxc2OlaIIUqWKRDur3Evd9aJutRFLeRPUieMuA>
    <xmx:7mogaVgjG49PLf_j85wly8FjPYJHcyAyjxwcuTOA32nM2NdAtRQyTA>
    <xmx:7mogaS-aNR_ng0hZsvhwGtnrczQvkFrvebhWRuP-bGr09CuIhf-ILg>
    <xmx:7mogaXDLRPVyOoiP5cNBwoJkTGKUfdN9Uf23nl2Lto4MVqcZhRRQHQ>
    <xmx:7mogaS7-7WMJ-i6Z8zSN7G7to3LEYdXt1CeH5aBGRmS-DUYQmZd8bHZJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C7231EA0066; Fri, 21 Nov 2025 08:36:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjEcWmrOR-Xg
Date: Fri, 21 Nov 2025 14:36:25 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, git@vger.kernel.org
Message-Id: <328687ed-7fe6-47a2-a76e-7c38932d3914@app.fastmail.com>
In-Reply-To: <014801dc5ae9$543c73c0$fcb55b40$@nexbridge.com>
References: <003901dc596c$40bfbd80$c23f3880$@nexbridge.com>
 <94d81164-5af5-471e-a403-f2d544796d18@app.fastmail.com>
 <014801dc5ae9$543c73c0$fcb55b40$@nexbridge.com>
Subject: Re: [BUG] Test Failure 2.52.0, t8020.16,19
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 21, 2025, at 14:18, rsbecker@nexbridge.com wrote:
> On November 19, 2025 11:25 AM, Kristoffer Haugsbakk wrote:
>>On Wed, Nov 19, 2025, at 16:50, rsbecker@nexbridge.com wrote:
>>> The following two failures appeared on NonStop for the actual release. I
> did
>>> not see them in -rc0 or after (doesn't mean they didn't happen after
> rc0).
>>> To my eyes, this looks like a real issue not just on NonStop. It is 100%
>>> reproducible and is not transient. The build is with OpenSSL 3.4, but
> that
>>> should not matter.
>>>
>>> expecting success of 8020.16 'cross merge boundaries in blaming':
>>>         git checkout HEAD^0 &&
>>>         git rm -rf . &&
>>>         test_commit m1 &&
>>>         git checkout HEAD^ &&
>>>         git rm -rf . &&
>>>         test_commit m2 &&
>>>         git merge m1 &&
>>>         check_last_modified <<-\EOF
>>>         m2 m2.t
>>>         m1 m1.t
>>>         EOF
>>>[snip]
>>
>>Also reported here https://lore.kernel.org/git/4dc4c8cd-c0cc-4784-8fcf-
>>defa3a051087@mit.edu/
>
> As a packager for NonStop, my team and I are trying to determine whether
> 2.52.0
> can actually be shipped. The concern is, is this a defect in the test code
> or underlying
> git merge code, and if the latter, how big an impact. If we hold off, how
> long will it
> take for a fix (approximately). I do not know the merge code, so...

See the email from Jeff King on that thread https://lore.kernel.org/git/20251120081611.GC1283645@coredump.intra.peff.net/

By the way your email client reflows lines so aggressively that it
breaks lines in the middle of URLs.
