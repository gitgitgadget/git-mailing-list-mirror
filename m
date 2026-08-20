Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F18385D70
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205084; cv=none; b=L6z5TKgi7toAioePMznkn4MMwnz20BaUEh4n8snVw+u0cVUlImt3MZRLk0RKxHEjeqcnfV5YUt6BLVAHcxbrEX5ijqaCeu6092d8EeNMn0MB2Dq7+10NFX4Uy8ZlVoC8UdqNJz5kBDoCKxBI11rBGqosWwV8WkvA6SxgYNlALyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205084; c=relaxed/simple;
	bh=q5k0ywFYtnpTKbzpSJxiuSfOKmWWEB2rtpxM52a1qyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhDTOQYTqJCkehS/kaB43yd2vweFmpadXFUvJFcDQb0YZVvyKJkMRnOILZqFUxsb6dKwVyDAYetQ9/e7a2re/VwdAmsURbmPitXJB+61qdN8MMO8BrajiXCUXQcE6zeQJ4CFNf/qhAuD0lJZn6HnC3XXUChXB2P3G6aKVu0OFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LaHT6TPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjgSRyUw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LaHT6TPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjgSRyUw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 75D8FEC00AD;
	Thu, 20 Aug 2026 01:51:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 20 Aug 2026 01:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787205082; x=1787291482; bh=JZMcsUQWgM
	EQOPpeLw0Qrx6I6ux0GUFN/4348Ip5oDs=; b=LaHT6TPgxxTtvs/qnZkiOzroeI
	0WVykCoBb/hBVGfJJ7YArVET8ZnQo/XIwrXZITjL5nYReUdhQCNdh3iqzuZwH/YF
	L0lNgr0hFan4+j1aqykmMX5BPqsSBeXtDf+I5Osiu49iJ5Qelto9gkE7WusEtJOz
	9ikZaXRjzySUa2EKT3H6x4QD+VFbsVLCM8kzVZLUR7K3z68jwvJh8fCpiSqY9LuG
	W5yEqVQ52vTKfNzHBPhp2EP/6eJA9I9u0IeAuGMfILLleQS+Z4/1KmZEH5jbPsgF
	KO3xv06EKzGtOQ95W9gWxGNqp3bhRNYg9ys9uU3qFkcKW/O3xslk73k4lP7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787205082; x=1787291482; bh=JZMcsUQWgMEQOPpeLw0Qrx6I6ux0GUFN/43
	48Ip5oDs=; b=XjgSRyUwXoTjT3WCHAEKqbfGxhDgpM9pqT39bvClY//ijkeTVoi
	i9gv9ilk/KbRO2zo+On+jG32dEVeJOOHi74FKmDKcKPLQ1zVzDClfOMjh7qV7iZS
	ce0tc6BMIqqKg2XD6YVgBpnN/yJhnVM8QLMtaNB+kUZ4S8u7WBMUFuKcXhLSS5nS
	LtMpw3OhRJrFQKYuPllAg6lxB0YO7X41g4b71F2AZ+NoaQBS9lxS7qubz9wLETVX
	UF2XJXUxufWWJ8mrTR5+KG8XkndwfAMSM2z3HXkxJoW3xrW9Z/3e5dTXpTIeLRA6
	wyIvAGBaAoZIDgt6Jt9X9J5EwwZrH13MkOQ==
X-ME-Sender: <xms:2pWGaqCYvBPOwOnPMkm_eHxPYYkwpYTucXOkHgCpP9WNuAPDegB9vA>
    <xme:2pWGaqhbgCQWUqNreyOyC-wWqQJJv_Vb2TnDgsAEonIVcd9P8LtdqFeKs2slEN0sJ
    XmWTxx6gNdHo7NzZMu9twpBSud5m5DBqk6_JxLYoagECG1Gjr2l0kA>
