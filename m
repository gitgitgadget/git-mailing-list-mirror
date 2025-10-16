Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415C1A2C11
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610743; cv=none; b=RsvhfkRDlPM2RLRDi14zQ0sLHry0ep7YKk5IoNZEBkQ26wjSozZxG24QpJP2DAk9ZndLVPmuMuXHyY/iVwNqLI36w2JWxoPVB1JifZ8TZBz4J+gyxubDvTacpiS+3YZd1wR8CbyGzL5Zxi73B5wJlEWSgnydASmK8ntALOCzne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610743; c=relaxed/simple;
	bh=CSLNfXhsj3RU0ZNm9PgDJEwjuVg+vbvfEyss/pAKiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+GC3QQOA+hiqJYydgq7sCqGQ0h4VaKrb3c8hY0iCA6EaNrWJ50TXoCXU5nrxDNkNqNbUCrQpz9Qc3WmMZ0TGVAVCuSI2edBtbKCLO9Jw/Rz2H+x4FdnrwowXN70YWKojYDsqznXYpTzzseFjOq2zXzzdiuL7N+j4qwxDzNhjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YhnJ48Fe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDZqXKFv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YhnJ48Fe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDZqXKFv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A574D14000FC;
	Thu, 16 Oct 2025 06:32:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 06:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760610739; x=1760697139; bh=yMmln7BLig
	CpDXF5Pzo24ilhQtjLeYZu2i5zjrBIcno=; b=YhnJ48FeXDd+WBbXsBNv3z5x7I
	VUdZH2cqtrepM5Kczdxr5czBmbY9KTbuGH+m2JBPs+abupN0VpqOQc6WnmOOymkf
	KF2l2kMDOvw/9dg9aLNl+WcE5w8zn5jaa5mfF/w5k9BT8APjCxBhqzTbzcI+VvWd
	eZTbWKDJ9SABveS+Ppb+wkYjZ3nO4ejTHA4mJA4hACuTPtF6VjjGEeDRo/Yttnlr
	TaMVnhLOjUOsoI+iBOPn+h1sxWDqvsn1m4FyF2Xg9+uwuUNmdyPZvApmJfUxVWDh
	26GEwA7XVdFCR0RywI1kdqCQl0MlOqHHMnJBa9CbOasEAxIOdAhY/pFUklMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760610739; x=1760697139; bh=yMmln7BLigCpDXF5Pzo24ilhQtjLeYZu2i5
	zjrBIcno=; b=SDZqXKFvxbZEMWbI7M68IwWoEQXy9BQzar5i7INzERPZwAfW3jH
	7cv+O7ChvLx5UqAzumpmsUr9LYoarcw6IMV0uLKhPkpCyiK5vq7MCE9cZP+Uzi+m
	hA9zvRRVH3OgKsbqvWHHUdkrwy6kxGjil8KswTYNVsMU1XJdr/Zi2ORXdc5JX2yJ
	fB3W1zWbbPbgDVOWZuFwiDqXlRjr48gI7nuP/y7p2xpikDnbIjmrqaxd0BsLKGbx
	JvrNv5yTjekkTTzdYk4/YCa4JuV6pfDhap6DfHfGchKY3p/OAPyz0gObt/fmWPO0
	7RqnHGWugi9sVg7B4NZLsjn/1qeQPDKp7tQ==
X-ME-Sender: <xms:s8nwaHjXZZAPRt-ialfFv2as6ERd5ZIsIgsyZ308W6IH3J0t_4oyEg>
    <xme:s8nwaHvPA6WTdlujzhK2CRZ3stu1ne5D2N4nkFh1_ztpsGWaKrkneYKwUmrB62hQL
    DKWvUW7JD7v05nQoPraVfZ6Rn9D7SjRt-2f79FD_E4mSczBK1S7xIo>
X-ME-Received: <xmr:s8nwaA40L-f6KKHKKbdjR-MBDzMVCOsBhGzZopj94OhGO0SIP_CmIY3fbndMHozDVhXvo00Ur0DeDcUFyj3lRduIzn9osj7igErmzWuAyP6Y_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:s8nwaLMts9xdkohaO4EdLcwDCPz_8XyYUF7amnyLJTbTfZaevF_fUA>
    <xmx:s8nwaGsW07Q0IlOEqOAm8dsf_YCLAaNrJECU0FZODgx-2-aRNl_KuQ>
    <xmx:s8nwaGbM2KdccQAxZAABtm6gfaXx6CarcAI1j_a6m8i623p6Tj4cQA>
    <xmx:s8nwaAwiAy9sq6jwn326L56hI8Gjn22dGbeesvcHBudQxcvkI5lLcA>
    <xmx:s8nwaE-mBuUtMSwUn7a6TVcrvp4yp6uA6JdlKtbQbnH-lf4MnlX5KXZc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:32:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf1dcbf5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 10:32:15 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:31:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <aPDJj5e9GKLSeVfS@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

On Wed, Oct 15, 2025 at 06:26:57PM -0400, Taylor Blau wrote:
> Note to the maintainer:
> 
>  * This series has been rebased on to 'master' (which is 4b71b29477
>    (The seventeenth batch, 2025-10-10) at the time of writing) to
>    avoid semantic conflicts now that ps/packfile-store has been
>    merged.
> 
> This is a relatively small reroll of my series to clean up the repack
> builtin by introducing a repack.h API, which is the first of ~three
> series that will implement incremental MIDX/bitmap-based repacking.
> 
> A range-diff is included below for convenience, but the changes since
> v1 are generally limited to the following:
> 
>  * Wording tweaks and a couple of minor typo fixes.
> 
>  * Dropping explicit casts out of 'void *'.
> 
>  * Clarification in commit "builtin/repack.c: introduce `struct
>    write_pack_opts`" that additional cleanup follows in the upcoming
>    patches.
> 
>  * Marking parts of the new API as const where possible.
> 
>  * Using 'bool' as the return type and simplifying the implementation
>    of `write_pack_opts_is_local()`.
> 
>  * Avoid shadowing "struct write_pack_opts opts" in `cmd_repack()`.
> 
> Outside of that, the series is unchanged, and I am hopeful that this
> round looks good to reviewers so that we can move on to the more
> interesting parts of incremental MIDX/bitmap repacking ;-).

I didn't quite feel like reviewing all of these patches again, so I only
had a look at the range-diff. The changes in there all look good to me
and address my feedback.

So I feel like all of this is in a reasonably good shape and a
definitive improvement for our code base. Thanks!

Patrick
