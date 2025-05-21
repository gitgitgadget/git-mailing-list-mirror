Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7062356B4
	for <git@vger.kernel.org>; Wed, 21 May 2025 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814189; cv=none; b=jPfm6o5Yvb+qf66YT9PEhJG9AyfGOSbvB9ySp1RSOKrWctxpGZvo6PjiDNHUDpJ6YjqSMRTBEKSeatARs6a1rGGpIuB9dn0bCgjtUakmOWQhpDS/sNvpyfCNhIJaJQXswr/Lik1Nkr2S04eX+DR5zSreFSm7+DCIhllbd2xWtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814189; c=relaxed/simple;
	bh=vrCm3vbbq4DOlXy0b2HEZ/xjORugI0tITdNM4rGZaE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goEmWPUkfzkpcP+agFU3zZWeZW0SIBGKgRA4KlZ/sdP4hxGVA7uP7LjVE2FEjHbJUNDBgk7/FCDOkjq26TFgVLq7bjinzGXaA3LbnTFa+P1GxTPuNws0fl3jbxA4nqUUR8rLB08Q/Fvys0xv6PIxyEy8hJ3VD/iHOP8ahrMw1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RcT/l2cT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xl35i0+J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RcT/l2cT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xl35i0+J"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AAC9A1380456;
	Wed, 21 May 2025 03:56:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 03:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747814186; x=1747900586; bh=vrCm3vbbq4
	DOlXy0b2HEZ/xjORugI0tITdNM4rGZaE0=; b=RcT/l2cTdG2l0P1g9WRaJdohRT
	qdxU3eiVqb6WzuT4rQrcGZe8ksNiNaZSI3NNhw9z60sf7KzYSTSGMGZWZXb8bLOP
	m3fetLfdt8Qm0VtLkDf0mK4caSTcsF8l/0AAoQ8F0dxUWhN5GFUL9JHAkEV8eK38
	NkP47Akhz/X7arqeybK1cVeH3gzfCpysDqwP44tkxf5xO/IN4gCf/KX7yY5eIKrj
	8Tvd4t2+3OxF7Tko78B0M+DS7RgSW+XAh7acxxxtb0P1GwngF6RfnnnFh9J90CT8
	spINPUQf1IjNryUaIiDV8Ayh64w28w1jxxFNVXI0tK+wn4FhvSPcNMed1ZNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747814186; x=1747900586; bh=vrCm3vbbq4DOlXy0b2HEZ/xjORugI0tITdN
	M4rGZaE0=; b=Xl35i0+JTwuFdfQ7202ipzMzt6gTCVzKaI9H5IBzvQID1B3Kt+y
	+RG7OTEEQAO8ZCnf+n0Yfxnsqw275Tt7zryLl0iXnQ9YSkD8NQJeeIrLm3SSGvVL
	/+hv31+DJRJUDkxULkhP8ciyaeve23HF2G+f9tInOQUoRH0/GQDQGbkszn3wq4W2
	uxj0NKrYft+as6fJkuF4dK9cRcWT50TJJxuX12xV8QVVW9Dq3l7OblouFqGTpnm+
	3wRtmmNDwqO++P7Z6EukxurH48kqDCBqelKHpGyIL7HdE3BF3RJacs564Sgff+Th
	Lb8KLOe2tlw5DfvgDY9kvdYCe5V7LfhvJgw==
X-ME-Sender: <xms:KoctaPGcJIIgvXe2yVBbA2GRuRuazLsJc34jJwY6iU3TzUJcudZcnA>
    <xme:KoctaMV0uUJD8agqpAHuRdfhL-0GVh0bqZzvgqHI-QTD3MYkQ3M2RsqZItGrh5gse
    Ccsy1ePn3Zk1XlGVw>
X-ME-Received: <xmr:KoctaBIO3HotJIufoge3t-YnuFtr-amfaLiVJ-51HjolSM4Zv14HIJoLjTTiyitxWuzfwu5ePMAkdb-wZg6J5ZeeAdBmskxY-QZlDv8ZOK-New>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrug
    htuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludei
    gfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepihifihgvnhgrnhgusehrvgguhhgrthdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtg
    homhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vg
X-ME-Proxy: <xmx:KoctaNGV0d2l4NtlYicYQjG58SJj6CPNq-2ttZudB7VCI6RLoMVYoA>
    <xmx:KoctaFVUxlUK4CwyIhkVw-_69muFUebpSV-seVETwNWGblK5OhNgpQ>
    <xmx:KoctaIPieKpRy4rC5vUXKMHBPObSvqq-G7JiEsRPtfCQYyd30aZ2hQ>
    <xmx:KoctaE21Ww5p_GhU3VH0LSAwpVwdKQAPokEbK1BYJMjCEpikMqud5w>
    <xmx:KoctaPIKrmlNYWKo-wKi4vCADs4DbnK5sKdRQaE7X4uvb9kCeqtvzODd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 03:56:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dd38b6a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 07:56:24 +0000 (UTC)
Date: Wed, 21 May 2025 09:56:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ian Wienand <iwienand@redhat.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] run-command: prep_childenv on all platforms
Message-ID: <aC2HJxvrorJdMkL9@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-4-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520193506.95199-4-ben.knoble+github@gmail.com>

On Tue, May 20, 2025 at 03:34:57PM -0400, D. Ben Knoble wrote:
> We only prepare the child environment on non-Windows platforms, but
> prep_childenv is the natural interposition point for our subprocess
> system to adjust the environment as needed. Use it for Windows
> platforms, also. In subsequent commits we'll use this interposition
> point to modify the environment on all platforms.

What is the consequence though of calling `prep_childenv()` on Windows
now? Why didn't we call it before this change? Details like this should
definitely go into the commit message to explain why it's safe to add
the call now.

Patrick