X-ME-Received: <xmr:2pWGarPsKEAJBU1xEjDQFN35TLrnIZkMk_jz1obKMiPFnnCYU2eSph4r4SEQ8sM8DvK3K1kDq7OrhPjIHspC6Z7nkdh7J37IgJIkn5TxCQ>
X-ME-Proxy-Cause: dmFkZTFlUG02fpAQlyWw9wfd5/1EeIJ3FNDux9+GqmsvkQy2WJYvsumzFl1S2WTObXQ7aZ
    NUJFCCuF/b7Y8bSVrl4GdXIqbQanaIqmRZGV8aRoGQwvYIW+5VkhbMa4I6bGcEFB82TdBI
    35bEUTLTMwfhROhM4FCdbkqvTdTJHPWzpITrB0iM3H9zCLZ1Jq+LLFeJsO1Vd9iGJoDcxQ
    cvG4ECmvWabgSK9X3Wgk5HZNXiQ2KiuRTtnU1exSZw7+beCFDIQMm58kQFWSZmRMcpad3K
    ris5pWHXJz4emIT709b5NrMZVfwcFMIdWSCqPM4PmqrHh6O+JWWSRd2v37GVpQiX3KWag3
    oAKkLI/w9pcxJ4fz5rZwxBHY26GRu4JyCYSllIVXVgZo8heZ9zBxJ5Z7LTcxZRVHbGK2Oj
    2ojhrTQKLoQaClVGwkkgpkz48I80iumK8A1JDaUDuaEbIurd3QvHFv0kCaTheYCHHaj95M
    jghijCiEYgRpeld3LzoVewZ+gmigh7BaEkwbL/ghmjPxuJFXCBV+9HfPXvKBwZ4Sf2aTdl
    UQejvabxe3JHHT5ngz6WGpwkRA9WCpIfjF4LiglFIeGacaO8SrpeWFPW5qeZIQpXoYYWki
    TySHWKx2B1UjIRw/Gy+JeXbgL+4BcUKJFTz0BARDL1I40SD0uqUD8vCupN0w
X-ME-Proxy: <xmx:2pWGaj7j86w7B7hskdcjwXqyN4qdve7v78XWOYRV3KsKxDBn8fSClQ>
    <xmx:2pWGah3z7-wE42eiV02xfO7av6VxnVajt8NmEPEDOMbsl1nZ-M5sxw>
    <xmx:2pWGasZ86livi72IXKnNXO3XMBdjpYp6l5t9HhSlnLE73xYsADmR6w>
    <xmx:2pWGahC3DR7nEgquYSBpG7Dri7CX6JyDRoQ4IlJit8-RJUG2zcpKEQ>
    <xmx:2pWGapwdFEQT4_XHclo_l-VMPOcgZdKyz4aFdtACe_OLhtK4PFavlFYn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 01:51:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 372242c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 05:51:19 +0000 (UTC)
Date: Thu, 20 Aug 2026 07:51:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] reftable/stack: remove
 `REFTABLE_STACK_NEW_ADDITION_RELOAD`
Message-ID: <aoaV1GBPWwvTsYRm@pks.im>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>

On Wed, Aug 19, 2026 at 03:19:37PM +0200, Karthik Nayak wrote:
> In 80e7342ea8 (reftable/stack: allow locking of outdated stacks,
> 2024-09-24), the `REFTABLE_STACK_NEW_ADDITION_RELOAD` was introduced so
> that callers of `reftable_stack_init_addition()` can also reload the
> stack if there was a concurrent update made before the lock was
> obtained.
> 
> Then 16684b6fae (refs/reftable: always reload stacks when creating
> lock, 2025-08-12) updated all of the remaining call-sites to propagate
> this flag to ensure that we always reload the stack whenever there was a
> concurrent update.
> 
> As all calls to `reftable_stack_init_addition()` inevitably propagate
> the flag, it is safe to remove the flag and its associated code and make
> the reloading of the stack the default flow. This makes it easier to
> follow the flow and simplifies the logic.
> 
> The only exceptions are:
> 
>   1. Unit tests, where we explicitly do not propagate the flag. These
>      tests are now modified with the new status quo.
> 
>   2. `reftable_stack_clean_locked()`, which was propagating 0 to
>      `reftable_stack_new_addition()` but was then manually reloading the
>      stack after. Here the new flow will achieve the same, while also
>      allowing us to remove the manual reload.

libgit2 uses this flag though, so we'd have to adapt it, too. As far as
I can see though all of the calls to `reftable_stack_add()` it has pass
this flag.

> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index 5d22d84e80..5d224f8079 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -58,22 +58,13 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
>  /* holds a transaction to add tables at the top of a stack. */
>  struct reftable_addition;
>  
> -enum {
> -	/*
> -	 * Reload the stack when the stack is out-of-date after locking it.
> -	 */
> -	REFTABLE_STACK_NEW_ADDITION_RELOAD = (1 << 0),
> -};
> -
>  /*
>   * returns a new transaction to add reftables to the given stack. As a side
> - * effect, the ref database is locked. Accepts REFTABLE_STACK_NEW_ADDITION_*
> - * flags.
> + * effect, the ref database is locked.
>   */
>  int reftable_stack_new_addition(struct reftable_addition **dest,
>  				struct reftable_stack *st,
> -				const struct reftable_write_options *opts,
> -				unsigned int flags);
> +				const struct reftable_write_options *opts);
>  
>  /* Adds a reftable to transaction. */
>  int reftable_addition_add(struct reftable_addition *add,

We're already busy adapting this function anyway, so do we maybe want to
fix its name to `reftable_stack_addition_new` while at it?

Patrick
