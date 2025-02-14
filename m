Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DB42AAF
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508961; cv=none; b=IKNXlARi6Ye9duKJOWSBiwP4Q7EuBy5jiTYennOFvN+EBacJlObW8KxBlUDb31qyoq4cmXvGzupYDe4fRfpjfHyaEB1X/sH8o8sulmBBfS9IVBc17DRwymXgusO04GY9AU5BkL/lodgMGNBF+GJAEXu+qAzjJxKSZjyJfP56lwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508961; c=relaxed/simple;
	bh=qu0ZhVNHfkEOlqgJ8zeua2S7/XEVlyAfNl3v4jmI7W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVwkHgNZGE1K6uBte9zTAzz+RJBAqADYiKLw4zjk5nw+1O9qYUcOwiGlu36s7QxEFlj4IJaMIyIY8cBArQ/8rqm94WIBAN3vsIMRsSfqNq9XWeVTE1ucdsBEbF+9uI2MXkj+oQnDX/9zFbvYs2qiv85vK4FHGwzImDEzbgzfzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K3FwxUoJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x5q6yA4R; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K3FwxUoJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x5q6yA4R"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAF4A2540193;
	Thu, 13 Feb 2025 23:55:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 13 Feb 2025 23:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739508957; x=1739595357; bh=Ux+umlBON0
	eAL+IssXa9wbTYTCUvFtjNf1AEV6bEkSA=; b=K3FwxUoJEdh9mY/c7e9ajaNZH2
	OrU6GmJ3+vjjwlqIIuQNd/bHaBKFxP6zdum3ILGveKm+RJBHKUmVCNgvJ1tPHWgR
	e4+YTMxAx5NE7kFSlbcMFCBE+nnRxTQaV7PgvpGhJQ75xbcgn1UAoJE5tOHDRb1H
	QXMjPPJ0ycrOVJcx7tEOG1fr2f+CSFE3cAe6NQr9MBEq/TrDr0/HeZMWx+GWD+9S
	nUJol9DYXO4hsbfDuTf8jOkCgZu6kMayLimLwvSR1FL8GFFVfduVp7rCydkpktIZ
	Kwzo25TY9a2vzJoLKzbVNxV5EQA6WGxC/c0Exh+u3NE55WM6cO/MYLvd8BUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739508957; x=1739595357; bh=Ux+umlBON0eAL+IssXa9wbTYTCUvFtjNf1A
	EV6bEkSA=; b=x5q6yA4Rl4Evlh3VwbQT8P8KA9RADg8s6jo6d3Ia3X12yTKksVM
	ONfrVw1smxAeO0ZfDKuDskHl5uenKFKPUx1sf7CJpkza3ZetAq/l2ky0EvETC6es
	oGxx5t9rduX8/cjnXAt+3abYs9qBuTxoCKw+o4mbRQjYzLO8IORyXQBhVcb8ItQV
	8NWr46H9xtLKRemKhih9poMz7VGAQJD6OaBgu5rZYCxCcXUacbxfUXK3g2cDbkR9
	N46eo2Hmaxy3e4wPzU7CmJUYCaX3C+Eg0f52oyphfY/ZLIGk3fNZ8yBM1eqgvMcW
	oQoTwdq45lhNq+i4LeqYhQttZOtDKUsjDzA==
X-ME-Sender: <xms:3cyuZ_DcsZcUgml-O0mYTYItw8Z9Ua_bSSdhSMPJAqsBpWTzhS5Lkw>
    <xme:3cyuZ1jOcHg2zjx0RVAXLFjxh30PkIJQGkvphhuxZu-c6PaMOtnYXOc_uqrtc4Vlv
    0HjJ0o2zwWrX6XEwg>
X-ME-Received: <xmr:3cyuZ6lD6yFP_dIyIS1YGPpy3n1F3ElvqUfRAaodsWEERRZzu7P2VpEHDXOM8h9LJHoGG-pmXILt-lWDSrsj1HGLh3kZeIXAUszXEzZzkfxBuBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegkeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3cyuZxwRpQLN6BFnePfKmOWNXAkAZfoDcfDrbekIdDFr5IS5ExRVfg>
    <xmx:3cyuZ0Q1u7f3ZDe044aIgz3N1squfUHtWnB7AGAQ9MzV7dA4bLE4cA>
    <xmx:3cyuZ0ZiJwDmKCT1UzUqsmRRi4lRy6LiMCQ_KjQlYC5c6aBTaWuHKg>
    <xmx:3cyuZ1RNNTITPY3xhENY3rTrOvy7WAvnuyBIVprY5knPR_MBS1KIKA>
    <xmx:3cyuZ6eK4w6wqXw8PQxz8M2sKHMhJhdb570sOHIuBI4RclQCsNemCPsH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 23:55:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3af4de8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Feb 2025 04:55:55 +0000 (UTC)
Date: Fri, 14 Feb 2025 05:55:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: remove accidental recipe prefix in conditional
Message-ID: <Z67M2rZ082v5j9SH@pks.im>
References: <a79e9e9f50410721d85747b03559d55be98bca20.1739478347.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79e9e9f50410721d85747b03559d55be98bca20.1739478347.git.me@ttaylorr.com>

On Thu, Feb 13, 2025 at 03:25:50PM -0500, Taylor Blau wrote:
> Back in 728b9ac0c3 (Makefile(s): avoid recipe prefix in conditional
> statements, 2024-04-08), we prepared our Makefiles for a forthcoming
> change in upstream Make that would ban the recipe prefix within a
> conditional statement by replacing tabs (the prefix) with eight spaces.
> 
> In b9d6f64393 (compat/zlib: allow use of zlib-ng as backend,
> 2025-01-28), a handful of recipe prefix characters were introduced in a
> conditional statement ('ifdef ZLIB_NG'), causing 'make' to fail on my
> system, which uses GNU Make 4.4.90.
> 
> Remove the recipe prefix characters by replacing them with the same
> script as is mentioned in 728b9ac0c3.

Oh, that's a change I wasn't aware of in Make. The patch looks obviously
good to me in that context, thanks for fixing!

Patrick
