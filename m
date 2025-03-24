Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43A25FA17
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812841; cv=none; b=NsYQPR1mun4AetmNdkvwPankl/X3q+gl2I6m72FidQBBfuIFt20ARetcH5K+e4BvSqF0SZPSc6mnOganni4kFUUQEbdPOR1lZpGq9G7fD5+qag/YFr7HgGPn3pnZnsrbF5vPctnQfcg0BMmjjy+JKLqOTyNYDZCfYd/h2EEAu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812841; c=relaxed/simple;
	bh=FVwOKT01lms5fS5HXipiLhlPuz8cZXDNSO8ZbyKlNQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx8JGQr/mGcAVKS7Ej8Csw+IET4TsILqy1jxqkaeyyu70iPGpCOHDCFzc0p5JgX0nMlJHhxO4or8gFkGxBskKoILOR7o5HMVefmZNJG+u1EjYJFqS1lI25Py84l6+Q72sHT5i8MzbWcjOsMVKlQ/CDf/pRcvZhafTicQ2C2K6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hNTRVxO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AgCSskva; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hNTRVxO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AgCSskva"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1398B13833BB;
	Mon, 24 Mar 2025 06:40:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 06:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742812838; x=1742899238; bh=3qbFFe7JdX
	/xmJdixL1YXKFZKZ29STV2xfsYbdhabFw=; b=hNTRVxO1TLqfmnLG6RxFC/NG52
	7KezgXsNd9uYmrwz1Mlck067vlmSNc1xLSMIHB3bSmqaDbdj4GWuUZXcNRBEholo
	BHc0RibGznFcPgZFlE08JDR+yVaOATEwptsZ3T/vEX/HbyX+KWe2ARmQJdYX7blm
	suSjoTFzKvSNg/CFA/DuogPg1rDQwJ4cKq6Q/FIwwpog5agKoqgr+uYVHj16gAy/
	Wc0PEaNRkCRvfWWCNKW36Uxe4+rTrlFTob83Ih5WoPQFjdWY82EELwCCpI8NmPsv
	Wk5rcX0TUuV20vkSM3xoZl1OYIna17f6iBc7ijBj6ucz6j8iapsmSXPvkAWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742812838; x=1742899238; bh=3qbFFe7JdX/xmJdixL1YXKFZKZ29STV2xfs
	YbdhabFw=; b=AgCSskvajJv3vlTC+LIKsGNl3Y0+e3PlEVuEzW9jCKhDUgXGBET
	fcWFcCBL7XfBAmcvcj6wy7DrdPtkry+0tfCCxY404kNGVrQZQf57wWwO1f2kWjX3
	87EewfqKN0WPyHAcRZr5hDV4dD5cYyrw4JAu5PMwY49gtpmA7Q6bLoqWqio2wDO1
	TpNKC99w53ZhOs+gkU9Nop+9bO5U4S8FRGUWpbMbRf6niqBRK4HoUD4AL5AlALW4
	MCAyK2ZY6FpqAmhoR9WP8iVgmBO13bEnpoBtoWNknKO+/s1KRelsdN+icYlbI+yU
	CxyTWYL2MvziFsyVV/vdMFrwvooVheBXG3w==
X-ME-Sender: <xms:pTbhZ7GF1M1TPMWzqRnIkEFdUvxptkdmSWtB3V1pP43xGULoQHHmxQ>
    <xme:pTbhZ4UOvJiXO6UKKDQOJ64LRLQZZwY_Xakj8kO4JQVBj2QGKI6FEtdm85HA9p_1v
    RmspPo5w7AOVbCbbg>
X-ME-Received: <xmr:pTbhZ9IEGq1HhO1Lz6ihakyIvYLXRXL0fSrV3dGi8Z5a8-Ke0TDjfBsq8aXlYTXI9av3L6hzIHjDplnf41eUas08mZzt1S8bTWY8FjTposFb2TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhikhhuihesohhstghhihhnrgdrtghnpdhrtg
    hpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pTbhZ5El5OaaQc9TQoPHdPgfU8owrtg_8NXxcpWtk07gLZru4M54WA>
    <xmx:pTbhZxUJ1OStYDUFmDuDESF4KxRwpIfQuMkl1j6z1Z8K9rt1208jUA>
    <xmx:pTbhZ0NYswTz7zt5F-ot1OhWFVf4yu8PXwVXzdCQE59yzqQAoPtSxw>
    <xmx:pTbhZw1YCgwmPbI9XIPr4FzfvKmNVsIfQEQj8VTcxCS4-nvhnjmXww>
    <xmx:pjbhZ0RjR0Mp6kDYB9cq-KQdHqAEEvMQmC_uLObH_PXmQGcYMLK7LcXu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 06:40:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed225113 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 10:40:34 +0000 (UTC)
Date: Mon, 24 Mar 2025 11:40:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, likui@oschina.cn
Subject: Re: [PATCH] builtin/fetch: avoid aborting closed reference
 transaction
Message-ID: <Z-E2ns9VziejSLB2@pks.im>
References: <g4baz2kt25ysb6wcesoqxhvw2ooxkmqio3dj6b44h6gt5l6z3r@rocsjlys5nqs>
 <20250321004437.505461-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321004437.505461-1-jltobler@gmail.com>

On Thu, Mar 20, 2025 at 07:44:37PM -0500, Justin Tobler wrote:
> As part of the reference transaction commit phase, the transaction is
> set to a closed state regardless of whether it was successful of not.
> Attempting to abort a closed transaction via `ref_transaction_abort()`
> results in a `BUG()`.

Yeah, this is one of the more intricate parts of ref transactions, and
it has been biting me several times in the past. It feels somewhat
similar in spirit to how the `ref_iterator` used to automatically free
itself once it has reached its end, which led to the same class of bugs
due to the interface being way too intricate.

So I wonderer whether we should refactor this interface in the same way:
instead of automatically freeing the transaction on commit/abort, we'd
never do so and require the caller to always free it themselves. This
would make it way easier to use because we can now unconditionally free
the transaction everywhere.

That wouldn't help with the fixed bug though, which is that we call
abort after a failed commit even though the transaction was already
aborted.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 95fd0018b9..f2555731f4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1867,8 +1867,15 @@ static int do_fetch(struct transport *transport,
>  			goto cleanup;
>  
>  		retcode = ref_transaction_commit(transaction, &err);
> -		if (retcode)
> +		if (retcode) {
> +			/*
> +			 * Explicitly handle transaction cleanup to avoid
> +			 * aborting an already closed transaction.
> +			 */
> +			ref_transaction_free(transaction);
> +			transaction = NULL;
>  			goto cleanup;
> +		}
>  	}
>  
>  	commit_fetch_head(&fetch_head);

Okay, makes sense.

Thanks for the fix!

Patrick
