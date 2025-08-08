Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747B222585
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638138; cv=none; b=EdL0clfHNVenTemnosrZPVSzj0oP61D0yffPSZRt29eioJjomKr90jTGSoC/w/McK/Nn0sEoOIDSs+KRL5onmV6us9OaLAXTTaVHxzxxEQprDmSeADBagN2maLHV9C44rPKr6uG7UfPhL+zQieVbJBmIWdL/N5MeX4LrrWPiIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638138; c=relaxed/simple;
	bh=hsNjzVxHfQZOyZPIyJ/HB5hd/HuF5Jwi5cZIdARQagA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu8yVVUkhQtzzdtYVTYz/g7sdS2VZRNU3EQH06+0Q0pk7DJpoErZ9Kv3NTA/9M8j3pkuHypb1g6IK/TMJrIKZQYCIyUvo/oN17Tdoh5o4OOYa+NqmfDLJ2Ju4bnlg4QOtZyU+XQAeTXRsPmYo9gjz8RwhGeJ/NAFdCQDoTfZxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=An98sOQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbFn/TC/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="An98sOQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbFn/TC/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C5081400079;
	Fri,  8 Aug 2025 03:28:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 08 Aug 2025 03:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754638135; x=1754724535; bh=HueONohQyr
	CGn9wlBtFac0wMjGq26/VP9jb/Wd5R+Y0=; b=An98sOQPKKokEgkrjPh5g9zToK
	gyvKb6pHMDbiBHNf+ddDuixU7ksGi9NdjNan9oR7lbfS5fUd3sckKA3s35UfpYCB
	A/cwjZQxCJ2Xqg/KyCGbmTXTTmC/JfVHF2/Htj9H1StsQfQvcb+upiyzPDlhjhhR
	iRoDut2Pnbvqzr8qzCPpZq+jaP/DjA7rZ4zWvUwdK3EX9nMmo43cYsYdtm6XU7aI
	U5hfnSc/HYgQyBNYSHw8ZD5vwZST0RoBsJNmN64o+exxsBhPHAXBvou+3s+W7iBH
	csp+9lBpGJdoaxBq0fGTuZbuIa94kFSZGAIhJGgCRQkF9ONUJfx1e2GGnT9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754638135; x=1754724535; bh=HueONohQyrCGn9wlBtFac0wMjGq26/VP9jb
	/Wd5R+Y0=; b=LbFn/TC/xmfSjMmTuj6i7rTHqOED0djg5EdFwQjJf4yToAZYYNY
	/wh4uN90WgQWDvhDGZAbuGpCFSCvlcBhUrqFF0z5XCearEg31+Fvk89uOAJ1+IKd
	DTARieKnBOQhqQjYOze/Nhz0IqHwa5yx1YiQcRgpkPa9gkV+5B2RbkD2pR0D4VSz
	Z/Iu+d/qCtkEx+9ys+Ik2BmKczbxYGJIStXATJg7tFTNuQqrras/vfIlcdC1MWXu
	pUW6agAtnpJ64LV3Rgm6gng2ht3CuJ4wc0J/azF1yFNyhxZMJQd07hP+wTgNKlWH
	7zhZ8q5Mh0gZMsRpUYJ2+HeF1IvXCnFPw/g==
X-ME-Sender: <xms:NqeVaPdO5igNZwPOpodGFQFFbohs1PfenWonD3cMiJc6rPmiJy96Cw>
    <xme:NqeVaIeRM4cz2NsrQ-7lVMc5v18NzKcJurqM35JJsO9CS8p4HBIvpEwtfXvGKveU_
    QoGVISoanOovNsG7A>
X-ME-Received: <xmr:NqeVaB_E8ggjfVvu815_oDmSHAjEJl-UhIl6P6FDDvMgHy4FzcyfQMQ_rOMInlz6FnEnl7Av5TqfgTNIoPdvOAQJQZK46Pgzq0h4r1gpfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhurdguvg
    hnthhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:NqeVaMnWhgQXMMwZrGzHQ94fsjeveyCPQgBiVcMJZ987NOxYSpK9jw>
    <xmx:NqeVaL-KP2zvr_90inAPhVOtdLnohdM9H3DbLMdhBYlqbGDkGlLjAg>
    <xmx:NqeVaCm3nCViWt-qivF5Jik-LSh-34juZxtY6mlD0BaSjAWNeYbmWw>
    <xmx:NqeVaA2TQ5vLll034Mt5e2XzkGufYMgrgcA37o8iGxA1G3EvmLLZOQ>
    <xmx:N6eVaNGUkxFxXnvfVxMcDSRjaix5uDqRgCwZnRmJiAvAh32E1Ah3-Kcw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 03:28:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 220ed97d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 8 Aug 2025 07:28:52 +0000 (UTC)
Date: Fri, 8 Aug 2025 09:28:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/3] remote.c: remove erroneous BUG case
Message-ID: <aJWnMSmEXNTG1lL1@pks.im>
References: <cover.1754627874.git.liu.denton@gmail.com>
 <cover.1754637849.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754637849.git.liu.denton@gmail.com>

On Fri, Aug 08, 2025 at 12:24:39AM -0700, Denton Liu wrote:
> In the case where one pushes a non-existent oid to an unqualified
> destination, we encounter the following BUG
> 
> 	error: The destination you provided is not a full refname (i.e.,
> 	starting with "refs/"). We tried to guess what you meant by:
> 
> 	- Looking for a ref that matches 'branch' on the remote side.
> 	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
> 	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
> 	  refs/{heads,tags}/ prefix on the remote side.
> 
> 	Neither worked, so we gave up. You must fully qualify the ref.
> 	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
> 	fatal: the remote end hung up unexpectedly
> 	Aborted (core dumped)
> 
> However, this isn't actually a bug so replace it with an advise()
> message.
> 
> Changes since v4:
> 
> * Put the switch statement refactoring patch last so that we don't get
>   compile errors from a missing variable

Thanks, this version looks good to me.

Patrick
