Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2094320A2E
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934960; cv=none; b=XYApzNQS4lK0jn8tPH++swYE5xZ3OfIwuTfGCHwqEUpKKahklSorrxk6nKKqpmYY4f3CdZAOgM26bKhpPI3KcDZ6+KWlOVqgwXn0zragD/sKVRM7e+jZy7OsBHZfKONwf+lF+AYUR9Q6gjHkKdlQrfnDhm4mRyEqBPyugL0qYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934960; c=relaxed/simple;
	bh=ke/rbpen3hPkueuQMBbbBVhsfugNnin+P8OMlcL2mcc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TEGY5jO5U9lxAW0Y0gwHAXLn2/iAUpbbq6+r7yKfks9nbF6YfzL/iRrCgHqS4cy4ZRucs/Z6KRxXbGS9BsfCV5ERq44p1FXtcX3M4hp09qh2CCVyT7QnV0+KVyHqI50nNBoE+N7OpXBOeCog2TLrc1NdvyyhstYUPEGWCeJTXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=C67RIljN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tayhFJD9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="C67RIljN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tayhFJD9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DBACDEC0173;
	Tue, 20 Jan 2026 13:49:16 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 13:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768934956;
	 x=1769021356; bh=PbyPGiyFopjUhfpxF3+nNkoHMuupJKWQSprsrqAy8dA=; b=
	C67RIljN3NSTiFUvlKSglleOiEy/1UgPH9xBbn2zkkKFCIEazfe4jhyV1kFn3Kzh
	AR1Ho6kpqGmGEc8ahqWI2zs0vBNhQyxt/vbubOjtTeU71JpwAJY0RyTGcsrmNi2Y
	hvhk2M+HNd9h5PvP5Z19PEUATj3Lefd4FhJXmm/r5odOJP2BMhzdnS/ZOOTOg8BQ
	ogoH1AHfNZdqR2yMGc8KzM99FkLIlLOrXYIYiquAnWtztrLm/C3USwRenNy7Ub8M
	SUk49Xs6seGPjkqRjN10w0zmb+evXiNbL5Gc1d336gCRQDohDJ/v1E+EPbEvyoH9
	lem95kTWLcQ91ruxKrFF8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768934956; x=
	1769021356; bh=PbyPGiyFopjUhfpxF3+nNkoHMuupJKWQSprsrqAy8dA=; b=t
	ayhFJD9tPQPoQxrZkwfR4gtZpXm03CIggEhKveuQsOUCDq1gAO29pzz4uYdHgplK
	DwU2OiRWLDYGh0oM7cTWKxpI+bpQY3/if8xv31nunToF0Ibb543whLYUqwVVbBRt
	jcy8HeCMlSo6luCBcn/W9ObMzoKmverjbB+lOVF/UbyfY7TzqHLmLdXG7f6ONVbj
	iK2l1FfF6jvub+1Ik12kARVS1O3OP5ELsVZNdcHZgpUDM0MfDNpwdunZFJGJnHQR
	PXS1ihHMtHueCB8a/wRUmo2RhuMvLvQw8bXeOrEoE0UoPc0vlBvl3hBRT6riPD4E
	GP111aEzJ9GbqvSjKw7wg==
X-ME-Sender: <xms:LM5vaSbbiuKFgBY0oKavh3mwywQaI7oS0yGTS33k2neBVHQmxAPEPkw>
    <xme:LM5vaQNHmgxuxMYeBFbTgZa7Qq4sSYrEiEGfDTeTo8-XpdSx-NkXoocJ9dLUMjNnG
    XsHZOqzFuIjo8FvyWzimvu_wXNljGp_Ml89k_YRHZ9HSOzauMJG8KU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LM5vadAGAohI2zFbznchCBz_iaYg6UvF4AMLYI4Z6jWXuZ2SosswPQ>
    <xmx:LM5vaW8UUrGDp5GXHVts94nWEjiHM2P2koDI8dvuLOG-NL1M9DFczA>
    <xmx:LM5vacGAjd7mzq_0KEq9_m-Kl8MYRuoDGxJmlq3qyCQhI_LD9aVrXA>
    <xmx:LM5vacMeBg-62HkylYZK4u8rUZsNcJsM313Alorx3o5sI8BzDBYSFA>
    <xmx:LM5vaUzvckdqlxVH_GplGXmgy0DqHxHiLBs5WlreBlwTslS1tLNmJ8Qs>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65A391EA006B; Tue, 20 Jan 2026 13:49:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai8Eq8lg8y5F
Date: Tue, 20 Jan 2026 19:48:56 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Git Mailing List" <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <291a02b3-54b2-4444-bebf-7d7a9265f11a@app.fastmail.com>
In-Reply-To: <xmqqtswgywb4.fsf@gitster.g>
References: 
 <f10c3f680d58ca0abbf795ae8b0f2ad14ab85419.1768906910.git.phillip.wood@dunelm.org.uk>
 <5a4e7da4-d295-4beb-9f37-b2ce4e10df35@app.fastmail.com>
 <xmqqtswgywb4.fsf@gitster.g>
Subject: Re: [PATCH] mailmap: add an entry for Phillip Wood
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 20, 2026, at 19:26, Junio C Hamano wrote:
>>>[snip]
>>> I'm not sure if we actually remap the address in trailers but
>>> we've certainly talked about doing it in the past.
>>
>> Yeah it does.
>
> Hmph, are you sure?  My quick experiment tells me that the trailers
> are not munged.

I was working on state that it turns out was not in the email thread.
I jumped to the conclusion that the question was about git-shortlog(1)
using the mailmap. Since that is the only place where I know that
trailers can be mapped like that.

I call it the curse of invented knowledge ;) sorry.

>[snip]
