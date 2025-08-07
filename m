Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C48155A4D
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547347; cv=none; b=IIyKHCPETgstdvdJz38tBmpo+XEoZR7dzd7VEw+ELc7gxWXvCtzsXY/c5EFvVOQ7qI9v7RDAZKpyZAlksVAaSKpRdK4hZ+LFtOeKGN8r5Mioi2GAIkDrUYrKU10TWXMPfwwDwMGUXRwLEZoVDjPhYZSfvE6CrA83myQs6W+sdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547347; c=relaxed/simple;
	bh=ZC5SCCnSG89PQy0c8eYEgf3omuj1C6tyWCaWZ9lPLFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcEURKw+b9ua4eJrrLYRmFsjeN7WHk1IFHapV48oGXs+fO8A8xMn+mDlER8MxBYdX+KXQ5uo6RB8qtpHAa1TP0n1DFs5yGXUacFaUqv8lvBn3tlYC1/mXJKg5wVwhu18s8tqSG3tNgPxUo/2irsccQDOYIjC7RDO+ejaK/satas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P3QhI1dv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoN+qODc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P3QhI1dv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoN+qODc"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CF15EC013B;
	Thu,  7 Aug 2025 02:15:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 02:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754547344; x=1754633744; bh=rYEpxffDmE
	QbwE8daTxKWo6WW8XoHeJnGt5erP0ECog=; b=P3QhI1dv+fwTBYkuVOWLmo+Ekx
	c8otnO44muXjyz1BUtzeIn3N63Py9jwLcyaVYhYnsM9j8kiLvHsiNj8raeZb7Cjk
	T4JXIc7J43PVPpG5ddypfEKMdIbldRX3ALDqHUhF1PKqaGHJ2esYo8JM79/SkMf9
	Fg2UKft/R8+wyjKnVLl8ih8RI1p7y3G00bxGSsZLpNzsFdAH5Wii4y5Q+KDcv32N
	Wte1ezwUkz6SQwaVp/qFWribSPo0z4sIrSZHncY5FGstT59sQSWKeVGKikXS6bK7
	n+DmjCRIUwKny6GQaMfs4xgaRBtu13w7Bx4E6jlB0dYAdzvy0llZyWwLbZnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754547344; x=1754633744; bh=rYEpxffDmEQbwE8daTxKWo6WW8XoHeJnGt5
	erP0ECog=; b=KoN+qODcDeJS5csKSjbM7GrG4ympUC5tNiUnd2m8qAWaUtyNL4Y
	Md1+pGQtTs/XE2PQp5pO5xlm678L9LXkV7slKMyqoYa2n4Yrq8AQTRj35RQ9nF5e
	hYn08Kho1Ny/npofK+KwtrQsPeDuSB0+h/AhowQUnIRlxvFitRItaEf7o9nvwrZp
	WeeQ6+OPgy8XsQ2tQgme3+oSZ7Nj0ns0ac2Bf2tFgXB0vID+2h5Wy3cACN2XXRyo
	Oo69MQ0ucNTXu/uI8A4Kp//m5g0uyQtrihuMTekpM8X4RKrCa35gSsv4GBI7T1pA
	gnw1668l2yCWE9cRKc98nZ4erV2KBZcIpag==
X-ME-Sender: <xms:kESUaBZKJp2gV6dc46qKIikAzGtpHbAGx2Q_We7aVYdhTwhfFsTfBQ>
    <xme:kESUaC9dDx6FfR4c0y6Uosw9hpLahy8cuBDQAL9he-f5n4lphQJAReD_oMfCIVS8v
    Rz0pTb3sTPjiE2I4g>
X-ME-Received: <xmr:kESUaAj1thy0-RNj4asZxVJSZbbYrnR2gn475Rnh3TPhdVEVphRpleLVoczk9lRnHd1z4b4wuDUNFm3kZ9kLyaQJLTTkEvukcdD5eJP_Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kESUaCe6rBpVG0rSvrjnZOY65JAGDEiNieySgOSos1ENiiZDCfiX0g>
    <xmx:kESUaHqaVEd-4XwFgH_XZjvb3qKVv3-T-Px5v1a_kOBuHn-FNHBI3Q>
    <xmx:kESUaHB1Mh4liHdz5OmEjCmWHIe9Sv3F1JuVVpzOR5za56s_r3ruNQ>
    <xmx:kESUaEaHa69ODI-_dkWZN-TGwytp4LnK4jaeFuPs60FtHVRzijkQaQ>
    <xmx:kESUaKrJnd6P3nZ50zqTomEc4DXJsBJDXtnxQzz4w6BINmH4-y4O1pU3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:15:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0d8507e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 06:15:41 +0000 (UTC)
