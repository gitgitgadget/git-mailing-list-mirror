Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9142236453
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242738; cv=none; b=CSNAN5kIP4/SKTOh2ypY0KTn55jB5lwLUIX3Hb00cCyBmt2g8HdETDh7bFEb/o8ds0ztmZO29tF58j7g2W/jcPz2DrGDS6jrfIkIkClTHJyrm5aoMZzZyOYFjShwCjNvbwVFhNkEgexGo24g3wltYf0x8TLFHg+vMZ7cYqPCixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242738; c=relaxed/simple;
	bh=/DEQYbc0w+aNWT0MIjGzv6UgqDvMFePiSGqXBhjfB3U=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZFvy0vrWAhNNM5Oh+Q+LXa8TKMuPmB7W9B1RTW7GxL8iTONv2+ZxN2actGFIZXJBDb0WmvsqD7q9JlKxHBqTqlzIqbBXw4F6GRrjCplPQLZ4aFijgXdw9kSapVIrUULhlBIr4rWrzoScajt7jq59RoAC4NSZSf2RI6bJK64L0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dXY18gUV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LyGFNngj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dXY18gUV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyGFNngj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C34E7A0191;
	Thu, 23 Oct 2025 14:05:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 14:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761242735;
	 x=1761329135; bh=/DEQYbc0w+aNWT0MIjGzv6UgqDvMFePiSGqXBhjfB3U=; b=
	dXY18gUV9eP9ygD1EnSxdB+xI+wqsbkUE0psHqRuQwhfCnxNpRYtkPoxekyh7MX+
	S/7YIPCw5p1bFnLK0MTo0Ot/w8xI+Ky2XPbVgGtgurCSL0dhLNj9Ci1JAovDWfer
	3Fa5ma+yGt6Cx+50ma+PSHVl6niijqtu+La3p+LZSlQJbqUOu0ZjefUYF8e3U3vi
	zxUwojggjoosQH+LF8DXrX9YY8c0bvN4b2xV3vzM5bVBuMxl/bCfBv5ly909ZYEf
	XPNClkpNzAKV8eOgHnoXo5Wshn+hvg+c8/Kk5+84AG7ZE3rqjJ7lk6shFGYzlUoq
	f/RrquB+BoC+YU7IjaO5GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761242735; x=1761329135; bh=/
	DEQYbc0w+aNWT0MIjGzv6UgqDvMFePiSGqXBhjfB3U=; b=LyGFNngj31SQdtwsn
	m33p2AYyzg65YrduIguCpX4qecCSLHfHx22JqsOpVWmb+fS/fROUD5BWl4ojGpxo
	4M9Lw38h41j/2FNvG6ltvFOwhMkQyxb7+/twSZyiIYi+G2FnAPEhttKBFLj0BfxE
	qjvJ1jNEFvrGU3XW/wiVGUOYP6BK4DH8C8hgeu6wQiZ+5dWBzdoMztua4BmwoUH2
	miuyFAJ8PK8MAeOGp2ZLvMUvAczwLRCdlwkesSijervkS3Vfe9WKxfMuqNHKJ4er
	gSuntiV7Kr3zwULSXAZu2IDtaO+LafOA3ytfkXy1iCVVwNPNangia5FqG3iOCTIH
	r0m8g==
X-ME-Sender: <xms:b276aNKvPXkQsIpNsCEXjexvUYBRyTUS5Dnx38g5JgpG02X4dzhm9Lk>
    <xme:b276aD9cYRimH89VCTCUHsqnpzqARhgqZiWevr1IvcER1DWs6teMnfVyGzWHuJFsG
    atbO-2j4g1v-eNMSJkDFuEackTCptmufnDlBE5nyu5nGl8lAHSC8_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdffhfefffej
    feffteetvdettdevfeetheegtdehtdeiudefffduleffleeljeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhvrdhrohhothesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b276aH2ve6rtGIMRkzsaq6KZ6VtkSrRvR67Js_ZG-6M9oC8F2uNJXw>
    <xmx:b276aEBPagsGc1rbxgXkpUXxRegxGRALErac8CqKRESfFEIc1kLz4g>
    <xmx:b276aPe7PdiZVRNG6VPmsWWQeIOjtyudKDR5vycuerETEvV2wgKMwQ>
    <xmx:b276aJjddKABQ3fVSnXf53zj5Advsl0Dawt_Sp0wV5RX56rxBMj63g>
    <xmx:b276aEtBTspsMaaNHzDnHy4LfYeTrRoxEEMJTHfKVGsWVzUgcdKXLmWY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87F331EA0062; Thu, 23 Oct 2025 14:05:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALJxWQCjwTkF
Date: Thu, 23 Oct 2025 20:05:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Benjamin Root" <ben.v.root@gmail.com>, git@vger.kernel.org
Message-Id: <fe071caa-9238-497f-a52d-525d50873426@app.fastmail.com>
In-Reply-To: 
 <CANNq6FmsufpGZTxv8_OMf7nHwpscD4L0a+rd2HCnO9Cs6PX5gw@mail.gmail.com>
References: 
 <CANNq6FmsufpGZTxv8_OMf7nHwpscD4L0a+rd2HCnO9Cs6PX5gw@mail.gmail.com>
Subject: Re: I still use `git whatchanged`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 22, 2025, at 18:05, Benjamin Root wrote:
> I was directed by my git client (v2.51.0 installed via homebrew) to
> send this email if I still use `git whatchanged`. I think it is a
> great verb and I can never remember the different log output options
> to get me what I want with `git log`.

Git 2.51.1 lets you set up an alias with the same name.

https://lore.kernel.org/git/da3d0baa-d473-460e-a9b4-4b4042e6cafd@app.fastmail.com/

There is one regression with that release
that will be fixed in 2.51.2.
