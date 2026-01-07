Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E712F7ACA
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780334; cv=none; b=Gy1qPX/AZ+3LhrZc0kOgMHjkfSywue3rzGnVV07wcnTEhr+hhpkeqKcY0K7FyIqHbbnoIJHWdPbtse+tMRt6Kx4fqjhTJ26fhOCGhXneV14K7+vnT3Oli7GzuB4KMyy1o2WIVKvkeN3MGvSXI1iWOi5ieV/FtPn3uCBF5SndA/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780334; c=relaxed/simple;
	bh=657p+QDzP0D9rGrvKvyMxyPYiLtBjd2FE/9BO7SMYzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is1SxfVxzeP9HtJUKu2FDJLnOInwPaCDOYTq+F2YeM/1WqdUKynHyAis9bx0Ja50Xi3gBy4zB4MBgKp8OtBziyjhEJ/ToZnLzBEUoYpt4DzwQw53cPNt97a3l7HYg9sdidzbxwvcOn2avUTUuLuKE9fEuwvbQ79F7EbLfWhsO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WfTJR+bD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zWi8dAGf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WfTJR+bD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zWi8dAGf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BE91CEC026F;
	Wed,  7 Jan 2026 05:05:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 05:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767780330; x=1767866730; bh=BVEdqmFf98
	I+dR/c1a42881z14JmagkOZdKyK0hqUVM=; b=WfTJR+bDIsXfTUMOdaWl5f7jI2
	Yz54EwM+Ik19X9O9zOOxr5/Ho28ykzb57WdK5S6MdEUXPq7m4J5RXb2ati9+0+00
	Ytq7b3iqDXZNnDwXdVAfW7EZ5+3/LiIT76OXNG+2NJMSXDuoXuYYRyZWQ4hvCoF+
	/S0aWIyhmPlx2Oyb8O+fOuwRGqKShcsihNkILe4h5SeDYCoSBE9YCFenvUW3F4Nc
	fPFZbNbDXxFlwiZZm+x5vvfY0Iq8uwKY95iD05xqBJHaDSbzylJHH06PYm5ofHz8
	L89X6m+7obS0nlhsL2InQSEdnstaeFFHfXjWVlaKknvm/YO3nvl6666TkdWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767780330; x=1767866730; bh=BVEdqmFf98I+dR/c1a42881z14JmagkOZdK
	yK0hqUVM=; b=zWi8dAGfOB5gmqitmhsviQrbBYvYEhNvjoNTJSGC+ATBkFZZOWa
	ZSSYOFOJhjnzsr+zFISg3dNPg77Vv61GgNRDXPkI6brNaEUFFHtpouaAZVtp6gRW
	UcM0/pxIdWOCuxpaCSeeWd4klYU/F4hiOFUGPBicsGCiJmJqZdM6zrH2vV4UZLqH
	8ImjIKqpdFgnLGRewH06NzPlJJEvnxdpUL9DH7O8kFyRV9zDmrm03S5RNlwo8dR4
	BctP4cn0cagfgbU/mSlF/Gt29+uIsURc3nf1Z/Kz7pBIANKS1CeibpfIGBnPDe4q
	MEZ/GQeP07sNi9x/49Y65ExtqAdmtFpNAsg==
X-ME-Sender: <xms:6i9eaWCWZr--fdE9ZhRfc-jb_LPUMXDVhI6rfP1_viJsoFrOLK3TxQ>
    <xme:6i9eaeEijHVEYpfyEYGblO9855MfOkqclmhBDFRxfUubgqU34Ub8ySWtGtN5aiHS1
    5EsX2Of_4MubqeiHZafEiZ4Q-lEJkmBcaj5tltSAZZZPY6BTUkH>
X-ME-Received: <xmr:6i9eaQBuHMhisID3RRezHRITQmw6jl6q22rbmEbFWtZcqeruRDRRVr9td6AUwv2whfYNHaNtCF1-2Fkk-QqpVSb-gy-K-lz06UtnVeKoD2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6i9eaWWqo25HRDTVtAUvULI38bax8LRTYxAOgQUmDW-vYrPEiCxfDg>
    <xmx:6i9eacqqLySxHXFI6qXCbFrjRtT9XxR4OqBG6X_YmpIeCMg891XwSQ>
    <xmx:6i9eaaSPz03TvI_tEXEw76CHuz_VkZqVXisK5rNCJLjXxITcWHjwqQ>
    <xmx:6i9eae17Bs5ByuYyxgliGTAYWhT7Pw9JYcz5at35Yn_eUmNfTF_bPA>
    <xmx:6i9eaRsgPV6PCmkigopPwJ7ExSCYT9taCr9b7NI8ICOKsALKIMdcWMei>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:05:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e73cfa65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:05:29 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:05:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/9] fetch: make filter_options local to cmd_fetch()
Message-ID: <aV4v5m29XfRcvI_9@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223111113.47473-5-christian.couder@gmail.com>

On Tue, Dec 23, 2025 at 12:11:08PM +0100, Christian Couder wrote:
> The `struct list_objects_filter_options filter_options` variable used
> in "builtin/fetch.c" to store the parsed filters specified by
> `--filter=<filterspec>` is currently a static variable global to the
> file.
> 
> As we are going to use it more in a following commit, it could become a
> bit less easy to understand how it's managed.
> 
> To avoid that, let's make it clear that it's owned by cmd_fetch() by
> moving its definition into that function and making it non-static.
> 
> This requires passing a pointer to it through the prepare_transport(),
> do_fetch(), backfill_tags(), fetch_one_setup_partial(), and fetch_one()
> functions, but it's quite straightforward.

Nice cleanups. I'm always happy to see less global state.

Patrick
