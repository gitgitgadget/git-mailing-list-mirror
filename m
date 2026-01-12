Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A33CEAF
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206124; cv=none; b=NOFl+oERfyv5fXC6bL8ua4AcnTpQmgTqQzKnYWLbsP8jWhe9tkQueRln5iaJZsA4SkmrsytevgR1Ny7PnImF5AH7lrYjv2/JmeFPPzmItCxggK/rjava/W259S2yK87ECpndjpqxFpsLTKbWe40edYgSDaoGcJH/WnfSh7xe3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206124; c=relaxed/simple;
	bh=rjUJN7SJ8r7pBk0HvAzXeJPRUFy+OA5TFPU78FJXB7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yba1DEVakqysfmQB48/IjjSh09ouEHWu9FTRro40ULI8jdKBOtc4AdNEBBZVEAt2fvcnvGcc3VfTRJME9Wu5n/iDrzFh4sqRs4PuziPmW2qyxLwLZu3RoYvKV6Lbh+Rth7Z053uk10k/2K59e/wyhf1Hq9ZAkAHIUmKvBBJ3l7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fqh+/a5d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZodQdCcd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fqh+/a5d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZodQdCcd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49A637A0049;
	Mon, 12 Jan 2026 03:22:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 03:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768206122;
	 x=1768292522; bh=hSOJGKp0GEJUTfofvT6Spijmrj3z72S/HR/lVHOb8uk=; b=
	fqh+/a5d4LcNAi5viNRW154IIHX3xRfBqJO9NZxkK7F1GDTN+HqRM5TPPDrBx4Q2
	PzLx2Pql8XD5DWr+hUhcFspRtFGc++xj1ukLOFuLmTDuXhm0aRYJjDTh0HcNUa+g
	PuzONUXUaN0kz0oClZQH3W7ZSozpmlOG6Hfw/BIM2dBwb/40VkbzuZNqj2wUdOZP
	DuOAH409pskt3g9qhluUQiVOVmlDIs1ekeUStlj4v+YSxu0qcTwbKIKga3yc37tA
	Eu5K5GlpkqUswmWnZSbagcRPZEu2S6sUloOozloxiuBSiqHMePQX8kxrEvSIleVS
	Y68R1g3NU/wKTgPXf1IvfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768206122; x=
	1768292522; bh=hSOJGKp0GEJUTfofvT6Spijmrj3z72S/HR/lVHOb8uk=; b=Z
	odQdCcd5WXABby23rDmxWOXK5BRBkG/DrusQKPg+VAxaOZY7XHJvjdYxUQ++Lq2K
	0aoqW29d7+Ov0vXDbGwK9oRUZ9ghb/JqOw+O+4E598EsMWmGHX8yIi349lzwKTWt
	aJv91/JL+H3T2NaDSJd6WlxsmHBHSqMhD4D+XWydOGWxd/RpZy82kBiAh0bUMa7f
	+tuUKym+KHNLPtDrS0+EQ6SoplAnD5DmUhr0l7xYAIKe84L+z7kQF2486poXUZ1t
	tU9Cn1Qco0Dwb3ugLL/n3Gf+VUNP0u0pCIKGQppgi06/X7DGnAkxdcpi44iMU02w
	JgPzYozHGgZp+ysGYUruQ==
X-ME-Sender: <xms:Kq9kaZRc7eWCQR5UgeI7O9JlEF2I4ii4GrHh9mjxmC9TUbKDfTfXsA>
    <xme:Kq9kaaNaf4l_V4opk2vER7PUdYPqRru_-nlnv-a1o4boDtFFeIvBseTYMQUYz7AtI
    G2g9mE4YCY9CnlZbuwU3r1HLA0AN2ddSUQZj5v1CBXv2GOK2uNVzQ>
