Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7519AD90
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728889; cv=none; b=QZglTx8sLnI9EK69zItES3emUEoGcvzvlnjD8R093FiEY8GmbUkGEEbcIdjM8uXOWqGTPD8NWUX+YNiLg8oSVoZdmAgO8efxXlW64LhZzkJ+E7DysRD/enrxgsd8TykpkXGzK8wd/3wzoIr/bJtQ9tH1IsTLm57ic7liHg2hQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728889; c=relaxed/simple;
	bh=b2zJ5vQV/HmVC5OByZfrsnI3HGEB8T5QpB8zd8F5DuU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0B+KwMMlwYwPF+jSH2aZnNuW3VpoYNISXbzAa2FLVa5xz1tU8j2JKtHLR3Y2JcyMtpCRK2KFhofqvidAOPbpRAbgOvE756Lm0ytuNQu1QoPQMdKr4S+e4VTQX64us44OhrvF4jW892w+KjtXfVKS4KFfxcBLzBlJbZoxXlsqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h6ulwb0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAsPtLla; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h6ulwb0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAsPtLla"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 658ED14002AB;
	Wed, 29 Oct 2025 05:08:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 29 Oct 2025 05:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761728884; x=1761815284; bh=BSWQMFyUYC
	CpfzPapBYUlU/VtIBKbqAOumKdgh3dfSA=; b=h6ulwb0YXNk13Dlc2jsBCL11EV
	j1/FrHjGJijT0gKjKow7AUE+iVjq5XrpKVDT3wVhGP2yY9PbV6KNKVeQmk3huJJQ
	pZSmFtqdnZVxweBDEsHBX7WmeO0oVyiHoPSXgbBev3Os0Y/G10rMnwLGLa9NOYoV
	F3lxmacNsB3IyoNjAepwtHHUjqiK5qnFM0REXfOYxH48atUeJ8l39URMGaC42ZGO
	nMcFLmF39Va7MePUVe8i0Tej+tPHwq39KaB9CJeFQv7PRmG0WfOri03HlkDtTMTV
	wcI1Rcu4UX0xCCqMJeAyF4pmD1CsyKHnR+PdIS3nmTlmyb3C5b/YL9jHOipg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761728884; x=1761815284; bh=BSWQMFyUYCCpfzPapBYUlU/VtIBKbqAOumK
	dgh3dfSA=; b=hAsPtLlas03TUAandT7pSCwhVV1KynBnZcU5j2M4ZP7FFRVQzfF
	MIB2YUuY+ca0h6R+26QIWK2Y9D9w954CvGh0TPlNM9gCOMJoo7QsFT0GnYlYdiUx
	9i7zDbO5NgAFIsrfDSalQWkKOq1vA2WgLOMi5Mvx9e/3NXixc3MCaFpOoNZYLhWG
	9NroTXTPd7SSwM6Nt3DNALCiGs09keUbPLgwFGduHWZijEfILB314KzwtoOM4Nu0
	RjZjKhdzAT1/1ncAVDZLCg6rQ+yHiJ5HiEN4ngcR6EhNgnhQmdReKmLinkJV3cx4
	Yc9EWhKfCkR/+hcyueEyA6EhR5uO//8SMbQ==
X-ME-Sender: <xms:dNkBaY5hYeSbxehhkP8ka0WO1T9-fozqZygATboxxZKLUT3YYc7EbQ>
    <xme:dNkBaQ7eMjHu30f_-psQMkHP4ht5EPI-wT45Zhu39C7zO6Lqit9TlqZNIROcZNGlW
    IGLyREiCrBv1n9hOCwWrdKNo0HIf3l3lYQ_UqjJhUY8tiyLRGLbxw>
X-ME-Received: <xmr:dNkBacct--y8Y4E-e8LKmcSmnpmonKIi8PtOu0VenzesidADXrcYs4lW02-TOCx55wfDJiwHw8FLJt5iC-hkB2J1iYyIH-57HK1U6OwX4Ks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:dNkBacBVpzDM6UVuzAHG_CgOSVLr6G6RGF5ldDG8ygJUT_K5H8kvvQ>
    <xmx:dNkBaX84i0hJXC0xa1kS261Q6hRLesg8idljgjhpBZ0mzWJC72gaEg>
    <xmx:dNkBafJ1s33PLCrV0A_fyrSVFeeFYwnJoq_hJi1gK7cdmRdqRtTfkQ>
    <xmx:dNkBaYi3Y-DN5HjEiujGhYjmsIQL3fk_WN25BBjavQGpMLRVhpAsYQ>
    <xmx:dNkBaYvg9CZ5bSL-BXdI_i-Wu3OmGRgjOApgJJV2XKjFQ-hCxv5cJzDN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 05:08:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c630160 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 29 Oct 2025 09:08:03 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:07:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
Message-ID: <aQHZbx-2JCnCgL_d@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net>
 <aQCKCfuaEKBArD-g@pks.im>
 <aQFg2tvS6Wf7WGd4@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQFg2tvS6Wf7WGd4@fruit.crustytoothpaste.net>

On Wed, Oct 29, 2025 at 12:33:30AM +0000, brian m. carlson wrote:
> On 2025-10-28 at 09:16:57, Patrick Steinhardt wrote:
> > An alternative would be to introduce an enum and set up bindgen so that
> > we can pull this enum into Rust. I'd personally favor that over using an
> > uint32_t as it conveys way more meaning. Have you considered this?
> 
> That would lead to problems because we zero-initialize some object IDs
> (and you see later in the series what problems that causes) and that
> will absolutely not work in Rust, since setting an enum to an invalid
> value is undefined behaviour.

We could of course try and represent the uninitialized state with a
third enum state. But it would probably make things awfully unergonomic
all over the place :/

Patrick