Date: Thu, 7 Aug 2025 08:15:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/3] within_depth: fix return for empty path
Message-ID: <aJREivx80NI08BEU@pks.im>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
 <20250729-toon-max-depth-v1-2-c177e39c40fb@iotcl.com>
 <aIm5vMeTLSLD-6Fz@pks.im>
 <87ms8cttdj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ms8cttdj.fsf@iotcl.com>

On Wed, Aug 06, 2025 at 04:30:32PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Just for my own understanding: the only difference is when we don't have
> > even a single matching slash, as we don't verify `depth > max_depth` in
> > that case. So in theory, we could modify the function to the following
> > equivalent:
> >
> > 	int within_depth(const char *name, int namelen,
> > 				int depth, int max_depth)
> > 	{
> > 		const char *cp = name, *cpe = name + namelen;
> >
> > 		if (depth > max_depth)
> > 			return 0;
> >
> > 		while (cp < cpe) {
> > 			if (*cp++ != '/')
> > 				continue;
> > 			depth++;
> > 			if (depth > max_depth)
> > 				return 0;
> > 		}
> > 		return 1;
> > 	}
> >
> > (Not saying we should, I'm just double checking my understanding).
> 
> To be honest, I wasn't sure no more. I decided to see if I can write a
> unit test. This is what I came up with:
> 
>     void test_dir__within_depth(void)
>     {
>     	struct test_case {
>     		const char *path;
>     		int depth;
>     		int max_depth;
>     		int expect;
>     	} test_cases[] = {
>     		/* depth = 0; max_depth = 0 */
>     		{ "",         0, 0, 1 },
>     		{ "file",     0, 0, 1 },
>     		{ "a",        0, 0, 1 },
>     		{ "a/file",   0, 0, 0 },
>     		{ "a/b",      0, 0, 0 },
>     		{ "a/b/file", 0, 0, 0 },
> 
>     		/* depth = 0; max_depth = 1 */
>     		{ "",         0, 1, 1 },
>     		{ "file",     0, 1, 1 },
>     		{ "a",        0, 1, 1 },
>     		{ "a/file",   0, 1, 1 },
>     		{ "a/b",      0, 1, 1 },
>     		{ "a/b/file", 0, 1, 0 },
> 
>     		/* depth = 1; max_depth = 1 */
>     		{ "",         1, 1, 1 },
>     		{ "file",     1, 1, 1 },
>     		{ "a",        1, 1, 1 },
>     		{ "a/file",   1, 1, 0 },
>     		{ "a/b",      1, 1, 0 },
>     		{ "a/b/file", 1, 1, 0 },
> 
>     		/* depth = 1; max_depth = 0 */
>     		{ "",         1, 0, 0 },
>     		{ "file",     1, 0, 0 },
>     		{ "a",        1, 0, 0 },
>     		{ "a/file",   1, 0, 0 },
>     		{ "a/b",      1, 0, 0 },
>     		{ "a/b/file", 1, 0, 0 },
>     	};
> 
>     	for (size_t i = 0; i < ARRAY_SIZE(test_cases); i++) {
>     		int result = within_depth(test_cases[i].path, strlen(test_cases[i].path),
>     					  test_cases[i].depth, test_cases[i].max_depth);
>     		cl_assert_equal_b(result, test_cases[i].expect);
>     	}
>     }
> 
> The change in this patch affect the last batch of tests (the batch with
> 'depth = 1; max_depth = 0'). Running the test on both this patch and
> your suggestion gives the same results, so yes your suggestion has the
> same output.
> 
> Do you think it's worth to add such unit test?

Sure, if we can easily test this via such a unit test I think it would
be a good addition.

Patrick