X-ME-Received: <xmr:Kq9kacMRahP9pkhNB9UjogJApmlYtpVjjdtIf9I7eRHdOS7rTw9aS9wfR-Ffz5pMd3yztHNuA0CaKyA5i2MUQjt4bSscGka0SIRVlp9hjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejieefhfffieeghfdvgfduhedvjedttedtjeekheeiheegtdfhieelveegveevvden
    ucffohhmrghinhepihhllhhlohhokhhinhhtohhthhgrthdrihhtnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhrrghmvg
    hshhgsrggsuhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghplhgrthhtnhgvrhes
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:Kq9kaatFrfIWVwd4z67eXztR2O-K1Ot0k04_vK0PYCuu5aeGXW8uxQ>
    <xmx:Kq9kaWXHY-7EnRR2LBKh_1Bf9AJZNtoLHVemAvS2BS80-2GWudxFNw>
    <xmx:Kq9kaSslTpekTeca3uhqfIQSmvDkMu-JRz6Y7cZG-MaM28DVm5kp2Q>
    <xmx:Kq9kaSV_IZ3iUAu18ke5b6vJlayd9Oh5G70xfZY_0ZT1qqICDLCx2g>
    <xmx:Kq9kaWJwfGeS2-dWxw103DQfkHkhPD3N-a2P_5PEREcuH8BS68z-ob79>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:22:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbbc9045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:22:00 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:21:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <aWSvJbYBWpJc-Vcc@pks.im>
References: <20251112223722.376330-1-aplattner@nvidia.com>
 <aWEV2qs8MHqt_JXC@pks.im>
 <2e103c5b-8cb3-40ec-aa0e-793f85a1f80d@nvidia.com>
 <c09387eb-0847-4130-85d1-9da8a3f64164@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c09387eb-0847-4130-85d1-9da8a3f64164@nvidia.com>

On Fri, Jan 09, 2026 at 10:39:10AM -0800, Aaron Plattner wrote:
> On 1/9/26 9:57 AM, Aaron Plattner wrote:
> > On 1/9/26 6:51 AM, Patrick Steinhardt wrote:
> [...]
> > > > diff --git a/remote-curl.c b/remote-curl.c
> > > > index 69f919454a..1d0ae72521 100644
> > > > --- a/remote-curl.c
> > > > +++ b/remote-curl.c
> > > > @@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc,
> > > > struct slot_results *results)
> > > >       headers = curl_slist_append(headers, rpc->hdr_content_type);
> > > >       headers = curl_slist_append(headers, rpc->hdr_accept);
> > > > +    headers = http_append_auth_header(&http_auth, headers);
> > > > +
> > > >       curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
> > > >       curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
> > > >       curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
> > > 
> > > The change looks simple enough, and matches what we do in `post_rpc()`
> > > itself.
> > > 
> > > It would be great to have a test case for this. It might be possible to
> > > use t5563-simple-http-auth as an example, where we already know to set
> > > up an HTTP server with authentication.
> > 
> > I'll look into that. It wasn't obvious to me how to make it hit this RPC
> > case specifically but I'll see if I can figure out a way.
> 
> I asked AI to try generating a test case for me and it discovered that the
> problem doesn't reproduce with Basic auth because git sets CURLOPT_USERNAME
> and CURLOPT_PASSWORD and curl implicitly includes those in subsequent
> requests without git having to add them explicitly. If we used
> CURLOPT_XOAUTH2_BEARER like imap-send.c does, then curl would presumably do
> the same thing behind the scenes.
> 
> That said, I'm not sure using that makes sense since the credential helper
> just tells git to use Bearer auth and what the token is, but not whether
> it's OAuth2 or some other kind of token. I don't know if that matters.
> Rahul, do you have any opinions there since you're familiar with this stuff
> than I am?
> 
> Anyway, the test it came up with creates a repository with 2000 branches to
> get the reply to hit the large_request=1 case and then uses a simple
> credential helper with a dummy Bearer token to trigger the problem. If you
> think the current fix and that test scenario sound reasonable, I'll clean it
> up and send out a v2.

Creating 2000 branches can be done efficiently via a single
git-update-ref(1) call, so this wouldn't cause the test to become
prohibitively expensive. And if that manages to reproduce the problem it
sounds like a reasonable way forward.

Thanks!

Patrick
