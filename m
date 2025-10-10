Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805154654
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095343; cv=none; b=BxbD1hFL2KFkiKCZtfbVAJsxrpn1dl09uoHLciJ2x/Ht2Dy+z0BEBU8Hina67LbY9yFbLjk2UwP/GS/u5jADxXCD0sN/EWF4CWthvCBUWOu2CHJzEJtShtDE27JAKA64Vd+X4KJR1NNGN53lehhjkZuILn7zJmJBlZ8W3HWgOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095343; c=relaxed/simple;
	bh=UsMVE2wBNFUay3Ecrsip7lXP/AlcaVFgNuS+KbGDnvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMkNtGnjpPfzHTWixX3CmKR+7+IeIfnwblyGalHu3B8ONI5vDGk4nsUwzY8lKzM7JGGHU8skOHEM3TCoE2HtDJ0g/4E8FnjbhZ7V9tltJgL0v2p7ycBoy2Idr+16Yqbixdc20EWxub3DbibHlNiQ4cC5G+PNk1NeVYrhGrr1uxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bRe7zQn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X58XqYV6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bRe7zQn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X58XqYV6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 02500EC0129;
	Fri, 10 Oct 2025 07:22:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Oct 2025 07:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095339; x=1760181739; bh=W1qgSiLUQB
	bvqh+FR9Ezf26jhItBuqQ/UpEUWMBJG1g=; b=bRe7zQn7Wz0GVMCzOXkRd/6NPl
	kZrwA+y6BiI5ggZfOhyW4sPMVsQvJ9IRO0BNHwuHLRs4KGuMQW7XBnIw5VcjUb5/
	hUCInBB5DPiJ9TwPDLwNIR7nmmpZJl3NJg4O+w0Fs0gRNi+m7xqmRhTnO+IBDjHb
	dEr9l1rKfMFv+84CGkTHQ+46mQaxA/LHnNShSa3K6HLC7kOXRiDPEFmgHakcGkbx
	m+w1d3PVJ033nhFStgp5ZL/hrwmyO0msA9DxSaFEkKgyyEidopcTHp/u60zkzcr8
	KhEouB+qWDDRWmHOmLNC7WLB1j3WTh6z+bF8rCmzcD6WYt9aQJzVn6Phzwkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095339; x=1760181739; bh=W1qgSiLUQBbvqh+FR9Ezf26jhItBuqQ/UpE
	UWMBJG1g=; b=X58XqYV6oXIFZek6LKxTI6m5tIM/+QmEkkyKDObhZ8e+gPDb82j
	ljQodHE6xqABsZyLvzsIsnsR58U9Y1KOZb9Yv/JncosQvdfSfkBx0VAgDblkMyvu
	A6lS97fZH/vINEPgt73lA8rvIJT/CU1EyDcISZMY4pSK705t5HiODb7hfbnskuvX
	+f2TNcXTJo3gh2Vt0mWdS/8gpXqHzQDiF/azvdQsmz8JNgEy890uMNSRzxBRjFh+
	ufPPKG76hdtTSLgcRZ48ch6tGETkBmggT6MAQk3NDlguBa2fybXV8zlcOlW/AvdT
	f6BMzkasl43WgYcexNuEGzL9XY68QNh1wkA==
X-ME-Sender: <xms:a-zoaK65-J2HZOVglQVDaIw5Q423QAzONa4e_8BKP9B5WKHyQLuJDw>
    <xme:a-zoaJ4CtaKoY2rkhhTkWXnaDd2jSeUuCfKaQVe4bYv2d22gfWA29JfKeITVcKF9q
    Su_gciXZehvyWu1iQcIs31skszAMGWawJHdiUAo4xc23LsHuO-TBw>
X-ME-Received: <xmr:a-zoaHEHXYnFaZpHrfkfwYctV0bfLu2jSqKUmC_h3LzsAmSeP_wpsrBpr2VVUH6SQJjfckaJvtwltqOk3we817pIYgqVIgsJqchAiTb4uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a-zoaCT6URME_9xOWNmosa34Js3Ej2hGnh_smtO-AZtXlUHCsnYRjg>
    <xmx:a-zoaAtXmpt9LqRKqx9fSz68yqdEIKCyn2GZuY0c9cwAHlhJNKgulw>
    <xmx:a-zoaBzdplA04c18Lxr1QIrFa3-Co6olStOmapdrzURiM3EPKGNpng>
    <xmx:a-zoaK7_FzsMQO-n7RwhHbzgAQIH45BfLDSLWqq9kXUB5_JyXppJSw>
    <xmx:a-zoaIof3yxu0C-yFbVcnByGOKdIihkrq-B1LaxqXebD_gBiPUUFEfeC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36a142bb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:17 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] refs: move to using the '.optimize' functions
Message-ID: <aOjsYoeMkF6-w7G7@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-1-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-1-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:05PM +0200, Karthik Nayak wrote:
> The `struct ref_store` variable, exposes two ways to optimize a reftable
> backend:
> 
>   1. pack_refs
>   2. optimize
> 
> The former was specific to the 'files' + 'packed' refs backend. The
> latter is more generic and covers all backends. While the naming is
> different, both these tend to perform the same functionality.

"tend to perform" is a bit of a curious thing to say, as it raises the
question when it doesn't.

> In the following commit, we will consolidate this code to only maintain
> the 'optimize' functions. In preparation, modify the backends to also do
> the same, by moving to supporting the 'optimize' function.

Maybe: "In preparation, modify the backends so that they exclusively
implement the `optimize` callback, only."

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a4cda57981..0b81bd7f74 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1445,8 +1445,8 @@ static int should_pack_refs(struct files_ref_store *refs,
>  	return 0;
>  }
>  
> -static int files_pack_refs(struct ref_store *ref_store,
> -			   struct pack_refs_opts *opts)
> +static int files_optimize(struct ref_store *ref_store,
> +			  struct pack_refs_opts *opts)

`struct pack_refs_opts` really should be renamed to
`refs_optimize_opts`. Let's read on, maybe you do this in subsequent
patches.

Patrick
