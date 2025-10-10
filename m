Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF874284B4C
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095352; cv=none; b=jpbHZ7wFRjLt34Pw4ZnvgZChrIJx/9sVwEVr71c69kuqCwf1JqkQFHOhSzybOuAKmT8ycISHudQPuo+0c7/l8KB3gMUxEUS/ynMiLl9KFFPgq2wxdLbyl8tVA78WkoiQdjl+mf7om3YdceSIkhWPrG82d6S+QooBJ46kIeMs1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095352; c=relaxed/simple;
	bh=1bvQvDcMNXeiwKqh+IvzzpbsfBLQSekvC7nrUfgjKvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5bxQgeSPMuA1ODA/y8v0ehSWkchY8Ahwf1fWG78LOMAmQAZjy/eLfPbPTnlQPiezJNgv0GX4xKBM3kMFERb8qWrDlhmkdKTTag90qrWy889ZEGI0Fw1zq4Tgwt2sxxEr2t5K/pCcV85AkUlJh5k8utYS/gNgbrZysm+pqREw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VtJY6yeh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=otv6CrpU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VtJY6yeh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="otv6CrpU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9824140009E;
	Fri, 10 Oct 2025 07:22:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Oct 2025 07:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095349; x=1760181749; bh=1nVf2Jpw23
	ENMl7uqSxXJnAlQeSfC2hU/+e1MkK1fz0=; b=VtJY6yehrR5gJRYKzLM6rNAQqC
	ZdYtdgUlFXHZgUY0c1fbhnmIlPrp4gWb21cuQRxL7jedBoI6tdO3+5GZe8mdjlwQ
	t7YI1dK61UkcU491uX1shXZJp696dVE0quOfntDbKPI7QhsRRmB8bfpC/OOCxNec
	J2j7zQDJaMCplL1A+u7RReWZtpfAzHk+RUYKT1qpMkzX+VK6mKdCc+nU5GBvEEw7
	fAhOnBArh6KJ0zKRARlJK2WAcE82ps40ohsHxkZ8HnsZTyAezqE6aN1BdAjmB+vV
	FgHRoz4O0w8+pgywKZrDCKP9j2uncs5uSmCNQXte6cO9anyMq/HArpGi/Xkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095349; x=1760181749; bh=1nVf2Jpw23ENMl7uqSxXJnAlQeSfC2hU/+e
	1MkK1fz0=; b=otv6CrpUSFmGeOBJ/ptqh08s4j5jrxPy8pgCn2wyEPL0D11jyQ+
	6n6qOhigMQq2/mNd9/oiWuzqL4708HZ/bAs2UUI/DRSO52EOUHPtlFfAOS0kjQ90
	wgNoiSP5q73ENKcCmQddDM+XqD7dvRZgZThvbD1uVuuMyfE5lHt2hHtMgG7VCBIZ
	leK6yId2+5lWIwuD2FtLRvynBRzPluwrovYfGg0UnNlLNL8DpGDQOdq1tuKzPHiy
	ex7H4jcq2QDFq4exOGT+krN2k95n73+lOR32vhtcu2jAK/DtnmwThoQGbhtrq4eW
	Z5vKHf/+QN+nqNeiwXdi8tuN+BoRusj2h/g==
X-ME-Sender: <xms:dezoaOUEbXc1PAeKpls2lxFW9xYhSl74v5EduS0nQ_PddswIjIIYnQ>
    <xme:dezoaAlzgL1QHc__HMmZBt5LDrlKpuIY6GA2Ox8pmrlDqnPmjKlJzc8arzQVEuoCy
    efiki7uo9_hTIDidBAMeYGOSqgsy0zMkdS3qk4v9GRMzFZhw_-c9AI>
X-ME-Received: <xmr:dezoaAAHoCW46KWZIwUoX-8cNHEXAx0PTl0Xo2yfaJI1zwT5CKtQC-TOLA6su6xFGZk8emaBmht0V6lXMo2fUS6mYbMY0BxaKP6uFIsAHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dezoaAdER2c3b8AmlVvOhAXk4PPh1e9789SuANhFN7izwYd_fOBAWg>
    <xmx:dezoaLK-sLI4HkERilXTtRWBxuJWh5LQZg3XubPENJ05dDhVmkF-NQ>
    <xmx:dezoaDcJRaaZlboNbZTeKyxBALmE6I2TqLszuMQXlsMpimwj-l5wXw>
    <xmx:dezoaC0J9d2FI5CYID4B6pm2F2nypuLGlwkH7QpT31U1JKjmFwGZaQ>
    <xmx:dezoaDEGq8wlMpnSSMLe3AnFC6-CgczRR9ib_VwvFUMTdVF4qfI6gCF6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e18d2a6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:28 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/9] refs: rename 'pack_refs_opts' to 'optimize_refs_opts'
Message-ID: <aOjscGfX4ns-5qCm@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-3-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-3-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:07PM +0200, Karthik Nayak wrote:
> The previous commit removed all references to 'pack_refs()' within
> the refs subsystem. Continue this cleanup by also renaming
> 'pack_refs_opts' to 'optimize_refs_opts' and the respective flags
> accordingly. Keeping the naming consistent will make the code easier to
> maintain.

Good, this is what I was hoping to see :)

> diff --git a/refs.c b/refs.c
> index 77dc1ab501..514fb85af2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2312,7 +2312,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>  	refs->gitdir = xstrdup(path);
>  }
>  
> -int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
> +int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts)

An options struct for a function `do_something()` should typically be
called `struct do_something_opts`. So we should rename the struct to
`refs_optimize_opts`.

> diff --git a/refs.h b/refs.h
> index c6c955d78d..58b222ac02 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -500,15 +500,15 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
>  
>  /*
>   * Flags for controlling behaviour of refs_optimize()
> - * PACK_REFS_PRUNE: Prune loose refs after packing
> - * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
> - *                 result are decided by the ref backend. Backends may ignore
> - *                 this flag and fall back to a normal repack.
> + * OPTIMIZE_REFS_PRUNE: Prune loose refs after packing
> + * OPTIMIZE_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
> + *                     result are decided by the ref backend. Backends may ignore
> + *                     this flag and fall back to a normal repack.
>   */
> -#define PACK_REFS_PRUNE (1 << 0)
> -#define PACK_REFS_AUTO  (1 << 1)
> +#define OPTIMIZE_REFS_PRUNE (1 << 0)
> +#define OPTIMIZE_REFS_AUTO  (1 << 1)

And these would then be called `REFS_OPTIMIZE_PRUNE` etc.

Patrick
