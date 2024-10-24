Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE615623A
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751450; cv=none; b=rRgY0eWsiD/qWW0Wm/bA8U12t7ySCV8g8bch4b52yBsIcid+Vqkhr2gMLMMaVPEzcSrnwxQjy8FCt2yCixeQZHqWUfVeou6QSbID01WixzxoXTMBJP9UjIc3VWWZWsu9Cokzb0bJwHM6SaIKrFI6aPXF0cw3lNBmHGsrr3MPBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751450; c=relaxed/simple;
	bh=7gP+e7ha5HienGG9CvRp3LSuq0i2bzfOHJ83uR06Kdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaUbjfzI4f+O5SFjTSPKz9igBxhcVTpFQ5sQIe4yzTO/MM7p12BwUdw3Ux8YSs0CffipZ2FT+kWJteV7/sfvBDRy/YeZ5Y6GeGTVGVap0d12RoPK/WHokSNVQg1wOY8iZEUtFcLWrkACX3P6516J4AxhptyEAnZ64kR2ZmvWg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GVHZkugH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cd66Xylw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GVHZkugH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cd66Xylw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 231B213804BD;
	Thu, 24 Oct 2024 02:30:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 02:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729751446;
	 x=1729837846; bh=ihTpfPTRY3L4lWZGdE9sjdlXB1YoNHFdedEPY+lwg2M=; b=
	GVHZkugHhWQKOxpfQuc0FgiTmO9iHc9rPyuDKhZH5oOiv+85Uqk8mFvMagnSngMM
	FIzTdNeXLIt2/+SEWcFiN1a9xAUWNF1rZ0J5KtPCZOiKPJ/MVH9mxw+bgLJWAZrx
	qd/GzQnwXfy1eW2+iO1cVX2hd0KO65liQM6B3FoY/FY7b+dWXbMJJtP/T1YPncAO
	3EBzoNcWZ+rH/0Qk8S3B9SZV0aMqHUzZkZRimH2XOx7251RNezRQtkXG7gCwnbUd
	8dz1U71jiuM0cQu05HzeV0euJqftWlYmEO0W/Li6w9u+F05c2LBOoMvHViwdu90x
	Y2Mx9iXePYVmWpaQA4LnYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729751446; x=
	1729837846; bh=ihTpfPTRY3L4lWZGdE9sjdlXB1YoNHFdedEPY+lwg2M=; b=c
	d66XylwdD1GA3DYgAWO6bfTVz1fVrBJ7KK58Tczp0k+EeMrfEq5/nRzd+S0SEB2s
	0bN14N+qVefCisDeaXQWNq6ZhhqEl/9dubNBHy0tkP2qGp4ACfd5nG9fw/K9I/ZW
	YaHLGLLzYZO52BoVFoKL0rk0brW6JX/nrAmIxXmjf6PnWDVSzgJmssOHy6mbiFDn
	3td0ZBDseO2tDBpFP/fN9mmeLwucfV13uaQ3+/t2QkbH+4cOZ0ICOU364Pkoh7Vl
	TYhaap95+R3tpVcxvqV0GDx2IIJfyOVU4/5onqOEdIQ8bLvZODYDJDmevCUOhrQX
	EqnJnqELBnWIt865840NQ==
X-ME-Sender: <xms:lekZZ1B3TxXGm7sxK6Vn5adC3dTWeqSXyX5RE0Ckcrb7YwrTDzqQpA>
    <xme:lekZZzjJvR02xibLsbXKBWM1OswzxB5hhGyDIh-XN9Yz3cPKrmqZBKZBdYz4p-Ppj
    bgbA7N3fwzFPOJ38w>
X-ME-Received: <xmr:lekZZwlVlzOfeZLhE4PTugohhey8BaBoUhM-f7h1TkcjnlQ4v26l5D62FJ00nlq3Z5Igbdr08xkYJUZzg0PdQ5P27xoziqesr1EIsMg6YLZDgd9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekrodttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudetheffgeeutdefvefgteehhfegveffffdtveei
    ffejleeuteekteeujeegkeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvg
X-ME-Proxy: <xmx:lukZZ_y2BGWQNqsHNN2zkEhEFoB9VoTAqrt-xSZ7TUi2IevMppA98Q>
    <xmx:lukZZ6QV_LP4MjBjYoCwF1xQn8jpuZKUkbLVK8PozeOsLJpg4FGRNQ>
    <xmx:lukZZyYr3ckFlK3-xxV7hnbq24JR-d0fPG6_qrRMARd7a6IBT56FHA>
    <xmx:lukZZ7QUldUATYWWVikY3FbUsLpnIPYzyKUN9CUsOLDK5Oit4HXqcQ>
    <xmx:lukZZ4ePdR-_kL4CtkaXXu_U4fkt__melLAZGI4Nuig0OEgzz4P-MmdK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 02:30:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c20f890 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 06:30:46 +0000 (UTC)
Date: Thu, 24 Oct 2024 08:30:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <ZxnpitkbPPNTLuGT@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
 <51b63d57-fa01-4a8c-95fa-770a62afd80f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51b63d57-fa01-4a8c-95fa-770a62afd80f@app.fastmail.com>

On Wed, Oct 23, 2024 at 06:19:43PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 23, 2024, at 17:05, Patrick Steinhardt wrote:
> > […]
> > Careful readers might have noticed that [1] does not mention the above
> > flag, but instead mentions `FILE_RENAME_POSIX_SEMANICS`. This flag is
> 
> s/FILE_RENAME_POSIX_SEMANICS/FILE_RENAME_FLAG_POSIX_SEMANTICS/

No, this is actually intentional. There are two different flags:

  - FILE_RENAME_POSIX_SEMANTICS is what ntifs.h exposes and what I've
    been linking for documentation. This flag cannot be used though with
    `FileRenameInfoEx`.

  - FILE_RENAME_FLAG_POSIX_SEMANTICS is what needs to be used with
    `FileRenameInfoEx`, but it is undocumented.

> >  	/* TODO: translate more errors */
> 
> It seems that `Documentation` doesn’t mention the difference between
> `TODO` and `NEEDSWORK`.  What is it?

No idea, to be honest.

Patrick
