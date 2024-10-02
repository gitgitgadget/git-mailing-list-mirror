Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA21E7669
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866164; cv=none; b=LlQituoZMg8N7xDD43V+5Yx8n6RT6LTGXHp7pLvLMAbrce2nZf+mezbpBakc+WpHJGmI2j+tHaUgWDqeoOKtK7ALjeInsSCODqi0tNYTF7PYo0h95oKgwOawuE1vHy5B/Qhfzy5CTfEgErzEjc3FRoBL2pDxqQuYcbCAD4myyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866164; c=relaxed/simple;
	bh=GdijF12acoc4dZ0PJQ/w66yVVTTRKW6cfhJteaiQBic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgWVT44laWNMN3sGDKvdBR5lOJRSU1rQNKee+R8bNMdWdn/K7G3lFvH2eiYEg387b8Xx4fI912p5cRPAFhedp8NGzy6q/OCgWPPGdP+X4a9aQQkZb096qpoxklAHm9djfDikQAvKCCYXKB7jVRMWfqOu7yAuQRHD3ZNA4IjSLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Exq/YY0U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hui/+OkP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Exq/YY0U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hui/+OkP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8702C13805E2;
	Wed,  2 Oct 2024 06:49:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 06:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866160; x=1727952560; bh=Bmx4iYHk3H
	y60Iu9pVFoxJFAq++iL+v5e6X5y9U1MH8=; b=Exq/YY0UXalTkCvyDepfw/rQO3
	qGTD0DCsWv4PeRVoBepJ0LtNIFXJ42e29nfBxnsZWSFoZ1gf3ATgDl3hyV3qwYyY
	z+aXwxM9uLEubTs2TQqhDuzDmqZc/eL4zZX9cvaDe3lXFsFi1UyZKTUQ0wpzs5DA
	H20wilYp1JzZiDMg5IQawgRVhJvuNh60cfKZmRoPtlcHYYOpCkGf0RkC5H+tFmdU
	AbUND02JDqJTefT1WeFLn2kry5iIvMyjMR/g7vC/ki2a17WQD/XAnGvrNpgDrUO3
	pv9e7/IkwHB+8b+StM5y6bn+XR3F9Funko6vadN/YxG9j5N+/9NEvX60CPjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866160; x=1727952560; bh=Bmx4iYHk3Hy60Iu9pVFoxJFAq++i
	L+v5e6X5y9U1MH8=; b=Hui/+OkPRVoZj+UanKUF6+MZ+JiPyQWPurIv92UN/mrG
	+PJnJy6EwZ2bQl8u/WT+OfrpAkOnu9o3+sut3PKmgDm40J8JYwROix0ox5oCFoWr
	QMZutwLkz5C8/0MO1zn1ufNHe6tRZkxzrX3x+kS+ZqusApGcL9F85L5691HIIUuR
	9jcSNMnnIJ69YxKOmRS5q8hFPzF/drG5NUZIuyxoY1XCwCh+3E7VZ275rX+g69r1
	/3xgFLOuZvYnFfHoQ6uRtCLp2aMc1gPUGWtvUKTx+OG3WCP7PG39I3zWeh5v5pzt
	gt6a0lbFYaS+ghDVWPlx2DJWaRMJuNiiis25lAtJKg==
X-ME-Sender: <xms:MCX9Zo_3EptANJbdeeHhBzsR4mVxhuJ2ciLaPuydTLBkIz0oJRdybQ>
    <xme:MCX9Zgv-R5N0Trz_-3myNJUF2yJs-oaV_CVmrCvlJ0mB1N38MCvfB_gPvGbXeL17B
    pCfxY6zT8HulHK7vQ>
X-ME-Received: <xmr:MCX9ZuBkaRe9kGGuMQz_EUMfp2jwiQVJKpY202Dqx-mEX-_miGnrTYJWwbWHJM1Hr9zcoJpZWTX9L1v40cz5ON2sI-KpzIEnif6mBlsp8LGGesCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MCX9Zoef5CuTeyWP_IsiISvS_xPvU1rfA8fHw9Yga6tDkyFiHqvgGA>
    <xmx:MCX9ZtP6YnYMCWjkkS7_VZXz_7uszHz6kzXhxev3KOUXzzpzG1pE-A>
    <xmx:MCX9Zin66ApnDxn7xLb2DupAXXUKaIOY3ZncqAHspgXOe4HVRUYwGQ>
    <xmx:MCX9ZvvqXJSU8QsYBwIzdgGsh3HC4SQqHx6M8el5FB_VqxxJQG1wVQ>
    <xmx:MCX9Zg2qf4_rUq3SeXY0IWpl-z5zdAfeOexE07_GKFFw-dEUFogcDm3_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:49:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee62c279 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:48:25 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:49:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] read-cache: free threaded memory pool
Message-ID: <Zv0lISjo-5bHzEzW@pks.im>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <pull.1801.v2.git.1727804265033.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1801.v2.git.1727804265033.gitgitgadget@gmail.com>

On Tue, Oct 01, 2024 at 05:37:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> In load_cache_entries_threaded(), each thread allocates its own memory
> pool. This pool needs to be cleaned up while closing the threads down,
> or it will be leaked.
> 
> This ce_mem_pool pointer could theoretically be converted to an inline
> copy of the struct, but the use of a pointer helps with existing lazy-
> initialization logic. Adjusting that behavior only to avoid this pointer
> would be a much bigger change.

Thanks, this looks good to me.

Patrick
